Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FE6E6004
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDRLiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDRLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:37:59 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E104B7ABA;
        Tue, 18 Apr 2023 04:37:42 -0700 (PDT)
Received: from kaima.. ([10.12.190.56])
        (user=kaima@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33IBZ9Ba004965-33IBZ9Bb004965
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Apr 2023 19:35:23 +0800
From:   Kai Ma <kaima@hust.edu.cn>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Kai Ma <kaima@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe
Date:   Tue, 18 Apr 2023 11:34:51 +0000
Message-Id: <20230418113451.151312-1-kaima@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: kaima@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_of_iomap() instead of of_iomap() to automatically
handle the unused ioremap region. If any error occurs, regions allocated by
kzalloc() will leak, but using devm_kzalloc() instead will automatically
free the memory using devm_kfree().

Also, fix error handling of hws by adding unregister_hws label, which
unregisters remaining hws when iomap failed.

Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
Signed-off-by: Kai Ma <kaima@hust.edu.cn>
---
The issue is found by static analysis and remains untested.
---
 drivers/clk/imx/clk-imxrt1050.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index fd5c51fc92c0..08d155feb035 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -42,7 +42,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	struct device_node *anp;
 	int ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMXRT1050_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
@@ -53,10 +53,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	hws[IMXRT1050_CLK_OSC] = imx_get_clk_hw_by_name(np, "osc");
 
 	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
-	pll_base = of_iomap(anp, 0);
+	pll_base = devm_of_iomap(dev, anp, 0, NULL);
 	of_node_put(anp);
-	if (WARN_ON(!pll_base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(pll_base))) {
+		ret = PTR_ERR(pll_base);
+		goto unregister_hws;
+	}
 
 	/* Anatop clocks */
 	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
@@ -104,8 +106,10 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 
 	/* CCM clocks */
 	ccm_base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(ccm_base)))
-		return PTR_ERR(ccm_base);
+	if (WARN_ON(IS_ERR(ccm_base))) {
+		ret = PTR_ERR(ccm_base);
+		goto unregister_hws;
+	}
 
 	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
 	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
@@ -149,8 +153,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
-		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
+		goto unregister_hws;
 	}
+	return 0;
+
+unregister_hws:
+	imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
 	return ret;
 }
 static const struct of_device_id imxrt1050_clk_of_match[] = {
-- 
2.34.1

