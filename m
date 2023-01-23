Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E1677528
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjAWGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAWGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:40:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271DDBF5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:40:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o17-20020a05600c511100b003db021ef437so7737892wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjXpKA4JxoE+HGRIALy1sJ9Tu9aDnL5aCNpUki8vVSA=;
        b=PD4DhGvyQlMosWSqNvtIA94x91f/g4ZCjum1Bvtbpz5vdftz7uoYdm9wfnn10J0Cr3
         bDdqKZiPHnUv0Wr523BMCIDaiHDGV/wAFRGOoRsYNvROfZKB0MQhVtW+o9lMfLewy3ZC
         kCCv/LModEn9KXp8SeBCFjL3RXGD7vrewT1EPrsFinjzWezRw+A0ZJcDycyjsY8c25Wd
         67mDdjnAnCxzPPkrFrHLHt4jVwjUfHSavsATkEC8how8xrzWgeKb7zYos52z5L2CDcL/
         BkKkC4aci8Z7Jm/xlmf5G920phTtUj09YLKcBOrBImZuxqfPKM6nbIjocTJTgbGsjiP+
         aj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjXpKA4JxoE+HGRIALy1sJ9Tu9aDnL5aCNpUki8vVSA=;
        b=KikeXEX4wCCIxzQ8xp6SsEPKwMpIahOJie3KYZGcgDhplRuj836IX4x8+gGt2ohWRf
         zcxEZmSVnZdmnS64z4mAv21R7H+mmC8oYOoMGvtMRqr0J7fqY9tJ04KgE+SFHGQUDO9I
         9gDQ2Uas7NIElxqQPXBWuZeah8ZkS+OYbuaGMzwDHdPjDzdqIIRas+7c0BzNeVmtjX86
         4rS4QQTq29Fgf+ajevK4q5ERZVUW9vanZzkodR0GAQ0uzuMutJ42xyZmqhH8oGBiKkeB
         C4NeYX5i72gf4qWQx6ZwEbL4eFafp1fbqbAPQ4m0GRCrZ0rDlsLS1DO4m4U0+RW4sgBn
         /g4A==
X-Gm-Message-State: AFqh2kpAB3d1r+CY/346muGRqRxwEmj2qt+fg1KFuTMsCg2dU9u9cbDQ
        Db+3nUAHULtw2D6HhvYL6cjR1A==
X-Google-Smtp-Source: AMrXdXu+18/1OqjCXE9wZk08tLBTTt7yAAghn/6qG7PgZaJWKlSv89RGQ3AU0I12q5VuWtqu2LW2yg==
X-Received: by 2002:a05:600c:2206:b0:3d2:2a72:2577 with SMTP id z6-20020a05600c220600b003d22a722577mr22708887wml.27.1674456029235;
        Sun, 22 Jan 2023 22:40:29 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a1c7504000000b003da28dfdedcsm11439373wmc.5.2023.01.22.22.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:40:28 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwmon: (pmbus/core): Generalize pmbus status flag map
Date:   Mon, 23 Jan 2023 07:40:18 +0100
Message-Id: <20230123064021.2657670-1-Naresh.Solanki@9elements.com>
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

The PMBus status flag map(pmbus_regulator_status_flag_map) is moved
outside of the regulator #if block and the associated variable/struct
name updated to reflect as generic PMBus status.

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
 

base-commit: 4d891f76a30d3be4194a805c5e4277786140ef05
-- 
2.38.1

