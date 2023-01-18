Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693FB671B54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjARL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjARL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:59:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494465F1E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:16:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so1150545wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXTrb1mABL6hk1/BqMq0qMil187bfL2xGvlv7UgmT0Q=;
        b=hXSceJ/dNoFBoLniQES5KcDs9PBOnRePs09Q5cNcDJYOXchU9Srb7BtZ3kKQOj5LKJ
         yiRMNoXaDHvD1qeXzidVOy8iY6oqozq6pZdfdpc24RIYKYVfP7XnKiqR2QFBQG70c5Jk
         Eiy7wQvWLnYRoNVWRyAf7R3Lu0CVMN0DFlmTkZzz4TjPneYfCM/nYqrrpJWZUS4/tGSZ
         A0vmd9KNhaOqacln1S75gmPCVNhgvY6UFSAyZejBgh8tZJAk/Me4VHntSeuIkiD/rIAv
         TSzqHPo6sHNnChR7XRjnh2VNO0ypF0hDD8O9b6Fpd2SNR67XLj6XmNOOclaIZN3UMnf8
         eRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXTrb1mABL6hk1/BqMq0qMil187bfL2xGvlv7UgmT0Q=;
        b=FRV5k+T37Szgaw7Y5Ft5VhVJvNtUoECoKZv1JgP9Tw9QGbgPM+9UW+lf9Mf4zl609P
         LzCq/JJOq0gRLSP8JrIItTLj/p6u9InNA3tL2J/nxWAvRuPO1XLNNEdOSbDFmRf6/z9e
         2ar+cb68j3PdViMqrCIkKSwQFB1+H29Vfft9N7ks+iNDaqWE3kuHRvsQJZFgT9oEgAsN
         2HTm/4TWY5fWard0eExd2D6WrqFTy5DcBgAu/T4H24nCMV5X+hYupu26lg1FxZD1WVO0
         2OOE0aGlvrkby6AKJlD/zm98tgDoCTdaIBIrej6VJTSWGWtr0x5ZeCyaXvgw1MONhESj
         7wnQ==
X-Gm-Message-State: AFqh2kpfCqjGJPQOUIH+/VeXFp4SmvjM2LT+Yib4XWe7gmb9gY1HYfC1
        b3mDNY3o6Rfbg7jeCfDfnHAr0T4UHUl5FkZAYzo=
X-Google-Smtp-Source: AMrXdXs/LkjEROa0/2eNNV5b8/rnJ4ctFRVNHSplW9I5u+kBJFkH9CbKaB20dngBSdjBfjnROe9eBw==
X-Received: by 2002:a05:600c:3489:b0:3db:693:3fc9 with SMTP id a9-20020a05600c348900b003db06933fc9mr5581523wmq.27.1674040602089;
        Wed, 18 Jan 2023 03:16:42 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id ay22-20020a05600c1e1600b003dafbd859a6sm1657411wmb.43.2023.01.18.03.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:16:41 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus/core): Generalize pmbus status flag map
Date:   Wed, 18 Jan 2023 12:15:36 +0100
Message-Id: <20230118111536.3276540-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.38.1
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

Move the PMBus status flag map (pmbus_regulator_status_flag_map)
outside of the regulator #if block and update the associated
variable/struct name to reflect a generic PMBus status. Also retain
the regulator error flag for use in determining regulator specific error.

This will make the PMBus status flag map more versatile and easier to
incorporate into different contexts and functions.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 94 ++++++++++++++++----------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..1b70cf3be313 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2692,6 +2692,49 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	return 0;
 }
 
+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
+struct pmbus_status_assoc {
+	int pflag, rflag;
+};
+
+/* PMBus->regulator bit mappings for a PMBus status register */
+struct pmbus_status_category {
+	int func;
+	int reg;
+	const struct pmbus_status_assoc *bits; /* zero-terminated */
+};
+
+static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[] = {
+	{
+		.func = PMBUS_HAVE_STATUS_VOUT,
+		.reg = PMBUS_STATUS_VOUT,
+		.bits = (const struct pmbus_status_assoc[]) {
+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_IOUT,
+		.reg = PMBUS_STATUS_IOUT,
+		.bits = (const struct pmbus_status_assoc[]) {
+			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
+			{ },
+		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_TEMP,
+		.reg = PMBUS_STATUS_TEMPERATURE,
+		.bits = (const struct pmbus_status_assoc[]) {
+			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
+			{ },
+		},
+	},
+};
+
 #if IS_ENABLED(CONFIG_REGULATOR)
 static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
 {
@@ -2738,54 +2781,11 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
 	return _pmbus_regulator_on_off(rdev, 0);
 }
 
-/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
-struct pmbus_regulator_status_assoc {
-	int pflag, rflag;
-};
-
-/* PMBus->regulator bit mappings for a PMBus status register */
-struct pmbus_regulator_status_category {
-	int func;
-	int reg;
-	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
-};
-
-static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
-	{
-		.func = PMBUS_HAVE_STATUS_VOUT,
-		.reg = PMBUS_STATUS_VOUT,
-		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
-			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
-			{ },
-		},
-	}, {
-		.func = PMBUS_HAVE_STATUS_IOUT,
-		.reg = PMBUS_STATUS_IOUT,
-		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
-			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
-			{ },
-		},
-	}, {
-		.func = PMBUS_HAVE_STATUS_TEMP,
-		.reg = PMBUS_STATUS_TEMPERATURE,
-		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
-			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
-			{ },
-		},
-	},
-};
-
 static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
 {
 	int i, status;
-	const struct pmbus_regulator_status_category *cat;
-	const struct pmbus_regulator_status_assoc *bit;
+	const struct pmbus_status_category *cat;
+	const struct pmbus_status_assoc *bit;
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2796,8 +2796,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 
 	mutex_lock(&data->update_lock);
 
-	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
-		cat = &pmbus_regulator_flag_map[i];
+	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
+		cat = &pmbus_status_flag_map[i];
 		if (!(func & cat->func))
 			continue;
 

base-commit: 774dccfe77dcd8cf1d82df1f61fe95a720dc76e4
-- 
2.38.1

