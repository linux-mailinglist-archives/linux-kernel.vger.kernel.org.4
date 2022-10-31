Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F8613400
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJaKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJaKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:52:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA6E007;
        Mon, 31 Oct 2022 03:52:36 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29V7wATZ013358;
        Mon, 31 Oct 2022 06:52:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kj6ghhtak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 06:52:27 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 29VAqQDe050445
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 06:52:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 31 Oct
 2022 06:52:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 31 Oct 2022 06:52:25 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 29VAq8wX021417;
        Mon, 31 Oct 2022 06:52:17 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v2 3/3] drivers: iio: accel: Add support for ADXL359 device
Date:   Mon, 31 Oct 2022 12:51:29 +0200
Message-ID: <20221031105129.47740-4-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031105129.47740-1-ramona.bolboaca@analog.com>
References: <20221031105129.47740-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jSuF_PVMaP3pZXsyFzo4r-BZTrAyZ3GC
X-Proofpoint-ORIG-GUID: jSuF_PVMaP3pZXsyFzo4r-BZTrAyZ3GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310068
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ADXL359 device in already existing ADXL355 driver.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl359.pdf
Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
changes in v2:
 - Added missing spaces in subject
 - Added Datasheet tag in commit message
 - Removed type field from adxl355_chip_info
 - Added fields for acceleration scale and temperature offset in 
   adxl355_chip_info structure
 - Added constant data for acceleration scale and temperature offset specific
   to each device in adxl35x_chip_info
 - Moved scale and offset documentation to adxl35x_chip_info definition
 - Moved device_get_match_data inside if (!chip_data) {} block
 drivers/iio/accel/adxl355.h      | 21 +++++++-
 drivers/iio/accel/adxl355_core.c | 85 +++++++++++++++++++++++++-------
 drivers/iio/accel/adxl355_i2c.c  | 22 +++++++--
 drivers/iio/accel/adxl355_spi.c  | 19 +++++--
 4 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
index 6dd49b13e4fd..3a08a1808e86 100644
--- a/drivers/iio/accel/adxl355.h
+++ b/drivers/iio/accel/adxl355.h
@@ -10,12 +10,31 @@
 
 #include <linux/regmap.h>
 
+enum adxl355_device_type {
+	ADXL355,
+	ADXL359,
+};
+
+struct adxl355_fractional_type {
+	int integer;
+	int decimal;
+};
+
 struct device;
 
+struct adxl355_chip_info {
+	const char			*name;
+	u8				part_id;
+	struct adxl355_fractional_type	accel_scale;
+	struct adxl355_fractional_type	temp_offset;
+
+};
+
 extern const struct regmap_access_table adxl355_readable_regs_tbl;
 extern const struct regmap_access_table adxl355_writeable_regs_tbl;
+extern const struct adxl355_chip_info adxl35x_chip_info[];
 
 int adxl355_core_probe(struct device *dev, struct regmap *regmap,
-		       const char *name);
+		       const struct adxl355_chip_info *chip_info);
 
 #endif /* _ADXL355_H_ */
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index dd08253d66d0..c501ad9af631 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -60,6 +60,7 @@
 #define ADXL355_DEVID_AD_VAL		0xAD
 #define ADXL355_DEVID_MST_VAL		0x1D
 #define ADXL355_PARTID_VAL		0xED
+#define ADXL359_PARTID_VAL		0xE9
 #define ADXL355_RESET_CODE		0x52
 
 static const struct regmap_range adxl355_read_reg_range[] = {
@@ -83,6 +84,60 @@ const struct regmap_access_table adxl355_writeable_regs_tbl = {
 };
 EXPORT_SYMBOL_NS_GPL(adxl355_writeable_regs_tbl, IIO_ADXL355);
 
+const struct adxl355_chip_info adxl35x_chip_info[] = {
+	[ADXL355] = {
+		.name = "adxl355",
+		.part_id = ADXL355_PARTID_VAL,
+		/*
+		 * At +/- 2g with 20-bit resolution, scale is given in datasheet
+		 * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2.
+		 */
+		.accel_scale = {
+			.integer = 0,
+			.decimal = 38245,
+		},
+		/*
+		 * The datasheet defines an intercept of 1885 LSB at 25 degC
+		 * and a slope of -9.05 LSB/C. The following formula can be used
+		 * to find the temperature:
+		 * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
+		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
+		 * Hence using some rearranging we get the scale as -110.497238
+		 * and offset as -2111.25.
+		 */
+		.temp_offset = {
+			.integer =  -2111,
+			.decimal = 250000,
+		},
+	},
+	[ADXL359] = {
+		.name = "adxl359",
+		.part_id = ADXL359_PARTID_VAL,
+		/*
+		 * At +/- 10g with 20-bit resolution, scale is given in datasheet
+		 * as 19.5ug/LSB = 0.0000195 * 9.80665 = 0.0.00019122967 m/s^2.
+		 */
+		.accel_scale = {
+			.integer = 0,
+			.decimal = 191229,
+		},
+		/*
+		 * The datasheet defines an intercept of 1852 LSB at 25 degC
+		 * and a slope of -9.05 LSB/C. The following formula can be used
+		 * to find the temperature:
+		 * Temp = ((RAW - 1852)/(-9.05)) + 25 but this doesn't follow
+		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
+		 * Hence using some rearranging we get the scale as -110.497238
+		 * and offset as -2079.25.
+		 */
+		.temp_offset = {
+			.integer = -2079,
+			.decimal = 250000,
+		},
+	},
+};
+EXPORT_SYMBOL_NS_GPL(adxl35x_chip_info, IIO_ADXL355);
+
 enum adxl355_op_mode {
 	ADXL355_MEASUREMENT,
 	ADXL355_STANDBY,
@@ -162,6 +217,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
 };
 
 struct adxl355_data {
+	const struct adxl355_chip_info *chip_info;
 	struct regmap *regmap;
 	struct device *dev;
 	struct mutex lock; /* lock to protect op_mode */
@@ -456,33 +512,23 @@ static int adxl355_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-		/*
-		 * The datasheet defines an intercept of 1885 LSB at 25 degC
-		 * and a slope of -9.05 LSB/C. The following formula can be used
-		 * to find the temperature:
-		 * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
-		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
-		 * Hence using some rearranging we get the scale as -110.497238
-		 * and offset as -2111.25.
-		 */
 		case IIO_TEMP:
+			/* Temperature scale is -110.497238.
+			 * See the detailed explanation in adxl35x_chip_info definition above.
+			 */
 			*val = -110;
 			*val2 = 497238;
 			return IIO_VAL_INT_PLUS_MICRO;
-		/*
-		 * At +/- 2g with 20-bit resolution, scale is given in datasheet
-		 * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2.
-		 */
 		case IIO_ACCEL:
-			*val = 0;
-			*val2 = 38245;
+			*val = data->chip_info->accel_scale.integer;
+			*val2 = data->chip_info->accel_scale.decimal;
 			return IIO_VAL_INT_PLUS_NANO;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
-		*val = -2111;
-		*val2 = 250000;
+		*val = data->chip_info->temp_offset.integer;
+		*val2 = data->chip_info->temp_offset.decimal;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		*val = sign_extend32(data->calibbias[chan->address], 15);
@@ -705,7 +751,7 @@ static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
 }
 
 int adxl355_core_probe(struct device *dev, struct regmap *regmap,
-		       const char *name)
+		       const struct adxl355_chip_info *chip_info)
 {
 	struct adxl355_data *data;
 	struct iio_dev *indio_dev;
@@ -720,9 +766,10 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	data->regmap = regmap;
 	data->dev = dev;
 	data->op_mode = ADXL355_STANDBY;
+	data->chip_info = chip_info;
 	mutex_init(&data->lock);
 
-	indio_dev->name = name;
+	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl355_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl355_channels;
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index f67d57921c81..6cde5ccac06b 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -23,6 +23,20 @@ static const struct regmap_config adxl355_i2c_regmap_config = {
 static int adxl355_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
+	const struct adxl355_chip_info *chip_data;
+	const struct i2c_device_id *adxl355;
+
+	chip_data = device_get_match_data(&client->dev);
+	if (!chip_data) {
+		adxl355 = to_i2c_driver(client->dev.driver)->id_table;
+		if (!adxl355)
+			return -EINVAL;
+
+		chip_data = (void *)i2c_match_id(adxl355, client)->driver_data;
+
+		if (!chip_data)
+			return -EINVAL;
+	}
 
 	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -32,17 +46,19 @@ static int adxl355_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return adxl355_core_probe(&client->dev, regmap, client->name);
+	return adxl355_core_probe(&client->dev, regmap, chip_data);
 }
 
 static const struct i2c_device_id adxl355_i2c_id[] = {
-	{ "adxl355", 0 },
+	{ "adxl355", (kernel_ulong_t)&adxl35x_chip_info[ADXL355] },
+	{ "adxl359", (kernel_ulong_t)&adxl35x_chip_info[ADXL359] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl355_i2c_id);
 
 static const struct of_device_id adxl355_of_match[] = {
-	{ .compatible = "adi,adxl355" },
+	{ .compatible = "adi,adxl355", .data = &adxl35x_chip_info[ADXL355] },
+	{ .compatible = "adi,adxl359", .data = &adxl35x_chip_info[ADXL359] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl355_of_match);
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index 5fe986ae03f6..fc99534d91ff 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/property.h>
 
 #include "adxl355.h"
 
@@ -24,9 +25,17 @@ static const struct regmap_config adxl355_spi_regmap_config = {
 
 static int adxl355_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct adxl355_chip_info *chip_data;
 	struct regmap *regmap;
 
+	chip_data = device_get_match_data(&spi->dev);
+	if (!chip_data) {
+		chip_data = (void *)spi_get_device_id(spi)->driver_data;
+
+		if (!chip_data)
+			return -EINVAL;
+	}
+
 	regmap = devm_regmap_init_spi(spi, &adxl355_spi_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
@@ -35,17 +44,19 @@ static int adxl355_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return adxl355_core_probe(&spi->dev, regmap, id->name);
+	return adxl355_core_probe(&spi->dev, regmap, chip_data);
 }
 
 static const struct spi_device_id adxl355_spi_id[] = {
-	{ "adxl355", 0 },
+	{ "adxl355", (kernel_ulong_t)&adxl35x_chip_info[ADXL355] },
+	{ "adxl359", (kernel_ulong_t)&adxl35x_chip_info[ADXL359] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl355_spi_id);
 
 static const struct of_device_id adxl355_of_match[] = {
-	{ .compatible = "adi,adxl355" },
+	{ .compatible = "adi,adxl355", .data = &adxl35x_chip_info[ADXL355] },
+	{ .compatible = "adi,adxl359", .data = &adxl35x_chip_info[ADXL359] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl355_of_match);
-- 
2.25.1

