Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261D654ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiLWJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiLWJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:45:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B63B430;
        Fri, 23 Dec 2022 01:43:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CEDF6602D23;
        Fri, 23 Dec 2022 09:43:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788620;
        bh=PXg/FppXIPAwQaA1oQS+Wf5hDsh7ZOHb0BNVjLOTW5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyCKHsYiwTJfdyb3tvjNEKRy9srzOulk2Ya2MQx/rDCK3OE5uc+cBwsh93H/RW/Nh
         S3lKvRxus8aICClNWQ2ZmgBMk4Z4bnuku9jB/WTulPVZCkDJTjoqP3RlMysZVaIf1g
         0F4ha/KiKMLidSJRb28cfjaXcxo1ZkdE5NioJxeTeRZXV6QwQthoIWpcQpvrskgwl/
         gyfXdje9yNZYqE4juN/dCQFoFEXHBQ1qJmk3Lh2LpQ/11G1XQnaehn/mtw+Mmgl+NE
         M2zOt9WpwgxElRPdvIAPwYHte89xuHCum3hLilf5io2BSkGGLJwhzPuAoj9ETOKQVp
         tr5uUzfwS/Q9A==
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
Subject: [PATCH v2 23/23] clk: mediatek: clk-mt7986-topckgen: Migrate to mtk_clk_simple_probe()
Date:   Fri, 23 Dec 2022 10:42:59 +0100
Message-Id: <20221223094259.87373-24-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
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

There are no more non-common calls in clk_mt7986_topckgen_probe():
migrate this driver to mtk_clk_simple_probe().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 52 +++++-----------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index bf3088e6d9e3..286418aa00a0 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -290,52 +290,24 @@ static const struct mtk_mux top_muxes[] = {
 			     0x1C4, 5),
 };
 
-static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-	void __iomem *base;
-	int nr = ARRAY_SIZE(top_fixed_clks) + ARRAY_SIZE(top_divs) +
-		 ARRAY_SIZE(top_muxes);
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return -ENOMEM;
-	}
-
-	clk_data = mtk_alloc_clk_data(nr);
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-				    clk_data);
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
-			       &mt7986_clk_lock, clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r) {
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-		goto free_topckgen_data;
-	}
-	return r;
-
-free_topckgen_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.clk_lock = &mt7986_clk_lock,
+};
 
 static const struct of_device_id of_match_clk_mt7986_topckgen[] = {
-	{ .compatible = "mediatek,mt7986-topckgen", },
+	{ .compatible = "mediatek,mt7986-topckgen", .data = &topck_desc },
 	{}
 };
 
 static struct platform_driver clk_mt7986_topckgen_drv = {
-	.probe = clk_mt7986_topckgen_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7986-topckgen",
 		.of_match_table = of_match_clk_mt7986_topckgen,
-- 
2.39.0

