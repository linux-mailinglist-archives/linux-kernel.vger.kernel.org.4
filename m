Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBB63B0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiK1SIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiK1SIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:08:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879A5A6CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:52:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bx10so6074280wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO3T6izkndoqrxAmqJG8a+elakt0mpY9L9RmSWzRKEc=;
        b=nLRny+q6msUT6Xk7M86SLzljlKR5Htu49iaCs2jbcn3gbuywkV64xFoa279GaqSvuI
         vgMGCZKUmlEOuz4McLCNkDBN0xX7G8WAdw61g+hwvaq81rPknvBvnMbAJ0E/zu7jV6eW
         724M/t2SG2eXzWisH9DcwuN6p2vOffasE1r4o8yxCI1jnpMH2KEf1pKLCr4oYr6sa0jn
         7/qut4k7jtcVr2sFV57iuVZmBQn/mvVArjFVD7qza6/REr5o3IU0HzUy/tMCV2qPoAAK
         iPXhqaAaS2RzG026pKj4IYbiEJooeEPp9ogr6wgfPBWvgOufjvbAP+mEspnTRX3y9bJj
         xyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO3T6izkndoqrxAmqJG8a+elakt0mpY9L9RmSWzRKEc=;
        b=A7KxZ/qFdQC2Di+HzrKIbGRRyeypuy9jVps09NYVUyIfzXe3AoNyFUOTih4IBnUAko
         09Vjl8K0vxdntWjxIQqmC5bMBMxw+bCyc0FnERPx6VaRxPG3EKsoWRK0H33PwLiRB2kU
         sFz8Z5lKN65fh6xqBepYjwg8PMimvxxyZ0yXmJc1AJ5wP+m1JSJe9F5YVAQZxhS72Ci2
         Z/Q8OZneqY4KoKGSCstPUu8Zngq/jDXLH+BUPK+1L4NXEVX2ZTP045Ifrqeq0Z35sZ+o
         UaRDJ9TwEtWqHpKiVlSOChyj+eR02Um+oB7n7DZI7XyyKhuAm2MbHK6J1RmKPGnItDNK
         piaA==
X-Gm-Message-State: ANoB5pmQ81uQJ6ZVos/hF0XoBRwrrZ8i8WGh1HpkyIlI0Y2f6YlpVRT/
        icEim5eB95eqsPwlqdQNjqiKdqG/mGiQNQ==
X-Google-Smtp-Source: AA0mqf5mvZMQ4bBawYbMIzPuf0SWQSAkWv3MOYklqJZBAg1Hyo6mXnUnuvL6G07JP7nhc314mWg6Dw==
X-Received: by 2002:adf:f7c8:0:b0:236:720a:e391 with SMTP id a8-20020adff7c8000000b00236720ae391mr25189432wrq.368.1669657941717;
        Mon, 28 Nov 2022 09:52:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:791b:cf20:d3ea:d01])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d4b47000000b00242109cf587sm5828856wrs.28.2022.11.28.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:52:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/2] gpiolib: protect the GPIO device against being dropped while in use by user-space
Date:   Mon, 28 Nov 2022 18:52:14 +0100
Message-Id: <20221128175214.602612-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221128175214.602612-1-brgl@bgdev.pl>
References: <20221128175214.602612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

While any of the GPIO cdev syscalls is in progress, the kernel can call
gpiochip_remove() (for instance, when a USB GPIO expander is disconnected)
which will set gdev->chip to NULL after which any subsequent access will
cause a crash.

To avoid that: use an RW-semaphore in which the syscalls take it for
reading (so that we don't needlessly prohibit the user-space from calling
syscalls simultaneously) while gpiochip_remove() takes it for writing so
that it can only happen once all syscalls return.

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 222 +++++++++++++++++++++++++++---------
 drivers/gpio/gpiolib.c      |   3 +
 drivers/gpio/gpiolib.h      |   5 +
 3 files changed, 178 insertions(+), 52 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 7a9504fb27f1..581bc0e945a4 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -200,10 +200,14 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 	struct gpiohandle_data ghd;
 	DECLARE_BITMAP(vals, GPIOHANDLES_MAX);
 	unsigned int i;
-	int ret;
+	int ret = 0;
+
+	down_read(&gdev->sem);
 
-	if (!gdev->chip)
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 	switch (cmd) {
 	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
@@ -212,43 +216,52 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 						    lh->num_descs, lh->descs,
 						    NULL, vals);
 		if (ret)
-			return ret;
+			break;
 
 		memset(&ghd, 0, sizeof(ghd));
 		for (i = 0; i < lh->num_descs; i++)
 			ghd.values[i] = test_bit(i, vals);
 
 		if (copy_to_user(ip, &ghd, sizeof(ghd)))
-			return -EFAULT;
+			ret = -EFAULT;
 
-		return 0;
+		break;
 	case GPIOHANDLE_SET_LINE_VALUES_IOCTL:
 		/*
 		 * All line descriptors were created at once with the same
 		 * flags so just check if the first one is really output.
 		 */
-		if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags))
-			return -EPERM;
+		if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags)) {
+			ret = -EPERM;
+			break;
+		}
 
-		if (copy_from_user(&ghd, ip, sizeof(ghd)))
-			return -EFAULT;
+		if (copy_from_user(&ghd, ip, sizeof(ghd))) {
+			ret = -EFAULT;
+			break;
+		}
 
 		/* Clamp all values to [0,1] */
 		for (i = 0; i < lh->num_descs; i++)
 			__assign_bit(i, vals, ghd.values[i]);
 
 		/* Reuse the array setting function */
-		return gpiod_set_array_value_complex(false,
-						     true,
-						     lh->num_descs,
-						     lh->descs,
-						     NULL,
-						     vals);
+		ret = gpiod_set_array_value_complex(false,
+						    true,
+						    lh->num_descs,
+						    lh->descs,
+						    NULL,
+						    vals);
+		break;
 	case GPIOHANDLE_SET_CONFIG_IOCTL:
-		return linehandle_set_config(lh, ip);
+		ret = linehandle_set_config(lh, ip);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	up_read(&gdev->sem);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
@@ -1388,20 +1401,31 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 	struct linereq *lr = file->private_data;
 	struct gpio_device *gdev = lr->gdev;
 	void __user *ip = (void __user *)arg;
+	long ret;
+
+	down_read(&gdev->sem);
 
-	if (!gdev->chip)
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 	switch (cmd) {
 	case GPIO_V2_LINE_GET_VALUES_IOCTL:
-		return linereq_get_values(lr, ip);
+		ret = linereq_get_values(lr, ip);
+		break;
 	case GPIO_V2_LINE_SET_VALUES_IOCTL:
-		return linereq_set_values(lr, ip);
+		ret = linereq_set_values(lr, ip);
+		break;
 	case GPIO_V2_LINE_SET_CONFIG_IOCTL:
-		return linereq_set_config(lr, ip);
+		ret = linereq_set_config(lr, ip);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	up_read(&gdev->sem);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
@@ -1419,8 +1443,12 @@ static __poll_t linereq_poll(struct file *file,
 	struct gpio_device *gdev = lr->gdev;
 	__poll_t events = 0;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return 0;
+	}
 
 	poll_wait(file, &lr->wait, wait);
 
@@ -1428,6 +1456,7 @@ static __poll_t linereq_poll(struct file *file,
 						 &lr->wait.lock))
 		events = EPOLLIN | EPOLLRDNORM;
 
+	up_read(&gdev->sem);
 	return events;
 }
 
@@ -1442,22 +1471,30 @@ static ssize_t linereq_read(struct file *file,
 	ssize_t bytes_read = 0;
 	int ret;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
-	if (count < sizeof(le))
+	if (count < sizeof(le)) {
+		up_read(&gdev->sem);
 		return -EINVAL;
+	}
 
 	do {
 		spin_lock(&lr->wait.lock);
 		if (kfifo_is_empty(&lr->events)) {
 			if (bytes_read) {
 				spin_unlock(&lr->wait.lock);
+				up_read(&gdev->sem);
 				return bytes_read;
 			}
 
 			if (file->f_flags & O_NONBLOCK) {
 				spin_unlock(&lr->wait.lock);
+				up_read(&gdev->sem);
 				return -EAGAIN;
 			}
 
@@ -1465,6 +1502,7 @@ static ssize_t linereq_read(struct file *file,
 					!kfifo_is_empty(&lr->events));
 			if (ret) {
 				spin_unlock(&lr->wait.lock);
+				up_read(&gdev->sem);
 				return ret;
 			}
 		}
@@ -1481,11 +1519,14 @@ static ssize_t linereq_read(struct file *file,
 			break;
 		}
 
-		if (copy_to_user(buf + bytes_read, &le, sizeof(le)))
+		if (copy_to_user(buf + bytes_read, &le, sizeof(le))) {
+			up_read(&gdev->sem);
 			return -EFAULT;
+		}
 		bytes_read += sizeof(le);
 	} while (count >= bytes_read + sizeof(le));
 
+	up_read(&gdev->sem);
 	return bytes_read;
 }
 
@@ -1733,14 +1774,19 @@ static __poll_t lineevent_poll(struct file *file,
 	struct gpio_device *gdev = le->gdev;
 	__poll_t events = 0;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return 0;
+	}
 
 	poll_wait(file, &le->wait, wait);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
 		events = EPOLLIN | EPOLLRDNORM;
 
+	up_read(&gdev->sem);
 	return events;
 }
 
@@ -1761,8 +1807,12 @@ static ssize_t lineevent_read(struct file *file,
 	ssize_t ge_size;
 	int ret;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 	/*
 	 * When compatible system call is being used the struct gpioevent_data,
@@ -1777,19 +1827,23 @@ static ssize_t lineevent_read(struct file *file,
 		ge_size = sizeof(struct compat_gpioeevent_data);
 	else
 		ge_size = sizeof(struct gpioevent_data);
-	if (count < ge_size)
+	if (count < ge_size) {
+		up_read(&gdev->sem);
 		return -EINVAL;
+	}
 
 	do {
 		spin_lock(&le->wait.lock);
 		if (kfifo_is_empty(&le->events)) {
 			if (bytes_read) {
 				spin_unlock(&le->wait.lock);
+				up_read(&gdev->sem);
 				return bytes_read;
 			}
 
 			if (file->f_flags & O_NONBLOCK) {
 				spin_unlock(&le->wait.lock);
+				up_read(&gdev->sem);
 				return -EAGAIN;
 			}
 
@@ -1797,6 +1851,7 @@ static ssize_t lineevent_read(struct file *file,
 					!kfifo_is_empty(&le->events));
 			if (ret) {
 				spin_unlock(&le->wait.lock);
+				up_read(&gdev->sem);
 				return ret;
 			}
 		}
@@ -1813,11 +1868,14 @@ static ssize_t lineevent_read(struct file *file,
 			break;
 		}
 
-		if (copy_to_user(buf + bytes_read, &ge, ge_size))
+		if (copy_to_user(buf + bytes_read, &ge, ge_size)) {
+			up_read(&gdev->sem);
 			return -EFAULT;
+		}
 		bytes_read += ge_size;
 	} while (count >= bytes_read + ge_size);
 
+	up_read(&gdev->sem);
 	return bytes_read;
 }
 
@@ -1846,8 +1904,12 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 	/*
 	 * We can get the value for an event line but not set it,
@@ -1859,15 +1921,23 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 		memset(&ghd, 0, sizeof(ghd));
 
 		val = gpiod_get_value_cansleep(le->desc);
-		if (val < 0)
+		if (val < 0) {
+			up_read(&gdev->sem);
 			return val;
+		}
+
 		ghd.values[0] = val;
 
-		if (copy_to_user(ip, &ghd, sizeof(ghd)))
+		if (copy_to_user(ip, &ghd, sizeof(ghd))) {
+			up_read(&gdev->sem);
 			return -EFAULT;
+		}
 
+		up_read(&gdev->sem);
 		return 0;
 	}
+
+	up_read(&gdev->sem);
 	return -EINVAL;
 }
 
@@ -2358,36 +2428,53 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
 	void __user *ip = (void __user *)arg;
+	long ret;
+
+	down_read(&gdev->sem);
 
 	/* We fail any subsequent ioctl():s when the chip is gone */
-	if (!gdev->chip)
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 	/* Fill in the struct and pass to userspace */
 	switch (cmd) {
 	case GPIO_GET_CHIPINFO_IOCTL:
-		return chipinfo_get(cdev, ip);
+		ret = chipinfo_get(cdev, ip);
+		break;
 #ifdef CONFIG_GPIO_CDEV_V1
 	case GPIO_GET_LINEHANDLE_IOCTL:
-		return linehandle_create(gdev, ip);
+		ret = linehandle_create(gdev, ip);
+		break;
 	case GPIO_GET_LINEEVENT_IOCTL:
-		return lineevent_create(gdev, ip);
+		ret = lineevent_create(gdev, ip);
+		break;
 	case GPIO_GET_LINEINFO_IOCTL:
-		return lineinfo_get_v1(cdev, ip, false);
+		ret = lineinfo_get_v1(cdev, ip, false);
+		break;
 	case GPIO_GET_LINEINFO_WATCH_IOCTL:
-		return lineinfo_get_v1(cdev, ip, true);
+		ret = lineinfo_get_v1(cdev, ip, true);
+		break;
 #endif /* CONFIG_GPIO_CDEV_V1 */
 	case GPIO_V2_GET_LINEINFO_IOCTL:
-		return lineinfo_get(cdev, ip, false);
+		ret = lineinfo_get(cdev, ip, false);
+		break;
 	case GPIO_V2_GET_LINEINFO_WATCH_IOCTL:
-		return lineinfo_get(cdev, ip, true);
+		ret = lineinfo_get(cdev, ip, true);
+		break;
 	case GPIO_V2_GET_LINE_IOCTL:
-		return linereq_create(gdev, ip);
+		ret = linereq_create(gdev, ip);
+		break;
 	case GPIO_GET_LINEINFO_UNWATCH_IOCTL:
-		return lineinfo_unwatch(cdev, ip);
+		ret = lineinfo_unwatch(cdev, ip);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	up_read(&gdev->sem);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
@@ -2436,8 +2523,12 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 	struct gpio_device *gdev = cdev->gdev;
 	__poll_t events = 0;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return 0;
+	}
 
 	poll_wait(file, &cdev->wait, pollt);
 
@@ -2445,6 +2536,7 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 						 &cdev->wait.lock))
 		events = EPOLLIN | EPOLLRDNORM;
 
+	up_read(&gdev->sem);
 	return events;
 }
 
@@ -2458,13 +2550,19 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
-	if (!gdev->chip)
+	down_read(&gdev->sem);
+
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 #ifndef CONFIG_GPIO_CDEV_V1
 	event_size = sizeof(struct gpio_v2_line_info_changed);
-	if (count < event_size)
+	if (count < event_size) {
+		up_read(&gdev->sem);
 		return -EINVAL;
+	}
 #endif
 
 	do {
@@ -2472,11 +2570,13 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 		if (kfifo_is_empty(&cdev->events)) {
 			if (bytes_read) {
 				spin_unlock(&cdev->wait.lock);
+				up_read(&gdev->sem);
 				return bytes_read;
 			}
 
 			if (file->f_flags & O_NONBLOCK) {
 				spin_unlock(&cdev->wait.lock);
+				up_read(&gdev->sem);
 				return -EAGAIN;
 			}
 
@@ -2484,6 +2584,7 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 					!kfifo_is_empty(&cdev->events));
 			if (ret) {
 				spin_unlock(&cdev->wait.lock);
+				up_read(&gdev->sem);
 				return ret;
 			}
 		}
@@ -2495,6 +2596,7 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 			event_size = sizeof(struct gpioline_info_changed);
 		if (count < event_size) {
 			spin_unlock(&cdev->wait.lock);
+			up_read(&gdev->sem);
 			return -EINVAL;
 		}
 #endif
@@ -2508,23 +2610,31 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 
 #ifdef CONFIG_GPIO_CDEV_V1
 		if (event_size == sizeof(struct gpio_v2_line_info_changed)) {
-			if (copy_to_user(buf + bytes_read, &event, event_size))
+			if (copy_to_user(buf + bytes_read,
+					 &event, event_size)) {
+				up_read(&gdev->sem);
 				return -EFAULT;
+			}
 		} else {
 			struct gpioline_info_changed event_v1;
 
 			gpio_v2_line_info_changed_to_v1(&event, &event_v1);
 			if (copy_to_user(buf + bytes_read, &event_v1,
-					 event_size))
+					 event_size)) {
+				up_read(&gdev->sem);
 				return -EFAULT;
+			}
 		}
 #else
-		if (copy_to_user(buf + bytes_read, &event, event_size))
+		if (copy_to_user(buf + bytes_read, &event, event_size)) {
+			up_read(&gdev->sem);
 			return -EFAULT;
+		
 #endif
 		bytes_read += event_size;
 	} while (count >= bytes_read + sizeof(event));
 
+	up_read(&gdev->sem);
 	return bytes_read;
 }
 
@@ -2541,13 +2651,19 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev;
 	int ret = -ENOMEM;
 
+	down_read(&gdev->sem);
+
 	/* Fail on open if the backing gpiochip is gone */
-	if (!gdev->chip)
+	if (!gdev->chip) {
+		up_read(&gdev->sem);
 		return -ENODEV;
+	}
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
-	if (!cdev)
+	if (!cdev) {
+		up_read(&gdev->sem);
 		return -ENOMEM;
+	}
 
 	cdev->watched_lines = bitmap_zalloc(gdev->chip->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
@@ -2570,6 +2686,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_unregister_notifier;
 
+	up_read(&gdev->sem);
 	return ret;
 
 out_unregister_notifier:
@@ -2579,6 +2696,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
+	up_read(&gdev->sem);
 	return ret;
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4756ea08894f..0d71f8a5a66e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -731,6 +731,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->notifier);
+	init_rwsem(&gdev->sem);
 
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
@@ -865,6 +866,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	unsigned long	flags;
 	unsigned int	i;
 
+	down_write(&gdev->sem);
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
@@ -899,6 +901,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * gone.
 	 */
 	gcdev_unregister(gdev);
+	up_write(&gdev->sem);
 	put_device(&gdev->dev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d900ecdbac46..9ad68a0adf4a 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
+#include <linux/rwsem.h>
 
 #define GPIOCHIP_NAME	"gpiochip"
 
@@ -39,6 +40,9 @@
  * @list: links gpio_device:s together for traversal
  * @notifier: used to notify subscribers about lines being requested, released
  *            or reconfigured
+ * @sem: protects the structure from a NULL-pointer dereference of @chip by
+ *       user-space operations when the device gets unregistered during
+ *       a hot-unplug event
  * @pin_ranges: range of pins served by the GPIO driver
  *
  * This state container holds most of the runtime variable data
@@ -60,6 +64,7 @@ struct gpio_device {
 	void			*data;
 	struct list_head        list;
 	struct blocking_notifier_head notifier;
+	struct rw_semaphore	sem;
 
 #ifdef CONFIG_PINCTRL
 	/*
-- 
2.37.2

