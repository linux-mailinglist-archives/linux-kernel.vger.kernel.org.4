Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10E708FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjESGCW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 May 2023 02:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESGCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:02:11 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F267F10E0;
        Thu, 18 May 2023 23:02:07 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C070F24DBE4;
        Fri, 19 May 2023 14:02:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 19 May
 2023 14:02:06 +0800
Received: from ubuntu.localdomain (113.72.146.100) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 19 May
 2023 14:02:06 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/4] soc: starfive: Add JH7110 AON PMU support
Date:   Thu, 18 May 2023 23:02:02 -0700
Message-ID: <20230519060202.15296-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
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
index 60bbc3a05d79..d64e1b3b14f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20127,6 +20127,7 @@ F:	include/dt-bindings/reset/starfive?jh71*.h
 
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

