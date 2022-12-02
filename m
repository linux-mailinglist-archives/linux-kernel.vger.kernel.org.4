Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57EA6408EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiLBPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiLBPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:04:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0663CB235
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:04:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f18so8200610wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7mJOwBTOPcCP4+k6byGyz37a9Lv7sYFUXRpG0d4gx0=;
        b=DR34k4P33bw78V6Mq0SPV2K4ny41OfOywm4+0h9MnoA0AONBo5YaR5gXJGA/x9FVyI
         d7fnMya0IsB8bOWtZmlkxiyMFgH6REhZILXGA7UBE4ejQQvb2ZLPMAme/2cLEq9ZrXJI
         XFgz7sWtAJCWfG2qARVcR07+ygTwCosJjJcwjvx6fLk85XWkhZqqCWDoHx+kI8GI+8aU
         pe1k/gGJe/BMxMxukpV72lg5VJKcZukpGoISTJGHlVFckVnXHg0AvSjsQFufrRnrDE8Z
         QCfCDv2YuW4egK292qzO/n/XZfgG4VPLGrim3neOGgkTOtbhP1XUUz2FX5m9KhT1zPe4
         NN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7mJOwBTOPcCP4+k6byGyz37a9Lv7sYFUXRpG0d4gx0=;
        b=Wqq+WvFYfUkhTpiOlsE4wf7otyfK5cZ0bSvN1hNeTeE1MNStnQc0wB3pIWJQDfidRL
         pm/gQV4fK3ptyEm1VK7oWHsKsJuniZ3GyxPKClRLQM5h1pXlHT+Fv6XczID3G8K+o7oT
         1oXHpLye6nWalPg36QN7hhAzyfQBL09xpFzv61Xt0Xc192uGH5QgfDRMvl+LcrlQuN6i
         +V41/FtIppjJlAtfjbVauQ4Fe8jLwDjVG7oLwy78kYTeY7iPdqOaXEGlQdHLK3mVDGtJ
         XC4ghqSM7FG382pZVvGC3vB9fMrPKIuh/OMK0728+OfqG/BzFoZCCggQVoHQqvS3rxCO
         JCEg==
X-Gm-Message-State: ANoB5pnfxeuSoR17E2l4r2Gn4YZcmGnrtT+u7VzOR6AT7G/kIvIoxYnj
        WG+ImkEEB4kYjW9gY6ENnANlKnxm/VOH0YuO
X-Google-Smtp-Source: AA0mqf4TdERzAwpbW/uq4xtcJVFHYsA6RkRQ5srUbIdApM52xWAfljAtrrgAXpSVhy9Nz2hZCJxQlQ==
X-Received: by 2002:a5d:6343:0:b0:242:143f:1d2e with SMTP id b3-20020a5d6343000000b00242143f1d2emr16733953wrw.391.1669993490087;
        Fri, 02 Dec 2022 07:04:50 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id v6-20020adfe286000000b00241f467f888sm7218237wri.74.2022.12.02.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:04:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Hainke <vincent@systemli.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v7 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Date:   Fri,  2 Dec 2022 16:04:43 +0100
Message-Id: <20221202150444.244313-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202150444.244313-1-brgl@bgdev.pl>
References: <20221202150444.244313-1-brgl@bgdev.pl>
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

