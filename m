Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCA67FC2B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjA2Bfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjA2Bfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:35:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1A227BB;
        Sat, 28 Jan 2023 17:34:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l35-20020a05600c1d2300b003dc4634a466so1786576wms.4;
        Sat, 28 Jan 2023 17:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5OPwoktr/gHLCZIx1nzPWjzcvgFIbWWXHyNhPqOslY=;
        b=ASp2JV8xsqi/naxj1oeuPaSQq99D5QfIeiYf+g+MXDzOXCarrPJP+P2PyLzmtGhk5+
         /bARaPZ4meSCKlB5cmWm41ojBpkTLSPP4Vt164OcHKUl5rtq7BqQkt8TWMfCXzW3wx7J
         8BKMKlZZDw8DN79zYn2HxWE0tg7syR/+JuaQi9lte2fpWKIt7L0feSAsWPLFZvo2I6sN
         VjcTkufdzkXPGUSjnUvYZLia8PfTpOnmcOctAE8s3XFjEco4EKK+z9+ubeYWlrvooaFx
         uNIQs3KWyWyPV8fzdnowXrEEkfrtge7p+/tvzVKBMH3LSBUSs6R+V1/YqDNBqztPZ49M
         bG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5OPwoktr/gHLCZIx1nzPWjzcvgFIbWWXHyNhPqOslY=;
        b=JW70G1I4HfMdZR9P6w3hAymXiqcfkIRSA8KBA3K01NH1ff6pTerE8TG9QS9xKCyR+H
         5XH1rSjtvAOqY+OaImHutvj5DhhiSWzFjWTx2+1uzkIeB3M9WY1ylccFNEcEsTiJvq2O
         imzL4nID7phGm7VkYtH2YcrmYme8pNOShzXcbKePPTcYPRIH/+6ugOLlBOQnpTrhlbXm
         AMTUrvCT3kJ0yoUz/O7N1uTRXgy1OZe6FYXeloAch7oOVFeUCFazeHOnhC7bvZ2VeCh1
         /9SdDxoMft3F69BsqHjZkXj+dHd0Yl+fmOxNNV8sfd3Thl4gDbSOzxqZK1JTiqIOj5Gp
         8Mag==
X-Gm-Message-State: AO0yUKX3wMrLBtYBK/772cDm5Y3+6MUhpkVV+8/21DW47ZYCajOotD6c
        skOZQWuxgbhQn/DXiBC/SX4ULSIOW/U=
X-Google-Smtp-Source: AK7set/OGtDpMplzR30bAhx/iRoYeymYvSOfbirw7zWEU09d9SrgLUD3VIK3qHG49o7GYF8GMjAQ+w==
X-Received: by 2002:a05:600c:3d86:b0:3dc:53a2:2690 with SMTP id bi6-20020a05600c3d8600b003dc53a22690mr535459wmb.7.1674956097873;
        Sat, 28 Jan 2023 17:34:57 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:34:57 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] iio: pressure: bmp280: Add support for new sensor BMP580
Date:   Sun, 29 Jan 2023 02:33:07 +0100
Message-Id: <97a234ddac057eea1e6790d7fa4a66564abec2ed.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds compatibility with the new sensor generation, the BMP580.

The measurement and initialization codepaths are adapted from
the device datasheet and the repository from manufacturer at
https://github.com/boschsensortec/BMP5-Sensor-API.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index cec4b429cd64..02b97e89de50 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -17,14 +17,14 @@ config ABP060MG
 	  will be called abp060mg.
 
 config BMP280
-	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor driver"
+	tristate "Bosch Sensortec BMP180/BMP280/BMP380/BMP580 pressure sensor driver"
 	depends on (I2C || SPI_MASTER)
 	select REGMAP
 	select BMP280_I2C if (I2C)
 	select BMP280_SPI if (SPI_MASTER)
 	help
-	  Say yes here to build support for Bosch Sensortec BMP180, BMP280 and
-	  BMP380 pressure and temperature sensors. Also supports the BME280 with
+	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
+	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
 	  an additional humidity sensor channel.
 
 	  To compile this driver as a module, choose M here: the core module
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 22addaaa5393..c65fb4025ad9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -13,6 +13,7 @@
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp581-ds004.pdf
  *
  * Notice:
  * The link to the bmp180 datasheet points to an outdated version missing these changes:
@@ -71,6 +72,41 @@ enum bmp380_odr {
 	BMP380_ODR_0_0015HZ,
 };
 
+enum bmp580_odr {
+	BMP580_ODR_240HZ,
+	BMP580_ODR_218HZ,
+	BMP580_ODR_199HZ,
+	BMP580_ODR_179HZ,
+	BMP580_ODR_160HZ,
+	BMP580_ODR_149HZ,
+	BMP580_ODR_140HZ,
+	BMP580_ODR_129HZ,
+	BMP580_ODR_120HZ,
+	BMP580_ODR_110HZ,
+	BMP580_ODR_100HZ,
+	BMP580_ODR_89HZ,
+	BMP580_ODR_80HZ,
+	BMP580_ODR_70HZ,
+	BMP580_ODR_60HZ,
+	BMP580_ODR_50HZ,
+	BMP580_ODR_45HZ,
+	BMP580_ODR_40HZ,
+	BMP580_ODR_35HZ,
+	BMP580_ODR_30HZ,
+	BMP580_ODR_25HZ,
+	BMP580_ODR_20HZ,
+	BMP580_ODR_15HZ,
+	BMP580_ODR_10HZ,
+	BMP580_ODR_5HZ,
+	BMP580_ODR_4HZ,
+	BMP580_ODR_3HZ,
+	BMP580_ODR_2HZ,
+	BMP580_ODR_1HZ,
+	BMP580_ODR_0_5HZ,
+	BMP580_ODR_0_25HZ,
+	BMP580_ODR_0_125HZ,
+};
+
 /*
  * These enums are used for indexing into the array of compensation
  * parameters for BMP280.
@@ -1216,6 +1252,303 @@ const struct bmp280_chip_info bmp380_chip_info = {
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
+/*
+ * BMP5xx soft reset procedure
+ */
+static int bmp580_soft_reset(struct bmp280_data *data)
+{
+	unsigned int reg;
+	int ret;
+
+	/* Write reset word to CMD register */
+	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_SOFT_RESET);
+	if (ret) {
+		dev_err(data->dev, "failed to send reset command to device\n");
+		return ret;
+	}
+	/* Wait 2ms for reset completion */
+	usleep_range(2000, 2500);
+
+	/* Dummy read of chip_id */
+	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to reestablish comms after reset\n");
+		return ret;
+	}
+
+	/* Check if POR bit is set on interrupt reg */
+	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "error reading interrupt status register\n");
+		return ret;
+	}
+	if (!(reg & BMP580_INT_STATUS_POR_MASK)) {
+		dev_err(data->dev, "error resetting sensor\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Contrary to previous sensors families, compensation algorithm is builtin.
+ * We are only required to read the register raw data and adapt the ranges
+ * for what is expected on IIO ABI.
+ */
+
+static int bmp580_read_temp(struct bmp280_data *data, int *val)
+{
+	s32 raw_temp;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
+			       sizeof(data->buf));
+	if (ret) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	raw_temp = get_unaligned_le24(data->buf);
+	if (raw_temp == BMP580_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+
+	/*
+	 * Temperature is returned in Celsius degrees in fractional
+	 * form down 2^16. We reescale by x1000 to return milli Celsius
+	 * to respect IIO ABI.
+	 */
+	*val = (raw_temp * 1000) >> 16;
+	return IIO_VAL_INT;
+}
+
+static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
+{
+	u32 raw_press;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
+			       sizeof(data->buf));
+	if (ret) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	raw_press = get_unaligned_le24(data->buf);
+	if (raw_press == BMP580_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	/*
+	 * Pressure is returned in Pascals in fractional form down 2^16.
+	 * We reescale /1000 to convert to kilopascal to respect IIO ABI.
+	 */
+	*val = raw_press;
+	*val2 = 64000; /* 2^6 * 1000 */
+	return IIO_VAL_FRACTIONAL;
+}
+
+static const int bmp580_odr_table[][2] = {
+	[BMP580_ODR_240HZ] =	{240, 0},
+	[BMP580_ODR_218HZ] =	{218, 0},
+	[BMP580_ODR_199HZ] =	{199, 0},
+	[BMP580_ODR_179HZ] =	{179, 0},
+	[BMP580_ODR_160HZ] =	{160, 0},
+	[BMP580_ODR_149HZ] =	{149, 0},
+	[BMP580_ODR_140HZ] =	{140, 0},
+	[BMP580_ODR_129HZ] =	{129, 0},
+	[BMP580_ODR_120HZ] =	{120, 0},
+	[BMP580_ODR_110HZ] =	{110, 0},
+	[BMP580_ODR_100HZ] =	{100, 0},
+	[BMP580_ODR_89HZ] =	{89, 0},
+	[BMP580_ODR_80HZ] =	{80, 0},
+	[BMP580_ODR_70HZ] =	{70, 0},
+	[BMP580_ODR_60HZ] =	{60, 0},
+	[BMP580_ODR_50HZ] =	{50, 0},
+	[BMP580_ODR_45HZ] =	{45, 0},
+	[BMP580_ODR_40HZ] =	{40, 0},
+	[BMP580_ODR_35HZ] =	{35, 0},
+	[BMP580_ODR_30HZ] =	{30, 0},
+	[BMP580_ODR_25HZ] =	{25, 0},
+	[BMP580_ODR_20HZ] =	{20, 0},
+	[BMP580_ODR_15HZ] =	{15, 0},
+	[BMP580_ODR_10HZ] =	{10, 0},
+	[BMP580_ODR_5HZ] =	{5, 0},
+	[BMP580_ODR_4HZ] =	{4, 0},
+	[BMP580_ODR_3HZ] =	{3, 0},
+	[BMP580_ODR_2HZ] =	{2, 0},
+	[BMP580_ODR_1HZ] =	{1, 0},
+	[BMP580_ODR_0_5HZ] =	{0, 500000},
+	[BMP580_ODR_0_25HZ] =	{0, 250000},
+	[BMP580_ODR_0_125HZ] =	{0, 125000},
+};
+
+static int bmp580_preinit(struct bmp280_data *data)
+{
+	unsigned int reg;
+	int ret;
+
+	/* Issue soft-reset command */
+	ret = bmp580_soft_reset(data);
+	if (ret)
+		return ret;
+
+	/* Post powerup sequence */
+	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
+	if (ret)
+		return ret;
+
+	/* Print warn message if we don't know the chip id */
+	if (reg != BMP580_CHIP_ID && reg != BMP580_CHIP_ID_ALT)
+		dev_warn(data->dev, "preinit: unexpected chip_id\n");
+
+	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+	if (ret)
+		return ret;
+
+	/* Check nvm status */
+	if (!(reg & BMP580_STATUS_NVM_RDY_MASK) || (reg & BMP580_STATUS_NVM_ERR_MASK)) {
+		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int bmp580_chip_config(struct bmp280_data *data)
+{
+	bool change = false, aux;
+	unsigned int tmp;
+	u8 reg_val;
+	int ret;
+
+	/* Sets sensor in standby mode */
+	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
+				 BMP580_ODR_DEEPSLEEP_DIS |
+				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
+	if (ret) {
+		dev_err(data->dev, "failed to change sensor to standby mode\n");
+		return ret;
+	}
+	/* From datasheet's table 4: electrical characteristics */
+	usleep_range(2500, 3000);
+
+	/* Set default DSP mode settings */
+	reg_val = FIELD_PREP(BMP580_DSP_COMP_MASK, BMP580_DSP_PRESS_TEMP_COMP_EN) |
+		  BMP580_DSP_SHDW_IIR_TEMP_EN | BMP580_DSP_SHDW_IIR_PRESS_EN;
+
+	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_CONFIG,
+				 BMP580_DSP_COMP_MASK |
+				 BMP580_DSP_SHDW_IIR_TEMP_EN |
+				 BMP580_DSP_SHDW_IIR_PRESS_EN, reg_val);
+
+	/* Configure oversampling */
+	reg_val = FIELD_PREP(BMP580_OSR_TEMP_MASK, data->oversampling_temp) |
+		  FIELD_PREP(BMP580_OSR_PRESS_MASK, data->oversampling_press) |
+		  BMP580_OSR_PRESS_EN;
+
+	ret = regmap_update_bits_check(data->regmap, BMP580_REG_OSR_CONFIG,
+				       BMP580_OSR_TEMP_MASK | BMP580_OSR_PRESS_MASK |
+				       BMP580_OSR_PRESS_EN,
+				       reg_val, &aux);
+	if (ret) {
+		dev_err(data->dev, "failed to write oversampling register\n");
+		return ret;
+	}
+	change = change || aux;
+
+	/* Configure output data rate */
+	ret = regmap_update_bits_check(data->regmap, BMP580_REG_ODR_CONFIG, BMP580_ODR_MASK,
+				       FIELD_PREP(BMP580_ODR_MASK, data->sampling_freq),
+				       &aux);
+	if (ret) {
+		dev_err(data->dev, "failed to write ODR configuration register\n");
+		return ret;
+	}
+	change = change || aux;
+
+	/* Set filter data */
+	reg_val = FIELD_PREP(BMP580_DSP_IIR_PRESS_MASK, data->iir_filter_coeff) |
+		  FIELD_PREP(BMP580_DSP_IIR_TEMP_MASK, data->iir_filter_coeff);
+
+	ret = regmap_update_bits_check(data->regmap, BMP580_REG_DSP_IIR,
+				       BMP580_DSP_IIR_PRESS_MASK |
+				       BMP580_DSP_IIR_TEMP_MASK,
+				       reg_val, &aux);
+	if (ret) {
+		dev_err(data->dev, "failed to write config register\n");
+		return ret;
+	}
+	change = change || aux;
+
+	/* Restore sensor to normal operation mode */
+	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				BMP580_MODE_MASK,
+				FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_NORMAL));
+	if (ret) {
+		dev_err(data->dev, "failed to set normal mode\n");
+		return ret;
+	}
+	/* From datasheet's table 4: electrical characteristics */
+	usleep_range(3000, 3500);
+
+	if (change) {
+		/*
+		 * Check if ODR and OSR settings are valid or we are
+		 * operating in a degraded mode.
+		 */
+		ret = regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
+		if (ret) {
+			dev_err(data->dev, "error reading effective OSR register\n");
+			return ret;
+		}
+		if (!(tmp & BMP580_EFF_OSR_VALID_ODR)) {
+			dev_warn(data->dev, "OSR and ODR incompatible settings detected\n");
+			/* Set current OSR settings from data on effective OSR */
+			data->oversampling_temp = FIELD_GET(BMP580_EFF_OSR_TEMP_MASK, tmp);
+			data->oversampling_press = FIELD_GET(BMP580_EFF_OSR_PRESS_MASK, tmp);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+
+const struct bmp280_chip_info bmp580_chip_info = {
+	.id_reg = BMP580_REG_CHIP_ID,
+	.chip_id = BMP580_CHIP_ID,
+	.regmap_config = &bmp580_regmap_config,
+	.start_up_time = 2000,
+	.channels = bmp380_channels,
+	.num_channels = 2,
+
+	.oversampling_temp_avail = bmp580_oversampling_avail,
+	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
+	.oversampling_temp_default = ilog2(1),
+
+	.oversampling_press_avail = bmp580_oversampling_avail,
+	.num_oversampling_press_avail = ARRAY_SIZE(bmp580_oversampling_avail),
+	.oversampling_press_default = ilog2(4),
+
+	.sampling_freq_avail = bmp580_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp580_odr_table) * 2,
+	.sampling_freq_default = BMP580_ODR_50HZ,
+
+	.iir_filter_coeffs_avail = bmp380_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
+	.chip_config = bmp580_chip_config,
+	.read_temp = bmp580_read_temp,
+	.read_press = bmp580_read_press,
+	.preinit = bmp580_preinit,
+};
+EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
+
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
 	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 5f908e2c9826..567b945e6427 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -34,6 +34,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
 	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
 	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
+	{ .compatible = "bosch,bmp580", .data = &bmp580_chip_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
@@ -44,6 +45,7 @@ static const struct i2c_device_id bmp280_i2c_id[] = {
 	{"bmp280", (kernel_ulong_t)&bmp280_chip_info },
 	{"bme280", (kernel_ulong_t)&bme280_chip_info },
 	{"bmp380", (kernel_ulong_t)&bmp380_chip_info },
+	{"bmp580", (kernel_ulong_t)&bmp580_chip_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index c98c67970265..3ee56720428c 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -115,6 +115,54 @@ static bool bmp380_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool bmp580_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP580_REG_NVM_DATA_MSB:
+	case BMP580_REG_NVM_DATA_LSB:
+	case BMP580_REG_NVM_ADDR:
+	case BMP580_REG_ODR_CONFIG:
+	case BMP580_REG_OSR_CONFIG:
+	case BMP580_REG_INT_SOURCE:
+	case BMP580_REG_INT_CONFIG:
+	case BMP580_REG_OOR_THR_MSB:
+	case BMP580_REG_OOR_THR_LSB:
+	case BMP580_REG_OOR_CONFIG:
+	case BMP580_REG_OOR_RANGE:
+	case BMP580_REG_IF_CONFIG:
+	case BMP580_REG_FIFO_CONFIG:
+	case BMP580_REG_FIFO_SEL:
+	case BMP580_REG_DSP_CONFIG:
+	case BMP580_REG_DSP_IIR:
+	case BMP580_REG_CMD:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bmp580_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP580_REG_NVM_DATA_MSB:
+	case BMP580_REG_NVM_DATA_LSB:
+	case BMP580_REG_FIFO_COUNT:
+	case BMP580_REG_INT_STATUS:
+	case BMP580_REG_PRESS_XLSB:
+	case BMP580_REG_PRESS_LSB:
+	case BMP580_REG_PRESS_MSB:
+	case BMP580_REG_FIFO_DATA:
+	case BMP580_REG_TEMP_XLSB:
+	case BMP580_REG_TEMP_LSB:
+	case BMP580_REG_TEMP_MSB:
+	case BMP580_REG_EFF_OSR:
+	case BMP580_REG_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -138,3 +186,15 @@ const struct regmap_config bmp380_regmap_config = {
 	.volatile_reg = bmp380_is_volatile_reg,
 };
 EXPORT_SYMBOL_NS(bmp380_regmap_config, IIO_BMP280);
+
+const struct regmap_config bmp580_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BMP580_REG_CMD,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bmp580_is_writeable_reg,
+	.volatile_reg = bmp580_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS(bmp580_regmap_config, IIO_BMP280);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index d5a224b95185..1dff9bb7c4e9 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -85,6 +85,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
 	{ .compatible = "bosch,bme280", .data = &bmp280_chip_info },
 	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
+	{ .compatible = "bosch,bmp580", .data = &bmp580_chip_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
@@ -95,6 +96,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
 	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },
 	{ "bme280", (kernel_ulong_t)&bmp280_chip_info },
 	{ "bmp380", (kernel_ulong_t)&bmp380_chip_info },
+	{ "bmp580", (kernel_ulong_t)&bmp580_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index be17104ef0a2..f29d44b09efc 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -6,6 +6,107 @@
 #include <linux/regulator/consumer.h>
 
 
+/* BMP580 specific registers */
+#define BMP580_REG_CMD			0x7E
+#define BMP580_REG_EFF_OSR		0x38
+#define BMP580_REG_ODR_CONFIG		0x37
+#define BMP580_REG_OSR_CONFIG		0x36
+#define BMP580_REG_IF_CONFIG		0x13
+#define BMP580_REG_REV_ID		0x02
+#define BMP580_REG_CHIP_ID		0x01
+/* OOR allows to configure a pressure alarm */
+#define BMP580_REG_OOR_CONFIG		0x35
+#define BMP580_REG_OOR_RANGE		0x34
+#define BMP580_REG_OOR_THR_MSB		0x33
+#define BMP580_REG_OOR_THR_LSB		0x32
+/* DSP registers (IIR filters) */
+#define BMP580_REG_DSP_IIR		0x31
+#define BMP580_REG_DSP_CONFIG		0x30
+/* NVM access registers */
+#define BMP580_REG_NVM_DATA_MSB		0x2D
+#define BMP580_REG_NVM_DATA_LSB		0x2C
+#define BMP580_REG_NVM_ADDR		0x2B
+/* Status registers */
+#define BMP580_REG_STATUS		0x28
+#define BMP580_REG_INT_STATUS		0x27
+#define BMP580_REG_CHIP_STATUS		0x11
+/* Data registers */
+#define BMP580_REG_FIFO_DATA		0x29
+#define BMP580_REG_PRESS_MSB		0x22
+#define BMP580_REG_PRESS_LSB		0x21
+#define BMP580_REG_PRESS_XLSB		0x20
+#define BMP580_REG_TEMP_MSB		0x1F
+#define BMP580_REG_TEMP_LSB		0x1E
+#define BMP580_REG_TEMP_XLSB		0x1D
+/* FIFO config registers */
+#define BMP580_REG_FIFO_SEL		0x18
+#define BMP580_REG_FIFO_COUNT		0x17
+#define BMP580_REG_FIFO_CONFIG		0x16
+/* Interruptions config registers */
+#define BMP580_REG_INT_SOURCE		0x15
+#define BMP580_REG_INT_CONFIG		0x14
+
+#define BMP580_CMD_NOOP			0x00
+#define BMP580_CMD_EXTMODE_SEQ_0	0x73
+#define BMP580_CMD_EXTMODE_SEQ_1	0xB4
+#define BMP580_CMD_EXTMODE_SEQ_2	0x69
+#define BMP580_CMD_NVM_OP_SEQ_0		0x5D
+#define BMP580_CMD_NVM_READ_SEQ_1	0xA5
+#define BMP580_CMD_NVM_WRITE_SEQ_1	0xA0
+#define BMP580_CMD_SOFT_RESET		0xB6
+
+#define BMP580_INT_STATUS_POR_MASK	BIT(4)
+
+#define BMP580_STATUS_CORE_RDY_MASK	BIT(0)
+#define BMP580_STATUS_NVM_RDY_MASK	BIT(1)
+#define BMP580_STATUS_NVM_ERR_MASK	BIT(2)
+#define BMP580_STATUS_NVM_CMD_ERR_MASK	BIT(3)
+
+#define BMP580_OSR_PRESS_MASK		GENMASK(5, 3)
+#define BMP580_OSR_TEMP_MASK		GENMASK(2, 0)
+#define BMP580_OSR_PRESS_EN		BIT(6)
+#define BMP580_EFF_OSR_PRESS_MASK	GENMASK(5, 3)
+#define BMP580_EFF_OSR_TEMP_MASK	GENMASK(2, 0)
+#define BMP580_EFF_OSR_VALID_ODR	BIT(7)
+
+#define BMP580_ODR_MASK			GENMASK(6, 2)
+#define BMP580_MODE_MASK		GENMASK(1, 0)
+#define BMP580_MODE_SLEEP		0
+#define BMP580_MODE_NORMAL		1
+#define BMP580_MODE_FORCED		2
+#define BMP580_MODE_CONTINOUS		3
+#define BMP580_ODR_DEEPSLEEP_DIS	BIT(7)
+
+#define BMP580_DSP_COMP_MASK		GENMASK(1, 0)
+#define BMP580_DSP_COMP_DIS		0
+#define BMP580_DSP_TEMP_COMP_EN		1
+/*
+ * In section 7.27 of datasheet, modes 2 and 3 are technically the same.
+ * Pressure compensation means also enabling temperature compensation
+ */
+#define BMP580_DSP_PRESS_COMP_EN	2
+#define BMP580_DSP_PRESS_TEMP_COMP_EN	3
+#define BMP580_DSP_IIR_FORCED_FLUSH	BIT(2)
+#define BMP580_DSP_SHDW_IIR_TEMP_EN	BIT(3)
+#define BMP580_DSP_FIFO_IIR_TEMP_EN	BIT(4)
+#define BMP580_DSP_SHDW_IIR_PRESS_EN	BIT(5)
+#define BMP580_DSP_FIFO_IIR_PRESS_EN	BIT(6)
+#define BMP580_DSP_OOR_IIR_PRESS_EN	BIT(7)
+
+#define BMP580_DSP_IIR_PRESS_MASK	GENMASK(5, 3)
+#define BMP580_DSP_IIR_TEMP_MASK	GENMASK(2, 0)
+#define BMP580_FILTER_OFF		0
+#define BMP580_FILTER_1X		1
+#define BMP580_FILTER_3X		2
+#define BMP580_FILTER_7X		3
+#define BMP580_FILTER_15X		4
+#define BMP580_FILTER_31X		5
+#define BMP580_FILTER_63X		6
+#define BMP580_FILTER_127X		7
+
+#define BMP580_TEMP_SKIPPED		0x7f7f7f
+#define BMP580_PRESS_SKIPPED		0x7f7f7f
+
 /* BMP380 specific registers */
 #define BMP380_REG_CMD			0x7E
 #define BMP380_REG_CONFIG		0x1F
@@ -184,6 +285,8 @@
 #define BMP280_REG_ID			0xD0
 
 #define BMP380_CHIP_ID			0x50
+#define BMP580_CHIP_ID			0x50
+#define BMP580_CHIP_ID_ALT		0x51
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
 #define BME280_CHIP_ID			0x60
@@ -353,11 +456,13 @@ extern const struct bmp280_chip_info bmp180_chip_info;
 extern const struct bmp280_chip_info bmp280_chip_info;
 extern const struct bmp280_chip_info bme280_chip_info;
 extern const struct bmp280_chip_info bmp380_chip_info;
+extern const struct bmp280_chip_info bmp580_chip_info;
 
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
 extern const struct regmap_config bmp380_regmap_config;
+extern const struct regmap_config bmp580_regmap_config;
 
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
-- 
2.39.1

