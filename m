Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1186750D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjATJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjATJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:22:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA379AAA8;
        Fri, 20 Jan 2023 01:21:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F03C26602E33;
        Fri, 20 Jan 2023 09:21:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206481;
        bh=hyvZWVe4ucYAiauxcf5ZTm/oM/iSZL9fEKOY17bmsT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArFWnpwU9BMxzSmwnSuLQupVtoVqZkZVi8le2zbJTs20X8UFx9EQ84xCG7fNlXh52
         eSTx2H0Pc8T/8VmcT+wlENRDNG+ZPY0BrNnPoDausxtZVViheC8bMDY26Q2YJncbvy
         dyLTr1ofqZUgfbmvDq9r5VtZwrORzwsCUO1aJpb9a28gK50kHszDh2tzdsHsSoZ4Fq
         p7mC33HVq9RogtOttnXYNz7Y9Ievyh+y3djrwutJxuP2gp2QF1pd2Jq6m3p2xt7UjW
         qftS35tcFM2RrXR0ObWeMKs/q2nJpQh21OqIuKG0CNa9K449+MHAHiEmyacyIRPq5p
         vHZshz+Y2otBA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v4 13/23] clk: mediatek: mt8173: Migrate pericfg/topckgen to mtk_clk_simple_probe()
Date:   Fri, 20 Jan 2023 10:20:43 +0100
Message-Id: <20230120092053.182923-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
References: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
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

Function mtk_clk_simple_probe() gained the ability to register multiple
clock types: migrate MT8173's pericfg and topckgen to this common
probe function to reduce duplication and code size.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8173-pericfg.c  | 76 ++++-----------------
 drivers/clk/mediatek/clk-mt8173-topckgen.c | 77 ++++------------------
 2 files changed, 27 insertions(+), 126 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-pericfg.c b/drivers/clk/mediatek/clk-mt8173-pericfg.c
index 3552235ad55e..e87294b72c2c 100644
--- a/drivers/clk/mediatek/clk-mt8173-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-pericfg.c
@@ -46,6 +46,7 @@ static const struct mtk_composite peri_clks[] = {
 };
 
 static const struct mtk_gate peri_gates[] = {
+	GATE_DUMMY(CLK_DUMMY, "peri_gate_dummy"),
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_NFI, "peri_nfi", "axi_sel", 0),
 	GATE_PERI0(CLK_PERI_THERM, "peri_therm", "axi_sel", 1),
@@ -93,78 +94,27 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 };
 
+static const struct mtk_clk_desc peri_desc = {
+	.clks = peri_gates,
+	.num_clks = ARRAY_SIZE(peri_gates),
+	.composite_clks = peri_clks,
+	.num_composite_clks = ARRAY_SIZE(peri_clks),
+	.clk_lock = &mt8173_clk_lock,
+	.rst_desc = &clk_rst_desc,
+};
+
 static const struct of_device_id of_match_clk_mt8173_pericfg[] = {
-	{ .compatible = "mediatek,mt8173-pericfg" },
+	{ .compatible = "mediatek,mt8173-pericfg", .data = &peri_desc },
 	{ /* sentinel */ }
 };
 
-static int clk_mt8173_pericfg_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data))
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, peri_gates,
-				   ARRAY_SIZE(peri_gates), clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = mtk_clk_register_composites(&pdev->dev, peri_clks,
-					ARRAY_SIZE(peri_clks), base,
-					&mt8173_clk_lock, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_composites;
-
-	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-	if (r)
-		goto unregister_clk_hw;
-
-	return 0;
-
-unregister_clk_hw:
-	of_clk_del_provider(node);
-unregister_composites:
-	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8173_pericfg_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
-	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
-
 static struct platform_driver clk_mt8173_pericfg_drv = {
 	.driver = {
 		.name = "clk-mt8173-pericfg",
 		.of_match_table = of_match_clk_mt8173_pericfg,
 	},
-	.probe = clk_mt8173_pericfg_probe,
-	.remove = clk_mt8173_pericfg_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_pericfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-topckgen.c b/drivers/clk/mediatek/clk-mt8173-topckgen.c
index cfcfd016357a..257961528fe2 100644
--- a/drivers/clk/mediatek/clk-mt8173-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8173-topckgen.c
@@ -421,6 +421,7 @@ static const char * const i2s3_b_ck_parents[] = {
 };
 
 static const struct mtk_fixed_clk fixed_clks[] = {
+	FIXED_CLK(CLK_DUMMY, "topck_dummy", "clk26m", DUMMY_RATE),
 	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", DUMMY_RATE),
 	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
 	FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", DUMMY_RATE),
@@ -623,78 +624,28 @@ static const struct mtk_composite top_muxes[] = {
 	MUX(CLK_TOP_I2S3_B_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
 };
 
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.clk_lock = &mt8173_top_clk_lock,
+};
+
 static const struct of_device_id of_match_clk_mt8173_topckgen[] = {
-	{ .compatible = "mediatek,mt8173-topckgen" },
+	{ .compatible = "mediatek,mt8173-topckgen", .data = &topck_desc },
 	{ /* sentinel */ }
 };
 
-static int clk_mt8173_topckgen_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
-	int r;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data))
-		return -ENOMEM;
-
-	r = mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	if (r)
-		goto unregister_fixed_clks;
-
-	r = mtk_clk_register_composites(&pdev->dev, top_muxes,
-					ARRAY_SIZE(top_muxes), base,
-					&mt8173_top_clk_lock, clk_data);
-	if (r)
-		goto unregister_factors;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_composites;
-
-	return 0;
-
-unregister_composites:
-	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
-unregister_factors:
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-unregister_fixed_clks:
-	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8173_topckgen_remove(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
-
 static struct platform_driver clk_mt8173_topckgen_drv = {
 	.driver = {
 		.name = "clk-mt8173-topckgen",
 		.of_match_table = of_match_clk_mt8173_topckgen,
 	},
-	.probe = clk_mt8173_topckgen_probe,
-	.remove = clk_mt8173_topckgen_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_topckgen_drv);
 
-- 
2.39.0

