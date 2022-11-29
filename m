Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E7963C02E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiK2MgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiK2MgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:36:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F545EF88
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:36:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v7so10795420wmn.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6khL3o+nYd4EpijUyoz7gbx8Fgdk9OV+QGJ+37UJ6c=;
        b=klIsnLNDetM7Gn7Mu8MxPmZKmXCifAdJeA/nDHnlS9c46nnt6EEkzBXk3zEadqNBqd
         sGEzNCfLJ5hzCVwXtRwZaeYwmAmzKR3c5pLJVvlNbwK+iT7lbaz6KFRJ1VaWEEXT/PeH
         ZYuFC3WEF2/qH5XKm3lu7HbZ8KhHhKga8NgP3+Oo1E+eypaCO/xrK45T1mvZaHhDu7I2
         Dq8OoBi+O5+CARxL8UARtYaQGP+lk0g4cvg9AwZoqtIS+/tunbKBaOX9w9Fg4rgt6spp
         V0OkSHGlDLxWmRaI7x1H4AIlFWAhpxg6r03cpR6OY7QBdzFcgGkhaQDCbecAiRGAS678
         dYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6khL3o+nYd4EpijUyoz7gbx8Fgdk9OV+QGJ+37UJ6c=;
        b=cKlc6Fq2r0nZQrqQrRXZvfvuTwh/DK+cTsOsvAZPp2eibg/L84rtaKdHm68MigTtQj
         H07/mxfAoeEpN3PJrIuS2rWPdZjDe0xxqm3We7IT32JFN3PKtFXUGVNGAES0yaqVoUE8
         xqJaQWmiyPf/3k1dtM67QcT82lnYa1trujudpZDG56ewjpiCcUK0kF+7wd/vSEMZxefc
         ZPsqYXDrpThwVLIdv/ESTY2Fz8ya1kqTIGrJApPFebcpCq+AcIeg+yD94mG2MjhV/qc1
         SbgIoyWbIjq/uCfH4PlSO7iPJ5sK2W8b+QEkktiIRd4WOlzAwHb5LpTRI0/8gFIEAzun
         UOKg==
X-Gm-Message-State: ANoB5pkZfcCvHJQA4snMwRGUWf8jwlK+0ev4Ku2AEjBkwZU9ej4dHDr2
        SNXgpKhYAcWAKD0sptCjDt3l+g==
X-Google-Smtp-Source: AA0mqf4I29VjpXe7kZPrTkE/ZqX3BP2ItLUqbJUzm4nmdNtnc/qzYYkHVSlQggvoQ6Td1w/8/R77rQ==
X-Received: by 2002:a05:600c:3543:b0:3cf:a6e8:b59b with SMTP id i3-20020a05600c354300b003cfa6e8b59bmr44570512wmq.128.1669725362248;
        Tue, 29 Nov 2022 04:36:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id k13-20020a05600c1c8d00b003c6bd91caa5sm2295306wms.17.2022.11.29.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 04:36:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Date:   Tue, 29 Nov 2022 13:35:52 +0100
Message-Id: <20221129123553.353410-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129123553.353410-1-brgl@bgdev.pl>
References: <20221129123553.353410-1-brgl@bgdev.pl>
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

