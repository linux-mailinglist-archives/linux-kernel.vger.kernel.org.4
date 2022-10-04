Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D485F40D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJDKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJDKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:30:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C904C3BC45;
        Tue,  4 Oct 2022 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664879413; x=1696415413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+w7WUmpkMWi9VOIR+12U1GWuwipmdOz1cXuMvsXppE=;
  b=aZrD9dizsB/TNsRMfQn5ewlyv6VzPv1hb5oQeK6CHBB2o2yqhA4lKriz
   M3lZa6+s4Jaq9RMWOuEb8ygASSKO02T2QaPYVOWP+sOROKwRH93avkfA8
   Dqg4FeIWcoI3m5RfZfTKLBtZ54BNLLtT8WdbLELLrQ+ifGl60p9A0hIvC
   QXve414Aj8SSVqcQ18UzxVG9VAN9xsN6mcqbs0ZnfOzxaxUBpR6r3zXDS
   l8wAnsEYaYU+jYRhJ2sTPxBsqK78hdrJJC6plgFRMlOEDBD506A+o8e6T
   RpuBt1pYre359lDpfs7UaBxiYiBV442uCO8DAiOTQQAtIlgVcAXL6Rrti
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="282589421"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="282589421"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601574088"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="601574088"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2022 03:30:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 753D8101; Tue,  4 Oct 2022 13:30:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH v1 1/1] gpiolib: Get rid of not used of_node member
Date:   Tue,  4 Oct 2022 13:30:27 +0300
Message-Id: <20221004103027.47660-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

To test for now (using CIs and build bots) what is left uncoverted

Expected to fail in some configurations!

 drivers/gpio/gpiolib-acpi.c | 10 -------
 drivers/gpio/gpiolib-acpi.h |  4 ---
 drivers/gpio/gpiolib-of.c   | 59 +++++++++++++++----------------------
 drivers/gpio/gpiolib-of.h   |  5 ----
 drivers/gpio/gpiolib.c      | 15 +---------
 include/linux/gpio/driver.h |  7 -----
 6 files changed, 24 insertions(+), 76 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 285ecbf107c9..4c56d97e073c 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1354,16 +1354,6 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
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
index e476558d9471..e2edb632b2cc 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -36,8 +36,6 @@ struct acpi_gpio_info {
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
 
-void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
-
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
@@ -60,8 +58,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id);
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
 
-static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev) { }
-
 static inline void
 acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 0e4e1291604d..123b24f1ea5d 100644
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
@@ -565,7 +564,7 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	u32 tmp;
 	int ret;
 
-	chip_np = chip->of_node;
+	chip_np = to_of_node(chip->fwnode);
 	if (!chip_np)
 		return ERR_PTR(-EINVAL);
 
@@ -654,16 +653,18 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
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
 
@@ -815,14 +816,15 @@ int of_mm_gpiochip_add_data(struct device_node *np,
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
 
@@ -831,8 +833,8 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 	if (mm_gc->save_regs)
 		mm_gc->save_regs(mm_gc);
 
-	of_node_put(mm_gc->gc.of_node);
-	mm_gc->gc.of_node = of_node_get(np);
+	fwnode_handle_put(mm_gc->gc.fwnode);
+	mm_gc->gc.fwnode = fwnode_handle_get(fwnode);
 
 	ret = gpiochip_add_data(gc, data);
 	if (ret)
@@ -840,12 +842,12 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 
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
@@ -869,9 +871,9 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
 
 static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 {
+	struct device_node *np = to_of_node(chip->fwnode);
 	int len, i;
 	u32 start, count;
-	struct device_node *np = chip->of_node;
 
 	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
 	if (len < 0 || len % 2 != 0)
@@ -892,7 +894,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
-	struct device_node *np = chip->of_node;
+	struct device_node *np = to_of_node(chip->fwnode);
 	struct of_phandle_args pinspec;
 	struct pinctrl_dev *pctldev;
 	int index = 0, ret;
@@ -982,9 +984,10 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip) { return 0; }
 
 int of_gpiochip_add(struct gpio_chip *chip)
 {
+	struct device_node *np = to_of_node(chip->fwnode);
 	int ret;
 
-	if (!chip->of_node)
+	if (!np)
 		return 0;
 
 	if (!chip->of_xlate) {
@@ -1001,32 +1004,16 @@ int of_gpiochip_add(struct gpio_chip *chip)
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
index 8af2bc899aab..ed26664f1537 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -15,7 +15,6 @@ int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
 bool of_gpio_need_valid_mask(const struct gpio_chip *gc);
-void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device *dev,
 					     const char *con_id,
@@ -34,10 +33,6 @@ static inline bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
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
index 4756ea08894f..d2f1b3c027d1 100644
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
index 60b7896e14b9..17144bc6240f 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -506,13 +506,6 @@ struct gpio_chip {
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

