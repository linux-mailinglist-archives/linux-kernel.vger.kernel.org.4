Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CC63F7DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLATEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiLATEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:04:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFAFC5E1B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:04:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so4328394wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAA6BwbBaAZOfPoWU8hKGND5fHQgQCgW9VzqG/UGn2Y=;
        b=Ol3TACe9AgHdDvDQsBilzT1sJ3COPVe2KK+h1R2Ej+Vl2UTtUxHMOBd/mIF/skWmBm
         jCjVH3Lu8JpC+8f8mE1EyxcYOOyd717zjESbXmetpJv1cLUHzwNch/yvpYp+kxUEj8cE
         t9L3FcG+jZP8/Kg/0F9gHi6zlAVm3SpEskUeOu5OTEhLhRes7kKtvBA95B589mXsSINd
         d7s6QDBAy0vb/lmFAOZXH2ZlELaz7vd99hfvWUZH4WITD8FJbXTOxLZhrYrttUS1EFIY
         QmFq5acqsnlXNwJggSFOSgMV9swxetihXaPVskAVU0l/QK6oLVtoEKQfp8PpgYPfmwEM
         b1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAA6BwbBaAZOfPoWU8hKGND5fHQgQCgW9VzqG/UGn2Y=;
        b=y4C0zqF3mz9pl9cseniNrLloIbk2QCyNUqIb4jz7wJwGO9vvB34IrvwMFscxe/kn/p
         zKp07CCXddlVcoTJmGqxJmCxu+/SFzpV34GnIa7ya6in864XkqmqMBawi9rPS2OKKjDo
         JHUed67qDi+n1KnBL7ho1uoBTc7KGE7CQ61LkvE3xOJl76Vg9wA8QHEdwshTrIl8pek0
         Mky10j72Qo0Cq5DhuFmfNpzyewIRf1skCUCB7SLHRbtdku++o6GEgf8EYZwNFeu79ShW
         ph+eP14iGnwlMxBUZBk3hGTWUOKdnxQMl6o5pfs8KsAISP6iTrj8lutzkv34Do4uFbJk
         gyvw==
X-Gm-Message-State: ANoB5pl/b5OmPD/xCcUscI2/55GmJ47Bor3RZm2nbskQ0Ugxtw9hRZxM
        IKTOg89fJys2sf0YdZlbFrJpAgxMZUS8TUFe
X-Google-Smtp-Source: AA0mqf6v3SLD9xcefzYnyPDuzdbf1mfSpi+X6NxOG/z9pgpBS/3kUu3eqNM3jrd6LaDVTcrWIJPS/A==
X-Received: by 2002:adf:bd90:0:b0:241:edf6:e198 with SMTP id l16-20020adfbd90000000b00241edf6e198mr26625530wrh.492.1669921463047;
        Thu, 01 Dec 2022 11:04:23 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm11848474wmq.43.2022.12.01.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:04:22 -0800 (PST)
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
Date:   Thu,  1 Dec 2022 20:03:52 +0100
Message-Id: <20221201190354.1512790-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221201190354.1512790-1-Naresh.Solanki@9elements.com>
References: <20221201190354.1512790-1-Naresh.Solanki@9elements.com>
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

