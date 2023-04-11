Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC906DD34D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjDKGsA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 02:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDKGry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:47:54 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703822D66;
        Mon, 10 Apr 2023 23:47:49 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 445FD24E225;
        Tue, 11 Apr 2023 14:47:47 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 14:47:47 +0800
Received: from ubuntu.localdomain (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 14:47:46 +0800
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
Subject: [PATCH v1 3/7] soc: starfive: Modify ioremap to regmap
Date:   Mon, 10 Apr 2023 23:47:39 -0700
Message-ID: <20230411064743.273388-4-changhuang.liang@starfivetech.com>
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

Modify ioremap to regmap, easy to simplify code.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/soc/starfive/jh71xx_pmu.c | 43 +++++++++++++++++--------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
index 7d5f50d71c0d..306218c83691 100644
--- a/drivers/soc/starfive/jh71xx_pmu.c
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -6,13 +6,13 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/regmap.h>
 #include <dt-bindings/power/starfive,jh7110-pmu.h>
 
 /* register offset */
@@ -59,7 +59,7 @@ struct jh71xx_pmu_match_data {
 struct jh71xx_pmu {
 	struct device *dev;
 	const struct jh71xx_pmu_match_data *match_data;
-	void __iomem *base;
+	struct regmap *base;
 	struct generic_pm_domain **genpd;
 	struct genpd_onecell_data genpd_data;
 	int irq;
@@ -75,11 +75,14 @@ struct jh71xx_pmu_dev {
 static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
+	unsigned int val;
 
 	if (!mask)
 		return -EINVAL;
 
-	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
+	regmap_read(pmu->base, JH71XX_PMU_CURR_POWER_MODE, &val);
+
+	*is_on = val & mask;
 
 	return 0;
 }
@@ -130,7 +133,7 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 		encourage_hi = JH71XX_PMU_SW_ENCOURAGE_DIS_HI;
 	}
 
-	writel(mask, pmu->base + mode);
+	regmap_write(pmu->base, mode, mask);
 
 	/*
 	 * 2.Write SW encourage command sequence to the Software Encourage Reg (offset 0x44)
@@ -140,21 +143,21 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	 *   Then write the lower bits of the command sequence, followed by the upper
 	 *   bits. The sequence differs between powering on & off a domain.
 	 */
-	writel(JH71XX_PMU_SW_ENCOURAGE_ON, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
-	writel(encourage_lo, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
-	writel(encourage_hi, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
+	regmap_write(pmu->base, JH71XX_PMU_SW_ENCOURAGE, JH71XX_PMU_SW_ENCOURAGE_ON);
+	regmap_write(pmu->base, JH71XX_PMU_SW_ENCOURAGE, encourage_lo);
+	regmap_write(pmu->base, JH71XX_PMU_SW_ENCOURAGE, encourage_hi);
 
 	spin_unlock_irqrestore(&pmu->lock, flags);
 
 	/* Wait for the power domain bit to be enabled / disabled */
 	if (on) {
-		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
-						val, val & mask,
-						1, JH71XX_PMU_TIMEOUT_US);
+		ret = regmap_read_poll_timeout_atomic(pmu->base, JH71XX_PMU_CURR_POWER_MODE,
+						      val, val & mask,
+						      1, JH71XX_PMU_TIMEOUT_US);
 	} else {
-		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
-						val, !(val & mask),
-						1, JH71XX_PMU_TIMEOUT_US);
+		ret = regmap_read_poll_timeout_atomic(pmu->base, JH71XX_PMU_CURR_POWER_MODE,
+						      val, !(val & mask),
+						      1, JH71XX_PMU_TIMEOUT_US);
 	}
 
 	if (ret) {
@@ -190,14 +193,14 @@ static void jh71xx_pmu_int_enable(struct jh71xx_pmu *pmu, u32 mask, bool enable)
 	unsigned long flags;
 
 	spin_lock_irqsave(&pmu->lock, flags);
-	val = readl(pmu->base + JH71XX_PMU_TIMER_INT_MASK);
+	regmap_read(pmu->base, JH71XX_PMU_TIMER_INT_MASK, &val);
 
 	if (enable)
 		val &= ~mask;
 	else
 		val |= mask;
 
-	writel(val, pmu->base + JH71XX_PMU_TIMER_INT_MASK);
+	regmap_write(pmu->base, JH71XX_PMU_TIMER_INT_MASK, val);
 	spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
@@ -206,7 +209,7 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
 	struct jh71xx_pmu *pmu = data;
 	u32 val;
 
-	val = readl(pmu->base + JH71XX_PMU_INT_STATUS);
+	regmap_read(pmu->base, JH71XX_PMU_INT_STATUS, &val);
 
 	if (val & JH71XX_PMU_INT_SEQ_DONE)
 		dev_dbg(pmu->dev, "sequence done.\n");
@@ -220,8 +223,8 @@ static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
 		dev_err(pmu->dev, "p-channel fail event.\n");
 
 	/* clear interrupts */
-	writel(val, pmu->base + JH71XX_PMU_INT_STATUS);
-	writel(val, pmu->base + JH71XX_PMU_EVENT_STATUS);
+	regmap_write(pmu->base, JH71XX_PMU_INT_STATUS, val);
+	regmap_write(pmu->base, JH71XX_PMU_EVENT_STATUS, val);
 
 	return IRQ_HANDLED;
 }
@@ -271,7 +274,7 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 	if (!pmu)
 		return -ENOMEM;
 
-	pmu->base = devm_platform_ioremap_resource(pdev, 0);
+	pmu->base = device_node_to_regmap(np);
 	if (IS_ERR(pmu->base))
 		return PTR_ERR(pmu->base);
 
-- 
2.25.1

