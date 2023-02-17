Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C227369A719
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBQIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBQIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:36:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F85F266
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:36:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so4305453wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Glx5PtLD/RY+BLX0OyzHnvMIcdeGlar2Jyclh1azXvQ=;
        b=N7jRqIvR91vj/CV5RzLtG2QE7kIm/aYaxgaRXcYMG59naPQ3nVlWHTW3shWZnflA6L
         /41vKHdndtIamb1fdlcp5p8OwMcwpuGpHJe/pUoVyTn8pRQgNMgnBbpZ8TR9UuWHxIKI
         q8UvQKPtAtjAVhLncmyItdMIDojar95Zw68+Skhi/wfBnekqIrzMNIIlfxfzC1d9oY+8
         lgz8YvWjCtTKBtfZJpZZQTqwqoUiyLF7lTfHU6OJZ7cvPLYgro4ADWr+n4DRuRprvzrJ
         pq0GhGdas63WHhJqJi3caPQaZvXQ7XuuouCz+hVUaIZaFH2zWhKJfEa/olNIgVdJS3Hk
         EoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Glx5PtLD/RY+BLX0OyzHnvMIcdeGlar2Jyclh1azXvQ=;
        b=1CYv6y/1XvktumrcVWC9WLx2Et2Cz7XLlMadG5zIcgZZlcvvufL0M5GRlzHKVNTGef
         OQUGVGcRHJx1ZX6uVLyHDtco6nWulW96YpxL7LikOhJfbYWaH5DK4jdE8ek5sJG70jV0
         XjQCwAF+F5Dg9HOsD4Jw3q0ReTM/lgrx/g3s5nDmIECQwyQIs8ub0O/uZukI+KboMzja
         H5DKppmUG4XFkRcl7kTHePHIKvSy7rvTsJJVxdu6Tf8Z1Ty5KIDhqQSCExWrMvfB/39g
         CKqdjyE2qSEpiXQ+mvQmfbvzLST72FAU+z5QFnsMXR9GFRVMNdCd9i0OAIc4GOCHw06o
         ejhQ==
X-Gm-Message-State: AO0yUKV5940ro6SK25qzjRIGbAX1ZyjNU6YWWCBEKtoq/K3iuaarVf+3
        PuZa0B0zZyUmntVQmHZbnkEY3w==
X-Google-Smtp-Source: AK7set/LFJ7OLSKFvvjRjmtE3GX5xZuj9GYzZL76ygl+9Jzy4IXfFXfpkN3yO3zTFYl6HxDBI9fAHA==
X-Received: by 2002:adf:fb44:0:b0:2c5:4ffa:ba62 with SMTP id c4-20020adffb44000000b002c54ffaba62mr248459wrs.17.1676622999337;
        Fri, 17 Feb 2023 00:36:39 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003e209b45f6bsm4857021wmc.29.2023.02.17.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:36:39 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] hwmon: (pmbus/core): Notify hwmon events
Date:   Fri, 17 Feb 2023 09:36:31 +0100
Message-Id: <20230217083631.657430-4-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V3:
- Remove empty line
- locked version of pmbus_get_flags
Changes in V2
- Remove __maybe_unsed attribute as its not needed.
---
 drivers/hwmon/pmbus/pmbus_core.c | 48 ++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index d0415d5ac7d9..2d10a354fe7a 100644
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
@@ -3114,10 +3147,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+	int i, status, ret;
 
 	mutex_lock(&data->update_lock);
 	for (i = 0; i < data->info->pages; i++) {
+		ret = _pmbus_get_flags(data, i, &status, true);
+		if (ret)
+			return ret;
+
 		status = pmbus_read_status_word(client, i);
 		if (status < 0) {
 			mutex_unlock(&data->update_lock);
@@ -3126,6 +3163,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 
 		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
 			pmbus_clear_fault_page(client, i);
+
 	}
 	mutex_unlock(&data->update_lock);
 
-- 
2.39.1

