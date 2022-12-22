Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5946865407D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiLVL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiLVLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:55:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2A2CCBB;
        Thu, 22 Dec 2022 03:49:53 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E05C56602CF9;
        Thu, 22 Dec 2022 11:49:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709792;
        bh=pTPLqgfggQOJQKnrG05/EFzS5SPhf9tzN93cDLVUrqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgdBWw6KNXZj4C0KGInjFeutYEtcSTyJn04K4LfbXMqPd7WKGon9pw7CurJdxSKRt
         NFxPmnqXchewQYY1tubw48ehVEDa3aGSm9r6F6vzYghk4HT/EZGnWaOsWILdO42txx
         iY8ZuMufo+WHd/POAeLJTmbaTEzvT5sbn6SyOc4AkMAUdq7KY9mUNehtOMOeuRkEbs
         dECokdz+ptJJ/7aash4kiNibuQPQElBxoCmfyF7aPWLFqCJqnIPA5xNv3P5nZsdliA
         QklTOXzqfNKaD5hLcVJEwe4chzmYTle1bX3aav3h7LmVvosn1egDfHEV8Iko9lu/gE
         UcI9l0Sx9wZVA==
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
Subject: [PATCH v1 22/25] clk: mediatek: clk-mt8186-topckgen: Migrate to mtk_clk_simple_probe()
Date:   Thu, 22 Dec 2022 12:48:54 +0100
Message-Id: <20221222114857.120060-23-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
References: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
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

As done with MT8192, migrate MT8186 topckgen away from a custom probe
function and use mtk_clk_simple_{probe, remove}().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 101 ++++-----------------
 1 file changed, 19 insertions(+), 82 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 63befb1f492d..0fba88adf9fa 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -681,11 +681,6 @@ static struct mtk_composite top_muxes[] = {
 			0x0320, 4, 0x0334, 8, 0),
 };
 
-static const struct of_device_id of_match_clk_mt8186_topck[] = {
-	{ .compatible = "mediatek,mt8186-topckgen", },
-	{}
-};
-
 /* Register mux notifier for MFG mux */
 static int clk_mt8186_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
 {
@@ -708,86 +703,28 @@ static int clk_mt8186_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
 	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
 }
 
-static int clk_mt8186_topck_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-	void __iomem *base;
-
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		r = PTR_ERR(base);
-		goto free_top_data;
-	}
-
-	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-					clk_data);
-	if (r)
-		goto free_top_data;
-
-	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	if (r)
-		goto unregister_fixed_clks;
-
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
-				   &mt8186_clk_lock, clk_data, &pdev->dev);
-	if (r)
-		goto unregister_factors;
-
-	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-					&mt8186_clk_lock, clk_data, &pdev->dev);
-	if (r)
-		goto unregister_muxes;
-
-	r = clk_mt8186_reg_mfg_mux_notifier(&pdev->dev,
-					    clk_data->hws[CLK_TOP_MFG]->clk);
-	if (r)
-		goto unregister_composite_muxes;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_composite_muxes;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_composite_muxes:
-	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
-unregister_muxes:
-	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), clk_data);
-unregister_factors:
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-unregister_fixed_clks:
-	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), clk_data);
-free_top_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8186_topck_remove(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), clk_data);
-	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), clk_data);
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), clk_data);
-	mtk_free_clk_data(clk_data);
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_mtk_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_mtk_muxes),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.clk_lock = &mt8186_clk_lock,
+	.clk_notifier_func = clk_mt8186_reg_mfg_mux_notifier,
+	.mfg_clk_idx = CLK_TOP_MFG,
+};
 
-	return 0;
-}
+static const struct of_device_id of_match_clk_mt8186_topck[] = {
+	{ .compatible = "mediatek,mt8186-topckgen", .data = &topck_desc },
+	{}
+};
 
 static struct platform_driver clk_mt8186_topck_drv = {
-	.probe = clk_mt8186_topck_probe,
-	.remove = clk_mt8186_topck_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-topck",
 		.of_match_table = of_match_clk_mt8186_topck,
-- 
2.39.0

