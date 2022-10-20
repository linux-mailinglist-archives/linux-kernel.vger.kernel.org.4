Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02464606A02
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTVDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJTVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:03:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEBCCABC0;
        Thu, 20 Oct 2022 14:03:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b12so1411903edd.6;
        Thu, 20 Oct 2022 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHw/+KFKVZbjIecQIVXVGAioojTxw4dIL71FgSte190=;
        b=DcLN++pOsGTUM/bBGhTHiekkfMBSUqBFRiYN7viTVfr9qLgr2rh1ZD6NCtO6HnOrRY
         AKBduYuKXtORMXK9RcjLjWKX3x4YNXFqkBxt2FjR4i+ST4ln7Z5A0h3Ef7qcBmxWf0QO
         nl3SV6KCmv7qiJ7LQ2/KY7+lpIBVunBWY/HrOMCsPS224f6U3B5ciKOjcJURa2WwU80G
         dbKqed0CVF9AGkI3irGC7EsXaL47OGzVJwI1ZEghkszTWmSR/V9LrE4omKuRhQGYb91g
         p826C499e3g3XUjiJWI1Dl8dh2zzWCff/rJMTj9mjZhA+IrZHGYahYBDZdXf5Xb6u7np
         hAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHw/+KFKVZbjIecQIVXVGAioojTxw4dIL71FgSte190=;
        b=ZivmC8Njuwsue2h/hcn7atyGk1NR5esppl1p5DcgsBTbTUriP8byGTfiSx1mTjKxgI
         K3tGkUmiDUe09KmNWfEbWndhd30//i+rVrTq0ZFYrhFCzNzWw6B4ei3uvbeoVxGeiQHx
         RIOD9vQDsOWqXxUlkljriAchxYnOzuPWoJSl17Jp9fu6fJi2jzxc4UZktPcRZ3luswsd
         loqwTSJMU5z6K35JpZURizSigzrJZm/qvq2AoyD1O3af6FBaZAbotTXmbWlh5iNd/904
         gAnhFaGv4vnq8zFH7NjSJaAaOcVvZHdBDVt/TkF6RdXeXxXZ4w4hs2WE79QUbAqoevc2
         lvjg==
X-Gm-Message-State: ACrzQf1Ekz3HpZOiiaBPLlgs6YCC+8K/BY8o3HAY5qFQRTf/w/k8Uhmc
        XOn1T8oFOSukARnWEAHj6LTrj/Yoc90=
X-Google-Smtp-Source: AMsMyM6F3Uw6RFZv+xkLM7GwFHbkdqHL3nfta9o1T2+0lxdYVEeCFjesYoYbZHgu11HIG+jby4ZaQw==
X-Received: by 2002:a05:6402:1cc1:b0:45c:3a90:9499 with SMTP id ds1-20020a0564021cc100b0045c3a909499mr14262814edb.61.1666299822800;
        Thu, 20 Oct 2022 14:03:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c046-3500-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c046:3500::e63])
        by smtp.googlemail.com with ESMTPSA id 18-20020a170906211200b00779cde476e4sm10748721ejt.62.2022.10.20.14.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:03:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 1/4] hwmon: (jc42) Convert register access to use an I2C regmap
Date:   Thu, 20 Oct 2022 23:03:17 +0200
Message-Id: <20221020210320.1624617-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the jc42 driver to use an I2C regmap to access the registers.
This is done in preparation for improving the caching of registers and
to restore the cached limits during system resume.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/jc42.c  | 102 +++++++++++++++++++++++++-----------------
 2 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7ac3daaf59ce..d3bccc8176c5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -799,6 +799,7 @@ config SENSORS_IT87
 config SENSORS_JC42
 	tristate "JEDEC JC42.4 compliant memory module temperature sensors"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here, you get support for JEDEC JC42.4 compliant
 	  temperature sensors, which are used on many DDR3 memory modules for
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 30888feaf589..329a80264556 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {
@@ -216,7 +217,7 @@ static const u8 temp_regs[t_num_temp] = {
 
 /* Each client has this additional data */
 struct jc42_data {
-	struct i2c_client *client;
+	struct regmap	*regmap;
 	struct mutex	update_lock;	/* protect register access */
 	bool		extended;	/* true if extended range supported */
 	bool		valid;
@@ -251,19 +252,16 @@ static int jc42_temp_from_reg(s16 reg)
 static struct jc42_data *jc42_update_device(struct device *dev)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	struct jc42_data *ret = data;
-	int i, val;
+	unsigned int i, val;
+	int ret;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		for (i = 0; i < t_num_temp; i++) {
-			val = i2c_smbus_read_word_swapped(client, temp_regs[i]);
-			if (val < 0) {
-				ret = ERR_PTR(val);
+			ret = regmap_read(data->regmap, temp_regs[i], &val);
+			if (ret)
 				goto abort;
-			}
 			data->temp[i] = val;
 		}
 		data->last_updated = jiffies;
@@ -271,7 +269,7 @@ static struct jc42_data *jc42_update_device(struct device *dev)
 	}
 abort:
 	mutex_unlock(&data->update_lock);
-	return ret;
+	return ret ? ERR_PTR(ret) : data;
 }
 
 static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
@@ -326,7 +324,6 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long val)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	int diff, hyst;
 	int ret;
 
@@ -335,18 +332,18 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_min:
 		data->temp[t_min] = jc42_temp_to_reg(val, data->extended);
-		ret = i2c_smbus_write_word_swapped(client, temp_regs[t_min],
-						   data->temp[t_min]);
+		ret = regmap_write(data->regmap, temp_regs[t_min],
+				   data->temp[t_min]);
 		break;
 	case hwmon_temp_max:
 		data->temp[t_max] = jc42_temp_to_reg(val, data->extended);
-		ret = i2c_smbus_write_word_swapped(client, temp_regs[t_max],
-						   data->temp[t_max]);
+		ret = regmap_write(data->regmap, temp_regs[t_max],
+				   data->temp[t_max]);
 		break;
 	case hwmon_temp_crit:
 		data->temp[t_crit] = jc42_temp_to_reg(val, data->extended);
-		ret = i2c_smbus_write_word_swapped(client, temp_regs[t_crit],
-						   data->temp[t_crit]);
+		ret = regmap_write(data->regmap, temp_regs[t_crit],
+				   data->temp[t_crit]);
 		break;
 	case hwmon_temp_crit_hyst:
 		/*
@@ -368,9 +365,8 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 		}
 		data->config = (data->config & ~JC42_CFG_HYST_MASK) |
 				(hyst << JC42_CFG_HYST_SHIFT);
-		ret = i2c_smbus_write_word_swapped(data->client,
-						   JC42_REG_CONFIG,
-						   data->config);
+		ret = regmap_write(data->regmap, JC42_REG_CONFIG,
+				   data->config);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -470,51 +466,79 @@ static const struct hwmon_chip_info jc42_chip_info = {
 	.info = jc42_info,
 };
 
+static bool jc42_readable_reg(struct device *dev, unsigned int reg)
+{
+	return (reg >= JC42_REG_CAP && reg <= JC42_REG_DEVICEID) ||
+		reg == JC42_REG_SMBUS;
+}
+
+static bool jc42_writable_reg(struct device *dev, unsigned int reg)
+{
+	return (reg >= JC42_REG_CONFIG && reg <= JC42_REG_TEMP_CRITICAL) ||
+		reg == JC42_REG_SMBUS;
+}
+
+static bool jc42_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == JC42_REG_CONFIG || reg == JC42_REG_TEMP;
+}
+
+static const struct regmap_config jc42_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = JC42_REG_SMBUS,
+	.writeable_reg = jc42_writable_reg,
+	.readable_reg = jc42_readable_reg,
+	.volatile_reg = jc42_volatile_reg,
+};
+
 static int jc42_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
+	unsigned int config, cap;
 	struct jc42_data *data;
-	int config, cap;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(struct jc42_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &jc42_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	cap = i2c_smbus_read_word_swapped(client, JC42_REG_CAP);
-	if (cap < 0)
-		return cap;
+	ret = regmap_read(data->regmap, JC42_REG_CAP, &cap);
+	if (ret)
+		return ret;
 
 	data->extended = !!(cap & JC42_CAP_RANGE);
 
 	if (device_property_read_bool(dev, "smbus-timeout-disable")) {
-		int smbus;
-
 		/*
 		 * Not all chips support this register, but from a
 		 * quick read of various datasheets no chip appears
 		 * incompatible with the below attempt to disable
 		 * the timeout. And the whole thing is opt-in...
 		 */
-		smbus = i2c_smbus_read_word_swapped(client, JC42_REG_SMBUS);
-		if (smbus < 0)
-			return smbus;
-		i2c_smbus_write_word_swapped(client, JC42_REG_SMBUS,
-					     smbus | SMBUS_STMOUT);
+		ret = regmap_set_bits(data->regmap, JC42_REG_SMBUS,
+				      SMBUS_STMOUT);
+		if (ret)
+			return ret;
 	}
 
-	config = i2c_smbus_read_word_swapped(client, JC42_REG_CONFIG);
-	if (config < 0)
-		return config;
+	ret = regmap_read(data->regmap, JC42_REG_CONFIG, &config);
+	if (ret)
+		return ret;
 
 	data->orig_config = config;
 	if (config & JC42_CFG_SHUTDOWN) {
 		config &= ~JC42_CFG_SHUTDOWN;
-		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG, config);
+		regmap_write(data->regmap, JC42_REG_CONFIG, config);
 	}
 	data->config = config;
 
@@ -535,7 +559,7 @@ static void jc42_remove(struct i2c_client *client)
 
 		config = (data->orig_config & ~JC42_CFG_HYST_MASK)
 		  | (data->config & JC42_CFG_HYST_MASK);
-		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG, config);
+		regmap_write(data->regmap, JC42_REG_CONFIG, config);
 	}
 }
 
@@ -546,8 +570,7 @@ static int jc42_suspend(struct device *dev)
 	struct jc42_data *data = dev_get_drvdata(dev);
 
 	data->config |= JC42_CFG_SHUTDOWN;
-	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
-				     data->config);
+	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
 	return 0;
 }
 
@@ -556,8 +579,7 @@ static int jc42_resume(struct device *dev)
 	struct jc42_data *data = dev_get_drvdata(dev);
 
 	data->config &= ~JC42_CFG_SHUTDOWN;
-	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
-				     data->config);
+	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
 	return 0;
 }
 
-- 
2.38.1

