Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43C5B3761
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIIMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiIIMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:17:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044A241
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:14:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so4307806wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TJ4GfQdS18kjHFzyMVfKhwUm6gcXBWn+mssbcPQeJwE=;
        b=oN+I2pZAMqI3F5MeqhWKzXHDmX8Vcv6SECSIdW4HUtd1bBI2PS0RstBczHMiXFmLx2
         iPULfg56vRYZrIC/ZqZocF5LvapN/pLM3Sb/uFSs32AeOql+cbzefQgx+jpxO9/nTYIG
         DxwPzwNjpuffSzbZYkt9ZZ5wYiIuQ+64ehufT7ox7+tV6obS1IMaiDFxtl+9gkV8J3zC
         RB49BeuCvypsRAWsa4x4hJ7qs0Zf5mXrlhRbz5FLn70d/PvDo0XYxbiC2aFzqcyqOIiA
         YMOlv9ga7nVU8qMl5Q2QmR+teVJvjA44Ncz7NUo95O+5OTb5/s0CcZCp0JsokwrZ079n
         gH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TJ4GfQdS18kjHFzyMVfKhwUm6gcXBWn+mssbcPQeJwE=;
        b=AdxWtbpIKdGnWdLRI4NG6R5MTTs3PByV8wHcQHZRmAseySl3c32TiwCiiFrmWeSAHy
         Bt81o6dJGH2ZdPsU+3PUfYDFc+KZuW28eY1piFP5UDbyx0yrOD1qghBK4kVvJu+SaDTU
         UZ79lWFz1MfNsuGgCJ8v1afx4tYzAxn2/WKmXFzfXmWNeabulhvHkZVp97Bm1LjgssIT
         IQe3bI4rSjU7kIHi9nTJCKBcGt3VgNp240VGqTpEekj14fPGDSSjBYHxJzvpZrxrFiBN
         TYbKgvN58fhSzwyQlst47Cz4EQIV3NowwHE9LY/FN6W+ZPSR7IhQ8DPtm9Dfur1Yj8tn
         R5EQ==
X-Gm-Message-State: ACgBeo1PUtD7eacN+iVvR9u8CiW0m2jBpMhvF9FW8IKD94BfvGFhb+Vl
        l3urpYgCjQ7PVs+Voq+4pTj/WQ==
X-Google-Smtp-Source: AA6agR7FEMeGmHB066ypHBK/GDBz2fh/IZgxjLvt0P89XdLeGs68qyApP3Eftizp90z5O1zcBhMMIw==
X-Received: by 2002:a05:600c:6009:b0:3a5:b069:5d34 with SMTP id az9-20020a05600c600900b003a5b0695d34mr5250244wmb.115.1662725616388;
        Fri, 09 Sep 2022 05:13:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a421:c10c:c626:3f52])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b0022863395912sm379005wrm.53.2022.09.09.05.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:13:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Date:   Fri,  9 Sep 2022 14:13:29 +0200
Message-Id: <20220909121329.42004-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909121329.42004-1-brgl@bgdev.pl>
References: <20220909121329.42004-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful for user-space to be able to know the PIDs of processes
holding GPIO lines in case they have the permissions and need to kill
them.

Extend the gpio_v2_line_info structure with the consumer_pid field
that's set to the PID of the user-space process or 0 if the user lives
in the kernel.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib-cdev.c |  2 ++
 drivers/gpio/gpiolib.c      | 24 +++++++++++++++++++-----
 drivers/gpio/gpiolib.h      |  2 ++
 include/uapi/linux/gpio.h   |  5 ++++-
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f8041d4898d1..9b6d518680dc 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2120,6 +2120,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	if (desc->label)
 		strscpy(info->consumer, desc->label, sizeof(info->consumer));
 
+	info->consumer_pid = desc->pid;
+
 	/*
 	 * Userspace only need to know that the kernel is using this GPIO so
 	 * it can't use it.
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6768734b9e15..0c9d1639b04d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -96,6 +96,11 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
 	d->label = label;
 }
 
+static inline void desc_set_pid(struct gpio_desc *d, pid_t pid)
+{
+	d->pid = pid;
+}
+
 /**
  * gpio_to_desc - Convert a GPIO number to its descriptor
  * @gpio: global GPIO number
@@ -1892,7 +1897,8 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
  * on each other, and help provide better diagnostics in debugfs.
  * They're called even less than the "set direction" calls.
  */
-static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
+static int
+gpiod_request_commit(struct gpio_desc *desc, const char *label, pid_t pid)
 {
 	struct gpio_chip	*gc = desc->gdev->chip;
 	int			ret;
@@ -1913,6 +1919,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 
 	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
 		desc_set_label(desc, label ? : "?");
+		desc_set_pid(desc, pid);
 	} else {
 		ret = -EBUSY;
 		goto out_free_unlock;
@@ -1987,7 +1994,8 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
 		return; \
 	} while (0)
 
-int gpiod_request(struct gpio_desc *desc, const char *label)
+static int
+gpiod_request_with_pid(struct gpio_desc *desc, const char *label, pid_t pid)
 {
 	int ret = -EPROBE_DEFER;
 	struct gpio_device *gdev;
@@ -1996,7 +2004,7 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	gdev = desc->gdev;
 
 	if (try_module_get(gdev->owner)) {
-		ret = gpiod_request_commit(desc, label);
+		ret = gpiod_request_commit(desc, label, pid);
 		if (ret)
 			module_put(gdev->owner);
 		else
@@ -2009,11 +2017,16 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	return ret;
 }
 
+int gpiod_request(struct gpio_desc *desc, const char *label)
+{
+	return gpiod_request_with_pid(desc, label, 0);
+}
+
 int gpiod_request_user(struct gpio_desc *desc, const char *label)
 {
 	int ret;
 
-	ret = gpiod_request(desc, label);
+	ret = gpiod_request_with_pid(desc, label, current->pid);
 	if (ret == -EPROBE_DEFER)
 		ret = -ENODEV;
 
@@ -2042,6 +2055,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		}
 		kfree_const(desc->label);
 		desc_set_label(desc, NULL);
+		desc_set_pid(desc, 0);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
 		clear_bit(FLAG_OPEN_DRAIN, &desc->flags);
@@ -2140,7 +2154,7 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 		return desc;
 	}
 
-	ret = gpiod_request_commit(desc, label);
+	ret = gpiod_request_commit(desc, label, 0);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b35deb08a7f5..d1535677e162 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -165,6 +165,8 @@ struct gpio_desc {
 
 	/* Connection label */
 	const char		*label;
+	/* Consumer's PID (if consumer is in user-space, otherwise 0) */
+	pid_t			pid;
 	/* Name of the GPIO */
 	const char		*name;
 #ifdef CONFIG_OF_DYNAMIC
diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index cb9966d49a16..37f10021d1aa 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -219,6 +219,8 @@ struct gpio_v2_line_request {
  * gpio_v2_line_flag, such as %GPIO_V2_LINE_FLAG_ACTIVE_LOW,
  * %GPIO_V2_LINE_FLAG_OUTPUT etc, added together.
  * @attrs: the configuration attributes associated with the line
+ * @consumer_pid: process ID of the user-space consumer or 0 if the consumer
+ * lives in kernel space
  * @padding: reserved for future use
  */
 struct gpio_v2_line_info {
@@ -228,8 +230,9 @@ struct gpio_v2_line_info {
 	__u32 num_attrs;
 	__aligned_u64 flags;
 	struct gpio_v2_line_attribute attrs[GPIO_V2_LINE_NUM_ATTRS_MAX];
+	__s32 consumer_pid;
 	/* Space reserved for future use. */
-	__u32 padding[4];
+	__u32 padding[3];
 };
 
 /**
-- 
2.34.1

