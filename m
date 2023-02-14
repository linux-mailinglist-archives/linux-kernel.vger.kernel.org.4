Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7A696513
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBNNnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjBNNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:42:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459229166;
        Tue, 14 Feb 2023 05:42:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F062C6602195;
        Tue, 14 Feb 2023 13:42:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382143;
        bh=hwCP7gm11+c1NQhko4awCeTIivbanjlzLRr2jrAHrXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4mY2Sx7hZX5CA8+15VgIubyaonje1tb+p3X1n7G0XaZ5CVkxDQ6au7lI99fIA2b/
         Ff1E8vnLdh1y5k5ciCsFxnez9lwMbsgr4StUxmuWcH8hHxMvbNCihkztiQ25ebSCog
         DHqzDX+c//JPD4Gyoo16q8CDJu9arokUp6uYqPTTm3NZXC5CKumX0EsSDVKACjGjhB
         gfu460IyTbFAq+boOtQdnWfm6TDMsfs6pKfR1XNppsQOqZ0Mw0Muk+YHmbjFKyPvUV
         t2Y+2icZ/3xmxT2BTmBwE2TyKFqrF3g2gsQ/WuNOtQafx/vWNbDPJhz8UnRqsouHS5
         suuxPTrAx0j5g==
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
Subject: [PATCH v2 31/47] clk: mediatek: mt7986-infracfg: Migrate to common probe mechanism
Date:   Tue, 14 Feb 2023 14:41:11 +0100
Message-Id: <20230214134127.59273-32-angelogioacchino.delregno@collabora.com>
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

Convert this driver to use the common mtk_clk_simple_probe() mechanism.
While at it, also use module_platform_driver() instead, as this driver
just gained a .remove() callback during the conversion.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 61 ++++++----------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index 0a4bf87ee160..0299faad0733 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -157,57 +157,30 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA2(CLK_INFRA_IPCIEB_CK, "infra_ipcieb", "sysaxi_sel", 15),
 };
 
-static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-	void __iomem *base;
-	int nr = ARRAY_SIZE(infra_divs) + ARRAY_SIZE(infra_muxes) +
-		 ARRAY_SIZE(infra_clks);
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return -ENOMEM;
-	}
-
-	clk_data = mtk_alloc_clk_data(nr);
-
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
-	mtk_clk_register_muxes(&pdev->dev, infra_muxes,
-			       ARRAY_SIZE(infra_muxes), node,
-			       &mt7986_clk_lock, clk_data);
-	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
-			       ARRAY_SIZE(infra_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-		goto free_infracfg_data;
-	}
-	return r;
-
-free_infracfg_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-
-}
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.factor_clks = infra_divs,
+	.num_factor_clks = ARRAY_SIZE(infra_divs),
+	.mux_clks = infra_muxes,
+	.num_mux_clks = ARRAY_SIZE(infra_muxes),
+	.clk_lock = &mt7986_clk_lock,
+};
 
 static const struct of_device_id of_match_clk_mt7986_infracfg[] = {
-	{ .compatible = "mediatek,mt7986-infracfg", },
-	{}
+	{ .compatible = "mediatek,mt7986-infracfg", .data = &infra_desc },
+	{ /* sentinel */ }
 };
 
 static struct platform_driver clk_mt7986_infracfg_drv = {
-	.probe = clk_mt7986_infracfg_probe,
 	.driver = {
 		.name = "clk-mt7986-infracfg",
 		.of_match_table = of_match_clk_mt7986_infracfg,
 	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
-builtin_platform_driver(clk_mt7986_infracfg_drv);
+module_platform_driver(clk_mt7986_infracfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7986 infracfg clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

