Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB768C17B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjBFPbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjBFPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA22A98F;
        Mon,  6 Feb 2023 07:30:14 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A644D6602F9A;
        Mon,  6 Feb 2023 15:30:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697412;
        bh=eDJtafD5ej806nou99ug78e1GYvetve0uIFJWzuFWmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJmFmaHoyUIhUFVDottCypPapqO/zcvHCXI4p/klHHvnlZAumIx2UdhA/lZ+CvtlP
         4VwlqjwbC6sG8WMN5fV2uqLVORsssbrgnZutaC6UVCaveVt5sMjPBpnB5wHzv/pUKR
         QDJYpEpDAdZ4e/2XTZF+DPe8Zn5ns/y5CRdQbdJMewXViJ/xKPzp8fvx75TWBDthjH
         m195z7fb0mzs5BLDoAk0yvV/+mf6arsA6kW8EjFsegNbheNxva5aA/iT7+2IawMdK9
         Ld62le8smSdKbKmwiM+FhdbZ/mWq1exKGKAKWva/hw0P7q3IacoZr0zdwCgamKnAGn
         NjWfgaGtsJg4A==
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
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 19/45] clk: mediatek: mt8183: Convert all remaining clocks to common probe
Date:   Mon,  6 Feb 2023 16:29:02 +0100
Message-Id: <20230206152928.918562-20-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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
In order to do this, like done for other MediaTek clock drivers, it
was necessary to join top_early_divs with top_divs and to stop
registering the `clk13m` clock early.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 160 ++++++------------------------
 1 file changed, 28 insertions(+), 132 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 0fad2cf7f41b..035fdd02f0be 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -25,11 +25,8 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK(CLK_TOP_UNIVP_192M, "univpll_192m", "univpll", 192000000),
 };
 
-static const struct mtk_fixed_factor top_early_divs[] = {
-	FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
-};
-
 static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
 	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
 	FACTOR_FLAGS(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1, 0),
 	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2, 0),
@@ -809,26 +806,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
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
@@ -851,134 +828,53 @@ static int clk_mt8183_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
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
2.39.1

