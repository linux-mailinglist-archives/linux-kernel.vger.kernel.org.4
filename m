Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB728656363
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLZObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLZObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:31:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71514E72;
        Mon, 26 Dec 2022 06:31:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so7585288wms.4;
        Mon, 26 Dec 2022 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pcll64ajG15YCYg/EASo/QQIv8iNSJ6vRhknnam6qyo=;
        b=NfiuGysd4LexAHUUn08JQTaZLPXPCHcqOrCKienf6CBCoUsserAstuT0VnZDPtujw0
         /RsD0r2cAEcNBjlXUi4O+NOL9v8v0V0/6i5x4ancAS1XX8uioZPu83tp2mGbq0EyYPoE
         Sn53O8kI1ZGbNdsmS6LpCnAnhBouX/Szf8YbrKE95oauPkJrOyLoL0eN7hnw4sdLowOz
         1WHSgnMY7pNMNbCNj4J+VFSkqz/dYkyFHXXToxC/0hj4rosXRFRDCa+SJKoO8i6UT/Di
         Y2O9U87jCxMwqtyQQyVp24Bgas2KzwXe9ioFUf+7iF8KZ0UxZqsiQJjnrDXzJmwMrVVE
         l6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcll64ajG15YCYg/EASo/QQIv8iNSJ6vRhknnam6qyo=;
        b=x64kHsRM9g/bIvIvlBW1fAQ1lwl+D+rWfMp7Xlp0coUezgDPtjfETH6VT2Aj0Jto5X
         1z2n8vvPYA6EAGWh/x2WZralY+J5S+vM/SGF7pwVo/z4yT5mUqIINWdMa09LlQuG/qMM
         aM362rDbZPnzUfzyDZbrMeT8sTNXpnl+R2+Jb1mjH1j2p12CjLfqp7R1htwQRa8IW+eu
         fZHSb7Dt7P8q0+t8biLYIhId+YMHwsbv+wzRsJPalKohY09LVR83viwt165cq4L0EiE0
         uD0MKDjdjZDQ8iVseL+6WFYZ92s+GS3NdSkwE8H3taPZ4z9E8qjDq81Nc7phu9jVgTX5
         QsqQ==
X-Gm-Message-State: AFqh2krOvd+1ggwdlEYZwKqicFoiICGtlA4F5KnlwvSOzvMgs+lLKdYj
        9HCWxQl3qjK85vVPzw0AL5gLgk8HcnE=
X-Google-Smtp-Source: AMrXdXtEBBQBrTFPMk04MP0CKrCTbvpHMwZ99KSDaYeBspp/K6lCkGcKJLBDzqWi6dgAUaZXJt1IcQ==
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr13422470wmb.33.1672065094895;
        Mon, 26 Dec 2022 06:31:34 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm21511754wmq.8.2022.12.26.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:31:34 -0800 (PST)
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
Subject: [PATCH v2 1/5] iio: pressure: bmp280: Add enumeration to handle chip variants
Date:   Mon, 26 Dec 2022 15:29:20 +0100
Message-Id: <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
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

