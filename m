Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C645F4484
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJDNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDNnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:43:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47140E17
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:43:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1ofiCG-0002HX-Nq; Tue, 04 Oct 2022 15:42:56 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1ofiCH-004ZkB-Gx; Tue, 04 Oct 2022 15:42:56 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1ofiCE-00DCcH-St; Tue, 04 Oct 2022 15:42:54 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v1 2/2] iio: adc: add ADC driver for the TI LMP92064 controller
Date:   Tue,  4 Oct 2022 15:42:38 +0200
Message-Id: <20221004134238.3144326-2-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
References: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI LMP92064 is a dual 12 Bit ADC connected via SPI.
The two channels are intended for simultaneous measurements of the voltage
across- and current through a load to allow accurate instantaneous power
measurements.
The driver does not yet take advantage of this feature, as buffering is not yet
implemented.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 MAINTAINERS                   |   8 +
 drivers/iio/adc/Kconfig       |  10 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/ti-lmp92064.c | 317 ++++++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 drivers/iio/adc/ti-lmp92064.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b9654f764c8..75e3b6ae03d63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20390,6 +20390,14 @@ S:	Maintained
 F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
 
+TI LMP92064 ADC DRIVER
+M:	Leonard Göhrs <l.goehrs@pengutronix.de>
+R:	kernel@pengutronix.de
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
+F:	drivers/iio/adc/ti-lmp92064.c
+
 TI PCM3060 ASoC CODEC DRIVER
 M:	Kirill Marinushkin <kmarinushkin@birdec.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930891e0a..6c3d471304467 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1219,6 +1219,16 @@ config TI_AM335X_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called ti_am335x_adc.
 
+config TI_LMP92064
+	tristate "Texas Instruments LMP92064 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for the LMP92064 Precision Current and Voltage
+	  sensor.
+
+	  This driver can also be built as a module. If so, the module will be called
+	  ti-lmp92064.
+
 config TI_TLC4541
 	tristate "Texas Instruments TLC4541 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1772a549a3c80..10a9c1d470336 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
+obj-$(CONFIG_TI_LMP92064) += ti-lmp92064.o
 obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
 obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
new file mode 100644
index 0000000000000..b70193fc2c841
--- /dev/null
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments LMP92064 SPI ADC driver
+ *
+ * Copyright (c) 2022 Leonard Göhrs <kernel@pengutronix.de>, Pengutronix
+ *
+ * Based on linux/drivers/iio/adc/ti-tsc2046.c
+ * Copyright (c) 2021 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+
+#define TI_LMP92064_NAME "lmp92064"
+
+#define TI_LMP92064_CMD_READ BIT(15)
+#define TI_LMP92064_CMD_WRITE 0
+
+#define TI_LMP92064_REG_CONFIG_A 0x0000
+#define TI_LMP92064_REG_CONFIG_B 0x0001
+#define TI_LMP92064_REG_STATUS 0x0103
+
+#define TI_LMP92064_REG_DATA_VOUT_LSB 0x0200
+#define TI_LMP92064_REG_DATA_VOUT_MSB 0x0201
+#define TI_LMP92064_REG_DATA_COUT_LSB 0x0202
+#define TI_LMP92064_REG_DATA_COUT_MSB 0x0203
+
+#define TI_LMP92064_VAL_CONFIG_A 0x99
+#define TI_LMP92064_VAL_CONFIG_B 0x00
+#define TI_LMP92064_VAL_STATUS_OK 0x01
+
+#define TI_LMP92064_CHAN_INC 0
+#define TI_LMP92064_CHAN_INV 1
+
+struct lmp92064_adc_priv {
+	struct spi_device *spi;
+	int shunt_resistor;
+};
+
+static const struct iio_chan_spec lmp92064_adc_channels[] = {
+	{
+		.type = IIO_CURRENT,
+		.address = TI_LMP92064_CHAN_INC,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.datasheet_name = "INC",
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.address = TI_LMP92064_CHAN_INV,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.datasheet_name = "INV",
+	},
+};
+
+static int lmp92064_write_reg(struct lmp92064_adc_priv *priv, u16 reg, u8 val)
+{
+	u16 cmd = TI_LMP92064_CMD_WRITE | reg;
+	int ret;
+	u8 __aligned(IIO_DMA_MINALIGN) tx_buf[3];
+	struct spi_transfer xfer = {
+		.tx_buf = tx_buf,
+		.rx_buf = NULL,
+		.len = 3,
+	};
+
+	tx_buf[0] = cmd >> 8;
+	tx_buf[1] = cmd & 0xff;
+	tx_buf[2] = val;
+
+	ret = spi_sync_transfer(priv->spi, &xfer, 1);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "spi_sync_transfer failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lmp92064_read_reg(struct lmp92064_adc_priv *priv, u16 reg, u8 *val)
+{
+	u16 cmd = TI_LMP92064_CMD_READ | reg;
+	int ret;
+	u8 __aligned(IIO_DMA_MINALIGN) tx_buf[3] = { 0 };
+	u8 __aligned(IIO_DMA_MINALIGN) rx_buf[3] = { 0 };
+	struct spi_transfer xfer = {
+		.tx_buf = tx_buf,
+		.rx_buf = rx_buf,
+		.len = 3,
+	};
+
+	tx_buf[0] = cmd >> 8;
+	tx_buf[1] = cmd & 0xff;
+
+	ret = spi_sync_transfer(priv->spi, &xfer, 1);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "spi_sync_transfer failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	*val = rx_buf[2];
+
+	return 0;
+}
+
+static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, int *cout,
+			      int *vout)
+{
+	/*
+         * The ADC only latches in new samples if all DATA registers are read
+         * in descending sequential order.
+         * The ADC auto-decrements the register index with each clocked byte.
+         * Read both channels in single SPI transfer by selecting the highest
+         * register using the command below and clocking out all four data
+         * bytes.
+         */
+	u16 cmd = TI_LMP92064_CMD_READ | TI_LMP92064_REG_DATA_COUT_MSB;
+	u8 __aligned(IIO_DMA_MINALIGN) tx_buf[6] = { 0 };
+	u8 __aligned(IIO_DMA_MINALIGN) rx_buf[6] = { 0 };
+	struct spi_transfer xfer = {
+		.tx_buf = tx_buf,
+		.rx_buf = rx_buf,
+		.len = sizeof(tx_buf),
+	};
+	int ret;
+
+	tx_buf[0] = cmd >> 8;
+	tx_buf[1] = cmd & 0xff;
+
+	ret = spi_sync_transfer(priv->spi, &xfer, 1);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "spi_sync_transfer failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	if (cout)
+		*cout = (rx_buf[2] << 8) | (rx_buf[3]);
+
+	if (vout)
+		*vout = (rx_buf[4] << 8) | (rx_buf[5]);
+
+	return 0;
+}
+
+static int lmp92064_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct lmp92064_adc_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		if (chan->address == TI_LMP92064_CHAN_INC)
+			ret = lmp92064_read_meas(priv, val, NULL);
+		else
+			ret = lmp92064_read_meas(priv, NULL, val);
+		mutex_unlock(&indio_dev->mlock);
+
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->address == TI_LMP92064_CHAN_INC) {
+			/*
+                         * processed (mA) = raw * current_lsb (mA)
+                         * current_lsb (mA) = shunt_voltage_lsb (nV) / shunt_resistor (uOhm)
+                         * shunt_voltage_lsb (nV) = 81920000 / 4096 = 20000
+                         */
+			*val = 20000;
+			*val2 = priv->shunt_resistor;
+		} else {
+			/*
+                         * processed (mV) = raw * voltage_lsb (mV)
+                         * voltage_lsb (mV) = 2048 / 4096
+                         */
+			*val = 2048;
+			*val2 = 4096;
+		}
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lmp92064_reset(struct lmp92064_adc_priv *priv,
+			  struct gpio_desc *gpio_reset)
+{
+	u8 status;
+	int ret, i;
+
+	/* Perform a hard reset if possible */
+	if (gpio_reset) {
+		gpiod_set_value_cansleep(gpio_reset, 1);
+		usleep_range(1, 10);
+		gpiod_set_value_cansleep(gpio_reset, 0);
+		usleep_range(500, 750);
+	}
+
+	/* Perform a soft-reset and write default values to config registers
+         * that are not affected by soft reset */
+	ret = lmp92064_write_reg(priv, TI_LMP92064_REG_CONFIG_A,
+				 TI_LMP92064_VAL_CONFIG_A);
+	if (ret < 0)
+		return ret;
+
+	ret = lmp92064_write_reg(priv, TI_LMP92064_REG_CONFIG_B,
+				 TI_LMP92064_VAL_CONFIG_B);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for the device to signal readiness */
+	for (i = 0; i < 10; i++) {
+		ret = lmp92064_read_reg(priv, TI_LMP92064_REG_STATUS, &status);
+
+		if (ret < 0)
+			return ret;
+
+		if (status == TI_LMP92064_VAL_STATUS_OK)
+			return 0;
+
+		usleep_range(1000, 2000);
+	}
+
+	return -EBUSY;
+}
+
+static const struct iio_info lmp92064_adc_info = {
+	.read_raw = lmp92064_read_raw,
+};
+
+static int lmp92064_adc_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct lmp92064_adc_priv *priv;
+	struct iio_dev *indio_dev;
+	struct gpio_desc *gpio_reset;
+	int ret;
+	u32 shunt_resistor;
+
+	spi->bits_per_word = 8;
+	spi->mode &= ~SPI_MODE_X_MASK;
+	spi->mode |= SPI_MODE_0;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error in SPI setup\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+
+	priv->spi = spi;
+
+	ret = of_property_read_u32(dev->of_node, "shunt-resistor",
+				   &shunt_resistor);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to get shunt-resistor value\n");
+
+	/* The shunt resistance is passed to userspace as the denominator of an iio
+	 * fraction. Make sure it is in range for that. */
+	if (shunt_resistor <= 0 || shunt_resistor > INT_MAX) {
+		dev_err(dev, "Shunt resistance is out of range\n");
+		return -EINVAL;
+	}
+
+	priv->shunt_resistor = shunt_resistor;
+
+	gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(gpio_reset),
+				     "Failed to get GPIO reset pin\n");
+
+	ret = lmp92064_reset(priv, gpio_reset);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
+
+	indio_dev->name = TI_LMP92064_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = lmp92064_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(lmp92064_adc_channels);
+	indio_dev->info = &lmp92064_adc_info;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id lmp92064_of_table[] = {
+	{ .compatible = "ti,lmp92064" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lmp92064_of_table);
+
+static struct spi_driver lmp92064_adc_driver = {
+	.driver = {
+		.name = "lmp92064",
+		.of_match_table = lmp92064_of_table,
+	},
+	.probe = lmp92064_adc_probe,
+};
+module_spi_driver(lmp92064_adc_driver);
+
+MODULE_AUTHOR("Leonard Göhrs <kernel@pengutronix.de>");
+MODULE_DESCRIPTION("TI LMP92064 ADC");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

