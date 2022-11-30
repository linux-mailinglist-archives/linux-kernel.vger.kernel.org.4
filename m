Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02CA63DB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiK3RGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiK3RFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:05:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81C98967
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h11so20832472wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CXiZlD2TyqZ7MaMRJu4QFyk6ysF3bJp4l380A/oYl4=;
        b=Vk1g9N5MtEmS/1qfopQRw1TNtmQiSTBfJ2vUuBLKjdXeRtVwEkWZ2h/9BTjFu5E8er
         4mGUak187PqBT9S8JdjxDQocH+rUGaX33U9iHJwnYPU6teL17Y/B2jQqQPbip0TqWZMC
         DJ741gVu3bdXB+579W6oYTkP2crp+51EerD2N76DvHGh/gTVkZzPu+qICcOVF3ZlzneR
         CmRWcanxe527GsstQ7KMfwhguIceygpMTHTDXGIKuIFUc5jTqNj5EIk9PclOuVGIt1D4
         cFu+n3rcUbN+gW7J4uKh0oxLUtL3R0oyk42dRNSkWxKyudKHu4Qr+x6JSEI2Muqsvlue
         gsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CXiZlD2TyqZ7MaMRJu4QFyk6ysF3bJp4l380A/oYl4=;
        b=HFngznaLGYg1FSlh9eP5rDGfg1MPMWwd9KoULM1y2rWa81seWQfp3KBaOLZJQPy6uF
         wPjMicOvgNRM9mZsFtsCdBfOVUCbb1gLKP796ubBo6oRYpCCqiqgFjyPO6ebK32HUR/s
         foi9DiRpmaByrb4aPjrrHXfoPsuSPuahex4TlUYzkRmOxrFUx4thf9lv70J6ASfBmt/d
         wPv/J8IthE+gj5p6eL/jfUH7W4ylp+xfgiHmH5Z0Dx1bkiO5E/Vz7jMwNq7vDIYsljIp
         U7i0Z2fDLWVLqEbyZO9fhhqeBX4qaNv0bHS0MFXr3fZxqqN9yKlwO55HWHxzFLs6s4iF
         ZtIw==
X-Gm-Message-State: ANoB5pkUk++GdZI5r5LzZShMoMl4yOHa01OJSotgrLcY6vFkQ7USx5VZ
        U8YYsspfXYJu8d596Wmhb9i0tMB6oQCKgn3u
X-Google-Smtp-Source: AA0mqf6MtutqlORB9kMF0rRztaLSnkRJQR8hPZejiVjN0pQBkWHRcZUsCEHk3U4XHaNur/0oczfL/Q==
X-Received: by 2002:adf:9b84:0:b0:242:2f5d:e27f with SMTP id d4-20020adf9b84000000b002422f5de27fmr2029177wrc.54.1669827612102;
        Wed, 30 Nov 2022 09:00:12 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm2457159wmb.42.2022.11.30.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:00:11 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 3/4] hwmon: (pmbus/core): Implement irq support
Date:   Wed, 30 Nov 2022 17:59:53 +0100
Message-Id: <20221130165955.3479143-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221130165955.3479143-1-Naresh.Solanki@9elements.com>
References: <20221130165955.3479143-1-Naresh.Solanki@9elements.com>
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Implement PMBUS irq handler to notify regulator events.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h      |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 151 ++++++++++++++++++++++++++++---
 2 files changed, 137 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 10fb17879f8e..6b2e6cf93b19 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -26,7 +26,7 @@ enum pmbus_regs {
 
 	PMBUS_CAPABILITY		= 0x19,
 	PMBUS_QUERY			= 0x1A,
-
+	PMBUS_SMBALERT_MASK		= 0x1B,
 	PMBUS_VOUT_MODE			= 0x20,
 	PMBUS_VOUT_COMMAND		= 0x21,
 	PMBUS_VOUT_TRIM			= 0x22,
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 9a9e380acc23..613e2e484a0f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -81,6 +81,7 @@ struct pmbus_label {
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
+	struct regulator_dev **rdevs;
 
 	u32 flags;		/* from platform data */
 
@@ -2804,7 +2805,8 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 	},
 };
 
-static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
+				    unsigned int *event)
 {
 	int i, status;
 	const struct pmbus_regulator_status_category *cat;
@@ -2815,7 +2817,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	u8 page = rdev_get_id(rdev);
 	int func = data->info->func[page];
 
-	*flags = 0;
+	*error = 0;
+	*event = 0;
 
 	mutex_lock(&data->update_lock);
 
@@ -2831,8 +2834,10 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 		}
 
 		for (bit = cat->bits; bit->pflag; bit++) {
-			if (status & bit->pflag)
-				*flags |= bit->rflag;
+			if (status & bit->pflag) {
+				*error |= bit->rflag;
+				*event |= bit->eflag;
+			}
 		}
 	}
 
@@ -2851,11 +2856,15 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 		return status;
 
 	if (pmbus_regulator_is_enabled(rdev)) {
-		if (status & PB_STATUS_OFF)
-			*flags |= REGULATOR_ERROR_FAIL;
+		if (status & PB_STATUS_OFF) {
+			*error |= REGULATOR_ERROR_FAIL;
+			*event |= REGULATOR_EVENT_FAIL;
+		}
 
-		if (status & PB_STATUS_POWER_GOOD_N)
-			*flags |= REGULATOR_ERROR_REGULATION_OUT;
+		if (status & PB_STATUS_POWER_GOOD_N) {
+			*error |= REGULATOR_ERROR_REGULATION_OUT;
+			*event |= REGULATOR_EVENT_REGULATION_OUT;
+		}
 	}
 
 	/*
@@ -2863,13 +2872,22 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
 	 * a (conservative) best-effort interpretation.
 	 */
-	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
-	    (status & PB_STATUS_TEMPERATURE))
-		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
+	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
+	    (status & PB_STATUS_TEMPERATURE)) {
+		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
+		*event |= REGULATOR_EVENT_OVER_TEMP_WARN;
+	}
 
 	return 0;
 }
 
+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	unsigned int event;
+
+	return pmbus_regulator_get_flags(rdev, flags, &event);
+}
+
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
 {
 	struct device *dev = rdev_get_dev(rdev);
@@ -3060,14 +3078,61 @@ const struct regulator_ops pmbus_regulator_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
 
+static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
+{
+	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
+}
+
+static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
+{
+	struct pmbus_data *data = pdata;
+	struct i2c_client *client = to_i2c_client(data->dev);
+	int i, ret = IRQ_NONE, status, event;
+	u8 page;
+
+	for (i = 0; i < data->info->num_regulators; i++) {
+
+		if (!data->rdevs[i])
+			continue;
+
+		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, &event);
+		if (ret)
+			return ret;
+
+		if (event) {
+			regulator_notifier_call_chain(data->rdevs[i], event, NULL);
+			ret = IRQ_HANDLED;
+		}
+
+		page = rdev_get_id(data->rdevs[i]);
+		mutex_lock(&data->update_lock);
+		status = pmbus_read_status_word(client, page);
+		if (status < 0) {
+			mutex_unlock(&data->update_lock);
+			return status;
+		}
+
+		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
+			pmbus_clear_fault_page(client, page);
+
+		mutex_unlock(&data->update_lock);
+	}
+
+	return ret;
+}
+
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	struct device *dev = data->dev;
 	const struct pmbus_driver_info *info = data->info;
 	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
-	struct regulator_dev *rdev;
 	int i;
 
+	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
+				  GFP_KERNEL);
+	if (!data->rdevs)
+		return -ENOMEM;
+
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
 
@@ -3077,21 +3142,71 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
+		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
 					       &config);
-		if (IS_ERR(rdev))
-			return dev_err_probe(dev, PTR_ERR(rdev),
+		if (IS_ERR(data->rdevs[i]))
+			return dev_err_probe(dev, PTR_ERR(data->rdevs[i]),
 					     "Failed to register %s regulator\n",
 					     info->reg_desc[i].name);
 	}
 
 	return 0;
 }
+
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
+{
+	struct device *dev = &client->dev;
+	const struct pmbus_regulator_status_category *cat;
+	const struct pmbus_regulator_status_assoc *bit;
+	int i, j, err, ret;
+	u8 mask;
+	int func;
+
+	for (i = 0; i < data->info->pages; i++) {
+		func = data->info->func[i];
+
+		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
+			cat = &pmbus_regulator_flag_map[i];
+			if (!(func & cat->func))
+				continue;
+			mask = 0;
+			for (bit = cat->bits; bit->pflag; bit++)
+				mask |= bit->pflag;
+
+			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
+			if (err)
+				dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",	cat->reg);
+		}
+
+		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_CML, 0xff);
+		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_OTHER, 0xff);
+		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_MFR_SPECIFIC, 0xff);
+		if (data->info->func[i] & PMBUS_HAVE_FAN12)
+			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_12, 0xff);
+		if (data->info->func[i] & PMBUS_HAVE_FAN34)
+			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_34, 0xff);
+
+	}
+
+	/* Register notifiers - can fail if IRQ is not given */
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
+			      0, "pmbus-irq", data);
+	if (ret) {
+		dev_warn(dev, "IRQ disabled %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
 #else
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	return 0;
 }
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
+{
+	return 0;
+}
 #endif
 
 static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
@@ -3456,6 +3571,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 	if (ret)
 		return ret;
 
+	if (client->irq > 0) {
+		ret = pmbus_irq_setup(client, data);
+		if (ret)
+			return ret;
+	}
+
 	ret = pmbus_init_debugfs(client, data);
 	if (ret)
 		dev_warn(dev, "Failed to register debugfs\n");
-- 
2.37.3

