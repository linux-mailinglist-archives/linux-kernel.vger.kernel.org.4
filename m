Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F86E71FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDSD5W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjDSD44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:56:56 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5A5FC4;
        Tue, 18 Apr 2023 20:56:54 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 014A524E2B4;
        Wed, 19 Apr 2023 11:56:53 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 11:56:52 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 11:56:51 +0800
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
Subject: [RESEND v2 4/6] soc: starfive: Extract JH7110 pmu private operations
Date:   Tue, 18 Apr 2023 20:56:44 -0700
Message-ID: <20230419035646.43702-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move JH7110 private operation into private data of compatible.
Convenient to expand different compatible.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/soc/starfive/jh71xx_pmu.c | 98 +++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 306218c83691..bb44cc93e822 100644
--- a/drivers/soc/starfive/jh71xx_pmu.c
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -51,9 +51,17 @@ struct jh71xx_domain_info {
 	u8 bit;
 };
 
+struct jh71xx_pmu;
+struct jh71xx_pmu_dev;
+
 struct jh71xx_pmu_match_data {
 	const struct jh71xx_domain_info *domain_info;
 	int num_domains;
+	unsigned int pmu_status;
+	int (*pmu_parse_dt)(struct platform_device *pdev,
+			    struct jh71xx_pmu *pmu);
+	int (*pmu_set_state)(struct jh71xx_pmu_dev *pmd,
+			     u32 mask, bool on);
 };
 
 struct jh71xx_pmu {
@@ -80,14 +88,14 @@ static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_o
 	if (!mask)
 		return -EINVAL;
 
-	regmap_read(pmu->base, JH71XX_PMU_CURR_POWER_MODE, &val);
+	regmap_read(pmu->base, pmu->match_data->pmu_status, &val);
 
 	*is_on = val & mask;
 
 	return 0;
 }
 
-static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
 	unsigned long flags;
@@ -95,22 +103,8 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	u32 mode;
 	u32 encourage_lo;
 	u32 encourage_hi;
-	bool is_on;
 	int ret;
 
-	ret = jh71xx_pmu_get_state(pmd, mask, &is_on);
-	if (ret) {
-		dev_dbg(pmu->dev, "unable to get current state for %s\n",
-			pmd->genpd.name);
-		return ret;
-	}
-
-	if (is_on == on) {
-		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
-			pmd->genpd.name, on ? "en" : "dis");
-		return 0;
-	}
-
 	spin_lock_irqsave(&pmu->lock, flags);
 
 	/*
@@ -169,6 +163,29 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	return 0;
 }
 
+static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+	const struct jh71xx_pmu_match_data *match_data = pmu->match_data;
+	bool is_on;
+	int ret;
+
+	ret = jh71xx_pmu_get_state(pmd, mask, &is_on);
+	if (ret) {
+		dev_dbg(pmu->dev, "unable to get current state for %s\n",
+			pmd->genpd.name);
+		return ret;
+	}
+
+	if (is_on == on) {
+		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
+			pmd->genpd.name, on ? "en" : "dis");
+		return 0;
+	}
+
+	return match_data->pmu_set_state(pmd, mask, on);
+}
+
 static int jh71xx_pmu_on(struct generic_pm_domain *genpd)
 {
 	struct jh71xx_pmu_dev *pmd = container_of(genpd,
@@ -229,6 +246,30 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int jh7110_pmu_parse_dt(struct platform_device *pdev, struct jh71xx_pmu *pmu)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	pmu->base = device_node_to_regmap(np);
+	if (IS_ERR(pmu->base))
+		return PTR_ERR(pmu->base);
+
+	pmu->irq = platform_get_irq(pdev, 0);
+	if (pmu->irq < 0)
+		return pmu->irq;
+
+	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
+			       0, pdev->name, pmu);
+	if (ret)
+		dev_err(dev, "failed to request irq\n");
+
+	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
+
+	return 0;
+}
+
 static int jh71xx_pmu_init_domain(struct jh71xx_pmu *pmu, int index)
 {
 	struct jh71xx_pmu_dev *pmd;
@@ -274,23 +315,18 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 	if (!pmu)
 		return -ENOMEM;
 
-	pmu->base = device_node_to_regmap(np);
-	if (IS_ERR(pmu->base))
-		return PTR_ERR(pmu->base);
-
-	pmu->irq = platform_get_irq(pdev, 0);
-	if (pmu->irq < 0)
-		return pmu->irq;
-
-	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
-			       0, pdev->name, pmu);
-	if (ret)
-		dev_err(dev, "failed to request irq\n");
+	spin_lock_init(&pmu->lock);
 
 	match_data = of_device_get_match_data(dev);
 	if (!match_data)
 		return -EINVAL;
 
+	ret = match_data->pmu_parse_dt(pdev, pmu);
+	if (ret) {
+		dev_err(dev, "failed to parse dt\n");
+		return ret;
+	}
+
 	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
 				  sizeof(struct generic_pm_domain *),
 				  GFP_KERNEL);
@@ -310,9 +346,6 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	spin_lock_init(&pmu->lock);
-	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
-
 	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
 	if (ret) {
 		dev_err(dev, "failed to register genpd driver: %d\n", ret);
@@ -360,6 +393,9 @@ static const struct jh71xx_domain_info jh7110_power_domains[] = {
 static const struct jh71xx_pmu_match_data jh7110_pmu = {
 	.num_domains = ARRAY_SIZE(jh7110_power_domains),
 	.domain_info = jh7110_power_domains,
+	.pmu_status = JH71XX_PMU_CURR_POWER_MODE,
+	.pmu_parse_dt = jh7110_pmu_parse_dt,
+	.pmu_set_state = jh7110_pmu_set_state,
 };
 
 static const struct of_device_id jh71xx_pmu_of_match[] = {
-- 
2.25.1

