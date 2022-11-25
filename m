Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58B638F88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKYSLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKYSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:11:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B231DD8;
        Fri, 25 Nov 2022 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669399898; x=1700935898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=McC2W34dBid4dm371TTlzsuWAfcvm6zxbkwy2w4MfyY=;
  b=WSmbR24MaAt0GCv8LcZGk8g4N8kaMGPZ7RAOUHE4vDtUQbB2D97bUiR6
   /mKHdJeC0hFgWgl/M0ebwJDN5uDRdIC1ZEiPTV36IocqwaL0ArR1X88Xf
   D8VvV2Yi2cGitullCzTXCSgAeO3RN3MQs8iPEkPW78lsj4jiObX18Gm8c
   paaDS3pn+XMi6b8IQ0B6ke4hFPwavklE3IYcz9NA+YOnPkPGa1fsghWV7
   wCfTI6W6Ilt3sDmX3RKQJAd8tk5XAHV1AzjEuIkL4E77eVqjIxdzULE2R
   elhehk5a221v/V7Q8tc4in8eA0u7uiNKyMXDn1m5oJ3I7KR9kJeij7S/t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="341426385"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="341426385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 10:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="642762583"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="642762583"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2022 10:11:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E198F7; Fri, 25 Nov 2022 20:12:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] gpiolib: Introduce gpio_device_get() and gpio_device_put()
Date:   Fri, 25 Nov 2022 20:11:58 +0200
Message-Id: <20221125181158.67265-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
References: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
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
index f9288e41e3a7..acfb779767ed 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -265,7 +265,7 @@ static void linehandle_free(struct linehandle_state *lh)
 		if (lh->descs[i])
 			gpiod_free(lh->descs[i]);
 	kfree(lh->label);
-	put_device(&lh->gdev->dev);
+	gpio_device_put(lh->gdev);
 	kfree(lh);
 }
 
@@ -307,8 +307,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	lh = kzalloc(sizeof(*lh), GFP_KERNEL);
 	if (!lh)
 		return -ENOMEM;
-	lh->gdev = gdev;
-	get_device(&gdev->dev);
+	lh->gdev = gpio_device_get(gdev);
 
 	if (handlereq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
@@ -1480,7 +1479,7 @@ static void linereq_free(struct linereq *lr)
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
-	put_device(&lr->gdev->dev);
+	gpio_device_put(lr->gdev);
 	kfree(lr);
 }
 
@@ -1550,8 +1549,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 
-	lr->gdev = gdev;
-	get_device(&gdev->dev);
+	lr->gdev = gpio_device_get(gdev);
 
 	for (i = 0; i < ulr.num_lines; i++) {
 		lr->lines[i].req = lr;
@@ -1799,7 +1797,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-	put_device(&le->gdev->dev);
+	gpio_device_put(le->gdev);
 	kfree(le);
 }
 
@@ -1965,8 +1963,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc(sizeof(*le), GFP_KERNEL);
 	if (!le)
 		return -ENOMEM;
-	le->gdev = gdev;
-	get_device(&gdev->dev);
+	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
@@ -2514,7 +2511,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 
 	init_waitqueue_head(&cdev->wait);
 	INIT_KFIFO(cdev->events);
-	cdev->gdev = gdev;
+	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
 	ret = blocking_notifier_chain_register(&gdev->notifier,
@@ -2522,7 +2519,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_free_bitmap;
 
-	get_device(&gdev->dev);
 	file->private_data = cdev;
 
 	ret = nonseekable_open(inode, file);
@@ -2535,6 +2531,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
 out_free_bitmap:
+	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
@@ -2555,7 +2552,7 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
-	put_device(&gdev->dev);
+	gpio_device_put(gdev);
 	kfree(cdev);
 
 	return 0;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9b935288db9d..52a1b03987dc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -874,7 +874,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_free_valid_mask(gc);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
-		put_device(&gdev->dev);
+		gpio_device_put(gdev);
 		goto err_print_message;
 	}
 err_remove_from_list:
@@ -961,7 +961,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * gone.
 	 */
 	gcdev_unregister(gdev);
-	put_device(&gdev->dev);
+	gpio_device_put(gdev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
@@ -2052,17 +2052,15 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
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
@@ -2123,7 +2121,7 @@ void gpiod_free(struct gpio_desc *desc)
 {
 	if (desc && desc->gdev && gpiod_free_commit(desc)) {
 		module_put(desc->gdev->owner);
-		put_device(&desc->gdev->dev);
+		gpio_device_put(desc->gdev);
 	} else {
 		WARN_ON(extra_checks);
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 027674025561..13b2c02ec328 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -74,6 +74,16 @@ struct gpio_device {
 
 #define to_gpio_device(_dev_)	container_of(_dev_, struct gpio_device, dev)
 
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

