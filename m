Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5460E674
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiJZR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiJZR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:29:14 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C33471011A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:29:11 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 26 Oct 2022 20:29:06 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 29QHSwx1015427;
        Wed, 26 Oct 2022 13:28:58 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 29QHSwhJ027360;
        Wed, 26 Oct 2022 13:28:58 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        bgolaszewski@baylibre.com, linux-acpi@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/2] Support NVIDIA BlueField-3 GPIO controller
Date:   Wed, 26 Oct 2022 13:28:42 -0400
Message-Id: <20221026172843.27236-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20221026172843.27236-1-asmaa@nvidia.com>
References: <20221026172843.27236-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the BlueField-3 SoC GPIO driver
which allows:
- setting certain GPIOs as interrupts from other dependent drivers
- ability to manipulate certain GPIO values from user space

BlueField-3 has 56 GPIOs but the user is allowed to change only some
of them into GPIO mode. Use valid_mask to make it impossible to alter
the rest of the GPIOs.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf3.c | 314 +++++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a01af1180616..3e51c2a0455a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1532,6 +1532,13 @@ config GPIO_MLXBF2
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
 
+config GPIO_MLXBF3
+	tristate "Mellanox BlueField 3 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField 3 SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 29e3beb6548c..c5e86fd24d2c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_GPIO_MERRIFIELD)		+= gpio-merrifield.o
 obj-$(CONFIG_GPIO_ML_IOH)		+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MLXBF)		+= gpio-mlxbf.o
 obj-$(CONFIG_GPIO_MLXBF2)		+= gpio-mlxbf2.o
+obj-$(CONFIG_GPIO_MLXBF3)		+= gpio-mlxbf3.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)		+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)		+= gpio-mockup.o
 obj-$(CONFIG_GPIO_MOXTET)		+= gpio-moxtet.o
diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
new file mode 100644
index 000000000000..8517bbaf6f87
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+
+/*
+ * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ * There are 2 YU GPIO blocks:
+ * gpio[0]: HOST_GPIO0->HOST_GPIO31
+ * gpio[1]: HOST_GPIO32->HOST_GPIO55
+ */
+#define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
+
+/*
+ * fw_gpio[x] block registers and their offset
+ */
+#define YU_GPIO_FW_OUTPUT_ENABLE_SET	0x04
+#define YU_GPIO_FW_DATA_OUT_SET		0x08
+#define YU_GPIO_FW_OUTPUT_ENABLE_CLEAR	0x18
+#define YU_GPIO_FW_DATA_OUT_CLEAR	0x1c
+#define YU_GPIO_CAUSE_RISE_EN		0x28
+#define YU_GPIO_CAUSE_FALL_EN		0x2c
+#define YU_GPIO_READ_DATA_IN		0x30
+
+#define YU_GPIO_CAUSE_OR_CAUSE_EVTEN0	0x00
+#define YU_GPIO_CAUSE_OR_EVTEN0		0x14
+#define YU_GPIO_CAUSE_OR_CLRCAUSE	0x18
+
+struct mlxbf3_gpio_context {
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+
+	/* YU GPIO blocks address */
+	void __iomem *gpio_io;
+
+	/* YU GPIO cause block address */
+	void __iomem *gpio_cause_io;
+
+	/* Mask of valid gpios that can be accessed by software */
+	unsigned int valid_mask;
+};
+
+static int mlxbf3_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+
+	/* Write-only register */
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_OUTPUT_ENABLE_CLEAR);
+
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static int mlxbf3_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset,
+					int value)
+{
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_OUTPUT_ENABLE_SET);
+
+	if (value)
+		writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_DATA_OUT_SET);
+	else
+		writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_DATA_OUT_CLEAR);
+
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static void mlxbf3_gpio_irq_enable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	writel(BIT(offset), gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
+
+	val = readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	val |= BIT(offset);
+	writel(val, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+}
+
+static void mlxbf3_gpio_irq_disable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	val = readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	val &= ~BIT(offset);
+	writel(val, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+}
+
+static irqreturn_t mlxbf3_gpio_irq_handler(int irq, void *ptr)
+{
+	struct mlxbf3_gpio_context *gs = ptr;
+	struct gpio_chip *gc = &gs->gc;
+	unsigned long pending;
+	u32 level;
+
+	pending = readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CAUSE_EVTEN0);
+	writel(pending, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
+
+	for_each_set_bit(level, &pending, gc->ngpio)
+		generic_handle_irq(irq_find_mapping(gc->irq.domain, level));
+
+	return IRQ_RETVAL(pending);
+}
+
+static int
+mlxbf3_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	bool fall = false;
+	bool rise = false;
+	u32 val;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_BOTH:
+		fall = true;
+		rise = true;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		rise = true;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		fall = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	if (fall) {
+		val = readl(gs->gpio_io + YU_GPIO_CAUSE_FALL_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + YU_GPIO_CAUSE_FALL_EN);
+	}
+
+	if (rise) {
+		val = readl(gs->gpio_io + YU_GPIO_CAUSE_RISE_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + YU_GPIO_CAUSE_RISE_EN);
+	}
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static int mlxbf3_gpio_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+
+	*valid_mask = gs->valid_mask;
+
+	return 0;
+}
+
+/* BlueField-3 GPIO driver initialization routine. */
+static int
+mlxbf3_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf3_gpio_context *gs;
+	unsigned int npins, valid_mask;
+	struct gpio_irq_chip *girq;
+	struct gpio_chip *gc;
+	struct resource *res;
+	const char *name;
+	int ret, irq;
+
+	name = dev_name(dev);
+
+	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	/* Resource shared with pinctrl driver */
+	gs->gpio_io = devm_ioremap(dev, res->start, resource_size(res));
+	if (!gs->gpio_io)
+		return -ENOMEM;
+
+	/* YU GPIO block address */
+	gs->gpio_cause_io = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(gs->gpio_cause_io))
+		return PTR_ERR(gs->gpio_cause_io);
+
+	if (device_property_read_u32(dev, "npins", &npins))
+		npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
+
+	if (device_property_read_u32(dev, "valid_mask", &valid_mask))
+		valid_mask = 0x0;
+
+	gs->valid_mask = valid_mask;
+
+	gc = &gs->gc;
+
+	ret = bgpio_init(gc, dev, 4,
+			gs->gpio_io + YU_GPIO_READ_DATA_IN,
+			gs->gpio_io + YU_GPIO_FW_DATA_OUT_SET,
+			gs->gpio_io + YU_GPIO_FW_DATA_OUT_CLEAR,
+			NULL, NULL, 0);
+
+	gc->direction_output = mlxbf3_gpio_direction_output;
+	gc->direction_input = mlxbf3_gpio_direction_input;
+	gc->request = gpiochip_generic_request;
+	gc->free = gpiochip_generic_free;
+	gc->init_valid_mask = mlxbf3_gpio_init_valid_mask;
+
+	gc->ngpio = npins;
+	gc->owner = THIS_MODULE;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0) {
+		gs->irq_chip.name = name;
+		gs->irq_chip.irq_set_type = mlxbf3_gpio_irq_set_type;
+		gs->irq_chip.irq_enable = mlxbf3_gpio_irq_enable;
+		gs->irq_chip.irq_disable = mlxbf3_gpio_irq_disable;
+
+		girq = &gs->gc.irq;
+		girq->chip = &gs->irq_chip;
+		girq->handler = handle_simple_irq;
+		girq->default_type = IRQ_TYPE_NONE;
+		/* This will let us handle the parent IRQ in the driver */
+		girq->num_parents = 0;
+		girq->parents = NULL;
+		girq->parent_handler = NULL;
+
+		/*
+		 * Directly request the irq here instead of passing
+		 * a flow-handler because the irq is shared.
+		 */
+		ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
+				       IRQF_SHARED, name, gs);
+		if (ret) {
+			dev_err(dev, "failed to request IRQ");
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, gs);
+
+	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret) {
+		dev_err(dev, "Failed adding memory mapped gpiochip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id __maybe_unused mlxbf3_gpio_acpi_match[] = {
+	{ "MLNXBF33", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf3_gpio_acpi_match);
+
+static struct platform_driver mlxbf3_gpio_driver = {
+	.driver = {
+		.name = "mlxbf3_gpio",
+		.acpi_match_table = mlxbf3_gpio_acpi_match,
+	},
+	.probe    = mlxbf3_gpio_probe,
+};
+
+module_platform_driver(mlxbf3_gpio_driver);
+
+MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

