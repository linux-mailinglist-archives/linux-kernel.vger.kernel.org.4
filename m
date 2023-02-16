Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658726995B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBPNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjBPNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:25:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6755284;
        Thu, 16 Feb 2023 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553913; x=1708089913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oYHBvE6Orl3dJohMcJFTy8m770BvU0foqf1oKHZFBaI=;
  b=A23ZW6VRdsaYGtihKdDIRvYM7Mvr5gSpqGDXr90WwV9DefpUKnQass94
   nVTifl9pbziK9VkxSkR7OOviQHg9HGPaHqCZPCpqThAkhy8vvUCy2nphz
   wRPXcLpYKKCefd+DnUAxQgkuiGOheb0dNyykog2NKV++yKlGrccM1SfAp
   M5yjW+sxOR5mxj9PhCzZ5RhlYPSflRMEjSLDlI4hTIu/7TxRiKggfEsJY
   4a6dZI3bYneMhBtB9TLuood/8FVeweqpxY+FAwjpWj3WLBLbzVVvVf4wL
   CY88gAH0GT8u0cH6zuUKz7sH/HsaFD2++GyaXCduoUj9qC64cQiYIdteE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331711612"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331711612"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:25:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999033085"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="999033085"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2023 05:25:08 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 04EB71A9F3;
        Thu, 16 Feb 2023 18:55:08 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 01CDF18C; Thu, 16 Feb 2023 18:55:08 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/3] gpio: merrifield: Adapt to tangier driver
Date:   Thu, 16 Feb 2023 18:53:55 +0530
Message-Id: <20230216132356.29922-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230216132356.29922-1-raag.jadav@intel.com>
References: <20230216132356.29922-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Make use of Intel Tangier as a library driver for Merrifield.

Signed-off-by: Pandith N <pandith.n@intel.com>
Co-developed-by: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpio/Kconfig           |   4 +-
 drivers/gpio/gpio-merrifield.c | 444 +++------------------------------
 drivers/gpio/gpio-tangier.h    |   5 +
 3 files changed, 38 insertions(+), 415 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 952afd4e28b6..7fc7a2768705 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -631,6 +631,8 @@ config GPIO_TANGIER
 	select GPIOLIB_IRQCHIP
 	help
 	  GPIO support for Intel Tangier and compatible platforms.
+	  Currently supported:
+	   - Merrifield
 
 	  If built as a module its name will be gpio-tangier.
 
@@ -1524,7 +1526,7 @@ config GPIO_BT8XX
 config GPIO_MERRIFIELD
 	tristate "Intel Merrifield GPIO support"
 	depends on X86_INTEL_MID
-	select GPIOLIB_IRQCHIP
+	select GPIO_TANGIER
 	help
 	  Say Y here to support Intel Merrifield GPIO.
 
diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 92ea8411050d..e91749ddb38a 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -1,61 +1,26 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Intel Merrifield SoC GPIO driver
  *
- * Copyright (c) 2016 Intel Corporation.
+ * Copyright (c) 2016, 2023 Intel Corporation.
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
 #include <linux/acpi.h>
 #include <linux/bitops.h>
-#include <linux/gpio/driver.h>
-#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/string_helpers.h>
+#include <linux/types.h>
 
-#define GCCR		0x000	/* controller configuration */
-#define GPLR		0x004	/* pin level r/o */
-#define GPDR		0x01c	/* pin direction */
-#define GPSR		0x034	/* pin set w/o */
-#define GPCR		0x04c	/* pin clear w/o */
-#define GRER		0x064	/* rising edge detect */
-#define GFER		0x07c	/* falling edge detect */
-#define GFBR		0x094	/* glitch filter bypass */
-#define GIMR		0x0ac	/* interrupt mask */
-#define GISR		0x0c4	/* interrupt source */
-#define GITR		0x300	/* input type */
-#define GLPR		0x318	/* level input polarity */
-#define GWMR		0x400	/* wake mask */
-#define GWSR		0x418	/* wake source */
-#define GSIR		0xc00	/* secure input */
+#include "gpio-tangier.h"
 
 /* Intel Merrifield has 192 GPIO pins */
 #define MRFLD_NGPIO	192
 
-struct mrfld_gpio_pinrange {
-	unsigned int gpio_base;
-	unsigned int pin_base;
-	unsigned int npins;
-};
-
-#define GPIO_PINRANGE(gstart, gend, pstart)		\
-	{						\
-		.gpio_base = (gstart),			\
-		.pin_base = (pstart),			\
-		.npins = (gend) - (gstart) + 1,		\
-	}
-
-struct mrfld_gpio {
-	struct gpio_chip	chip;
-	void __iomem		*reg_base;
-	raw_spinlock_t		lock;
-	struct device		*dev;
-};
-
-static const struct mrfld_gpio_pinrange mrfld_gpio_ranges[] = {
+static const struct tng_gpio_pinrange mrfld_gpio_ranges[] = {
 	GPIO_PINRANGE(0, 11, 146),
 	GPIO_PINRANGE(12, 13, 144),
 	GPIO_PINRANGE(14, 15, 35),
@@ -84,316 +49,7 @@ static const struct mrfld_gpio_pinrange mrfld_gpio_ranges[] = {
 	GPIO_PINRANGE(190, 191, 178),
 };
 
-static void __iomem *gpio_reg(struct gpio_chip *chip, unsigned int offset,
-			      unsigned int reg_type_offset)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	u8 reg = offset / 32;
-
-	return priv->reg_base + reg_type_offset + reg * 4;
-}
-
-static int mrfld_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	void __iomem *gplr = gpio_reg(chip, offset, GPLR);
-
-	return !!(readl(gplr) & BIT(offset % 32));
-}
-
-static void mrfld_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			   int value)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	void __iomem *gpsr, *gpcr;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	if (value) {
-		gpsr = gpio_reg(chip, offset, GPSR);
-		writel(BIT(offset % 32), gpsr);
-	} else {
-		gpcr = gpio_reg(chip, offset, GPCR);
-		writel(BIT(offset % 32), gpcr);
-	}
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-}
-
-static int mrfld_gpio_direction_input(struct gpio_chip *chip,
-				      unsigned int offset)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
-	unsigned long flags;
-	u32 value;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	value = readl(gpdr);
-	value &= ~BIT(offset % 32);
-	writel(value, gpdr);
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-
-	return 0;
-}
-
-static int mrfld_gpio_direction_output(struct gpio_chip *chip,
-				       unsigned int offset, int value)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
-	unsigned long flags;
-
-	mrfld_gpio_set(chip, offset, value);
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	value = readl(gpdr);
-	value |= BIT(offset % 32);
-	writel(value, gpdr);
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-
-	return 0;
-}
-
-static int mrfld_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-{
-	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
-
-	if (readl(gpdr) & BIT(offset % 32))
-		return GPIO_LINE_DIRECTION_OUT;
-
-	return GPIO_LINE_DIRECTION_IN;
-}
-
-static int mrfld_gpio_set_debounce(struct gpio_chip *chip, unsigned int offset,
-				   unsigned int debounce)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	void __iomem *gfbr = gpio_reg(chip, offset, GFBR);
-	unsigned long flags;
-	u32 value;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	if (debounce)
-		value = readl(gfbr) & ~BIT(offset % 32);
-	else
-		value = readl(gfbr) | BIT(offset % 32);
-	writel(value, gfbr);
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-
-	return 0;
-}
-
-static int mrfld_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
-				 unsigned long config)
-{
-	u32 debounce;
-
-	if ((pinconf_to_config_param(config) == PIN_CONFIG_BIAS_DISABLE) ||
-	    (pinconf_to_config_param(config) == PIN_CONFIG_BIAS_PULL_UP) ||
-	    (pinconf_to_config_param(config) == PIN_CONFIG_BIAS_PULL_DOWN))
-		return gpiochip_generic_config(chip, offset, config);
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return mrfld_gpio_set_debounce(chip, offset, debounce);
-}
-
-static void mrfld_irq_ack(struct irq_data *d)
-{
-	struct mrfld_gpio *priv = irq_data_get_irq_chip_data(d);
-	u32 gpio = irqd_to_hwirq(d);
-	void __iomem *gisr = gpio_reg(&priv->chip, gpio, GISR);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	writel(BIT(gpio % 32), gisr);
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-}
-
-static void mrfld_irq_unmask_mask(struct mrfld_gpio *priv, u32 gpio, bool unmask)
-{
-	void __iomem *gimr = gpio_reg(&priv->chip, gpio, GIMR);
-	unsigned long flags;
-	u32 value;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	if (unmask)
-		value = readl(gimr) | BIT(gpio % 32);
-	else
-		value = readl(gimr) & ~BIT(gpio % 32);
-	writel(value, gimr);
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-}
-
-static void mrfld_irq_mask(struct irq_data *d)
-{
-	struct mrfld_gpio *priv = irq_data_get_irq_chip_data(d);
-	u32 gpio = irqd_to_hwirq(d);
-
-	mrfld_irq_unmask_mask(priv, gpio, false);
-	gpiochip_disable_irq(&priv->chip, gpio);
-}
-
-static void mrfld_irq_unmask(struct irq_data *d)
-{
-	struct mrfld_gpio *priv = irq_data_get_irq_chip_data(d);
-	u32 gpio = irqd_to_hwirq(d);
-
-	gpiochip_enable_irq(&priv->chip, gpio);
-	mrfld_irq_unmask_mask(priv, gpio, true);
-}
-
-static int mrfld_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct mrfld_gpio *priv = gpiochip_get_data(gc);
-	u32 gpio = irqd_to_hwirq(d);
-	void __iomem *grer = gpio_reg(&priv->chip, gpio, GRER);
-	void __iomem *gfer = gpio_reg(&priv->chip, gpio, GFER);
-	void __iomem *gitr = gpio_reg(&priv->chip, gpio, GITR);
-	void __iomem *glpr = gpio_reg(&priv->chip, gpio, GLPR);
-	unsigned long flags;
-	u32 value;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	if (type & IRQ_TYPE_EDGE_RISING)
-		value = readl(grer) | BIT(gpio % 32);
-	else
-		value = readl(grer) & ~BIT(gpio % 32);
-	writel(value, grer);
-
-	if (type & IRQ_TYPE_EDGE_FALLING)
-		value = readl(gfer) | BIT(gpio % 32);
-	else
-		value = readl(gfer) & ~BIT(gpio % 32);
-	writel(value, gfer);
-
-	/*
-	 * To prevent glitches from triggering an unintended level interrupt,
-	 * configure GLPR register first and then configure GITR.
-	 */
-	if (type & IRQ_TYPE_LEVEL_LOW)
-		value = readl(glpr) | BIT(gpio % 32);
-	else
-		value = readl(glpr) & ~BIT(gpio % 32);
-	writel(value, glpr);
-
-	if (type & IRQ_TYPE_LEVEL_MASK) {
-		value = readl(gitr) | BIT(gpio % 32);
-		writel(value, gitr);
-
-		irq_set_handler_locked(d, handle_level_irq);
-	} else if (type & IRQ_TYPE_EDGE_BOTH) {
-		value = readl(gitr) & ~BIT(gpio % 32);
-		writel(value, gitr);
-
-		irq_set_handler_locked(d, handle_edge_irq);
-	}
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-
-	return 0;
-}
-
-static int mrfld_irq_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct mrfld_gpio *priv = gpiochip_get_data(gc);
-	u32 gpio = irqd_to_hwirq(d);
-	void __iomem *gwmr = gpio_reg(&priv->chip, gpio, GWMR);
-	void __iomem *gwsr = gpio_reg(&priv->chip, gpio, GWSR);
-	unsigned long flags;
-	u32 value;
-
-	raw_spin_lock_irqsave(&priv->lock, flags);
-
-	/* Clear the existing wake status */
-	writel(BIT(gpio % 32), gwsr);
-
-	if (on)
-		value = readl(gwmr) | BIT(gpio % 32);
-	else
-		value = readl(gwmr) & ~BIT(gpio % 32);
-	writel(value, gwmr);
-
-	raw_spin_unlock_irqrestore(&priv->lock, flags);
-
-	dev_dbg(priv->dev, "%s wake for gpio %u\n", str_enable_disable(on), gpio);
-	return 0;
-}
-
-static const struct irq_chip mrfld_irqchip = {
-	.name		= "gpio-merrifield",
-	.irq_ack	= mrfld_irq_ack,
-	.irq_mask	= mrfld_irq_mask,
-	.irq_unmask	= mrfld_irq_unmask,
-	.irq_set_type	= mrfld_irq_set_type,
-	.irq_set_wake	= mrfld_irq_set_wake,
-	.flags		= IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
-};
-
-static void mrfld_irq_handler(struct irq_desc *desc)
-{
-	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct mrfld_gpio *priv = gpiochip_get_data(gc);
-	struct irq_chip *irqchip = irq_desc_get_chip(desc);
-	unsigned long base, gpio;
-
-	chained_irq_enter(irqchip, desc);
-
-	/* Check GPIO controller to check which pin triggered the interrupt */
-	for (base = 0; base < priv->chip.ngpio; base += 32) {
-		void __iomem *gisr = gpio_reg(&priv->chip, base, GISR);
-		void __iomem *gimr = gpio_reg(&priv->chip, base, GIMR);
-		unsigned long pending, enabled;
-
-		pending = readl(gisr);
-		enabled = readl(gimr);
-
-		/* Only interrupts that are enabled */
-		pending &= enabled;
-
-		for_each_set_bit(gpio, &pending, 32)
-			generic_handle_domain_irq(gc->irq.domain, base + gpio);
-	}
-
-	chained_irq_exit(irqchip, desc);
-}
-
-static int mrfld_irq_init_hw(struct gpio_chip *chip)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	void __iomem *reg;
-	unsigned int base;
-
-	for (base = 0; base < priv->chip.ngpio; base += 32) {
-		/* Clear the rising-edge detect register */
-		reg = gpio_reg(&priv->chip, base, GRER);
-		writel(0, reg);
-		/* Clear the falling-edge detect register */
-		reg = gpio_reg(&priv->chip, base, GFER);
-		writel(0, reg);
-	}
-
-	return 0;
-}
-
-static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
+static const char *mrfld_gpio_get_pinctrl_dev_name(struct tng_gpio *priv)
 {
 	struct acpi_device *adev;
 	const char *name;
@@ -409,37 +65,9 @@ static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
 	return name;
 }
 
-static int mrfld_gpio_add_pin_ranges(struct gpio_chip *chip)
-{
-	struct mrfld_gpio *priv = gpiochip_get_data(chip);
-	const struct mrfld_gpio_pinrange *range;
-	const char *pinctrl_dev_name;
-	unsigned int i;
-	int retval;
-
-	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name(priv);
-	if (!pinctrl_dev_name)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(mrfld_gpio_ranges); i++) {
-		range = &mrfld_gpio_ranges[i];
-		retval = gpiochip_add_pin_range(&priv->chip, pinctrl_dev_name,
-						range->gpio_base,
-						range->pin_base,
-						range->npins);
-		if (retval) {
-			dev_err(priv->dev, "failed to add GPIO pin range\n");
-			return retval;
-		}
-	}
-
-	return 0;
-}
-
 static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct gpio_irq_chip *girq;
-	struct mrfld_gpio *priv;
+	struct tng_gpio *priv;
 	u32 gpio_base, irq_base;
 	void __iomem *base;
 	int retval;
@@ -466,49 +94,37 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (!priv)
 		return -ENOMEM;
 
+	priv->ctx = devm_kzalloc(&pdev->dev, sizeof(*priv->ctx), GFP_KERNEL);
+	if (!priv->ctx)
+		return -ENOMEM;
+
 	priv->dev = &pdev->dev;
 	priv->reg_base = pcim_iomap_table(pdev)[0];
-
-	priv->chip.label = dev_name(&pdev->dev);
-	priv->chip.parent = &pdev->dev;
-	priv->chip.request = gpiochip_generic_request;
-	priv->chip.free = gpiochip_generic_free;
-	priv->chip.direction_input = mrfld_gpio_direction_input;
-	priv->chip.direction_output = mrfld_gpio_direction_output;
-	priv->chip.get = mrfld_gpio_get;
-	priv->chip.set = mrfld_gpio_set;
-	priv->chip.get_direction = mrfld_gpio_get_direction;
-	priv->chip.set_config = mrfld_gpio_set_config;
 	priv->chip.base = gpio_base;
 	priv->chip.ngpio = MRFLD_NGPIO;
+	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
+	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
 	priv->chip.can_sleep = false;
-	priv->chip.add_pin_ranges = mrfld_gpio_add_pin_ranges;
 
-	raw_spin_lock_init(&priv->lock);
+	priv->pin_info.name = mrfld_gpio_get_pinctrl_dev_name(priv);
+	if (!priv->pin_info.name)
+		return -ENOMEM;
 
 	retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (retval < 0)
 		return retval;
 
-	girq = &priv->chip.irq;
-	gpio_irq_chip_set_chip(girq, &mrfld_irqchip);
-	girq->init_hw = mrfld_irq_init_hw;
-	girq->parent_handler = mrfld_irq_handler;
-	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(&pdev->dev, girq->num_parents,
-				     sizeof(*girq->parents), GFP_KERNEL);
-	if (!girq->parents)
-		return -ENOMEM;
-	girq->parents[0] = pci_irq_vector(pdev, 0);
-	girq->first = irq_base;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_bad_irq;
+	priv->irq = pci_irq_vector(pdev, 0);
+	priv->irq_base = irq_base;
 
-	retval = devm_gpiochip_add_data(&pdev->dev, &priv->chip, priv);
-	if (retval) {
-		dev_err(&pdev->dev, "gpiochip_add error %d\n", retval);
-		return retval;
-	}
+	priv->reg.gwmr = GWMR_MRFLD;
+	priv->reg.gwsr = GWSR_MRFLD;
+	priv->reg.gsir = GSIR_MRFLD;
+
+	retval = tng_gpio_probe(priv);
+	if (retval)
+		return dev_err_probe(&pdev->dev, retval,
+				     "tng_gpio_probe error %d\n", retval);
 
 	pci_set_drvdata(pdev, priv);
 	return 0;
@@ -525,9 +141,9 @@ static struct pci_driver mrfld_gpio_driver = {
 	.id_table	= mrfld_gpio_ids,
 	.probe		= mrfld_gpio_probe,
 };
-
 module_pci_driver(mrfld_gpio_driver);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Merrifield SoC GPIO driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(GPIO_TANGIER);
diff --git a/drivers/gpio/gpio-tangier.h b/drivers/gpio/gpio-tangier.h
index 4850af012f17..414530c60c5a 100644
--- a/drivers/gpio/gpio-tangier.h
+++ b/drivers/gpio/gpio-tangier.h
@@ -18,6 +18,11 @@
 
 struct device;
 
+/* Merrifield specific wake registers */
+#define GWMR_MRFLD	0x400	/* Wake mask */
+#define GWSR_MRFLD	0x418	/* Wake source */
+#define GSIR_MRFLD	0xc00	/* Secure input */
+
 #define GPIO_PINRANGE(gstart, gend, pstart)		\
 	{						\
 		.gpio_base = (gstart),			\
-- 
2.17.1

