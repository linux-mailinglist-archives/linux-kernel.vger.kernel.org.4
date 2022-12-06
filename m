Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04158644379
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiLFMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiLFMw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:52:27 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC215A29;
        Tue,  6 Dec 2022 04:52:21 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 78B0A60730;
        Tue,  6 Dec 2022 13:45:37 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/2] gpio: max7317: Add gpio expander driver
Date:   Tue,  6 Dec 2022 13:45:28 +0100
Message-Id: <20221206124530.5431-1-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for maxim MAX7317 SPI-Interfaced 10 Port
GPIO Expander.

Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/gpio/Kconfig        |   8 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-max7317.c | 221 ++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/gpio/gpio-max7317.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a01af1180616..24ed968a2b7f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1622,6 +1622,14 @@ config GPIO_MAX7301
 	help
 	  GPIO driver for Maxim MAX7301 SPI-based GPIO expander.
 
+config GPIO_MAX7317
+	tristate "Maxim MAX7317 GPIO expander"
+	depends on SPI
+	help
+	  GPIO driver for Maxim MAX7317 SPI-based GPIO expander.
+	  The MAX7317 is a serial-interfaced gpio extender, with
+	  10 ports.
+
 config GPIO_MC33880
 	tristate "Freescale MC33880 high-side/low-side switch"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 29e3beb6548c..edbfb3d918ce 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_GPIO_MAX7300)		+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)		+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX730X)		+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX732X)		+= gpio-max732x.o
+obj-$(CONFIG_GPIO_MAX7317)		+= gpio-max7317.o
 obj-$(CONFIG_GPIO_MAX77620)		+= gpio-max77620.o
 obj-$(CONFIG_GPIO_MAX77650)		+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MB86S7X)		+= gpio-mb86s7x.o
diff --git a/drivers/gpio/gpio-max7317.c b/drivers/gpio/gpio-max7317.c
new file mode 100644
index 000000000000..58b66f763beb
--- /dev/null
+++ b/drivers/gpio/gpio-max7317.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021, Lukasz Zemla, Woodward Inc.
+ *
+ */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_data/max7317.h>
+
+/* MAX7317 has 10 pins, controlled by 10 internal registers,
+ * addressed as 0x00 - 0x09.
+ */
+#define PIN_NUMBER 10
+
+/* Register code to read inputs from 7 to 0 */
+#define REG_CODE_READ_PORTS_7_TO_0	((u8)0x0E)
+/* Register code to read inputs from 9 to 8 */
+#define REG_CODE_READ_PORTS_9_TO_8	((u8)0x0F)
+
+struct max7317 {
+	struct mutex		lock;
+	struct gpio_chip	chip;
+	struct device		*dev;
+};
+
+struct max7317_platform_data {
+	/* number assigned to the first GPIO */
+	unsigned int	gpio_base;
+};
+
+/* A write to the MAX7317 means one message with one transfer */
+static int max7317_spi_write(struct device *dev, unsigned int reg,
+				unsigned int val)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	u16 word = ((reg & 0x7F) << 8) | (val & 0xFF);
+
+	return spi_write_then_read(spi, &word, sizeof(word), NULL, 0);
+}
+
+/* A read from the MAX7317 means two transfers, with chip select going high between them. */
+static int max7317_spi_read(struct device *dev, unsigned int reg)
+{
+	int ret;
+	u16 word;
+	struct spi_device *spi = to_spi_device(dev);
+
+	word = 0x8000 | (reg << 8);
+
+	/* First transfer: ask to read register */
+	ret = spi_write(spi, &word, sizeof(word));
+	if (ret)
+		return ret;
+
+	/* Second transfer: read register value */
+	ret = spi_read(spi, &word, sizeof(word));
+	if (ret)
+		return ret;
+
+	return word & 0xff;
+}
+
+static void max7317_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+
+	mutex_lock(&ts->lock);
+	max7317_spi_write(ts->dev, offset, value);
+	mutex_unlock(&ts->lock);
+}
+
+static int max7317_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max7317 *ts = gpiochip_get_data(chip);
+	unsigned int reg, val, mask, shift;
+	int inputs;
+
+	if (offset < 8) {
+		reg = REG_CODE_READ_PORTS_7_TO_0;
+		mask = 1u << offset;
+		shift = offset;
+	} else {
+		reg = REG_CODE_READ_PORTS_9_TO_8;
+		mask = 1u << (offset - 8);
+		shift = offset - 8;
+	}
+
+	mutex_lock(&ts->lock);
+	inputs = max7317_spi_read(ts->dev, reg);
+	mutex_unlock(&ts->lock);
+
+	val = ((unsigned int)inputs & mask) >> shift;
+
+	return (int)val;
+}
+
+static int max7317_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	/* Per documentation:
+	 * 'Configure a port as an input by setting its output register to 0x01,
+	 * which sets the port output high impedance (Table 4).
+	 */
+	max7317_set(chip, offset, 1);
+	return 0;
+}
+
+static int max7301_direction_output(struct gpio_chip *chip, unsigned int offset,
+				    int value)
+{
+	max7317_set(chip, offset, value);
+	return 0;
+}
+
+static int max7317_probe(struct spi_device *spi)
+{
+	struct max7317 *ts;
+	struct device *dev;
+	struct max7317_platform_data *pdata;
+	int ret;
+
+	/* bits_per_word cannot be configured in platform data */
+	spi->bits_per_word = 16;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	ts = devm_kzalloc(&spi->dev, sizeof(struct max7317), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->dev = &spi->dev;
+
+	dev = ts->dev;
+
+	pdata = dev_get_platdata(dev);
+
+	mutex_init(&ts->lock);
+	dev_set_drvdata(dev, ts);
+
+	if (pdata)
+		ts->chip.base = pdata->gpio_base;
+	else
+		ts->chip.base = -1;
+
+	ts->chip.label = dev->driver->name;
+
+	ts->chip.direction_input = max7317_direction_input;
+	ts->chip.get = max7317_get;
+	ts->chip.direction_output = max7301_direction_output;
+	ts->chip.set = max7317_set;
+
+	ts->chip.ngpio = PIN_NUMBER;
+	ts->chip.can_sleep = true;
+	ts->chip.parent = dev;
+	ts->chip.owner = THIS_MODULE;
+
+	ret = gpiochip_add_data(&ts->chip, ts);
+	if (!ret)
+		return ret;
+
+	mutex_destroy(&ts->lock);
+	return ret;
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
+	mutex_destroy(&ts->lock);
+}
+
+static const struct spi_device_id max7317_id[] = {
+	{ "max7317", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max7317_id);
+
+static const struct of_device_id max7317_of_table[] = {
+	{ .compatible = "maxim,max7317" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max7317_of_table);
+
+static struct spi_driver max7317_driver = {
+	.driver = {
+		.name = "max7317",
+		.of_match_table	= of_match_ptr(max7317_of_table),
+	},
+	.probe = max7317_probe,
+	.remove = max7317_remove,
+	.id_table = max7317_id,
+};
+
+static int __init max7317_init(void)
+{
+	return spi_register_driver(&max7317_driver);
+}
+/* register after spi postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(max7317_init);
+
+static void __exit max7317_exit(void)
+{
+	spi_unregister_driver(&max7317_driver);
+}
+module_exit(max7317_exit);
+
+MODULE_AUTHOR("Lukasz Zemla");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MAX7317 GPIO-Expander");
-- 
2.37.4

