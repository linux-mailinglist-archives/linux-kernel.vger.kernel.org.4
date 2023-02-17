Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4269A718
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBQIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:36:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9465ECBF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:36:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u16so337319wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY82imEcfFicloUzMXV5t4stt323TuRafcAwVY/x37M=;
        b=L0EFWAsmTPDVvIQcwiHJCxJPyIxytL4c/GZkFpD8l3FyYHZUcoEVGuKMIiut3shir4
         AQyHaFSzCekMWjr9i0vIEs2NKBeApGsuj56vsLHqxlEY4/TtlURRtcWWOqZ+w1Q/DG3Y
         tZwOcKY4pV66PSfdyD0uc8hVuScivFEN7HHy8LyRQ7+FJ5m5K9xUyTLLiCujcPi7Z7Cm
         TY1UffdUpqP7pmxr2+sCfr2JyRw1SlC/bSzEJBkfv41UH47PlglBklT6KQRELAtZ/R7D
         9kD/+bVoH02D9kphl8JPh4dWYsAwX4TUY/xSX328aEPQ6txcWZ8bBkJg5lw8gCZf9HJz
         7qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY82imEcfFicloUzMXV5t4stt323TuRafcAwVY/x37M=;
        b=1/wbes1ml4DiTnQTbRGRr8N7aQZ5pVJuXvm0Y+mKX082ugbNIX7Mh3Ad6GpieZfc/n
         jB1SS8EDKH6h20YPoTsqVAmHsX40exbqWlindd5mtV6OpmqYinSy3gR+Q2SZOgPCclqr
         IyszxOSxGzlFJ8ySwq6ROoces0Z7kKIiDkICWaAjSJmwNSlSHAHLVHT1tHhMy5aRlY2h
         Sb3VPsKvwesNrKdFMjY7oBmdMnj5b2QlvKx7mLnSzHKflCngkI09HKaZauBmX/+LbTqO
         XftpjeJNgPdP4EVoEA/ypY9jkLr99u/N69ZeH0pSyT7aHuy+GtX5D+F2mReFGL6zbcj7
         VX6w==
X-Gm-Message-State: AO0yUKVtBqzkM7km88ql8m8mdVTRWPB/Df6EOEdIIu20pEVD+v284APy
        9z4gAt8rf+nqPrRTyhq4oYZCXqb6nbw3A5X0QTs=
X-Google-Smtp-Source: AK7set+FbOSuRt29gKRaJ94HI9bbq3cnCFhAIga+tGHofviVqV6kC9S4UvDKZ+w/oFpxJ6fGCjs77Q==
X-Received: by 2002:a05:600c:a692:b0:3db:2858:db84 with SMTP id ip18-20020a05600ca69200b003db2858db84mr98499wmb.34.1676622998462;
        Fri, 17 Feb 2023 00:36:38 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003e209b45f6bsm4857021wmc.29.2023.02.17.00.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:36:38 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] hwmon: (pmbus/core): Add interrupt support
Date:   Fri, 17 Feb 2023 09:36:30 +0100
Message-Id: <20230217083631.657430-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
References: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
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

Implement PMBUS irq handler.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V3:
- Remove pmbus word check for SMBALERT writes
- Remove variable ret & use err instead.
- Use dev_dbg_once instead of error.
- Remove error print when writing to misc_status register.
- Move client irq check to pmbus_irq_setup.
---
 drivers/hwmon/pmbus/pmbus.h      |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 78 ++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

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
index f8ac9016ea0e..d0415d5ac7d9 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3105,6 +3105,80 @@ static int pmbus_regulator_register(struct pmbus_data *data)
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
+	int i, status;
+
+	mutex_lock(&data->update_lock);
+	for (i = 0; i < data->info->pages; i++) {
+		status = pmbus_read_status_word(client, i);
+		if (status < 0) {
+			mutex_unlock(&data->update_lock);
+			return status;
+		}
+
+		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
+			pmbus_clear_fault_page(client, i);
+	}
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
@@ -3467,6 +3541,10 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
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

