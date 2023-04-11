Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F86DD359
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDKGsW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 02:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjDKGry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:47:54 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC01212F;
        Mon, 10 Apr 2023 23:47:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6CD7724E293;
        Tue, 11 Apr 2023 14:47:49 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 14:47:49 +0800
Received: from ubuntu.localdomain (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 14:47:48 +0800
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 6/7] soc: starfive: Add dphy pmu support
Date:   Mon, 10 Apr 2023 23:47:42 -0700
Message-ID: <20230411064743.273388-7-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dphy pmu to turn on/off the dphy power switch.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                       |  1 +
 drivers/soc/starfive/jh71xx_pmu.c | 65 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b2170e1e4ff..4d958f02403e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19944,6 +19944,7 @@ F:	include/dt-bindings/reset/starfive?jh71*.h
 
 STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/soc/starfive/jh71xx_pmu.c
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 990db6735c48..d4092ca4dccf 100644
--- a/drivers/soc/starfive/jh71xx_pmu.c
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -24,6 +24,9 @@
 #define JH71XX_PMU_EVENT_STATUS		0x88
 #define JH71XX_PMU_INT_STATUS		0x8C
 
+/* DPHY pmu register offset */
+#define JH71XX_PMU_DPHY_SWITCH		0x00
+
 /* sw encourage cfg */
 #define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
 #define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
@@ -94,6 +97,8 @@ static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_o
 
 	if (pmu->match_data->pmu_type == JH71XX_PMU_GENERAL)
 		offset = JH71XX_PMU_CURR_POWER_MODE;
+	else if (pmu->match_data->pmu_type == JH71XX_PMU_DPHY)
+		offset = JH71XX_PMU_DPHY_SWITCH;
 
 	regmap_read(pmu->base, offset, &val);
 
@@ -170,6 +175,23 @@ static int jh71xx_pmu_general_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bo
 	return 0;
 }
 
+static int jh71xx_pmu_dphy_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+
+	if (on)
+		regmap_update_bits(pmu->base, JH71XX_PMU_DPHY_SWITCH, mask, mask);
+	else
+		regmap_update_bits(pmu->base, JH71XX_PMU_DPHY_SWITCH, mask, 0);
+
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
 static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
@@ -191,6 +213,8 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 
 	if (pmu->match_data->pmu_type == JH71XX_PMU_GENERAL)
 		ret = jh71xx_pmu_general_set_state(pmd, mask, on);
+	else if (pmu->match_data->pmu_type == JH71XX_PMU_DPHY)
+		ret = jh71xx_pmu_dphy_set_state(pmd, mask, on);
 
 	return ret;
 }
@@ -280,6 +304,25 @@ static int jh7110_pmu_general_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int jh7110_pmu_dphy_parse_dt(struct platform_device *pdev,
+				    struct jh71xx_pmu *pmu)
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
@@ -409,10 +452,31 @@ static const struct jh71xx_pmu_match_data jh7110_pmu = {
 	.pmu_parse_dt = jh7110_pmu_general_parse_dt,
 };
 
+static const struct jh71xx_domain_info jh7110_dphy_power_domains[] = {
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
+static const struct jh71xx_pmu_match_data jh7110_pmu_dphy = {
+	.num_domains = ARRAY_SIZE(jh7110_dphy_power_domains),
+	.domain_info = jh7110_dphy_power_domains,
+	.pmu_type = JH71XX_PMU_DPHY,
+	.pmu_parse_dt = jh7110_pmu_dphy_parse_dt,
+};
+
 static const struct of_device_id jh71xx_pmu_of_match[] = {
 	{
 		.compatible = "starfive,jh7110-pmu",
 		.data = (void *)&jh7110_pmu,
+	}, {
+		.compatible = "starfive,jh7110-pmu-dphy",
+		.data = (void *)&jh7110_pmu_dphy,
 	}, {
 		/* sentinel */
 	}
@@ -429,5 +493,6 @@ static struct platform_driver jh71xx_pmu_driver = {
 builtin_platform_driver(jh71xx_pmu_driver);
 
 MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
 MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

