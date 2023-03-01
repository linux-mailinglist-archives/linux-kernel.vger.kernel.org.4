Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B716A7179
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCAQpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCAQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:44:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1E3608E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:44:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so7745552wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1677689096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLcZN2988ihhBNvPwnv1tBtUBTQj9QBFY2uBIRKI9Sg=;
        b=aNAVQgIv3Vy00lGPfD4qRq2kKY9XtZyvMcazWF5GKeKI1CnUYiWnu53gwOq07GP+5w
         iEf3QrP//BhNzkSKDKoQXvqPxpGvzICY6EdI6XGMdIgcORWKWQYDoBkzd0UEkOTdEXUa
         cJJ8gvrgwVLej13B8Z1VCGeZoYa5EVxi18E49hdzT8EqJbuptYLq7C75dF57DVqnFxQH
         HmoMmX15r+bFRAwV6JNeRPR7on57YLIf6CyYl7vdV7p0VlXw95AWH9604XlxTwlQKZyb
         j33NQDi8S5Hh7CUZkkpdsrvj35L5dX8aX9MEmGR4RHU5xkSKmAGxDlF4Ti3ACCABwX4o
         RjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677689096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLcZN2988ihhBNvPwnv1tBtUBTQj9QBFY2uBIRKI9Sg=;
        b=snDw2BNfEa3wtq6fbh9vq5JBf3GsTt9eJzViV0oOQcpPougENHy5UP+KsYzseqUCor
         yUACcNT3iNqNxP0ujgHLYT5Kkq2Hl+rBSlNDotWDmNiUcN5YNLqRidNQiUV7H4cjg2aY
         zZjA9MTR0AtdCnLcFE8UpVfEx9Uh5apEHau97l9NzOcCbiEmsc1zayEUPO3FGJOPkbrB
         +MVg7pkM6Qb+6QdRJotkO0z4tpJbCZTjtYFhORCVW6NKYi87+4ksrWsU2IbiLxuh35v6
         YPQEBO9A/WceYKxfaOpXXKinRsKwKMxV8ZLCKgjrHpbv4gAoQS/d9wrLl2uORquBBhax
         GLLQ==
X-Gm-Message-State: AO0yUKWrA4mtv8acOMFTCAz28I69WVYDmLmRf2hzmu4H9avHiJ3BkJm5
        lX4FKYwoinZ9Fsg+xYTeO9ygYw==
X-Google-Smtp-Source: AK7set/QZ1Z8Yx7b0VTjJtuU0kqrqwy9mCFJ7gjVLxo5ZtqOtPxuqt/h5V0PRdss1adPjwLhNowUIQ==
X-Received: by 2002:a05:600c:4d26:b0:3eb:2de8:b743 with SMTP id u38-20020a05600c4d2600b003eb2de8b743mr6083621wmp.12.1677689096340;
        Wed, 01 Mar 2023 08:44:56 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcde8000000b003dc521f336esm105542wmj.14.2023.03.01.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 08:44:56 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] hwmon: (pmbus/core): Notify hwmon events
Date:   Wed,  1 Mar 2023 17:44:34 +0100
Message-Id: <20230301164434.1928237-4-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V4:
- Ignore return error in irq handle & instead continue loop.
Changes in V3:
- Remove empty line
- locked version of pmbus_get_flags
Changes in V2
- Remove __maybe_unsed attribute as its not needed.
---
 drivers/hwmon/pmbus/pmbus_core.c | 46 +++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index dfd227459d8b..0ddef2c9ba9b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2761,7 +2761,35 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
 	return !!(ret & PB_OPERATION_CONTROL_ON);
 }
 
-static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
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
+static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
+			    bool notify)
 {
 	int i, status;
 	const struct pmbus_status_category *cat;
@@ -2785,6 +2813,10 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 			if (status & bit->pflag)
 				*flags |= bit->rflag;
 		}
+
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
+
 	}
 
 	/*
@@ -2828,12 +2860,13 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 	return 0;
 }
 
-static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
+static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
+					  bool notify)
 {
 	int ret;
 
 	mutex_lock(&data->update_lock);
-	ret = _pmbus_get_flags(data, page, flags);
+	ret = _pmbus_get_flags(data, page, flags, notify);
 	mutex_unlock(&data->update_lock);
 
 	return ret;
@@ -2878,7 +2911,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
 
-	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3114,9 +3147,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-
+	int i, status;
 	mutex_lock(&data->update_lock);
-	/* TODO: Check status flag & notify hwmon events */
+	for (i = 0; i < data->info->pages; i++)
+		_pmbus_get_flags(data, i, &status, true);
 
 	pmbus_clear_faults(client);
 	mutex_unlock(&data->update_lock);
-- 
2.39.1

