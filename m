Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8B6A717A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCAQpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCAQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:44:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1004E34038
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:44:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j3so9010478wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1677689095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVVDY8ic1qw0PVkNeQsrCkRxHgDpu5ucByCSMwYa9Ps=;
        b=IuDP27vbGYs3T4iGMRPV/UvoR9HIzQVOlvo0t2jJ75WRdav5sHFWfqDo8mt4YIvlYx
         Z3FONtKWwpPuHHUxRFsRu3hT2t+TnsdKwmPQwqKcS8dkvLD2f1JBFdy25vgOkd8RpfPk
         d8LMj+8gJapLAp2TTkrRyI1N+LycFDczKvEq1bJIZK89lhbdPIFxDdJk3Lbh9Wgm4gR8
         acm5ChbCFe2UvT2F6FJBWivN4oEJIGrw0cBqDiazZx3BzAfJiNXirmMUcaCkzGvp/8Ib
         CfbqkfiUgx6FxzjqWBOvzcpNZ0FZk7u/LefqcMO3iXMPZ6/zs3Y+IBut1utfcK/HHcQ7
         jCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677689095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVVDY8ic1qw0PVkNeQsrCkRxHgDpu5ucByCSMwYa9Ps=;
        b=qpJRJbtwv24vhi24YwlAOBdQTGPIdvmmxjI3BAxgPlCTV+boy7hxMG7yM44Ru2TxVj
         WrvE4qNHioGca3N6+sqx+1NzzfUxemJetZLs9j3bvrs5c/hoB48Gcv2GXsnNRVh50qzU
         4Vi7k1CfwvYMTObBOdIdWBS9L9xjwQjlUx5qnihlity9UIcrHg09SjnFyVN3vhPs0R8/
         qNO4LXgeidCmtqoWpRm2dCd8SfHUI7QmwNIpvX+0XY3xtqtZHTTsyDX7rsO0IWoCO6o7
         4AAWAqselYT9sLLvS+Gm1bLSdyVjufl7V3R3elvvYPsMGGykedCaD7zIMRRRDVcihN8s
         L+1A==
X-Gm-Message-State: AO0yUKVWGZkaa9QzuDdzz4nGDDNOdciVsSatE6BvrpvYT3AVCIy5SF+M
        /6TKmPi+d0lzRHeP1DT2jrpo+w==
X-Google-Smtp-Source: AK7set+XSc/AxQVmgmYK+IYFnOdLK1+ddo53AwtKZqsoGF+O2NwUBhLz+HSungGdFlkmbF7B+C7APA==
X-Received: by 2002:a05:600c:5119:b0:3e2:1a01:3a7c with SMTP id o25-20020a05600c511900b003e21a013a7cmr11625048wms.6.1677689095409;
        Wed, 01 Mar 2023 08:44:55 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcde8000000b003dc521f336esm105542wmj.14.2023.03.01.08.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 08:44:55 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] hwmon: (pmbus/core): Add interrupt support
Date:   Wed,  1 Mar 2023 17:44:33 +0100
Message-Id: <20230301164434.1928237-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
References: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
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
...
Changes in V4:
- Clear fault using pmbus_clear_faults at end of interrupt handler.
- Remove for loop.
Changes in V3:
- Remove pmbus word check for SMBALERT writes
- Remove variable ret & use err instead.
- Use dev_dbg_once instead of error.
- Remove error print when writing to misc_status register.
- Move client irq check to pmbus_irq_setup.
---
 drivers/hwmon/pmbus/pmbus.h      |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 70 ++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 713ea7915425..11e84e141126 100644
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
index f8ac9016ea0e..dfd227459d8b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3105,6 +3105,72 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 }
 #endif
 
+static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
+{
+	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
+}
+
+static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
+{
+	struct pmbus_data *data = pdata;
+	struct i2c_client *client = to_i2c_client(data->dev);
+
+	mutex_lock(&data->update_lock);
+	/* TODO: Check status flag & notify hwmon events */
+
+	pmbus_clear_faults(client);
+	mutex_unlock(&data->update_lock);
+
+	return IRQ_HANDLED;
+}
+
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
+{
+	struct device *dev = &client->dev;
+	const struct pmbus_status_category *cat;
+	const struct pmbus_status_assoc *bit;
+	int i, j, err, func;
+	u8 mask;
+
+	static const u8 misc_status[] = {PMBUS_STATUS_CML, PMBUS_STATUS_OTHER,
+					 PMBUS_STATUS_MFR_SPECIFIC, PMBUS_STATUS_FAN_12,
+					 PMBUS_STATUS_FAN_34};
+
+	if (!client->irq)
+		return 0;
+
+	for (i = 0; i < data->info->pages; i++) {
+		func = data->info->func[i];
+
+		for (j = 0; j < ARRAY_SIZE(pmbus_status_flag_map); j++) {
+			cat = &pmbus_status_flag_map[j];
+			if (!(func & cat->func))
+				continue;
+			mask = 0;
+			for (bit = cat->bits; bit->pflag; bit++)
+				mask |= bit->pflag;
+
+			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
+			if (err)
+				dev_dbg_once(dev, "Failed to set smbalert for reg 0x%02x\n",
+					     cat->reg);
+		}
+
+		for (j = 0; j < ARRAY_SIZE(misc_status); j++)
+			pmbus_write_smbalert_mask(client, i, misc_status[j], 0xff);
+	}
+
+	/* Register notifiers */
+	err = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler, 0,
+					"pmbus-irq", data);
+	if (err) {
+		dev_err(dev, "failed to request an irq %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -3467,6 +3533,10 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 	if (ret)
 		return ret;
 
+	ret = pmbus_irq_setup(client, data);
+	if (ret)
+		return ret;
+
 	ret = pmbus_init_debugfs(client, data);
 	if (ret)
 		dev_warn(dev, "Failed to register debugfs\n");
-- 
2.39.1

