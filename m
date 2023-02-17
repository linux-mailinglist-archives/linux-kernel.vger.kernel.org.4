Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734A569A713
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBQIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBQIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:36:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D55F820
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:36:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t6-20020a7bc3c6000000b003dc57ea0dfeso357332wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srqtCUqvgw2GALgaYCo2FspSe77rX/vhZEfIW9FiLT8=;
        b=byVuIPTcFkpLgDpfNkmbC59s9wYKMEOsRWzBuy/8JhVlvIlRoxmsqEN29Qos2BtzeX
         Kmzik88H77yerWniqgNJ9Q8arryN3cuieN50st3vS7M376KlpoE0pUpbj/PQ9YlsdSXk
         VS5v5eyZuXw6VquCL8BjbiuEWU/7KM1+/vNffLAiM0sFZsiHcW/3Asq3mjWKjuMhcp+V
         qGXCRUaTt9FOh3vng4E/ZVAHNIOlpoQwokqZt+1AVEkmPpuGaxsGgyPMdGucbH+c1+sk
         cZwvrmzN/aait1Zh+YpH/h/r3jNUEZVYyMivwtIJYqFnHIlDOdHFFpqaBvmdO+ihMmQA
         Q2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srqtCUqvgw2GALgaYCo2FspSe77rX/vhZEfIW9FiLT8=;
        b=0OnLkhecuSG/BUOnMQu70BwvxT/os/grXAaWVyYgyNXAWXPUAV2XFs7iMGgdBGz+cF
         +oiM4e3cpGfN/Us0uf+rSA5+VHZkO/yu1w4/I8mrpvYShM0xA1E/vWmSJnFeUlKJ6TuQ
         JR8sDxH/mlSRnPmMTA5HR3kTFzV5vFulbe6hFxNRhGm+qbcjURJYr7loGY9f+B7+nWH5
         m3gHlMZPdfBZbt0TucgP03DN693H6+OIJOHjvzNdmlQb/yI2KHjiLsUlV70+k3oRvO0e
         kq3NF6aXHjsre+RIPqEH5xCkO578KT8T0Bj9ztvA7Q28GXy9fNUJOjfwPcR3FjmE7rJq
         UfUA==
X-Gm-Message-State: AO0yUKWvRzbMVDlHPlwBE2sr2WP+Pye2amRxdXhCy2rDplyewQ8b9Tg7
        hSzwQ9RmHEf4KsEkX4I/8X8Lo5SwD+MjkMsZV3k=
X-Google-Smtp-Source: AK7set/sM0ukjrE0AxBgexM3oWL41CS99tRb7V71vQZIVVyCQR3zGMNFrjjcWJ2up0DWkTNEpMUzJg==
X-Received: by 2002:a05:600c:2ac8:b0:3df:eb5d:fbf with SMTP id t8-20020a05600c2ac800b003dfeb5d0fbfmr555659wme.38.1676622995885;
        Fri, 17 Feb 2023 00:36:35 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003e209b45f6bsm4857021wmc.29.2023.02.17.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:36:35 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] hwmon: (pmbus/core): Generalize pmbus status flag map
Date:   Fri, 17 Feb 2023 09:36:28 +0100
Message-Id: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
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
 

base-commit: 5720a18baa4686d56d0a235e6ecbcc55f8d716d7
-- 
2.39.1

