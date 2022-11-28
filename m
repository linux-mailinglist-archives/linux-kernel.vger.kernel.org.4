Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C463B0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiK1SIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiK1SIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:08:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEBC5A6C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:52:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h131-20020a1c2189000000b003d02dd48c45so6447983wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMtp1gg19QZNYjxQ694u9n0VoXP0xbVcjfY8e1YGe7s=;
        b=geTeHRxJpGj4ZYrwPK6CHWNqeuUn2eExpT2gpLyM+ZLBorJfImu4aznrfFaWJJ3cdF
         qoo2HCN3w536klplUcQq+NOJyB5b1xM5wt69HDl2ieYoXmt3K67e9AZ9FF7DdpsC/k9E
         Q+BB4wDGxcFyTa5LR3ND2kQFbv5m990QtjR6yj0hvvkvl96LbZcoqatUKcSIfMjm0w9s
         YJIqxn2NAdmcF/4CwnqMYm/fxCGbcyvkLekA6Y/z+5oJ6T0IQS/qeANQ0lyn9RvqQPCw
         MQFyrqcHUn36xBdPTO+shMTrPuwrMK+W3CmwPJdQd381KfnWWAlJsuyrGmIjEyBM1FAM
         yVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMtp1gg19QZNYjxQ694u9n0VoXP0xbVcjfY8e1YGe7s=;
        b=mwhjZFzpUSwO5THUO3CczrdUI5PiGWEZqUw/v3ifSP4et81JYvTNjTmwYPaPNaVG2u
         vnS+eVYlVY7ldR2xTc489AovyZHP2dfIYhmxqHh7vYEDG87htOcOMhXkQECvZN1Qb5p9
         PTNE9oi61iuuBlCMPB0VILbs80DthZ1rB+IG56MA/SNiVwQMSZkjj/WjofDU85mO/lIZ
         MIcE8IkkLudRWvh4vrb/N6gy13xFDHnCOQJEHhaAbCKyRxQnYNiccFhgtOraEbLUJMj8
         Bz+NQ2H17kMj5VlTKW0E5C9VboDNqg2uiRXaQYmD8rt4exc69s2HQ6cWu807ubjPqePo
         uDng==
X-Gm-Message-State: ANoB5pnX4n8zn7XGFwillAPzdQn7rh7CknJ59Z/vTMXDTiP447xQw3br
        qsbNqqSTh25HXedATnnKz4AQqw==
X-Google-Smtp-Source: AA0mqf7yDCS6YXNaAh/VbIEuuYhdWcYlJ680GOih6Kp00Cv8OR7JwYAojb7kUKsAlj/JMO3VMgpEbA==
X-Received: by 2002:a05:600c:654c:b0:3d0:110c:d25f with SMTP id dn12-20020a05600c654c00b003d0110cd25fmr32284389wmb.125.1669657940931;
        Mon, 28 Nov 2022 09:52:20 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:791b:cf20:d3ea:d01])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d4b47000000b00242109cf587sm5828856wrs.28.2022.11.28.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:52:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Date:   Mon, 28 Nov 2022 18:52:13 +0100
Message-Id: <20221128175214.602612-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221128175214.602612-1-brgl@bgdev.pl>
References: <20221128175214.602612-1-brgl@bgdev.pl>
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
---
 drivers/gpio/gpiolib-cdev.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0cb6b468f364..7a9504fb27f1 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -195,12 +195,16 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct linehandle_state *lh = file->private_data;
+	struct gpio_device *gdev = lh->gdev;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 	DECLARE_BITMAP(vals, GPIOHANDLES_MAX);
 	unsigned int i;
 	int ret;
 
+	if (!gdev->chip)
+		return -ENODEV;
+
 	switch (cmd) {
 	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
 		/* NOTE: It's okay to read values of output lines */
@@ -1382,8 +1386,12 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 			  unsigned long arg)
 {
 	struct linereq *lr = file->private_data;
+	struct gpio_device *gdev = lr->gdev;
 	void __user *ip = (void __user *)arg;
 
+	if (!gdev->chip)
+		return -ENODEV;
+
 	switch (cmd) {
 	case GPIO_V2_LINE_GET_VALUES_IOCTL:
 		return linereq_get_values(lr, ip);
@@ -1408,8 +1416,12 @@ static __poll_t linereq_poll(struct file *file,
 			    struct poll_table_struct *wait)
 {
 	struct linereq *lr = file->private_data;
+	struct gpio_device *gdev = lr->gdev;
 	__poll_t events = 0;
 
+	if (!gdev->chip)
+		return 0;
+
 	poll_wait(file, &lr->wait, wait);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&lr->events,
@@ -1425,10 +1437,14 @@ static ssize_t linereq_read(struct file *file,
 			    loff_t *f_ps)
 {
 	struct linereq *lr = file->private_data;
+	struct gpio_device *gdev = lr->gdev;
 	struct gpio_v2_line_event le;
 	ssize_t bytes_read = 0;
 	int ret;
 
+	if (!gdev->chip)
+		return -ENODEV;
+
 	if (count < sizeof(le))
 		return -EINVAL;
 
@@ -1714,8 +1730,12 @@ static __poll_t lineevent_poll(struct file *file,
 			       struct poll_table_struct *wait)
 {
 	struct lineevent_state *le = file->private_data;
+	struct gpio_device *gdev = le->gdev;
 	__poll_t events = 0;
 
+	if (!gdev->chip)
+		return 0;
+
 	poll_wait(file, &le->wait, wait);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
@@ -1735,11 +1755,15 @@ static ssize_t lineevent_read(struct file *file,
 			      loff_t *f_ps)
 {
 	struct lineevent_state *le = file->private_data;
+	struct gpio_device *gdev = le->gdev;
 	struct gpioevent_data ge;
 	ssize_t bytes_read = 0;
 	ssize_t ge_size;
 	int ret;
 
+	if (!gdev->chip)
+		return -ENODEV;
+
 	/*
 	 * When compatible system call is being used the struct gpioevent_data,
 	 * in case of at least ia32, has different size due to the alignment
@@ -1818,9 +1842,13 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
 	struct lineevent_state *le = file->private_data;
+	struct gpio_device *gdev = le->gdev;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 
+	if (!gdev->chip)
+		return -ENODEV;
+
 	/*
 	 * We can get the value for an event line but not set it,
 	 * because it is input by definition.
@@ -2405,8 +2433,12 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 				    struct poll_table_struct *pollt)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
+	struct gpio_device *gdev = cdev->gdev;
 	__poll_t events = 0;
 
+	if (!gdev->chip)
+		return 0;
+
 	poll_wait(file, &cdev->wait, pollt);
 
 	if (!kfifo_is_empty_spinlocked_noirqsave(&cdev->events,
@@ -2420,11 +2452,15 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 				   size_t count, loff_t *off)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
+	struct gpio_device *gdev = cdev->gdev;
 	struct gpio_v2_line_info_changed event;
 	ssize_t bytes_read = 0;
 	int ret;
 	size_t event_size;
 
+	if (!gdev->chip)
+		return -ENODEV;
+
 #ifndef CONFIG_GPIO_CDEV_V1
 	event_size = sizeof(struct gpio_v2_line_info_changed);
 	if (count < event_size)
-- 
2.37.2

