Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3768C172
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBFPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjBFPab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E182A9BF;
        Mon,  6 Feb 2023 07:30:09 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79EA96600363;
        Mon,  6 Feb 2023 15:30:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697408;
        bh=cRMD0WbwFQ4EBUljcBKgX6YcBL+eLZi0B62hiSyzKvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6BtzdvLRz/yNrrrpOczGGcX31o8u1nuzv/cyScFiSKGuUjviW0q5TapPfRqfJnN2
         oU1xDJIW1LZbD/K4n5NW7rMme22GGYIz7Nn+8p8IR+Tbld4n4OoSfNIhdhFcPbV+VW
         B1fryUfoQifXoG824pD8PhHb02sYGKnjxsk9u1lex38L8nQbicVLJfPIT4ZWOMYKdi
         l9Gnb1tT6mcCnGZOJ2Q56ESOwFafoL/xey9cnema5MkZ+HZEWDUQdVHwE1rMoD/+MD
         6mqQ4sNPA4GXQdB81GfU7iSQV1MuyAeSUINbzooTtxJLgxfd866kF8a/wgl13cR0he
         sIgJj3jhOY/Lw==
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
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 16/45] clk: mediatek: mt8167: Convert to mtk_clk_simple_{probe,remove}()
Date:   Mon,  6 Feb 2023 16:28:59 +0100
Message-Id: <20230206152928.918562-17-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

Convert topckgen and infracfg clock drivers to use the common
mtk_clk_simple_probe() mechanism and change this from the old
"static" CLK_OF_DECLARE to be a platform driver, allowing it
to eventually be built as a module.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8167-aud.c    | 31 +++++----
 drivers/clk/mediatek/clk-mt8167-img.c    | 32 ++++-----
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c | 32 ++++-----
 drivers/clk/mediatek/clk-mt8167-vdec.c   | 33 ++++-----
 drivers/clk/mediatek/clk-mt8167.c        | 86 +++++++++---------------
 5 files changed, 101 insertions(+), 113 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index 2d890a440863..eec9de190cb6 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -48,19 +48,22 @@ static const struct mtk_gate aud_clks[] = {
 	GATE_AUD(CLK_AUD_TML, "aud_tml", "aud_afe", 27),
 };
 
-static void __init mtk_audsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
-
-	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+static const struct mtk_clk_desc aud_desc = {
+	.clks = aud_clks,
+	.num_clks = ARRAY_SIZE(aud_clks),
+};
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static const struct of_device_id of_match_clk_mt8167_audsys[] = {
+	{ .compatible = "mediatek,mt8167-audsys", .data = &aud_desc },
+	{ /* sentinel */ }
+};
 
-}
-CLK_OF_DECLARE(mtk_audsys, "mediatek,mt8167-audsys", mtk_audsys_init);
+static struct platform_driver clk_mt8167_audsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8167-audsys",
+		.of_match_table = of_match_clk_mt8167_audsys,
+	},
+};
+module_platform_driver(clk_mt8167_audsys_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 23950186ee02..5cd51d894d32 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -41,20 +41,22 @@ static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_VENC, "img_venc", "smi_mm", 9),
 };
 
-static void __init mtk_imgsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
-
-	mtk_clk_register_gates(NULL, node, img_clks, ARRAY_SIZE(img_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
 
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static const struct of_device_id of_match_clk_mt8167_imgsys[] = {
+	{ .compatible = "mediatek,mt8167-imgsys", .data = &img_desc },
+	{ /* sentinel */ }
+};
 
-}
-CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8167-imgsys", mtk_imgsys_init);
+static struct platform_driver clk_mt8167_imgsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8167-imgsys",
+		.of_match_table = of_match_clk_mt8167_imgsys,
+	},
+};
+module_platform_driver(clk_mt8167_imgsys_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 40b2d45f3fe3..2cf88d5d245d 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -39,20 +39,22 @@ static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_B26M, "mfg_b26m", "clk26m_ck", 3),
 };
 
-static void __init mtk_mfgcfg_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
-
-	mtk_clk_register_gates(NULL, node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+static const struct mtk_clk_desc mfg_desc = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
 
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static const struct of_device_id of_match_clk_mt8167_mfgcfg[] = {
+	{ .compatible = "mediatek,mt8167-mfgcfg", .data = &mfg_desc },
+	{ /* sentinel */ }
+};
 
-}
-CLK_OF_DECLARE(mtk_mfgcfg, "mediatek,mt8167-mfgcfg", mtk_mfgcfg_init);
+static struct platform_driver clk_mt8167_mfgcfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8167-mfgcfg",
+		.of_match_table = of_match_clk_mt8167_mfgcfg,
+	},
+};
+module_platform_driver(clk_mt8167_mfgcfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 905529789a7c..da15f34765ff 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -54,21 +54,22 @@ static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC1_I(CLK_VDEC_LARB1_CKEN, "vdec_larb1_cken", "smi_mm", 0),
 };
 
-static void __init mtk_vdecsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
-
-	mtk_clk_register_gates(NULL, node, vdec_clks, ARRAY_SIZE(vdec_clks),
-			       clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
 
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static const struct of_device_id of_match_clk_mt8167_vdec[] = {
+	{ .compatible = "mediatek,mt8167-vdecsys", .data = &vdec_desc },
+	{ /* sentinel */ }
+};
 
-}
-CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt8167-vdecsys", mtk_vdecsys_init);
+static struct platform_driver clk_mt8167_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8167-vdecsys",
+		.of_match_table = of_match_clk_mt8167_vdec,
+	},
+};
+builtin_platform_driver(clk_mt8167_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 3f0b2c90c518..2f8b663151ff 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
 
 #include "clk-gate.h"
 #include "clk-mtk.h"
@@ -865,59 +866,38 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP5(CLK_TOP_APLL12_DIV6, "apll12_div6", "apll12_ck_div6", 8),
 };
 
-static void __init mtk_topckgen_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
-
-	clk_data = mtk_alloc_clk_data(MT8167_CLK_TOP_NR_CLK);
+static const struct mtk_clk_desc topck_desc = {
+	.clks = top_clks,
+	.num_clks = ARRAY_SIZE(top_clks),
+	.fixed_clks = fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.divider_clks = top_adj_divs,
+	.num_divider_clks = ARRAY_SIZE(top_adj_divs),
+	.clk_lock = &mt8167_clk_lock,
+};
 
-	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
-				    clk_data);
-	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+static const struct mtk_clk_desc infra_desc = {
+	.composite_clks = ifr_muxes,
+	.num_composite_clks = ARRAY_SIZE(ifr_muxes),
+	.clk_lock = &mt8167_clk_lock,
+};
 
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(NULL, top_muxes,
-				    ARRAY_SIZE(top_muxes), base,
-				    &mt8167_clk_lock, clk_data);
-	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
-				base, &mt8167_clk_lock, clk_data);
+static const struct of_device_id of_match_clk_mt8167[] = {
+	{ .compatible = "mediatek,mt8167-topckgen", .data = &topck_desc },
+	{ .compatible = "mediatek,mt8167-infracfg", .data = &infra_desc },
+	{ /* sentinel */ }
+};
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8167-topckgen", mtk_topckgen_init);
-
-static void __init mtk_infracfg_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
-
-	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
-
-	mtk_clk_register_composites(NULL, ifr_muxes,
-				    ARRAY_SIZE(ifr_muxes), base,
-				    &mt8167_clk_lock, clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_infracfg, "mediatek,mt8167-infracfg", mtk_infracfg_init);
+static struct platform_driver clk_mt8167_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8167",
+		.of_match_table = of_match_clk_mt8167,
+	},
+};
+module_platform_driver(clk_mt8167_drv);
-- 
2.39.1

