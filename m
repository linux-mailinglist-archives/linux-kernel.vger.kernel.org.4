Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994F6750B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjATJV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjATJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:21:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE139AAB4;
        Fri, 20 Jan 2023 01:21:05 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 045106602DAA;
        Fri, 20 Jan 2023 09:21:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206464;
        bh=nBOzaScA39qhpLHj0reOWfUMSPCyNv5Eiqahh8XFI5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsAPsMOsEu0ecUK6aVY1FBVGLT8jmWW/31kqVFHBxjKDmweMaYyJqhVB6ndQOpnqM
         Z9Hf8i9pbjwutvvIHPmWFHOLcqoUQMm2max/1WGqqiG+MewOGmLqu0OyFYs8WleW8E
         P8s5A7bCd9gN3xQS9xNT96tmbRo9VlSUUzY5FSa+GWJceUXOwFrRIjScFICXLsVmdW
         C2mnln7a2+W8PUni6bA7hm72FmtRxeMFDsB6zMgbAdsgDqFUCu1lW44vNlxzQt2GLA
         jKYkbf1xlz/wwIdIhg2iqjYzLu7n87dN4yP0X+JSTEjRRPckQn5kx78nmTp24cBQis
         X2IZZ2sNEd8+g==
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
Subject: [PATCH v4 03/23] clk: mediatek: clk-gate: Propagate struct device with mtk_clk_register_gates()
Date:   Fri, 20 Jan 2023 10:20:33 +0100
Message-Id: <20230120092053.182923-4-angelogioacchino.delregno@collabora.com>
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
reflect this change; also, to improve consistency with other kernel
functions, the pointer to struct device was moved as the first param.

Since a lot of MediaTek clock drivers are actually registering as a
platform device, but were still registering the mtk-gate clocks
without passing any struct device to the clock framework, they've
been changed to pass a valid one now, as to make all those platforms
able to use runtime power management where available.

While at it, some much needed indentation changes were also done.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c              | 23 ++++++-------------
 drivers/clk/mediatek/clk-gate.h              |  7 +-----
 drivers/clk/mediatek/clk-mt2701-aud.c        |  4 ++--
 drivers/clk/mediatek/clk-mt2701-eth.c        |  4 ++--
 drivers/clk/mediatek/clk-mt2701-g3d.c        |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c        |  4 ++--
 drivers/clk/mediatek/clk-mt2701-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt2701.c            | 12 +++++-----
 drivers/clk/mediatek/clk-mt2712-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt2712.c            | 12 +++++-----
 drivers/clk/mediatek/clk-mt6765.c            | 10 ++++----
 drivers/clk/mediatek/clk-mt6779-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt6779.c            |  6 ++---
 drivers/clk/mediatek/clk-mt6795-infracfg.c   |  3 ++-
 drivers/clk/mediatek/clk-mt6795-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt6795-pericfg.c    |  3 ++-
 drivers/clk/mediatek/clk-mt6797-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt6797.c            |  4 ++--
 drivers/clk/mediatek/clk-mt7622-aud.c        |  4 ++--
 drivers/clk/mediatek/clk-mt7622-eth.c        |  8 +++----
 drivers/clk/mediatek/clk-mt7622-hif.c        |  8 +++----
 drivers/clk/mediatek/clk-mt7622.c            | 14 ++++++------
 drivers/clk/mediatek/clk-mt7629-eth.c        |  7 +++---
 drivers/clk/mediatek/clk-mt7629-hif.c        |  8 +++----
 drivers/clk/mediatek/clk-mt7629.c            | 10 ++++----
 drivers/clk/mediatek/clk-mt7986-eth.c        | 10 ++++----
 drivers/clk/mediatek/clk-mt7986-infracfg.c   |  4 ++--
 drivers/clk/mediatek/clk-mt8135.c            |  8 +++----
 drivers/clk/mediatek/clk-mt8167-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt8167-vdec.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8167.c            |  2 +-
 drivers/clk/mediatek/clk-mt8173-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt8173.c            | 24 ++++++++++----------
 drivers/clk/mediatek/clk-mt8183-audio.c      |  4 ++--
 drivers/clk/mediatek/clk-mt8183-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt8183.c            | 16 ++++++-------
 drivers/clk/mediatek/clk-mt8186-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt8192-aud.c        |  3 ++-
 drivers/clk/mediatek/clk-mt8192-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt8192.c            | 17 +++++++-------
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |  3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8365-mm.c         |  5 ++--
 drivers/clk/mediatek/clk-mt8365.c            |  4 ++--
 drivers/clk/mediatek/clk-mt8516-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt8516.c            |  2 +-
 drivers/clk/mediatek/clk-mtk.c               |  4 ++--
 52 files changed, 156 insertions(+), 160 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 0c867136e49d..67d9e741c5e7 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -152,12 +152,12 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
-static struct clk_hw *mtk_clk_register_gate(const char *name,
+static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name,
 					 const char *parent_name,
 					 struct regmap *regmap, int set_ofs,
 					 int clr_ofs, int sta_ofs, u8 bit,
 					 const struct clk_ops *ops,
-					 unsigned long flags, struct device *dev)
+					 unsigned long flags)
 {
 	struct mtk_clk_gate *cg;
 	int ret;
@@ -202,10 +202,9 @@ static void mtk_clk_unregister_gate(struct clk_hw *hw)
 	kfree(cg);
 }
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev)
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk_hw *hw;
@@ -229,13 +228,13 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 			continue;
 		}
 
-		hw = mtk_clk_register_gate(gate->name, gate->parent_name,
+		hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
 					    regmap,
 					    gate->regs->set_ofs,
 					    gate->regs->clr_ofs,
 					    gate->regs->sta_ofs,
 					    gate->shift, gate->ops,
-					    gate->flags, dev);
+					    gate->flags);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name,
@@ -261,14 +260,6 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
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
index d9897ef53528..1a46b4c56fc5 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -50,15 +50,10 @@ struct mtk_gate {
 #define GATE_MTK(_id, _name, _parent, _regs, _shift, _ops)		\
 	GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift, _ops, 0)
 
-int mtk_clk_register_gates(struct device_node *node,
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 			   const struct mtk_gate *clks, int num,
 			   struct clk_hw_onecell_data *clk_data);
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev);
-
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 6ba398eb7df9..263c7075bbcb 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -151,8 +151,8 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index edf1e2ed2b59..844902bd1ffa 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -57,8 +57,8 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETHSYS_NR);
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1458109d99d9..b71e774a16a9 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -51,7 +51,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_G3DSYS_NR);
 
-	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
+	mtk_clk_register_gates(&pdev->dev, node, g3d_clks, ARRAY_SIZE(g3d_clks),
 			       clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 434cbbe8c037..ca7c022ad2d0 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -54,8 +54,8 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_HIFSYS_NR);
 
-	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, hif_clks,
+			       ARRAY_SIZE(hif_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 9ea7abad99d2..23d5ddcc1d37 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -88,8 +88,8 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 9b442af37e67..61f1f358104b 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -689,8 +689,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt2701_clk_lock, clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -795,8 +795,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		}
 	}
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						infra_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), infra_clk_data);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
@@ -918,8 +918,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
 			&mt2701_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 7d44b09b8a0a..25b8af640c12 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -135,8 +135,8 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 56980dd6c2ea..6260cdcd18c4 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1350,8 +1350,8 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 			&mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 			&mt2712_clk_lock, top_clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			top_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), top_clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 
@@ -1370,8 +1370,8 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1392,8 +1392,8 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index e9b9e6729733..0fa0e4ed877a 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -789,7 +789,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -828,8 +828,8 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 				 clk_data);
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
 			       &mt6765_clk_lock, clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -862,8 +862,8 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
-	mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
+			       ARRAY_SIZE(ifr_clks), clk_data);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index eda8cbee3d23..2cccf62d3b36 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -93,8 +93,8 @@ static int clk_mt6779_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 0d0a90ee5eb2..559d4d596e0c 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1221,7 +1221,7 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -1263,8 +1263,8 @@ static int clk_mt6779_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index df7eed6e071e..8025d171d692 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -101,7 +101,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
+				     ARRAY_SIZE(infra_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index fd73f202f292..eebb6143ada2 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -87,7 +87,8 @@ static int clk_mt6795_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, mm_gates,
+				     ARRAY_SIZE(mm_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index cb28d35dad59..f69e715e0c1f 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -109,7 +109,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, peri_gates,
+				     ARRAY_SIZE(peri_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 0846011fc894..deb16a6b16a5 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -101,8 +101,8 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index b89f325a4b9b..2052ba4261b3 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -596,8 +596,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		}
 	}
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       infra_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), infra_clk_data);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 				 infra_clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 9f2e5aa7b5d9..a3eb66b7532e 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -138,8 +138,8 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 43de0477d5d9..e058e4a9cc42 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -81,8 +81,8 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -103,8 +103,8 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
 
-	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, sgmii_clks,
+			       ARRAY_SIZE(sgmii_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 67e96231dd25..9371520c628b 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -92,8 +92,8 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ssusb_clks,
+			       ARRAY_SIZE(ssusb_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -114,8 +114,8 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, pcie_clks,
+			       ARRAY_SIZE(pcie_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 3b55f8641fae..976f318c2e5e 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -652,8 +652,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				  base, &mt7622_clk_lock, clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
@@ -670,8 +670,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -698,7 +698,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
@@ -720,8 +720,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 282dd6559465..a4ae7d6c7a71 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -92,7 +92,8 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
 
-	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       CLK_ETH_NR_CLK, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -114,8 +115,8 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
 
-	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, sgmii_clks[id++],
+			       CLK_SGMII_NR_CLK, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 0c8b9e139789..bd1ce65aad2b 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -87,8 +87,8 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ssusb_clks,
+			       ARRAY_SIZE(ssusb_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -109,8 +109,8 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, pcie_clks,
+			       ARRAY_SIZE(pcie_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index e4a08c811adc..aadf5d1bc986 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -605,8 +605,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -628,8 +628,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
@@ -655,7 +655,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 7868c0728e96..703872239ecc 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -84,8 +84,8 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
 
-	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
-			       clk_data);
+	mtk_clk_register_gates(NULL, node, sgmii0_clks,
+			       ARRAY_SIZE(sgmii0_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -102,8 +102,8 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
 
-	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
-			       clk_data);
+	mtk_clk_register_gates(NULL, node, sgmii1_clks,
+			       ARRAY_SIZE(sgmii1_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -121,7 +121,7 @@ static void __init mtk_ethsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index 49666047bf0e..a3aee4bc9e0c 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -192,8 +192,8 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
 			       &mt7986_clk_lock, clk_data);
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index b68888a034c4..05963fd76ee9 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -567,8 +567,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_INFRA_M4U]->clk);
 
@@ -595,8 +595,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, peri_gates,
+			       ARRAY_SIZE(peri_gates), clk_data);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8135_clk_lock, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index ce1ae8d243c3..f6bea6e9e6a4 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -55,7 +55,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index e359e563d2b7..77db13b177fc 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -48,7 +48,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, img_clks, ARRAY_SIZE(img_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 4fd82fe87d6e..3c23591b02f7 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -46,7 +46,7 @@ static void __init mtk_mfgcfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 73910060577f..c0b44104c765 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -110,8 +110,8 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 
 	data = &mt8167_mmsys_driver_data;
 
-	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
+				     data->gates_num, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index ee4fffb6859d..759e5791599f 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -61,7 +61,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, vdec_clks, ARRAY_SIZE(vdec_clks),
+			       clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index f900ac4bf7b8..59fe82ba5c7a 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -937,7 +937,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 8abf42c2030c..42db738a1d9b 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -124,8 +124,8 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 
 	data = &mt8173_mmsys_driver_data;
 
-	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
+				     data->gates_num, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b57e33cda7a5..c6545f9c759f 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -888,8 +888,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
@@ -918,8 +918,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, peri_gates,
+			       ARRAY_SIZE(peri_gates), clk_data);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8173_clk_lock, clk_data);
 
@@ -1062,8 +1062,8 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, img_clks,
+			       ARRAY_SIZE(img_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1080,8 +1080,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, vdec_clks,
+			       ARRAY_SIZE(vdec_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1097,8 +1097,8 @@ static void __init mtk_vencsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
 
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, venc_clks,
+			       ARRAY_SIZE(venc_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1114,8 +1114,8 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
 
-	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, venclt_clks,
+			       ARRAY_SIZE(venclt_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index b2d7746eddbe..f358a6e7a340 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -75,8 +75,8 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 11ecc6fb0065..358031530913 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -90,8 +90,8 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 23afc9584638..efee904217dc 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1100,8 +1100,8 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
-		clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1175,8 +1175,8 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
 		base, &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-		top_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), top_clk_data);
 
 	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
 					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
@@ -1195,8 +1195,8 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-		clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
@@ -1218,8 +1218,8 @@ static int clk_mt8183_peri_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 1d33be407947..0b72607777fa 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -69,7 +69,8 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+				   ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
 		goto free_mm_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 8c989bffd8c7..f524188fe4c2 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -87,7 +87,8 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, aud_clks,
+				   ARRAY_SIZE(aud_clks), clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 1be3ff4d407d..e9eb4cf8349a 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -91,7 +91,8 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 6f4525a4ff75..eb53d0fc47e3 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1127,8 +1127,8 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_top_composites;
 
-	r = mtk_clk_register_gates_with_dev(node, top_clks, ARRAY_SIZE(top_clks),
-					    top_clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
+				   ARRAY_SIZE(top_clks), top_clk_data);
 	if (r)
 		goto unregister_adj_divs_composites;
 
@@ -1171,8 +1171,8 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, infra_clks, ARRAY_SIZE(infra_clks),
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+				   ARRAY_SIZE(infra_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1203,8 +1203,8 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, peri_clks, ARRAY_SIZE(peri_clks),
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+				   ARRAY_SIZE(peri_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1232,9 +1232,8 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	r = mtk_clk_register_gates_with_dev(node, apmixed_clks,
-					    ARRAY_SIZE(apmixed_clks), clk_data,
-					    &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 0dfed6ec4d15..1bc917f2667e 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -124,7 +124,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apmixed_data;
 
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
 		goto unregister_plls;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 93e96419da66..d8c9166d00f4 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1286,7 +1286,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
+				   ARRAY_SIZE(top_clks), top_clk_data);
 	if (r)
 		goto unregister_composite_divs;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 07b46bfd5040..839b730688ac 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -104,7 +104,8 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, vdo0_clks,
+				   ARRAY_SIZE(vdo0_clks), clk_data);
 	if (r)
 		goto free_vdo0_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 835335b9d87b..7df695b28925 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -131,7 +131,8 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, vdo1_clks,
+				   ARRAY_SIZE(vdo1_clks), clk_data);
 	if (r)
 		goto free_vdo1_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 5c8bf18ab1f1..22c75a03a645 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -81,9 +81,8 @@ static int clk_mt8365_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	ret = mtk_clk_register_gates_with_dev(node, mm_clks,
-					      ARRAY_SIZE(mm_clks), clk_data,
-					      dev);
+	ret = mtk_clk_register_gates(dev, node, mm_clks,
+				     ARRAY_SIZE(mm_clks), clk_data);
 	if (ret)
 		goto err_free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index adfecb618f10..b30cbeae1c3d 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -1019,8 +1019,8 @@ static int clk_mt8365_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
+				     ARRAY_SIZE(ifr_clks), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 90f48068a8de..00f356fe7c7a 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -54,7 +54,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index b96db88893e2..c10979905f11 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -691,7 +691,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3c1ac8d3010f..fe44a729b4f4 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -459,8 +459,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks, mcd->num_clks,
+				   clk_data);
 	if (r)
 		goto free_data;
 
-- 
2.39.0

