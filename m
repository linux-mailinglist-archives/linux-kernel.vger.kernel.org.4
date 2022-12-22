Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E79C654079
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiLVL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiLVLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:55:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE42EF81;
        Thu, 22 Dec 2022 03:49:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40C1D6602CF8;
        Thu, 22 Dec 2022 11:49:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709790;
        bh=v4bpRy6DKVod2vAuX1EyO2724COnQa/afh1pvd8ocYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrsQLoJofTCMYgIJrQfyPkRSDYicPjNPBtaKkJa/r8n75WbEuah3G+kP+KIMamQ4D
         cvQ5Znz8ycsOGwOKR04Prl57jgCHjQaHzy6Au5ixDG25y2Xt3416psh7SZ7y/auuWg
         7WP8dT7jrRao8oP5+P5BQWoqk3XmIXq+pExfMGV7XiZwcehPQBVosjhlltQm+Y6bLP
         mOkkKTkC7iZ5IcUzEVbYKHJoc9wo6uxFUMq51iT0dDT6ZM7zKfIwl4AixgVfFerjz1
         pmQjEEPGgHmg6bPwLYuuu0kNGSGYE+viCJ9guutyy7Q+Nu9V4bkKibkvry8gFoE1L9
         48Y3kqNMpIMcg==
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
Subject: [PATCH v1 21/25] clk: mediatek: clk-mt8192: Migrate topckgen to mtk_clk_simple_probe()
Date:   Thu, 22 Dec 2022 12:48:53 +0100
Message-Id: <20221222114857.120060-22-angelogioacchino.delregno@collabora.com>
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

Since the common simple probe function for MediaTek clock drivers can
now register the MFG MUX notifier, it's possible to migrate MT8192's
topckgen to that, allowing for some code size reduction.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 80 +++++++------------------------
 1 file changed, 17 insertions(+), 63 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 702770326286..adde457e6277 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1064,66 +1064,6 @@ static int clk_mt8192_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
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
-		return;
-
-	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-	if (r)
-		return r;
-
-	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	if (r)
-		goto unregister_fixed_clks;
-
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
-				   &mt8192_clk_lock, top_clk_data, &pdev->dev);
-	if (r)
-		goto unregister_factors;
-
-	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-					&mt8192_clk_lock, top_clk_data, &pdev->dev);
-	if (r)
-		goto unregister_muxes;
-
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-					    top_clk_data, &pdev->dev);
-	if (r)
-		goto unregister_top_composites;
-
-	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
-					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
-	if (r)
-		goto unregister_gates;
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				      top_clk_data);
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
@@ -1158,9 +1098,6 @@ static const struct of_device_id of_match_clk_mt8192[] = {
 	{
 		.compatible = "mediatek,mt8192-apmixedsys",
 		.data = clk_mt8192_apmixed_probe,
-	}, {
-		.compatible = "mediatek,mt8192-topckgen",
-		.data = clk_mt8192_top_probe,
 	}, {
 		/* sentinel */
 	}
@@ -1193,9 +1130,26 @@ static const struct mtk_clk_desc peri_desc = {
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

