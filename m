Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB94655DE4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiLYQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLYQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:56:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6BF2708;
        Sun, 25 Dec 2022 08:56:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so8576180wrm.2;
        Sun, 25 Dec 2022 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pcll64ajG15YCYg/EASo/QQIv8iNSJ6vRhknnam6qyo=;
        b=ASoVHuWVqUHNXmzaiP5MtnjorTVoj+JpHGsuJr+fsSsgrAMiHY1q5RySreu6xJROW1
         tnAOAPPVQ6K5ENgDzc9Hx8wCb5mADBsYiSznNkOT5if8hBdTvfAwKcHcy9FI9GlFcc9p
         HutiZ/6EncVZkUTR8Da5km5mvegm8mVkla7h4cvV2V1wsH1EemDW/8SIIh8Boi0rVKqh
         Af6wRj4DQUWOr5kYUqUqv8cYWIuMX15rvsJzWwtO5yl2vzCZjlQ5iJzeuzSr1riLqJ+c
         vMUsICk7EngzO86RRNRAlcy5Rpb2HBDe993UEd1IwLGT+Xk6T4hA90FbYuYT2mJ1R5M6
         tt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcll64ajG15YCYg/EASo/QQIv8iNSJ6vRhknnam6qyo=;
        b=GxTm0yNOCxHTmmve/LGW90fDP2962kElYNVSN0Bx5XupdQiXlz3GenQMnSovu8c5kx
         NDnZbGXnDwlufgGifa5MI3UASxuxNULCyKNYGzjqdSAiIfVYr/+39HU4Xz0KMWsZWG46
         vQlhBA0BKMz8YGgs4cXamWw1NxCi7UrMiWW3KKUXwljnQY3idonJqisydzfuJHW8j5Ur
         tvyhh5OPaFw6J66faNcMkRKKApB/fysGFwPC5E5+fFhj799F8Ba+k1kyrYFG9vliLUzw
         khPKwVB5rbJ2bdZS0A5uNsPa5MnEcBPI5BP+ayNLBxl3n6MSIWP5aCQaSYz70KMHRCeh
         /6tw==
X-Gm-Message-State: AFqh2kp2U8fqGQHtinqv8NixjH+emy5LQ5aR0SnNupAujVIRT60pdyiT
        HHhastC1g/+xWzeL0qbzFQdmay+r1iw=
X-Google-Smtp-Source: AMrXdXs4LY32HhVvWvbPnnoY0pZ84grSLIhD+Q5AXCNfb53Voxc2rQnqvS1OmlBB6A/bxD7WnOHjmQ==
X-Received: by 2002:adf:f9d1:0:b0:254:3dcb:dbb3 with SMTP id w17-20020adff9d1000000b002543dcbdbb3mr9942977wrr.53.1671987406930;
        Sun, 25 Dec 2022 08:56:46 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b00236c1f2cecesm9470874wrx.81.2022.12.25.08.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 08:56:46 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iio: pressure: bmp280: Add enumeration to handle chip variants
Date:   Sun, 25 Dec 2022 17:56:07 +0100
Message-Id: <f0368a3f460707417110dffdb0166824da20af15.1671986815.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671986815.git.ang.iglesiasg@gmail.com>
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
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

Adds enumeration to improve handling the different supported sensors
on driver initialization. This avoid collisions if different variants
share the same device idetifier on ID register.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c0aff78489b4..46959a91408f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -186,6 +186,7 @@ struct bmp280_data {
 
 struct bmp280_chip_info {
 	unsigned int id_reg;
+	const unsigned int chip_id;
 
 	const struct iio_chan_spec *channels;
 	int num_channels;
@@ -907,6 +908,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
 static const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
+	.chip_id = BMP280_CHIP_ID,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 2,
@@ -955,6 +957,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 
 static const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
+	.chip_id = BME280_CHIP_ID,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 3,
@@ -1321,6 +1324,7 @@ static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 12
 
 static const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
+	.chip_id = BMP380_CHIP_ID,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = 2,
@@ -1581,6 +1585,7 @@ static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 
 static const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
+	.chip_id = BMP180_CHIP_ID,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 2,
@@ -1685,16 +1690,16 @@ int bmp280_common_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	switch (chip) {
-	case BMP180_CHIP_ID:
+	case BMP180:
 		chip_info = &bmp180_chip_info;
 		break;
-	case BMP280_CHIP_ID:
+	case BMP280:
 		chip_info = &bmp280_chip_info;
 		break;
-	case BME280_CHIP_ID:
+	case BME280:
 		chip_info = &bme280_chip_info;
 		break;
-	case BMP380_CHIP_ID:
+	case BMP380:
 		chip_info = &bmp380_chip_info;
 		break;
 	default:
@@ -1751,9 +1756,9 @@ int bmp280_common_probe(struct device *dev,
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
-	if (chip_id != chip) {
+	if (chip_id != data->chip_info->chip_id) {
 		dev_err(dev, "bad chip id: expected %x got %x\n",
-			chip, chip_id);
+			data->chip_info->chip_id, chip_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 14eab086d24a..59921e8cd592 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -12,14 +12,14 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 
 	switch (id->driver_data) {
-	case BMP180_CHIP_ID:
+	case BMP180:
 		regmap_config = &bmp180_regmap_config;
 		break;
-	case BMP280_CHIP_ID:
-	case BME280_CHIP_ID:
+	case BMP280:
+	case BME280:
 		regmap_config = &bmp280_regmap_config;
 		break;
-	case BMP380_CHIP_ID:
+	case BMP380:
 		regmap_config = &bmp380_regmap_config;
 		break;
 	default:
@@ -40,21 +40,21 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id bmp280_of_i2c_match[] = {
-	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
-	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
-	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
-	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
-	{ .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
+	{ .compatible = "bosch,bmp085", .data = (void *)BMP180 },
+	{ .compatible = "bosch,bmp180", .data = (void *)BMP180 },
+	{ .compatible = "bosch,bmp280", .data = (void *)BMP280 },
+	{ .compatible = "bosch,bme280", .data = (void *)BME280 },
+	{ .compatible = "bosch,bmp380", .data = (void *)BMP380 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
-	{"bmp085", BMP180_CHIP_ID },
-	{"bmp180", BMP180_CHIP_ID },
-	{"bmp280", BMP280_CHIP_ID },
-	{"bme280", BME280_CHIP_ID },
-	{"bmp380", BMP380_CHIP_ID },
+	{"bmp085", BMP180 },
+	{"bmp180", BMP180 },
+	{"bmp280", BMP280 },
+	{"bme280", BME280 },
+	{"bmp380", BMP380 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 011c68e07ebf..4a2df5b5d838 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -59,14 +59,14 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	}
 
 	switch (id->driver_data) {
-	case BMP180_CHIP_ID:
+	case BMP180:
 		regmap_config = &bmp180_regmap_config;
 		break;
-	case BMP280_CHIP_ID:
-	case BME280_CHIP_ID:
+	case BMP280:
+	case BME280:
 		regmap_config = &bmp280_regmap_config;
 		break;
-	case BMP380_CHIP_ID:
+	case BMP380:
 		regmap_config = &bmp380_regmap_config;
 		break;
 	default:
@@ -101,11 +101,11 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
 
 static const struct spi_device_id bmp280_spi_id[] = {
-	{ "bmp180", BMP180_CHIP_ID },
-	{ "bmp181", BMP180_CHIP_ID },
-	{ "bmp280", BMP280_CHIP_ID },
-	{ "bme280", BME280_CHIP_ID },
-	{ "bmp380", BMP380_CHIP_ID },
+	{ "bmp180", BMP180 },
+	{ "bmp181", BMP180 },
+	{ "bmp280", BMP280 },
+	{ "bme280", BME280 },
+	{ "bmp380", BMP380 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index c791325c7416..efc31bc84708 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -191,6 +191,14 @@
 #define BMP280_PRESS_SKIPPED		0x80000
 #define BMP280_HUMIDITY_SKIPPED		0x8000
 
+/* Enum with supported pressure sensor models */
+enum bmp280_variant {
+	BMP180,
+	BMP280,
+	BME280,
+	BMP380,
+};
+
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
-- 
2.39.0

