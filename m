Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919DE5FCCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJLU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJLU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:59:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED910C4DD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:58:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b4so27954889wrs.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMyEn9/l1GnS0KeabX8cS3jjIciny2a6oc7n6OgkRYQ=;
        b=P6hjR790FQQh8j0KeQ3Z4wYUPu1C24zn5/4kyONlYocmqHkV69RavAUK7Ebbl5MauP
         ZMdyYE+EH5z+fSFHSqh6wQYTLJwp6EnG60CrU8xWf/z1IZeXzYp7uPajXs780U5x1wwO
         AIYhlMbQdjexCusmGL81qh4qctKQhXRwn35hGJyXznk+y60ieUdlu0XsmMExFjFb50gR
         sASBHnRef9ZdW9u5hIaX3eYGm9qt+pgNmn5JPB9DcJTFi4Qgsw+6CN5xdp1px/KbtKJ9
         xnsk1YQSOH/aXHnFOBErgXIFoWTqtVcIt9nEjsJaAmnH34OruWnXQ+X0WmtXfFoHSQ0r
         YrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMyEn9/l1GnS0KeabX8cS3jjIciny2a6oc7n6OgkRYQ=;
        b=6xsYxmr7qrurVaOEfr0jtYdtKX0Lisq7+Sv0mzw2GyqVmUs8skZzEILirxJvZwH8ri
         AUF+MVo7kOva07cm9d7rJTODnKIHAv8bzwPsmaGRKXjn6PMBb454hy7v30JfZ6Td9cE9
         ENXPqZnh+K8DiWak/9Xwz69wHUoFnaaq+6qj6s389ox6BAWewBAbBZ55/tVZ9TlvTF2O
         4zkuJsorhJLXn2A0LOX0RNFoaNutzYl1IlDk/GSwUocfxJf0SwbVgjnGY590DLh/E43Q
         YNDaIQZH982S05F686SXbgAUv/aNPsOBfyMH704EipJYsXIgtj2g7+V3SyqcGWhx6bY2
         hR4A==
X-Gm-Message-State: ACrzQf1wAZtXoTqAMkbGZbWOPtkvLy5AuZN4R/Wa3DqPRF4IlG585Nh0
        GwGZhLylY2cVTPe1bGUfieLA2w==
X-Google-Smtp-Source: AMsMyM4U++oIdheY/Y6Oufgx29Uu/NYF7YKmPDg3kzCJ9eQ9XcVPs1LWz8Pea5gpbV/n/a8ojSzvJQ==
X-Received: by 2002:a05:6000:144f:b0:231:2053:ef7c with SMTP id v15-20020a056000144f00b002312053ef7cmr8299394wrx.179.1665608264013;
        Wed, 12 Oct 2022 13:57:44 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003c6cd82596esm3165443wmq.43.2022.10.12.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:57:43 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 3/3] hwmon: (max6639) Change from pdata to dt configuration
Date:   Wed, 12 Oct 2022 22:57:36 +0200
Message-Id: <20221012205736.1231514-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012205736.1231514-1-Naresh.Solanki@9elements.com>
References: <20221012205736.1231514-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max6639_platform_data is not used by any in-kernel driver and does not
address the MAX6639 fans separately.
Move to device tree configuration with explicit properties to configure
each fan.

Non-DT platform can still use this module with its default
configuration.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/max6639.c | 205 +++++++++++++++++++++++++++++-----------
 1 file changed, 152 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..2fc096a00e21 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,7 +19,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_data/max6639.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -85,9 +84,9 @@ struct max6639_data {
 	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
-
+	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[2];	/* Index in above rpm_ranges table */
+	u8 pwm_polarity[2];	/* Fans PWM polarity, 0..1 */
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
 };
@@ -319,7 +318,7 @@ static ssize_t fan_input_show(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+		       data->rpm_range[attr->index]));
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -386,29 +385,39 @@ static struct attribute *max6639_attrs[] = {
 ATTRIBUTE_GROUPS(max6639);
 
 /*
- *  returns respective index in rpm_ranges table
- *  1 by default on invalid range
+ *  Get respective index in rpm_ranges table
  */
-static int rpm_range_to_reg(int range)
+static int rpm_range_to_index(struct device *dev, u8 *index, int rpm)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
-		if (rpm_ranges[i] == range)
-			return i;
+	if (rpm < 0)
+		return -EINVAL;
+
+	/* Set index based on chip support */
+	switch (rpm) {
+	case 0 ... 2000:
+		*index = 0;
+		break;
+	case 2001 ... 4000:
+		*index = 1;
+		break;
+	case 4001 ... 8000:
+		*index = 2;
+		break;
+	case 8001 ... 16000:
+		*index = 3;
+		break;
+	default:
+		/* Use max range for higher RPM */
+		dev_warn(dev, "RPM higher than supported range.");
+		*index = 3;
 	}
-
-	return 1; /* default: 4000 RPM */
+	return 0;
 }
 
 static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
-	struct max6639_platform_data *max6639_info =
-		dev_get_platdata(&client->dev);
-	int i;
-	int rpm_range = 1; /* default: 4000 RPM */
-	int err;
+	int i, err;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
@@ -416,51 +425,32 @@ static int max6639_init_client(struct i2c_client *client,
 	if (err)
 		goto exit;
 
-	/* Fans pulse per revolution is 2 by default */
-	if (max6639_info && max6639_info->ppr > 0 &&
-			max6639_info->ppr < 5)
-		data->ppr = max6639_info->ppr;
-	else
-		data->ppr = 2;
-	data->ppr -= 1;
-
-	if (max6639_info)
-		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
-	data->rpm_range = rpm_range;
-
 	for (i = 0; i < 2; i++) {
 
 		/* Set Fan pulse per revolution */
 		err = i2c_smbus_write_byte_data(client,
 				MAX6639_REG_FAN_PPR(i),
-				data->ppr << 6);
+				data->ppr[i] << 6);
 		if (err)
 			goto exit;
 
 		/* Fans config PWM, RPM */
 		err = i2c_smbus_write_byte_data(client,
 			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
+			MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
 		if (err)
 			goto exit;
 
-		/* Fans PWM polarity high by default */
-		if (max6639_info && max6639_info->pwm_polarity == 0)
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-		else
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
-		if (err)
-			goto exit;
+		/* Fans PWM polarity */
+		err = i2c_smbus_write_byte_data(client,
+			MAX6639_REG_FAN_CONFIG2a(i), data->pwm_polarity[i] ? 0x02 : 0x00);
 
 		/*
-		 * /THERM full speed enable,
+		 * /THERM full speed disable,
 		 * PWM frequency 25kHz, see also GCONFIG below
 		 */
 		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+			MAX6639_REG_FAN_CONFIG3(i), 0x03);
 		if (err)
 			goto exit;
 
@@ -483,8 +473,6 @@ static int max6639_init_client(struct i2c_client *client,
 		if (err)
 			goto exit;
 
-		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
 		err = i2c_smbus_write_byte_data(client,
 				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
 		if (err)
@@ -524,12 +512,92 @@ static void max6639_regulator_disable(void *data)
 	regulator_disable(data);
 }
 
+static int max6639_probe_child_from_dt(struct i2c_client *client,
+				      struct device_node *child,
+				      struct max6639_data *data)
+
+{
+	struct device *dev = &client->dev;
+	u32 i, val, maxrpm;
+	int err;
+
+	err = of_property_read_u32(child, "reg", &i);
+	if (err) {
+		dev_err(dev, "missing reg property of %pOFn\n", child);
+		return err;
+	}
+
+	if (i >= 2) {
+		dev_err(dev, "invalid reg %d of %pOFn\n", i, child);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(child, "pulses-per-revolution", &val);
+	if (err) {
+		dev_err(dev, "missing pulses-per-revolution property of %pOFn\n", child);
+		return err;
+	}
+
+	if (val < 0 || val > 5) {
+		dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
+		return -EINVAL;
+	}
+	data->ppr[i] = val;
+
+	err = of_property_read_u32(child, "max-rpm", &maxrpm);
+	if (err) {
+		dev_err(dev, "missing max-rpm property of %pOFn\n", child);
+		return err;
+	}
+
+	err = rpm_range_to_index(dev, &data->rpm_range[i], maxrpm);
+	if (err) {
+		dev_err(dev, "invalid max-rpm %d of %pOFn\n", maxrpm, child);
+		return err;
+	}
+
+
+	err = of_property_read_u32(child, "target-rpm", &val);
+	/* Convert to PWM from provided target RPM */
+	if (!err && val != 0)
+		data->pwm[i] =
+			(u8)(val * 120 / maxrpm);
+
+	data->pwm_polarity[i] =  of_property_read_bool(child, "pwm-polarity-inverse");
+
+	return 0;
+}
+static int max6639_probe_from_dt(struct i2c_client *client, struct max6639_data *data)
+{
+	struct device *dev = &client->dev;
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int err;
+
+	/* Compatible with non-DT platforms */
+	if (!np)
+		return 0;
+
+	for_each_child_of_node(np, child) {
+		if (strcmp(child->name, "fan"))
+			continue;
+
+		err = max6639_probe_child_from_dt(client, child, data);
+		if (err) {
+			of_node_put(child);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int max6639_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct max6639_data *data;
 	struct device *hwmon_dev;
-	int err;
+	int err, i;
 
 	data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
 	if (!data)
@@ -539,9 +607,11 @@ static int max6639_probe(struct i2c_client *client)
 
 	data->reg = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(data->reg)) {
-		if (PTR_ERR(data->reg) != -ENODEV)
-			return PTR_ERR(data->reg);
-
+		if (PTR_ERR(data->reg) != -ENODEV) {
+			err = (int)PTR_ERR(data->reg);
+			dev_warn(dev, "Failed looking up fan supply: %d\n", err);
+			return err;
+		}
 		data->reg = NULL;
 	} else {
 		/* Spin up fans */
@@ -560,6 +630,24 @@ static int max6639_probe(struct i2c_client *client)
 
 	mutex_init(&data->update_lock);
 
+	/* default values */
+	for (i = 0; i < 2; i++) {
+		/* 4000 RPM */
+		data->rpm_range[i] = 1;
+		data->ppr[i] = 2;
+		data->pwm_polarity[i] = 1;
+		/* Max. temp. 80C/90C/100C */
+		data->temp_therm[i] = 80;
+		data->temp_alert[i] = 90;
+		data->temp_ot[i] = 100;
+		/* PWM 120/120 (i.e. 100%) */
+		data->pwm[i] = 120;
+	}
+
+	err = max6639_probe_from_dt(client, data);
+	if (err)
+		return err;
+
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -571,6 +659,7 @@ static int max6639_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+#if IS_ENABLED(CONFIG_PM_SLEEP)
 static int max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -608,6 +697,7 @@ static int max6639_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(client,
 			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
 }
+#endif
 
 static const struct i2c_device_id max6639_id[] = {
 	{"max6639", 0},
@@ -616,13 +706,22 @@ static const struct i2c_device_id max6639_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max6639_id);
 
-static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
+#ifdef CONFIG_OF
+static const struct of_device_id maxim_of_platform_match[] = {
+	{.compatible = "maxim,max6639"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
+#endif
+
+static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
 
 static struct i2c_driver max6639_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		   .name = "max6639",
 		   .pm = pm_sleep_ptr(&max6639_pm_ops),
+		   .of_match_table = of_match_ptr(maxim_of_platform_match),
 		   },
 	.probe_new = max6639_probe,
 	.id_table = max6639_id,
-- 
2.37.3

