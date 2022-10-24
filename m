Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA156094EA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiJWQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJWQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:57:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7164D2;
        Sun, 23 Oct 2022 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666544219; x=1698080219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Rg3KhR6QudN53F09OpL0KlKQzVurculcfJodkdmGO4=;
  b=i9+1uoGnNSwLqQq0pUa9ueCuh+T4puOYlo1fU/H8zr69lMyxz4GZGzlu
   U63/mBtogBknB6xNrmpaNqVfI9D6cMYCLg+7VL+jS5898N3vjRwUJAiZR
   wei5bBTbXKZJ5+eMd9lX79mGzCsAJGC6UQRWbM4DWljHnSUwtodlq+W6c
   emuOgZFj7AGN2RojTfWT1EwRu2GiHl0nUC71iJM7QI4aX1JaRMNs6BNLz
   t5nIljcUA1wqKlS9w2jFzGoPbwn4x8F3GK0fl3ysN/0FCq3RJJeUX8VfM
   DqWILQ5DmLJ1oYJvjr4waCTBWBfHeCayE9JRfLeCRL3O5/7zoWHqCKSAx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="333865331"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="333865331"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:56:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="736152021"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="736152021"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:56:55 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v5] iio: temperature: Add driver support for Maxim MAX30208
Date:   Mon, 24 Oct 2022 22:26:58 +0530
Message-Id: <20221024165658.181340-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

v5:
1. Fixed comment position in max30208_request
2. Use of local u8 variable to build register values
3. Using u8 instead of s8 in data_count
4. Removed global MAX30208_RES_MILLICELCIUS
5. Removed 'comma' on NULL terminators

v4: Version comments go below line separator of signed-off-by

v3: Release the mutex lock after error gets returned

v2:
1. Removed TODO
2. Removed unnecessary blank spaces
3. Corrected MC->MILLICELCIUS
4. Comments added wherever required
5. dev_err on i2c fails
6. Rearranged some flows
7. Removed PROCESSED
8. int error return on gpio setup
9. device_register at the end of probe
10. Return on unsuccessful reset
11. acpi_match_table and of_match_table added
12. Minor quirks

 MAINTAINERS                        |   6 +
 drivers/iio/temperature/Kconfig    |  10 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max30208.c | 323 +++++++++++++++++++++++++++++
 4 files changed, 340 insertions(+)
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
index 000000000000..4f78337c78fe
--- /dev/null
+++ b/drivers/iio/temperature/max30208.c
@@ -0,0 +1,323 @@
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
+struct max30208_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+	struct mutex lock; /* Lock to prevent concurrent reads */
+};
+
+static const struct iio_chan_spec max30208_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+/**
+ * max30208_request() - Request a reading
+ * @data: Struct comprising member elements of the device
+ *
+ * Requests a reading from the device and waits until the conversion is ready.
+ */
+static int max30208_request(struct max30208_data *data)
+{
+	/*
+	 * Sensor can take up to 500 ms to respond so execute a total of
+	 * 10 retries to give the device sufficient time.
+	 */
+	int retries = 10;
+	u8 regval;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg temperature setup\n");
+		return ret;
+	}
+
+	regval = ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
+
+	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, regval);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing reg temperature setup\n");
+		return ret;
+	}
+
+	while (retries--) {
+		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Error reading reg status\n");
+			goto sleep;
+		}
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
+	u8 data_count;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	ret = max30208_request(data);
+	if (ret < 0)
+		goto unlock;
+
+	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n");
+		goto unlock;
+	} else if (!ret) {
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MAX30208_FIFO_DATA_CNTR);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
+			goto unlock;
+		}
+	}
+
+	data_count = ret;
+
+	/*
+	 * Ideally, counter should decrease by 1 each time a word is read from FIFO.
+	 * However, practically, the device behaves erroneously and counter sometimes
+	 * decreases by more than 1. Hence, do not loop the counter until it becomes 0
+	 * rather, use the exact counter value after each FIFO word is read.
+	 * Return the last reading from FIFO as the most recently triggered one.
+	 */
+	while (data_count) {
+		ret = i2c_smbus_read_word_swapped(data->client,
+						  MAX30208_FIFO_DATA);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
+			goto unlock;
+		}
+
+		data_count = i2c_smbus_read_byte_data(data->client,
+						      MAX30208_FIFO_DATA_CNTR);
+		if (data_count < 0) {
+			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
+			ret = data_count;
+			goto unlock;
+		}
+	}
+
+unlock:
+	mutex_unlock(&data->lock);
+	return ret;
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
+		*val = 5;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30208_gpio_setup(struct max30208_data *data)
+{
+	u8 regval;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       MAX30208_GPIO_SETUP);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg GPIO setup\n");
+		return ret;
+	}
+
+	/*
+	 * Setting GPIO1 to trigger temperature conversion
+	 * when driven low.
+	 * Setting GPIO0 to trigger interrupt when temperature
+	 * conversion gets completed.
+	 */
+	regval = ret | MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX30208_GPIO_SETUP, regval);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing reg GPIO setup\n");
+		return ret;
+	}
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       MAX30208_INT_ENABLE);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg interrupt enable\n");
+		return ret;
+	}
+
+	/* Enabling GPIO0 interrupt */
+	regval = ret | MAX30208_INT_ENABLE_TEMP_RDY;
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX30208_INT_ENABLE, regval);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing reg interrupt enable\n");
+		return ret;
+	}
+
+	return 0;
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
+	/* Reset the device initially */
+	ret = i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
+					MAX30208_SYSTEM_CTRL_RESET);
+	if (ret) {
+		dev_err(dev, "Failure in performing reset\n");
+		return ret;
+	}
+
+	usleep_range(50000, 60000);
+
+	ret = max30208_gpio_setup(data);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register IIO device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id max30208_id_table[] = {
+	{ "max30208" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max30208_id_table);
+
+static const struct acpi_device_id max30208_acpi_match[] = {
+	{ "MAX30208" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
+
+static const struct of_device_id max30208_of_match[] = {
+	{ .compatible = "maxim,max30208" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max30208_of_match);
+
+static struct i2c_driver max30208_driver = {
+	.driver = {
+		.name = MAX30208_DRV_NAME,
+		.of_match_table = max30208_of_match,
+		.acpi_match_table = ACPI_PTR(max30208_acpi_match),
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

