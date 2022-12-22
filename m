Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436E65474C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiLVUhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiLVUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:37:04 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939020BE1;
        Thu, 22 Dec 2022 12:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8UbzzxEYxavIqAzfz0BKol+AB7kInMwdg3uqNR7iUrQ=; b=G+BYqhjTjHIuB7iuALvx6d/kE3
        qgvZ1PAWpwcOCods6Ol4L9VE3OjjOnEf0+aZ35PBNbRn/020fZTNNKqmXmdvDDek56b6/pNpVpwuD
        TEvMtzT8pihLaUefeEjLRoQYmepQl1AyUA6GYd2kMhTO2XHX7XqXylF+N4OY4glJMydg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48920 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8SJA-000070-99; Thu, 22 Dec 2022 15:36:53 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com
Date:   Thu, 22 Dec 2022 15:36:09 -0500
Message-Id: <20221222203610.2571287-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221222203610.2571287-1-hugo@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 2/3] iio: adc: ti-ads7924: add ADS7924 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
digital converter (ADC) with an I2C interface.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 MAINTAINERS                  |   7 +
 drivers/iio/adc/Kconfig      |  13 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads7924.c | 514 +++++++++++++++++++++++++++++++++++
 4 files changed, 535 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads7924.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ced1f994442..7abe6f0cd2cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20545,6 +20545,13 @@ M:	Robert Richter <rric@kernel.org>
 S:	Odd Fixes
 F:	drivers/gpio/gpio-thunderx.c
 
+TI ADS7924 ADC DRIVER
+M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
+F:	drivers/iio/adc/ti-ads7924.c
+
 TI AM437X VPFE DRIVER
 M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 235319546974..18adcd6200b0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1207,6 +1207,19 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS7924
+	tristate "Texas Instruments ADS7924 ADC"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS7924
+	  4 channels, 12-bit I2C ADC chip.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads7924.
+
 config TI_ADS7950
 	tristate "Texas Instruments ADS7950 ADC driver"
 	depends on SPI && GPIOLIB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 6e08415c3f3a..1e5bdf47a091 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
+obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
new file mode 100644
index 000000000000..e9ca7a045d18
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Texas Instruments ADS7924 ADC, 12-bit, 4-Channels, I2C
+ *
+ * iio/adc/ti-ads7924.c
+ * Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
+ * Copyright 2022 DimOnOff
+ *
+ * based on iio/adc/ti-ads1015.c
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * Datasheets: https://www.ti.com/lit/gpn/ads7924
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/i2c.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#define ADS7924_DRV_NAME "ads7924"
+
+#define ADS7924_CHANNELS 4
+
+/* Registers. */
+#define ADS7924_MODECNTRL_REG	0x00
+#define ADS7924_INTCNTRL_REG	0x01
+#define ADS7924_DATA0_U_REG	0x02
+#define ADS7924_DATA0_L_REG	0x03
+#define ADS7924_DATA1_U_REG	0x04
+#define ADS7924_DATA1_L_REG	0x05
+#define ADS7924_DATA2_U_REG	0x06
+#define ADS7924_DATA2_L_REG	0x07
+#define ADS7924_DATA3_U_REG	0x08
+#define ADS7924_DATA3_L_REG	0x09
+#define ADS7924_ULR0_REG	0x0A
+#define ADS7924_LLR0_REG	0x0B
+#define ADS7924_ULR1_REG	0x0C
+#define ADS7924_LLR1_REG	0x0D
+#define ADS7924_ULR2_REG	0x0E
+#define ADS7924_LLR2_REG	0x0F
+#define ADS7924_ULR3_REG	0x10
+#define ADS7924_LLR3_REG	0x11
+#define ADS7924_INTCONFIG_REG	0x12
+#define ADS7924_SLPCONFIG_REG	0x13
+#define ADS7924_ACQCONFIG_REG	0x14
+#define ADS7924_PWRCONFIG_REG	0x15
+#define ADS7924_RESET_REG	0x16
+
+/* Register address INC bit: when set to '1', the register address is
+ * automatically incremented after every register read which allows convenient
+ * reading of multiple registers. Set INC to '0' when reading a single register.
+ */
+#define ADS7924_AUTO_INCREMENT_BIT	BIT(7)
+
+#define ADS7924_MODECNTRL_MODE_SHIFT	2
+#define ADS7924_MODECNTRL_MODE_MASK	GENMASK(7, ADS7924_MODECNTRL_MODE_SHIFT)
+
+#define ADS7924_MODECNTRL_SEL_SHIFT	0
+#define ADS7924_MODECNTRL_SEL_MASK	GENMASK(1, ADS7924_MODECNTRL_SEL_SHIFT)
+
+#define ADS7924_CFG_INTPOL_BIT		1
+#define ADS7924_CFG_INTTRIG_BIT		0
+
+#define ADS7924_CFG_INTPOL_MASK		BIT(ADS7924_CFG_INTPOL_BIT)
+#define ADS7924_CFG_INTTRIG_MASK	BIT(ADS7924_CFG_INTTRIG_BIT)
+
+/* Interrupt pin polarity */
+#define ADS7924_CFG_INTPOL_LOW		0
+#define ADS7924_CFG_INTPOL_HIGH		1
+
+/* Interrupt pin signaling */
+#define ADS7924_CFG_INTTRIG_LEVEL	0
+#define ADS7924_CFG_INTTRIG_EDGE	1
+
+/* Mode control values */
+#define ADS7924_MODECNTRL_IDLE			0x00
+#define ADS7924_MODECNTRL_AWAKE			0x20
+#define ADS7924_MODECNTRL_MANUAL_SINGLE		0x30
+#define ADS7924_MODECNTRL_MANUAL_SCAN		0x32
+#define ADS7924_MODECNTRL_AUTO_SINGLE		0x31
+#define ADS7924_MODECNTRL_AUTO_SCAN		0x33
+#define ADS7924_MODECNTRL_AUTO_SINGLE_SLEEP	0x39
+#define ADS7924_MODECNTRL_AUTO_SCAN_SLEEP	0x3B
+#define ADS7924_MODECNTRL_AUTO_BURST_SLEEP	0x3F
+
+#define ADS7924_ACQTIME_SHIFT	0
+#define ADS7924_ACQTIME_MASK	GENMASK(4, ADS7924_ACQTIME_SHIFT)
+
+#define ADS7924_PWRUPTIME_SHIFT	0
+#define ADS7924_PWRUPTIME_MASK	GENMASK(4, ADS7924_PWRUPTIME_SHIFT)
+
+/* The power-up time is allowed to elapse whenever the device has been shutdown
+ * in idle mode. Power-up time can allow external circuits, such as an
+ * operational amplifier, between the MUXOUT and ADCIN pins to turn on.
+ * The nominal time programmed by the PUTIME[4:0] register bits is given by:
+ *     t PU = PWRUPTIME[4:0] × 2 μs
+ * If a power-up time is not required, set the bits to '0' to effectively bypass.
+ */
+#define ADS7924_PWRUPTIME_US 0 /* Bypass (0us). */
+
+/* Acquisition Time. Minimum is 6us. */
+#define ADS7924_ACQTIME_US 6 /* Disable (6us). */
+
+/* The conversion time is always 4μs and cannot be programmed by the user. */
+#define ADS7924_CONVTIME_US 4
+
+#define ADS7924_TOTAL_CONVTIME (ADS7924_PWRUPTIME_US + ADS7924_ACQTIME_US + \
+				ADS7924_CONVTIME_US)
+
+#define ADS7924_SLEEP_DELAY_MS		2000
+
+enum ads7924_channels {
+	ADS7924_CH0,
+	ADS7924_CH1,
+	ADS7924_CH2,
+	ADS7924_CH3,
+	ADS7924_TIMESTAMP,
+};
+
+#define ADS7924_V_CHAN(_chan, _addr) {				\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.address = _addr,					\
+	.channel = _chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), 		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.scan_index = _addr,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.shift = 4,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.datasheet_name = "AIN"#_chan,				\
+}
+
+/* To map a channel with its corresponding data register (MSB). */
+static const unsigned int ads7924_channel_data_msb_regs[] = {
+	ADS7924_DATA0_U_REG,
+	ADS7924_DATA1_U_REG,
+	ADS7924_DATA2_U_REG,
+	ADS7924_DATA3_U_REG
+};
+
+struct ads7924_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator *vref_reg;
+
+	/* GPIO descriptor for device hard-reset pin. */
+	struct gpio_desc *reset_gpio;
+
+	/*
+	 * Protects ADC ops, e.g: concurrent sysfs/buffered
+	 * data reads, configuration updates
+	 */
+	struct mutex lock;
+
+	/*
+	 * Set to true when the ADC is switched to the continuous-conversion
+	 * mode and exits from a power-down state. This flag is used to avoid
+	 * getting the stale result from the conversion register.
+	 */
+	bool conv_invalid;
+};
+
+static bool ads7924_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADS7924_MODECNTRL_REG:
+	case ADS7924_INTCNTRL_REG:
+	case ADS7924_ULR0_REG:
+	case ADS7924_LLR0_REG:
+	case ADS7924_ULR1_REG:
+	case ADS7924_LLR1_REG:
+	case ADS7924_ULR2_REG:
+	case ADS7924_LLR2_REG:
+	case ADS7924_ULR3_REG:
+	case ADS7924_LLR3_REG:
+	case ADS7924_INTCONFIG_REG:
+	case ADS7924_SLPCONFIG_REG:
+	case ADS7924_ACQCONFIG_REG:
+	case ADS7924_PWRCONFIG_REG:
+	case ADS7924_RESET_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config ads7924_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ADS7924_RESET_REG,
+	.writeable_reg = ads7924_is_writeable_reg,
+};
+
+static const struct iio_chan_spec ads7924_channels[] = {
+	ADS7924_V_CHAN(0, ADS7924_CH0),
+	ADS7924_V_CHAN(1, ADS7924_CH1),
+	ADS7924_V_CHAN(2, ADS7924_CH2),
+	ADS7924_V_CHAN(3, ADS7924_CH3),
+	IIO_CHAN_SOFT_TIMESTAMP(ADS7924_TIMESTAMP),
+};
+
+static
+int ads7924_get_adc_result(struct ads7924_data *data, int chan, int *val)
+{
+	int ret;
+	__be16 be_val;
+
+	if (chan < 0 || chan >= ADS7924_CHANNELS)
+		return -EINVAL;
+
+	if (data->conv_invalid) {
+		int conv_time;
+
+		conv_time = ADS7924_TOTAL_CONVTIME;
+		/* Allow 10% for internal clock inaccuracy. */
+		conv_time += conv_time / 10;
+		usleep_range(conv_time, conv_time + 1);
+		data->conv_invalid = false;
+	}
+
+	ret = regmap_raw_read(data->regmap, ADS7924_AUTO_INCREMENT_BIT |
+			      ads7924_channel_data_msb_regs[chan],
+			      &be_val, sizeof(be_val));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(be_val);
+	*val = *val >> ads7924_channels[chan].scan_type.shift;
+
+	return ret;
+}
+
+static int ads7924_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret, vref_uv;
+	struct ads7924_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			break;
+
+		ret = ads7924_get_adc_result(data, chan->address, val);
+		if (ret < 0)
+			dev_dbg(data->dev, "%s error1\n", __func__);
+		else
+			ret = IIO_VAL_INT;
+
+		iio_device_release_direct_mode(indio_dev);
+		break;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		vref_uv = regulator_get_voltage(data->vref_reg);
+		if (vref_uv < 0) {
+			/* dummy regulator "get_voltage" returns -EINVAL */
+			ret = -EINVAL;
+		} else {
+			*val =  vref_uv / 1000; /* Convert reg voltage to mV */
+			*val2 = chan->scan_type.realbits; /* Data bits */
+			ret = IIO_VAL_FRACTIONAL_LOG2;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static const struct iio_info ads7924_info = {
+	.read_raw	= ads7924_read_raw,
+};
+
+static int ads7924_of_parse_channel_config(struct iio_dev *indio_dev,
+					   struct device_node *np)
+{
+	struct ads7924_data *priv = iio_priv(indio_dev);
+	struct device *dev = priv->dev;
+	struct device_node *child;
+	int num_channels;
+	unsigned int channel = 0;
+	int ret;
+
+	num_channels = of_get_available_child_count(np);
+	if (!num_channels) {
+		dev_err(dev, "no channel children\n");
+		return -ENODEV;
+	}
+	dev_dbg(dev, "found %d ADC channels\n", num_channels);
+
+	for_each_available_child_of_node(np, child) {
+		ret = of_property_read_u32(child, "reg", &channel);
+		if (ret)
+			goto err;
+
+		if (channel >= ADS7924_CHANNELS) {
+			dev_err(dev, "invalid channel index %d\n", channel);
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	of_node_put(child);
+
+	return ret;
+}
+
+static int ads7924_set_conv_mode(struct ads7924_data *data, int mode)
+{
+	/* When switching between modes, be sure to first select the Awake mode
+	 * and then switch to the desired mode. This procedure ensures the
+	 * internal control logic is properly synchronized.
+	 */
+	if (mode != ADS7924_MODECNTRL_IDLE) {
+		int ret;
+
+		ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
+					 ADS7924_MODECNTRL_MODE_MASK,
+					 ADS7924_MODECNTRL_AWAKE <<
+					 ADS7924_MODECNTRL_MODE_SHIFT);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
+				  ADS7924_MODECNTRL_MODE_MASK,
+				  mode << ADS7924_MODECNTRL_MODE_SHIFT);
+}
+
+static int ads7924_reset(struct iio_dev *indio_dev)
+{
+	struct ads7924_data *data = iio_priv(indio_dev);
+
+	if (data->reset_gpio) {
+		gpiod_set_value(data->reset_gpio, 1); /* Assert. */
+		/* Educated guess: assert time not specified in datasheet... */
+		mdelay(100);
+		gpiod_set_value(data->reset_gpio, 0); /* Deassert. */
+	} else {
+		int ret;
+
+		/* A write of 10101010 to this register will generate a
+		 * software reset of the ADS7924.
+		 */
+		ret = regmap_write(data->regmap, ADS7924_RESET_REG, 0b10101010);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+};
+
+static void ads7924_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static int ads7924_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads7924_data *data;
+	struct device *dev = &client->dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data = iio_priv(indio_dev);
+
+	data->dev = dev;
+
+	/* Initialize the reset GPIO as output with an initial value of 0. */
+	data->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(data->reset_gpio))
+		return PTR_ERR(data->reset_gpio);
+
+	mutex_init(&data->lock);
+
+	indio_dev->name = ADS7924_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->channels = ads7924_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads7924_channels);
+	indio_dev->info = &ads7924_info;
+
+	ret = ads7924_of_parse_channel_config(indio_dev, dev->of_node);
+	if (ret < 0)
+		return ret;
+
+	data->regmap = devm_regmap_init_i2c(client, &ads7924_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "Failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	data->vref_reg = devm_regulator_get(dev, "vref");
+	if (IS_ERR(data->vref_reg)) {
+		dev_err(dev, "devm_regulator_get() failed\n");
+		return PTR_ERR(data->vref_reg);
+	}
+
+	ret = regulator_enable(data->vref_reg);
+	if (ret) {
+		dev_err(dev, "regulator_enable() failed\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ads7924_reg_disable, data->vref_reg);
+	if (ret) {
+		dev_err(dev, "devm_add_action_or_reset() failed\n");
+		return ret;
+	}
+
+	ret = ads7924_reset(indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to reset device\n");
+		return ret;
+	}
+
+	ret = ads7924_set_conv_mode(data,
+				    ADS7924_MODECNTRL_AUTO_SCAN);
+	if (ret)
+		return ret;
+
+	/* Disable signal acquire time. */
+	ret = regmap_update_bits(data->regmap, ADS7924_ACQCONFIG_REG,
+				 ADS7924_ACQTIME_MASK, 0);
+	if (ret < 0) {
+		dev_err(dev, "Disable signal acquire time failed\n");
+		return ret;
+	}
+
+	/* Disable power-up time. */
+	ret = regmap_update_bits(data->regmap, ADS7924_PWRCONFIG_REG,
+				 ADS7924_PWRUPTIME_MASK, 0);
+	if (ret < 0) {
+		dev_err(dev, "Disable power-up time failed\n");
+		return ret;
+	}
+
+	data->conv_invalid = true;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register IIO device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ads7924_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads7924_data *data = iio_priv(indio_dev);
+	int ret;
+
+	iio_device_unregister(indio_dev);
+
+	ret = ads7924_set_conv_mode(data, ADS7924_MODECNTRL_IDLE);
+	if (ret)
+		dev_warn(&client->dev, "Failed to power down (%pe)\n",
+			 ERR_PTR(ret));
+}
+
+static const struct of_device_id ads7924_of_match[] = {
+	{ .compatible = "ti,ads7924", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ads7924_of_match);
+
+static struct i2c_driver ads7924_driver = {
+	.driver = {
+		.name = ADS7924_DRV_NAME,
+		.of_match_table = ads7924_of_match,
+	},
+	.probe_new	= ads7924_probe,
+	.remove		= ads7924_remove,
+};
+
+module_i2c_driver(ads7924_driver);
+
+MODULE_AUTHOR("Hugo Villeneuve <hvilleneuve@dimonoff.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS7924 ADC I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

