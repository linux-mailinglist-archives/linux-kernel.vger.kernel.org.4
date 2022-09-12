Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4E5B6459
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiILXsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILXsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:48:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9085072A;
        Mon, 12 Sep 2022 16:48:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o25so18064070wrf.9;
        Mon, 12 Sep 2022 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4KGwPWrY6dbaymVDauaT5Su1EdquxSq27pDyAizJJYY=;
        b=j4lVn9ziUMGATcJzbjA+OEWDoE5OigGEBmX9veqdS5uDE2BC2cwGd7S2fxDCmIi0qk
         cjdORZz8ARtgM1kNxO4mfK4zaNoyd0gWO2EmazTi7lk8J+jrM8GCGJLAGY8dkGUCmgOT
         8jYku7y3am8JD6TeeDh0/HhlMuQJsQQI568K4CvXIVfcZiMk0pEJJ47169k4bOnmuSdl
         7tBzGYhlZNGz3f7+wIKgFSqsqd4AGO7WmHCDs9jyrror/ukgBIwQF6WpoFwtafnWDMby
         D2SQnD+gRbcNaLtw/wBQKTmI9VhuKj63u7Jal4JteAe9sDtSBdaDa1938O9ldGr6TPEW
         Q5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4KGwPWrY6dbaymVDauaT5Su1EdquxSq27pDyAizJJYY=;
        b=jriOvA5s581wuH+xAzTdy89CR5Quc937zxXvng0tyXjF5WRDzC9egPVnjOp6ueov9v
         97qj8qmEpNJIY/0GoEO6F4xEeMnCt0vIx/EGR+fRdc+8uV6a9PRbxYN2lBqWXTAwfzie
         mHBHbFayCJr8VjeBRHlCNheU6W6B2ofSm+EuYXiOa5ubTMt02apCaIDytTrEepkqcy1M
         YzyY19F5zHe948U9lu5/wEZcnbul4qpnoJN2jCiRy3ee5XX1Mww5Wh8VBHs3HmQN3hhb
         vD1WqowHNdmPJZw+LI4CkW95EKtat7AzpO6YIIFeQJ1rDBx3nCwSmZ3OMmQUvhQDwHuT
         F9/A==
X-Gm-Message-State: ACgBeo3oRnzynOvOYKWLRtkDbyEEEr9j1o+VM6evYZvguSlOWlYWwNTh
        up0dR3aI44mOOow9saBFYRKTieI+oyw=
X-Google-Smtp-Source: AA6agR5JdQTeoQpaB0KBo+vnso8MqekU8odNDPM8EMB1TlAVY+AzjAVNB+XyElQebBRf/+BEOQRVgA==
X-Received: by 2002:a05:6000:1081:b0:22a:2ecf:9cf8 with SMTP id y1-20020a056000108100b0022a2ecf9cf8mr12651676wrw.205.1663026484179;
        Mon, 12 Sep 2022 16:48:04 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe30f000000b0021e6c52c921sm10506529wrj.54.2022.09.12.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:48:03 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/9] iio: pressure: bmp280: simplify driver initialization logic
Date:   Tue, 13 Sep 2022 01:47:31 +0200
Message-Id: <584c90f309e4f24bf2e4aa2b15c8577d288f978d.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplified common initialization logic of different sensor types
unifying calibration and initial configuration recovery.

Default config param values of each sensor type are stored inside
chip_info structure and used to initialize sensor data struct instance.

The helper functions for read each sensor type calibration are converted
to a callback available on the chip_info struct.

Separated bme280 specific calibration code from bmp280 function. Dropped
the additional chip_id argument in bmp280 code as is not longer required.
Now both bmp280/bme280 calibration function use same signature as bmp180.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 126 +++++++++++++++++++----------
 1 file changed, 83 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4793bcd9f0b3..203623d32032 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -109,19 +109,28 @@ struct bmp280_data {
 };
 
 struct bmp280_chip_info {
+	unsigned int id_reg;
+
+	int num_channels;
+	unsigned int start_up_time;
+
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
+	int oversampling_temp_default;
 
 	const int *oversampling_press_avail;
 	int num_oversampling_press_avail;
+	int oversampling_press_default;
 
 	const int *oversampling_humid_avail;
 	int num_oversampling_humid_avail;
+	int oversampling_humid_default;
 
 	int (*chip_config)(struct bmp280_data *);
 	int (*read_temp)(struct bmp280_data *, int *);
 	int (*read_press)(struct bmp280_data *, int *, int *);
 	int (*read_humid)(struct bmp280_data *, int *, int *);
+	int (*read_calib)(struct bmp280_data *);
 };
 
 /*
@@ -148,15 +157,10 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	},
 };
 
-static int bmp280_read_calib(struct bmp280_data *data,
-			     struct bmp280_calib *calib,
-			     unsigned int chip)
+static int bmp280_read_calib(struct bmp280_data *data)
 {
+	struct bmp280_calib *calib = &data->calib.bmp280;
 	__le16 c_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
-	struct device *dev = data->dev;
-	unsigned int tmp;
-	__le16 l16;
-	__be16 b16;
 	int ret;
 
 
@@ -188,6 +192,25 @@ static int bmp280_read_calib(struct bmp280_data *data,
 	calib->P8 = le16_to_cpu(c_buf[P8]);
 	calib->P9 = le16_to_cpu(c_buf[P9]);
 
+	return 0;
+}
+
+static int bme280_read_calib(struct bmp280_data *data)
+{
+	struct bmp280_calib *calib = &data->calib.bmp280;
+	struct device *dev = data->dev;
+	unsigned int tmp;
+	__le16 l16;
+	__be16 b16;
+	int ret;
+
+	/* Load shared calibration params with bmp280 first */
+	ret = bmp280_read_calib(data);
+	if  (ret < 0) {
+		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
+		return ret;
+	}
+
 	/*
 	 * Read humidity calibration values.
 	 * Due to some odd register addressing we cannot just
@@ -195,8 +218,6 @@ static int bmp280_read_calib(struct bmp280_data *data,
 	 * value separately and sometimes do some bit shifting...
 	 * Humidity data is only available on BME280.
 	 */
-	if (chip != BME280_CHIP_ID)
-		return 0;
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
 	if (ret < 0) {
@@ -631,15 +652,32 @@ static int bmp280_chip_config(struct bmp280_data *data)
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
 static const struct bmp280_chip_info bmp280_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	/*
+	 * Oversampling config values on BMx280 have one additional setting
+	 * that other generations of the family don't:
+	 * The value 0 means the measurement is bypassed instead of
+	 * oversampling set to x1.
+	 *
+	 * To account for this difference, and preserve the same common
+	 * config logic, this is handled later on chip_config callback
+	 * incrementing one unit the oversampling setting.
+	 */
+	.oversampling_temp_default = BMP280_OSRS_TEMP_2X - 1,
 
 	.oversampling_press_avail = bmp280_oversampling_avail,
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
+	.read_calib = bmp280_read_calib,
 };
 
 static int bme280_chip_config(struct bmp280_data *data)
@@ -661,19 +699,27 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const struct bmp280_chip_info bme280_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 3,
+
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_temp_default = BMP280_OSRS_TEMP_2X - 1,
 
 	.oversampling_press_avail = bmp280_oversampling_avail,
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
 	.oversampling_humid_avail = bmp280_oversampling_avail,
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
 
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_humid = bmp280_read_humid,
+	.read_calib = bme280_read_calib,
 };
 
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
@@ -741,9 +787,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	return 0;
 }
 
-static int bmp180_read_calib(struct bmp280_data *data,
-			     struct bmp180_calib *calib)
+static int bmp180_read_calib(struct bmp280_data *data)
 {
+	struct bmp180_calib *calib = &data->calib.bmp180;
 	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
 	int ret;
 	int i;
@@ -909,17 +955,24 @@ static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 
 static const struct bmp280_chip_info bmp180_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
 		ARRAY_SIZE(bmp180_oversampling_temp_avail),
+	.oversampling_temp_default = 0,
 
 	.oversampling_press_avail = bmp180_oversampling_press_avail,
 	.num_oversampling_press_avail =
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
+	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
 
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
+	.read_calib = bmp180_read_calib,
 };
 
 static irqreturn_t bmp085_eoc_irq(int irq, void *d)
@@ -986,6 +1039,7 @@ int bmp280_common_probe(struct device *dev,
 			const char *name,
 			int irq)
 {
+	const struct bmp280_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
 	struct gpio_desc *gpiod;
@@ -1007,30 +1061,25 @@ int bmp280_common_probe(struct device *dev,
 
 	switch (chip) {
 	case BMP180_CHIP_ID:
-		indio_dev->num_channels = 2;
-		data->chip_info = &bmp180_chip_info;
-		data->oversampling_press = ilog2(8);
-		data->oversampling_temp = ilog2(1);
-		data->start_up_time = 10000;
+		chip_info = &bmp180_chip_info;
 		break;
 	case BMP280_CHIP_ID:
-		indio_dev->num_channels = 2;
-		data->chip_info = &bmp280_chip_info;
-		data->oversampling_press = ilog2(16);
-		data->oversampling_temp = ilog2(2);
-		data->start_up_time = 2000;
+		chip_info = &bmp280_chip_info;
 		break;
 	case BME280_CHIP_ID:
-		indio_dev->num_channels = 3;
-		data->chip_info = &bme280_chip_info;
-		data->oversampling_press = ilog2(16);
-		data->oversampling_humid = ilog2(16);
-		data->oversampling_temp = ilog2(2);
-		data->start_up_time = 2000;
+		chip_info = &bme280_chip_info;
 		break;
 	default:
 		return -EINVAL;
 	}
+	data->chip_info = chip_info;
+
+	/* Apply initial values from chip info structure */
+	indio_dev->num_channels = chip_info->num_channels;
+	data->oversampling_press = chip_info->oversampling_press_default;
+	data->oversampling_humid = chip_info->oversampling_humid_default;
+	data->oversampling_temp = chip_info->oversampling_temp_default;
+	data->start_up_time = chip_info->start_up_time;
 
 	/* Bring up regulators */
 	regulator_bulk_set_supply_names(data->supplies,
@@ -1067,7 +1116,8 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	data->regmap = regmap;
-	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
+
+	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
 	if (chip_id != chip) {
@@ -1087,21 +1137,11 @@ int bmp280_common_probe(struct device *dev,
 	 * non-volatile memory during production". Let's read them out at probe
 	 * time once. They will not change.
 	 */
-	if (chip_id  == BMP180_CHIP_ID) {
-		ret = bmp180_read_calib(data, &data->calib.bmp180);
-		if (ret < 0) {
-			dev_err(data->dev,
-				"failed to read calibration coefficients\n");
-			return ret;
-		}
-	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
-		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
-		if (ret < 0) {
-			dev_err(data->dev,
-				"failed to read calibration coefficients\n");
-			return ret;
-		}
-	}
+
+	ret = data->chip_info->read_calib(data);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "failed to read calibration coefficients\n");
 
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
-- 
2.37.3

