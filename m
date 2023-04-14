Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059766E1A75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjDNCnJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Apr 2023 22:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDNCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:43:02 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191AB12E;
        Thu, 13 Apr 2023 19:43:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D4F4124E27E;
        Fri, 14 Apr 2023 10:42:59 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Apr
 2023 10:42:59 +0800
Received: from localhost.localdomain (183.27.97.249) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Apr
 2023 10:42:58 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 4/7] clk: starfive: jh7110-sys: Modify PLL clocks source
Date:   Fri, 14 Apr 2023 10:41:54 +0800
Message-ID: <20230414024157.53203-5-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify PLL clocks source to be got from dts instead of
the fixed factor clocks.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  1 +
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++---------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index e306edf4defa..903a5097c642 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -35,6 +35,7 @@ config CLK_STARFIVE_JH7110_SYS
 	select AUXILIARY_BUS
 	select CLK_STARFIVE_JH71X0
 	select RESET_STARFIVE_JH7110
+	select CLK_STARFIVE_JH7110_PLL
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the system clock controller on the
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 5ec210644e1d..439999dc2191 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -395,29 +395,6 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(priv->dev, (void *)(&priv->base));
 
-	/*
-	 * These PLL clocks are not actually fixed factor clocks and can be
-	 * controlled by the syscon registers of JH7110. They will be dropped
-	 * and registered in the PLL clock driver instead.
-	 */
-	/* 24MHz -> 1000.0MHz */
-	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
-							 "osc", 0, 125, 3);
-	if (IS_ERR(priv->pll[0]))
-		return PTR_ERR(priv->pll[0]);
-
-	/* 24MHz -> 1066.0MHz */
-	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
-							 "osc", 0, 533, 12);
-	if (IS_ERR(priv->pll[1]))
-		return PTR_ERR(priv->pll[1]);
-
-	/* 24MHz -> 1188.0MHz */
-	priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
-							 "osc", 0, 99, 2);
-	if (IS_ERR(priv->pll[2]))
-		return PTR_ERR(priv->pll[2]);
-
 	for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
 		u32 max = jh7110_sysclk_data[idx].max;
 		struct clk_parent_data parents[4] = {};
@@ -455,8 +432,12 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 				parents[i].fw_name = "tdm_ext";
 			else if (pidx == JH7110_SYSCLK_MCLK_EXT)
 				parents[i].fw_name = "mclk_ext";
-			else
-				parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
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

