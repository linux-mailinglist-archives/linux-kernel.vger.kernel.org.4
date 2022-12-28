Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2132657494
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiL1JUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiL1JUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:20:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D234F15;
        Wed, 28 Dec 2022 01:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672219238; x=1703755238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hNd/hArL9/6boN9uSffZJyCUY4OmKqVMlCay2nIEb8I=;
  b=bWc7r5zcnW8j5g8LSYJk6akI8ry7QzyDJcVUS6EfoW1TlbPGjUkOIS77
   fwTriSAe4WdzAaIzXIWBVaagWEBh5QpWj6RIXOXy8Z2O/f1DnGoFXwP68
   Wwvx3KMTFGMGjSYS4CIoSWjmkYZs2ZX9v/TixLelL/51163hRRPR9Te12
   +emps6+O7wcKvlsYBMBzXp9Iy7UwEzyF5hcUwVl4T4Jhkb9sUK9A9tNVA
   gVOmD+uoMDQNwFCo+5ml1OrnZ6sY61lS890kRosy4ydSyJWiloiXUi4PA
   A75sEPfzzok7ZD8jAK8qTemXJkXRlBvhh+dJaro8NAQImbbRAO+IIA0Sx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="348041442"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="348041442"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:20:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="721737258"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="721737258"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2022 01:20:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5663159; Wed, 28 Dec 2022 11:20:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 1/3] gpiolib: Introduce gpio_device_get() and gpio_device_put()
Date:   Wed, 28 Dec 2022 11:20:43 +0200
Message-Id: <20221228092045.80425-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce gpio_device_get() and gpio_device_put() helpers
and convert existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 21 +++++++++------------
 drivers/gpio/gpiolib.c      | 14 ++++++--------
 drivers/gpio/gpiolib.h      | 10 ++++++++++
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e878e3f22b0e..0a33971c964c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -321,7 +321,7 @@ static void linehandle_free(struct linehandle_state *lh)
 		if (lh->descs[i])
 			gpiod_free(lh->descs[i]);
 	kfree(lh->label);
-	put_device(&lh->gdev->dev);
+	gpio_device_put(lh->gdev);
 	kfree(lh);
 }
 
@@ -363,8 +363,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	lh = kzalloc(sizeof(*lh), GFP_KERNEL);
 	if (!lh)
 		return -ENOMEM;
-	lh->gdev = gdev;
-	get_device(&gdev->dev);
+	lh->gdev = gpio_device_get(gdev);
 
 	if (handlereq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
@@ -1576,7 +1575,7 @@ static void linereq_free(struct linereq *lr)
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
-	put_device(&lr->gdev->dev);
+	gpio_device_put(lr->gdev);
 	kfree(lr);
 }
 
@@ -1646,8 +1645,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 
-	lr->gdev = gdev;
-	get_device(&gdev->dev);
+	lr->gdev = gpio_device_get(gdev);
 
 	for (i = 0; i < ulr.num_lines; i++) {
 		lr->lines[i].req = lr;
@@ -1916,7 +1914,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-	put_device(&le->gdev->dev);
+	gpio_device_put(le->gdev);
 	kfree(le);
 }
 
@@ -2094,8 +2092,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc(sizeof(*le), GFP_KERNEL);
 	if (!le)
 		return -ENOMEM;
-	le->gdev = gdev;
-	get_device(&gdev->dev);
+	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
@@ -2671,7 +2668,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 
 	init_waitqueue_head(&cdev->wait);
 	INIT_KFIFO(cdev->events);
-	cdev->gdev = gdev;
+	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
 	ret = blocking_notifier_chain_register(&gdev->notifier,
@@ -2679,7 +2676,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_free_bitmap;
 
-	get_device(&gdev->dev);
 	file->private_data = cdev;
 
 	ret = nonseekable_open(inode, file);
@@ -2694,6 +2690,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
 out_free_bitmap:
+	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
@@ -2716,7 +2713,7 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
-	put_device(&gdev->dev);
+	gpio_device_put(gdev);
 	kfree(cdev);
 
 	return 0;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5a66d9616d7c..fdb0dc464218 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -882,7 +882,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_free_valid_mask(gc);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
-		put_device(&gdev->dev);
+		gpio_device_put(gdev);
 		goto err_print_message;
 	}
 err_remove_from_list:
@@ -972,7 +972,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 */
 	gcdev_unregister(gdev);
 	up_write(&gdev->sem);
-	put_device(&gdev->dev);
+	gpio_device_put(gdev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
@@ -2063,17 +2063,15 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
 int gpiod_request(struct gpio_desc *desc, const char *label)
 {
 	int ret = -EPROBE_DEFER;
-	struct gpio_device *gdev;
 
 	VALIDATE_DESC(desc);
-	gdev = desc->gdev;
 
-	if (try_module_get(gdev->owner)) {
+	if (try_module_get(desc->gdev->owner)) {
 		ret = gpiod_request_commit(desc, label);
 		if (ret)
-			module_put(gdev->owner);
+			module_put(desc->gdev->owner);
 		else
-			get_device(&gdev->dev);
+			gpio_device_get(desc->gdev);
 	}
 
 	if (ret)
@@ -2134,7 +2132,7 @@ void gpiod_free(struct gpio_desc *desc)
 {
 	if (desc && desc->gdev && gpiod_free_commit(desc)) {
 		module_put(desc->gdev->owner);
-		put_device(&desc->gdev->dev);
+		gpio_device_put(desc->gdev);
 	} else {
 		WARN_ON(extra_checks);
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b3c2db6eba80..cca81375f127 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -82,6 +82,16 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
 	return container_of(dev, struct gpio_device, dev);
 }
 
+static inline struct gpio_device *gpio_device_get(struct gpio_device *gdev)
+{
+	return to_gpio_device(get_device(&gdev->dev));
+}
+
+static inline void gpio_device_put(struct gpio_device *gdev)
+{
+	put_device(&gdev->dev);
+}
+
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
-- 
2.35.1

