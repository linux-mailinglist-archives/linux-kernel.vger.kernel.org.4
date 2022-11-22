Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82675633E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKVNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiKVNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:50:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E8857B66
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:50:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g12so24765676wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anPtCF5gBJhBr5uCnQB81OM8p3Xz5Q/bnswXpaOxfac=;
        b=IZnvrEAHpQbFCVb2X0xMbyK7M7glhqm5TW4CNLb88tUcFT4xnnmYnCaQdSBG3kYszw
         3E9+xksP9YbojeVUxrEuyNfjYAYuXR8lBpXurT1jFeEAAngAeiSpQ+ZWU3fxJffSvUmM
         WzkHEYpdekadPwBgliW/B7/tcPDCfEex5os5247I60frjYPm/ruJqpwt8PGPYVEpgHO6
         4aZEb+uiqb0BCp1v/tpfcaWkhLNZVx4EiKt5sO+vlmZKXfkgDYzCKaJnVlFbaPNVkgY9
         r4Ae/OZdQ3qRmQFYhKSGrWFD2DEYKag626eq9vpF9+LrVk/YwgaOf38xuKST6H3wqiTF
         L38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anPtCF5gBJhBr5uCnQB81OM8p3Xz5Q/bnswXpaOxfac=;
        b=KXDG3lUa0BNKv0mX8a0J+gQunOmRAqlPEiN0N2JUJykpbLRWqo+JS5haACHDT1df6M
         +517I5r8+kJHGtxu8YFHFeRuiTXTuTlkOzqDoAGZ8FUasTQ1T5cr47FsCGSz1kDvJKQD
         i+htF8hGrhU0lnTJtSB7adFWwpl0yJKlPw2jUZtW8f5PJeH8vW9MfDIB4G7KswCakZfS
         4OJscjwvzB+PKlKW5L5PT8WAWdUkmUmAwNOLRWXPsaLZLwmYONY7jCruXXP6zYpwMiww
         mDLsk0cSRwOxvzvCFORiMJLErWzKEjFtbWo4dUoP7vZwwB6xpaI9xypMBR1d4pKLEnM9
         8LdQ==
X-Gm-Message-State: ANoB5plkLSWOB3NBJyArVg9VUPJDYDbU/q61JY+H5dDULDTXCVZ5eWHc
        H11DiBs8z/262dB/pFMIQYG0Og==
X-Google-Smtp-Source: AA0mqf5QgdcZ/OOjlvli5z5iQi2BcnAncn3DVpnEZV7M4C+vJFQ3LY2Hh01VWZkJiTeCS+nPAEaIrw==
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id t10-20020adfeb8a000000b0022e31b2ecb9mr14552775wrn.693.1669125021741;
        Tue, 22 Nov 2022 05:50:21 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c465100b003cf483ee8e0sm19947254wmo.24.2022.11.22.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:50:21 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (pmbus/core): Implement IRQ support
Date:   Tue, 22 Nov 2022 14:50:13 +0100
Message-Id: <20221122135014.3504094-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122135014.3504094-1-Naresh.Solanki@9elements.com>
References: <20221122135014.3504094-1-Naresh.Solanki@9elements.com>
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Implement IRQ support to monitor PMBUS regulator events.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h      |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 151 ++++++++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 13 deletions(-)

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
index 7d7d10039987..0c0d9419e72a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3033,13 +3033,107 @@ const struct regulator_ops pmbus_regulator_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
 
-static int pmbus_regulator_register(struct pmbus_data *data)
+static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
 {
-	struct device *dev = data->dev;
+	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
+}
+
+static int pmbus_irq_subhandler(struct i2c_client *client, struct regulator_err_state *stat,
+			       unsigned long *dev_mask)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u8 page = rdev_get_id(stat->rdev);
+	const struct pmbus_regulator_status_category *cat;
+	const struct pmbus_regulator_status_assoc *bit;
+	int status, i;
+	int func = data->info->func[page];
+
+	stat->notifs = 0;
+	stat->errors = 0;
+
+	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
+		cat = &pmbus_regulator_flag_map[i];
+		if (!(func & cat->func))
+			continue;
+
+		status = _pmbus_read_byte_data(client, page, cat->reg);
+		if (status < 0) {
+			mutex_unlock(&data->update_lock);
+			return status;
+		}
+
+		for (bit = cat->bits; bit->pflag; bit++) {
+			if (status & bit->pflag) {
+				stat->notifs |= bit->eflag;
+				stat->errors |= bit->rflag;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int pmbus_fault_handler(int irq, struct regulator_irq_data *rid, unsigned long *dev_mask)
+{
+	struct regulator_err_state *stat;
+	struct pmbus_data *data;
+	struct device *dev;
+	struct i2c_client *client;
+	int status;
+	u8 page;
+	int i;
+
+	*dev_mask = 0;
+	rid->opaque = 0;
+
+	for (i = 0; i < rid->num_states; i++) {
+		stat  = &rid->states[i];
+		dev = rdev_get_dev(stat->rdev);
+		client = to_i2c_client(dev->parent);
+		data = i2c_get_clientdata(client);
+		page = rdev_get_id(stat->rdev);
+
+		mutex_lock(&data->update_lock);
+		status = pmbus_irq_subhandler(client, stat, dev_mask);
+		if (status < 0) {
+			mutex_unlock(&data->update_lock);
+			return REGULATOR_FAILED_RETRY;
+		}
+
+		status = pmbus_read_status_byte(client, page);
+		if (status < 0) {
+			mutex_unlock(&data->update_lock);
+			return REGULATOR_FAILED_RETRY;
+		}
+
+		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY))
+			pmbus_clear_fault_page(client, page);
+		mutex_unlock(&data->update_lock);
+	}
+
+	return REGULATOR_ERROR_CLEARED;
+}
+
+static int pmbus_regulator_register(struct i2c_client *client, struct pmbus_data *data)
+{
+	struct device *dev = &client->dev;
 	const struct pmbus_driver_info *info = data->info;
 	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
-	struct regulator_dev *rdev;
-	int i;
+	const struct pmbus_regulator_status_category *cat;
+	const struct pmbus_regulator_status_assoc *bit;
+	int func;
+	struct regulator_dev **rdevs;
+	struct regulator_irq_desc pmbus_notif = {
+		.name = "pmbus-irq",
+		.map_event = pmbus_fault_handler,
+	};
+	void *irq_helper;
+	int i, j, err, errs;
+	u8 mask;
+
+	rdevs = devm_kzalloc(dev, sizeof(*rdevs) * info->num_regulators, GFP_KERNEL);
+	if (!rdevs)
+		return -ENOMEM;
 
 	for (i = 0; i < info->num_regulators; i++) {
 		struct regulator_config config = { };
@@ -3050,18 +3144,51 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 		if (pdata && pdata->reg_init_data)
 			config.init_data = &pdata->reg_init_data[i];
 
-		rdev = devm_regulator_register(dev, &info->reg_desc[i],
-					       &config);
-		if (IS_ERR(rdev))
-			return dev_err_probe(dev, PTR_ERR(rdev),
-					     "Failed to register %s regulator\n",
-					     info->reg_desc[i].name);
+		rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i], &config);
+		if (IS_ERR(rdevs[i])) {
+			dev_err(dev, "Failed to register %s regulator\n",
+				info->reg_desc[i].name);
+			return PTR_ERR(rdevs[i]);
+		}
+	}
+
+	if (client->irq > 0) {
+		pmbus_notif.data = rdevs;
+		errs = 0;
+		for (i = 0; i < data->info->pages; i++) {
+			func = data->info->func[i];
+
+			for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
+				cat = &pmbus_regulator_flag_map[i];
+				if (!(func & cat->func))
+					continue;
+				mask = 0;
+				for (bit = cat->bits; bit->pflag; bit++) {
+					errs |= bit->rflag;
+					mask |= bit->pflag;
+				}
+				err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
+				if (err)
+					dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",
+						cat->reg);
+			}
+
+		}
+
+		/* Register notifiers - can fail if IRQ is not given */
+		irq_helper = devm_regulator_irq_helper(dev, &pmbus_notif, client->irq, 0, errs,
+						      NULL, &rdevs[0], info->num_regulators);
+		if (IS_ERR(irq_helper)) {
+			if (PTR_ERR(irq_helper) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_warn(dev, "IRQ disabled %pe\n", irq_helper);
+		}
 	}
 
 	return 0;
 }
 #else
-static int pmbus_regulator_register(struct pmbus_data *data)
+static int pmbus_regulator_register(struct i2c_client *client, struct pmbus_data *data)
 {
 	return 0;
 }
@@ -3425,7 +3552,7 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 		return PTR_ERR(data->hwmon_dev);
 	}
 
-	ret = pmbus_regulator_register(data);
+	ret = pmbus_regulator_register(client, data);
 	if (ret)
 		return ret;
 
-- 
2.37.3

