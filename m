Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A896EBF8C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDWMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:48:34 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AA510C8;
        Sun, 23 Apr 2023 05:48:32 -0700 (PDT)
Received: from pride-PowerEdge-R740.. ([172.16.0.254])
        (user=U201812168@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33NCl40M013852-33NCl40N013852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Apr 2023 20:47:08 +0800
From:   Ziwei Yan <u201812168@hust.edu.cn>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Ziwei Yan <u201812168@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: clk-imx8mq: fix memory leak and missing unwind goto in imx8mq_clocks_probe
Date:   Sun, 23 Apr 2023 08:47:02 -0400
Message-Id: <20230423124702.168027-1-u201812168@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: U201812168@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/clk/imx/clk-imx8mq.c:611 imx8mq_clocks_probe() warn: 'base'
from of_iomap() not released on lines: 399,611.

This is because probe() returns without releasing base.
I fix this by replacing of_iomap() with devm_of_iomap()
to automatically handle the unused ioremap region.

Similarly, I use devm_kzalloc() instead of kzalloc()
to automatically free the memory
using devm_kfree() when error occurs.

Besides, in this function, some other issues are found.
On line 311 and 398,
probe() returns directly without unregistering hws.
So I add `goto unregister_hws;` here.

Fixes: b9ef22e1592f ("clk: imx: imx8mq: Switch to clk_hw based API")
Fixes: b80522040cd3 ("clk: imx: Add clock driver for i.MX8MQ CCM")
Fixes: 1aa6af5f1813 ("clk: imx8mq: Use devm_platform_ioremap_resource() instead of of_iomap()")
Signed-off-by: Ziwei Yan <u201812168@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis and remains untested.
---
 drivers/clk/imx/clk-imx8mq.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4bd65879fcd3..4aa58a7e7880 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -288,7 +288,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int err;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX8MQ_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
@@ -306,10 +306,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
-	base = of_iomap(np, 0);
+	base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	hws[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -395,8 +397,10 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base)))
-		return PTR_ERR(base);
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mq_a53_sels, base + 0x8000);
-- 
2.34.1

