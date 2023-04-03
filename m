Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A319F6D43B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjDCLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDCLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:41:04 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC246BD;
        Mon,  3 Apr 2023 04:41:02 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 06C785F71F;
        Mon,  3 Apr 2023 13:41:01 +0200 (CEST)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpio: max7317: Add gpio expander driver
Date:   Mon,  3 Apr 2023 13:40:32 +0200
Message-Id: <20230403114033.8336-2-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403114033.8336-1-edmund.berenson@emlix.com>
References: <20230403114033.8336-1-edmund.berenson@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for maxim MAX7317 SPI-Interfaced 10 Port
GPIO Expander.

v2: adjust driver to use regmap

Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/gpio/Kconfig        |  11 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-max7317.c | 161 ++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/gpio/gpio-max7317.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 13be729710f2..109cf09d8c05 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1615,6 +1615,17 @@ config GPIO_MAX7301
 	help
 	  GPIO driver for Maxim MAX7301 SPI-based GPIO expander.
 
+config GPIO_MAX7317
+	tristate "Maxim MAX7317 GPIO expander"
+	select REGMAP_SPI
+	help
+	  GPIO driver for Maxim MAX7317 SPI-based GPIO expander.
+	  The MAX7317 is a serial-interfaced gpio extender, with
+	  10 ports.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-max7317.
+
 config GPIO_MC33880
 	tristate "Freescale MC33880 high-side/low-side switch"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c048ba003367..8dce549bb6c5 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_GPIO_MAX7300)		+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)		+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX730X)		+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX732X)		+= gpio-max732x.o
+obj-$(CONFIG_GPIO_MAX7317)		+= gpio-max7317.o
 obj-$(CONFIG_GPIO_MAX77620)		+= gpio-max77620.o
 obj-$(CONFIG_GPIO_MAX77650)		+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MB86S7X)		+= gpio-mb86s7x.o
diff --git a/drivers/gpio/gpio-max7317.c b/drivers/gpio/gpio-max7317.c
new file mode 100644
index 000000000000..65824efaad6c
--- /dev/null
+++ b/drivers/gpio/gpio-max7317.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021, Lukasz Zemla, Woodward Inc.
+ */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#define MAX7317_PIN_NUMBER 10
+#define REG_CODE_READ_PORTS_7_TO_0	((u8)0x0E)
+#define REG_CODE_READ_PORTS_9_TO_8	((u8)0x0F)
+
+struct max7317 {
+	struct gpio_chip	chip;
+	struct regmap		*regmap;
+	int			direction[MAX7317_PIN_NUMBER];
+};
+
+struct max7317_platform_data {
+	unsigned int	gpio_base;
+};
+
+static const struct regmap_config max7317_regmap_cfg =  {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int max7317_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+	unsigned int val;
+	int ret;
+	u8 reg = (offset < 8) ? REG_CODE_READ_PORTS_7_TO_0 : REG_CODE_READ_PORTS_9_TO_8;
+
+	ret = regmap_read(ts->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	return val & BIT(offset % 8);
+}
+
+/*
+ * After writing the register an additional read is performed in order for
+ * changes to take effect.
+ */
+static void max7317_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+
+	if (regmap_write(ts->regmap, offset, value ? 1 : 0))
+		dev_err(chip->parent, "Failed to set pin: %d\n", offset);
+	max7317_get(chip, offset);
+}
+
+static int max7317_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+
+	max7317_set(chip, offset, 1);
+	ts->direction[offset] = GPIO_LINE_DIRECTION_IN;
+	return 0;
+}
+
+static int max7317_direction_output(struct gpio_chip *chip, unsigned int offset,
+				    int value)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+
+	ts->direction[offset] = GPIO_LINE_DIRECTION_OUT;
+	return 0;
+}
+
+static int max7317_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+
+	return ts->direction[offset];
+}
+
+static int max7317_probe(struct spi_device *spi)
+{
+	struct max7317 *ts;
+	struct device *dev;
+	struct max7317_platform_data *pdata;
+	int i;
+
+	ts = devm_kzalloc(&spi->dev, sizeof(struct max7317), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+	dev_set_drvdata(&spi->dev, ts);
+
+	pdata = dev_get_platdata(dev);
+	if (pdata)
+		ts->chip.base = pdata->gpio_base;
+	else
+		ts->chip.base = -1;
+
+	ts->chip.label = dev_name(&spi->dev);
+	ts->chip.direction_input = max7317_direction_input;
+	ts->chip.get = max7317_get;
+	ts->chip.direction_output = max7317_direction_output;
+	ts->chip.set = max7317_set;
+	ts->chip.get_direction = max7317_get_direction;
+
+	ts->chip.ngpio = MAX7317_PIN_NUMBER;
+	ts->chip.can_sleep = true;
+	ts->chip.parent = &spi->dev;
+	ts->chip.owner = THIS_MODULE;
+
+	for (i = 0; i < MAX7317_PIN_NUMBER; i++)
+		ts->direction[i] = GPIO_LINE_DIRECTION_IN;
+
+	ts->regmap = devm_regmap_init_spi(spi, &max7317_regmap_cfg);
+	if (IS_ERR(ts->regmap))
+		return PTR_ERR(ts->regmap);
+
+	return devm_gpiochip_add_data(&spi->dev, &ts->chip, ts);
+}
+
+static void max7317_remove(struct spi_device *spi)
+{
+	struct max7317 *ts = dev_get_drvdata(&spi->dev);
+
+	if (!ts)
+		return;
+
+	gpiochip_remove(&ts->chip);
+}
+
+static const struct spi_device_id max7317_id[] = {
+	{ "max7317", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max7317_id);
+
+static const struct of_device_id max7317_dt_ids[] = {
+	{ .compatible = "maxim,max7317" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max7317_dt_ids);
+
+static struct spi_driver max7317_driver = {
+	.driver = {
+		.name = "max7317",
+		.of_match_table	= max7317_dt_ids,
+	},
+	.probe = max7317_probe,
+	.remove = max7317_remove,
+	.id_table = max7317_id,
+};
+module_spi_driver(max7317_driver);
+
+MODULE_AUTHOR("Lukasz Zemla");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MAX7317 GPIO-Expander");
-- 
2.39.2

