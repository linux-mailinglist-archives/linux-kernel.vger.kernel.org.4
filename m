Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F46AC27D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCFOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCFOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:08:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36D26855;
        Mon,  6 Mar 2023 06:07:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31560660220B;
        Mon,  6 Mar 2023 14:06:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111581;
        bh=bujBkbH2Xnz+TA8zGt0BdnZlgZ+DvKgH48XA13G7rag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqiee3E3wKWgNpCx8IXh08Z2wKpXvLsBjDQ+24pSemmKDfMNQxEbABPtapVeswr5i
         r4p2p42SrtvFt57QLXMGYs7gmuHcISh41cp3C1omIpwaQiRCSY5AbHdlaQFdlzCpdI
         5Zd96zJLEQYwBqJsCBvdIBxTEkFXmzkS3gxums1A2PzrEyAxptNi9kwy80+HF3ZV8T
         nxvXN+jkydub3zf0Wclnz+KY8Wvjw44DVXKHz6VsYjV+y2vE2/LpTgvH92rb9wiV6v
         i93bmpOkfNl2MMeZlKqu7mo9dYZZPKoBA2mzJIVHVRgjzfwRn3uPA8eyN3t/EMSzLi
         xqOqVr8N1tsTQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 21/54] clk: mediatek: mt8183: Convert all remaining clocks to common probe
Date:   Mon,  6 Mar 2023 15:05:10 +0100
Message-Id: <20230306140543.1813621-22-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to mtk_clk_simple_{probe,remove}() for infracfg and topckgen
clocks on MT8183 to allow full module build for clock drivers.

Differently from other MediaTek clock drivers, it was necessary to
change the name of the `clk13m` clock, as that is already declared
in the SoC's devicetree as a "fixed-factor-clock" (with the same
name) and redeclaring it here would obviously fail to register the
entire clock controller; this clock wasn't dropped only to retain
compatibility with older devicetrees

As a note, the `clk13m` clock is not mentioned in any parent names
array(s) as the correct one (csw_f26m_d2) is already used in place
of that.

Thanks to the conversion, more error handling was added to the clocks
registration.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8183.c | 166 ++++++------------------------
 1 file changed, 34 insertions(+), 132 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 9da193d7782d..02176ee97cd2 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -25,11 +25,14 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK(CLK_TOP_UNIVP_192M, "univpll_192m", "univpll", 192000000),
 };
 
-static const struct mtk_fixed_factor top_early_divs[] = {
-	FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
-};
-
+/*
+ * To retain compatibility with older devicetrees, we keep CLK_TOP_CLK13M
+ * valid, but renamed from "clk13m" (defined as fixed clock in the new
+ * devicetrees) to "clk26m_d2", satisfying the older clock assignments.
+ * This means that on new devicetrees "clk26m_d2" is unused.
+ */
 static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_CLK13M, "clk26m_d2", "clk26m", 1, 2),
 	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
 	FACTOR_FLAGS(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1, 0),
 	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2, 0),
@@ -803,26 +806,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
 };
 
-static struct clk_hw_onecell_data *top_clk_data;
-
-static void clk_mt8183_top_init_early(struct device_node *node)
-{
-	int i;
-
-	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-
-	for (i = 0; i < CLK_TOP_NR_CLK; i++)
-		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
-			top_clk_data);
-
-	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
-}
-
-CLK_OF_DECLARE_DRIVER(mt8183_topckgen, "mediatek,mt8183-topckgen",
-			clk_mt8183_top_init_early);
-
 /* Register mux notifier for MFG mux */
 static int clk_mt8183_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
 {
@@ -845,134 +828,53 @@ static int clk_mt8183_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
 	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
 }
 
-static int clk_mt8183_top_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct device_node *node = pdev->dev.of_node;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-		top_clk_data);
-
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
-		top_clk_data);
-
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-
-	mtk_clk_register_muxes(&pdev->dev, top_muxes,
-			       ARRAY_SIZE(top_muxes), node,
-			       &mt8183_clk_lock, top_clk_data);
-
-	mtk_clk_register_composites(&pdev->dev, top_aud_comp,
-				    ARRAY_SIZE(top_aud_comp), base,
-				    &mt8183_clk_lock, top_clk_data);
-
-	mtk_clk_register_gates(&pdev->dev, node, top_clks,
-			       ARRAY_SIZE(top_clks), top_clk_data);
-
-	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
-					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
-	if (ret)
-		return ret;
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				      top_clk_data);
-}
-
-static int clk_mt8183_mcu_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
-
-	mtk_clk_register_composites(&pdev->dev, mcu_muxes,
-				    ARRAY_SIZE(mcu_muxes), base,
-				    &mt8183_clk_lock, clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
-
-static const struct of_device_id of_match_clk_mt8183[] = {
-	{
-		.compatible = "mediatek,mt8183-topckgen",
-		.data = clk_mt8183_top_probe,
-	}, {
-		.compatible = "mediatek,mt8183-mcucfg",
-		.data = clk_mt8183_mcu_probe,
-	}, {
-		/* sentinel */
-	}
-};
-
-static int clk_mt8183_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *pdev);
-	int r;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	r = clk_probe(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static const struct mtk_clk_desc infra_desc = {
 	.clks = infra_clks,
 	.num_clks = ARRAY_SIZE(infra_clks),
 	.rst_desc = &clk_rst_desc,
 };
 
+static const struct mtk_clk_desc mcu_desc = {
+	.composite_clks = mcu_muxes,
+	.num_composite_clks = ARRAY_SIZE(mcu_muxes),
+	.clk_lock = &mt8183_clk_lock,
+};
+
 static const struct mtk_clk_desc peri_desc = {
 	.clks = peri_clks,
 	.num_clks = ARRAY_SIZE(peri_clks),
 };
 
-static const struct of_device_id of_match_clk_mt8183_simple[] = {
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.composite_clks = top_aud_comp,
+	.num_composite_clks = ARRAY_SIZE(top_aud_comp),
+	.clks = top_clks,
+	.num_clks = ARRAY_SIZE(top_clks),
+	.clk_lock = &mt8183_clk_lock,
+	.clk_notifier_func = clk_mt8183_reg_mfg_mux_notifier,
+	.mfg_clk_idx = CLK_TOP_MUX_MFG,
+};
+
+static const struct of_device_id of_match_clk_mt8183[] = {
 	{ .compatible = "mediatek,mt8183-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt8183-mcucfg", .data = &mcu_desc },
 	{ .compatible = "mediatek,mt8183-pericfg", .data = &peri_desc, },
+	{ .compatible = "mediatek,mt8183-topckgen", .data = &topck_desc },
 	{ /* sentinel */ }
 };
 
-static struct platform_driver clk_mt8183_simple_drv = {
+static struct platform_driver clk_mt8183_drv = {
 	.probe = mtk_clk_simple_probe,
 	.remove = mtk_clk_simple_remove,
-	.driver = {
-		.name = "clk-mt8183-simple",
-		.of_match_table = of_match_clk_mt8183_simple,
-	},
-};
-
-static struct platform_driver clk_mt8183_drv = {
-	.probe = clk_mt8183_probe,
 	.driver = {
 		.name = "clk-mt8183",
 		.of_match_table = of_match_clk_mt8183,
 	},
 };
-
-static int __init clk_mt8183_init(void)
-{
-	int ret = platform_driver_register(&clk_mt8183_drv);
-
-	if (ret)
-		return ret;
-	return platform_driver_register(&clk_mt8183_simple_drv);
-}
-
-arch_initcall(clk_mt8183_init);
+module_platform_driver(clk_mt8183_drv)
-- 
2.39.2

