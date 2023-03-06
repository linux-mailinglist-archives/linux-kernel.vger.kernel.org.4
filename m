Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BC6AB8D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCFIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCFIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:50:24 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBBB113EF;
        Mon,  6 Mar 2023 00:50:21 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 5675620BAA;
        Mon,  6 Mar 2023 09:34:51 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] gpio: fxl6408: add I2C GPIO expander driver
Date:   Mon,  6 Mar 2023 09:34:46 +0100
Message-Id: <20230306083446.41082-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306083446.41082-1-francesco@dolcini.it>
References: <20230306083446.41082-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Support Fairchild (now ON Semiconductor) fxl6408 which has 8 GPIO lines
and is controlled by I2C bus.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/gpio/Kconfig        |   6 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-fxl6408.c | 160 ++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/gpio/gpio-fxl6408.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 13be729710f2..34ed748dba5c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1000,6 +1000,12 @@ config GPIO_ADNP
 	  enough to represent all pins, but the driver will assume a
 	  register layout for 64 pins (8 registers).
 
+config GPIO_FXL6408
+	tristate "FXL6408 I2C GPIO expander"
+	select GPIO_REGMAP
+	help
+	  GPIO driver for Fairchild Semiconductor FXL6408 GPIO expander
+
 config GPIO_GW_PLD
 	tristate "Gateworks PLD GPIO Expander"
 	depends on OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c048ba003367..12027f4c3bee 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_GPIO_EP93XX)		+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXAR)			+= gpio-exar.o
 obj-$(CONFIG_GPIO_F7188X)		+= gpio-f7188x.o
 obj-$(CONFIG_GPIO_FTGPIO010)		+= gpio-ftgpio010.o
+obj-$(CONFIG_GPIO_FXL6408)		+= gpio-fxl6408.o
 obj-$(CONFIG_GPIO_GE_FPGA)		+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)		+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)		+= gpio-grgpio.o
diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
new file mode 100644
index 000000000000..7b28b09c7b66
--- /dev/null
+++ b/drivers/gpio/gpio-fxl6408.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FXL6408 GPIO driver
+ *
+ * Copyright 2023 Toradex
+ *
+ * Author: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
+ *
+ */
+
+#include <linux/gpio.h>
+#include <linux/gpio/regmap.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+#define FXL6408_REG_DEVICE_ID		0x01
+#define FXL6408_MF_FAIRCHILD		0b101
+#define FXL6408_MF_SHIFT		5
+
+/* Bits set here indicate that the GPIO is an output. */
+#define FXL6408_REG_IO_DIR		0x03
+
+/* Bits set here, when the corresponding bit of IO_DIR is set, drive
+ * the output high instead of low.
+ */
+#define FXL6408_REG_OUTPUT		0x05
+
+/* Bits here make the output High-Z, instead of the OUTPUT value. */
+#define FXL6408_REG_OUTPUT_HIGH_Z	0x07
+
+/* Returns the current status (1 = HIGH) of the input pins. */
+#define FXL6408_REG_INPUT_STATUS	0x0f
+
+#define FXL6408_MAX_REGISTER		0x13
+
+#define FXL6408_NGPIO			8
+
+static const struct regmap_range rd_range[] = {
+	{ FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
+	{ FXL6408_REG_IO_DIR, FXL6408_REG_OUTPUT },
+	{ FXL6408_REG_INPUT_STATUS, FXL6408_REG_INPUT_STATUS }
+};
+
+static const struct regmap_range wr_range[] = {
+	{ FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
+	{ FXL6408_REG_IO_DIR, FXL6408_REG_OUTPUT },
+	{ FXL6408_REG_OUTPUT_HIGH_Z, FXL6408_REG_OUTPUT_HIGH_Z }
+};
+
+static const struct regmap_range volatile_range[] = {
+	{ FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
+	{ FXL6408_REG_INPUT_STATUS, FXL6408_REG_INPUT_STATUS }
+};
+
+static const struct regmap_access_table rd_table = {
+	.yes_ranges = rd_range,
+	.n_yes_ranges = ARRAY_SIZE(rd_range)
+};
+
+static const struct regmap_access_table wr_table = {
+	.yes_ranges = wr_range,
+	.n_yes_ranges = ARRAY_SIZE(wr_range)
+};
+
+static const struct regmap_access_table volatile_table = {
+	.yes_ranges = volatile_range,
+	.n_yes_ranges = ARRAY_SIZE(volatile_range)
+};
+
+static const struct regmap_config regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = FXL6408_MAX_REGISTER,
+	.wr_table = &wr_table,
+	.rd_table = &rd_table,
+	.volatile_table = &volatile_table,
+
+	.cache_type = REGCACHE_RBTREE,
+	.num_reg_defaults_raw = FXL6408_MAX_REGISTER + 1
+};
+
+static int fxl6408_identify(struct device *dev, struct regmap *regmap)
+{
+	int val, ret;
+
+	ret = regmap_read(regmap, FXL6408_REG_DEVICE_ID, &val);
+	if (ret) {
+		dev_err(dev, "error %d reading DEVICE_ID\n", ret);
+	} else if (val >> FXL6408_MF_SHIFT != FXL6408_MF_FAIRCHILD) {
+		dev_err(dev, "invalid device id 0x%02x\n", val);
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+static int fxl6408_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	int ret;
+	struct gpio_regmap_config gpio_config = {
+		.parent = dev,
+		.ngpio = FXL6408_NGPIO,
+		.reg_dat_base = GPIO_REGMAP_ADDR(FXL6408_REG_INPUT_STATUS),
+		.reg_set_base = GPIO_REGMAP_ADDR(FXL6408_REG_OUTPUT),
+		.reg_dir_out_base = GPIO_REGMAP_ADDR(FXL6408_REG_IO_DIR),
+		.ngpio_per_reg = FXL6408_NGPIO
+	};
+	gpio_config.regmap = devm_regmap_init_i2c(client, &regmap);
+
+	if (IS_ERR(gpio_config.regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(gpio_config.regmap);
+	}
+
+	ret = fxl6408_identify(dev, gpio_config.regmap);
+	if (ret)
+		return ret;
+
+	/* Disable High-Z of outputs, so that our OUTPUT updates
+	 * actually take effect.
+	 */
+	ret = regmap_write(gpio_config.regmap, FXL6408_REG_OUTPUT_HIGH_Z, 0);
+	if (ret) {
+		dev_err(dev, "failed to write 'output high Z' register\n");
+		return ret;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+}
+
+static const __maybe_unused struct of_device_id fxl6408_dt_ids[] = {
+	{ .compatible = "fcs,fxl6408" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fxl6408_dt_ids);
+
+static const struct i2c_device_id fxl6408_id[] = {
+	{ "fxl6408", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, fxl6408_id);
+
+static struct i2c_driver fxl6408_driver = {
+	.driver = {
+		.name	= "fxl6408",
+		.of_match_table = fxl6408_dt_ids,
+	},
+	.probe_new	= fxl6408_probe,
+	.id_table	= fxl6408_id,
+};
+
+module_i2c_driver(fxl6408_driver);
+
+MODULE_AUTHOR("Emanuele Ghidoli <emanuele.ghidoli@toradex.com>");
+MODULE_DESCRIPTION("FXL6408 GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

