Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57477654037
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLVLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiLVLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:53:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B622B61D;
        Thu, 22 Dec 2022 03:49:21 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9EFC6602CD6;
        Thu, 22 Dec 2022 11:49:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709760;
        bh=xMZiAKwpe53kZFQbADFekhYR4L86oA0T01+MfIvvLHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1Xbs96oIBFmKl4BZg/5lT9Y9pQXveVEX+EevdFxtYDG5Vbm9XGGlMKtZX2S98aXw
         1rZkrtW8xBKNiPq1arfgpcd4OUQYrP/UwFyGnzY4XU6TNzTNVXvG5dj7W5966QmzeC
         fENpw+59z53RZntkuHdD0ahAZRUJv/MDtfQqYjUj6hlwviltpc0WJSi4wg3VEUIyNL
         eeq/v2mPQE9kNB2QXSKb5xk0pXZ5uaj49l2bsQTSfrUjb4/Yf39jcDxgBydsAAKd9m
         5+6JXZidHiqakBCgJ1HU7sdsJ4yLAKEdNwJNfFw1z3A497Ghj3VnpyntyJQR93yUSs
         0fCLr2h9LKECw==
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
Subject: [PATCH v1 03/25] clk: mediatek: clk-gate: Propagate struct device with mtk_clk_register_gates()
Date:   Thu, 22 Dec 2022 12:48:35 +0100
Message-Id: <20221222114857.120060-4-angelogioacchino.delregno@collabora.com>
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

Commit e4c23e19aa2a ("clk: mediatek: Register clock gate with device")
introduces a helper function for the sole purpose of propagating a
struct device pointer to the clk API when registering the mtk-gate
clocks to take advantage of Runtime PM when/where needed and where
a power domain is defined in devicetree.

Function mtk_clk_register_gates() then becomes a wrapper around the
new mtk_clk_register_gates_with_dev() function that will simply pass
NULL as struct device: this is essential when registering drivers
with CLK_OF_DECLARE instead of as a platform device, as there will
be no struct device to pass... but we can as well simply have only
one function that always takes such pointer as a param and pass NULL
when unavoidable.

This commit removes the mtk_clk_register_gates() wrapper and renames
mtk_clk_register_gates_with_dev() to the former and all of the calls
to either of the two functions were fixed in all drivers in order to
reflect this change.

Since a lot of MediaTek clock drivers are actually registering as a
platform device, but were still registering the mtk-gate clocks
without passing any struct device to the clock framework, they've
been changed to pass a valid one now, as to make all those platforms
able to use runtime power management where available.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c              | 16 ++++------------
 drivers/clk/mediatek/clk-gate.h              |  8 ++------
 drivers/clk/mediatek/clk-mt2701-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c        |  2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c        |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c        |  2 +-
 drivers/clk/mediatek/clk-mt2701-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt2701.c            |  6 +++---
 drivers/clk/mediatek/clk-mt2712-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt2712.c            |  6 +++---
 drivers/clk/mediatek/clk-mt6765.c            |  6 +++---
 drivers/clk/mediatek/clk-mt6779-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt6779.c            |  4 ++--
 drivers/clk/mediatek/clk-mt6795-infracfg.c   |  3 ++-
 drivers/clk/mediatek/clk-mt6795-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt6795-pericfg.c    |  3 ++-
 drivers/clk/mediatek/clk-mt6797-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt6797.c            |  2 +-
 drivers/clk/mediatek/clk-mt7622-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt7622-eth.c        |  4 ++--
 drivers/clk/mediatek/clk-mt7622-hif.c        |  4 ++--
 drivers/clk/mediatek/clk-mt7622.c            |  9 +++++----
 drivers/clk/mediatek/clk-mt7629-eth.c        |  5 +++--
 drivers/clk/mediatek/clk-mt7629-hif.c        |  4 ++--
 drivers/clk/mediatek/clk-mt7629.c            |  6 +++---
 drivers/clk/mediatek/clk-mt7986-eth.c        |  6 +++---
 drivers/clk/mediatek/clk-mt7986-infracfg.c   |  2 +-
 drivers/clk/mediatek/clk-mt8135.c            |  4 ++--
 drivers/clk/mediatek/clk-mt8167-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8167.c            |  2 +-
 drivers/clk/mediatek/clk-mt8173-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt8173.c            | 12 ++++++------
 drivers/clk/mediatek/clk-mt8183-audio.c      |  2 +-
 drivers/clk/mediatek/clk-mt8183-mm.c         |  2 +-
 drivers/clk/mediatek/clk-mt8183.c            |  8 ++++----
 drivers/clk/mediatek/clk-mt8186-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt8192-aud.c        |  3 ++-
 drivers/clk/mediatek/clk-mt8192-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt8192.c            | 12 ++++++------
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |  3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8365-mm.c         |  5 ++---
 drivers/clk/mediatek/clk-mt8365.c            |  2 +-
 drivers/clk/mediatek/clk-mt8516-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt8516.c            |  2 +-
 drivers/clk/mediatek/clk-mtk.c               |  4 ++--
 52 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 0c867136e49d..80deaabfd848 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -202,10 +202,10 @@ static void mtk_clk_unregister_gate(struct clk_hw *hw)
 	kfree(cg);
 }
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev)
+int mtk_clk_register_gates(struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_hw_onecell_data *clk_data,
+			   struct device *dev)
 {
 	int i;
 	struct clk_hw *hw;
@@ -261,14 +261,6 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 	return PTR_ERR(hw);
 }
-EXPORT_SYMBOL_GPL(mtk_clk_register_gates_with_dev);
-
-int mtk_clk_register_gates(struct device_node *node,
-			   const struct mtk_gate *clks, int num,
-			   struct clk_hw_onecell_data *clk_data)
-{
-	return mtk_clk_register_gates_with_dev(node, clks, num, clk_data, NULL);
-}
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index d9897ef53528..03053c2c2fdd 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -52,12 +52,8 @@ struct mtk_gate {
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-			   struct clk_hw_onecell_data *clk_data);
-
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev);
+			   struct clk_hw_onecell_data *clk_data,
+			   struct device *dev);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 			      struct clk_hw_onecell_data *clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 6ba398eb7df9..ab13ab618fb5 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -152,7 +152,7 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
 
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index edf1e2ed2b59..9670e1e170f2 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -58,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_ETHSYS_NR);
 
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-						clk_data);
+						clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1458109d99d9..11391b144267 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -52,7 +52,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_G3DSYS_NR);
 
 	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 434cbbe8c037..c14c0bb10f88 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -55,7 +55,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_HIFSYS_NR);
 
 	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
-						clk_data);
+						clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 9ea7abad99d2..ec5e516ca099 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -89,7 +89,7 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-						clk_data);
+						clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 9b442af37e67..dff69fabb171 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -690,7 +690,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 				base, &mt2701_clk_lock, clk_data);
 
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-						clk_data);
+			       clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -796,7 +796,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	}
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						infra_clk_data);
+			       infra_clk_data, &pdev->dev);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
@@ -919,7 +919,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-						clk_data);
+			       clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
 			&mt2701_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 7d44b09b8a0a..6c5f26a73476 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -136,7 +136,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+			clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 56980dd6c2ea..24ec3384c429 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1351,7 +1351,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 			&mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			top_clk_data);
+			top_clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 
@@ -1371,7 +1371,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			clk_data);
+			clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1393,7 +1393,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			clk_data);
+			clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index e9b9e6729733..7401693ef472 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -790,7 +790,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
 	mtk_clk_register_gates(node, apmixed_clks,
-			       ARRAY_SIZE(apmixed_clks), clk_data);
+			       ARRAY_SIZE(apmixed_clks), clk_data, &pdev->dev);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
@@ -829,7 +829,7 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
 			       &mt6765_clk_lock, clk_data);
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -863,7 +863,7 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
 	mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index eda8cbee3d23..101808b3e38f 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -94,7 +94,7 @@ static int clk_mt6779_mm_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 0d0a90ee5eb2..622a2fc6c167 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1222,7 +1222,7 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
 	mtk_clk_register_gates(node, apmixed_clks,
-			       ARRAY_SIZE(apmixed_clks), clk_data);
+			       ARRAY_SIZE(apmixed_clks), clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1264,7 +1264,7 @@ static int clk_mt6779_infra_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index df7eed6e071e..4bbd2bfe2ec4 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -101,7 +101,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates), clk_data);
+	ret = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates),
+				     clk_data, &pdev->dev);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index fd73f202f292..10a623b83f68 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -87,7 +87,8 @@ static int clk_mt6795_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates), clk_data);
+	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates),
+				     clk_data, &pdev->dev);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index cb28d35dad59..479a8abcb80b 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -109,7 +109,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+	ret = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
+				     clk_data, &pdev->dev);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 0846011fc894..dd96db5f2c0d 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -102,7 +102,7 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index b89f325a4b9b..250ac8bd6a3c 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -597,7 +597,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	}
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       infra_clk_data);
+			       infra_clk_data, &pdev->dev);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 				 infra_clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 9f2e5aa7b5d9..d0379d8704af 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -139,7 +139,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 43de0477d5d9..9b4a26ca0f44 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -82,7 +82,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
 
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -104,7 +104,7 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
 
 	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 67e96231dd25..8cf37f75ca77 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -93,7 +93,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -115,7 +115,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 3b55f8641fae..eab450fc824c 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -653,7 +653,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 				  base, &mt7622_clk_lock, clk_data);
 
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
@@ -671,7 +671,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -699,7 +699,8 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 			      clk_data);
 
 	mtk_clk_register_gates(node, apmixed_clks,
-			       ARRAY_SIZE(apmixed_clks), clk_data);
+			       ARRAY_SIZE(apmixed_clks), clk_data,
+			       &pdev->dev);
 
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
@@ -721,7 +722,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 282dd6559465..39aa9eb5355e 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -92,7 +92,8 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
 
-	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
+	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK,
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -115,7 +116,7 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
 
 	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 0c8b9e139789..44fbd88b4647 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -88,7 +88,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -110,7 +110,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index e4a08c811adc..2daceeab7fc4 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -606,7 +606,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -629,7 +629,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
@@ -656,7 +656,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 			      clk_data);
 
 	mtk_clk_register_gates(node, apmixed_clks,
-			       ARRAY_SIZE(apmixed_clks), clk_data);
+			       ARRAY_SIZE(apmixed_clks), clk_data, &pdev->dev);
 
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 7868c0728e96..765df117afa6 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -85,7 +85,7 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
 
 	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
-			       clk_data);
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -103,7 +103,7 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
 
 	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
-			       clk_data);
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -121,7 +121,7 @@ static void __init mtk_ethsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index 49666047bf0e..24947ccdb70a 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -193,7 +193,7 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
 			       &mt7986_clk_lock, clk_data);
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index b68888a034c4..7193ab38090d 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -568,7 +568,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+						clk_data, NULL);
 
 	clk_prepare_enable(clk_data->hws[CLK_INFRA_M4U]->clk);
 
@@ -596,7 +596,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
+						clk_data, NULL);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8135_clk_lock, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index ce1ae8d243c3..aa229aaf467f 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -55,7 +55,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index e359e563d2b7..1e592fa46c96 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -48,7 +48,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
+	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 4fd82fe87d6e..b494d04bc851 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -46,7 +46,7 @@ static void __init mtk_mfgcfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
+	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 73910060577f..5669b5eecca9 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -111,7 +111,7 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 	data = &mt8167_mmsys_driver_data;
 
 	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+				     clk_data, &pdev->dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index ee4fffb6859d..fcd6fdcd2536 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -61,7 +61,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks), clk_data);
+	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index f900ac4bf7b8..b150f893a4b8 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -937,7 +937,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data, NULL);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 8abf42c2030c..a99583c62c3b 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -125,7 +125,7 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 	data = &mt8173_mmsys_driver_data;
 
 	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+				     clk_data, &pdev->dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b57e33cda7a5..dfb819dd1b1b 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -889,7 +889,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+			       clk_data, NULL);
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
@@ -919,7 +919,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
+			       clk_data, NULL);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8173_clk_lock, clk_data);
 
@@ -1063,7 +1063,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-						clk_data);
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1081,7 +1081,7 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-						clk_data);
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1098,7 +1098,7 @@ static void __init mtk_vencsys_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
 
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-						clk_data);
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1115,7 +1115,7 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
 
 	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
-						clk_data);
+			       clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index b2d7746eddbe..f4c6448b6f74 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -76,7 +76,7 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			clk_data);
+			       clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 11ecc6fb0065..f93043da26c0 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -91,7 +91,7 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+			clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 23afc9584638..f99c092476c2 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1101,7 +1101,7 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
 	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
-		clk_data);
+		clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1176,7 +1176,7 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 		base, &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-		top_clk_data);
+		top_clk_data, &pdev->dev);
 
 	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
 					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
@@ -1196,7 +1196,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-		clk_data);
+		clk_data, &pdev->dev);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
@@ -1219,7 +1219,7 @@ static int clk_mt8183_peri_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+			       clk_data, &pdev->dev);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 1d33be407947..35038928eacf 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -69,7 +69,8 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+				   clk_data, &pdev->dev);
 	if (r)
 		goto free_mm_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 8c989bffd8c7..3acadca2452a 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -87,7 +87,8 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks),
+				   clk_data, &pdev->dev);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 1be3ff4d407d..226f6976c277 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -91,7 +91,8 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+				   clk_data, &pdev->dev);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 991d78a71644..e1b625b86911 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1127,7 +1127,7 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_top_composites;
 
-	r = mtk_clk_register_gates_with_dev(node, top_clks, ARRAY_SIZE(top_clks),
+	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 					    top_clk_data, &pdev->dev);
 	if (r)
 		goto unregister_adj_divs_composites;
@@ -1168,7 +1168,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, infra_clks, ARRAY_SIZE(infra_clks),
+	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 					    clk_data, &pdev->dev);
 	if (r)
 		goto free_clk_data;
@@ -1200,7 +1200,7 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, peri_clks, ARRAY_SIZE(peri_clks),
+	r = mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 					    clk_data, &pdev->dev);
 	if (r)
 		goto free_clk_data;
@@ -1229,9 +1229,9 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	r = mtk_clk_register_gates_with_dev(node, apmixed_clks,
-					    ARRAY_SIZE(apmixed_clks), clk_data,
-					    &pdev->dev);
+	r = mtk_clk_register_gates(node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data,
+				   &pdev->dev);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 0dfed6ec4d15..f967e2592dea 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -124,7 +124,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apmixed_data;
 
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
+				   clk_data, &pdev->dev);
 	if (r)
 		goto unregister_plls;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 93e96419da66..ed604d39f9d5 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1286,7 +1286,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
+				   top_clk_data, &pdev->dev);
 	if (r)
 		goto unregister_composite_divs;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 07b46bfd5040..9ebad476e943 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -104,7 +104,8 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
+	r = mtk_clk_register_gates(node, vdo0_clks, ARRAY_SIZE(vdo0_clks),
+				   clk_data, &pdev->dev);
 	if (r)
 		goto free_vdo0_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 835335b9d87b..a7a588f086c5 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -131,7 +131,8 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
+	r = mtk_clk_register_gates(node, vdo1_clks, ARRAY_SIZE(vdo1_clks),
+				   clk_data, &pdev->dev);
 	if (r)
 		goto free_vdo1_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 5c8bf18ab1f1..bc6bf0913452 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -81,9 +81,8 @@ static int clk_mt8365_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	ret = mtk_clk_register_gates_with_dev(node, mm_clks,
-					      ARRAY_SIZE(mm_clks), clk_data,
-					      dev);
+	ret = mtk_clk_register_gates(node, mm_clks,
+				     ARRAY_SIZE(mm_clks), clk_data, dev);
 	if (ret)
 		goto err_free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index adfecb618f10..5a43e5aad16e 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -1020,7 +1020,7 @@ static int clk_mt8365_infra_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-				     clk_data);
+				     clk_data, &pdev->dev);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 90f48068a8de..e3a7b3c939f3 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -54,7 +54,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data, NULL);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index b96db88893e2..a648ee463697 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -691,7 +691,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data, NULL);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3c1ac8d3010f..e04eef7e2b6f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -459,8 +459,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks,
+				   clk_data, &pdev->dev);
 	if (r)
 		goto free_data;
 
-- 
2.39.0

