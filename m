Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB16FD3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjEJBx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjEJBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:53:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08CD3A85;
        Tue,  9 May 2023 18:53:18 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 665C224E1D4;
        Wed, 10 May 2023 09:53:17 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 10 May
 2023 09:53:17 +0800
Received: from ubuntu.localdomain (183.27.98.219) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 10 May
 2023 09:53:16 +0800
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
Subject: [PATCH v3 4/5] soc: starfive: Add JH7110 AON PMU support
Date:   Tue, 9 May 2023 18:53:10 -0700
Message-ID: <20230510015311.27505-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510015311.27505-1-changhuang.liang@starfivetech.com>
References: <20230510015311.27505-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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
 drivers/soc/starfive/jh71xx_pmu.c | 57 ++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c0b39c44957..ce0befe39394 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19939,6 +19939,7 @@ F:	include/dt-bindings/reset/starfive?jh71*.h
 
 STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/soc/starfive/jh71xx_pmu.c
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 0dbdcc0d2c91..c7b474409cf7 100644
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
@@ -160,6 +163,26 @@ static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	return 0;
 }
 
+static int jh7110_aon_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+	val = readl(pmu->base + JH71XX_AON_PMU_SWITCH);
+
+	if (on)
+		val |= mask;
+	else
+		val &= ~mask;
+
+	writel(val, pmu->base + JH71XX_AON_PMU_SWITCH);
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
 static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
@@ -317,10 +340,12 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 	if (!match_data)
 		return -EINVAL;
 
-	ret = match_data->pmu_parse_irq(pdev, pmu);
-	if (ret) {
-		dev_err(dev, "failed to parse irq\n");
-		return ret;
+	if (match_data->pmu_parse_irq) {
+		ret = match_data->pmu_parse_irq(pdev, pmu);
+		if (ret) {
+			dev_err(dev, "failed to parse irq\n");
+			return ret;
+		}
 	}
 
 	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
@@ -394,10 +419,31 @@ static const struct jh71xx_pmu_match_data jh7110_pmu = {
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
+	.pmu_set_state = jh7110_aon_pmu_set_state,
+};
+
 static const struct of_device_id jh71xx_pmu_of_match[] = {
 	{
 		.compatible = "starfive,jh7110-pmu",
 		.data = (void *)&jh7110_pmu,
+	}, {
+		.compatible = "starfive,jh7110-aon-syscon",
+		.data = (void *)&jh7110_aon_pmu,
 	}, {
 		/* sentinel */
 	}
@@ -414,5 +460,6 @@ static struct platform_driver jh71xx_pmu_driver = {
 builtin_platform_driver(jh71xx_pmu_driver);
 
 MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
 MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

