Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986867D87D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjAZWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjAZWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:52 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504645F5E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:32 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h10so2588298qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCHr8u8LkHFJIdDqjoshO09JHhBWtvWwNk0DDadovgI=;
        b=TFi70dSxljUji9Q8+lRwOqeik36CcxykG1bkL7Zmf4w+0tfOzcN5b85Yn9/0xi8/Gj
         sj/I4tMTUr/52yQrbPTK5aruYP4IuMdcqDjtELTU9Bf4/KgwDKbe9h9Vo4ZXVZF1fkBC
         ZI/cth4gdK1SQ8awl1oUTlgXWExLx1Iyt0cZBEQiw+aQBxRIMMFHr4lcRSk+Zvg4f+y8
         ae8jKPwB/UtSxPp0xbI40WchEDa4Ka7ikNQfK500slNPN7y0Mv86dv7Q7k6oDFli0wzw
         kZtYjh57Gw/V9vHYOmcRAjXA70S8lBR8GrW8AfphZyRzyfF6ehRilbsgdCg4mIg6TTpu
         1QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCHr8u8LkHFJIdDqjoshO09JHhBWtvWwNk0DDadovgI=;
        b=zub5W+BKemSgzckjfbAYWHwFNVCU6lUcn07jkdP4Mwj9qQobJxC+WlpW+vlWTsaiLG
         Qu/jSaRRgp3Q6v2xbnQxKbBup/VA1CeflngfY0rwFu6uLWMWcNsX7oqDF5Y4sd2wcuOP
         orcXGAokgFfWmv5UMwYperPIZJhXulPzRg9D0kFzt3qYXWypLqgCDZre9B3WmRYx6X0W
         2WtmSS/y7vOVyK7tjG//g30KAhsCfkniVLKSCEemdk6qgEPmMb4hsvGMc807wIL7btpl
         5m8D0mslnzeWtJwjtfCqDXzhwU7qiwzFG8zubIzI/W2eMxbaBJVrLXtbpUj7WIhtqeTT
         4lSw==
X-Gm-Message-State: AO0yUKWYrcDtyZYi+q6Y1S5oc2UfNhrgZK+YcEGpGeYDiUYu6Si8Kl1R
        zF7TPuJsIGLpTJxS4XCbSy1HON9HTA6Cs+5K9Ps=
X-Google-Smtp-Source: AK7set+POzIdwC2TjvFXAo8YwyVcG5JoC8xn1J6GK4SISPLu8sV+t8bzgGAq3VE4ublbVe2kxOaNng==
X-Received: by 2002:a0c:f812:0:b0:537:8125:b533 with SMTP id r18-20020a0cf812000000b005378125b533mr4687943qvn.34.1674772351923;
        Thu, 26 Jan 2023 14:32:31 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a220700b006ff8a122a1asm1723091qkh.78.2023.01.26.14.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:32:31 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:32:26 -0500
Subject: [PATCH v4 4/5] hwmon: ltc2945: Allow setting shunt resistor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-b4-ltc2945_shunt_resistor-v4-4-bb913470d8da@criticallink.com>
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
In-Reply-To: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9001;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=kCSpCo/P+JFRfq9IZAl6ayWTbbT5LfJiwbvQxfe6g3w=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0v96zFJJWKGHqQesz69ayOn6UqiOCCZzjw53eNx4
 YdJI+omJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9L/egAKCRDc1/0uCzbrqkb+EA
 CCTTrUKXIvVjU0LpKAJFLD/5sUp+4Tg8mMk/H4dslTDJWDfBMPsCYZMxyFzxPgV4leYqaGWZjG6vns
 UWkFvuveqvD1kESxVbY0NiLZjuCmYe4ZP/0Rl9ycRUrFHmSMIhvpaOhBCkiPY028+bGuFc54bakurO
 4txYNTh20oylXaYxx0woWD9K+cdT2zJ3p3F7e2Gbb77HM4rX98HpFC1RvMN03P42ImbaXWGgO+F0h8
 5ihdlmfMMAqGiWNiVmv4++1eldYEYl+c8LrjrwSDbZewxCX6OD/y0xF9atczAWBzILF8H5wo3VQRBU
 VJCCyGWyZxoAeKrVAsovjs+2IO2O2A4BDCu0Mn0hxnYfodlvUYNDl1Rxc45PKFPzVDPTEQRzFfqhLv
 JFp29d2SdlYNesKPDoSrliGql1cOvhLBSd7pW6kVYLN0q3Y0RXt0nW0Rsjzh9oqaf0ZluhY5LadAHo
 UgsZNMVLMNZUAMPomN/sDwROHbspJvCYWqv84PgEHG1dwX54rCPI6Ln/FsBNk35DdNStMsh+Pjnscl
 JQYmNIAchqr6Xf6xniLxWNKZaFL38j4nWBYe+HygM7efrVxwe6IMImIEoTwuLEV/zxH2CjZfHB6ZeN
 wp90D1H0WnxpxuaUYYXXqDJ5YCRig4NyaboWviqrNd0Aj+tVRJ4E3oXOFVsw==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pruitt <jpruitt@criticallink.com>

Add the ability to specify the value of the shunt resistor in the
device tree instead of assuming it is 1 milliOhm. The value in the
device tree has the name shunt-resistor-micro-ohms and the
default value is 1000 micro-ohms in order to preserve the
current behavior.

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: John Pruitt <jpruitt@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 117 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 42 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index ac15298a6558..0b5e448b4f12 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -64,6 +64,16 @@ static const struct of_device_id __maybe_unused ltc2945_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ltc2945_of_match);
 
+/**
+ * struct ltc2945_data - LTC2945 device data
+ * @regmap: regmap device
+ * @shunt_resistor: shunt resistor value in micro ohms (1000 by default)
+ */
+struct ltc2945_data {
+	struct regmap *regmap;
+	u32 shunt_resistor;
+};
+
 static inline bool is_power_reg(u8 reg)
 {
 	return reg < LTC2945_SENSE_H;
@@ -72,7 +82,9 @@ static inline bool is_power_reg(u8 reg)
 /* Return the value from the given register in uW, mV, or mA */
 static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u32 shunt_resistor = data->shunt_resistor;
 	unsigned int control;
 	u8 buf[3];
 	long long val;
@@ -84,10 +96,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 		return ret;
 
 	if (is_power_reg(reg)) {
-		/* power */
+		/* 24-bit power */
 		val = (buf[0] << 16) + (buf[1] << 8) + buf[2];
 	} else {
-		/* current, voltage */
+		/* 12-bit current, voltage */
 		val = (buf[0] << 4) + (buf[1] >> 4);
 	}
 
@@ -98,9 +110,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	case LTC2945_MAX_POWER_THRES_H:
 	case LTC2945_MIN_POWER_THRES_H:
 		/*
-		 * Convert to uW by assuming current is measured with
-		 * an 1mOhm sense resistor, similar to current
-		 * measurements.
+		 * Convert to uW
 		 * Control register bit 0 selects if voltage at SENSE+/VDD
 		 * or voltage at ADIN is used to measure power.
 		 */
@@ -114,6 +124,14 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
 			val = (val * 25LL) >> 1;
 		}
+		val *= 1000;
+		/* Overflow check: Assuming max 24-bit power, val is at most 53 bits right now. */
+		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
+		/*
+		 * Overflow check: After division, depending on shunt resistor,
+		 * val can still be > 32 bits so returning long long makes sense
+		 */
+
 		break;
 	case LTC2945_VIN_H:
 	case LTC2945_MAX_VIN_H:
@@ -136,14 +154,11 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	case LTC2945_MIN_SENSE_H:
 	case LTC2945_MAX_SENSE_THRES_H:
 	case LTC2945_MIN_SENSE_THRES_H:
-		/*
-		 * 25 uV resolution. Convert to current as measured with
-		 * an 1 mOhm sense resistor, in mA. If a different sense
-		 * resistor is installed, calculate the actual current by
-		 * dividing the reported current by the sense resistor value
-		 * in mOhm.
-		 */
-		val *= 25;
+		/* 25 uV resolution. Convert to mA. */
+		val *= 25 * 1000;
+		/* Overflow check: Assuming max 12-bit sense, val is at most 27 bits right now */
+		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
+		/* Overflow check: After division, <= 27 bits */
 		break;
 	default:
 		return -EINVAL;
@@ -151,13 +166,18 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	return val;
 }
 
-static int ltc2945_val_to_reg(struct device *dev, u8 reg,
-			      unsigned long val)
+static long long ltc2945_val_to_reg(struct device *dev, u8 reg,
+			      unsigned long long val)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u32 shunt_resistor = data->shunt_resistor;
 	unsigned int control;
 	int ret;
 
+	/* Ensure we don't overflow */
+	val = clamp_val(val, 0, U32_MAX);
+
 	switch (reg) {
 	case LTC2945_POWER_H:
 	case LTC2945_MAX_POWER_H:
@@ -165,9 +185,6 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MAX_POWER_THRES_H:
 	case LTC2945_MIN_POWER_THRES_H:
 		/*
-		 * Convert to register value by assuming current is measured
-		 * with an 1mOhm sense resistor, similar to current
-		 * measurements.
 		 * Control register bit 0 selects if voltage at SENSE+/VDD
 		 * or voltage at ADIN is used to measure power, which in turn
 		 * determines register calculations.
@@ -177,14 +194,16 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			return ret;
 		if (control & CONTROL_MULT_SELECT) {
 			/* 25 mV * 25 uV = 0.625 uV resolution. */
-			val = DIV_ROUND_CLOSEST(val, 625);
+			val *= shunt_resistor;
+			/* Overflow check: Assuming 32-bit val and shunt resistor, val <= 64bits */
+			val = DIV_ROUND_CLOSEST_ULL(val, 625 * 1000);
+			/* Overflow check: val is now <= 44 bits */
 		} else {
-			/*
-			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
-			 * Divide first to avoid overflow;
-			 * accept loss of accuracy.
-			 */
-			val = DIV_ROUND_CLOSEST(val, 25) * 2;
+			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
+			val *= shunt_resistor;
+			/* Overflow check: Assuming 32-bit val and shunt resistor, val <= 64bits */
+			val = DIV_ROUND_CLOSEST_ULL(val, 25 * 1000) * 2;
+			/* Overflow check: val is now <= 51 bits */
 		}
 		break;
 	case LTC2945_VIN_H:
@@ -208,14 +227,11 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MIN_SENSE_H:
 	case LTC2945_MAX_SENSE_THRES_H:
 	case LTC2945_MIN_SENSE_THRES_H:
-		/*
-		 * 25 uV resolution. Convert to current as measured with
-		 * an 1 mOhm sense resistor, in mA. If a different sense
-		 * resistor is installed, calculate the actual current by
-		 * dividing the reported current by the sense resistor value
-		 * in mOhm.
-		 */
-		val = DIV_ROUND_CLOSEST(val, 25);
+		/* 25 uV resolution. Convert to  mA. */
+		val *= shunt_resistor;
+		/* Overflow check: Assuming 32-bit val and 32-bit shunt resistor, val is 64bits */
+		val = DIV_ROUND_CLOSEST_ULL(val, 25 * 1000);
+		/* Overflow check: val is now <= 50 bits */
 		break;
 	default:
 		return -EINVAL;
@@ -240,15 +256,16 @@ static ssize_t ltc2945_value_store(struct device *dev,
 				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	u8 reg = attr->index;
-	unsigned long val;
+	unsigned int val;
 	u8 regbuf[3];
 	int num_regs;
-	int regval;
+	long long regval;
 	int ret;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -277,7 +294,8 @@ static ssize_t ltc2945_history_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	u8 reg = attr->index;
 	int num_regs = is_power_reg(reg) ? 3 : 2;
 	u8 buf_min[3] = { 0xff, 0xff, 0xff };
@@ -329,7 +347,8 @@ static ssize_t ltc2945_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	unsigned int fault;
 	int ret;
 
@@ -458,6 +477,12 @@ static int ltc2945_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct regmap *regmap;
+	struct ltc2945_data *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	dev_set_drvdata(dev, data);
 
 	regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -465,11 +490,19 @@ static int ltc2945_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
+	data->regmap = regmap;
+	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				     &data->shunt_resistor))
+		data->shunt_resistor = 1000;
+
+	if (data->shunt_resistor == 0)
+		return -EINVAL;
+
 	/* Clear faults */
 	regmap_write(regmap, LTC2945_FAULT, 0x00);
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-							   regmap,
+							   data,
 							   ltc2945_groups);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }

-- 
2.25.1

