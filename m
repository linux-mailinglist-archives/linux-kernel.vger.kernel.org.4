Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC963A16F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiK1GnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK1GnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:43:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414755580;
        Sun, 27 Nov 2022 22:43:10 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxVPB8WIRjppgBAA--.3935S3;
        Mon, 28 Nov 2022 14:43:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuJ2WIRjVQwdAA--.8588S2;
        Mon, 28 Nov 2022 14:43:07 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Subject: [PATCH v8 1/2] gpio: loongson: add gpio driver support
Date:   Mon, 28 Nov 2022 14:42:59 +0800
Message-Id: <20221128064300.12021-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuJ2WIRjVQwdAA--.8588S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfGw1kWrWrWr1UZr1kJr1rCrg_yoW8XFykCo
        W7WFZ8WrW8Wr17JayFq3WSqF47ZFn0qF10ywnakan8Ca15tr98Jry3C3y3XFy0vF1FgFy7
        ZFyfur4fGFsrtF4Dn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
        Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I
        6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8-4S5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson platforms GPIO controller contains 60 GPIO pins in total,
4 of which are dedicated GPIO pins, and the remaining 56 are reused
with other functions. Each GPIO can set input/output and has the
interrupt capability.

This driver added support for Loongson GPIO controller and support to
use DTS or ACPI to descibe GPIO device resources.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v8:
		1. Return the loongson_gpio_init function directly in probe.
Change in v7:
		1. Add the gpio irqchip support.
		2. Replace __set_direction with loongson_commit_direction.
		3. Replace __set_level with loongson_commit_level. 
		4. Remove the parser of gsi_idx_map. 
		5. Add the support_irq flag.
		6. Replace string platform_data with chip_data.
		7. Remove the loongson_gpio_request.
Change in v6:
		1. Remove the bit mode keep byte mode in all function except 
		   loongson_gpio_init.
		2. Use bgpio_init replace bit mode. 
		3. Implement the function loongson_gpio_get_direction for byte mode.
		4. Set ngpios after call bgpio_init. 
		5. Use gpio-loongson-64bit.c as driver filename.
		6. Ignore that loongson legacy drvier and remove the patch about 
		   "gpio: loongson2ef: move driver to original location". 
Change in v5:
		1. Move legacy gpio driver to proper location.
		2. Remove the "gpio_base".
		3. Add of_device_id and acpi_device_id data field for platform
		   data. 
		4. Remove the ACPI_PTR().
		5. Remove the gpio label judgement logic and use mode instead.  
		6. Drop platform_loongson_gpio_get_props.
		7. Using devres for all resource. 
		8. Remove the loongson_gpio_remove.
		9. Remove the unmatched print information.
		10. Remove the loongson_gpio_exit.
Change in v4:
		1. Fixup name spelling about Signed-off-by. 
		2. Drop "series" here and everywhere else.
		3. Fixup the copyright in driver.
		4. Drop the "else" in loongson_gpio_request.
		5. Use trinocular operation replace the related logic.
		6. Remove lable judgement in context about "lgpio->chip.to_irq = 
		   loongson_gpio_to_irq"
		7. Use dev_err replace pr_err in probe.
		8. Make legacy platform_data should be left out of this patch.
		9. Remove the mips config in gpio Kconfig.
Change in v3:
		1. Move the gpio platform data struct from arch/ into include/linux/
		   platform_data/.
		2. Replace platform_gpio_data with loongson_gpio_platform_data in .c.
		3. Add maintainer in MAINTAINERS file for include/linux/platform_data/
		   gpio-loongson.h and gpio-loongson.c
Change in v2:
		1. Fixup of_loongson_gpio_get_props and remove the parse logic about
	           "loongson,conf_offset", "loongson,out_offset", "loongson,in_offset",
		   "loongson,gpio_base", "loongson,support_irq" then kernel driver will
		   initial them that depend compatible except "loongson,gpio_base".

 MAINTAINERS                        |   6 +
 drivers/gpio/Kconfig               |  12 +
 drivers/gpio/Makefile              |   1 +
 drivers/gpio/gpio-loongson-64bit.c | 378 +++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 drivers/gpio/gpio-loongson-64bit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114db9c8f32..2854da69cabb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12051,6 +12051,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
+LOONGSON GPIO DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-loongson-64bit.c
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a01af1180616..d3e2380dbacf 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -381,6 +381,18 @@ config GPIO_LOONGSON
 	help
 	  Driver for GPIO functionality on Loongson-2F/3A/3B processors.
 
+config GPIO_LOONGSON_64BIT
+	tristate "Loongson 64 bit GPIO support"
+	depends on LOONGARCH || COMPILE_TEST
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support the GPIO functionality of a number of
+	  Loongson series of chips. The Loongson GPIO controller supports
+	  up to 60 GPIOS in total, 4 of which are dedicated GPIO pins, and
+	  the remaining 56 are reused with other functions, with edge or
+	  level triggered interrupts.
+
 config GPIO_LPC18XX
 	tristate "NXP LPC18XX/43XX GPIO support"
 	default y if ARCH_LPC18XX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 29e3beb6548c..fc832484cc77 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
 obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
 obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
 obj-$(CONFIG_GPIO_LOONGSON)		+= gpio-loongson.o
+obj-$(CONFIG_GPIO_LOONGSON_64BIT)	+= gpio-loongson-64bit.o
 obj-$(CONFIG_GPIO_LP3943)		+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LP873X)		+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LP87565)		+= gpio-lp87565.o
diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
new file mode 100644
index 000000000000..19a0149480f8
--- /dev/null
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Loongson GPIO Support
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <linux/of_irq.h>
+#include <asm/types.h>
+
+#define LOONGSON_GPIO_IN(x)		(x->reg_base +\
+					x->p_data->in_offset)
+#define LOONGSON_GPIO_OUT(x)		(x->reg_base +\
+					x->p_data->out_offset)
+#define LOONGSON_GPIO_OEN(x)		(x->reg_base +\
+					x->p_data->conf_offset)
+#define LOONGSON_GPIO_IN_BYTE(x, gpio)	(x->reg_base +\
+					x->p_data->in_offset + gpio)
+#define LOONGSON_GPIO_OUT_BYTE(x, gpio)	(x->reg_base +\
+					x->p_data->out_offset + gpio)
+#define LOONGSON_GPIO_OEN_BYTE(x, gpio)	(x->reg_base +\
+					x->p_data->conf_offset + gpio)
+
+enum loongson_gpio_mode {
+	BIT_CTRL_MODE,
+	BYTE_CTRL_MODE,
+};
+
+struct loongson_gpio_chip_data {
+	const char		*label;
+	enum loongson_gpio_mode	mode;
+	int			conf_offset;
+	int			out_offset;
+	int			in_offset;
+	bool			support_irq;
+};
+
+struct loongson_gpio_chip {
+	struct gpio_chip	chip;
+	struct fwnode_handle	*fwnode;
+	spinlock_t		lock;
+	void __iomem		*reg_base;
+	const struct loongson_gpio_chip_data *p_data;
+};
+
+static inline void loongson_commit_direction(
+				struct loongson_gpio_chip *lgpio,
+				unsigned int pin, int input)
+{
+	u8  bval;
+
+	bval = input ? 1 : 0;
+	writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
+}
+
+static void loongson_commit_level(struct loongson_gpio_chip *lgpio,
+				unsigned int pin, int high)
+{
+	u8 bval;
+
+	bval = high ? 1 : 0;
+	writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
+}
+
+static int loongson_gpio_direction_input(
+				struct gpio_chip *chip, unsigned int pin)
+{
+	unsigned long flags;
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+
+	spin_lock_irqsave(&lgpio->lock, flags);
+	loongson_commit_direction(lgpio, pin, 1);
+	spin_unlock_irqrestore(&lgpio->lock, flags);
+
+	return 0;
+}
+
+static int loongson_gpio_direction_output(
+				struct gpio_chip *chip, unsigned int pin,
+				int value)
+{
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lgpio->lock, flags);
+	loongson_commit_level(lgpio, pin, value);
+	loongson_commit_direction(lgpio, pin, 0);
+	spin_unlock_irqrestore(&lgpio->lock, flags);
+
+	return 0;
+}
+
+static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
+{
+	u8  bval;
+	int val;
+
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+
+	bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
+	val = bval & 1;
+
+	return val;
+}
+
+static int loongson_gpio_get_direction(
+				struct gpio_chip *chip, unsigned int pin)
+{
+	u8  bval;
+	int val;
+
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+
+	bval = readb(LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
+	val = bval & 1;
+
+	return val;
+}
+
+static void loongson_gpio_set(struct gpio_chip *chip, unsigned int pin,
+			int value)
+{
+	unsigned long flags;
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+
+	spin_lock_irqsave(&lgpio->lock, flags);
+	loongson_commit_level(lgpio, pin, value);
+	spin_unlock_irqrestore(&lgpio->lock, flags);
+}
+
+static int loongson_gpio_to_irq(
+			struct gpio_chip *chip, unsigned int offset)
+{
+	struct platform_device *pdev =
+		container_of(chip->parent, struct platform_device, dev);
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	return platform_get_irq(pdev, offset);
+}
+
+static void loongson_gpio_irq_ack(struct irq_data *d)
+{
+	irq_chip_ack_parent(d);
+}
+
+static void loongson_gpio_mask_irq(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	irq_chip_mask_parent(d);
+	gpiochip_disable_irq(gc, d->hwirq);
+}
+
+static void loongson_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_enable_irq(gc, d->hwirq);
+	irq_chip_unmask_parent(d);
+}
+
+static int loongson_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_set_handler_locked(d, handle_edge_irq);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_set_handler_locked(d, handle_edge_irq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_handler_locked(d, handle_level_irq);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler_locked(d, handle_level_irq);
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_set_handler_locked(d, handle_edge_irq);
+		break;
+	case IRQ_TYPE_NONE:
+	default:
+		return -EINVAL;
+	}
+
+	return irq_chip_set_type_parent(d, type);
+}
+
+static const struct irq_chip loongson_gpio_irqchip = {
+	.name = "loongson-gpio-irqchip",
+	.irq_ack = loongson_gpio_irq_ack,
+	.irq_mask = loongson_gpio_mask_irq,
+	.irq_unmask = loongson_gpio_irq_unmask,
+	.irq_set_type = loongson_gpio_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int loongson_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
+					     unsigned int child,
+					     unsigned int child_type,
+					     unsigned int *parent,
+					     unsigned int *parent_type)
+{
+	*parent_type = child_type;
+
+	/* GPIO lines 0..3 have dedicated IRQs */
+	if (child >= 0 && child <= 3) {
+		*parent = child + 60;
+		return 0;
+	}
+
+	if (child >= 4 && child <= 31) {
+		*parent = 58;
+		return 0;
+	}
+
+	if (child >= 32 && child <= 63) {
+		*parent = 59;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int loongson_gpio_init(
+			struct device *dev, struct loongson_gpio_chip *lgpio,
+			struct device_node *np, void __iomem *reg_base)
+{
+	int ret;
+	u32 ngpios;
+	struct irq_domain __maybe_unused *parent;
+	struct gpio_irq_chip __maybe_unused *girq;
+	struct device_node __maybe_unused *irq_parent;
+
+	lgpio->reg_base = reg_base;
+
+	if (lgpio->p_data->mode == BIT_CTRL_MODE) {
+		ret = bgpio_init(&lgpio->chip, dev, 8,
+				LOONGSON_GPIO_IN(lgpio),
+				LOONGSON_GPIO_OUT(lgpio), 0,
+				LOONGSON_GPIO_OEN(lgpio), NULL, 0);
+		if (ret) {
+			dev_err(dev, "unable to init generic GPIO\n");
+			return ret;
+		}
+	} else {
+		lgpio->chip.direction_input = loongson_gpio_direction_input;
+		lgpio->chip.get = loongson_gpio_get;
+		lgpio->chip.get_direction = loongson_gpio_get_direction;
+		lgpio->chip.direction_output = loongson_gpio_direction_output;
+		lgpio->chip.set = loongson_gpio_set;
+		lgpio->chip.can_sleep = 0;
+		lgpio->chip.of_node = np;
+		lgpio->chip.parent = dev;
+		spin_lock_init(&lgpio->lock);
+	}
+
+	device_property_read_u32(dev, "ngpios", &ngpios);
+
+	lgpio->chip.ngpio = ngpios;
+	lgpio->chip.label = lgpio->p_data->label;
+
+	if (lgpio->p_data->support_irq == true) {
+		lgpio->chip.to_irq = loongson_gpio_to_irq;
+		irq_parent = of_irq_find_parent(np);
+		if (irq_parent)
+			parent = irq_find_host(irq_parent);
+
+		lgpio->fwnode = of_node_to_fwnode(np);
+
+		girq = &lgpio->chip.irq;
+		gpio_irq_chip_set_chip(girq, &loongson_gpio_irqchip);
+		girq->fwnode = lgpio->fwnode;
+		girq->parent_domain = parent;
+		girq->child_to_parent_hwirq = loongson_gpio_child_to_parent_hwirq;
+		girq->handler = handle_bad_irq;
+		girq->default_type = IRQ_TYPE_NONE;
+	}
+
+	devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
+
+	return 0;
+}
+
+static int loongson_gpio_probe(struct platform_device *pdev)
+{
+	void __iomem *reg_base;
+	struct loongson_gpio_chip *lgpio;
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+
+	lgpio = devm_kzalloc(dev, sizeof(*lgpio), GFP_KERNEL);
+	if (!lgpio)
+		return -ENOMEM;
+
+	lgpio->p_data = device_get_match_data(&pdev->dev);
+
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
+
+	return loongson_gpio_init(dev, lgpio, np, reg_base);
+}
+
+static const struct loongson_gpio_chip_data loongson_gpio_pdata0 = {
+	.label = "ls2k_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0x10,
+	.out_offset = 0x20,
+	.support_irq = true,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_pdata1 = {
+	.label = "ls7a_gpio",
+	.mode = BYTE_CTRL_MODE,
+	.conf_offset = 0x800,
+	.in_offset = 0x900,
+	.out_offset = 0xa00,
+	.support_irq = false,
+};
+
+static const struct of_device_id loongson_gpio_of_match[] = {
+	{
+		.compatible = "loongson,ls2k-gpio",
+		.data = &loongson_gpio_pdata0,
+	},
+	{
+		.compatible = "loongson,ls7a-gpio",
+		.data = &loongson_gpio_pdata1,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, loongson_gpio_of_match);
+
+static const struct acpi_device_id loongson_gpio_acpi_match[] = {
+	{
+		.id = "LOON0002",
+		.driver_data = (kernel_ulong_t)&loongson_gpio_pdata1,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
+
+static struct platform_driver loongson_gpio_driver = {
+	.driver = {
+		.name = "loongson-gpio",
+		.owner = THIS_MODULE,
+		.of_match_table = loongson_gpio_of_match,
+		.acpi_match_table = loongson_gpio_acpi_match,
+	},
+	.probe = loongson_gpio_probe,
+};
+
+static int __init loongson_gpio_setup(void)
+{
+	return platform_driver_register(&loongson_gpio_driver);
+}
+postcore_initcall(loongson_gpio_setup);
+
+MODULE_DESCRIPTION("Loongson gpio driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

