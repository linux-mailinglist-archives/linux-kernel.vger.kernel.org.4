Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558F5FC800
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJLPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:12:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647F62E2;
        Wed, 12 Oct 2022 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665587538; x=1697123538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SUYi4TMpBxcHszfJZ8Qbam9NgSnoY0Kr/kt/m4uSq0M=;
  b=f3S0LcRwPoWsjZpCLzmhvGGc3eMk6TxopdRpbDYWO/QFMm3XSNPpljVt
   uSMBixWVfV35gEhX9TkyYMDfZC6JZf+4YhVNK3HYNPufgNX9N61qARR56
   5Noa+rBvg6N54bmU2keX6L48XbcuJUhcDZbQ6vMXeEzcD7vQQfeKMptVb
   GxKPA5z2udIvO1lZSG6hxTnh4xjkIlZtbjZk9I24ZJZkErac6EW3i2uMl
   14I11YijxMeLIhqv4FdDT5pyj+vLt3uPDZlSmvlgeT74/wOEk0q2SZ208
   ++/U+WezJvp5uldIUaTw14rCGDgYd/XVYj2mFFD7Izr718IpOCqk48uTD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="306446688"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="306446688"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:12:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="801874018"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="801874018"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:12:00 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] iio: temperature: Add driver support for Maxim MAX30208
Date:   Thu, 13 Oct 2022 20:42:03 +0530
Message-Id: <20221013151203.406113-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim MAX30208 is a digital temperature sensor with 0.1°C accuracy.
Add support for max30208 driver in iio subsystem.

Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---
 MAINTAINERS                        |   6 +
 drivers/iio/temperature/Kconfig    |  10 ++
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max30208.c | 273 +++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 drivers/iio/temperature/max30208.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f1390b8270b2..7f1fd2e31b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12373,6 +12373,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
 F:	drivers/regulator/max20086-regulator.c
 
+MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
+M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/temperature/max30208.c
+
 MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index e8ed849e3b76..ed384f33e0c7 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -128,6 +128,16 @@ config TSYS02D
 	  This driver can also be built as a module. If so, the module will
 	  be called tsys02d.
 
+config MAX30208
+	tristate "Maxim MAX30208 digital temperature sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for Maxim MAX30208
+	  digital temperature sensor connected via I2C.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max30208.
+
 config MAX31856
 	tristate "MAX31856 thermocouple sensor"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index dd08e562ffe0..dfec8c6d3019 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
 obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
+obj-$(CONFIG_MAX30208) += max30208.o
 obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
new file mode 100644
index 000000000000..e16c31621065
--- /dev/null
+++ b/drivers/iio/temperature/max30208.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
+ *
+ * Maxim MAX30208 digital temperature sensor with 0.1°C accuracy
+ * (7-bit I2C slave address (0x50 - 0x53))
+ *
+ * Note: This driver sets GPIO1 to behave as input for temperature
+ * conversion and GPIO0 to act as interrupt for temperature conversion.
+ *
+ * TODO: trigger temperature conversion via GPIO1
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#define MAX30208_DRV_NAME		"max30208"
+
+#define MAX30208_STATUS			0x00
+#define MAX30208_STATUS_TEMP_RDY	BIT(0)
+#define MAX30208_INT_ENABLE		0x01
+#define MAX30208_INT_ENABLE_TEMP_RDY	BIT(0)
+
+#define MAX30208_FIFO_OVF_CNTR		0x06
+#define MAX30208_FIFO_DATA_CNTR		0x07
+#define MAX30208_FIFO_DATA		0x08
+
+#define MAX30208_SYSTEM_CTRL		0x0c
+#define MAX30208_SYSTEM_CTRL_RESET	0x01
+
+#define MAX30208_TEMP_SENSOR_SETUP	0x14
+#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
+
+#define MAX30208_GPIO_SETUP		0x20
+#define MAX30208_GPIO1_SETUP		GENMASK(7, 6)
+#define MAX30208_GPIO0_SETUP		GENMASK(1, 0)
+#define MAX30208_GPIO_CTRL		0x21
+#define MAX30208_GPIO1_CTRL		BIT(3)
+#define MAX30208_GPIO0_CTRL		BIT(0)
+
+#define MAX30208_RESOLUTION_MC		5
+
+struct max30208_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+	struct mutex lock;
+};
+
+static const struct iio_chan_spec max30208_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+static int max30208_request(struct max30208_data *data)
+{
+	int retries = 10;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
+	if (ret < 0)
+		return ret;
+
+	ret |= MAX30208_TEMP_SENSOR_SETUP_CONV;
+
+	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, ret);
+	if (ret < 0)
+		return ret;
+
+	while (retries--) {
+		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
+		if (ret < 0)
+			goto sleep;
+
+		if (ret & MAX30208_STATUS_TEMP_RDY)
+			return 0;
+
+		msleep(50);
+	}
+	dev_warn(&data->client->dev, "Temperature conversion failed\n");
+
+	return 0;
+
+sleep:
+	usleep_range(50000, 60000);
+	return 0;
+}
+
+static int max30208_update_temp(struct max30208_data *data)
+{
+	u16 temp_raw = 0;
+	s8 data_count;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	ret = max30208_request(data);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		data_count = i2c_smbus_read_byte_data(data->client,
+						      MAX30208_FIFO_DATA_CNTR);
+	else
+		data_count = ret;
+
+	if (data_count < 0)
+		return data_count;
+
+	while (data_count) {
+		ret = i2c_smbus_read_word_swapped(data->client,
+						  MAX30208_FIFO_DATA);
+		if (ret < 0)
+			return ret;
+
+		data_count = i2c_smbus_read_byte_data(data->client,
+						      MAX30208_FIFO_DATA_CNTR);
+		if (data_count < 0)
+			return data_count;
+	}
+	temp_raw = ret;
+
+	mutex_unlock(&data->lock);
+
+	return temp_raw;
+}
+
+static int max30208_read(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int *val, int *val2, long mask)
+{
+	struct max30208_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max30208_update_temp(data);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret, 15);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = MAX30208_RESOLUTION_MC;
+		*val2 = 1;
+
+		return IIO_VAL_FRACTIONAL;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = max30208_update_temp(data);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret, 15) * MAX30208_RESOLUTION_MC;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void max30208_gpio_setup(struct max30208_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       MAX30208_GPIO_SETUP);
+	if (ret >= 0) {
+		/*
+		 * Setting GPIO1 to trigger temperature conversion
+		 * when driven low.
+		 * Setting GPIO0 to trigger interrupt when temperature
+		 * conversion gets completed.
+		 */
+		ret |= MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
+		i2c_smbus_write_byte_data(data->client,
+					  MAX30208_GPIO_SETUP, ret);
+	}
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       MAX30208_INT_ENABLE);
+	if (ret >= 0) {
+		/* Enabling GPIO0 interrupt */
+		ret |= MAX30208_INT_ENABLE_TEMP_RDY;
+		i2c_smbus_write_byte_data(data->client,
+					  MAX30208_INT_ENABLE, ret);
+	}
+}
+
+static const struct iio_info max30208_info = {
+	.read_raw = max30208_read,
+};
+
+static int max30208_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct max30208_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = i2c;
+	mutex_init(&data->lock);
+
+	indio_dev->name = MAX30208_DRV_NAME;
+	indio_dev->channels = max30208_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max30208_channels);
+	indio_dev->info = &max30208_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register IIO device\n");
+		return ret;
+	}
+
+	/* Reset the device after registering */
+	ret = i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
+					MAX30208_SYSTEM_CTRL_RESET);
+	if (ret)
+		dev_warn(dev, "Proceeding without successful reset\n");
+
+	usleep_range(50000, 60000);
+
+	max30208_gpio_setup(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id max30208_id_table[] = {
+	{ "max30208", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max30208_id_table);
+
+static struct i2c_driver max30208_driver = {
+	.driver = {
+		.name = MAX30208_DRV_NAME,
+	},
+	.probe_new = max30208_probe,
+	.id_table = max30208_id_table,
+};
+
+static int __init max30208_init(void)
+{
+	return i2c_add_driver(&max30208_driver);
+}
+module_init(max30208_init);
+
+static void __exit max30208_exit(void)
+{
+	i2c_del_driver(&max30208_driver);
+}
+module_exit(max30208_exit);
+
+MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
+MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1

