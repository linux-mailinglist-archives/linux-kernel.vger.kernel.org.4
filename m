Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4463D162
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiK3JGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiK3JGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:06:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4648436
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:06:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so897760wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysZtnS5xnth5w0LemSDO+wCvjLXEmog+vjYaOIZiWJQ=;
        b=kok9z+BwG6oqUKdWE2UkF36lieA5csfb1Agg11U6bznRNMDgpRnqDzb1jeSIU8gs8O
         WTIePJiOdCVxdjmuVGBX642nh8SR2pNcjQTeYiPm7NtJQ/jENCTwxqdse3Sk/fkK+Cwt
         wFfAFqdl1mz7leMXkwFWfmc84oWFdui/X14xPiSk7LITXUqWEUn1WcgvdlhYEII0am4P
         rYo0Y5f4DA2IQ+gGUNYPw/2WA6SANhApcEO7BbuVCsIoxgKajJDvi3nz4awkQhRQsy3V
         cvQX3DAwoI8JKYXqV965hE2k/cvS3I4XIpZSmsoBbBPYX89i8xOpYvYMTdzJ4B0C5L5l
         6lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysZtnS5xnth5w0LemSDO+wCvjLXEmog+vjYaOIZiWJQ=;
        b=FEpBNWgtYLRR/rIIeoAr0FyJKJuzGjbLri/qgUbk3OzOtebzXbgHNGq/jLLf05qX6W
         woesuZ0dD8nUkaw93tsgm+Afg3IKgOqs4UEt9jVqOxbHaTtyKNFR6gEyd8C2jpCmDGOd
         D7EYkkNlrPm5Ss7/ka/Lj/UHgDRF0P19lLSuoeFuEWj7P19LrqDAYizR1z987JhIJBCf
         LM41USqxQ4tphodpknrgAwWDCap3EXGP1KAgvWIxort7GaMW9IKNmmvOTMpZgvc0U0ws
         vSKiuzvwkQ/eEFiiEkwzs4w91BikCyWpJtI1YhR5Ez+AglNQlpb2zvNHC3d/2447uTNr
         UldQ==
X-Gm-Message-State: ANoB5pkw4/nisyLGS2p/0LstTaaB2zkMwvooDRwvEdUNkQdEXwjim15/
        ovEZ0jq+6vU78W4siPkU+oVhEuAi/9yJVQ==
X-Google-Smtp-Source: AA0mqf6tkyxIkozkwEdmwSnCSC74NhatapTw1vx61KGezBXp+IViS/TYR5zdCunAm78IhgGPi7sZFg==
X-Received: by 2002:a7b:cbc6:0:b0:3c6:b650:34dd with SMTP id n6-20020a7bcbc6000000b003c6b65034ddmr37797612wmi.45.1669799159746;
        Wed, 30 Nov 2022 01:05:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:458c:6db9:e033:a468])
        by smtp.gmail.com with ESMTPSA id v24-20020a05600c4d9800b003cfbe1da539sm1168841wmp.36.2022.11.30.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:05:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Date:   Wed, 30 Nov 2022 10:05:55 +0100
Message-Id: <20221130090556.40280-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130090556.40280-1-brgl@bgdev.pl>
References: <20221130090556.40280-1-brgl@bgdev.pl>
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
---
 drivers/gpio/gpiolib-cdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0cb6b468f364..911d91668903 100644
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
+		return 0;
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
+		return 0;
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
+		return 0;
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

