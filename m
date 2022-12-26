Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59490656369
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiLZOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiLZOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:32:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0265E6B;
        Mon, 26 Dec 2022 06:32:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs20so8031095wrb.3;
        Mon, 26 Dec 2022 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjMkuu0y8HlvUAKn/mM88SIPu3VaIS/uapetW8Al+Co=;
        b=IuJabP8/bh5LF/Zvs+6IktgzOm85ByZ/UM0G9M92dw+ZhuuYkEBWIRurl0ab/KjCkX
         +2CiUNJ/5XTDX15pPYm9uK39UK26js8XYsoewMfzMW8GLveashps5LwO/4vLbehI0fIl
         0WFQFPYSm24I/OzYUBnPhXWrcCsxKLC8EakYyL+o0vYwpBsByV97iM1QFKgpLgbgVgqy
         4vizV6n4oEMpEuk4p0cqoFPxai1CjEBsoDyiPjYVB4H//i3cx1n3KVVEbHvXRkIAkZi+
         fVcEDGcPSfItcr5eppgVpIcOW7SUXjBSFg2jDqslI1r214iVxj2X4DQ8LRrU9elKWgjC
         /fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjMkuu0y8HlvUAKn/mM88SIPu3VaIS/uapetW8Al+Co=;
        b=eV3EHKyedDOk+Jw4f3wv/MNxg8OwiA8V9mpDUn5zFD/8FjTsDHgnh7vuD5Y3FVwd2z
         CuOyNbJ+NoJKoH5nrx8oztP4desK+oBfX2h+vyWLyKkPXsAAE8HXdhje4U9jhwjHHING
         DDEr9SH5peW9mTUfri6g7hxgGEcS8PoQ7XjYKyl/J/oLQIplwIC5BMLrAWXJHHc2a96i
         dYCn+ZfNT8qMUMAVuczVaHHxIkUmw2lCQh66f/X8H/v6oQMYIDkWbw583YdH7D+QEpsW
         styMt25Tt94YhZDV4QpZ6U3whrm5JJXnLaY8iMiAFuw7HHU2FojD03dZIJosQlXaxXoB
         IKTA==
X-Gm-Message-State: AFqh2koJlmbEMaly25I99IA+GbekRb8DSGNXbW5/fNg7kGxePjv4XuAj
        U97q6gDXL5zuihORw6nc3VI12pedvjU=
X-Google-Smtp-Source: AMrXdXtuFoDZ/0gF8I+nf++Wj/P+7+waZggEZO3GoAjHiZQEmwFw21mWbT+ac0QVBUrHv4/tLV5Ynw==
X-Received: by 2002:adf:d22c:0:b0:242:33ed:af28 with SMTP id k12-20020adfd22c000000b0024233edaf28mr11784266wrh.41.1672065129712;
        Mon, 26 Dec 2022 06:32:09 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm21511754wmq.8.2022.12.26.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:32:09 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new sensor BMP580
Date:   Mon, 26 Dec 2022 15:29:22 +0100
Message-Id: <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
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
index c9453389e4f7..1c18e3b2c501 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -17,14 +17,14 @@ config ABP060MG
 	  will be called abp060mg.
 
 config BMP280
-	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor I2C driver"
+	tristate "Bosch Sensortec BMP180/BMP280/BMP380/BMP580 pressure sensor I2C driver"
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
index c37cf2caec68..44901c6eb2f9 100644
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
@@ -130,6 +131,41 @@ enum bmp380_odr {
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
 struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
@@ -1361,6 +1397,399 @@ static const struct bmp280_chip_info bmp380_chip_info = {
 	.preinit = bmp380_preinit,
 };
 
+enum bmp580_commands {
+	BMP580_SOFT_RESET_CMD,
+	BMP580_NVM_WRITE_CMD,
+	BMP580_NVM_READ_CMD,
+	BMP580_EXT_MODE_CMD,
+};
+
+/*
+ * Helper function to send a command to BMP5XX sensors.
+ *
+ * BMP5xx sensors have a series of commands actionable
+ * writing specific sequences on the CMD register:
+ * SOFT_RESET: performs a reset of the system.
+ * NVM_READ: read the contents of a user position of the nvm memory.
+ * NVM_WRITE: write new data to a user position of the nvm memory.
+ * EXT_MODE: enable extended mode with additional debug pages.
+ */
+static int bmp580_cmd(struct bmp280_data *data, enum bmp580_commands cmd)
+{
+	unsigned long deadline;
+	unsigned int reg;
+	int ret;
+
+	switch (cmd) {
+	case BMP580_SOFT_RESET_CMD:
+		/* Send reset word */
+		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_SOFT_RESET);
+		if (ret) {
+			dev_err(data->dev, "failed to send reset command to device\n");
+			return ret;
+		}
+		/* Wait 2ms for reset completion */
+		usleep_range(2000, 2500);
+		/* Dummy read of chip_id */
+		ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
+		if (ret) {
+			dev_err(data->dev, "failed to reestablish comms after reset\n");
+			return ret;
+		}
+		/* Check if POR bit is set on interrupt reg */
+		ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &reg);
+		if (ret) {
+			dev_err(data->dev, "error reading interrupt status register\n");
+			return ret;
+		}
+		if (!(reg & BMP580_INT_STATUS_POR_MASK)) {
+			dev_err(data->dev, "error resetting sensor\n");
+			return -EINVAL;
+		}
+		break;
+	case BMP580_NVM_WRITE_CMD:
+	case BMP580_NVM_READ_CMD:
+		/* Check nvm ready flag */
+		ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+		if (ret) {
+			dev_err(data->dev, "failed to check nvm status\n");
+			return ret;
+		}
+		if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
+			dev_err(data->dev, "sensor's nvm is not ready\n");
+			return -EIO;
+		}
+		/* Send NVM operation sequence */
+		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
+		if (ret) {
+			dev_err(data->dev, "failed to send nvm operation's first sequence\n");
+			return ret;
+		}
+		if (cmd == BMP580_NVM_WRITE_CMD) {
+			/* Send write sequence */
+			ret = regmap_write(data->regmap, BMP580_REG_CMD,
+					   BMP580_CMD_NVM_WRITE_SEQ_1);
+			if (ret) {
+				dev_err(data->dev, "failed to send nvm write sequence\n");
+				return ret;
+			}
+			/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
+			usleep_range(10000, 10500);
+			deadline = jiffies + msecs_to_jiffies(10);
+		} else {
+			/* Send read sequence */
+			ret = regmap_write(data->regmap, BMP580_REG_CMD,
+					   BMP580_CMD_NVM_READ_SEQ_1);
+			if (ret) {
+				dev_err(data->dev, "failed to send nvm read sequence\n");
+				return ret;
+			}
+			/* Datasheet says on 4.8.1.1 it takes approximately 200us */
+			usleep_range(200, 250);
+			deadline = jiffies + usecs_to_jiffies(200);
+		}
+		if (ret) {
+			dev_err(data->dev, "failed to write command sequence\n");
+			return -EIO;
+		}
+		/* Wait until NVM is ready again */
+		do {
+			ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+			if (ret) {
+				dev_err(data->dev, "failed to check nvm status\n");
+				reg &= ~BMP580_STATUS_NVM_RDY_MASK;
+			}
+		} while (time_before(jiffies, deadline) && !(reg & BMP580_STATUS_NVM_RDY_MASK));
+
+		if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
+			dev_err(data->dev,
+				"reached timeout waiting for nvm operation completion\n");
+			return -ETIMEDOUT;
+		}
+		/* Checks nvm error flags */
+		if ((reg & BMP580_STATUS_NVM_ERR_MASK) || (reg & BMP580_STATUS_NVM_CMD_ERR_MASK)) {
+			dev_err(data->dev, "error processing nvm operation\n");
+			return -EIO;
+		}
+		break;
+	case BMP580_EXT_MODE_CMD:
+		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_EXTMODE_SEQ_0);
+		if (ret) {
+			dev_err(data->dev, "failed to send ext_mode first sequence\n");
+			return ret;
+		}
+		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_EXTMODE_SEQ_1);
+		if (ret) {
+			dev_err(data->dev, "failed to send ext_mode second sequence\n");
+			return ret;
+		}
+		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_EXTMODE_SEQ_2);
+		if (ret) {
+			dev_err(data->dev, "failed to send ext_mode second sequence\n");
+			return ret;
+		}
+		break;
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
+	*val2 = 64000; // 2^6 * 1000
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
+	ret = bmp580_cmd(data, BMP580_SOFT_RESET_CMD);
+	if (ret)
+		return ret;
+	/* Post powerup sequence */
+	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
+	if (ret)
+		return ret;
+	if (reg != BMP580_CHIP_ID) {
+		dev_err(data->dev, "preinit: unexpected chip_id\n");
+		return -EINVAL;
+	}
+	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+	if (ret)
+		return ret;
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
+static const int bmp580_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+
+static const struct bmp280_chip_info bmp580_chip_info = {
+	.id_reg = BMP580_REG_CHIP_ID,
+	.chip_id = BMP580_CHIP_ID,
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
+	.iir_filter_coeffs_avail = bmp580_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp580_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
+	.chip_config = bmp580_chip_config,
+	.read_temp = bmp580_read_temp,
+	.read_press = bmp580_read_press,
+	.read_calib = NULL,
+	.preinit = bmp580_preinit,
+};
+
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
 	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
@@ -1713,6 +2142,9 @@ int bmp280_common_probe(struct device *dev,
 	case BMP380:
 		chip_info = &bmp380_chip_info;
 		break;
+	case BMP580:
+		chip_info = &bmp580_chip_info;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1779,9 +2211,10 @@ int bmp280_common_probe(struct device *dev,
 	 */
 	if (data->chip_info->preinit) {
 		ret = data->chip_info->preinit(data);
-		dev_err(dev, "error running preinit tasks");
-		if (ret < 0)
+		if (ret) {
+			dev_err(dev, "error running preinit tasks\n");
 			return ret;
+		}
 	}
 
 	ret = data->chip_info->chip_config(data);
@@ -1795,11 +2228,12 @@ int bmp280_common_probe(struct device *dev,
 	 * non-volatile memory during production". Let's read them out at probe
 	 * time once. They will not change.
 	 */
-
-	ret = data->chip_info->read_calib(data);
-	if (ret < 0)
-		return dev_err_probe(data->dev, ret,
-				     "failed to read calibration coefficients\n");
+	if (data->chip_info->read_calib) {
+		ret = data->chip_info->read_calib(data);
+		if (ret < 0)
+			return dev_err_probe(data->dev, ret,
+					     "failed to read calibration coefficients\n");
+	}
 
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 59921e8cd592..c52d2b477bb7 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -22,6 +22,9 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 	case BMP380:
 		regmap_config = &bmp380_regmap_config;
 		break;
+	case BMP580:
+		regmap_config = &bmp580_regmap_config;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -45,6 +48,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 	{ .compatible = "bosch,bmp280", .data = (void *)BMP280 },
 	{ .compatible = "bosch,bme280", .data = (void *)BME280 },
 	{ .compatible = "bosch,bmp380", .data = (void *)BMP380 },
+	{ .compatible = "bosch,bmp580", .data = (void *)BMP580 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
@@ -55,6 +59,7 @@ static const struct i2c_device_id bmp280_i2c_id[] = {
 	{"bmp280", BMP280 },
 	{"bme280", BME280 },
 	{"bmp380", BMP380 },
+	{"bmp580", BMP580 },
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
index 4a2df5b5d838..5653c3c33081 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -69,6 +69,9 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	case BMP380:
 		regmap_config = &bmp380_regmap_config;
 		break;
+	case BMP580:
+		regmap_config = &bmp580_regmap_config;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -96,6 +99,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp280", },
 	{ .compatible = "bosch,bme280", },
 	{ .compatible = "bosch,bmp380", },
+	{ .compatible = "bosch,bmp580", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
@@ -106,6 +110,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
 	{ "bmp280", BMP280 },
 	{ "bme280", BME280 },
 	{ "bmp380", BMP380 },
+	{ "bmp580", BMP580 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index efc31bc84708..27d2abc17d01 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -3,6 +3,107 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
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
@@ -180,6 +281,7 @@
 #define BMP280_REG_RESET		0xE0
 #define BMP280_REG_ID			0xD0
 
+#define BMP580_CHIP_ID			0x50
 #define BMP380_CHIP_ID			0x50
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
@@ -197,12 +299,14 @@ enum bmp280_variant {
 	BMP280,
 	BME280,
 	BMP380,
+	BMP580,
 };
 
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
 extern const struct regmap_config bmp380_regmap_config;
+extern const struct regmap_config bmp580_regmap_config;
 
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
-- 
2.39.0

