Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC647654E99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiLWJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiLWJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:43:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926563578D;
        Fri, 23 Dec 2022 01:43:15 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CCDC6602CE6;
        Fri, 23 Dec 2022 09:43:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788594;
        bh=BJpeugsotBsLMOM6SD/PFiXg/IwoTPpVagtQf6A2tuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKh0btc7UyS0//R5o9OAZFgffMmuz4txIhkxzz2BkcBwpWgY8/+fFNX/19tT3mVzZ
         FUI29syb703TcFdfw0glNBR9YhvaLE1bcWavDbXZgsAwFl73mzzi7EPhuyPiR1Hkyl
         BiZHL4I4dDYLK3y5haD+MfIG8i4fjML4wtxEHEDB4Ccta+IQMIZCz60W1HB0EtnzXE
         N2UpB/m/ZSRnJtbMhCMvQrIkYZyel66tntqOQ7VHd83leo7ep9pm+iDIisf/k2tcAl
         +083ZDDUSCZTkSsvJKWuqdCiIYwWZUXjFDq1gmC4BG9y4mrGjaKU/S8XJuldarYIsf
         Or5arUwU63cZg==
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
Subject: [PATCH v2 05/23] clk: mediatek: clk-mtk: Propagate struct device for composites
Date:   Fri, 23 Dec 2022 10:42:41 +0100
Message-Id: <20221223094259.87373-6-angelogioacchino.delregno@collabora.com>
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

Like done for cpumux clocks, propagate struct device for composite
clocks registered through clk-mtk helpers to be able to get runtime
pm support for MTK clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701.c          | 4 ++--
 drivers/clk/mediatek/clk-mt2712.c          | 4 ++--
 drivers/clk/mediatek/clk-mt6779.c          | 4 ++--
 drivers/clk/mediatek/clk-mt6795-pericfg.c  | 2 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c | 2 +-
 drivers/clk/mediatek/clk-mt6797.c          | 2 +-
 drivers/clk/mediatek/clk-mt7622.c          | 5 +++--
 drivers/clk/mediatek/clk-mt7629.c          | 4 ++--
 drivers/clk/mediatek/clk-mt8135.c          | 4 ++--
 drivers/clk/mediatek/clk-mt8167.c          | 4 ++--
 drivers/clk/mediatek/clk-mt8173.c          | 4 ++--
 drivers/clk/mediatek/clk-mt8183.c          | 6 +++---
 drivers/clk/mediatek/clk-mt8186-mcu.c      | 2 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 4 ++--
 drivers/clk/mediatek/clk-mt8192.c          | 4 ++--
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 2 +-
 drivers/clk/mediatek/clk-mt8365.c          | 5 +++--
 drivers/clk/mediatek/clk-mt8516.c          | 4 ++--
 drivers/clk/mediatek/clk-mtk.c             | 9 +++++----
 drivers/clk/mediatek/clk-mtk.h             | 3 ++-
 20 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index dcae25778817..bd62acb5d697 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -684,7 +684,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 								clk_data);
 
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				base, &mt2701_clk_lock, clk_data);
+				base, &mt2701_clk_lock, clk_data, &pdev->dev);
 
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt2701_clk_lock, clk_data);
@@ -922,7 +922,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 			       clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
-			&mt2701_clk_lock, clk_data);
+			&mt2701_clk_lock, clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 24ec3384c429..5cadcf6ca9b7 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1347,7 +1347,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 			top_clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt2712_clk_lock, top_clk_data);
+			&mt2712_clk_lock, top_clk_data, &pdev->dev);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 			&mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
@@ -1422,7 +1422,7 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
 
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-			&mt2712_clk_lock, clk_data);
+			&mt2712_clk_lock, clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 622a2fc6c167..825f2f57e868 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1248,10 +1248,10 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 			       node, &mt6779_clk_lock, clk_data);
 
 	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-				    base, &mt6779_clk_lock, clk_data);
+				    base, &mt6779_clk_lock, clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-				    base, &mt6779_clk_lock, clk_data);
+				    base, &mt6779_clk_lock, clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index 479a8abcb80b..1fc80bc1592b 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -115,7 +115,7 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 		goto free_clk_data;
 
 	ret = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-					  &mt6795_peri_clk_lock, clk_data);
+					  &mt6795_peri_clk_lock, clk_data, &pdev->dev);
 	if (ret)
 		goto unregister_gates;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index 8b8307635a35..bb232e1726f1 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -558,7 +558,7 @@ static int clk_mt6795_topckgen_probe(struct platform_device *pdev)
 		goto unregister_factors;
 
 	ret = mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), base,
-					  &mt6795_top_clk_lock, clk_data);
+					  &mt6795_top_clk_lock, clk_data, &pdev->dev);
 	if (ret)
 		goto unregister_muxes;
 
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 250ac8bd6a3c..581bc7d9f66d 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -397,7 +397,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 				 clk_data);
 
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-				    &mt6797_clk_lock, clk_data);
+				    &mt6797_clk_lock, clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index adf3b4535170..fb4e2552ba76 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -647,7 +647,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 				 clk_data);
 
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				    base, &mt7622_clk_lock, clk_data);
+				    base, &mt7622_clk_lock, clk_data,
+				    &pdev->dev);
 
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				  base, &mt7622_clk_lock, clk_data);
@@ -725,7 +726,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 			       clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
-				    &mt7622_clk_lock, clk_data);
+				    &mt7622_clk_lock, clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 48bc4a6705fb..890f1944565e 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -589,7 +589,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 				 clk_data);
 
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				    base, &mt7629_clk_lock, clk_data);
+				    base, &mt7629_clk_lock, clk_data, &pdev->dev);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
@@ -632,7 +632,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 			       clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
-				    &mt7629_clk_lock, clk_data);
+				    &mt7629_clk_lock, clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 7193ab38090d..253fe271ee97 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -549,7 +549,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8135_clk_lock, clk_data);
+			&mt8135_clk_lock, clk_data, NULL);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_CCI_SEL]->clk);
 
@@ -598,7 +598,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
 						clk_data, NULL);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8135_clk_lock, clk_data);
+			&mt8135_clk_lock, clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index b150f893a4b8..cc064e98643a 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -941,7 +941,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-		&mt8167_clk_lock, clk_data);
+		&mt8167_clk_lock, clk_data, NULL);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8167_clk_lock, clk_data);
 
@@ -967,7 +967,7 @@ static void __init mtk_infracfg_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
 	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
-		&mt8167_clk_lock, clk_data);
+		&mt8167_clk_lock, clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 125b01b9e2ab..617f68274004 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -870,7 +870,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8173_clk_lock, clk_data);
+			&mt8173_clk_lock, clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -921,7 +921,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
 			       clk_data, NULL);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8173_clk_lock, clk_data);
+			&mt8173_clk_lock, clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index f99c092476c2..194906ca4b5b 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1170,10 +1170,10 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 		node, &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-		base, &mt8183_clk_lock, top_clk_data);
+		base, &mt8183_clk_lock, top_clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-		base, &mt8183_clk_lock, top_clk_data);
+		base, &mt8183_clk_lock, top_clk_data, &pdev->dev);
 
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 		top_clk_data, &pdev->dev);
@@ -1237,7 +1237,7 @@ static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
 
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-			&mt8183_clk_lock, clk_data);
+			&mt8183_clk_lock, clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index dfc305c1fc5d..c4a5557cb830 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -66,7 +66,7 @@ static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 	}
 
 	r = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-					NULL, clk_data);
+					NULL, clk_data, &pdev->dev);
 	if (r)
 		goto free_mcu_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index c2beda7ef976..b79954a42481 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -743,12 +743,12 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 		goto unregister_factors;
 
 	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-					&mt8186_clk_lock, clk_data);
+					&mt8186_clk_lock, clk_data, &pdev->dev);
 	if (r)
 		goto unregister_muxes;
 
 	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
-					&mt8186_clk_lock, clk_data);
+					&mt8186_clk_lock, clk_data, &pdev->dev);
 	if (r)
 		goto unregister_composite_muxes;
 
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index e1b625b86911..27ad629062c4 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1118,12 +1118,12 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 		goto unregister_factors;
 
 	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-					&mt8192_clk_lock, top_clk_data);
+					&mt8192_clk_lock, top_clk_data, &pdev->dev);
 	if (r)
 		goto unregister_muxes;
 
 	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
-					&mt8192_clk_lock, top_clk_data);
+					&mt8192_clk_lock, top_clk_data, &pdev->dev);
 	if (r)
 		goto unregister_top_composites;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index ed604d39f9d5..437c12d19b03 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1282,7 +1282,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 		goto unregister_muxes;
 
 	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
-					&mt8195_clk_lock, top_clk_data);
+					&mt8195_clk_lock, top_clk_data, &pdev->dev);
 	if (r)
 		goto unregister_muxes;
 
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 5a43e5aad16e..00c15f89a5f6 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -954,7 +954,7 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 
 	ret = mtk_clk_register_composites(top_misc_mux_gates,
 					  ARRAY_SIZE(top_misc_mux_gates), base,
-					  &mt8365_clk_lock, clk_data);
+					  &mt8365_clk_lock, clk_data, &pdev->dev);
 	if (ret)
 		goto unregister_muxes;
 
@@ -1081,7 +1081,8 @@ static int clk_mt8365_mcu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes),
-					  base, &mt8365_clk_lock, clk_data);
+					  base, &mt8365_clk_lock, clk_data,
+					  &pdev->dev);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index a648ee463697..b50b2d1387b6 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -695,7 +695,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-		&mt8516_clk_lock, clk_data);
+		&mt8516_clk_lock, clk_data, NULL);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8516_clk_lock, clk_data);
 
@@ -721,7 +721,7 @@ static void __init mtk_infracfg_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
 	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
-		&mt8516_clk_lock, clk_data);
+		&mt8516_clk_lock, clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index e04eef7e2b6f..a1ab34305b95 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -198,7 +198,7 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
 
 static struct clk_hw *mtk_clk_register_composite(const struct mtk_composite *mc,
-		void __iomem *base, spinlock_t *lock)
+		void __iomem *base, spinlock_t *lock, struct device *dev)
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
@@ -310,7 +310,8 @@ static void mtk_clk_unregister_composite(struct clk_hw *hw)
 
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-				struct clk_hw_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data,
+				struct device *dev)
 {
 	struct clk_hw *hw;
 	int i;
@@ -327,7 +328,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 			continue;
 		}
 
-		hw = mtk_clk_register_composite(mc, base, lock);
+		hw = mtk_clk_register_composite(mc, base, lock, dev);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mc->name,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f2db6b57d5b5..15122504c02d 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -156,7 +156,8 @@ struct mtk_composite {
 
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-				struct clk_hw_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data,
+				struct device *dev);
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 				   struct clk_hw_onecell_data *clk_data);
 
-- 
2.39.0

