Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5EC64D225
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiLNWHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLNWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:07:49 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B4442F4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:07:43 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z12so3701711qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkruMqduxIbjtx8gXwhOn81yywW3pdpreSNZQFqbSOk=;
        b=TcJVe3cOaqvIGQaH6BmLwuzQ18Pqn6CwMr9RJM6kFs2gxALvRVq7dTcBOngYh5vES7
         iDZJzdeftZnWyRsIFKX06imAc3Vc0CBCvOHLR83C4DV/LFwMz1mRf+XZew9nrCcCtBu3
         z/Cj09zA8ZnL8sOrLiKhUg1v9NlhoT5KXtdnCjASLj1UGkXEl72qQPqQ4L9SK1FzC8mv
         jec6AxiFPSofa9b2+mRw6zE8MG7roXNobJxG6JD+fdAJV++GHdoKzQ4jGzE39SEvU2rF
         NxAXm5kqD4o3MSvy2YNIzuaEGQHgLgK6iShzWiHU3ZItTY/LBo20HAZzfC2pHk1yw5Fw
         zhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkruMqduxIbjtx8gXwhOn81yywW3pdpreSNZQFqbSOk=;
        b=jnhJiL4W9KZe6FJ1POjuAQcjpuO7K3gdyf6aWaO7FCsUyh9/ro79r8nJQOfcsOnhhC
         X2/SJiD2ywc3QTcxv37U7CKriDsUx3flVP3fO2gZDhSYEl7Px4B8enmBZOw+I19VTBXQ
         lYNqzo9FQWeyOZDypIXkbuT9rdflTcBcqi4y32/9Wo6rxGMAHKLNTqc+7B/wN0bLY48h
         ZDch1ufAK88E3BlvBPtNQ43rVhKaa+G3GWxuyRNcIdIi+rewI7sxHBVrMaWEw1SangND
         qNZDLBUXjiCVku+PbC8UcC1y/ctQSSxgqK28M9684YYeHw7xGq5e02ERT5VQmcN8BRCl
         v3MQ==
X-Gm-Message-State: ANoB5pn/cMf+Wz9gZZTHwlUDz9zawKE1o6Rk9rusiK6frh3m9MvhbcJS
        AytaVi7XqPRaspWPQLMaYL+r1A==
X-Google-Smtp-Source: AA0mqf61hmftnE2cie9po67xol3T56V060QxdLlDKUi4YXYmHzfqUmHNiaujOiiymdbHijyRbv4FEw==
X-Received: by 2002:ac8:689a:0:b0:3a7:ec54:cfa2 with SMTP id m26-20020ac8689a000000b003a7ec54cfa2mr38298744qtq.56.1671055662630;
        Wed, 14 Dec 2022 14:07:42 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id l24-20020ae9f018000000b006fc2b672950sm10623939qkg.37.2022.12.14.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:07:42 -0800 (PST)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     John Pruitt <jpruitt@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH 2/2] hwmon: ltc2945: Allow setting shunt resistor
Date:   Wed, 14 Dec 2022 17:07:27 -0500
Message-Id: <20221214220727.1350784-3-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214220727.1350784-1-jcormier@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pruitt <jpruitt@criticallink.com>

Added the ability to specify the value of the shunt resistor in the
device tree instead of assuming it is 1 milliOhm. The value in the
device tree has the name shunt-resistor-micro-ohms and the
default value is 1000 micro-ohms in order to preserve the
current behavior.

Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
Signed-off-by: John Pruitt <jpruitt@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 86 +++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 9adebb59f604..4e8b92e53133 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -58,6 +58,11 @@
 #define CONTROL_MULT_SELECT	(1 << 0)
 #define CONTROL_TEST_MODE	(1 << 4)
 
+struct ltc2945_data {
+	struct regmap *regmap;
+	u32 shunt_resistor; // number of microohms
+};
+
 static inline bool is_power_reg(u8 reg)
 {
 	return reg < LTC2945_SENSE_H;
@@ -66,7 +71,9 @@ static inline bool is_power_reg(u8 reg)
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
@@ -93,8 +100,11 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	case LTC2945_MIN_POWER_THRES_H:
 		/*
 		 * Convert to uW by assuming current is measured with
-		 * an 1mOhm sense resistor, similar to current
-		 * measurements.
+		 * a 1000 microOhm sense resistor (aka shunt resistor)
+		 * or what is specified in DT, similar to current
+		 * measurements. The shunt_resistor value is in
+		 * microOhms.
+		 *
 		 * Control register bit 0 selects if voltage at SENSE+/VDD
 		 * or voltage at ADIN is used to measure power.
 		 */
@@ -108,6 +118,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
 			val = (val * 25LL) >> 1;
 		}
+		val *= 1000;
+		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
 		break;
 	case LTC2945_VIN_H:
 	case LTC2945_MAX_VIN_H:
@@ -132,12 +144,15 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	case LTC2945_MIN_SENSE_THRES_H:
 		/*
 		 * 25 uV resolution. Convert to current as measured with
-		 * an 1 mOhm sense resistor, in mA. If a different sense
-		 * resistor is installed, calculate the actual current by
-		 * dividing the reported current by the sense resistor value
-		 * in mOhm.
+		 * an 1000 microOhm sense (or shunt) resistor, in mA.
+		 * If a different shunt resistor is installed, calculate
+		 * the actual current by dividing the reported current
+		 * by the shunt resistor value in microOhms. The actual
+		 * The actual shunt resistor value can be specified
+		 * in the device tree.
 		 */
-		val *= 25;
+		val *= 25 * 1000;
+		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
 		break;
 	default:
 		return -EINVAL;
@@ -148,7 +163,9 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			      unsigned long val)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u32 shunt_resistor = data->shunt_resistor;
 	unsigned int control;
 	int ret;
 
@@ -160,8 +177,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MIN_POWER_THRES_H:
 		/*
 		 * Convert to register value by assuming current is measured
-		 * with an 1mOhm sense resistor, similar to current
+		 * with a 1000 microOhm sense resistor, (aka shunt resistor)
+		 * or what is specified in DT, similar to current
 		 * measurements.
+		 *
 		 * Control register bit 0 selects if voltage at SENSE+/VDD
 		 * or voltage at ADIN is used to measure power, which in turn
 		 * determines register calculations.
@@ -171,14 +190,16 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			return ret;
 		if (control & CONTROL_MULT_SELECT) {
 			/* 25 mV * 25 uV = 0.625 uV resolution. */
-			val = DIV_ROUND_CLOSEST(val, 625);
+			val *= shunt_resistor;
+			val = DIV_ROUND_CLOSEST(val, 625 * 1000);
 		} else {
 			/*
 			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
 			 * Divide first to avoid overflow;
 			 * accept loss of accuracy.
 			 */
-			val = DIV_ROUND_CLOSEST(val, 25) * 2;
+			val *= shunt_resistor;
+			val = DIV_ROUND_CLOSEST(val, 25 * 1000) * 2;
 		}
 		break;
 	case LTC2945_VIN_H:
@@ -204,12 +225,14 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MIN_SENSE_THRES_H:
 		/*
 		 * 25 uV resolution. Convert to current as measured with
-		 * an 1 mOhm sense resistor, in mA. If a different sense
-		 * resistor is installed, calculate the actual current by
-		 * dividing the reported current by the sense resistor value
-		 * in mOhm.
+		 * a 1000 microOhm sense (or shunt) resistor, in mA. If
+		 * a different shunt resistor is installed, calculate
+		 * the actual current by dividing the reported current
+		 * by the sense resistor value in microOhms. The actual
+		 * shunt resistor value can be specified in the device tree.
 		 */
-		val = DIV_ROUND_CLOSEST(val, 25);
+		val *= shunt_resistor;
+		val = DIV_ROUND_CLOSEST(val, 25 * 1000);
 		break;
 	default:
 		return -EINVAL;
@@ -234,7 +257,8 @@ static ssize_t ltc2945_value_store(struct device *dev,
 				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	u8 reg = attr->index;
 	unsigned long val;
 	u8 regbuf[3];
@@ -269,7 +293,8 @@ static ssize_t ltc2945_history_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	u8 reg = attr->index;
 	int num_regs = is_power_reg(reg) ? 3 : 2;
 	u8 buf_min[3] = { 0xff, 0xff, 0xff };
@@ -321,7 +346,8 @@ static ssize_t ltc2945_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	unsigned int fault;
 	int ret;
 
@@ -450,6 +476,14 @@ static int ltc2945_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct regmap *regmap;
+	u32 shunt_resistor;
+
+	struct ltc2945_data *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	dev_set_drvdata(dev, data);
 
 	regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -457,11 +491,21 @@ static int ltc2945_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
+	data->regmap = regmap;
+	if (of_property_read_u32(client->dev.of_node,
+				 "shunt-resistor-micro-ohms", &shunt_resistor))
+		shunt_resistor = 1000; /* 1000 micro-Ohm if not set via DT */
+
+	if (shunt_resistor == 0)
+		return -EINVAL;
+
+	data->shunt_resistor = shunt_resistor;
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

