Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033F6742865
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjF2Oab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjF2OaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:30:18 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03BA92D7F;
        Thu, 29 Jun 2023 07:30:13 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(12333:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 29 Jun 2023 22:29:57 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 29 Jun
 2023 22:29:57 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 29 Jun 2023 22:29:57 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] regulator: rt5739: Add DID check and compatible for rt5733
Date:   Thu, 29 Jun 2023 22:29:56 +0800
Message-ID: <1688048996-25606-3-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688048996-25606-1-git-send-email-cy_huang@richtek.com>
References: <1688048996-25606-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add compatible and use DID to check rt5733.

The only difference bwtween rt5733 and rt5739 is the output range and
voltage step. These two chips can be distinguished from the DIE id.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
v2:
- Remove DID check in 'set_suspend_voltage' callback, use desc member to
  check min/max and vsel calculation
- Use switch case to check DID for the future variation
---
 drivers/regulator/rt5739.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/rt5739.c b/drivers/regulator/rt5739.c
index 74fc5bf6d87e..ca5f9b05331c 100644
--- a/drivers/regulator/rt5739.c
+++ b/drivers/regulator/rt5739.c
@@ -31,10 +31,17 @@
 #define RT5739_MODEVSEL1_MASK	BIT(1)
 #define RT5739_MODEVSEL0_MASK	BIT(0)
 #define RT5739_VID_MASK		GENMASK(7, 5)
+#define RT5739_DID_MASK		GENMASK(3, 0)
 #define RT5739_ACTD_MASK	BIT(7)
 #define RT5739_ENVSEL1_MASK	BIT(1)
 #define RT5739_ENVSEL0_MASK	BIT(0)
 
+#define RT5733_CHIPDIE_ID	0x1
+#define RT5733_VOLT_MINUV	270000
+#define RT5733_VOLT_MAXUV	1401250
+#define RT5733_VOLT_STPUV	6250
+#define RT5733_N_VOLTS		182
+
 #define RT5739_VOLT_MINUV	300000
 #define RT5739_VOLT_MAXUV	1300000
 #define RT5739_VOLT_STPUV	5000
@@ -93,8 +100,11 @@ static int rt5739_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	const struct regulator_desc *desc = rdev->desc;
 	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int reg, vsel;
+	int max_uV;
+
+	max_uV = desc->min_uV + desc->uV_step * (desc->n_voltages - 1);
 
-	if (uV < RT5739_VOLT_MINUV || uV > RT5739_VOLT_MAXUV)
+	if (uV < desc->min_uV || uV > max_uV)
 		return -EINVAL;
 
 	if (desc->vsel_reg == RT5739_REG_NSEL0)
@@ -102,7 +112,7 @@ static int rt5739_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	else
 		reg = RT5739_REG_NSEL0;
 
-	vsel = (uV - RT5739_VOLT_MINUV) / RT5739_VOLT_STPUV;
+	vsel = (uV - desc->min_uV) / desc->uV_step;
 	return regmap_write(regmap, reg, vsel);
 }
 
@@ -189,15 +199,12 @@ static unsigned int rt5739_of_map_mode(unsigned int mode)
 }
 
 static void rt5739_init_regulator_desc(struct regulator_desc *desc,
-				       bool vsel_active_high)
+				       bool vsel_active_high, u8 did)
 {
 	/* Fixed */
 	desc->name = "rt5739-regulator";
 	desc->owner = THIS_MODULE;
 	desc->ops = &rt5739_regulator_ops;
-	desc->n_voltages = RT5739_N_VOLTS;
-	desc->min_uV = RT5739_VOLT_MINUV;
-	desc->uV_step = RT5739_VOLT_STPUV;
 	desc->vsel_mask = RT5739_VSEL_MASK;
 	desc->enable_reg = RT5739_REG_CNTL2;
 	desc->active_discharge_reg = RT5739_REG_CNTL1;
@@ -213,6 +220,20 @@ static void rt5739_init_regulator_desc(struct regulator_desc *desc,
 		desc->vsel_reg = RT5739_REG_NSEL0;
 		desc->enable_mask = RT5739_ENVSEL0_MASK;
 	}
+
+	/* Assigned by CHIPDIE ID */
+	switch (did) {
+	case RT5733_CHIPDIE_ID:
+		desc->n_voltages = RT5733_N_VOLTS;
+		desc->min_uV = RT5733_VOLT_MINUV;
+		desc->uV_step = RT5733_VOLT_STPUV;
+		break;
+	default:
+		desc->n_voltages = RT5739_N_VOLTS;
+		desc->min_uV = RT5739_VOLT_MINUV;
+		desc->uV_step = RT5739_VOLT_STPUV;
+		break;
+	}
 }
 
 static const struct regmap_config rt5739_regmap_config = {
@@ -258,7 +279,7 @@ static int rt5739_probe(struct i2c_client *i2c)
 
 	vsel_acth = device_property_read_bool(dev, "richtek,vsel-active-high");
 
-	rt5739_init_regulator_desc(desc, vsel_acth);
+	rt5739_init_regulator_desc(desc, vsel_acth, vid & RT5739_DID_MASK);
 
 	cfg.dev = dev;
 	cfg.of_node = dev_of_node(dev);
@@ -271,6 +292,7 @@ static int rt5739_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id rt5739_device_table[] = {
+	{ .compatible = "richtek,rt5733" },
 	{ .compatible = "richtek,rt5739" },
 	{ /* sentinel */ }
 };
-- 
2.40.1

