Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C463F851
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLATbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiLATak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80024C8D3E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vv4so6627737ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0CtKLNMhWrok1R+TOMY2EUaClmC34YMD2M3K60n2nM=;
        b=F1pPgi7Uhwoarw955/oDAtxbz42b53K8lIGgjZVnemqfuG8jAOEG9F7KdRks0/ic/b
         +O4s03AAjPn2XY3Y3O5J7cr/rSoFkagood2sy+VxJL6q3mkZvsai33XWw2E22DQ6sYnr
         QL8BCkS2f3EInBlKGTL47tCTpbDWMuiSpaSZHR5DhOM4W9c4BcNiIhcD45FWYNtwLEU9
         02U1UFVZRanSGlxr57rvmGcoMCOmsNfPw9BtwJJUcoZWdrpJhq4KOKHv4vod5903v80s
         67wq2bxcM9RryATSqS2XxwZCeNUYVJCxKwqt4ZsKmO3Gxf2ubUw5d6gqLYJ2klyhMt6+
         ivhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0CtKLNMhWrok1R+TOMY2EUaClmC34YMD2M3K60n2nM=;
        b=dLKov846+DOjP6PXavLzGZKF8bs98WnebKdGD6CLg98u4NGuAk7YQUozWN52dLzliz
         ajVlI2EuPK2HxGyDsQvigLZQsOS+P8l/Zc2k8Gvkf5JhEt84Bq2u09iO7UEUF8UKp2M3
         EmHf5VYiRIskby4YEYdyLIld9mlVSAVOw/9d4FrkEbpHzFcq1Czk+dbAs6ABvHJn7x+p
         XRX7rkS8gdOWEUp955nFY7Yg+MnjnlhB+QdCbmwu5Wgn+gWUkkwLCRAplVAmazVb9XVU
         zLLLti2hgpTtAithPfVfV9r2UlJDVtVp6H+/v7i+A/yOej9q3O7mE9jPgVjB/UKBSUQR
         3yRQ==
X-Gm-Message-State: ANoB5pnu90vAjOEr/UCOkSLbQsVNKUaF/3NANZQHzM1AwxMn9g2rXqm4
        uEvcT2FJqePYIJPf59mbjBPEHwC8RJWPtv+u
X-Google-Smtp-Source: AA0mqf7IYUExaxNInjQBy/z4TNmEsmh6cN2qK7pozMPn0trUO9I6q55Rpno0fDdfnt9NImp4xQYh4g==
X-Received: by 2002:a17:906:9c89:b0:7c0:7ab4:3715 with SMTP id fj9-20020a1709069c8900b007c07ab43715mr8634863ejc.343.1669923031914;
        Thu, 01 Dec 2022 11:30:31 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7c84f000000b004619f024864sm2054110edt.81.2022.12.01.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:31 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v5 2/5] hwmon: (pmbus/core): Add interrupt support
Date:   Thu,  1 Dec 2022 20:30:21 +0100
Message-Id: <20221201193025.1584365-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
References: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
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

Implement PMBUS irq handler.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 89 ++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

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
index a95f998ca247..6a3a3fd59b8e 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3077,11 +3077,94 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 
 	return 0;
 }
+
+static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
+{
+	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
+}
+
+static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
+{
+	struct pmbus_data *data = pdata;
+	struct i2c_client *client = to_i2c_client(data->dev);
+	int i, status;
+	u8 page;
+
+	for (i = 0; i < data->info->num_regulators; i++) {
+
+		if (!data->rdevs[i])
+			continue;
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
+	return IRQ_HANDLED;
+}
+
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
+{
+	struct device *dev = &client->dev;
+	const struct pmbus_regulator_status_category *cat;
+	const struct pmbus_regulator_status_assoc *bit;
+	int i, j, err, ret, func;
+	u8 mask;
+
+	for (i = 0; i < data->info->pages; i++) {
+		func = data->info->func[i];
+
+		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
+			cat = &pmbus_regulator_flag_map[j];
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
+
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
@@ -3446,6 +3529,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
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

