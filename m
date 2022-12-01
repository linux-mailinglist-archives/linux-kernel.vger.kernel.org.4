Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A56A63F83D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiLATaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiLAT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:29:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD67C82E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:29:47 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id td2so6621142ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAA6BwbBaAZOfPoWU8hKGND5fHQgQCgW9VzqG/UGn2Y=;
        b=ZkxLBb407lw5roeqTrwRGvPCKsojHFoAe3OqINsHXW5+ST/OpPG97AWzOZW+sQJxJj
         TS5Qg4pvd4vm2gMDg4GeXMw9v1MewYMZZ87YLWahxSMKVvqCOtZO5YdhDHf4ZunJ5xb5
         c2OV0kCElDSbMMHs2vXXd523aLXlGtEH4/t1M/cng2cEN3eTyDk3547XVaQyrTBrGvHD
         wr+UdDN60A5WIyC7TcJ6JB0sjfNqhqFdjdrB4PczTy1r7GEn6g53wv25hIpk8j59Yx9O
         zcLnnPbPG4qUp9ajDvWQMVIF7Eun2IjvlTkYG3l6y53sSINCIDRTwT7URk2aXAVKH36D
         DkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAA6BwbBaAZOfPoWU8hKGND5fHQgQCgW9VzqG/UGn2Y=;
        b=8OltM9qxMuQUBNeew63yhruV2+UNPPk/2SR67Bsp8mzmQjipBFzN7F6hMEDr6BfPhJ
         4DZX7KSBoV3SJGjhl/2q3Qq9FkVKI5wybWyyF/KOka5F5t8SbBkdiOkl1RMgwD4+RrJF
         v8sNeG0oi5Gkb+/X81CQaeFdHwkObfAXrZTyBPXZ53XnMZiPpRT92KqDcNf/D3Y/t0R/
         dhNKQqG3bHcD3Gy2z+bikg0d//rfJPBzR0RmwWl4gzkiKxVxZurRmRoNAhtggDzuKrxX
         LFDF0Y9m+dmqPyNOx/FlzldoWNp9PMuHafBOVK7/l4SL0zcLVAJA2A62Sqy1YySdtwtF
         pOfQ==
X-Gm-Message-State: ANoB5pkQ/Kx+4Ti9elrJbaCyg+CK6u85IyxT7067yHvO//TGgeDCJtmz
        TYLVz5ilOg0cVdZvNo5xMUYWgfu7FTxGPwhK
X-Google-Smtp-Source: AA0mqf4KaQ/PZhqP2NZNstCWqrU2vspheNrEaD/1GAbdYX5+A2TcBGQf6jzE7m09NtYT4W3CNB9ccg==
X-Received: by 2002:a17:906:597:b0:7a8:fd1a:c073 with SMTP id 23-20020a170906059700b007a8fd1ac073mr49267924ejn.4.1669922985727;
        Thu, 01 Dec 2022 11:29:45 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090639cd00b0073022b796a7sm2141380eje.93.2022.12.01.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:29:45 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 3/5] hwmon: (pmbus/core): Notify hwmon events
Date:   Thu,  1 Dec 2022 20:29:37 +0100
Message-Id: <20221201192940.1584012-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221201192940.1584012-1-Naresh.Solanki@9elements.com>
References: <20221201192940.1584012-1-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 46 +++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index bdcbc216b0cc..78c401412c4d 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2782,7 +2782,35 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 	},
 };
 
-static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+#define to_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct device_attribute, attr)
+
+static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
+{
+	int i;
+
+	for (i = 0; i < data->num_attributes; i++) {
+		struct device_attribute *da = to_dev_attr(data->group.attrs[i]);
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+		int index = attr->index;
+		u16 smask = pb_index_to_mask(index);
+		u8 spage = pb_index_to_page(index);
+		u16 sreg = pb_index_to_reg(index);
+
+		if (reg == sreg && page == spage && (smask & flags)) {
+			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
+			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
+			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
+			flags &= ~smask;
+		}
+
+		if (!flags)
+			break;
+	}
+}
+
+static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
+				    bool notify)
 {
 	int i, status;
 	const struct pmbus_regulator_status_category *cat;
@@ -2812,6 +2840,9 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 			if (status & bit->pflag)
 				*flags |= bit->rflag;
 		}
+
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
 	}
 
 	/*
@@ -2856,6 +2887,11 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	return 0;
 }
 
+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	return pmbus_regulator_get_flags(rdev, flags, false);
+}
+
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
 {
 	struct device *dev = rdev_get_dev(rdev);
@@ -3088,7 +3124,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+	int i, ret = IRQ_NONE, status;
 	u8 page;
 
 	for (i = 0; i < data->info->num_regulators; i++) {
@@ -3096,6 +3132,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		if (!data->rdevs[i])
 			continue;
 
+		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, true);
+		if (ret)
+			return ret;
+
 		page = rdev_get_id(data->rdevs[i]);
 		mutex_lock(&data->update_lock);
 		status = pmbus_read_status_word(client, page);
@@ -3110,7 +3150,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		mutex_unlock(&data->update_lock);
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
-- 
2.37.3

