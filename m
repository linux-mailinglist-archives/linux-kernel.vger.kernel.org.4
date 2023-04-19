Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391036E71DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjDSDtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 23:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDSDsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:48:47 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D4558D;
        Tue, 18 Apr 2023 20:48:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B30CE24E251;
        Wed, 19 Apr 2023 11:48:42 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 11:48:38 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 11:48:37 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 5/6] soc: starfive: Add JH7110 AON PMU support
Date:   Tue, 18 Apr 2023 20:48:31 -0700
Message-ID: <20230419034833.43243-6-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419034833.43243-1-changhuang.liang@starfivetech.com>
References: <20230419034833.43243-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AON PMU for StarFive JH7110 SoC. It can be used to turn on/off the
dphy rx/tx power switch.

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                       |  1 +
 drivers/soc/starfive/jh71xx_pmu.c | 63 ++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fafeea8ebdb..8f32d43a9b67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19950,6 +19950,7 @@ F:	include/dt-bindings/reset/starfive?jh71*.h
 
 STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/soc/starfive/jh71xx_pmu.c
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index bb44cc93e822..1303826aa7b5 100644
--- a/drivers/soc/starfive/jh71xx_pmu.c
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -2,7 +2,7 @@
 /*
  * StarFive JH71XX PMU (Power Management Unit) Controller Driver
  *
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
  */
 
 #include <linux/interrupt.h>
@@ -24,6 +24,9 @@
 #define JH71XX_PMU_EVENT_STATUS		0x88
 #define JH71XX_PMU_INT_STATUS		0x8C
 
+/* aon pmu register offset */
+#define JH71XX_AON_PMU_SWITCH		0x00
+
 /* sw encourage cfg */
 #define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
 #define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
@@ -163,6 +166,23 @@ static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	return 0;
 }
 
+static int jh7110_aon_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+
+	if (on)
+		regmap_update_bits(pmu->base, JH71XX_AON_PMU_SWITCH, mask, mask);
+	else
+		regmap_update_bits(pmu->base, JH71XX_AON_PMU_SWITCH, mask, 0);
+
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
 static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
@@ -270,6 +290,24 @@ static int jh7110_pmu_parse_dt(struct platform_device *pdev, struct jh71xx_pmu *
 	return 0;
 }
 
+static int jh7110_aon_pmu_parse_dt(struct platform_device *pdev, struct jh71xx_pmu *pmu)
+{
+	struct device *parent;
+	struct device *dev = &pdev->dev;
+
+	parent = pdev->dev.parent;
+	if (!parent) {
+		dev_err(dev, "No parent for syscon pmu\n");
+		return -ENODEV;
+	}
+
+	pmu->base = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(pmu->base))
+		return PTR_ERR(pmu->base);
+
+	return 0;
+}
+
 static int jh71xx_pmu_init_domain(struct jh71xx_pmu *pmu, int index)
 {
 	struct jh71xx_pmu_dev *pmd;
@@ -398,10 +436,32 @@ static const struct jh71xx_pmu_match_data jh7110_pmu = {
 	.pmu_set_state = jh7110_pmu_set_state,
 };
 
+static const struct jh71xx_domain_info jh7110_aon_power_domains[] = {
+	[JH7110_PD_DPHY_TX] = {
+		.name = "DPHY-TX",
+		.bit = 30,
+	},
+	[JH7110_PD_DPHY_RX] = {
+		.name = "DPHY-RX",
+		.bit = 31,
+	},
+};
+
+static const struct jh71xx_pmu_match_data jh7110_aon_pmu = {
+	.num_domains = ARRAY_SIZE(jh7110_aon_power_domains),
+	.domain_info = jh7110_aon_power_domains,
+	.pmu_status = JH71XX_AON_PMU_SWITCH,
+	.pmu_parse_dt = jh7110_aon_pmu_parse_dt,
+	.pmu_set_state = jh7110_aon_pmu_set_state,
+};
+
 static const struct of_device_id jh71xx_pmu_of_match[] = {
 	{
 		.compatible = "starfive,jh7110-pmu",
 		.data = (void *)&jh7110_pmu,
+	}, {
+		.compatible = "starfive,jh7110-aon-pmu",
+		.data = (void *)&jh7110_aon_pmu,
 	}, {
 		/* sentinel */
 	}
@@ -418,5 +478,6 @@ static struct platform_driver jh71xx_pmu_driver = {
 builtin_platform_driver(jh71xx_pmu_driver);
 
 MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
 MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

