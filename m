Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC296750C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjATJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjATJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:21:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10C95169;
        Fri, 20 Jan 2023 01:21:12 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62E296602DD4;
        Fri, 20 Jan 2023 09:21:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206467;
        bh=vFjWiqN0B/e1baxTrKbvEl8fqxld91Vb6UUPEYCcHy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfBA/0cxsQXTwnquNudMq3w/o5IX9/GDiNJCW1XAtnUHOTm8UTBr+59YWQidXUN0y
         NoBgUG6a+lRlugh7gE1PTX5c5voQiUY+XK973fqcP4xBP46Md9c/g3Ipm46Y0mOV9u
         qtagzXk/DqawDT8GZ4A36mwhELBaV5I127Xmtl9XnYfNVGgxhF/9n3ekTbU9d41rTh
         QpnFNdNkBkd1iwZn007s3myXEzket8J8WanAs0Nw+nrbfdR3Y4hFWaTc2mGWPogMBu
         XT5wsya+w6pjbN/G3FoNSYcrqPlxCL+MBJw+T1W8auCmDJW334frpUVIhFUgG1o0Wc
         nMzS8l41IW5EQ==
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
Subject: [PATCH v4 05/23] clk: mediatek: clk-mtk: Propagate struct device for composites
Date:   Fri, 20 Jan 2023 10:20:35 +0100
Message-Id: <20230120092053.182923-6-angelogioacchino.delregno@collabora.com>
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

Like done for cpumux clocks, propagate struct device for composite
clocks registered through clk-mtk helpers to be able to get runtime
pm support for MTK clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701.c          | 10 ++++++----
 drivers/clk/mediatek/clk-mt2712.c          | 12 ++++++++----
 drivers/clk/mediatek/clk-mt6779.c          | 10 ++++++----
 drivers/clk/mediatek/clk-mt6795-pericfg.c  |  3 ++-
 drivers/clk/mediatek/clk-mt6795-topckgen.c |  3 ++-
 drivers/clk/mediatek/clk-mt6797.c          |  3 ++-
 drivers/clk/mediatek/clk-mt7622.c          |  8 +++++---
 drivers/clk/mediatek/clk-mt7629.c          |  8 +++++---
 drivers/clk/mediatek/clk-mt8135.c          | 10 ++++++----
 drivers/clk/mediatek/clk-mt8167.c          | 10 ++++++----
 drivers/clk/mediatek/clk-mt8173.c          | 10 ++++++----
 drivers/clk/mediatek/clk-mt8183.c          | 15 +++++++++------
 drivers/clk/mediatek/clk-mt8186-mcu.c      |  3 ++-
 drivers/clk/mediatek/clk-mt8186-topckgen.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8192.c          |  6 ++++--
 drivers/clk/mediatek/clk-mt8195-topckgen.c |  3 ++-
 drivers/clk/mediatek/clk-mt8365.c          |  7 ++++---
 drivers/clk/mediatek/clk-mt8516.c          | 10 ++++++----
 drivers/clk/mediatek/clk-mtk.c             | 11 ++++++-----
 drivers/clk/mediatek/clk-mtk.h             |  3 ++-
 20 files changed, 93 insertions(+), 58 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 3d56ab25aeac..06ca81359d35 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -683,8 +683,9 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 								clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				base, &mt2701_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt2701_clk_lock, clk_data);
 
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt2701_clk_lock, clk_data);
@@ -921,8 +922,9 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
 			       ARRAY_SIZE(peri_clks), clk_data);
 
-	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
-			&mt2701_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, peri_muxs,
+				    ARRAY_SIZE(peri_muxs), base,
+				    &mt2701_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 6260cdcd18c4..c483a7ad64fe 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1346,8 +1346,9 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
 			top_clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt2712_clk_lock, top_clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 			&mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_gates(&pdev->dev, node, top_clks,
@@ -1421,8 +1422,11 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
 
-	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-			&mt2712_clk_lock, clk_data);
+	r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+					ARRAY_SIZE(mcu_muxes), base,
+					&mt2712_clk_lock, clk_data);
+	if (r)
+		dev_err(&pdev->dev, "Could not register composites: %d\n", r);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 559d4d596e0c..a1c387d9731a 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1247,11 +1247,13 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
 			       node, &mt6779_clk_lock, clk_data);
 
-	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-				    base, &mt6779_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
+				    ARRAY_SIZE(top_aud_muxes), base,
+				    &mt6779_clk_lock, clk_data);
 
-	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-				    base, &mt6779_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_divs,
+				    ARRAY_SIZE(top_aud_divs), base,
+				    &mt6779_clk_lock, clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index f69e715e0c1f..08aaa9b09c36 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -114,7 +114,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
+	ret = mtk_clk_register_composites(&pdev->dev, peri_clks,
+					  ARRAY_SIZE(peri_clks), base,
 					  &mt6795_peri_clk_lock, clk_data);
 	if (ret)
 		goto unregister_gates;
diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index 8b8307635a35..62beca56ee01 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -557,7 +557,8 @@ static int clk_mt6795_topckgen_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_factors;
 
-	ret = mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), base,
+	ret = mtk_clk_register_composites(&pdev->dev, top_aud_divs,
+					  ARRAY_SIZE(top_aud_divs), base,
 					  &mt6795_top_clk_lock, clk_data);
 	if (ret)
 		goto unregister_muxes;
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 2052ba4261b3..105a512857b3 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -396,7 +396,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 				 clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
 				    &mt6797_clk_lock, clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index a51a6ed9c4b8..5a82c2270bfb 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -646,8 +646,9 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
 				 clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				    base, &mt7622_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt7622_clk_lock, clk_data);
 
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				  base, &mt7622_clk_lock, clk_data);
@@ -723,7 +724,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
 			       ARRAY_SIZE(peri_clks), clk_data);
 
-	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
+	mtk_clk_register_composites(&pdev->dev, peri_muxes,
+				    ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 0fa158d61a29..cf062d4a7ecc 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -588,8 +588,9 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
 				 clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				    base, &mt7629_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt7629_clk_lock, clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
@@ -631,7 +632,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
 			       ARRAY_SIZE(peri_clks), clk_data);
 
-	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
+	mtk_clk_register_composites(&pdev->dev, peri_muxes,
+				    ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 05963fd76ee9..2b9c925c2a2b 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -548,8 +548,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8135_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8135_clk_lock, clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_CCI_SEL]->clk);
 
@@ -597,8 +598,9 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	mtk_clk_register_gates(NULL, node, peri_gates,
 			       ARRAY_SIZE(peri_gates), clk_data);
-	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8135_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, peri_clks,
+				    ARRAY_SIZE(peri_clks), base,
+				    &mt8135_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 59fe82ba5c7a..91669ebafaf9 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -940,8 +940,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-		&mt8167_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8167_clk_lock, clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8167_clk_lock, clk_data);
 
@@ -966,8 +967,9 @@ static void __init mtk_infracfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
-	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
-		&mt8167_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, ifr_muxes,
+				    ARRAY_SIZE(ifr_muxes), base,
+				    &mt8167_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 767368463ec5..e3786fd64726 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -869,8 +869,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8173_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8173_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -920,8 +921,9 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	mtk_clk_register_gates(NULL, node, peri_gates,
 			       ARRAY_SIZE(peri_gates), clk_data);
-	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8173_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, peri_clks,
+				    ARRAY_SIZE(peri_clks), base,
+				    &mt8173_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index efee904217dc..34374b2862ac 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1169,11 +1169,13 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
 		node, &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-		base, &mt8183_clk_lock, top_clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
+				    ARRAY_SIZE(top_aud_muxes), base,
+				    &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-		base, &mt8183_clk_lock, top_clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_divs,
+				    ARRAY_SIZE(top_aud_divs), base,
+				    &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_gates(&pdev->dev, node, top_clks,
 			       ARRAY_SIZE(top_clks), top_clk_data);
@@ -1236,8 +1238,9 @@ static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
 
-	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-			&mt8183_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+				    ARRAY_SIZE(mcu_muxes), base,
+				    &mt8183_clk_lock, clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index dfc305c1fc5d..e52a2d986c99 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -65,7 +65,8 @@ static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 		goto free_mcu_data;
 	}
 
-	r = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
+	r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+					ARRAY_SIZE(mcu_muxes), base,
 					NULL, clk_data);
 	if (r)
 		goto free_mcu_data;
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index c2beda7ef976..9344c09136ee 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -742,12 +742,14 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_factors;
 
-	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_muxes,
+					ARRAY_SIZE(top_muxes), base,
 					&mt8186_clk_lock, clk_data);
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_adj_divs,
+					ARRAY_SIZE(top_adj_divs), base,
 					&mt8186_clk_lock, clk_data);
 	if (r)
 		goto unregister_composite_muxes;
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index eb53d0fc47e3..2d04218e6806 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1117,12 +1117,14 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_factors;
 
-	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_muxes,
+					ARRAY_SIZE(top_muxes), base,
 					&mt8192_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_adj_divs,
+					ARRAY_SIZE(top_adj_divs), base,
 					&mt8192_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_top_composites;
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index d8c9166d00f4..8202e7272f12 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1281,7 +1281,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_adj_divs,
+					ARRAY_SIZE(top_adj_divs), base,
 					&mt8195_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_muxes;
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index b30cbeae1c3d..0482a8aa43cc 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -952,7 +952,7 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_factors;
 
-	ret = mtk_clk_register_composites(top_misc_mux_gates,
+	ret = mtk_clk_register_composites(&pdev->dev, top_misc_mux_gates,
 					  ARRAY_SIZE(top_misc_mux_gates), base,
 					  &mt8365_clk_lock, clk_data);
 	if (ret)
@@ -1080,8 +1080,9 @@ static int clk_mt8365_mcu_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes),
-					  base, &mt8365_clk_lock, clk_data);
+	ret = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+					  ARRAY_SIZE(mcu_muxes), base,
+					  &mt8365_clk_lock, clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index c10979905f11..2c0cae7b3bcf 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -694,8 +694,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-		&mt8516_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8516_clk_lock, clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8516_clk_lock, clk_data);
 
@@ -720,8 +721,9 @@ static void __init mtk_infracfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
-	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
-		&mt8516_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, ifr_muxes,
+				    ARRAY_SIZE(ifr_muxes), base,
+				    &mt8516_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index fe44a729b4f4..cf2f465ecf22 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -197,8 +197,8 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
 
-static struct clk_hw *mtk_clk_register_composite(const struct mtk_composite *mc,
-		void __iomem *base, spinlock_t *lock)
+static struct clk_hw *mtk_clk_register_composite(struct device *dev,
+		const struct mtk_composite *mc, void __iomem *base, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 	struct clk_mux *mux = NULL;
@@ -264,7 +264,7 @@ static struct clk_hw *mtk_clk_register_composite(const struct mtk_composite *mc,
 		div_ops = &clk_divider_ops;
 	}
 
-	hw = clk_hw_register_composite(NULL, mc->name, parent_names, num_parents,
+	hw = clk_hw_register_composite(dev, mc->name, parent_names, num_parents,
 		mux_hw, mux_ops,
 		div_hw, div_ops,
 		gate_hw, gate_ops,
@@ -308,7 +308,8 @@ static void mtk_clk_unregister_composite(struct clk_hw *hw)
 	kfree(mux);
 }
 
-int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
+int mtk_clk_register_composites(struct device *dev,
+				const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
 				struct clk_hw_onecell_data *clk_data)
 {
@@ -327,7 +328,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 			continue;
 		}
 
-		hw = mtk_clk_register_composite(mc, base, lock);
+		hw = mtk_clk_register_composite(dev, mc, base, lock);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mc->name,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f2db6b57d5b5..cd97d2722380 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -154,7 +154,8 @@ struct mtk_composite {
 		.flags = 0,						\
 	}
 
-int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
+int mtk_clk_register_composites(struct device *dev,
+				const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
 				struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
-- 
2.39.0

