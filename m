Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E263220B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKUMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKUM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:29:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207FB4073
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t1so8344051wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42FU8QS0Q4hrQTp2XxYMrcn/SR5rM3XxkeVj0MMdKrY=;
        b=dG3v2v4PjTz3kjJE8b9TPnYKKcmh+t6AdR/E6kkhSDOyF0l3dEYN1LvO7Yw13zZ3C3
         nAgtV9V4Nbn+SYFKBt6/Vi8tOoSIw1Q+tNPf8Ugd28kJpg/mNPmFZAWLxuRoWcfrK1dC
         R9WiCDKi2HcxotAgCk/y5w+rf/1Q7/HSqmkdI3R5dTESWTODdiiY6b7iApygXC9fh4v2
         kdo1YJpDeRrpDKdimUhqn4OMnGwNh9wYLi21x0qedlEoLRmyTBfdNY4CrLhA0TvwRhTp
         x7VmyiXQHsyD97xthh0aBXQrWWyOYY7J2FgL47/UlpWZYuY4MhEJUYqAaXyFUZM9zv6E
         hy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42FU8QS0Q4hrQTp2XxYMrcn/SR5rM3XxkeVj0MMdKrY=;
        b=xcQG7VICeOwzaB2849bdmF7RVlFZudPhxVW4WGXoRD41fySg5MeN0v5+A4afzcN4sM
         OKdDOGcPcFKOBj+XvtA5kB4t93RJz9SGcsy3bvLuuHsbbI5YRi0II2ZYrgUsCngeIQPm
         TPJC+tgnYVurPbM6OwXehBd1vqmnYhnlpLQg3zooQs8H911/hx66q9tncZloh4ZZEkZs
         hF3ou9GhOnZh1zWxd/VeVAWIY9orG+Yh1yllDJQaxKkgAyBrHAx4nUGZPETsKEIWwOxy
         9fLZT5J/yl3lF+LZwcQBEF36eKbQRFacoJ+zg5ovhFPv94QjnrLNtDa5MUNuQLbqhItq
         B5Cw==
X-Gm-Message-State: ANoB5pnLSIF9Htm89+1NPlYNTsCHa89Y1h/wzu2/UxI50X5jKJGEcUDO
        M8NioTQM1g9a49h/p5x+zeRTqQ==
X-Google-Smtp-Source: AA0mqf4DBZ+gKSFqXf5BdUHVPZjHturZePf7SeldkGwvxtTIIrLWH5tljSR7LY0iMPcUTwFZdCDTxQ==
X-Received: by 2002:a7b:cd85:0:b0:3cf:931c:3cfa with SMTP id y5-20020a7bcd85000000b003cf931c3cfamr3726623wmj.203.1669033786957;
        Mon, 21 Nov 2022 04:29:46 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id dn12-20020a05600c654c00b003cf6c2f9513sm13929015wmb.2.2022.11.21.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:29:46 -0800 (PST)
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
        linux-pwm@vger.kernel.org
Subject: [PATCH v7 4/4] hwmon: (max6639) Add pwm support
Date:   Mon, 21 Nov 2022 13:29:32 +0100
Message-Id: <20221121122932.2493174-5-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
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

Add pwm support for max6639. Also configure pwm fan speed based on pwm
provided in DT.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/max6639.c | 229 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 216 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 3176c33af6c6..56d9004b7a38 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1115,6 +1115,7 @@ config SENSORS_MAX6621
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
+	depends on PWM
 	help
 	  If you say yes here you get support for the MAX6639
 	  sensor chips.
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index feafa3511297..5bfeee35abf0 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/pwm.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -61,6 +62,10 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 /* Tach supported range. This internally controls tach frequency */
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
+/* Supported PWM frequency */
+static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
+					   25000 };
+
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
 				0 : (rpm_ranges[rpm_range] * 30) / (val))
 #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
@@ -78,9 +83,9 @@ struct max6639_data {
 	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
 	bool temp_fault[2];	/* Detected temperature diode failure */
 	u8 fan[2];		/* Register value: TACH count for fans >=30 */
+	struct pwm_device	*pwmd[2]; /* max6639 has two pwm device */
 	u32 target_rpm[2];
 	u32 max_rpm[2];
-	u8 pwm[2];
 
 	u8 status;		/* Detected channel alarms and fan failures */
 
@@ -92,9 +97,10 @@ struct max6639_data {
 	/* Register values initialized only once */
 	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
 	u8 rpm_range[2];	/* Index in above rpm_ranges table */
-	u8 pwm_polarity[2];
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
+	/* max6639 pwm chip */
+	struct pwm_chip chip;
 };
 
 static struct max6639_data *max6639_update_device(struct device *dev)
@@ -285,8 +291,11 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	struct pwm_state state;
+
+	pwm_get_state(data->pwmd[attr->index], &state);
 
-	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
+	return sprintf(buf, "%d\n", pwm_get_relative_duty_cycle(&state, 255));
 
 }
 
@@ -296,9 +305,9 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
+	struct pwm_state state;
 
 	res = kstrtoul(buf, 10, &val);
 	if (res)
@@ -306,11 +315,11 @@ static ssize_t pwm_store(struct device *dev,
 
 	val = clamp_val(val, 0, 255);
 
-	mutex_lock(&data->update_lock);
-	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	i2c_smbus_write_byte_data(client, MAX6639_REG_TARGTDUTY(attr->index),
-				 data->pwm[attr->index]);
-	mutex_unlock(&data->update_lock);
+	pwm_get_state(data->pwmd[attr->index], &state);
+	pwm_set_relative_duty_cycle(&state, val, 255);
+	res = pwm_apply_state(data->pwmd[attr->index], &state);
+	if (res)
+		return res;
 
 	return count;
 }
@@ -426,6 +435,7 @@ static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
 	int i, err;
+	struct pwm_state state;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
@@ -479,10 +489,11 @@ static int max6639_init_client(struct i2c_client *client,
 		if (err)
 			goto exit;
 
-		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = data->target_rpm[i];
-		err = i2c_smbus_write_byte_data(client, MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
-
+		/* Configure PWM controller */
+		pwm_get_state(data->pwmd[i], &state);
+		pwm_set_relative_duty_cycle(&state, data->target_rpm[i],
+					    data->max_rpm[i]);
+		err = pwm_apply_state(data->pwmd[i], &state);
 		if (err)
 			goto exit;
 
@@ -576,7 +587,22 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 	else
 		data->target_rpm[i] = maxrpm;
 
-	return 0;
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
 }
 
 static int max6639_probe_from_dt(struct i2c_client *client,
@@ -605,6 +631,172 @@ static int max6639_probe_from_dt(struct i2c_client *client,
 	return 0;
 }
 
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
+		state->period = DIV_ROUND_UP(NSEC_PER_SEC, freq);
+
+		value = i2c_smbus_read_byte_data(client,
+						 MAX6639_REG_TARGTDUTY(i));
+		if (value < 0)
+			goto abort;
+		/* max6639 supports 120 slots only */
+		state->duty_cycle = mul_u64_u32_div(state->period, value, 120);
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
+	cstate = pwm->state;
+
+	mutex_lock(&data->update_lock);
+
+	if (state->period != cstate.period) {
+		/* Configure frequency */
+		freq = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state->period);
+		/* Chip supports limited number of frequency */
+		for (x = 0; x < sizeof(freq_table); x++)
+			if (freq <= freq_table[x])
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
+		if (x >> 2)
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
+	if (state->duty_cycle != cstate.duty_cycle ||
+	    state->period != cstate.period) {
+		value = DIV_ROUND_DOWN_ULL(
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
@@ -618,6 +810,15 @@ static int max6639_probe(struct i2c_client *client)
 
 	data->client = client;
 
+	/* Add PWM controller of max6639 */
+	data->chip.dev = dev;
+	data->chip.ops = &max6639_pwm_ops;
+	data->chip.npwm = 2;
+
+	err = devm_pwmchip_add(dev, &data->chip);
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to add PWM chip\n");
+
 	data->reg = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(data->reg)) {
 		if (PTR_ERR(data->reg) != -ENODEV) {
-- 
2.37.3

