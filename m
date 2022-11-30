Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5363DB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiK3RGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiK3RFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:05:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC698941
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m19so4492500wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADo04tg+16fhlHcXEalyoHswqSIikOudDCDm6c2e17k=;
        b=NKu8S/HWybo5iLmhXLOZ4iQ/6NF9zExmhhZ1XuHdPAD/XvPsE3cuPkUcIXqhhFqoOs
         OoEcvaa3CZvsbEkiSDX7yopx8HyxBwO+ItxHGrrTl8bUJGSvt8/Db73li2ej+DNKGafy
         n5mrkCQlx23Nt4KWd8WppTeaPRO/VMy93SeqNgQp5WYIGrKwXvHm2lZoN8JLuJ74QwYV
         ZtRToEQ+QCegU3LS+1Q29y7fAY8nphbWSnatkHvqR9YCIBSM3ig37Hn2uA1RvMziG+sb
         Gp9lO+F4CoNkX+tIMhHY7XpmUawd5os3UzmsnnCHsLACgg4whAxz6KJwh5aB2j+NH3jo
         R0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADo04tg+16fhlHcXEalyoHswqSIikOudDCDm6c2e17k=;
        b=HcJfLaoYEeEK2693FMI6x4f/xDrmH6lf/AZ0/+aQvo159rinTW65lmdZCptG7wEkMc
         VRwOx2z9D9b24n3tLoPv+cDoBP5NHD5QE+09XT1daBQRqh2h+1f9f4sZq4DJC0gVmNCT
         B+7DDrttx29YhmOrh39UwGQgMu1UVi6jnwUKVDq/AEcE0+Wf5boGrorg69uVu/6ZGifM
         Wsf6tGLpZ7gw+QJjvga6g2rjYA9E6L8xedmt3BzYSwMTg2wEgsfHU+tVD0Yo5H/twzg+
         ht8tnVpkSvJp14p4vYRis2pTrBWYzKsYLF7rXuiT7BR8WYSyK7vGpLHrAdI6KPqtFgy/
         rAhw==
X-Gm-Message-State: ANoB5pmFD6kGjuatrCDo7Hdb7lO2q4nM1/fk9s4CzQ62kpGthRbYpPBS
        Iv7Q66X07YkSReppbvsUqSsllw==
X-Google-Smtp-Source: AA0mqf6dFEgTtxymKQ/eqI2nEtCILDoCpgb5WmUZJlpi5KtpxCXvj3P5gCntwYjpnOaQ2dqKxyBMDw==
X-Received: by 2002:a05:600c:1e25:b0:3d0:31c9:1d77 with SMTP id ay37-20020a05600c1e2500b003d031c91d77mr29100295wmb.113.1669827614406;
        Wed, 30 Nov 2022 09:00:14 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm2457159wmb.42.2022.11.30.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:00:14 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 4/4] hwmon: (pmbus/core): Notify hwmon events
Date:   Wed, 30 Nov 2022 17:59:54 +0100
Message-Id: <20221130165955.3479143-4-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 37 +++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 613e2e484a0f..da92a08484c9 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2805,8 +2805,36 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
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
+		}
+
+		flags &= ~smask;
+
+		if (!flags)
+			break;
+	}
+}
+
 static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
-				    unsigned int *event)
+				    unsigned int *event, bool notify)
 {
 	int i, status;
 	const struct pmbus_regulator_status_category *cat;
@@ -2833,6 +2861,9 @@ static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *e
 			return status;
 		}
 
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
+
 		for (bit = cat->bits; bit->pflag; bit++) {
 			if (status & bit->pflag) {
 				*error |= bit->rflag;
@@ -2885,7 +2916,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 {
 	unsigned int event;
 
-	return pmbus_regulator_get_flags(rdev, flags, &event);
+	return pmbus_regulator_get_flags(rdev, flags, &event, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3095,7 +3126,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		if (!data->rdevs[i])
 			continue;
 
-		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, &event);
+		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, &event, true);
 		if (ret)
 			return ret;
 
-- 
2.37.3

