Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C969C176
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjBSRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBSRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:00:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC411E9E;
        Sun, 19 Feb 2023 09:00:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b10so577083wrx.11;
        Sun, 19 Feb 2023 09:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z4d8yA+Glq1zTMCAgla4KeAR322TLFeB1Hqom6T12w=;
        b=IL4YgAfahiCxC0zMCzz8F0QmxWBCgUobZFXusHlHOHimF3a2D5YUmaEJ8ZC/B3ENbE
         nbIVOkKF0t7jEm7abMXYvQ6FtnWCwtcdm1KhnQDKInW8rDEK8OdBkga0ZqFAlL8HE0U/
         UnJgr4YoEJ3Qb6v1gIu/y0VKKC1JZarQH7UoGzhOe7VxPsOZDRLWKSnORn1bdd8Lvny/
         v30nT6MwYVIF855U7yfK0ZkZB7kIf49Ao7RG5A32xVLmrOyPs3DvWC3GRUObt2oyBKId
         4SPvkXCr0WVQUXd8v3W0ccydjI1Tv5RgMbbDv9qiS8841Jn73S0IRiAMgaXkfAC45Rkx
         /wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z4d8yA+Glq1zTMCAgla4KeAR322TLFeB1Hqom6T12w=;
        b=xP2dPzOTGC/3BZg+KBsKzy/5Gu8l6ztzcRKpLi29eZ5ayDktcd0wGEQpVhWUO9zYvk
         rUtvZBcI+Z+Fyz2lmakgRCrmRPQj1sWTVLoMiOSwTAowlcs0mOhqDBgw4zJZ60ddYY/3
         bQ5LiNKFrh5TC7SnfzcSRB7zaj8I0bwg34b63H+Qo57G6IBFTiKAF88K441YbFErSuLD
         qIOP4LkcrOkMAY80wWrfIqLNjw9ugwvEqZ0sXt7eOv1G7a2d4DKMIe143yuOsBNH6XIS
         ANqowMDLaxFVor243L8N/LzHVoVzXc9rLTK/5NFJKAIyrqrYxWFOETHyGIh1Jk480SoG
         +tvw==
X-Gm-Message-State: AO0yUKW4jfumQt3+HzOU41ayb6E00PV22UsBrArFEWnTkOsqjDvU+RWV
        qQg7LvmurpDqX2nLPBAPfaxCN3fYV0g=
X-Google-Smtp-Source: AK7set+RA5gEEVwceX6ejjaboXf39rTIva6u5yoev+Djbub/iWlVRLt4v9Tbn8XtAhKWcM+Xq4Eoow==
X-Received: by 2002:a5d:650e:0:b0:2c5:60e2:ed6d with SMTP id x14-20020a5d650e000000b002c560e2ed6dmr1336019wru.3.1676826020689;
        Sun, 19 Feb 2023 09:00:20 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id v20-20020a5d5914000000b002c552c6c8c2sm366427wrd.87.2023.02.19.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:00:20 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] iio: pressure: bmp280: Use chip_info pointers for each chip as driver data
Date:   Sun, 19 Feb 2023 17:57:59 +0100
Message-Id: <a48cfa756be48d61dbf656c65daff6e9a1290e6f.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
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

Refactor driver I2C and SPI implementations using pointers for each
variant's chip_info as the driver data. Adds the regmap configuration
to the chip_info struct.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c0aff78489b4..2c8773db4b73 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -49,65 +49,6 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
-struct bmp180_calib {
-	s16 AC1;
-	s16 AC2;
-	s16 AC3;
-	u16 AC4;
-	u16 AC5;
-	u16 AC6;
-	s16 B1;
-	s16 B2;
-	s16 MB;
-	s16 MC;
-	s16 MD;
-};
-
-/* See datasheet Section 4.2.2. */
-struct bmp280_calib {
-	u16 T1;
-	s16 T2;
-	s16 T3;
-	u16 P1;
-	s16 P2;
-	s16 P3;
-	s16 P4;
-	s16 P5;
-	s16 P6;
-	s16 P7;
-	s16 P8;
-	s16 P9;
-	u8  H1;
-	s16 H2;
-	u8  H3;
-	s16 H4;
-	s16 H5;
-	s8  H6;
-};
-
-/* See datasheet Section 3.11.1. */
-struct bmp380_calib {
-	u16 T1;
-	u16 T2;
-	s8  T3;
-	s16 P1;
-	s16 P2;
-	s8  P3;
-	s8  P4;
-	u16 P5;
-	u16 P6;
-	s8  P7;
-	s8  P8;
-	s16 P9;
-	s8  P10;
-	s8  P11;
-};
-
-static const char *const bmp280_supply_names[] = {
-	"vddd", "vdda"
-};
-
-#define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
 
 enum bmp380_odr {
 	BMP380_ODR_200HZ,
@@ -130,94 +71,6 @@ enum bmp380_odr {
 	BMP380_ODR_0_0015HZ,
 };
 
-struct bmp280_data {
-	struct device *dev;
-	struct mutex lock;
-	struct regmap *regmap;
-	struct completion done;
-	bool use_eoc;
-	const struct bmp280_chip_info *chip_info;
-	union {
-		struct bmp180_calib bmp180;
-		struct bmp280_calib bmp280;
-		struct bmp380_calib bmp380;
-	} calib;
-	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
-	unsigned int start_up_time; /* in microseconds */
-
-	/* log of base 2 of oversampling rate */
-	u8 oversampling_press;
-	u8 oversampling_temp;
-	u8 oversampling_humid;
-	u8 iir_filter_coeff;
-
-	/*
-	 * BMP380 devices introduce sampling frequency configuration. See
-	 * datasheet sections 3.3.3. and 4.3.19 for more details.
-	 *
-	 * BMx280 devices allowed indirect configuration of sampling frequency
-	 * changing the t_standby duration between measurements, as detailed on
-	 * section 3.6.3 of the datasheet.
-	 */
-	int sampling_freq;
-
-	/*
-	 * Carryover value from temperature conversion, used in pressure
-	 * calculation.
-	 */
-	s32 t_fine;
-
-	/*
-	 * DMA (thus cache coherency maintenance) may require the
-	 * transfer buffers to live in their own cache lines.
-	 */
-	union {
-		/* Sensor data buffer */
-		u8 buf[3];
-		/* Calibration data buffers */
-		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
-		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
-		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
-		/* Miscellaneous, endianess-aware data buffers */
-		__le16 le16;
-		__be16 be16;
-	} __aligned(IIO_DMA_MINALIGN);
-};
-
-struct bmp280_chip_info {
-	unsigned int id_reg;
-
-	const struct iio_chan_spec *channels;
-	int num_channels;
-	unsigned int start_up_time;
-
-	const int *oversampling_temp_avail;
-	int num_oversampling_temp_avail;
-	int oversampling_temp_default;
-
-	const int *oversampling_press_avail;
-	int num_oversampling_press_avail;
-	int oversampling_press_default;
-
-	const int *oversampling_humid_avail;
-	int num_oversampling_humid_avail;
-	int oversampling_humid_default;
-
-	const int *iir_filter_coeffs_avail;
-	int num_iir_filter_coeffs_avail;
-	int iir_filter_coeff_default;
-
-	const int (*sampling_freq_avail)[2];
-	int num_sampling_freq_avail;
-	int sampling_freq_default;
-
-	int (*chip_config)(struct bmp280_data *);
-	int (*read_temp)(struct bmp280_data *, int *);
-	int (*read_press)(struct bmp280_data *, int *, int *);
-	int (*read_humid)(struct bmp280_data *, int *, int *);
-	int (*read_calib)(struct bmp280_data *);
-};
-
 /*
  * These enums are used for indexing into the array of compensation
  * parameters for BMP280.
@@ -905,8 +758,10 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
-static const struct bmp280_chip_info bmp280_chip_info = {
+const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
+	.chip_id = BMP280_CHIP_ID,
+	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 2,
@@ -934,6 +789,7 @@ static const struct bmp280_chip_info bmp280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
 };
+EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
@@ -953,8 +809,10 @@ static int bme280_chip_config(struct bmp280_data *data)
 	return bmp280_chip_config(data);
 }
 
-static const struct bmp280_chip_info bme280_chip_info = {
+const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
+	.chip_id = BME280_CHIP_ID,
+	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 3,
@@ -977,6 +835,7 @@ static const struct bmp280_chip_info bme280_chip_info = {
 	.read_humid = bmp280_read_humid,
 	.read_calib = bme280_read_calib,
 };
+EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
 
 /*
  * Helper function to send a command to BMP3XX sensors.
@@ -1319,8 +1178,10 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 
-static const struct bmp280_chip_info bmp380_chip_info = {
+const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
+	.chip_id = BMP380_CHIP_ID,
+	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = 2,
@@ -1346,6 +1207,7 @@ static const struct bmp280_chip_info bmp380_chip_info = {
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
 };
+EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
@@ -1579,8 +1441,10 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 
-static const struct bmp280_chip_info bmp180_chip_info = {
+const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
+	.chip_id = BMP180_CHIP_ID,
+	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 2,
@@ -1600,6 +1464,7 @@ static const struct bmp280_chip_info bmp180_chip_info = {
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
 };
+EXPORT_SYMBOL_NS(bmp180_chip_info, IIO_BMP280);
 
 static irqreturn_t bmp085_eoc_irq(int irq, void *d)
 {
@@ -1661,11 +1526,10 @@ static void bmp280_regulators_disable(void *data)
 
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
-			unsigned int chip,
+			const struct bmp280_chip_info *chip_info,
 			const char *name,
 			int irq)
 {
-	const struct bmp280_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
 	struct gpio_desc *gpiod;
@@ -1684,22 +1548,6 @@ int bmp280_common_probe(struct device *dev,
 	indio_dev->info = &bmp280_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	switch (chip) {
-	case BMP180_CHIP_ID:
-		chip_info = &bmp180_chip_info;
-		break;
-	case BMP280_CHIP_ID:
-		chip_info = &bmp280_chip_info;
-		break;
-	case BME280_CHIP_ID:
-		chip_info = &bme280_chip_info;
-		break;
-	case BMP380_CHIP_ID:
-		chip_info = &bmp380_chip_info;
-		break;
-	default:
-		return -EINVAL;
-	}
 	data->chip_info = chip_info;
 
 	/* Apply initial values from chip info structure */
@@ -1751,9 +1599,9 @@ int bmp280_common_probe(struct device *dev,
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
index 14eab086d24a..5f908e2c9826 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -8,25 +8,14 @@
 static int bmp280_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
-	const struct regmap_config *regmap_config;
+	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 
-	switch (id->driver_data) {
-	case BMP180_CHIP_ID:
-		regmap_config = &bmp180_regmap_config;
-		break;
-	case BMP280_CHIP_ID:
-	case BME280_CHIP_ID:
-		regmap_config = &bmp280_regmap_config;
-		break;
-	case BMP380_CHIP_ID:
-		regmap_config = &bmp380_regmap_config;
-		break;
-	default:
-		return -EINVAL;
-	}
+	chip_info = device_get_match_data(&client->dev);
+	if (!chip_info)
+		chip_info = (const struct bmp280_chip_info *) id->driver_data;
 
-	regmap = devm_regmap_init_i2c(client, regmap_config);
+	regmap = devm_regmap_init_i2c(client, chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "failed to allocate register map\n");
 		return PTR_ERR(regmap);
@@ -34,27 +23,27 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 
 	return bmp280_common_probe(&client->dev,
 				   regmap,
-				   id->driver_data,
+				   chip_info,
 				   id->name,
 				   client->irq);
 }
 
 static const struct of_device_id bmp280_of_i2c_match[] = {
-	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
-	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
-	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
-	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
-	{ .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
+	{ .compatible = "bosch,bmp085", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp180", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
+	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
+	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
-	{"bmp085", BMP180_CHIP_ID },
-	{"bmp180", BMP180_CHIP_ID },
-	{"bmp280", BMP280_CHIP_ID },
-	{"bme280", BME280_CHIP_ID },
-	{"bmp380", BMP380_CHIP_ID },
+	{"bmp085", (kernel_ulong_t)&bmp180_chip_info },
+	{"bmp180", (kernel_ulong_t)&bmp180_chip_info },
+	{"bmp280", (kernel_ulong_t)&bmp280_chip_info },
+	{"bme280", (kernel_ulong_t)&bme280_chip_info },
+	{"bmp380", (kernel_ulong_t)&bmp380_chip_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 011c68e07ebf..d5a224b95185 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -47,8 +47,8 @@ static struct regmap_bus bmp280_regmap_bus = {
 static int bmp280_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct bmp280_chip_info *chip_info;
 	struct regmap *regmap;
-	const struct regmap_config *regmap_config;
 	int ret;
 
 	spi->bits_per_word = 8;
@@ -58,25 +58,14 @@ static int bmp280_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	switch (id->driver_data) {
-	case BMP180_CHIP_ID:
-		regmap_config = &bmp180_regmap_config;
-		break;
-	case BMP280_CHIP_ID:
-	case BME280_CHIP_ID:
-		regmap_config = &bmp280_regmap_config;
-		break;
-	case BMP380_CHIP_ID:
-		regmap_config = &bmp380_regmap_config;
-		break;
-	default:
-		return -EINVAL;
-	}
+	chip_info = device_get_match_data(&spi->dev);
+	if (!chip_info)
+		chip_info = (const struct bmp280_chip_info *) id->driver_data;
 
 	regmap = devm_regmap_init(&spi->dev,
 				  &bmp280_regmap_bus,
 				  &spi->dev,
-				  regmap_config);
+				  chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "failed to allocate register map\n");
 		return PTR_ERR(regmap);
@@ -84,28 +73,28 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
 	return bmp280_common_probe(&spi->dev,
 				   regmap,
-				   id->driver_data,
+				   chip_info,
 				   id->name,
 				   spi->irq);
 }
 
 static const struct of_device_id bmp280_of_spi_match[] = {
-	{ .compatible = "bosch,bmp085", },
-	{ .compatible = "bosch,bmp180", },
-	{ .compatible = "bosch,bmp181", },
-	{ .compatible = "bosch,bmp280", },
-	{ .compatible = "bosch,bme280", },
-	{ .compatible = "bosch,bmp380", },
+	{ .compatible = "bosch,bmp085", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp180", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp181", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
+	{ .compatible = "bosch,bme280", .data = &bmp280_chip_info },
+	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
 
 static const struct spi_device_id bmp280_spi_id[] = {
-	{ "bmp180", BMP180_CHIP_ID },
-	{ "bmp181", BMP180_CHIP_ID },
-	{ "bmp280", BMP280_CHIP_ID },
-	{ "bme280", BME280_CHIP_ID },
-	{ "bmp380", BMP380_CHIP_ID },
+	{ "bmp180", (kernel_ulong_t)&bmp180_chip_info },
+	{ "bmp181", (kernel_ulong_t)&bmp180_chip_info },
+	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },
+	{ "bme280", (kernel_ulong_t)&bmp280_chip_info },
+	{ "bmp380", (kernel_ulong_t)&bmp380_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index c791325c7416..387723fd0772 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -1,7 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/iio/iio.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
 
 /* BMP380 specific registers */
 #define BMP380_REG_CMD			0x7E
@@ -191,6 +194,165 @@
 #define BMP280_PRESS_SKIPPED		0x80000
 #define BMP280_HUMIDITY_SKIPPED		0x8000
 
+/* Core exported structs */
+
+static const char *const bmp280_supply_names[] = {
+	"vddd", "vdda"
+};
+
+#define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
+
+struct bmp180_calib {
+	s16 AC1;
+	s16 AC2;
+	s16 AC3;
+	u16 AC4;
+	u16 AC5;
+	u16 AC6;
+	s16 B1;
+	s16 B2;
+	s16 MB;
+	s16 MC;
+	s16 MD;
+};
+
+/* See datasheet Section 4.2.2. */
+struct bmp280_calib {
+	u16 T1;
+	s16 T2;
+	s16 T3;
+	u16 P1;
+	s16 P2;
+	s16 P3;
+	s16 P4;
+	s16 P5;
+	s16 P6;
+	s16 P7;
+	s16 P8;
+	s16 P9;
+	u8  H1;
+	s16 H2;
+	u8  H3;
+	s16 H4;
+	s16 H5;
+	s8  H6;
+};
+
+/* See datasheet Section 3.11.1. */
+struct bmp380_calib {
+	u16 T1;
+	u16 T2;
+	s8  T3;
+	s16 P1;
+	s16 P2;
+	s8  P3;
+	s8  P4;
+	u16 P5;
+	u16 P6;
+	s8  P7;
+	s8  P8;
+	s16 P9;
+	s8  P10;
+	s8  P11;
+};
+
+struct bmp280_data {
+	struct device *dev;
+	struct mutex lock;
+	struct regmap *regmap;
+	struct completion done;
+	bool use_eoc;
+	const struct bmp280_chip_info *chip_info;
+	union {
+		struct bmp180_calib bmp180;
+		struct bmp280_calib bmp280;
+		struct bmp380_calib bmp380;
+	} calib;
+	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
+	unsigned int start_up_time; /* in microseconds */
+
+	/* log of base 2 of oversampling rate */
+	u8 oversampling_press;
+	u8 oversampling_temp;
+	u8 oversampling_humid;
+	u8 iir_filter_coeff;
+
+	/*
+	 * BMP380 devices introduce sampling frequency configuration. See
+	 * datasheet sections 3.3.3. and 4.3.19 for more details.
+	 *
+	 * BMx280 devices allowed indirect configuration of sampling frequency
+	 * changing the t_standby duration between measurements, as detailed on
+	 * section 3.6.3 of the datasheet.
+	 */
+	int sampling_freq;
+
+	/*
+	 * Carryover value from temperature conversion, used in pressure
+	 * calculation.
+	 */
+	s32 t_fine;
+
+	/*
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		/* Sensor data buffer */
+		u8 buf[3];
+		/* Calibration data buffers */
+		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
+		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
+		/* Miscellaneous, endianess-aware data buffers */
+		__le16 le16;
+		__be16 be16;
+	} __aligned(IIO_DMA_MINALIGN);
+};
+
+struct bmp280_chip_info {
+	unsigned int id_reg;
+	const unsigned int chip_id;
+
+	const struct regmap_config *regmap_config;
+
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	unsigned int start_up_time;
+
+	const int *oversampling_temp_avail;
+	int num_oversampling_temp_avail;
+	int oversampling_temp_default;
+
+	const int *oversampling_press_avail;
+	int num_oversampling_press_avail;
+	int oversampling_press_default;
+
+	const int *oversampling_humid_avail;
+	int num_oversampling_humid_avail;
+	int oversampling_humid_default;
+
+	const int *iir_filter_coeffs_avail;
+	int num_iir_filter_coeffs_avail;
+	int iir_filter_coeff_default;
+
+	const int (*sampling_freq_avail)[2];
+	int num_sampling_freq_avail;
+	int sampling_freq_default;
+
+	int (*chip_config)(struct bmp280_data *);
+	int (*read_temp)(struct bmp280_data *, int *);
+	int (*read_press)(struct bmp280_data *, int *, int *);
+	int (*read_humid)(struct bmp280_data *, int *, int *);
+	int (*read_calib)(struct bmp280_data *);
+};
+
+/* Chip infos for each variant */
+extern const struct bmp280_chip_info bmp180_chip_info;
+extern const struct bmp280_chip_info bmp280_chip_info;
+extern const struct bmp280_chip_info bme280_chip_info;
+extern const struct bmp280_chip_info bmp380_chip_info;
+
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
@@ -199,7 +361,7 @@ extern const struct regmap_config bmp380_regmap_config;
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
-			unsigned int chip,
+			const struct bmp280_chip_info *,
 			const char *name,
 			int irq);
 
-- 
2.39.2

