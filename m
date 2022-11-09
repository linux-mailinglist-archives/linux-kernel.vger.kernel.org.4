Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA44C622EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKIPHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiKIPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:06:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7D1B78D;
        Wed,  9 Nov 2022 07:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006416; x=1699542416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jnMjN8XmUSOuY+JXUltcu3YHJQPqbKKPegrVVmr9mi8=;
  b=EyqZA2bn44370ieycqKyFo21IPAyXc23H4jtGEbJ2e8ANRUOfEyxat/W
   hg0bD8R89ZK8ABxYLbxRDd+KFUca04/BKV/4wgZCj3Htaj6RgAzuywxyn
   GJr1oPQbTGKt/s810uKw3wcMhHfGhiX5mI9ohbMzS/so8TPTOF148m/Fh
   DARzEJUKoazDGqHgcOLettbmcDjwGBhBkJf8ljadi0zGagM2HOwKKUKv4
   ncCN028gQssthgRc1ZxpdO4JP/36iKmjNW8knLcjCOQ3IcyaKkejj6frl
   g+/wP9nsNaAU0uHmEPXnUZxdroEFL+K2vTax7e0EzF59DNKxGcMrHFFeo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="291386814"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="291386814"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705736770"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="705736770"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 07:06:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 401E315C; Wed,  9 Nov 2022 17:07:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] gpiolib: Get rid of not used of_node member
Date:   Wed,  9 Nov 2022 17:07:06 +0200
Message-Id: <20221109150706.38823-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109150706.38823-1-andriy.shevchenko@linux.intel.com>
References: <20221109150706.38823-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 ----------
 drivers/gpio/gpiolib-acpi.h |  4 ----
 drivers/gpio/gpiolib-of.c   | 22 +++-------------------
 drivers/gpio/gpiolib-of.h   |  5 -----
 drivers/gpio/gpiolib.c      | 15 +--------------
 include/linux/gpio/driver.h |  7 -------
 6 files changed, 4 insertions(+), 59 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index a7d2358736fe..5c6ebb249863 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1363,16 +1363,6 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
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
index 1ac6816839db..a15495ef19ea 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -38,8 +38,6 @@ struct acpi_gpio_info {
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
 
-void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
-
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
@@ -62,8 +60,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id);
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
 
-static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev) { }
-
 static inline void
 acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 83997434215e..e22d25d85c7e 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -669,7 +669,7 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	u32 tmp;
 	int ret;
 
-	chip_np = chip->of_node;
+	chip_np = to_of_node(chip->fwnode);
 	if (!chip_np)
 		return ERR_PTR(-EINVAL);
 
@@ -761,7 +761,7 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 	struct device_node *np;
 	int ret;
 
-	for_each_available_child_of_node(chip->of_node, np) {
+	for_each_available_child_of_node(to_of_node(chip->fwnode), np) {
 		if (!of_property_read_bool(np, "gpio-hog"))
 			continue;
 
@@ -972,7 +972,7 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
-	struct device_node *np = chip->of_node;
+	struct device_node *np = to_of_node(chip->fwnode);
 	struct of_phandle_args pinspec;
 	struct pinctrl_dev *pctldev;
 	int index = 0, ret;
@@ -1094,19 +1094,3 @@ void of_gpiochip_remove(struct gpio_chip *chip)
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
index 2c32a332ede5..f128a7f45945 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -14,7 +14,6 @@ struct gpio_desc *of_find_gpio(struct device *dev,
 int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
-void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device *dev,
 					     const char *con_id,
@@ -29,10 +28,6 @@ static inline int of_gpio_get_count(struct device *dev, const char *con_id)
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
index 11fb7ec883e9..4032fbb6994c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -646,7 +646,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
 {
-	struct fwnode_handle *fwnode = NULL;
 	struct gpio_device *gdev;
 	unsigned long flags;
 	int base = gc->base;
@@ -654,11 +653,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int ret = 0;
 	u32 ngpios;
 
-	if (gc->fwnode)
-		fwnode = gc->fwnode;
-	else if (gc->parent)
-		fwnode = dev_fwnode(gc->parent);
-
 	/*
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
@@ -671,14 +665,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gdev->chip = gc;
 	gc->gpiodev = gdev;
 
-	of_gpio_dev_init(gc, gdev);
-	acpi_gpio_dev_init(gc, gdev);
-
-	/*
-	 * Assign fwnode depending on the result of the previous calls,
-	 * if none of them succeed, assign it to the parent's one.
-	 */
-	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
+	device_set_node(&gdev->dev, gc->fwnode ?: dev_fwnode(gc->parent));
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6aeea1071b1b..12c2c32d42d2 100644
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

