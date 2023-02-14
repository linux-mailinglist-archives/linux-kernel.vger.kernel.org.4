Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53F6964ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjBNNmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjBNNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:41:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4AD25E22;
        Tue, 14 Feb 2023 05:41:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A7CCC660216D;
        Tue, 14 Feb 2023 13:41:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382108;
        bh=8FCYMfAOFtesOuQgR23iEJsH5DFbnIHYEwIdqw3++KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=at+zjfObYId55dsjFa2epZ2YBlBrOIbCSJHQzUWQu3uwbKgpJcK//h6snfs1Uh3kW
         6qly4csplWhZGjEZWrQriD7YCEdhs8Q66g11EEuIQVoSbC4gS2dmlljPOGfrOSzBBY
         3OvPsLQcRfd2UeOYz7DTh2MhZg+A1lsbLjfg64khr37aapnWcF/S9l5XpYN9EHksw7
         /2KA6PRAOvCb97Wr1YX4K44A+Cj1iY3/HKZd2MCHlQegfd2OepUCzyrfH393ElOerJ
         SOisBXl3bLHRaTSrCEy66dSo7on1kmrdj7OaHs79tet/D8Rvxr6V/3AuVqVdCPTlCt
         cSMNrEinzSN9A==
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
Subject: [PATCH v2 05/47] clk: mediatek: mt2712: Migrate topckgen/mcucfg to mtk_clk_simple_probe()
Date:   Tue, 14 Feb 2023 14:40:45 +0100
Message-Id: <20230214134127.59273-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
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

Now that the common mtk_clk_simple_{probe,remove}() functions can deal
with divider clocks it is possible to migrate more clock drivers to it:
in this case, it's about topckgen.
While at it, also perform a fast migration for mcucfg.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2712.c | 127 +++++-------------------------
 1 file changed, 21 insertions(+), 106 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 94f8fc2a4f7b..db20c46e088b 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -36,14 +36,11 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK(CLK_TOP_CVBSPLL, "cvbspll", NULL, 108000000),
 };
 
-static const struct mtk_fixed_factor top_early_divs[] = {
+static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_SYS_26M, "sys_26m", "clk26m", 1,
 		1),
 	FACTOR(CLK_TOP_CLK26M_D2, "clk26m_d2", "sys_26m", 1,
 		2),
-};
-
-static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_ARMCA35PLL, "armca35pll_ck", "armca35pll", 1,
 		1),
 	FACTOR(CLK_TOP_ARMCA35PLL_600M, "armca35pll_600m", "armca35pll_ck", 1,
@@ -1295,114 +1292,30 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static struct clk_hw_onecell_data *top_clk_data;
-
-static void clk_mt2712_top_init_early(struct device_node *node)
-{
-	int r, i;
-
-	if (!top_clk_data) {
-		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-
-		for (i = 0; i < CLK_TOP_NR_CLK; i++)
-			top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-	}
-
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
-			top_clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-
-CLK_OF_DECLARE_DRIVER(mt2712_topckgen, "mediatek,mt2712-topckgen",
-			clk_mt2712_top_init_early);
-
-static int clk_mt2712_top_probe(struct platform_device *pdev)
-{
-	int r, i;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return PTR_ERR(base);
-	}
-
-	if (!top_clk_data) {
-		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	} else {
-		for (i = 0; i < CLK_TOP_NR_CLK; i++) {
-			if (top_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
-				top_clk_data->hws[i] = ERR_PTR(-ENOENT);
-		}
-	}
-
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-			top_clk_data);
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
-			top_clk_data);
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	mtk_clk_register_composites(&pdev->dev, top_muxes,
-				    ARRAY_SIZE(top_muxes), base,
-				    &mt2712_clk_lock, top_clk_data);
-	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
-			&mt2712_clk_lock, top_clk_data);
-	mtk_clk_register_gates(&pdev->dev, node, top_clks,
-			       ARRAY_SIZE(top_clks), top_clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
-
-static int clk_mt2712_mcu_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return PTR_ERR(base);
-	}
-
-	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
-
-	r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
-					ARRAY_SIZE(mcu_muxes), base,
-					&mt2712_clk_lock, clk_data);
-	if (r)
-		dev_err(&pdev->dev, "Could not register composites: %d\n", r);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static const struct mtk_clk_desc topck_desc = {
+	.clks = top_clks,
+	.num_clks = ARRAY_SIZE(top_clks),
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.divider_clks = top_adj_divs,
+	.num_divider_clks = ARRAY_SIZE(top_adj_divs),
+	.clk_lock = &mt2712_clk_lock,
+};
 
-	return r;
-}
+static const struct mtk_clk_desc mcu_desc = {
+	.composite_clks = mcu_muxes,
+	.num_composite_clks = ARRAY_SIZE(mcu_muxes),
+	.clk_lock = &mt2712_clk_lock,
+};
 
 static const struct of_device_id of_match_clk_mt2712[] = {
 	{
 		.compatible = "mediatek,mt2712-apmixedsys",
 		.data = clk_mt2712_apmixed_probe,
-	}, {
-		.compatible = "mediatek,mt2712-topckgen",
-		.data = clk_mt2712_top_probe,
-	}, {
-		.compatible = "mediatek,mt2712-mcucfg",
-		.data = clk_mt2712_mcu_probe,
 	}, {
 		/* sentinel */
 	}
@@ -1440,7 +1353,9 @@ static const struct mtk_clk_desc peri_desc = {
 
 static const struct of_device_id of_match_clk_mt2712_simple[] = {
 	{ .compatible = "mediatek,mt2712-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt2712-mcucfg", .data = &mcu_desc },
 	{ .compatible = "mediatek,mt2712-pericfg", .data = &peri_desc, },
+	{ .compatible = "mediatek,mt2712-topckgen", .data = &topck_desc },
 	{ /* sentinel */ }
 };
 
-- 
2.39.1

