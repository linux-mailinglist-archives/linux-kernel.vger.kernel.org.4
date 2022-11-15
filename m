Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC146298B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiKOMVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiKOMVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:21:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308B2A96E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:20:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z14so23802028wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPVVmKupHXufx78iZ+1zTJn1ObV4U7i/qmWH2SMuCMI=;
        b=D5ZL5TbYLHBkgKzyVC9AJvdlEFuZkk/RLmsJVwaPghgAHCYYEXQmQgqMQY5jfel8y1
         Kqe74IXHdq+/ZKMx2QE59rvNrsycuoGyT3zPc4PRWEv73yQwZZbQDqWOOGdkvOB+XNpc
         17/IJmNeZq7QkASbFQ8soa2Gctn8R4lIMrN93QFDGH6NPg4xWjSjf5NkXCTuU1gMIh0z
         PpUtIKQjC+q7Lg7bDyL5+M8D7tCcHuCsjS1XXZq9oGIvBwHYutByqihmcvvo2TZeKkqf
         VwvNwzUoNIKJmWmuxKfA0JsvJmvoKYRiPorQN30fDYbbLknwUf0l4Og5suqwgS4P4Wpe
         XECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPVVmKupHXufx78iZ+1zTJn1ObV4U7i/qmWH2SMuCMI=;
        b=aw2on7e56UEfLw+SKhlL0XLFfZq+hmxEaGDN2KZ5Z7SSVmr5EPdZr9L93V+o8CoVcf
         ogsAZSKr/7l79jtWQkweFuimszXhDU+xKmyFOnwM0pavqhgQxIZB3cOQ4/ctbsA64mY0
         NIld93QX0HlHmHZ4MPCRT4RUo3xsOHYUB80Pn03crP+y2VQ2xOlNRlCr1WQhxjKL71Pz
         M+Y2ieGX4RQy8yuLW0xUhqNfmGuJ/VkGNhcbPrTYAhx1np6IWMUH0rc08WieCEjMUFYL
         D/EGR/d84OyDpYFWmCB+R4sNN8j1FF8BT6/H8m9Iy9GiRxB5fhJEa0Gduf9LpUvaRHdR
         mopw==
X-Gm-Message-State: ANoB5pnDyT88rx2ogb8IAvm9Zxs5gjV/RShCRnCpDV/L5/flRzjcImjY
        M9m1S8W9kCLOnatvQBkHsHtmPNl+uQfrIHI7
X-Google-Smtp-Source: AA0mqf6wsVwlDM/1nwIbmRrqBf86ywGZQByN/DHkgQIcHHWPFamSPG3GXx0OWUY2Bh2nV9AI8cwvCA==
X-Received: by 2002:a5d:4386:0:b0:22e:3177:1401 with SMTP id i6-20020a5d4386000000b0022e31771401mr10249748wrq.148.1668514831907;
        Tue, 15 Nov 2022 04:20:31 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm27108954wmo.0.2022.11.15.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:20:31 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v5 3/3] hwmon: (max6639) Change from pdata to dt configuration
Date:   Tue, 15 Nov 2022 13:20:05 +0100
Message-Id: <20221115122005.758519-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115122005.758519-1-Naresh.Solanki@9elements.com>
References: <20221115122005.758519-1-Naresh.Solanki@9elements.com>
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

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/max6639.c | 465 +++++++++++++++++++++++++++++++++-------
 2 files changed, 392 insertions(+), 74 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5695b266abcf..ad1f6742ca50 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1106,6 +1106,7 @@ config SENSORS_MAX6621
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
+	depends on PWM
 	help
 	  If you say yes here you get support for the MAX6639
 	  sensor chips.
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..d1ae77e8f72e 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,7 +19,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_data/max6639.h>
+#include <linux/pwm.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -54,11 +54,20 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
 
 #define MAX6639_FAN_CONFIG1_PWM			0x80
-
+#define MAX6639_REG_FAN_CONFIG2a_PWM_POL	0x02
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
+#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
+#define MAX6639_REG_TARGTDUTY_SLOT		120
 
+/* Tach supported range. This internally controls tach frequency */
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
+/* Supported PWM frequency */
+static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
+					25000 };
+
+
+
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
 				0 : (rpm_ranges[rpm_range] * 30) / (val))
 #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
@@ -76,20 +85,24 @@ struct max6639_data {
 	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
 	bool temp_fault[2];	/* Detected temperature diode failure */
 	u8 fan[2];		/* Register value: TACH count for fans >=30 */
+	struct pwm_device	*pwmd[2]; /* max6639 has two pwm device */
+	u32 target_rpm[2];
+	u32 max_rpm[2];
+
 	u8 status;		/* Detected channel alarms and fan failures */
 
 	/* Register values only written to */
-	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
 	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
 	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
 	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
-
+	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[2];	/* Index in above rpm_ranges table */
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
+	/* max6639 pwm chip */
+	struct pwm_chip chip;
 };
 
 static struct max6639_data *max6639_update_device(struct device *dev)
@@ -280,8 +293,12 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	struct pwm_state state;
+
+	pwm_get_state(data->pwmd[attr->index], &state);
+
+	return sprintf(buf, "%d\n", pwm_get_relative_duty_cycle(&state, 255));
 
-	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
 }
 
 static ssize_t pwm_store(struct device *dev,
@@ -290,9 +307,9 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
+	struct pwm_state state;
 
 	res = kstrtoul(buf, 10, &val);
 	if (res)
@@ -300,12 +317,12 @@ static ssize_t pwm_store(struct device *dev,
 
 	val = clamp_val(val, 0, 255);
 
-	mutex_lock(&data->update_lock);
-	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_TARGTDUTY(attr->index),
-				  data->pwm[attr->index]);
-	mutex_unlock(&data->update_lock);
+	pwm_get_state(data->pwmd[attr->index], &state);
+	pwm_set_relative_duty_cycle(&state, val, 255);
+	res = pwm_apply_state(data->pwmd[attr->index], &state);
+	if (res)
+		return res;
+
 	return count;
 }
 
@@ -319,7 +336,7 @@ static ssize_t fan_input_show(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+		       data->rpm_range[attr->index]));
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -386,29 +403,41 @@ static struct attribute *max6639_attrs[] = {
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
+		dev_warn(dev,
+		    "RPM higher than supported range. Default to 16000 RPM");
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
+	struct pwm_state state;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
@@ -416,51 +445,29 @@ static int max6639_init_client(struct i2c_client *client,
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
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_PPR(i),
-				data->ppr << 6);
+		err = i2c_smbus_write_byte_data(client,	MAX6639_REG_FAN_PPR(i),
+						data->ppr[i] << 6);
 		if (err)
 			goto exit;
 
 		/* Fans config PWM, RPM */
 		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
-		if (err)
-			goto exit;
-
-		/* Fans PWM polarity high by default */
-		if (max6639_info && max6639_info->pwm_polarity == 0)
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-		else
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
+						MAX6639_REG_FAN_CONFIG1(i),
+						MAX6639_FAN_CONFIG1_PWM |
+						data->rpm_range[i]);
 		if (err)
 			goto exit;
 
 		/*
-		 * /THERM full speed enable,
+		 * /THERM full speed disable,
 		 * PWM frequency 25kHz, see also GCONFIG below
 		 */
 		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+						MAX6639_REG_FAN_CONFIG3(i),
+						0x03);
 		if (err)
 			goto exit;
 
@@ -469,31 +476,35 @@ static int max6639_init_client(struct i2c_client *client,
 		data->temp_alert[i] = 90;
 		data->temp_ot[i] = 100;
 		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_THERM_LIMIT(i),
-				data->temp_therm[i]);
+						MAX6639_REG_THERM_LIMIT(i),
+						data->temp_therm[i]);
 		if (err)
 			goto exit;
 		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_ALERT_LIMIT(i),
-				data->temp_alert[i]);
+						MAX6639_REG_ALERT_LIMIT(i),
+						data->temp_alert[i]);
 		if (err)
 			goto exit;
 		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
+						MAX6639_REG_OT_LIMIT(i),
+						data->temp_ot[i]);
 		if (err)
 			goto exit;
 
-		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
+		/* Configure PWM controller */
+		pwm_get_state(data->pwmd[i], &state);
+		pwm_set_relative_duty_cycle(&state, data->target_rpm[i],
+					    data->max_rpm[i]);
+		err = pwm_apply_state(data->pwmd[i], &state);
 		if (err)
 			goto exit;
+
 	}
 	/* Start monitoring */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
 		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
 		MAX6639_GCONFIG_PWM_FREQ_HI);
+
 exit:
 	return err;
 }
@@ -524,12 +535,276 @@ static void max6639_regulator_disable(void *data)
 	regulator_disable(data);
 }
 
+static int max6639_probe_child_from_dt(struct i2c_client *client,
+				      struct device_node *child,
+				      struct max6639_data *data)
+
+{
+	struct device *dev = &client->dev;
+	u32 i, maxrpm;
+	int val, err;
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
+		dev_err(dev, "missing pulses-per-revolution property of %pOFn",
+			child);
+		return err;
+	}
+
+	if (val < 0 || val > 5) {
+		dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val,
+			child);
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
+	data->max_rpm[i] = maxrpm;
+
+	err = of_property_read_u32(child, "target-rpm", &val);
+	/* Use provided target RPM else default to maxrpm */
+	if (!err)
+		data->target_rpm[i] = val;
+	else
+		data->target_rpm[i] = maxrpm;
+
+	/* Get pwms property for PWM control */
+	data->pwmd[i] = devm_fwnode_pwm_get(dev, &child->fwnode, NULL);
+
+	if (!IS_ERR(data->pwmd[i]))
+		return 0;
+
+	if (PTR_ERR(data->pwmd[i]) == -EPROBE_DEFER)
+		return PTR_ERR(data->pwmd[i]);
+
+	dev_dbg(dev, "Using chip default PWM");
+	data->pwmd[i] = pwm_request_from_chip(&data->chip, i, NULL);
+	if (!IS_ERR(data->pwmd[i]))
+		return 0;
+
+	dev_dbg(dev, "Failed to configure pwm for fan %d", i);
+	return PTR_ERR_OR_ZERO(data->pwmd[i]);
+}
+
+static int max6639_probe_from_dt(struct i2c_client *client,
+				 struct max6639_data *data)
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
+static struct max6639_data *to_max6639_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct max6639_data, chip);
+}
+
+static void max6639_pwm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+
+	struct max6639_data *data = to_max6639_pwm(chip);
+	struct i2c_client *client = data->client;
+	int value, i = pwm->hwpwm, x;
+	unsigned int freq;
+
+	mutex_lock(&data->update_lock);
+
+	value = i2c_smbus_read_byte_data(client, MAX6639_REG_FAN_CONFIG1(i));
+	if (value < 0)
+		goto abort;
+
+	if (value & MAX6639_FAN_CONFIG1_PWM) {
+		state->enabled = true;
+
+		/* Determine frequency from respective registers */
+		value = i2c_smbus_read_byte_data(client,
+						 MAX6639_REG_FAN_CONFIG3(i));
+		if (value < 0)
+			goto abort;
+		x = value & MAX6639_FAN_CONFIG3_FREQ_MASK;
+
+		value = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
+		if (value < 0)
+			goto abort;
+		if (value & MAX6639_GCONFIG_PWM_FREQ_HI)
+			x |= 0x4;
+		x &= 0x7;
+		freq = freq_table[x];
+
+		state->period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+
+		value = i2c_smbus_read_byte_data(client,
+						 MAX6639_REG_TARGTDUTY(i));
+		if (value < 0)
+			goto abort;
+		/* max6639 supports 120 slots only */
+		state->duty_cycle = DIV_ROUND_UP_ULL(value * state->period,
+						     120);
+
+		value = i2c_smbus_read_byte_data(client,
+						 MAX6639_REG_FAN_CONFIG2a(i));
+		if (value < 0)
+			goto abort;
+		value &= MAX6639_REG_FAN_CONFIG2a_PWM_POL;
+		state->polarity = (value != 0);
+	} else
+		state->enabled = false;
+
+abort:
+	mutex_unlock(&data->update_lock);
+
+}
+
+static int max6639_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct max6639_data *data = to_max6639_pwm(chip);
+	struct i2c_client *client = data->client;
+	int value = 0, i = pwm->hwpwm, x;
+	unsigned int freq;
+	struct pwm_state cstate;
+
+	pwm_get_state(pwm, &cstate);
+
+	mutex_lock(&data->update_lock);
+
+	if (state->period != cstate.period) {
+		/* Configure frequency */
+		freq = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state->period);
+		/* Chip supports limited number of frequency */
+		for (x = 0; x < sizeof(freq_table); x++)
+			if (freq < freq_table[x])
+				break;
+
+		value = i2c_smbus_read_byte_data(client,
+						 MAX6639_REG_FAN_CONFIG3(i));
+		if (value < 0)
+			goto abort;
+		value &= ~MAX6639_FAN_CONFIG3_FREQ_MASK;
+		value |= (x & MAX6639_FAN_CONFIG3_FREQ_MASK);
+		value = i2c_smbus_write_byte_data(client,
+						  MAX6639_REG_FAN_CONFIG3(i),
+						  value);
+
+		value = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
+		if (value < 0)
+			goto abort;
+
+		if ((value & MAX6639_GCONFIG_PWM_FREQ_HI) && (x >> 2))
+			value &= ~MAX6639_GCONFIG_PWM_FREQ_HI;
+		else
+			value |= MAX6639_GCONFIG_PWM_FREQ_HI;
+		value = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
+						  value);
+		if (value < 0)
+			goto abort;
+	}
+
+	/* Configure dutycycle */
+	if (state->duty_cycle != cstate.duty_cycle) {
+		value = DIV_ROUND_UP_ULL(
+				state->duty_cycle * MAX6639_REG_TARGTDUTY_SLOT,
+				state->period);
+		value = i2c_smbus_write_byte_data(client,
+						  MAX6639_REG_TARGTDUTY(i),
+						  value);
+		if (value < 0)
+			goto abort;
+	}
+
+	/* Configure polarity */
+	if (state->polarity != cstate.polarity) {
+		value = i2c_smbus_read_byte_data(client,
+						 MAX6639_REG_FAN_CONFIG2a(i));
+		if (value < 0)
+			goto abort;
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			value |= MAX6639_REG_FAN_CONFIG2a_PWM_POL;
+		else
+			value &= ~MAX6639_REG_FAN_CONFIG2a_PWM_POL;
+		value = i2c_smbus_write_byte_data(client,
+						  MAX6639_REG_FAN_CONFIG2a(i),
+						  value);
+		if (value < 0)
+			goto abort;
+	}
+
+	if (state->enabled == cstate.enabled)
+		goto abort;
+
+	value = i2c_smbus_read_byte_data(client, MAX6639_REG_FAN_CONFIG1(i));
+	if (value < 0)
+		goto abort;
+	if (state->enabled)
+		value |= MAX6639_FAN_CONFIG1_PWM;
+	else
+		value &= ~MAX6639_FAN_CONFIG1_PWM;
+
+	value = i2c_smbus_write_byte_data(client, MAX6639_REG_FAN_CONFIG1(i),
+					  value);
+	if (value < 0)
+		goto abort;
+	value = 0;
+
+abort:
+	mutex_unlock(&data->update_lock);
+
+	return value;
+}
+
+static const struct pwm_ops max6639_pwm_ops = {
+	.apply = max6639_pwm_apply,
+	.get_state = max6639_pwm_get_state,
+	.owner = THIS_MODULE,
+};
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
@@ -537,11 +812,26 @@ static int max6639_probe(struct i2c_client *client)
 
 	data->client = client;
 
+	/* Add PWM controller of max6639 */
+	data->chip.dev = dev;
+	data->chip.ops = &max6639_pwm_ops;
+	data->chip.npwm = 2;
+	data->chip.of_pwm_n_cells = 3;
+
+	err = devm_pwmchip_add(dev, &data->chip);
+	if (err < 0) {
+		dev_err(dev, "failed to add PWM chip %d\n", err);
+		return err;
+	}
+
 	data->reg = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(data->reg)) {
-		if (PTR_ERR(data->reg) != -ENODEV)
-			return PTR_ERR(data->reg);
-
+		if (PTR_ERR(data->reg) != -ENODEV) {
+			err = (int)PTR_ERR(data->reg);
+			dev_warn(dev, "Failed looking up fan supply: %d\n",
+				 err);
+			return err;
+		}
 		data->reg = NULL;
 	} else {
 		/* Spin up fans */
@@ -560,6 +850,22 @@ static int max6639_probe(struct i2c_client *client)
 
 	mutex_init(&data->update_lock);
 
+	/* Below are defaults leter overridden by DT properties */
+	for (i = 0; i < 2; i++) {
+		/* 4000 RPM */
+		data->rpm_range[i] = 1;
+		data->ppr[i] = 2;
+		/* Max. temp. 80C/90C/100C */
+		data->temp_therm[i] = 80;
+		data->temp_alert[i] = 90;
+		data->temp_ot[i] = 100;
+	}
+
+	/* Probe from DT to get configuration */
+	err = max6639_probe_from_dt(client, data);
+	if (err)
+		return err;
+
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -571,6 +877,7 @@ static int max6639_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+#if IS_ENABLED(CONFIG_PM_SLEEP)
 static int max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -608,6 +915,7 @@ static int max6639_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(client,
 			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
 }
+#endif
 
 static const struct i2c_device_id max6639_id[] = {
 	{"max6639", 0},
@@ -616,13 +924,22 @@ static const struct i2c_device_id max6639_id[] = {
 
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

