# Use official Python 3.13 base
FROM python:3.13.0a5-slim

# Set working directory
WORKDIR /app

# Copy Python requirements and install
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy app.py
COPY app.py .

# Create required directory
RUN mkdir -p screenshots_cache

# Install Playwright and its dependencies
RUN playwright install --with-deps


# Install system dependencies required for Playwright
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnspr4 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libatspi2.0-0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Default command (you can change this)
CMD ["python", "app.py"]
