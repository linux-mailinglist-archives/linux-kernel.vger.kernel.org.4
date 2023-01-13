Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD36695B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbjAMLeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjAMLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:33:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C9D48CCD;
        Fri, 13 Jan 2023 03:07:29 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A85C6602DD1;
        Fri, 13 Jan 2023 11:07:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673608048;
        bh=A8I1jqefmTvU9+UZLVUvTYNGEnYvAvvH+scEzl+ZytQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiIUYp0BcKvBWh6A5fatJsi868VFG5rgBfipSrV46iF9Z979YOSR8IxUiCtMl5ZJP
         m9wD4oqMxO2eF09V55qTF1xpuqWxzxB5PXUAVUUPQlf+J+ecSlzjIAz8RNh3jyZMIq
         eCHWm1XRoD947G3E5HT7YtulrrYo5yi/M9u3xQK8eBr4cf544IBND/EipS2anIWC5Q
         HSmxlkJTz/aGlszcelL3KzfhKrWT1jP8PH9xtz1iqEHAz8Rfzlw6aZdFgB4msFY+Zz
         SS0IqonmJqrq7k9VIvZUy7v1ZdFJgnLN0CmcJfEpaxEa7WgWWDpqHPDgj+5tvn3kK8
         VBRsO4keskMwg==
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
Subject: [PATCH v3 19/23] clk: mediatek: clk-mt8192: Migrate topckgen to mtk_clk_simple_probe()
Date:   Fri, 13 Jan 2023 12:06:12 +0100
Message-Id: <20230113110616.111001-20-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
References: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
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

Since the common simple probe function for MediaTek clock drivers can
now register the MFG MUX notifier, it's possible to migrate MT8192's
topckgen to that, allowing for some code size reduction.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8192.c | 85 +++++++------------------------
 1 file changed, 17 insertions(+), 68 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 1ffff53bbe90..61299960d28a 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1064,71 +1064,6 @@ static int clk_mt8192_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
 	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
 }
 
-static int clk_mt8192_top_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *top_clk_data;
-	int r;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	if (!top_clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-	if (r)
-		return r;
-
-	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	if (r)
-		goto unregister_fixed_clks;
-
-	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
-				   ARRAY_SIZE(top_mtk_muxes), node,
-				   &mt8192_clk_lock, top_clk_data);
-	if (r)
-		goto unregister_factors;
-
-	r = mtk_clk_register_composites(&pdev->dev, top_muxes,
-					ARRAY_SIZE(top_muxes), base,
-					&mt8192_clk_lock, top_clk_data);
-	if (r)
-		goto unregister_muxes;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
-				   ARRAY_SIZE(top_clks), top_clk_data);
-	if (r)
-		goto unregister_top_composites;
-
-	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
-					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
-	if (r)
-		goto unregister_gates;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
-	if (r)
-		goto unregister_gates;
-
-	return 0;
-
-unregister_gates:
-	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
-unregister_top_composites:
-	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
-unregister_muxes:
-	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
-unregister_factors:
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-unregister_fixed_clks:
-	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-				      top_clk_data);
-	return r;
-}
-
 static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -1162,9 +1097,6 @@ static const struct of_device_id of_match_clk_mt8192[] = {
 	{
 		.compatible = "mediatek,mt8192-apmixedsys",
 		.data = clk_mt8192_apmixed_probe,
-	}, {
-		.compatible = "mediatek,mt8192-topckgen",
-		.data = clk_mt8192_top_probe,
 	}, {
 		/* sentinel */
 	}
@@ -1197,9 +1129,26 @@ static const struct mtk_clk_desc peri_desc = {
 	.num_clks = ARRAY_SIZE(peri_clks),
 };
 
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_mtk_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_mtk_muxes),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.clks = top_clks,
+	.num_clks = ARRAY_SIZE(top_clks),
+	.clk_lock = &mt8192_clk_lock,
+	.clk_notifier_func = clk_mt8192_reg_mfg_mux_notifier,
+	.mfg_clk_idx = CLK_TOP_MFG_PLL_SEL,
+};
+
 static const struct of_device_id of_match_clk_mt8192_simple[] = {
 	{ .compatible = "mediatek,mt8192-infracfg", .data = &infra_desc },
 	{ .compatible = "mediatek,mt8192-pericfg", .data = &peri_desc },
+	{ .compatible = "mediatek,mt8192-topckgen", .data = &topck_desc },
 	{ /* sentinel */ }
 };
 
-- 
2.39.0

