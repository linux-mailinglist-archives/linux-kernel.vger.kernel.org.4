Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE769A8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBQKA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:00:55 -0500
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE755A3;
        Fri, 17 Feb 2023 02:00:52 -0800 (PST)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <mike.looijmans@topic.nl>)
        id 1pSx61-0002ND-Bo; Fri, 17 Feb 2023 10:32:05 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Fri, 17 Feb 2023 10:31:46 +0100 (CET)
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000 chips
Date:   Fri, 17 Feb 2023 10:31:28 +0100
Message-Id: <20230217093128.8344-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217093128.8344-1-mike.looijmans@topic.nl>
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (5.58220942115e-05)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8Ek/evweAfCr35UpAYUD3+PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzeemUa7CfwmLuWRw6Ruql9Wrt/oF2ofKYeezPZTW+uL/H
 seNZtCKdSRRS0Op9pfwEIJgF/Accv4lLtE4TWYNIjgZ0d6t6F7vRFkkblm+Z5NM7uAX91bCdERq+
 A7shw5HBQ2daKZyt52e93s8gLaWLOD0k0yEeil+YFQCKRVPBg05RYxHc7P83X0MN+qD//KRAIHit
 SXey4py3ysTASO2UXeFQ4Qgt4X4Tp95rRBIvvWBPBRhQMjnWPePTCfZDmArPZIeACtMN2+k7Hl2f
 CJBCzMQSU0TAfewY74azpmhUFMUm6WR+8c0KEwPTO8SnuobzsYGVSJ8wtWY1sFszHIIOCVaSXCYz
 6id0Qp9FVqPRF2suI8AhfWAI+3OB0r2i1Lt3K9A6cgdCiY8xmftez8R17qICVXFBwzSiou3p4l21
 Lnm4raDtqovtutf+6p3IWiEp7sv8hwpvb9d6DiO/MNJCAi4VQGJ+1LTkbQYmusVqy7ayNInQ+0lb
 zXWs+DxTD0/y9NItsM9ttotsEyQnvsnwgLS2YCXoa0H3byJv27sfTQg0uDekYo1Hqy4HTtnbisEY
 dF3BmDDWlyN0s3TqgqYglfL26r6XjWWOjRxq519qzGAk8LmqWByQuE4NgLCNvMqE1OOhyzG/Oscj
 BsvZZcW2F/eP5MA2oM4kHoDesUvzBiKGdVbzMHZCLbq+RUAvJzB5kqRXG94JLe5wjSBKHlptjwLc
 C/q3ulM+N0SFWvYGld402dhO3rKV6pwQxFvCm4fZge4+1O2L9U8n0gI8wLSjrhcJAwxv5UO5sZxd
 eqrFmDfltnogTj8qLK1JEjQtdLlpGGJIVc62Nqo696BsygOetfhl6mn95SwmcmfcGGUA0e6qXhdN
 qA/HGy79l8NsddgLhvp0D3f4afLIxAhC50yRfl6ccly0PzSbw88/mVDVjJtxNRxDtVtSVZUycqyT
 RYlryfBAuZ5Et+LGxtm9bdYCmKJZW+BrFDC/0X/A+ATYOc7UfRNcx89nmby0P9XyoKjuEiLQ7atO
 8HFTGDgCMvPsvCrJPmnnTHzVkpybMK7ZTcy7gw0xIsUMCrkLcCOUpBeAxMISlhTTogmIm+7uWnoK
 mjYRxHdk36dyx5RXwY9bPSk4xAm9D8KTeKJT7gNACPda9C5A1O6kFyeoUgLG9Fmq65AUgaZnd2hL
 2hmYKGSbsZnDQjgsSw49Sii5+aiGrIAWIi25oV9mrhSyrCr9ZkLoYuqq9KhbrPlc7mH86PRM2wXS
 rZeO7490DQ4oonjwx7zj1NX1DIR11dSkmPvtyWJgnC5zP7uIa3lQ/u231eSo5G2x/iFPdyw4ROzm
 NnUfS+9D/8f1V4XA52uMvrBv5mOLRYyA4gWNdmAd3MxX1sDOTbqvraXMdrNhWyDyKHiG9D9npc/l
 oKm25XEdh/tdoFOMHHASJNUmoOHSoqgqxfHmWWD85nwkbPmrbEw7dsSRat9CQHDi1xXFs3q3IhkP
 kh0tg/7K/pvhMveDMLvPOCN7G4f8/9jMrNCEeHzU1fqcBF0cc09c/vXmiMsV0QMqN40gdI/Bo0mx
 wy49VYRt2QpvK9MHbp7CnWC4JNX3FpKX5O1CJVQsd8mXfdwBJpdMG5E66qnk8yMIt1SRoB9SzM1R
 dTEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADS1100 is a 16-bit ADC (at 8 samples per second).
The ADS1000 is similar, but has a fixed data rate.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/iio/adc/Kconfig      |  12 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1100.c | 467 +++++++++++++++++++++++++++++++++++
 3 files changed, 480 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1100.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 63f80d747cbd..bc1918d87f8e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1207,6 +1207,18 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS1100
+	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS1100 and
+	  ADS1000 ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1100.
+
 config TI_ADS7950
 	tristate "Texas Instruments ADS7950 ADC driver"
 	depends on SPI && GPIOLIB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 4ef41a7dfac6..61ef600fab99 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
+obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
new file mode 100644
index 000000000000..0b0d3e5b6bd6
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADS1100 - Texas Instruments Analog-to-Digital Converter
+ *
+ * Copyright (c) 2023, Topic Embedded Products
+ *
+ * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/iio/sysfs.h>
+
+#define ADS1100_DRV_NAME "ads1100"
+
+/* The ADS1100 has a single byte config register */
+
+/* Conversion in progress bit */
+#define ADS1100_CFG_ST_BSY	BIT(7)
+/* Single conversion bit */
+#define ADS1100_CFG_SC		BIT(4)
+/* Data rate */
+#define ADS1100_DR_MASK		(BIT(3) | BIT(2))
+#define ADS1100_DR_SHIFT	2
+/* Gain */
+#define ADS1100_PGA_MASK	(BIT(1) | BIT(0))
+
+#define ADS1100_CONTINUOUS	0
+#define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
+
+#define ADS1100_SLEEP_DELAY_MS	2000
+
+static const int ads1100_data_rate[] = {128, 32, 16, 8};
+static const int ads1100_data_rate_scale[] = {2048, 8192, 16384, 32768};
+static const int ads1100_gain[] = {1, 2, 4, 8};
+
+struct ads1100_data {
+	struct i2c_client *client;
+	struct regulator *reg_vdd;
+	struct mutex lock;
+	u8 config;
+	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+};
+
+static const struct iio_chan_spec ads1100_channel = {
+	.type = IIO_VOLTAGE,
+	.differential = 0,
+	.indexed = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_all =
+				BIT(IIO_CHAN_INFO_SCALE) |
+				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_shared_by_all_available =
+				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	.datasheet_name = "AIN",
+};
+
+static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
+{
+	int ret;
+	u8 config = (data->config & ~mask) | value;
+
+	if (data->config == config)
+		return 0; /* Already done */
+
+	ret = i2c_master_send(data->client, &config, 1);
+	if (ret < 0)
+		return ret;
+
+	data->config = config;
+	return 0;
+};
+
+static int ads1100_set_conv_mode(struct ads1100_data *data, u8 flag)
+{
+	return ads1100_set_config_bits(data, ADS1100_CFG_SC, flag);
+};
+
+static int ads1100_data_rate_index(struct ads1100_data *data)
+{
+	return (data->config & ADS1100_DR_MASK) >> ADS1100_DR_SHIFT;
+}
+
+static int ads1100_pga_index(struct ads1100_data *data)
+{
+	return (data->config & ADS1100_PGA_MASK);
+}
+
+/* Calculate full-scale value */
+static int ads1100_full_scale(struct ads1100_data *data)
+{
+	return ads1100_data_rate_scale[ads1100_data_rate_index(data)] *
+			ads1100_gain[ads1100_pga_index(data)];
+
+}
+
+#ifdef CONFIG_PM
+static int ads1100_set_power_state(struct ads1100_data *data, bool on)
+{
+	int ret;
+	struct device *dev = &data->client->dev;
+
+	if (on) {
+		ret = pm_runtime_resume_and_get(dev);
+	} else {
+		pm_runtime_mark_last_busy(dev);
+		ret = pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+#else /* !CONFIG_PM */
+
+static int ads1100_set_power_state(struct ads1100_data *data, bool on)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_PM */
+
+static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
+{
+	int ret;
+	u8 buffer[2];
+
+	if (chan != 0)
+		return -EINVAL;
+
+	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	*val = (s16)(((u16)buffer[0] << 8) | buffer[1]);
+	return 0;
+}
+
+static int ads1100_set_gain(struct ads1100_data *data, int gain)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ads1100_gain); ++i) {
+		if (ads1100_gain[i] == gain) {
+			return ads1100_set_config_bits(
+						data, ADS1100_PGA_MASK, i);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
+{
+	int i;
+	int size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+
+	for (i = 0; i < size; ++i) {
+		if (ads1100_data_rate[i] == rate) {
+			return ads1100_set_config_bits(
+				data, ADS1100_DR_MASK, i << ADS1100_DR_SHIFT);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ads1100_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1100_data_rate;
+		if (data->supports_data_rate)
+			*length = ARRAY_SIZE(ads1100_data_rate);
+		else
+			*length = 1;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*type = IIO_VAL_INT;
+		*vals = ads1100_gain;
+		*length = ARRAY_SIZE(ads1100_gain);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1100_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret;
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	dev_info(&data->client->dev, "%s %ld\n", __func__, mask);
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			break;
+
+		ret = ads1100_set_power_state(data, true);
+		if (ret < 0)
+			goto release_direct;
+
+		ret = ads1100_get_adc_result(data, chan->address, val);
+		if (ret < 0) {
+			ads1100_set_power_state(data, false);
+			goto release_direct;
+		}
+
+		ret = ads1100_set_power_state(data, false);
+		if (ret < 0)
+			goto release_direct;
+
+		ret = IIO_VAL_INT;
+release_direct:
+		iio_device_release_direct_mode(indio_dev);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(data->reg_vdd);
+		if (ret > 0) {
+			/* full-scale is the supply voltage (microvolts now) */
+			*val = ret / 1000; /* millivolts, range 27000..50000 */
+			*val2 = 1000 * ads1100_full_scale(data);
+			ret = IIO_VAL_FRACTIONAL;
+		}
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ads1100_data_rate[ads1100_data_rate_index(data)];
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*val = ads1100_gain[ads1100_pga_index(data)];
+		*val2 = 0;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads1100_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1100_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = ads1100_set_gain(data, val);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads1100_set_data_rate(data, chan->address, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static const struct iio_info ads1100_info = {
+	.read_avail	= ads1100_read_avail,
+	.read_raw	= ads1100_read_raw,
+	.write_raw	= ads1100_write_raw,
+};
+
+static int ads1100_setup(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	/* Setup continuous sampling mode at 8sps */
+	buffer[0] = ADS1100_DR_MASK | ADS1100_CONTINUOUS;
+	ret = i2c_master_send(data->client, buffer, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
+	if (ret < 0)
+		return ret;
+
+	/* Config register returned in third byte, strip away the busy status */
+	data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
+
+	/* Detect the sample rate capability by checking the DR bits */
+	data->supports_data_rate = !!(buffer[2] & ADS1100_DR_MASK);
+
+	return 0;
+}
+
+static int ads1100_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads1100_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->name = ADS1100_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &ads1100_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ads1100_info;
+
+	data->reg_vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->reg_vdd))
+		return PTR_ERR(data->reg_vdd);
+
+	ret = regulator_enable(data->reg_vdd);
+	if (ret < 0)
+		return ret;
+
+	ret = ads1100_setup(data);
+	if (ret) {
+		dev_err(&client->dev, "Failed to communicate with device\n");
+		goto exit_regulator;
+	}
+
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret)
+		goto exit_regulator;
+
+	pm_runtime_set_autosuspend_delay(&client->dev, ADS1100_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(&client->dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to register IIO device\n");
+		return ret;
+	}
+
+	return 0;
+
+exit_regulator:
+	regulator_disable(data->reg_vdd);
+	return ret;
+}
+
+static void ads1100_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+}
+
+#ifdef CONFIG_PM
+static int ads1100_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
+	regulator_disable(data->reg_vdd);
+
+	return 0;
+}
+
+static int ads1100_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads1100_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(data->reg_vdd);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to enable Vdd\n");
+		return ret;
+	}
+
+	/*
+	 * We'll always change the mode bit in the config register, so there is
+	 * no need here to "force" a write to the config register. If the device
+	 * has been power-cycled, we'll re-write its config register now.
+	 */
+	return ads1100_set_conv_mode(data, ADS1100_CONTINUOUS);
+}
+#endif
+
+static const struct dev_pm_ops ads1100_pm_ops = {
+	SET_RUNTIME_PM_OPS(ads1100_runtime_suspend,
+			   ads1100_runtime_resume, NULL)
+};
+
+static const struct i2c_device_id ads1100_id[] = {
+	{ "ads1100", },
+	{ "ads1000", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ads1100_id);
+
+static const struct of_device_id ads1100_of_match[] = {
+	{ .compatible = "ti,ads1100", },
+	{ .compatible = "ti,ads1000", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ads1100_of_match);
+
+static struct i2c_driver ads1100_driver = {
+	.driver = {
+		.name = ADS1100_DRV_NAME,
+		.of_match_table = ads1100_of_match,
+		.pm = &ads1100_pm_ops,
+	},
+	.probe_new	= ads1100_probe,
+	.remove		= ads1100_remove,
+	.id_table	= ads1100_id,
+};
+
+module_i2c_driver(ads1100_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Texas Instruments ADS1100 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

