Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E487A6230B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKIQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKIQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF72716E;
        Wed,  9 Nov 2022 08:53:59 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EEsmp027592;
        Wed, 9 Nov 2022 10:53:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=J51tDe4n/P70JEywu3N4H/UfOKsxpHMpiGSiyCiQ/4I=;
 b=dUnEOdFDDkZcRKd5VRb2CjaARxqLtp1Zo1haeVegqgJyjBBch47GKy4D/OsvXqstG1Dl
 Sfp3BIWo5MgpT46BmRhxVY9CEnIxAaqFLk3SlTI9kzcZtMS4zDkiOGiuOo00ChRUQ7kq
 59/ZuIJVISyKZvZ1fFo3Oy/Cn169lBf5k527Hwkc3I5dq7XB5oPnet0tnPKaC8utDjOb
 7oCcCH6p2BJrEQ9sFDd0n1l+JZkgw8zkjWHSRG7CxkhTF7eaMKqH2WAiUzifGS/vi7Jl
 DJxQ36foWjnYNhQWp9LqyUiAPlMGpaFjebocikNxI3IPrElu6fOi0X7oJZziXlvzMXVe TQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81nk99-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:37 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:35 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:35 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0205E468;
        Wed,  9 Nov 2022 16:53:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 06/12] regulator: arizona-micsupp: Don't hardcode use of ARIZONA defines
Date:   Wed, 9 Nov 2022 16:53:25 +0000
Message-ID: <20221109165331.29332-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jLRy66NxW7yMTh04myuZ0lqcWa6l1Zol
X-Proofpoint-GUID: jLRy66NxW7yMTh04myuZ0lqcWa6l1Zol
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Madera support was added to this driver the code was left
using ARIZONA_* defines. This wasn't causing any problem because
those defines just happened to have the same value as the
equivalent MADERA_* defines. But it is not ideal to assume this,
and future devices that can share this driver do not have the
same register map.

Fix the code to refer to the register data in struct regulator_desc.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/regulator/arizona-micsupp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index f6cfd3f6f0dd..21c36972a8e9 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -34,7 +34,7 @@ struct arizona_micsupp {
 	struct regulator_dev *regulator;
 	struct regmap *regmap;
 	struct snd_soc_dapm_context **dapm;
-	unsigned int enable_reg;
+	const struct regulator_desc *desc;
 	struct device *dev;
 
 	struct regulator_consumer_supply supply;
@@ -49,10 +49,11 @@ static void arizona_micsupp_check_cp(struct work_struct *work)
 		container_of(work, struct arizona_micsupp, check_cp_work);
 	struct snd_soc_dapm_context *dapm = *micsupp->dapm;
 	struct snd_soc_component *component;
+	const struct regulator_desc *desc = micsupp->desc;
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(micsupp->regmap, micsupp->enable_reg, &val);
+	ret = regmap_read(micsupp->regmap, desc->enable_reg, &val);
 	if (ret != 0) {
 		dev_err(micsupp->dev,
 			"Failed to read CP state: %d\n", ret);
@@ -62,8 +63,8 @@ static void arizona_micsupp_check_cp(struct work_struct *work)
 	if (dapm) {
 		component = snd_soc_dapm_to_component(dapm);
 
-		if ((val & (ARIZONA_CPMIC_ENA | ARIZONA_CPMIC_BYPASS)) ==
-		    ARIZONA_CPMIC_ENA)
+		if ((val & (desc->enable_mask | desc->bypass_mask)) ==
+		    desc->enable_mask)
 			snd_soc_component_force_enable_pin(component,
 							   "MICSUPP");
 		else
@@ -209,7 +210,6 @@ static const struct regulator_desc madera_micsupp = {
 	.type = REGULATOR_VOLTAGE,
 	.n_voltages = 40,
 	.ops = &arizona_micsupp_ops,
-
 	.vsel_reg = MADERA_LDO2_CONTROL_1,
 	.vsel_mask = MADERA_LDO2_VSEL_MASK,
 	.enable_reg = MADERA_MIC_CHARGE_PUMP_1,
@@ -264,7 +264,7 @@ static int arizona_micsupp_common_init(struct platform_device *pdev,
 	micsupp->init_data.consumer_supplies = &micsupp->supply;
 	micsupp->supply.supply = "MICVDD";
 	micsupp->supply.dev_name = dev_name(micsupp->dev);
-	micsupp->enable_reg = desc->enable_reg;
+	micsupp->desc = desc;
 
 	config.dev = micsupp->dev;
 	config.driver_data = micsupp;
@@ -285,8 +285,7 @@ static int arizona_micsupp_common_init(struct platform_device *pdev,
 		config.init_data = &micsupp->init_data;
 
 	/* Default to regulated mode */
-	regmap_update_bits(micsupp->regmap, micsupp->enable_reg,
-			   ARIZONA_CPMIC_BYPASS, 0);
+	regmap_update_bits(micsupp->regmap, desc->enable_reg, desc->bypass_mask, 0);
 
 	micsupp->regulator = devm_regulator_register(&pdev->dev,
 						     desc,
-- 
2.30.2

