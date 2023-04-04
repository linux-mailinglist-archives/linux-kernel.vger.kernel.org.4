Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07686D5B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjDDJIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjDDJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:08:10 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2E136;
        Tue,  4 Apr 2023 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680599278;
  x=1712135278;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=//l1anF0ErG+9eF77MZU7maawnQRHoL2bQ8f9i6FqaE=;
  b=bLMP9jd1JuXbTp9lfKKjAUru0ME3NQhQY0+RBdCt89MRMtdQ5GEoX7DK
   0rEn4ELmTLIvROkCaf8zryxttPARQphT4FQRfHtVH3XRYG6h+DnIOzonY
   imzkeHm8DytrYrKEAoycYderL/HGDcUifhh0i70LS1izGSp15qDB4LwPJ
   wSjnVMOIKpkDh3akWjRFDMiigs8dqCZNGuLa/I/K+eT8KJP2LxPpcvzV3
   P7hFldDDjg/ZGtrHuqHW2XX3B2X2w8zeeLL/nV819piQTYkPhLu/KYsce
   N5dRgkrCDxCLxuXQwuqQcTkrPI6A70qxs+pU9Lt8KUppAUPJO7OmKfuwA
   w==;
From:   Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Date:   Tue, 4 Apr 2023 11:07:43 +0200
Subject: [PATCH 2/2] iio: light: Add support for TI OPT4001 light sensor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230323-add-opt4001-driver-v1-2-1451dcc1bc8a@axis.com>
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
In-Reply-To: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses the continuous mode of the chip and integration
time can be configured through sysfs.
The constants for calculating lux value differs between packaging
so it uses different compatible string for the two versions
"ti,opt4001-picostar" and "ti,opt4001-sot-5x3" since the device id
is the same.

Datasheet: https://www.ti.com/lit/gpn/opt4001
Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
---
 drivers/iio/light/Kconfig   |  11 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/opt4001.c | 487 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 499 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..c4064fb35f1f 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -399,6 +399,17 @@ config OPT3001
 	  If built as a dynamically linked module, it will be called
 	  opt3001.
 
+config OPT4001
+	tristate "Texas Instruments OPT4001 Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say Y or M here, you get support for Texas Instruments
+	  OPT4001 Ambient Light Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  opt4001.
+
 config PA12203001
 	tristate "TXC PA12203001 light and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6f23817fae6f..4e0a908948db 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MAX44000)		+= max44000.o
 obj-$(CONFIG_MAX44009)		+= max44009.o
 obj-$(CONFIG_NOA1305)		+= noa1305.o
 obj-$(CONFIG_OPT3001)		+= opt3001.o
+obj-$(CONFIG_OPT4001)		+= opt4001.o
 obj-$(CONFIG_PA12203001)	+= pa12203001.o
 obj-$(CONFIG_RPR0521)		+= rpr0521.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
new file mode 100644
index 000000000000..1ddcb10e997b
--- /dev/null
+++ b/drivers/iio/light/opt4001.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Axis Communications AB
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/opt4001
+ *
+ * Device driver for the Texas Instruments OPT4001.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+/* OPT4001 register set */
+#define OPT4001_LIGHT1_MSB    0x00
+#define OPT4001_LIGHT1_LSB    0x01
+#define OPT4001_CTRL          0x0A
+#define OPT4001_DEVICE_ID     0x11
+
+/* OPT4001 register mask */
+#define OPT4001_EXPONENT_MASK    GENMASK(15, 12)
+#define OPT4001_MSB_MASK         GENMASK(11, 0)
+#define OPT4001_LSB_MASK         GENMASK(15, 8)
+#define OPT4001_COUNTER_MASK     GENMASK(7, 4)
+#define OPT4001_CRC_MASK         GENMASK(3, 0)
+
+/* OPT4001 device id mask */
+#define OPT4001_DEVICE_ID_MASK   GENMASK(11, 0)
+
+/* OPT4001 control registers mask */
+#define OPT4001_CTRL_QWAKE_MASK          GENMASK(15, 15)
+#define OPT4001_CTRL_RANGE_MASK          GENMASK(13, 10)
+#define OPT4001_CTRL_CONV_TIME_MASK      GENMASK(9, 6)
+#define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
+#define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
+#define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
+#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
+
+/* OPT4001 constants */
+#define OPT4001_DEVICE_ID_VAL            0x121
+/* OPT4001 needs different constants to calculate lux for different packaging */
+#define OPT4001_PICOSTAR_MUL_CONST       3125
+#define OPT4001_SOT_5x3_MUL_CONST        4375
+#define OPT4001_PACKAGE_DIV_CONST        10000000
+
+/* OPT4001 operating modes */
+#define OPT4001_CTRL_OPER_MODE_OFF        0x0
+#define OPT4001_CTRL_OPER_MODE_FORCED     0x1
+#define OPT4001_CTRL_OPER_MODE_ONE_SHOT   0x2
+#define OPT4001_CTRL_OPER_MODE_CONTINUOUS 0x3
+
+/* OPT4001 conversion control register definitions */
+#define OPT4001_CTRL_CONVERSION_0_6MS   0x0
+#define OPT4001_CTRL_CONVERSION_1MS     0x1
+#define OPT4001_CTRL_CONVERSION_1_8MS   0x2
+#define OPT4001_CTRL_CONVERSION_3_4MS   0x3
+#define OPT4001_CTRL_CONVERSION_6_5MS   0x4
+#define OPT4001_CTRL_CONVERSION_12_7MS  0x5
+#define OPT4001_CTRL_CONVERSION_25MS    0x6
+#define OPT4001_CTRL_CONVERSION_50MS    0x7
+#define OPT4001_CTRL_CONVERSION_100MS   0x8
+#define OPT4001_CTRL_CONVERSION_200MS   0x9
+#define OPT4001_CTRL_CONVERSION_400MS   0xa
+#define OPT4001_CTRL_CONVERSION_800MS   0xb
+
+/* OPT4001 scale light level range definitions */
+#define OPT4001_CTRL_LIGHT_SCALE_AUTO   12
+
+/* OPT4001 default values */
+#define OPT4001_DEFAULT_CONVERSION_TIME OPT4001_CTRL_CONVERSION_800MS
+
+struct opt4001_package_const {
+	int mul;
+	int div;
+};
+
+struct opt4001_settings {
+	/* Index of the chosen integration time */
+	u8 int_time;
+	u8 chip_type;
+};
+
+struct opt4001_chip {
+	struct opt4001_settings light_settings;
+	struct regmap *regmap;
+	struct i2c_client *client;
+	const struct opt4001_package_const *package_constants;
+	/*
+	 * Keep light_settings in sync with hardware state
+	 * and ensure multiple readers are serialized.
+	 */
+	struct mutex als_mutex;
+};
+
+static const struct opt4001_package_const opt4001_sot_5x3_const = {
+	.mul = OPT4001_SOT_5x3_MUL_CONST,
+	.div = OPT4001_PACKAGE_DIV_CONST,
+};
+
+static const struct opt4001_package_const opt4001_picostar_const = {
+	.mul = OPT4001_PICOSTAR_MUL_CONST,
+	.div = OPT4001_PACKAGE_DIV_CONST,
+};
+
+static const int opt4001_int_time_available[][2] = {
+	{ 0,    600 },
+	{ 0,   1000 },
+	{ 0,   1800 },
+	{ 0,   3400 },
+	{ 0,   6500 },
+	{ 0,  12700 },
+	{ 0,  25000 },
+	{ 0,  50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 400000 },
+	{ 0, 800000 },
+};
+
+/*
+ * Conversion time is integration time + time to set register
+ * this is used as integration time.
+ */
+static const int opt4001_int_time_reg[][2] = {
+	{    600,  OPT4001_CTRL_CONVERSION_0_6MS  },
+	{   1000,  OPT4001_CTRL_CONVERSION_1MS    },
+	{   1800,  OPT4001_CTRL_CONVERSION_1_8MS  },
+	{   3400,  OPT4001_CTRL_CONVERSION_3_4MS  },
+	{   6500,  OPT4001_CTRL_CONVERSION_6_5MS  },
+	{  12700,  OPT4001_CTRL_CONVERSION_12_7MS },
+	{  25000,  OPT4001_CTRL_CONVERSION_25MS   },
+	{  50000,  OPT4001_CTRL_CONVERSION_50MS   },
+	{ 100000,  OPT4001_CTRL_CONVERSION_100MS  },
+	{ 200000,  OPT4001_CTRL_CONVERSION_200MS  },
+	{ 400000,  OPT4001_CTRL_CONVERSION_400MS  },
+	{ 800000,  OPT4001_CTRL_CONVERSION_800MS  },
+};
+
+static int opt4001_als_time_to_index(const u32 als_integration_time)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(opt4001_int_time_available); i++) {
+		if (als_integration_time == opt4001_int_time_available[i][1])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int opt4001_calculate_crc(int exp, int mantissa, int count)
+{
+	int crc;
+
+	crc = (hweight32(mantissa) + hweight32(exp) + hweight32(count)) % 2;
+	crc |= ((hweight32(mantissa & 0xAAAAA) + hweight32(exp & 0xA)
+		 + hweight32(count & 0xA)) % 2) << 1;
+	crc |= ((hweight32(mantissa & 0x88888) + hweight32(exp & 0x8)
+		 + hweight32(count & 0x8)) % 2) << 2;
+	crc |= (hweight32(mantissa & 0x80808) % 2) << 3;
+	return crc;
+}
+
+static int opt4001_read_lux_value(struct iio_dev *indio_dev,
+				  int *val, int *val2)
+{
+	struct opt4001_chip *chip = iio_priv(indio_dev);
+	struct device *dev = &chip->client->dev;
+	uint light1;
+	uint light2;
+	uint msb;
+	uint lsb;
+	uint exp;
+	uint count;
+	uint crc;
+	uint calc_crc;
+	unsigned long long lux_raw;
+	int ret;
+
+	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read data bytes");
+		return ret;
+	}
+
+	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_LSB, &light2);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read data bytes");
+		return ret;
+	}
+
+	count = (OPT4001_COUNTER_MASK & light2) >> 4;
+	exp = (OPT4001_EXPONENT_MASK & light1) >> 12;
+	crc = (OPT4001_CRC_MASK & light2);
+	msb = (OPT4001_MSB_MASK & light1);
+	lsb = (OPT4001_LSB_MASK & light2) >> 8;
+	lux_raw = (msb << 8) + lsb;
+	calc_crc = opt4001_calculate_crc(exp, lux_raw, count);
+	if (calc_crc != crc)
+		return -EIO;
+
+	lux_raw = lux_raw << exp;
+	lux_raw = lux_raw * chip->package_constants->mul;
+	*val = div_u64_rem(lux_raw, chip->package_constants->div, val2);
+	*val2 = *val2 * 100;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int opt4001_set_conf(struct opt4001_chip *chip)
+{
+	struct opt4001_settings light_settings = chip->light_settings;
+	struct device *dev = &chip->client->dev;
+	u16 reg;
+	int ret;
+
+	reg = FIELD_PREP(OPT4001_CTRL_RANGE_MASK, OPT4001_CTRL_LIGHT_SCALE_AUTO);
+	reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, light_settings.int_time);
+	reg |= FIELD_PREP(OPT4001_CTRL_OPER_MODE_MASK, OPT4001_CTRL_OPER_MODE_CONTINUOUS);
+
+	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
+	if (ret)
+		dev_err(dev, "Failed to set configuration\n");
+
+	return ret;
+}
+
+static int opt4001_power_down(struct opt4001_chip *chip)
+{
+	int ret;
+	struct device *dev = &chip->client->dev;
+	uint reg;
+
+	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
+	if (ret) {
+		dev_err(dev, "Failed to read configuration\n");
+		return ret;
+	}
+
+	/* MODE_OFF is 0x0 so just set bits to 0 */
+	reg &= ~OPT4001_CTRL_OPER_MODE_MASK;
+
+	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
+	if (ret)
+		dev_err(dev, "Failed to set configuration to power down\n");
+
+	return ret;
+}
+
+static const struct iio_chan_spec opt4001_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+};
+
+static int opt4001_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct opt4001_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&chip->als_mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = opt4001_read_lux_value(indio_dev, val, val2);
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		*val2 = opt4001_int_time_reg[chip->light_settings.int_time][0];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&chip->als_mutex);
+
+	return ret;
+}
+
+static int opt4001_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct opt4001_chip *chip = iio_priv(indio_dev);
+	int int_time;
+	int ret = 0;
+
+	mutex_lock(&chip->als_mutex);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		int_time = opt4001_als_time_to_index(val2);
+		if (int_time < 0) {
+			ret = int_time;
+		} else {
+			chip->light_settings.int_time = int_time;
+			ret = opt4001_set_conf(chip);
+		}
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+
+	mutex_unlock(&chip->als_mutex);
+	return ret;
+}
+
+static int opt4001_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(opt4001_int_time_available) * 2;
+		*vals = (const int *)opt4001_int_time_available;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info opt4001_info_no_irq = {
+	.read_raw = opt4001_read_raw,
+	.write_raw = opt4001_write_raw,
+	.read_avail = opt4001_read_available,
+};
+
+static int opt4001_load_defaults(struct opt4001_chip *chip)
+{
+	chip->light_settings.int_time = OPT4001_DEFAULT_CONVERSION_TIME;
+
+	return opt4001_set_conf(chip);
+}
+
+static bool opt4001_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case OPT4001_LIGHT1_MSB:
+	case OPT4001_LIGHT1_LSB:
+	case OPT4001_CTRL:
+	case OPT4001_DEVICE_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool opt4001_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case OPT4001_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool opt4001_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case OPT4001_LIGHT1_MSB:
+	case OPT4001_LIGHT1_LSB:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config opt4001_regmap_config = {
+	.name = "opt4001",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = OPT4001_DEVICE_ID,
+	.readable_reg = opt4001_readable_reg,
+	.writeable_reg = opt4001_writable_reg,
+	.volatile_reg = opt4001_volatile_reg,
+	.disable_locking = true,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+/*
+ * The compatible string determines which constants to use depending on
+ * opt4001 packaging
+ */
+static const struct of_device_id opt4001_of_match[] = {
+	{ .compatible = "ti,opt4001-sot-5x3", .data = &opt4001_sot_5x3_const},
+	{ .compatible = "ti,opt4001-picostar", .data = &opt4001_picostar_const},
+	{}
+};
+MODULE_DEVICE_TABLE(of, opt4001_of_match);
+
+static int opt4001_probe(struct i2c_client *client)
+{
+	struct opt4001_chip *chip;
+	struct iio_dev *indio_dev;
+	const struct of_device_id *of_id;
+	int ret;
+	uint dev_id;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+
+	chip->regmap = devm_regmap_init_i2c(client, &opt4001_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
+				     "regmap initialization failed\n");
+
+	i2c_set_clientdata(client, indio_dev);
+	chip->client = client;
+
+	indio_dev->info = &opt4001_info_no_irq;
+
+	mutex_init(&chip->als_mutex);
+
+	ret = regmap_reinit_cache(chip->regmap, &opt4001_regmap_config);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to reinit regmap cache\n");
+
+	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &dev_id);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+			"Failed to read the device ID register\n");
+
+	dev_id = FIELD_GET(OPT4001_DEVICE_ID_MASK, dev_id);
+	if (dev_id != OPT4001_DEVICE_ID_VAL) {
+		dev_err(&client->dev, "Device ID: %#04x unknown\n", dev_id);
+		return -EINVAL;
+	}
+
+	indio_dev->channels = opt4001_channels;
+	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = chip->client->name;
+
+	of_id = of_match_device(of_match_ptr(opt4001_of_match), &client->dev);
+	chip->package_constants = of_id->data;
+
+	ret = opt4001_load_defaults(chip);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to set sensor defaults\n");
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static void opt4001_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct opt4001_chip *chip = iio_priv(indio_dev);
+
+	opt4001_power_down(chip);
+}
+
+static struct i2c_driver opt4001_driver = {
+	.driver = {
+		.name = "opt4001",
+		.of_match_table = of_match_ptr(opt4001_of_match),
+	},
+	.probe_new = opt4001_probe,
+	.remove = opt4001_remove
+};
+module_i2c_driver(opt4001_driver);
+
+MODULE_AUTHOR("Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>");
+MODULE_DESCRIPTION("Texas Instruments opt4001 ambient light sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.30.2

