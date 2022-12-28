Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6165748F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiL1JUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiL1JUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:20:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718363F3;
        Wed, 28 Dec 2022 01:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672219232; x=1703755232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMmpQONPDdapY9pS6wpbPLce5H+8MKwTLo52jhIYAws=;
  b=SVBmqPT1+qYMKiciGn3BF2995TeQslZN7W6/80ckXZ/W2I3b4EWVM+8F
   /IsAQkpOSXLC/a4Mg3VFjp9eOFA2alcFzvZZdZrNuIWP2qn5xxYYYT4HA
   hn2M6ipS+ddpqe/Eyb4mAG9A4pFhOF0V+9GNEZOOW+g0ObJMkhEmgZNXH
   GaKQPzSVKN3vRBe6cXf4pTNS/qirC4rMuN2TYSKdOZ3x61YR0jyxYL+TZ
   brgFVL6S0MVAPpA0RQrBq706xGAX7U/S3PD8Exg6fQaoX/bS4EtPhkq1g
   JFz5Ms7pnGocCFrV7io57fzxfk4YBEbL+Ox0pgUFistZnrJDfc5j49Rm6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="301202849"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="301202849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:20:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="603285106"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="603285106"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2022 01:20:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D66619E; Wed, 28 Dec 2022 11:21:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v4 2/3] gpiolib: Get rid of not used of_node member
Date:   Wed, 28 Dec 2022 11:20:44 +0200
Message-Id: <20221228092045.80425-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
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

All new drivers should use fwnode and / or parent to provide the
necessary information to the GPIO library.

Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 ----------
 drivers/gpio/gpiolib-acpi.h |  4 ----
 drivers/gpio/gpiolib-of.c   | 25 +++++--------------------
 drivers/gpio/gpiolib-of.h   |  5 -----
 drivers/gpio/gpiolib.c      | 11 +++--------
 include/linux/gpio/driver.h |  7 -------
 6 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bed0380c5136..466622a8fb36 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1387,16 +1387,6 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
 	kfree(acpi_gpio);
 }
 
-void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
-{
-	/* Set default fwnode to parent's one if present */
-	if (gc->parent)
-		ACPI_COMPANION_SET(&gdev->dev, ACPI_COMPANION(gc->parent));
-
-	if (gc->fwnode)
-		device_set_node(&gdev->dev, gc->fwnode);
-}
-
 static int acpi_gpio_package_count(const union acpi_object *obj)
 {
 	const union acpi_object *element = obj->package.elements;
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 9475f99a9694..5fa315b3c912 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -26,8 +26,6 @@ struct gpio_device;
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
 
-void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
-
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
@@ -42,8 +40,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id);
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
 
-static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev) { }
-
 static inline void
 acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4fff7258ee41..a6f9788d6db0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -668,7 +668,7 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	u32 tmp;
 	int ret;
 
-	chip_np = chip->of_node;
+	chip_np = dev_of_node(&chip->gpiodev->dev);
 	if (!chip_np)
 		return ERR_PTR(-EINVAL);
 
@@ -760,7 +760,7 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 	struct device_node *np;
 	int ret;
 
-	for_each_available_child_of_node(chip->of_node, np) {
+	for_each_available_child_of_node(dev_of_node(&chip->gpiodev->dev), np) {
 		if (!of_property_read_bool(np, "gpio-hog"))
 			continue;
 
@@ -970,14 +970,15 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
-	struct device_node *np = chip->of_node;
 	struct of_phandle_args pinspec;
 	struct pinctrl_dev *pctldev;
+	struct device_node *np;
 	int index = 0, ret;
 	const char *name;
 	static const char group_names_propname[] = "gpio-ranges-group-names";
 	struct property *group_names;
 
+	np = dev_of_node(&chip->gpiodev->dev);
 	if (!np)
 		return 0;
 
@@ -1063,7 +1064,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	struct device_node *np;
 	int ret;
 
-	np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
+	np = dev_of_node(&chip->gpiodev->dev);
 	if (!np)
 		return 0;
 
@@ -1092,19 +1093,3 @@ void of_gpiochip_remove(struct gpio_chip *chip)
 {
 	fwnode_handle_put(chip->fwnode);
 }
-
-void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
-{
-	/* Set default OF node to parent's one if present */
-	if (gc->parent)
-		gdev->dev.of_node = gc->parent->of_node;
-
-	if (gc->fwnode)
-		gc->of_node = to_of_node(gc->fwnode);
-
-	/* If the gpiochip has an assigned OF node this takes precedence */
-	if (gc->of_node)
-		gdev->dev.of_node = gc->of_node;
-	else
-		gc->of_node = gdev->dev.of_node;
-}
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index a6c593e6766c..e5bb065d82ef 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -23,7 +23,6 @@ struct gpio_desc *of_find_gpio(struct device_node *np,
 int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
-void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
@@ -38,10 +37,6 @@ static inline int of_gpio_get_count(struct device *dev, const char *con_id)
 {
 	return 0;
 }
-static inline void of_gpio_dev_init(struct gpio_chip *gc,
-				    struct gpio_device *gdev)
-{
-}
 #endif /* CONFIG_OF_GPIO */
 
 extern struct notifier_block gpio_of_notifier;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fdb0dc464218..e72c539fbec5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -659,10 +659,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = 0;
 	int ret = 0;
 
+	/* If the calling driver did not initialize firmware node, do it here */
 	if (gc->fwnode)
 		fwnode = gc->fwnode;
 	else if (gc->parent)
 		fwnode = dev_fwnode(gc->parent);
+	gc->fwnode = fwnode;
 
 	/*
 	 * First: allocate and populate the internal stat container, and
@@ -676,14 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gdev->chip = gc;
 	gc->gpiodev = gdev;
 
-	of_gpio_dev_init(gc, gdev);
-	acpi_gpio_dev_init(gc, gdev);
-
-	/*
-	 * Assign fwnode depending on the result of the previous calls,
-	 * if none of them succeed, assign it to the parent's one.
-	 */
-	gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
+	device_set_node(&gdev->dev, gc->fwnode);
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 44783fc16125..2316cb7fa667 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -503,13 +503,6 @@ struct gpio_chip {
 	 * the device tree automatically may have an OF translation
 	 */
 
-	/**
-	 * @of_node:
-	 *
-	 * Pointer to a device tree node representing this GPIO controller.
-	 */
-	struct device_node *of_node;
-
 	/**
 	 * @of_gpio_n_cells:
 	 *
-- 
2.35.1

