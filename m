Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3D6D29C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjCaVF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjCaVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:05:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF421D847
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:05:50 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5456249756bso438241657b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680296749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHDpWJ8LmFXnhqNV9hvIQWX65CwoKi+B8qVcqGGaFg0=;
        b=G0+PT7ejGRpajE70IDG+VljDx3e7hktCXEbeutu4Z4pJBD548bMqOWlCZrG8xnwd4r
         TFXNwlB2wI9Vc/2N9+eev2ReA5CZUsm2K2SXUwJROOy0Jgh/dLIm+srdAbJo8dq4c7Qn
         lgwojuCpF6qB4raUbuePretyHJAxgHhonIohQ8BaIMVXqWVhniJLQYqLNfO51jgtiPsd
         rox5wnzCuO5O7JL8TgiyTljQ10t52M1/6YaAPhGOR/rWF/e9oUFu+tPkX3nkk2Da+KEY
         737F06pFt10ESPCILHraylzZeVDpNDlfL8PR7GTioMzDUfzqcDD497oX4nDrTxtc0rlk
         X/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680296749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHDpWJ8LmFXnhqNV9hvIQWX65CwoKi+B8qVcqGGaFg0=;
        b=x9nEH2jJ7n4Lnq60q/Wvjqnk4s/zXX3lXPCkCTdpl9YBZkeNervATy97Y2eGHtLCgL
         jPU4Ow2E72/xu1osmP+R7VwcBXVI2/aqWvVPwpGg5OuX7P1dhDZiAprpttvt4OtdMRxT
         w1jTeqRx4qMwOwUq+hXMG798JuBhJpEUpClbs4S+Lm6h1yemsFM59Yz4r69+rvMbeiFe
         HDinYJccAxv4+7T6I7HDGsjhimhrMHFjCxH5lTg9FquZTAIH6t0ZYRH7ySJfkKYbt09A
         nGFFJualBJpkHCi1YFLVdTaJd2iCmVpSDGeLWlX0Dt/S6yJ7wbqH+cj5fZrPzplXjHXI
         TDZA==
X-Gm-Message-State: AAQBX9eHyGS36bOvejTX0xyalzdJZ574JZtCJ/p6whw+mXgYSV7a4Tmd
        N3iyzaGEgWH3/VmwQ340vb7k/g==
X-Google-Smtp-Source: AKy350ZMxzGAxGBBzwyegUQTjZuCNCvSqOdvEKiR8RakGgyyjTeJgysvwuTu8De3A5lkz/9wj4s9CA==
X-Received: by 2002:a0d:e28c:0:b0:544:7994:34dc with SMTP id l134-20020a0de28c000000b00544799434dcmr22865405ywe.43.1680296749222;
        Fri, 31 Mar 2023 14:05:49 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q70-20020a81b249000000b0054601ee157fsm751990ywh.114.2023.03.31.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:05:48 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 3/4] gpio: pci-idio-16: Migrate to the regmap API
Date:   Fri, 31 Mar 2023 17:05:25 -0400
Message-Id: <672f7f4ad6afb0d6bf5745118334b27c36594f77.1680296343.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680296343.git.william.gray@linaro.org>
References: <cover.1680296343.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. Migrate the pci-idio-16 module to the new
idio-16 library interface leveraging the gpio-regmap API.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4: none

 drivers/gpio/Kconfig            |   2 +-
 drivers/gpio/gpio-pci-idio-16.c | 294 +++++++-------------------------
 2 files changed, 62 insertions(+), 234 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9f7ec4f3fdbf..e19b2612e67c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1580,7 +1580,7 @@ config GPIO_PCH
 
 config GPIO_PCI_IDIO_16
 	tristate "ACCES PCI-IDIO-16 GPIO support"
-	select GPIOLIB_IRQCHIP
+	select REGMAP_MMIO
 	select GPIO_IDIO_16
 	help
 	  Enables GPIO support for the ACCES PCI-IDIO-16. An interrupt is
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 6726c32e31e6..5da67e0c83ff 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -5,214 +5,75 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/interrupt.h>
-#include <linux/irqdesc.h>
+#include <linux/err.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #include "gpio-idio-16.h"
 
-/**
- * struct idio_16_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @reg:	I/O address offset for the GPIO device registers
- * @state:	ACCES IDIO-16 device state
- * @irq_mask:	I/O bits affected by interrupts
- */
-struct idio_16_gpio {
-	struct gpio_chip chip;
-	raw_spinlock_t lock;
-	struct idio_16 __iomem *reg;
-	struct idio_16_state state;
-	unsigned long irq_mask;
+static const struct regmap_range idio_16_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x2), regmap_reg_range(0x3, 0x4),
 };
-
-static int idio_16_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	if (idio_16_get_direction(offset))
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int idio_16_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	return 0;
-}
-
-static int idio_16_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	return idio_16_get(idio16gpio->reg, &idio16gpio->state, offset);
-}
-
-static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
-	return 0;
-}
-
-static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, value);
-}
-
-static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-
-	idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
-}
-
-static void idio_16_irq_ack(struct irq_data *data)
-{
-}
-
-static void idio_16_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned long mask = BIT(irqd_to_hwirq(data));
-	unsigned long flags;
-
-	idio16gpio->irq_mask &= ~mask;
-
-	if (!idio16gpio->irq_mask) {
-		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-		iowrite8(0, &idio16gpio->reg->irq_ctl);
-
-		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
-	}
-
-	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
-}
-
-static void idio_16_irq_unmask(struct irq_data *data)
-{
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned long mask = BIT(irqd_to_hwirq(data));
-	const unsigned long prev_irq_mask = idio16gpio->irq_mask;
-	unsigned long flags;
-
-	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
-
-	idio16gpio->irq_mask |= mask;
-
-	if (!prev_irq_mask) {
-		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-		ioread8(&idio16gpio->reg->irq_ctl);
-
-		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
-	}
-}
-
-static int idio_16_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	/* The only valid irq types are none and both-edges */
-	if (flow_type != IRQ_TYPE_NONE &&
-		(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
-
-	return 0;
-}
-
-static const struct irq_chip idio_16_irqchip = {
-	.name = "pci-idio-16",
-	.irq_ack = idio_16_irq_ack,
-	.irq_mask = idio_16_irq_mask,
-	.irq_unmask = idio_16_irq_unmask,
-	.irq_set_type = idio_16_irq_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+static const struct regmap_range idio_16_rd_ranges[] = {
+	regmap_reg_range(0x1, 0x2), regmap_reg_range(0x5, 0x6),
 };
-
-static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
-{
-	struct idio_16_gpio *const idio16gpio = dev_id;
-	unsigned int irq_status;
-	struct gpio_chip *const chip = &idio16gpio->chip;
-	int gpio;
-
-	raw_spin_lock(&idio16gpio->lock);
-
-	irq_status = ioread8(&idio16gpio->reg->irq_status);
-
-	raw_spin_unlock(&idio16gpio->lock);
-
-	/* Make sure our device generated IRQ */
-	if (!(irq_status & 0x3) || !(irq_status & 0x4))
-		return IRQ_NONE;
-
-	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
-		generic_handle_domain_irq(chip->irq.domain, gpio);
-
-	raw_spin_lock(&idio16gpio->lock);
-
-	/* Clear interrupt */
-	iowrite8(0, &idio16gpio->reg->in0_7);
-
-	raw_spin_unlock(&idio16gpio->lock);
-
-	return IRQ_HANDLED;
-}
-
-#define IDIO_16_NGPIO 32
-static const char *idio_16_names[IDIO_16_NGPIO] = {
-	"OUT0", "OUT1", "OUT2", "OUT3", "OUT4", "OUT5", "OUT6", "OUT7",
-	"OUT8", "OUT9", "OUT10", "OUT11", "OUT12", "OUT13", "OUT14", "OUT15",
-	"IIN0", "IIN1", "IIN2", "IIN3", "IIN4", "IIN5", "IIN6", "IIN7",
-	"IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15"
+static const struct regmap_range idio_16_precious_ranges[] = {
+	regmap_reg_range(0x2, 0x2),
+};
+static const struct regmap_access_table idio_16_wr_table = {
+	.yes_ranges = idio_16_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_wr_ranges),
+};
+static const struct regmap_access_table idio_16_rd_table = {
+	.yes_ranges = idio_16_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_rd_ranges),
+};
+static const struct regmap_access_table idio_16_precious_table = {
+	.yes_ranges = idio_16_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_16_precious_ranges),
+};
+static const struct regmap_config idio_16_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x6,
+	.wr_table = &idio_16_wr_table,
+	.rd_table = &idio_16_rd_table,
+	.volatile_table = &idio_16_rd_table,
+	.precious_table = &idio_16_precious_table,
+	.cache_type = REGCACHE_FLAT,
 };
 
-static int idio_16_irq_init_hw(struct gpio_chip *gc)
-{
-	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(gc);
-
-	/* Disable IRQ by default and clear any pending interrupt */
-	iowrite8(0, &idio16gpio->reg->irq_ctl);
-	iowrite8(0, &idio16gpio->reg->in0_7);
+/* Only input lines (GPIO 16-31) support interrupts */
+#define IDIO_16_REGMAP_IRQ(_id)						\
+	[16 + _id] = {							\
+		.mask = BIT(2),						\
+		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH },	\
+	}
 
-	return 0;
-}
+static const struct regmap_irq idio_16_regmap_irqs[] = {
+	IDIO_16_REGMAP_IRQ(0), IDIO_16_REGMAP_IRQ(1), IDIO_16_REGMAP_IRQ(2), /* 0-2 */
+	IDIO_16_REGMAP_IRQ(3), IDIO_16_REGMAP_IRQ(4), IDIO_16_REGMAP_IRQ(5), /* 3-5 */
+	IDIO_16_REGMAP_IRQ(6), IDIO_16_REGMAP_IRQ(7), IDIO_16_REGMAP_IRQ(8), /* 6-8 */
+	IDIO_16_REGMAP_IRQ(9), IDIO_16_REGMAP_IRQ(10), IDIO_16_REGMAP_IRQ(11), /* 9-11 */
+	IDIO_16_REGMAP_IRQ(12), IDIO_16_REGMAP_IRQ(13), IDIO_16_REGMAP_IRQ(14), /* 12-14 */
+	IDIO_16_REGMAP_IRQ(15), /* 15 */
+};
 
 static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *const dev = &pdev->dev;
-	struct idio_16_gpio *idio16gpio;
 	int err;
 	const size_t pci_bar_index = 2;
 	const char *const name = pci_name(pdev);
-	struct gpio_irq_chip *girq;
-
-	idio16gpio = devm_kzalloc(dev, sizeof(*idio16gpio), GFP_KERNEL);
-	if (!idio16gpio)
-		return -ENOMEM;
+	struct idio_16_regmap_config config = {};
+	void __iomem *regs;
+	struct regmap *map;
 
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -226,53 +87,20 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	idio16gpio->reg = pcim_iomap_table(pdev)[pci_bar_index];
+	regs = pcim_iomap_table(pdev)[pci_bar_index];
 
-	/* Deactivate input filters */
-	iowrite8(0, &idio16gpio->reg->filter_ctl);
+	map = devm_regmap_init_mmio(dev, regs, &idio_16_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "Unable to initialize register map\n");
 
-	idio16gpio->chip.label = name;
-	idio16gpio->chip.parent = dev;
-	idio16gpio->chip.owner = THIS_MODULE;
-	idio16gpio->chip.base = -1;
-	idio16gpio->chip.ngpio = IDIO_16_NGPIO;
-	idio16gpio->chip.names = idio_16_names;
-	idio16gpio->chip.get_direction = idio_16_gpio_get_direction;
-	idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
-	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
-	idio16gpio->chip.get = idio_16_gpio_get;
-	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
-	idio16gpio->chip.set = idio_16_gpio_set;
-	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
-
-	idio_16_state_init(&idio16gpio->state);
-
-	girq = &idio16gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
-	girq->init_hw = idio_16_irq_init_hw;
-
-	raw_spin_lock_init(&idio16gpio->lock);
-
-	err = devm_gpiochip_add_data(dev, &idio16gpio->chip, idio16gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
-
-	err = devm_request_irq(dev, pdev->irq, idio_16_irq_handler, IRQF_SHARED,
-		name, idio16gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.map = map;
+	config.regmap_irqs = idio_16_regmap_irqs;
+	config.num_regmap_irqs = ARRAY_SIZE(idio_16_regmap_irqs);
+	config.irq = pdev->irq;
+	config.filters = true;
 
-	return 0;
+	return devm_idio_16_regmap_register(dev, &config);
 }
 
 static const struct pci_device_id idio_16_pci_dev_id[] = {
-- 
2.39.2

