Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B3740C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjF1JBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:01:14 -0400
Received: from mg.richtek.com ([220.130.44.152]:44348 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236441AbjF1Iri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:47:38 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(12336:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 28 Jun 2023 16:47:19 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 28 Jun
 2023 16:47:18 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 28 Jun 2023 16:47:18 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] regulator: rt5739: Add DID check and compatible for rt5733
Date:   Wed, 28 Jun 2023 16:47:17 +0800
Message-ID: <1687942037-14652-3-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add compatible and use DID to check rt5733.

The only difference bwtween rt5733 and rt5739 is the output range and
voltage step. These two chips can be distinguished from the DIE id.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rt5739.c | 49 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/rt5739.c b/drivers/regulator/rt5739.c
index 74fc5bf6d87e..c930ea27e51f 100644
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
@@ -92,9 +99,26 @@ static int rt5739_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
 	const struct regulator_desc *desc = rdev->desc;
 	struct regmap *regmap = rdev_get_regmap(rdev);
-	unsigned int reg, vsel;
+	unsigned int did, reg, vsel;
+	int min_uV, max_uV, step_uV, ret;
+
+	ret = regmap_read(regmap, RT5739_REG_ID1, &did);
+	if (ret)
+		return ret;
+
+	did &= RT5739_DID_MASK;
+
+	if (did == RT5733_CHIPDIE_ID) {
+		min_uV = RT5733_VOLT_MINUV;
+		max_uV = RT5733_VOLT_MAXUV;
+		step_uV = RT5733_VOLT_STPUV;
+	} else {
+		min_uV = RT5739_VOLT_MINUV;
+		max_uV = RT5739_VOLT_MAXUV;
+		step_uV = RT5739_VOLT_STPUV;
+	}
 
-	if (uV < RT5739_VOLT_MINUV || uV > RT5739_VOLT_MAXUV)
+	if (uV < min_uV || uV > max_uV)
 		return -EINVAL;
 
 	if (desc->vsel_reg == RT5739_REG_NSEL0)
@@ -102,7 +126,7 @@ static int rt5739_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	else
 		reg = RT5739_REG_NSEL0;
 
-	vsel = (uV - RT5739_VOLT_MINUV) / RT5739_VOLT_STPUV;
+	vsel = (uV - min_uV) / step_uV;
 	return regmap_write(regmap, reg, vsel);
 }
 
@@ -189,15 +213,12 @@ static unsigned int rt5739_of_map_mode(unsigned int mode)
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
@@ -213,6 +234,17 @@ static void rt5739_init_regulator_desc(struct regulator_desc *desc,
 		desc->vsel_reg = RT5739_REG_NSEL0;
 		desc->enable_mask = RT5739_ENVSEL0_MASK;
 	}
+
+	/* Assigned by CHIPDIE ID */
+	if (did == RT5733_CHIPDIE_ID) {
+		desc->n_voltages = RT5733_N_VOLTS;
+		desc->min_uV = RT5733_VOLT_MINUV;
+		desc->uV_step = RT5733_VOLT_STPUV;
+	} else {
+		desc->n_voltages = RT5739_N_VOLTS;
+		desc->min_uV = RT5739_VOLT_MINUV;
+		desc->uV_step = RT5739_VOLT_STPUV;
+	}
 }
 
 static const struct regmap_config rt5739_regmap_config = {
@@ -258,7 +290,7 @@ static int rt5739_probe(struct i2c_client *i2c)
 
 	vsel_acth = device_property_read_bool(dev, "richtek,vsel-active-high");
 
-	rt5739_init_regulator_desc(desc, vsel_acth);
+	rt5739_init_regulator_desc(desc, vsel_acth, vid & RT5739_DID_MASK);
 
 	cfg.dev = dev;
 	cfg.of_node = dev_of_node(dev);
@@ -271,6 +303,7 @@ static int rt5739_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id rt5739_device_table[] = {
+	{ .compatible = "richtek,rt5733" },
 	{ .compatible = "richtek,rt5739" },
 	{ /* sentinel */ }
 };
-- 
2.40.1

