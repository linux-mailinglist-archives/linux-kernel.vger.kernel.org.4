Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7863B1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiK1TAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiK1TAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:00:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C431B252AC;
        Mon, 28 Nov 2022 11:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669662047; x=1701198047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z4oZmTYf6q1xtHMQPZlks9ZpsjlcYED/5kdCjfxnLVI=;
  b=B+Y4SlZsFC7IkY3gQ8fjVl+HPqfxPoD5FPKhPoBtOySj1UgsffxndaaN
   H+Um5ICk1npZR1y2fLi39tnySKFRSW4UBbZjAefs7gRzrhMUH8m4fW3z9
   Jymorbl4+ZDNCOIePggO84r4x9XiulMhDcyG3wWCm+HYMSaikFe4AkR5o
   jD9243dlUZBx2cyjA/Yb/IFJcXw09j3KZoKd1pFINu/p1Ni4tqO0FBEBs
   C4LS/fxdhbMDzVaDKgN0ZQksHfogw2wwGEK/FtDLDc5Bjgd5ulCLlf2DM
   ozfXtEbzex3mcCEutV4iVZymJo7UMnq7B38oJB2y8xJyRk28CJWouGI/m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313628918"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313628918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712083613"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="712083613"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 11:00:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5913179; Mon, 28 Nov 2022 21:00:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/2] gpiolib: Introduce gpio_device_get() and gpio_device_put()
Date:   Mon, 28 Nov 2022 21:00:55 +0200
Message-Id: <20221128190055.6350-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128190055.6350-1-andriy.shevchenko@linux.intel.com>
References: <20221128190055.6350-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce gpio_device_get() and gpio_device_put() helpers
and convert existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/gpio/gpiolib-cdev.c | 21 +++++++++------------
 drivers/gpio/gpiolib.c      | 14 ++++++--------
 drivers/gpio/gpiolib.h      | 10 ++++++++++
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 8ecec2f56321..a76f2e79a776 100644
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
@@ -1487,7 +1486,7 @@ static void linereq_free(struct linereq *lr)
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
-	put_device(&lr->gdev->dev);
+	gpio_device_put(lr->gdev);
 	kfree(lr);
 }
 
@@ -1557,8 +1556,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 
-	lr->gdev = gdev;
-	get_device(&gdev->dev);
+	lr->gdev = gpio_device_get(gdev);
 
 	for (i = 0; i < ulr.num_lines; i++) {
 		lr->lines[i].req = lr;
@@ -1806,7 +1804,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-	put_device(&le->gdev->dev);
+	gpio_device_put(le->gdev);
 	kfree(le);
 }
 
@@ -1972,8 +1970,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc(sizeof(*le), GFP_KERNEL);
 	if (!le)
 		return -ENOMEM;
-	le->gdev = gdev;
-	get_device(&gdev->dev);
+	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
@@ -2521,7 +2518,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 
 	init_waitqueue_head(&cdev->wait);
 	INIT_KFIFO(cdev->events);
-	cdev->gdev = gdev;
+	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
 	ret = blocking_notifier_chain_register(&gdev->notifier,
@@ -2529,7 +2526,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_free_bitmap;
 
-	get_device(&gdev->dev);
 	file->private_data = cdev;
 
 	ret = nonseekable_open(inode, file);
@@ -2542,6 +2538,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
 out_free_bitmap:
+	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
@@ -2562,7 +2559,7 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
-	put_device(&gdev->dev);
+	gpio_device_put(gdev);
 	kfree(cdev);
 
 	return 0;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ccd47da4ec66..a54bad1ea3e5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -875,7 +875,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_free_valid_mask(gc);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
-		put_device(&gdev->dev);
+		gpio_device_put(gdev);
 		goto err_print_message;
 	}
 err_remove_from_list:
@@ -962,7 +962,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * gone.
 	 */
 	gcdev_unregister(gdev);
-	put_device(&gdev->dev);
+	gpio_device_put(gdev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
@@ -2053,17 +2053,15 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
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
@@ -2124,7 +2122,7 @@ void gpiod_free(struct gpio_desc *desc)
 {
 	if (desc && desc->gdev && gpiod_free_commit(desc)) {
 		module_put(desc->gdev->owner);
-		put_device(&desc->gdev->dev);
+		gpio_device_put(desc->gdev);
 	} else {
 		WARN_ON(extra_checks);
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index e443c1023a37..c342950ad200 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -77,6 +77,16 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
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

