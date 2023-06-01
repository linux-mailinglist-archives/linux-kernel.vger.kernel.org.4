Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85034719172
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFADkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFADkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:40:41 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9B136;
        Wed, 31 May 2023 20:40:37 -0700 (PDT)
Received: from hzh.. ([10.12.190.56])
        (user=zero12113@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3513cR3X030481-3513cR3Y030481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Jun 2023 11:38:31 +0800
From:   Zhanhao Hu <zero12113@hust.edu.cn>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Zhanhao Hu <zero12113@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe
Date:   Thu,  1 Jun 2023 03:38:25 +0000
Message-Id: <20230601033825.336558-1-zero12113@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: zero12113@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function probe(), it returns directly without unregistered hws
when error occurs.

Fix this by adding 'goto unregister_hws;' on line 295 and
line 310.

Use devm_kzalloc() instead of kzalloc() to automatically
free the memory using devm_kfree() when error occurs.

Replace of_iomap() with devm_of_iomap() to automatically
handle the unused ioremap region and delete 'iounmap(anatop_base);'
in unregister_hws.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Signed-off-by: Zhanhao Hu <zero12113@hust.edu.cn>
---
V1 -> V2 : Rephrase commit message in imperative mood.
This issue is found by static analysis and remains untested.
---
 drivers/clk/imx/clk-imx93.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 07b4a043e449..b6c7c2725906 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -264,7 +264,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	void __iomem *base, *anatop_base;
 	int i, ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
 	if (!clk_hw_data)
 		return -ENOMEM;
@@ -288,10 +288,12 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 								    "sys_pll_pfd2", 1, 2);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
-	anatop_base = of_iomap(np, 0);
+	anatop_base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!anatop_base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(anatop_base))) {
+		ret = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	clks[IMX93_CLK_ARM_PLL] = imx_clk_fracn_gppll_integer("arm_pll", "osc_24m",
 							      anatop_base + 0x1000,
@@ -304,8 +306,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(IS_ERR(base))) {
-		iounmap(anatop_base);
-		return PTR_ERR(base);
+		ret = PTR_ERR(base);
+		goto unregister_hws;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
@@ -345,7 +347,6 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 unregister_hws:
 	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
-	iounmap(anatop_base);
 
 	return ret;
 }
-- 
2.34.1

