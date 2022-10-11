Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711C5FB0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJKKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJKKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:48:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9D8C478
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:47:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id nb11so30503703ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyMKsMVCuw9ZEBvXV2FHgkkAIjr61V5h9OSDfmiNCgs=;
        b=UKmbN7aNQZIlF0tVfc5Zxu51GnBRzIGYAENb2JC4xoe1KuMfjqUZ2JW+WVFS09e79l
         NkHKZz9tcMDcw0T6+4lScEIzs/tAHuwj1qjAUoVbKAxriIjAOQU6GQleEWBs1V92FT/r
         55SGxXaghCa2aOkkdFJY2tdIqBnmuHuNlHxFTXD6lhSTZyeFvi/t+Y1vhkbSC9P2meGZ
         8glJsxldcoVNKyYrchI6FZ4RJmcACnCKymBp7DRHE7CLQsknYCiprb8g/H/Uex0Wxrmy
         aDAzvsfsEhpNqDBH/WCAo1Mi2CmtCBQyOQH62aeAQkLu2KMAMdtDXEVf3/tufXEpN8pP
         WQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyMKsMVCuw9ZEBvXV2FHgkkAIjr61V5h9OSDfmiNCgs=;
        b=PSEZBIeccrbGSTTbVZtRbfmHVfgyjnLTnWqykNUBycI9WdjxSVv49hMqrnpsb8V3Bs
         hgDQ2xjMZ/udgHl/6wvUkLJGGWakIXejuGk4Ivp/xh69kzFjoG9UR5GZblX/t87WhupB
         sqx/nqDq7EvvRzopQ8P0T2w9Eg4x7e1Q/JCcRmGY9xUH1ZTLeWQWwHKU7DDlJeWcVRjS
         2U5emvBqjir7V+RpbJcMgzUpFrBfElgYQNFQ8fNxUyYUIDqACP/NQJozE6ghQAIvUtYU
         /Rv7Amle0XbF9GZFthOmMqZURh97vPrS0ly09e3lylnrXBCfQbPvvOWQlJCODsd4Vb5B
         aIpw==
X-Gm-Message-State: ACrzQf2g+TPfS8QIYsGqgVnSHuh67R72F13bMpz1IxtniA8+vbPfb6vb
        o2/5H+kdgvXWYb4xoi5OcVrLYgahzBQCuuNH
X-Google-Smtp-Source: AMsMyM4IXgLTMcL2e+/WgIpBYs97q/vuUiNSgU9JeacxqJgT7un2enEhaCLeoHEPGdLjKjpm3AUylg==
X-Received: by 2002:a17:906:4795:b0:787:434f:d754 with SMTP id cw21-20020a170906479500b00787434fd754mr19163942ejc.268.1665485274717;
        Tue, 11 Oct 2022 03:47:54 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id mf22-20020a1709071a5600b0074136cac2e7sm6753081ejc.81.2022.10.11.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:47:54 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 3/3] hwmon: (max6639) Change from pdata to dt configuration
Date:   Tue, 11 Oct 2022 12:47:39 +0200
Message-Id: <20221011104739.53262-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
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

From: Marcello Sylvester Bauer <sylv@sylv.io>

max6639_platform_data is not used by any in-kernel driver and does not
address the MAX6639 channels separately. Move to device tree
configuration with explicit properties to configure each channel.

Non-DT platform can still use this module with its default
configuration.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/max6639.c               | 260 +++++++++++++++++++-------
 include/linux/platform_data/max6639.h |  15 --
 2 files changed, 197 insertions(+), 78 deletions(-)
 delete mode 100644 include/linux/platform_data/max6639.h

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..75eb4522fc9b 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,48 +19,53 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_data/max6639.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* The MAX6639 registers, valid channel numbers: 0, 1 */
 #define MAX6639_REG_TEMP(ch)			(0x00 + (ch))
-#define MAX6639_REG_STATUS			0x02
+#define MAX6639_REG_STATUS				0x02
 #define MAX6639_REG_OUTPUT_MASK			0x03
-#define MAX6639_REG_GCONFIG			0x04
+#define MAX6639_REG_GCONFIG				0x04
 #define MAX6639_REG_TEMP_EXT(ch)		(0x05 + (ch))
 #define MAX6639_REG_ALERT_LIMIT(ch)		(0x08 + (ch))
 #define MAX6639_REG_OT_LIMIT(ch)		(0x0A + (ch))
 #define MAX6639_REG_THERM_LIMIT(ch)		(0x0C + (ch))
 #define MAX6639_REG_FAN_CONFIG1(ch)		(0x10 + (ch) * 4)
-#define MAX6639_REG_FAN_CONFIG2a(ch)		(0x11 + (ch) * 4)
-#define MAX6639_REG_FAN_CONFIG2b(ch)		(0x12 + (ch) * 4)
+#define MAX6639_REG_FAN_CONFIG2a(ch)	(0x11 + (ch) * 4)
+#define MAX6639_REG_FAN_CONFIG2b(ch)	(0x12 + (ch) * 4)
 #define MAX6639_REG_FAN_CONFIG3(ch)		(0x13 + (ch) * 4)
 #define MAX6639_REG_FAN_CNT(ch)			(0x20 + (ch))
 #define MAX6639_REG_TARGET_CNT(ch)		(0x22 + (ch))
 #define MAX6639_REG_FAN_PPR(ch)			(0x24 + (ch))
 #define MAX6639_REG_TARGTDUTY(ch)		(0x26 + (ch))
-#define MAX6639_REG_FAN_START_TEMP(ch)		(0x28 + (ch))
-#define MAX6639_REG_DEVID			0x3D
-#define MAX6639_REG_MANUID			0x3E
-#define MAX6639_REG_DEVREV			0x3F
+#define MAX6639_REG_FAN_START_TEMP(ch)	(0x28 + (ch))
+#define MAX6639_REG_DEVID				0x3D
+#define MAX6639_REG_MANUID				0x3E
+#define MAX6639_REG_DEVREV				0x3F
 
 /* Register bits */
+#define MAX6639_REG_OUTPUT_MASK_OT(x, ch)		(x << (5 - ch))
+#define MAX6639_REG_OUTPUT_MASK_THERM(x, ch)	(x << (3 - ch))
+#define MAX6639_REG_OUTPUT_MASK_FANFAIL(x, ch)	(x << (1 - ch))
 #define MAX6639_GCONFIG_STANDBY			0x80
-#define MAX6639_GCONFIG_POR			0x40
-#define MAX6639_GCONFIG_DISABLE_TIMEOUT		0x20
+#define MAX6639_GCONFIG_POR				0x40
+#define MAX6639_GCONFIG_DISABLE_TIMEOUT	0x20
 #define MAX6639_GCONFIG_CH2_LOCAL		0x10
 #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
 
 #define MAX6639_FAN_CONFIG1_PWM			0x80
 
+#define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
+#define MAX6639_FAN_CONFIG3_SPIN_UP_DISABLE		0x80
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
 
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
 				0 : (rpm_ranges[rpm_range] * 30) / (val))
+
 #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
 
 /*
@@ -69,7 +74,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 struct max6639_data {
 	struct i2c_client *client;
 	struct mutex update_lock;
-	bool valid;		/* true if following fields are valid */
+	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
 	/* Register values sampled regularly */
@@ -85,9 +90,14 @@ struct max6639_data {
 	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
-
+	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[2];	/* Index in above rpm_ranges table */
+	u8 pwm_polarity[2];	/* Fans PWM polarity, 0..1 */
+	bool full_speed_on_therm[2];	/* disable THERM full speed assertion */
+	bool spin_up_enable[2];		/* Enable fan spin-up if fan is not spinning */
+	bool ot_indication[2];		/* Enable OT pin indication */
+	bool therm_indication[2];	/* Enable THERM pin indication */
+	bool fan_fail_indication[2];	/* Enable FANFAIL pin indication */
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
 };
@@ -144,7 +154,7 @@ static struct max6639_data *max6639_update_device(struct device *dev)
 		}
 
 		data->last_updated = jiffies;
-		data->valid = true;
+		data->valid = 1;
 	}
 abort:
 	mutex_unlock(&data->update_lock);
@@ -319,7 +329,7 @@ static ssize_t fan_input_show(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+		       data->rpm_range[attr->index]));
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -386,28 +396,34 @@ static struct attribute *max6639_attrs[] = {
 ATTRIBUTE_GROUPS(max6639);
 
 /*
- *  returns respective index in rpm_ranges table
- *  1 by default on invalid range
+ *  Get respective index in rpm_ranges table
  */
-static int rpm_range_to_reg(int range)
+static int rpm_range_to_index(u8 *index, int rpm)
 {
 	int i;
 
+	if (rpm <= 0)
+		return -EINVAL;
+
+	/* If provided RPM is more than 16000 RPM then select 16000
+	 * RPM range.
+	 */
+	*index = ARRAY_SIZE(rpm_ranges) - 1;
+
 	for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
-		if (rpm_ranges[i] == range)
-			return i;
+		if (rpm <= rpm_ranges[i]) {
+			*index = i;
+			break;
+		}
 	}
 
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
+	int i, val;
 	int err;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
@@ -416,58 +432,40 @@ static int max6639_init_client(struct i2c_client *client,
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
+		 * Full speed on therm, spin-up at zero rpm.
 		 * PWM frequency 25kHz, see also GCONFIG below
 		 */
 		err = i2c_smbus_write_byte_data(client,
 			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+			(data->full_speed_on_therm[i] ?
+			 MAX6639_FAN_CONFIG3_THERM_FULL_SPEED : 0) |
+			(data->spin_up_enable[i] ?
+			 0 : MAX6639_FAN_CONFIG3_SPIN_UP_DISABLE) | 0x03);
+
 		if (err)
 			goto exit;
 
-		/* Max. temp. 80C/90C/100C */
-		data->temp_therm[i] = 80;
-		data->temp_alert[i] = 90;
-		data->temp_ot[i] = 100;
 		err = i2c_smbus_write_byte_data(client,
 				MAX6639_REG_THERM_LIMIT(i),
 				data->temp_therm[i]);
@@ -483,13 +481,24 @@ static int max6639_init_client(struct i2c_client *client,
 		if (err)
 			goto exit;
 
-		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
 		err = i2c_smbus_write_byte_data(client,
 				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
 		if (err)
 			goto exit;
 	}
+
+	val = 0;
+	for (i = 0; i < 2; i++) {
+		val |= MAX6639_REG_OUTPUT_MASK_OT(
+				data->ot_indication[i], i);
+		val |= MAX6639_REG_OUTPUT_MASK_THERM(
+				data->therm_indication[i], i);
+		val |= MAX6639_REG_OUTPUT_MASK_FANFAIL(
+				data->fan_fail_indication[i], i);
+	}
+	/* Configure output mask register */
+	err = i2c_smbus_write_byte_data(client, MAX6639_REG_OUTPUT_MASK, val);
+
 	/* Start monitoring */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
 		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
@@ -524,12 +533,105 @@ static void max6639_regulator_disable(void *data)
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
+	err = rpm_range_to_index(&data->rpm_range[i], maxrpm);
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
+			(u8)(val * 255 / maxrpm);
+
+	data->pwm_polarity[i] =  of_property_read_bool(child, "pwm-polarity-inverse");
+
+	data->spin_up_enable[i] = of_property_read_bool(child, "maxim,fan-spin-up");
+
+	data->full_speed_on_therm[i] = of_property_read_bool(child,
+		"maxim,full-speed-on-therm");
+
+	data->fan_fail_indication[i] = of_property_read_bool(child, "maxim,fanfail_indication");
+
+	return 0;
+}
+
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
+	data->ot_indication[0] = !of_property_read_bool(np, "ot0_indication");
+	data->ot_indication[1] = !of_property_read_bool(np, "ot1_indication");
+	data->therm_indication[0] = !of_property_read_bool(np, "therm0_indication");
+	data->therm_indication[1] = !of_property_read_bool(np, "therm1_indication");
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
@@ -539,9 +641,11 @@ static int max6639_probe(struct i2c_client *client)
 
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
@@ -560,6 +664,25 @@ static int max6639_probe(struct i2c_client *client)
 
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
+		data->full_speed_on_therm[i] = false;
+	}
+
+	err = max6639_probe_from_dt(client, data);
+	if (err)
+		return err;
+
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -571,6 +694,7 @@ static int max6639_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+#if IS_ENABLED(CONFIG_PM_SLEEP)
 static int max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -608,6 +732,7 @@ static int max6639_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(client,
 			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
 }
+#endif
 
 static const struct i2c_device_id max6639_id[] = {
 	{"max6639", 0},
@@ -616,13 +741,22 @@ static const struct i2c_device_id max6639_id[] = {
 
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
diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
deleted file mode 100644
index 65bfdb4fdc15..000000000000
--- a/include/linux/platform_data/max6639.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_MAX6639_H
-#define _LINUX_MAX6639_H
-
-#include <linux/types.h>
-
-/* platform data for the MAX6639 temperature sensor and fan control */
-
-struct max6639_platform_data {
-	bool pwm_polarity;	/* Polarity low (0) or high (1, default) */
-	int ppr;		/* Pulses per rotation 1..4 (default == 2) */
-	int rpm_range;		/* 2000, 4000 (default), 8000 or 16000 */
-};
-
-#endif /* _LINUX_MAX6639_H */
-- 
2.37.3

