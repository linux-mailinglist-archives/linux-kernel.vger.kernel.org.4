Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD864289E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiLEMjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiLEMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:39:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8D91839A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:39:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so5183335wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7mJOwBTOPcCP4+k6byGyz37a9Lv7sYFUXRpG0d4gx0=;
        b=hQdiZxxfwRBbdBqkzjdQSZmqUyROTpqLpwLKFyR1LLSl6nDt2RZwa8fAZN2qgCmabp
         4kFCaE3n7ieRyN19ITerJvMLwFiUVYWEtgsv1FLBJMrJA5MSiuJVgxMCoKLLVDCuLheO
         CNO9rJTec2x++RLNGx+9oVkIJKlXqa8SAuiK3ab07wOxt+YF1ua7avLswW13Pqirhqg4
         Y05tnKaG6ZX9c9sm4US+iEeGWVlui3PtEqOiol9nbIZsZb58xGbQv/u37hGLBHI2ln8b
         rRRS2wQcq0IY0FbCWl9NrKYyZXzmTih8FRE8m20T88y98WA2Mlg2cUoO3z0g7kMQ7Cop
         SbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7mJOwBTOPcCP4+k6byGyz37a9Lv7sYFUXRpG0d4gx0=;
        b=v3X1CeebpmY+KjC5uOJfg+6t5QFiUG77lEPBreHYZmnILun9okbHrjexeC3Xfe3cgQ
         FgOD8JNXCXCSYSNaOBW4FzIXT5c5ekvRk6vXUyKO+HAptm3wi0MHFoJo2xisFjANvAlj
         h2/5pZt6jYTSxHTtuiKt0OFOo7dZ10RCyi4L3zNww5/UJEvRjDOAcem8mE+Sec2OpIAm
         FcK7MSn7uyfk7Z5IiC6gdNP19Zf8qxNhqmrf31kqvRVeRDZsO0FBLh8emvPn5h8CkrWC
         uMKFFXvpX1CKm9yxna0mwiWpKOZRnrtC5IdNwL6ccltLuTnjdBShSQGTk2rdfRxT9OeI
         HXCw==
X-Gm-Message-State: ANoB5pmN42LLwDI2oOe5/25duH7ZR6FqOUJmX2m6+fbQ7AyxPP7Yo6jV
        DFTeYQrrk5n4U8vCgRt9QfO+qA==
X-Google-Smtp-Source: AA0mqf6H9GiNXJl2HPj+UbZ4NjBUnNaJXfBZecpLhqbjyQJlPpOybTVBiRya3KsXVm3MWxVnxqXnyQ==
X-Received: by 2002:a05:600c:2f88:b0:3d1:bbc4:7957 with SMTP id t8-20020a05600c2f8800b003d1bbc47957mr4337740wmn.59.1670243947213;
        Mon, 05 Dec 2022 04:39:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1845:911d:bbf3:b5df])
        by smtp.gmail.com with ESMTPSA id w6-20020adfec46000000b0022efc4322a9sm14452947wrn.10.2022.12.05.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 04:39:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Hainke <vincent@systemli.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v8 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Date:   Mon,  5 Dec 2022 13:39:02 +0100
Message-Id: <20221205123903.159838-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221205123903.159838-1-brgl@bgdev.pl>
References: <20221205123903.159838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are several places where we can crash the kernel by requesting
lines, unbinding the GPIO device, then calling any of the system calls
relevant to the GPIO character device's annonymous file descriptors:
ioctl(), read(), poll().

While I observed it with the GPIO simulator, it will also happen for any
of the GPIO devices that can be hot-unplugged - for instance any HID GPIO
expander (e.g. CP2112).

This affects both v1 and v2 uAPI.

This fixes it partially by checking if gdev->chip is not NULL but it
doesn't entirely remedy the situation as we still have a race condition
in which another thread can remove the device after the check.

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0cb6b468f364..6fa5c2169985 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -201,6 +201,9 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 	unsigned int i;
 	int ret;
 
+	if (!lh->gdev->chip)
+		return -ENODEV;
+
 	switch (cmd) {
 	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
 		/* NOTE: It's okay to read values of output lines */
@@ -1384,6 +1387,9 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
 
+	if (!lr->gdev->chip)
+		return -ENODEV;
+
 	switch (cmd) {
 	case GPIO_V2_LINE_GET_VALUES_IOCTL:
 		return linereq_get_values(lr, ip);
@@ -1410,6 +1416,9 @@ static __poll_t linereq_poll(struct file *file,
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
 
+	if (!lr->gdev->chip)
+		return EPOLLHUP | EPOLLERR;
+
 	poll_wait(file, &lr->wait, wait);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&lr->events,
@@ -1429,6 +1438,9 @@ static ssize_t linereq_read(struct file *file,
 	ssize_t bytes_read = 0;
 	int ret;
 
+	if (!lr->gdev->chip)
+		return -ENODEV;
+
 	if (count < sizeof(le))
 		return -EINVAL;
 
@@ -1716,6 +1728,9 @@ static __poll_t lineevent_poll(struct file *file,
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
 
+	if (!le->gdev->chip)
+		return EPOLLHUP | EPOLLERR;
+
 	poll_wait(file, &le->wait, wait);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
@@ -1740,6 +1755,9 @@ static ssize_t lineevent_read(struct file *file,
 	ssize_t ge_size;
 	int ret;
 
+	if (!le->gdev->chip)
+		return -ENODEV;
+
 	/*
 	 * When compatible system call is being used the struct gpioevent_data,
 	 * in case of at least ia32, has different size due to the alignment
@@ -1821,6 +1839,9 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 
+	if (!le->gdev->chip)
+		return -ENODEV;
+
 	/*
 	 * We can get the value for an event line but not set it,
 	 * because it is input by definition.
@@ -2407,6 +2428,9 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
 
+	if (!cdev->gdev->chip)
+		return EPOLLHUP | EPOLLERR;
+
 	poll_wait(file, &cdev->wait, pollt);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&cdev->events,
@@ -2425,6 +2449,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
+	if (!cdev->gdev->chip)
+		return -ENODEV;
+
 #ifndef CONFIG_GPIO_CDEV_V1
 	event_size = sizeof(struct gpio_v2_line_info_changed);
 	if (count < event_size)
-- 
2.37.2

