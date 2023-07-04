Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EE746A14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGDGuB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 02:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGDGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:49:30 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9686BE42;
        Mon,  3 Jul 2023 23:49:21 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1983D8159;
        Tue,  4 Jul 2023 14:49:20 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 14:49:20 +0800
Received: from localhost.localdomain (113.72.144.31) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 14:49:18 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "William Qiu" <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [RESEND PATCH v6 5/7] clk: starfive: jh7110-sys: Add PLL clocks source from DTS
Date:   Tue, 4 Jul 2023 14:46:08 +0800
Message-ID: <20230704064610.292603-6-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.31]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
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

Modify PLL clocks source to be got from DTS or
the fixed factor clocks.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  1 +
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 45 +++++++++++--------
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 5195f7be5213..978b78ec08b1 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -35,6 +35,7 @@ config CLK_STARFIVE_JH7110_SYS
 	select AUXILIARY_BUS
 	select CLK_STARFIVE_JH71X0
 	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
+	select CLK_STARFIVE_JH7110_PLL
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the system clock controller on the
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index e6031345ef05..d56f48013388 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -386,6 +387,7 @@ EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
 
 static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 {
+	bool use_fixed_pll = true;	/* PLL clocks use fixed factor clocks or PLL driver */
 	struct jh71x0_clk_priv *priv;
 	unsigned int idx;
 	int ret;
@@ -402,28 +404,29 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	/*
-	 * These PLL clocks are not actually fixed factor clocks and can be
-	 * controlled by the syscon registers of JH7110. They will be dropped
-	 * and registered in the PLL clock driver instead.
-	 */
+	if (!IS_ERR(devm_clk_get(priv->dev, "pll0_out")))
+		use_fixed_pll = false;	/* can get pll clocks from PLL driver */
+
+	/* Use fixed factor clocks if can not get the PLL clocks from DTS */
+	if (use_fixed_pll) {
 	/* 24MHz -> 1000.0MHz */
-	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
-							 "osc", 0, 125, 3);
-	if (IS_ERR(priv->pll[0]))
-		return PTR_ERR(priv->pll[0]);
+		priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
+								 "osc", 0, 125, 3);
+		if (IS_ERR(priv->pll[0]))
+			return PTR_ERR(priv->pll[0]);
 
 	/* 24MHz -> 1066.0MHz */
-	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
-							 "osc", 0, 533, 12);
-	if (IS_ERR(priv->pll[1]))
-		return PTR_ERR(priv->pll[1]);
+		priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
+								 "osc", 0, 533, 12);
+		if (IS_ERR(priv->pll[1]))
+			return PTR_ERR(priv->pll[1]);
 
 	/* 24MHz -> 1188.0MHz */
-	priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
-							 "osc", 0, 99, 2);
-	if (IS_ERR(priv->pll[2]))
-		return PTR_ERR(priv->pll[2]);
+		priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
+								 "osc", 0, 99, 2);
+		if (IS_ERR(priv->pll[2]))
+			return PTR_ERR(priv->pll[2]);
+	}
 
 	for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
 		u32 max = jh7110_sysclk_data[idx].max;
@@ -462,8 +465,14 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 				parents[i].fw_name = "tdm_ext";
 			else if (pidx == JH7110_SYSCLK_MCLK_EXT)
 				parents[i].fw_name = "mclk_ext";
-			else
+			else if (use_fixed_pll)
 				parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
+			else if (pidx == JH7110_SYSCLK_PLL0_OUT)
+				parents[i].fw_name = "pll0_out";
+			else if (pidx == JH7110_SYSCLK_PLL1_OUT)
+				parents[i].fw_name = "pll1_out";
+			else if (pidx == JH7110_SYSCLK_PLL2_OUT)
+				parents[i].fw_name = "pll2_out";
 		}
 
 		clk->hw.init = &init;
-- 
2.25.1

