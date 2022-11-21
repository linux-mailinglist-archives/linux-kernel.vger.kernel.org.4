Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654D632268
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiKUMi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKUMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:38:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FAA7AD471;
        Mon, 21 Nov 2022 04:38:15 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Axjrc2cXtjYRoJAA--.20443S3;
        Mon, 21 Nov 2022 20:38:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuAwcXtjXpkXAA--.61043S3;
        Mon, 21 Nov 2022 20:38:13 +0800 (CST)
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
Subject: [PATCH v5 2/3] gpio: loongson: add gpio driver support
Date:   Mon, 21 Nov 2022 20:38:02 +0800
Message-Id: <20221121123803.3786-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221121123803.3786-1-zhuyinbo@loongson.cn>
References: <20221121123803.3786-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuAwcXtjXpkXAA--.61043S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfGw1kWF1rCr1UCr13Ww1rWFg_yoW8JF1rCo
        W7WFZ8W3y8Xr17X3WFqFyFqFW7ZFn0qF40ywn2yFs8Gan8t3s8try3G3y3XFyFvFyFqFyx
        ZFyfur4fGFZ7tFs8n29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_
        Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU2iFxUUUUU
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

 MAINTAINERS                  |   7 +
 drivers/gpio/Kconfig         |  10 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-loongson.c | 306 +++++++++++++++++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/gpio/gpio-loongson.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b80a64b70b9..47721a25249f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12048,6 +12048,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
+LOONGSON GPIO DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-loongson.c
+F:	include/linux/platform_data/gpio-loongson.h
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bc55b80f212a..3986b471647d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -375,6 +375,16 @@ config GPIO_LOGICVC
 	  Say yes here to support GPIO functionality of the Xylon LogiCVC
 	  programmable logic block.
 
+config GPIO_LOONGSON
+	tristate "Loongson GPIO support"
+	depends on LOONGARCH || COMPILE_TEST
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
index cfd298e00737..29e3beb6548c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
 obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
 obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
+obj-$(CONFIG_GPIO_LOONGSON)		+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)		+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LP873X)		+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LP87565)		+= gpio-lp87565.o
diff --git a/drivers/gpio/gpio-loongson.c b/drivers/gpio/gpio-loongson.c
new file mode 100644
index 000000000000..9fb65ba2c4bd
--- /dev/null
+++ b/drivers/gpio/gpio-loongson.c
@@ -0,0 +1,306 @@
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
+#include <asm/types.h>
+
+#define LOONGSON_GPIO_IN(x)		(x->base + x->p_data->in_offset)
+#define LOONGSON_GPIO_OUT(x)		(x->base + x->p_data->out_offset)
+#define LOONGSON_GPIO_OEN(x)		(x->base + x->p_data->conf_offset)
+
+#define LOONGSON_GPIO_IN_BYTE(x, gpio)	(x->base +\
+					x->p_data->in_offset + gpio)
+#define LOONGSON_GPIO_OUT_BYTE(x, gpio)	(x->base +\
+					x->p_data->out_offset + gpio)
+#define LOONGSON_GPIO_OEN_BYTE(x, gpio)	(x->base +\
+					x->p_data->conf_offset + gpio)
+
+enum loongson_gpio_mode {
+	BIT_CTRL_MODE,
+	BYTE_CTRL_MODE,
+};
+
+struct loongson_gpio_platform_data {
+	const char		*label;
+	enum loongson_gpio_mode	mode;
+	int			conf_offset;
+	int			out_offset;
+	int			in_offset;
+};
+
+struct loongson_gpio_chip {
+	struct gpio_chip	chip;
+	spinlock_t		lock;
+	void __iomem		*base;
+	u16			*gsi_idx_map;
+	u16			mapsize;
+	const struct loongson_gpio_platform_data *p_data;
+};
+
+static int loongson_gpio_request(
+			struct gpio_chip *chip, unsigned int pin)
+{
+	if (pin >= chip->ngpio)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void __set_direction(struct loongson_gpio_chip *lgpio,
+			unsigned int pin, int input)
+{
+	u64 qval;
+	u8  bval;
+
+	if (lgpio->p_data->mode == BIT_CTRL_MODE) {
+		qval = readq(LOONGSON_GPIO_OEN(lgpio));
+		if (input)
+			qval |= 1ULL << pin;
+		else
+			qval &= ~(1ULL << pin);
+		writeq(qval, LOONGSON_GPIO_OEN(lgpio));
+	} else {
+		bval = input ? 1 : 0;
+		writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
+	}
+}
+
+static void __set_level(struct loongson_gpio_chip *lgpio, unsigned int pin,
+			int high)
+{
+	u64 qval;
+	u8 bval;
+
+	if (lgpio->p_data->mode == BIT_CTRL_MODE) {
+		qval = readq(LOONGSON_GPIO_OUT(lgpio));
+		if (high)
+			qval |= 1ULL << pin;
+		else
+			qval &= ~(1ULL << pin);
+		writeq(qval, LOONGSON_GPIO_OUT(lgpio));
+	} else {
+		bval = high ? 1 : 0;
+		writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
+	}
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
+	__set_direction(lgpio, pin, 1);
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
+	__set_level(lgpio, pin, value);
+	__set_direction(lgpio, pin, 0);
+	spin_unlock_irqrestore(&lgpio->lock, flags);
+
+	return 0;
+}
+
+static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
+{
+	u64 qval;
+	u8  bval;
+	int val;
+
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+
+	if (lgpio->p_data->mode == BIT_CTRL_MODE) {
+		qval = readq(LOONGSON_GPIO_IN(lgpio));
+		val = (qval & (1ULL << pin)) != 0;
+	} else {
+		bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
+		val = bval & 1;
+	}
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
+	__set_level(lgpio, pin, value);
+	spin_unlock_irqrestore(&lgpio->lock, flags);
+}
+
+static int loongson_gpio_to_irq(
+			struct gpio_chip *chip, unsigned int offset)
+{
+	struct platform_device *pdev =
+		container_of(chip->parent, struct platform_device, dev);
+	struct loongson_gpio_chip *lgpio =
+		container_of(chip, struct loongson_gpio_chip, chip);
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	if ((lgpio->gsi_idx_map != NULL) && (offset < lgpio->mapsize))
+		offset = lgpio->gsi_idx_map[offset];
+	else
+		return -EINVAL;
+
+	return platform_get_irq(pdev, offset);
+}
+
+static int loongson_gpio_init(
+			struct device *dev, struct loongson_gpio_chip *lgpio,
+			struct device_node *np, void __iomem *base)
+{
+	lgpio->chip.request = loongson_gpio_request;
+	lgpio->chip.direction_input = loongson_gpio_direction_input;
+	lgpio->chip.get = loongson_gpio_get;
+	lgpio->chip.direction_output = loongson_gpio_direction_output;
+	lgpio->chip.set = loongson_gpio_set;
+	lgpio->chip.can_sleep = 0;
+	lgpio->chip.of_node = np;
+	lgpio->chip.parent = dev;
+	lgpio->chip.label = lgpio->p_data->label;
+	spin_lock_init(&lgpio->lock);
+	lgpio->base = (void __iomem *)base;
+	lgpio->chip.to_irq = loongson_gpio_to_irq;
+
+	devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
+
+	return 0;
+}
+
+static void loongson_gpio_get_props(struct platform_device *pdev,
+				  struct loongson_gpio_chip *lgpio)
+{
+	int rval;
+	u32 ngpios;
+	struct device *dev = &pdev->dev;
+
+	device_property_read_u32(dev, "ngpios", &ngpios);
+	lgpio->chip.ngpio = ngpios;
+
+	rval = device_property_read_u16_array(dev, "gsi_idx_map", NULL, 0);
+	if (rval > 0) {
+		lgpio->gsi_idx_map =
+			devm_kmalloc_array(dev, rval, sizeof(*lgpio->gsi_idx_map),
+					GFP_KERNEL);
+		if (lgpio->gsi_idx_map) {
+			lgpio->mapsize = rval;
+			device_property_read_u16_array(dev, "gsi_idx_map",
+					lgpio->gsi_idx_map, lgpio->mapsize);
+		}
+	}
+}
+
+static int loongson_gpio_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct loongson_gpio_chip *lgpio;
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+
+	lgpio = devm_kzalloc(dev, sizeof(*lgpio), GFP_KERNEL);
+	if (!lgpio)
+		return -ENOMEM;
+
+	loongson_gpio_get_props(pdev, lgpio);
+
+	lgpio->p_data = device_get_match_data(&pdev->dev);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	platform_set_drvdata(pdev, lgpio);
+
+	loongson_gpio_init(dev, lgpio, np, base);
+
+	return 0;
+}
+
+static const struct loongson_gpio_platform_data loongson_gpio_pdata0 = {
+	.label = "ls2k_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0x10,
+	.out_offset = 0x20,
+};
+
+static const struct loongson_gpio_platform_data loongson_gpio_pdata1 = {
+	.label = "ls7a_gpio",
+	.mode = BYTE_CTRL_MODE,
+	.conf_offset = 0x800,
+	.in_offset = 0x900,
+	.out_offset = 0xa00,
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
2.33.0

