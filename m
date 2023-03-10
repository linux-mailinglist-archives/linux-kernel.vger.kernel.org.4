Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75656B4983
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjCJPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjCJPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:12:52 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A41A130C13;
        Fri, 10 Mar 2023 07:04:27 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17683b570b8so6052247fac.13;
        Fri, 10 Mar 2023 07:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjrRtodmGZs9wYnSAx5JYX+404dFYNMJg/rR6vtjjPI=;
        b=oorv31+HEfcQzVuV/F6GdgjxFrkqAoN09Mr6zAfvmH9CYpM62Ky7C8d3MBnSgiueYQ
         rY3s2BEHab+0a1Zf82uj2m+3+e6zRhSyT4f9Lo/hVPykHTdsukA9RbpkkWQfjleK14l5
         e8cm1QMiEK1YEsK8oBHNQ3HMp92epO1C+RoN83dtQAtoheh7hZO8hzK6ZTRIK9KT4MfW
         U75EwXRbs5AF+1eeV78DUnFNKVCZVoKUwEyr0NzPo0KxKOgnuRXCDseLnKS7LrweudbR
         IsTAYwsrPezuYIuccINCcPFbLGPe/8UlLKGJMF/wAD3xNDwVAuWCcPzRHEHNO9Vyho00
         xjbA==
X-Gm-Message-State: AO0yUKVpkj9U1z+Ifehk7NLJv+zWv8sX3OT8CWTBvXv4zFH6c7pWxAnT
        Y89QEzVqcJTUAIRWW2OiR3qOnxlmIg==
X-Google-Smtp-Source: AK7set8+hYLShJp2TCqy6+bhl0FDcPoTQMjrS0wMK+P2PitkJQQBIHputg3z3jCkvFWaqnOYsxInyA==
X-Received: by 2002:a05:6808:b2a:b0:360:cb13:e78a with SMTP id t10-20020a0568080b2a00b00360cb13e78amr11490617oij.58.1678459725794;
        Fri, 10 Mar 2023 06:48:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020acada02000000b00383ef567cfdsm964720oig.21.2023.03.10.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:45 -0800 (PST)
Received: (nullmailer pid 1544870 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] regulator: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:22 -0600
Message-Id: <20230310144722.1544843-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/lp872x.c             |  3 +--
 drivers/regulator/max8997-regulator.c  | 11 +++--------
 drivers/regulator/max8998.c            |  3 +--
 drivers/regulator/s5m8767.c            | 17 ++++++-----------
 drivers/regulator/stpmic1_regulator.c  |  2 +-
 drivers/regulator/tps62360-regulator.c | 15 ++++-----------
 drivers/regulator/twl6030-regulator.c  |  2 +-
 7 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index c576894c3d52..b5d83a63991b 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -832,8 +832,7 @@ static struct lp872x_platform_data
 		return ERR_PTR(-ENOMEM);
 
 	of_property_read_u8(np, "ti,general-config", &pdata->general_config);
-	if (of_find_property(np, "ti,update-config", NULL))
-		pdata->update_config = true;
+	pdata->update_config = of_property_read_bool(np, "ti,update-config");
 
 	pdata->dvs = devm_kzalloc(dev, sizeof(struct lp872x_dvs), GFP_KERNEL);
 	if (!pdata->dvs)
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index ba47a5e2fbcb..829c3d9542af 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -943,14 +943,9 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 	}
 	of_node_put(regulators_np);
 
-	if (of_get_property(pmic_np, "max8997,pmic-buck1-uses-gpio-dvs", NULL))
-		pdata->buck1_gpiodvs = true;
-
-	if (of_get_property(pmic_np, "max8997,pmic-buck2-uses-gpio-dvs", NULL))
-		pdata->buck2_gpiodvs = true;
-
-	if (of_get_property(pmic_np, "max8997,pmic-buck5-uses-gpio-dvs", NULL))
-		pdata->buck5_gpiodvs = true;
+	pdata->buck1_gpiodvs = of_property_read_bool(pmic_np, "max8997,pmic-buck1-uses-gpio-dvs");
+	pdata->buck2_gpiodvs = of_property_read_bool(pmic_np, "max8997,pmic-buck2-uses-gpio-dvs");
+	pdata->buck5_gpiodvs = of_property_read_bool(pmic_np, "max8997,pmic-buck5-uses-gpio-dvs");
 
 	if (pdata->buck1_gpiodvs || pdata->buck2_gpiodvs ||
 						pdata->buck5_gpiodvs) {
diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index ac69bdd398cb..7f254066237d 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -618,8 +618,7 @@ static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
 	if (ret)
 		return -EINVAL;
 
-	if (of_find_property(pmic_np, "max8998,pmic-buck-voltage-lock", NULL))
-		pdata->buck_voltage_lock = true;
+	pdata->buck_voltage_lock = of_property_read_bool(pmic_np, "max8998,pmic-buck-voltage-lock");
 
 	ret = of_property_read_u32(pmic_np,
 					"max8998,pmic-buck1-default-dvs-idx",
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 754c6fcc6e64..3122ca7de8f5 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -605,7 +605,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 
 	of_node_put(regulators_np);
 
-	if (of_get_property(pmic_np, "s5m8767,pmic-buck2-uses-gpio-dvs", NULL)) {
+	if (of_property_read_bool(pmic_np, "s5m8767,pmic-buck2-uses-gpio-dvs")) {
 		pdata->buck2_gpiodvs = true;
 
 		if (of_property_read_u32_array(pmic_np,
@@ -616,7 +616,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 		}
 	}
 
-	if (of_get_property(pmic_np, "s5m8767,pmic-buck3-uses-gpio-dvs", NULL)) {
+	if (of_property_read_bool(pmic_np, "s5m8767,pmic-buck3-uses-gpio-dvs")) {
 		pdata->buck3_gpiodvs = true;
 
 		if (of_property_read_u32_array(pmic_np,
@@ -627,7 +627,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 		}
 	}
 
-	if (of_get_property(pmic_np, "s5m8767,pmic-buck4-uses-gpio-dvs", NULL)) {
+	if (of_property_read_bool(pmic_np, "s5m8767,pmic-buck4-uses-gpio-dvs")) {
 		pdata->buck4_gpiodvs = true;
 
 		if (of_property_read_u32_array(pmic_np,
@@ -661,14 +661,9 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	if (ret)
 		return -EINVAL;
 
-	if (of_get_property(pmic_np, "s5m8767,pmic-buck2-ramp-enable", NULL))
-		pdata->buck2_ramp_enable = true;
-
-	if (of_get_property(pmic_np, "s5m8767,pmic-buck3-ramp-enable", NULL))
-		pdata->buck3_ramp_enable = true;
-
-	if (of_get_property(pmic_np, "s5m8767,pmic-buck4-ramp-enable", NULL))
-		pdata->buck4_ramp_enable = true;
+	pdata->buck2_ramp_enable = of_property_read_bool(pmic_np, "s5m8767,pmic-buck2-ramp-enable");
+	pdata->buck3_ramp_enable = of_property_read_bool(pmic_np, "s5m8767,pmic-buck3-ramp-enable");
+	pdata->buck4_ramp_enable = of_property_read_bool(pmic_np, "s5m8767,pmic-buck4-ramp-enable");
 
 	if (pdata->buck2_ramp_enable || pdata->buck3_ramp_enable
 			|| pdata->buck4_ramp_enable) {
diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 2d7597c76e4a..d04759b56a95 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -576,7 +576,7 @@ static int stpmic1_regulator_register(struct platform_device *pdev, int id,
 	}
 
 	/* set mask reset */
-	if (of_get_property(config.of_node, "st,mask-reset", NULL) &&
+	if (of_property_read_bool(config.of_node, "st,mask-reset") &&
 	    cfg->mask_reset_reg != 0) {
 		ret = regmap_update_bits(pmic_dev->regmap,
 					 cfg->mask_reset_reg,
diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index da1b2b1341ae..a7019e869f50 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -296,17 +296,10 @@ static struct tps62360_regulator_platform_data *
 		return NULL;
 	}
 
-	if (of_find_property(np, "ti,vsel0-state-high", NULL))
-		pdata->vsel0_def_state = 1;
-
-	if (of_find_property(np, "ti,vsel1-state-high", NULL))
-		pdata->vsel1_def_state = 1;
-
-	if (of_find_property(np, "ti,enable-pull-down", NULL))
-		pdata->en_internal_pulldn = true;
-
-	if (of_find_property(np, "ti,enable-vout-discharge", NULL))
-		pdata->en_discharge = true;
+	pdata->vsel0_def_state = of_property_read_bool(np, "ti,vsel0-state-high");
+	pdata->vsel1_def_state = of_property_read_bool(np, "ti,vsel1-state-high");
+	pdata->en_internal_pulldn = of_property_read_bool(np, "ti,enable-pull-down");
+	pdata->en_discharge = of_property_read_bool(np, "ti,enable-vout-discharge");
 
 	return pdata;
 }
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index f3856750944f..d94e61aa1b84 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -729,7 +729,7 @@ static int twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (of_get_property(np, "ti,retain-on-reset", NULL))
+	if (of_property_read_bool(np, "ti,retain-on-reset"))
 		info->flags |= TWL_6030_WARM_RESET;
 
 	config.dev = &pdev->dev;
-- 
2.39.2

