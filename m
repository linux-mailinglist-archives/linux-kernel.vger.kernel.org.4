Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8C618719
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKCSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKCSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:08:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7ACF58;
        Thu,  3 Nov 2022 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498803; x=1699034803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tb/bsJQ7ZOSsfUsJM4qE4cXo/y1Pld0tApVWQ4QgeSs=;
  b=Sgo3a836bmxi/NN3kanYMRWksFf7EAutUPDjYdqxrrHTlhQevUBm65ma
   YfUVcXc3P6XEax0p28xFRCuE/u7zfqlIP9hPBQmq+sfcvZwEWar7IqdGN
   hLfr0LLbQD+4v3MPFOgHUwdrVL90beQxgjmotkpzxb6+hiGrPoFJQTWLd
   6cDkObIqZitvHhB5Wqh98pc+7W1vm77GEh9C1JK2hGt3cikjNPg0J78kn
   EgaeWj89W/ZsJaRr0x/yRjgXXZFzxnkzvgg7A8ovvM6kr+OJejkmBXL6W
   7yDKX7i0jH3nbnYopqMZEK/gvm6YJJHDjI8iNmGzLRxtQI6CCMXIFVh0h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293085576"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="293085576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="637272787"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="637272787"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2022 11:06:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63D93F7; Thu,  3 Nov 2022 20:06:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [rft, PATCH v2 1/1] gpiolib: Get rid of not used of_node member
Date:   Thu,  3 Nov 2022 20:06:43 +0200
Message-Id: <20221103180643.79352-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All new drivers should use fwnode and / or parent to provide the
necessary information to the GPIO library.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: resent against latest Linux Next: expected not to fail now
    (Linux Next has no more users of of_node member of gpio_chip)
v1: to test for now (using CIs and build bots) what is left uncoverted
    (Expected to fail in some configurations!)

 drivers/gpio/gpiolib-acpi.c | 10 -------
 drivers/gpio/gpiolib-acpi.h |  4 ---
 drivers/gpio/gpiolib-of.c   | 60 ++++++++++++++-----------------------
 drivers/gpio/gpiolib-of.h   |  5 ----
 drivers/gpio/gpiolib.c      | 15 +---------
 include/linux/gpio/driver.h |  7 -----
 6 files changed, 24 insertions(+), 77 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 064ba5150fd4..251e76b3a1f5 100644
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
index 01e0cb480a00..be26751b7b69 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -50,8 +50,6 @@ struct acpi_gpio_info {
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
 
-void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
-
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
@@ -74,8 +72,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id);
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
 
-static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev) { }
-
 static inline void
 acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 52616848a37c..f6a07a5b0fa0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -85,7 +85,7 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
 {
 	struct of_phandle_args *gpiospec = data;
 
-	return chip->gpiodev->dev.of_node == gpiospec->np &&
+	return device_match_of_node(&chip->gpiodev->dev, gpiospec->np) &&
 				chip->of_xlate &&
 				chip->of_xlate(chip, gpiospec, NULL) >= 0;
 }
@@ -122,9 +122,8 @@ static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
 {
 	int size;
-	const struct device_node *np = gc->of_node;
 
-	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
+	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
 	if (size > 0 && size % 2 == 0)
 		return true;
 	return false;
@@ -662,7 +661,7 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 					   unsigned long *lflags,
 					   enum gpiod_flags *dflags)
 {
-	struct device_node *chip_np;
+	struct device_node *chip_np = to_of_node(chip->fwnode);
 	enum of_gpio_flags xlate_flags;
 	struct of_phandle_args gpiospec;
 	struct gpio_desc *desc;
@@ -670,7 +669,6 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	u32 tmp;
 	int ret;
 
-	chip_np = chip->of_node;
 	if (!chip_np)
 		return ERR_PTR(-EINVAL);
 
@@ -759,16 +757,18 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
  */
 static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 {
-	struct device_node *np;
+	struct fwnode_handle *child;
 	int ret;
 
-	for_each_available_child_of_node(chip->of_node, np) {
-		if (!of_property_read_bool(np, "gpio-hog"))
+	fwnode_for_each_available_child_node(chip->fwnode, child) {
+		struct device_node *np = to_of_node(child);
+
+		if (!fwnode_property_read_bool(child, "gpio-hog"))
 			continue;
 
 		ret = of_gpiochip_add_hog(chip, np);
 		if (ret < 0) {
-			of_node_put(np);
+			fwnode_handle_put(child);
 			return ret;
 		}
 
@@ -920,14 +920,15 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 			    struct of_mm_gpio_chip *mm_gc,
 			    void *data)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	int ret = -ENOMEM;
 	struct gpio_chip *gc = &mm_gc->gc;
 
-	gc->label = kasprintf(GFP_KERNEL, "%pOF", np);
+	gc->label = kasprintf(GFP_KERNEL, "%pfw", fwnode);
 	if (!gc->label)
 		goto err0;
 
-	mm_gc->regs = of_iomap(np, 0);
+	mm_gc->regs = fwnode_iomap(fwnode, 0);
 	if (!mm_gc->regs)
 		goto err1;
 
@@ -936,8 +937,8 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 	if (mm_gc->save_regs)
 		mm_gc->save_regs(mm_gc);
 
-	of_node_put(mm_gc->gc.of_node);
-	mm_gc->gc.of_node = of_node_get(np);
+	fwnode_handle_put(mm_gc->gc.fwnode);
+	mm_gc->gc.fwnode = fwnode_handle_get(fwnode);
 
 	ret = gpiochip_add_data(gc, data);
 	if (ret)
@@ -945,12 +946,12 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 
 	return 0;
 err2:
-	of_node_put(np);
+	fwnode_handle_put(fwnode);
 	iounmap(mm_gc->regs);
 err1:
 	kfree(gc->label);
 err0:
-	pr_err("%pOF: GPIO chip registration failed with status %d\n", np, ret);
+	pr_err("%pfw: GPIO chip registration failed with status %d\n", fwnode, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_mm_gpiochip_add_data);
@@ -974,9 +975,9 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
 
 static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 {
+	struct device_node *np = to_of_node(chip->fwnode);
 	int len, i;
 	u32 start, count;
-	struct device_node *np = chip->of_node;
 
 	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
 	if (len < 0 || len % 2 != 0)
@@ -997,7 +998,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
-	struct device_node *np = chip->of_node;
+	struct device_node *np = to_of_node(chip->fwnode);
 	struct of_phandle_args pinspec;
 	struct pinctrl_dev *pctldev;
 	int index = 0, ret;
@@ -1087,9 +1088,10 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip) { return 0; }
 
 int of_gpiochip_add(struct gpio_chip *chip)
 {
+	struct device_node *np = to_of_node(chip->fwnode);
 	int ret;
 
-	if (!chip->of_node)
+	if (!np)
 		return 0;
 
 	if (!chip->of_xlate) {
@@ -1106,32 +1108,16 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (ret)
 		return ret;
 
-	of_node_get(chip->of_node);
+	fwnode_handle_get(chip->fwnode);
 
 	ret = of_gpiochip_scan_gpios(chip);
 	if (ret)
-		of_node_put(chip->of_node);
+		fwnode_handle_put(chip->fwnode);
 
 	return ret;
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(chip->of_node);
-}
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
+	fwnode_handle_put(chip->fwnode);
 }
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 1b5df39a952e..34415be0ac61 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -24,7 +24,6 @@ int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
 bool of_gpio_need_valid_mask(const struct gpio_chip *gc);
-void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device *dev,
 					     const char *con_id,
@@ -43,10 +42,6 @@ static inline bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
 {
 	return false;
 }
-static inline void of_gpio_dev_init(struct gpio_chip *gc,
-				    struct gpio_device *gdev)
-{
-}
 #endif /* CONFIG_OF_GPIO */
 
 extern struct notifier_block gpio_of_notifier;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8faedca6b14..be3240b805b4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -594,7 +594,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
 {
-	struct fwnode_handle *fwnode = NULL;
 	struct gpio_device *gdev;
 	unsigned long flags;
 	int base = gc->base;
@@ -602,11 +601,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
@@ -619,14 +613,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
index 2a44600b01f7..ee382712f066 100644
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

base-commit: 81214a573d19ae2fa5b528286ba23cd1cb17feec
-- 
2.35.1

