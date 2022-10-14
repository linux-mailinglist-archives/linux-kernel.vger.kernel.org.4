Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C385FEE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJNMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJNMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:38:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72694181D85;
        Fri, 14 Oct 2022 05:38:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so10141428ejc.12;
        Fri, 14 Oct 2022 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DbSTqMtmil4bDo/7Sw0Chebj9TIzPLTvQ9p9KgLL5Y=;
        b=T0VZsdUuPTSLZ0K7P1QzKvHL6TAjTRhahbUJdFGS1sn15HDxubQShC+Uf/9f/qciTN
         S/0OdVW/050dRCMNeCo0QpcZi1bgl8pVnmkIHwGZph1FEDXO/58+i6bQhCLu24rEVmkO
         gAN4RoDNiZUhdIOR3DHNTbZ3QM8JCsdyU5itY9MwHco1na4f7DZoTynGHY5KaZ4Y7nav
         8LeQZQ6dCZefZRulX08qDgF1UBytYqxCEVXBpdC70uPJ1DGvxL7EZknGbvF2H7c66p+O
         ZZ9WED3QHAW9Azln4m8IGFDvIAQ91G7oLfR/bBN/TdeWV9OdV3/1p9YtxRVFlu3u//dU
         wOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DbSTqMtmil4bDo/7Sw0Chebj9TIzPLTvQ9p9KgLL5Y=;
        b=I7zrwhRH0w6bHS8BX1RPYa0PjY0jxZS+fx+NX/1lGnozG2fonsQN8laBLirF6OTKow
         Yt+P43HUFYU3XJon+jZ4aXTj60AuHKBk+aLC+p8UVP8ZIFs9t8OxULaKdivYcVQc1McF
         sEReKI6X1/co4AhyV2VW73qaVoMNZxWoeW3JayrSO4XMjAG764v3M1UoveS4FUXC/Q25
         OB3R2WZUTg7UWYkyFf+aJPyiEwEohE1mWlLOCuRXE5oPt4YR8fENbW6uFsAN0nA+39Ae
         P/xQn6bIHdWy7o+foGPhK59yDY4qHCABcIDXZqX83si450uWHG+Q02hiPbtU5ZZn3zTe
         Aanw==
X-Gm-Message-State: ACrzQf0WNj+Juk4PfrR17VCqWFGzXfjH2w+56OLjFW0zQKvexmR/9xkM
        9lMW9I+1wav9QsbufmP/RZ8=
X-Google-Smtp-Source: AMsMyM6ss0cPjszZFZD/enEVsP7oiCvZobrT6FwBrTfEK5wlOZn3WimIBhO81L9JFMvWXP+cyuGhwA==
X-Received: by 2002:a17:907:8a1c:b0:78d:ef44:7759 with SMTP id sc28-20020a1709078a1c00b0078def447759mr3469886ejc.441.1665751088914;
        Fri, 14 Oct 2022 05:38:08 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dk24-20020a0564021d9800b0045b910b0542sm1774756edb.15.2022.10.14.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 05:38:08 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH 3/3] iio: temperature: ltc2983: support more parts
Date:   Fri, 14 Oct 2022 15:37:24 +0300
Message-Id: <20221014123724.1401011-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014123724.1401011-1-demonsingur@gmail.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 182 ++++++++++++++++++++++++++++--
 1 file changed, 175 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index a60ccf183687..22977bcdd2a3 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -25,9 +25,12 @@
 #define LTC2983_STATUS_REG			0x0000
 #define LTC2983_TEMP_RES_START_REG		0x0010
 #define LTC2983_TEMP_RES_END_REG		0x005F
+#define LTC2983_EEPROM_KEY_REG			0x00B0
+#define LTC2983_EEPROM_READ_STATUS_REG		0x00D0
 #define LTC2983_GLOBAL_CONFIG_REG		0x00F0
 #define LTC2983_MULT_CHANNEL_START_REG		0x00F4
 #define LTC2983_MULT_CHANNEL_END_REG		0x00F7
+#define LTC2986_EEPROM_STATUS_REG		0x00F9
 #define LTC2983_MUX_CONFIG_REG			0x00FF
 #define LTC2983_CHAN_ASSIGN_START_REG		0x0200
 #define LTC2983_CHAN_ASSIGN_END_REG		0x024F
@@ -35,13 +38,21 @@
 #define LTC2983_CUST_SENS_TBL_END_REG		0x03CF
 
 #define LTC2983_DIFFERENTIAL_CHAN_MIN		2
-#define LTC2983_MAX_CHANNELS_NR			20
 #define LTC2983_MIN_CHANNELS_NR			1
 #define LTC2983_SLEEP				0x97
 #define LTC2983_CUSTOM_STEINHART_SIZE		24
 #define LTC2983_CUSTOM_SENSOR_ENTRY_SZ		6
 #define LTC2983_CUSTOM_STEINHART_ENTRY_SZ	4
 
+#define LTC2983_EEPROM_KEY			0xA53C0F5A
+#define LTC2983_EEPROM_WRITE_CMD		0x15
+#define LTC2983_EEPROM_READ_CMD			0x16
+#define LTC2983_EEPROM_STATUS_FAILURE_MASK	GENMASK(3, 1)
+#define LTC2983_EEPROM_READ_FAILURE_MASK	GENMASK(7, 0)
+
+#define LTC2983_EEPROM_WRITE_TIME_MS		2600
+#define LTC2983_EEPROM_READ_TIME_MS		20
+
 #define LTC2983_CHAN_START_ADDR(chan) \
 			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
 #define LTC2983_CHAN_RES_ADDR(chan) \
@@ -171,6 +182,7 @@ enum {
 	LTC2983_SENSOR_DIODE = 28,
 	LTC2983_SENSOR_SENSE_RESISTOR = 29,
 	LTC2983_SENSOR_DIRECT_ADC = 30,
+	LTC2983_SENSOR_ACTIVE_TEMP = 31,
 };
 
 #define to_thermocouple(_sensor) \
@@ -191,7 +203,17 @@ enum {
 #define to_adc(_sensor) \
 		container_of(_sensor, struct ltc2983_adc, sensor)
 
+#define to_temp(_sensor) \
+		container_of(_sensor, struct ltc2983_temp, sensor)
+
+struct ltc2983_chip_info {
+	unsigned int max_channels_nr;
+	bool has_temp;
+	bool has_eeprom;
+};
+
 struct ltc2983_data {
+	const struct ltc2983_chip_info *info;
 	struct regmap *regmap;
 	struct spi_device *spi;
 	struct mutex lock;
@@ -271,6 +293,12 @@ struct ltc2983_adc {
 	bool single_ended;
 };
 
+struct ltc2983_temp {
+	struct ltc2983_sensor sensor;
+	struct ltc2983_custom_sensor *custom;
+	bool single_ended;
+};
+
 /*
  * Convert to Q format numbers. These number's are integers where
  * the number of integer and fractional bits are specified. The resolution
@@ -606,6 +634,22 @@ static int ltc2983_adc_assign_chan(struct ltc2983_data *st,
 	return __ltc2983_chan_assign_common(st, sensor, chan_val);
 }
 
+static int ltc2983_temp_assign_chan(struct ltc2983_data *st,
+				    const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_temp *temp = to_temp(sensor);
+	u32 chan_val;
+	int ret;
+
+	chan_val = LTC2983_ADC_SINGLE_ENDED(temp->single_ended);
+
+	ret = __ltc2983_chan_custom_sensor_assign(st, temp->custom, &chan_val);
+	if (ret)
+		return ret;
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
 static struct ltc2983_sensor *
 ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			 const struct ltc2983_sensor *sensor)
@@ -771,10 +815,10 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	if (rtd->sensor_config & LTC2983_RTD_4_WIRE_MASK) {
 		/* 4-wire */
 		u8 min = LTC2983_DIFFERENTIAL_CHAN_MIN,
-			max = LTC2983_MAX_CHANNELS_NR;
+			max = st->info->max_channels_nr;
 
 		if (rtd->sensor_config & LTC2983_RTD_ROTATION_MASK)
-			max = LTC2983_MAX_CHANNELS_NR - 1;
+			max = st->info->max_channels_nr - 1;
 
 		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
 		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
@@ -1143,6 +1187,38 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 	return &adc->sensor;
 }
 
+static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
+					       struct ltc2983_data *st,
+					       const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_temp *temp;
+
+	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	if (!temp)
+		return ERR_PTR(-ENOMEM);
+
+	if (fwnode_property_read_bool(child, "adi,single-ended"))
+		temp->single_ended = true;
+
+	if (!temp->single_ended &&
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+		dev_err(&st->spi->dev, "Invalid chan:%d for differential temp\n",
+			sensor->chan);
+		return ERR_PTR(-EINVAL);
+	}
+
+	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
+						   false, 4096, true);
+	if (IS_ERR(temp->custom))
+		return ERR_CAST(temp->custom);
+
+	/* set common parameters */
+	temp->sensor.assign_chan = ltc2983_temp_assign_chan;
+	temp->sensor.fault_handler = ltc2983_common_fault_handler;
+
+	return &temp->sensor;
+}
+
 static int ltc2983_chan_read(struct ltc2983_data *st,
 			const struct ltc2983_sensor *sensor, int *val)
 {
@@ -1302,10 +1378,10 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 
 		/* check if we have a valid channel */
 		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
-		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
+		    sensor.chan > st->info->max_channels_nr) {
 			ret = -EINVAL;
 			dev_err(dev, "chan:%d must be from %u to %u\n", sensor.chan,
-				LTC2983_MIN_CHANNELS_NR, LTC2983_MAX_CHANNELS_NR);
+				LTC2983_MIN_CHANNELS_NR, st->info->max_channels_nr);
 			goto put_child;
 		} else if (channel_avail_mask & BIT(sensor.chan)) {
 			ret = -EINVAL;
@@ -1345,6 +1421,9 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 			st->iio_channels--;
 		} else if (sensor.type == LTC2983_SENSOR_DIRECT_ADC) {
 			st->sensors[chan] = ltc2983_adc_new(child, st, &sensor);
+		} else if (st->info->has_temp &&
+			   sensor.type == LTC2983_SENSOR_ACTIVE_TEMP) {
+			st->sensors[chan] = ltc2983_temp_new(child, st, &sensor);
 		} else {
 			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
 			ret = -EINVAL;
@@ -1371,6 +1450,46 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 	return ret;
 }
 
+static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
+			      unsigned int wait_time, unsigned int status_reg,
+			      unsigned long status_fail_mask)
+{
+	__be32 bval = cpu_to_be32(LTC2983_EEPROM_KEY);
+	unsigned long time;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_bulk_write(st->regmap, LTC2983_EEPROM_KEY_REG, &bval,
+				sizeof(bval));
+	if (ret)
+		return ret;
+
+	reinit_completion(&st->completion);
+
+	ret = regmap_write(st->regmap, LTC2983_STATUS_REG,
+			   LTC2983_STATUS_START(true) | cmd);
+	if (ret)
+		return ret;
+
+	time = wait_for_completion_timeout(&st->completion,
+					   msecs_to_jiffies(wait_time));
+	if (!time) {
+		dev_err(&st->spi->dev, "EEPROM command timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = regmap_read(st->regmap, status_reg, &val);
+	if (ret)
+		return ret;
+
+	if (val & status_fail_mask) {
+		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
 	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
@@ -1396,6 +1515,15 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 	if (ret)
 		return ret;
 
+	if (st->info->has_eeprom && !assign_iio) {
+		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_READ_CMD,
+					 LTC2983_EEPROM_READ_TIME_MS,
+					 LTC2983_EEPROM_READ_STATUS_REG,
+					 LTC2983_EEPROM_READ_FAILURE_MASK);
+		if (!ret)
+			return 0;
+	}
+
 	for (chan = 0; chan < st->num_channels; chan++) {
 		u32 chan_type = 0, *iio_chan;
 
@@ -1435,9 +1563,13 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 static const struct regmap_range ltc2983_reg_ranges[] = {
 	regmap_reg_range(LTC2983_STATUS_REG, LTC2983_STATUS_REG),
 	regmap_reg_range(LTC2983_TEMP_RES_START_REG, LTC2983_TEMP_RES_END_REG),
+	regmap_reg_range(LTC2983_EEPROM_KEY_REG, LTC2983_EEPROM_KEY_REG),
+	regmap_reg_range(LTC2983_EEPROM_READ_STATUS_REG,
+			 LTC2983_EEPROM_READ_STATUS_REG),
 	regmap_reg_range(LTC2983_GLOBAL_CONFIG_REG, LTC2983_GLOBAL_CONFIG_REG),
 	regmap_reg_range(LTC2983_MULT_CHANNEL_START_REG,
 			 LTC2983_MULT_CHANNEL_END_REG),
+	regmap_reg_range(LTC2986_EEPROM_STATUS_REG, LTC2986_EEPROM_STATUS_REG),
 	regmap_reg_range(LTC2983_MUX_CONFIG_REG, LTC2983_MUX_CONFIG_REG),
 	regmap_reg_range(LTC2983_CHAN_ASSIGN_START_REG,
 			 LTC2983_CHAN_ASSIGN_END_REG),
@@ -1482,6 +1614,12 @@ static int ltc2983_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	st->info = device_get_match_data(&spi->dev);
+	if (!st->info)
+		st->info = (void *)spi_get_device_id(spi)->driver_data;
+	if (!st->info)
+		return -ENODEV;
+
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
 	if (IS_ERR(st->regmap)) {
 		dev_err(&spi->dev, "Failed to initialize regmap\n");
@@ -1524,6 +1662,15 @@ static int ltc2983_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	if (st->info->has_eeprom) {
+		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
+					 LTC2983_EEPROM_WRITE_TIME_MS,
+					 LTC2986_EEPROM_STATUS_REG,
+					 LTC2983_EEPROM_STATUS_FAILURE_MASK);
+		if (ret)
+			return ret;
+	}
+
 	indio_dev->name = name;
 	indio_dev->num_channels = st->iio_channels;
 	indio_dev->channels = st->iio_chan;
@@ -1554,14 +1701,35 @@ static int ltc2983_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
 				ltc2983_resume);
 
+static const struct ltc2983_chip_info ltc2983_chip_info_data = {
+	.max_channels_nr = 20,
+};
+
+static const struct ltc2983_chip_info ltc2984_chip_info_data = {
+	.max_channels_nr = 20,
+	.has_eeprom = true,
+};
+
+static const struct ltc2983_chip_info ltc2986_chip_info_data = {
+	.max_channels_nr = 10,
+	.has_temp = true,
+	.has_eeprom = true,
+};
+
 static const struct spi_device_id ltc2983_id_table[] = {
-	{ "ltc2983" },
+	{ "ltc2983", (kernel_ulong_t)&ltc2983_chip_info_data },
+	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
+	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
+	{ "ltm2985", (kernel_ulong_t)&ltc2986_chip_info_data },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
 
 static const struct of_device_id ltc2983_of_match[] = {
-	{ .compatible = "adi,ltc2983" },
+	{ .compatible = "adi,ltc2983", .data = &ltc2983_chip_info_data },
+	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
+	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
+	{ .compatible = "adi,ltm2985", .data = &ltc2986_chip_info_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltc2983_of_match);
-- 
2.37.3

