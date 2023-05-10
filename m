Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB36FD3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjEJBxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 21:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEJBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:53:20 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3085735B3;
        Tue,  9 May 2023 18:53:18 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2108624E240;
        Wed, 10 May 2023 09:53:16 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 10 May
 2023 09:53:16 +0800
Received: from ubuntu.localdomain (183.27.98.219) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 10 May
 2023 09:53:15 +0800
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
Subject: [PATCH v3 3/5] soc: starfive: Extract JH7110 pmu private operations
Date:   Tue, 9 May 2023 18:53:09 -0700
Message-ID: <20230510015311.27505-4-changhuang.liang@starfivetech.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move JH7110 private operation into private data of compatible. Convenient
to add AON PMU which would not have interrupts property.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/soc/starfive/jh71xx_pmu.c | 89 +++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 7d5f50d71c0d..0dbdcc0d2c91 100644
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
+	int (*pmu_parse_irq)(struct platform_device *pdev,
+			     struct jh71xx_pmu *pmu);
+	int (*pmu_set_state)(struct jh71xx_pmu_dev *pmd,
+			     u32 mask, bool on);
 };
 
 struct jh71xx_pmu {
@@ -79,12 +87,12 @@ static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_o
 	if (!mask)
 		return -EINVAL;
 
-	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
+	*is_on = readl(pmu->base + pmu->match_data->pmu_status) & mask;
 
 	return 0;
 }
 
-static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
 	unsigned long flags;
@@ -92,22 +100,8 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
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
@@ -166,6 +160,29 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
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
@@ -226,6 +243,25 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int jh7110_pmu_parse_irq(struct platform_device *pdev, struct jh71xx_pmu *pmu)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
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
@@ -275,19 +311,18 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 	if (IS_ERR(pmu->base))
 		return PTR_ERR(pmu->base);
 
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
 
+	ret = match_data->pmu_parse_irq(pdev, pmu);
+	if (ret) {
+		dev_err(dev, "failed to parse irq\n");
+		return ret;
+	}
+
 	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
 				  sizeof(struct generic_pm_domain *),
 				  GFP_KERNEL);
@@ -307,9 +342,6 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	spin_lock_init(&pmu->lock);
-	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
-
 	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
 	if (ret) {
 		dev_err(dev, "failed to register genpd driver: %d\n", ret);
@@ -357,6 +389,9 @@ static const struct jh71xx_domain_info jh7110_power_domains[] = {
 static const struct jh71xx_pmu_match_data jh7110_pmu = {
 	.num_domains = ARRAY_SIZE(jh7110_power_domains),
 	.domain_info = jh7110_power_domains,
+	.pmu_status = JH71XX_PMU_CURR_POWER_MODE,
+	.pmu_parse_irq = jh7110_pmu_parse_irq,
+	.pmu_set_state = jh7110_pmu_set_state,
 };
 
 static const struct of_device_id jh71xx_pmu_of_match[] = {
-- 
2.25.1

