Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478596750ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjATJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjATJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:22:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC794CB7;
        Fri, 20 Jan 2023 01:21:54 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45DC06602FA0;
        Fri, 20 Jan 2023 09:21:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206494;
        bh=mSaL+tk5NnlZ0CFxycF9bNaEJv21sxA1ml6TJybXbpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZdQop8+hf5QzVBcbSNniWWdE7xOm+lFdgmb2wr4GAy63j1Y/MD1kvzfGgXLPpI3J
         Lw6ss8cyEq+dqn1DvCX41qXV9ap+FGaYzrQ+rOKatJ7Cj5yJq/+NhiTYVEQVCZKpr5
         sXTe2XSqqA+zMejnP6oyAl9QNkziBQfSmLv5bqRhgAGpaKDzystu1m+m0Nuc9MHShO
         AvYZBfYU6Z2Nap+P82dk6+9f9ub/q2O4dGO5ft2UccJ48skLxCvszkTq1y8KdrJlPS
         uDXeztiqsLwzf9UdhCGAn2eYgCVs5sNqEZLOTG/m1PthWfFmLzk72DKrxNJHf3D2FA
         52JnYJ+UAuYEQ==
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
Subject: [PATCH v4 21/23] clk: mediatek: clk-mt6795-topckgen: Migrate to mtk_clk_simple_probe()
Date:   Fri, 20 Jan 2023 10:20:51 +0100
Message-Id: <20230120092053.182923-22-angelogioacchino.delregno@collabora.com>
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

Migrate away from custom probe functions and use the commonized
mtk_clk_simple_{probe, remove}().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt6795-topckgen.c | 86 ++++------------------
 1 file changed, 14 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index 65fd8aa69afd..e80fa588e309 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -523,88 +523,30 @@ static struct mtk_composite top_aud_divs[] = {
 	DIV_GATE(CLK_TOP_APLL2_DIV5, "apll2_div5", "apll2_div4", 0x12c, 21, 0x12c, 4, 4),
 };
 
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.composite_clks = top_aud_divs,
+	.num_composite_clks = ARRAY_SIZE(top_aud_divs),
+	.clk_lock = &mt6795_top_clk_lock,
+};
 
 static const struct of_device_id of_match_clk_mt6795_topckgen[] = {
-	{ .compatible = "mediatek,mt6795-topckgen" },
+	{ .compatible = "mediatek,mt6795-topckgen", .data = &topck_desc },
 	{ /* sentinel */ }
 };
 
-static int clk_mt6795_topckgen_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	if (ret)
-		goto unregister_fixed_clks;
-
-	ret = mtk_clk_register_muxes(&pdev->dev, top_muxes,
-				     ARRAY_SIZE(top_muxes), node,
-				     &mt6795_top_clk_lock, clk_data);
-	if (ret)
-		goto unregister_factors;
-
-	ret = mtk_clk_register_composites(&pdev->dev, top_aud_divs,
-					  ARRAY_SIZE(top_aud_divs), base,
-					  &mt6795_top_clk_lock, clk_data);
-	if (ret)
-		goto unregister_muxes;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_composites;
-
-	return 0;
-
-unregister_composites:
-	mtk_clk_unregister_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), clk_data);
-unregister_muxes:
-	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
-unregister_factors:
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-unregister_fixed_clks:
-	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return ret;
-}
-
-static int clk_mt6795_topckgen_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), clk_data);
-	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
-
 static struct platform_driver clk_mt6795_topckgen_drv = {
 	.driver = {
 		.name = "clk-mt6795-topckgen",
 		.of_match_table = of_match_clk_mt6795_topckgen,
 	},
-	.probe = clk_mt6795_topckgen_probe,
-	.remove = clk_mt6795_topckgen_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_topckgen_drv);
 
-- 
2.39.0

