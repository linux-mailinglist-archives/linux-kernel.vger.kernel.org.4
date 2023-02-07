Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033A968D623
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjBGMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjBGMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:02:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9EA27986
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:02:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jg8so2925657ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaQF9jCnWRtVaZ2JOVwPRjOWGkIFNvBsCtTkzPtmBA0=;
        b=W9kdTqjauhC9tIyjCZajrkg77xiY561pQLW34day0TyHYkx0Dl8ukTUedqrsqOoRIG
         A7oKinqBQQdc2VK3VQ21GcOvh/SdNLUa4gqAIpNNYRNbZg4uiF9rMqEg6fIIiFXJF0CD
         SiP+1zmSlqeVUnLqMp90kkyUEBT+CC3NTMdM+e2DUkKXoWm9aatmq1tR/PxCIi/YRwhL
         M33gV49UVkMoOpE32smSHZX8AAjZnHhZ5uJxjZmd5LNZkNny9kimJsyW1oG8ssywEnF5
         YQjiP3vUJlnIpqfS1fN5mpABvMLeebULr2s2XAaUV+rETebCy8h0y6X2HDUxTv2a202X
         uUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaQF9jCnWRtVaZ2JOVwPRjOWGkIFNvBsCtTkzPtmBA0=;
        b=5QDEL1zlSbX8Dd0eAFBy9Q7hEfxBOnTcrmLTy3WeGS52IjDxJH3R8KGF0y75pmcXhv
         /888Jd6C6k3tDxikhWE6aXnYfUT0iBfgyOl+Vy7GFCtJQeTDVKp4osug5RY0hyyI5k9t
         v9dIkRKlzHad9LFnvh+McH77ckLZ9whIQpmaQejcJsRVNn11nAQfqIQpOyqHp4FDMXpu
         I+nH1l9iW3P9LRCwx0eg7aLR2empBopXs+cXr8cF33ojywIKZ17oPdI8Ev+cOM77vH1A
         aHNPiRGQNkHRFApUjZjlf7+dqZwh8qXeZv/m01Gsr13f25ngrvu4AEkUBedv24+glJY5
         CP/g==
X-Gm-Message-State: AO0yUKV91k+h0XTpme9CzgMVb5AnNJqMCiLQzvoxHU3wRV2BtlpX42tJ
        bPlc7mtJ9AorRzAXUz0nEbSmvA==
X-Google-Smtp-Source: AK7set+j7XYlGfj8MTraGMTPK4W6uaXYoy+CrfUmIrEDXMIHV5LfqKkCZRHKSHZncsoC6ePevDlcIA==
X-Received: by 2002:a17:907:c24:b0:878:711d:9310 with SMTP id ga36-20020a1709070c2400b00878711d9310mr4399932ejc.1.1675771375995;
        Tue, 07 Feb 2023 04:02:55 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906a20500b008710789d85fsm6843934ejy.156.2023.02.07.04.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:02:55 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] hwmon: (pmbus/core): Notify hwmon events
Date:   Tue,  7 Feb 2023 13:02:41 +0100
Message-Id: <20230207120241.2800662-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
References: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V2
- Remove __maybe_unsed attribute as its not needed.
---
 drivers/hwmon/pmbus/pmbus_core.c | 48 ++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index d5403baad60a..f6778a9c7126 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2735,8 +2735,36 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
 	},
 };
 
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
+static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
+			   bool notify)
 
-static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
 {
 	int i, status, ret;
 	const struct pmbus_status_category *cat;
@@ -2764,6 +2792,10 @@ static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsi
 			if (status & bit->pflag)
 				*flags |= bit->rflag;
 		}
+
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
+
 	}
 
 	/*
@@ -2866,7 +2898,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
-	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3108,10 +3140,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+	int i, status, ret;
 
-	mutex_lock(&data->update_lock);
 	for (i = 0; i < data->info->pages; i++) {
+		ret = pmbus_get_flags(data, i, &status, true);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->update_lock);
 		status = pmbus_read_status_word(client, i);
 		if (status < 0) {
 			mutex_unlock(&data->update_lock);
@@ -3120,8 +3156,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 
 		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
 			pmbus_clear_fault_page(client, i);
+
+		mutex_unlock(&data->update_lock);
 	}
-	mutex_unlock(&data->update_lock);
+
 
 	return IRQ_HANDLED;
 }
-- 
2.39.1

