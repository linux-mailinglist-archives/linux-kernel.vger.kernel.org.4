Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333536750C7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjATJV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjATJVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:21:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331E30C4;
        Fri, 20 Jan 2023 01:21:12 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14A326602E12;
        Fri, 20 Jan 2023 09:21:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206469;
        bh=RUvncrHnR0gHvSopWbOcOv1MTVuKVe9169mWHQJCPEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5KR1NYrprxAggv73WiQ1YziPKg9VKH3K/ecIcCM6ROzJckPy7BR1kaw6P9YxcvQm
         qvXqq53uVPV+L33MMeVgs3lzIayOWgxDex8fR2DxqeixwWIUHYDpw8UpSVhDIEYvR7
         7qm9bv2YDwyYUgzAly2kAlNtaPvoam5pDWaKl6GZhwePSsir4UxpOnwZjSpw1FeE9q
         lkI4BZliuipBSjPFPCzvTOtvoQmV/uTONSG1/QjAc/WnOZrcCvngSUw/7mOb1rQJaG
         XyA4KH3YdHPMNEqQMwm8muU6JoqSSQbfjkgOIY/ChJYstc/dUSFiXJ/uTUEJIwSfHB
         Zd7eY5krdOJQw==
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
Subject: [PATCH v4 06/23] clk: mediatek: clk-mux: Propagate struct device for mtk-mux
Date:   Fri, 20 Jan 2023 10:20:36 +0100
Message-Id: <20230120092053.182923-7-angelogioacchino.delregno@collabora.com>
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

Like done for other clocks, propagate struct device for mtk mux clocks
registered through clk-mux helpers to enable runtime pm support.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt6765.c          |  3 ++-
 drivers/clk/mediatek/clk-mt6779.c          |  5 +++--
 drivers/clk/mediatek/clk-mt6795-topckgen.c |  3 ++-
 drivers/clk/mediatek/clk-mt7986-infracfg.c |  3 ++-
 drivers/clk/mediatek/clk-mt7986-topckgen.c |  3 ++-
 drivers/clk/mediatek/clk-mt8183.c          |  5 +++--
 drivers/clk/mediatek/clk-mt8186-topckgen.c |  3 ++-
 drivers/clk/mediatek/clk-mt8192.c          |  3 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c |  3 ++-
 drivers/clk/mediatek/clk-mt8365.c          |  3 ++-
 drivers/clk/mediatek/clk-mux.c             | 14 ++++++++------
 drivers/clk/mediatek/clk-mux.h             |  3 ++-
 12 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 0fa0e4ed877a..6f5c92a7f620 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -826,7 +826,8 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 				    clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
 				 clk_data);
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
 			       &mt6765_clk_lock, clk_data);
 	mtk_clk_register_gates(&pdev->dev, node, top_clks,
 			       ARRAY_SIZE(top_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index a1c387d9731a..248aaa50ced1 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1244,8 +1244,9 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
-			       node, &mt6779_clk_lock, clk_data);
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
+			       &mt6779_clk_lock, clk_data);
 
 	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
 				    ARRAY_SIZE(top_aud_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index 62beca56ee01..65fd8aa69afd 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -552,7 +552,8 @@ static int clk_mt6795_topckgen_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_fixed_clks;
 
-	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	ret = mtk_clk_register_muxes(&pdev->dev, top_muxes,
+				     ARRAY_SIZE(top_muxes), node,
 				     &mt6795_top_clk_lock, clk_data);
 	if (ret)
 		goto unregister_factors;
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index a3aee4bc9e0c..e80c92167c8f 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -190,7 +190,8 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
-	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
+	mtk_clk_register_muxes(&pdev->dev, infra_muxes,
+			       ARRAY_SIZE(infra_muxes), node,
 			       &mt7986_clk_lock, clk_data);
 	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
 			       ARRAY_SIZE(infra_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index de5121cf2877..c9bf47e6098f 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -303,7 +303,8 @@ static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
 			       &mt7986_clk_lock, clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAXI_SEL]->clk);
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 34374b2862ac..9d29db8a7c7b 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1166,8 +1166,9 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
-		node, &mt8183_clk_lock, top_clk_data);
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
+			       &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
 				    ARRAY_SIZE(top_aud_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 9344c09136ee..3ce2818dcbdd 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -737,7 +737,8 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_fixed_clks;
 
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
+				   ARRAY_SIZE(top_mtk_muxes), node,
 				   &mt8186_clk_lock, clk_data);
 	if (r)
 		goto unregister_factors;
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 2d04218e6806..09d065c680e4 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1112,7 +1112,8 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_early_factors;
 
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
+				   ARRAY_SIZE(top_mtk_muxes), node,
 				   &mt8192_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_factors;
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 8202e7272f12..cf520f85de73 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1262,7 +1262,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_fixed_clks;
 
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
+				   ARRAY_SIZE(top_mtk_muxes), node,
 				   &mt8195_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_factors;
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 0482a8aa43cc..c9faa07ec0a6 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -947,7 +947,8 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_fixed_clks;
 
-	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	ret = mtk_clk_register_muxes(&pdev->dev, top_muxes,
+				     ARRAY_SIZE(top_muxes), node,
 				     &mt8365_clk_lock, clk_data);
 	if (ret)
 		goto unregister_factors;
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index ba1720b9e231..c8593554239d 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -154,9 +154,10 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
-static struct clk_hw *mtk_clk_register_mux(const struct mtk_mux *mux,
-				 struct regmap *regmap,
-				 spinlock_t *lock)
+static struct clk_hw *mtk_clk_register_mux(struct device *dev,
+					   const struct mtk_mux *mux,
+					   struct regmap *regmap,
+					   spinlock_t *lock)
 {
 	struct mtk_clk_mux *clk_mux;
 	struct clk_init_data init = {};
@@ -177,7 +178,7 @@ static struct clk_hw *mtk_clk_register_mux(const struct mtk_mux *mux,
 	clk_mux->lock = lock;
 	clk_mux->hw.init = &init;
 
-	ret = clk_hw_register(NULL, &clk_mux->hw);
+	ret = clk_hw_register(dev, &clk_mux->hw);
 	if (ret) {
 		kfree(clk_mux);
 		return ERR_PTR(ret);
@@ -198,7 +199,8 @@ static void mtk_clk_unregister_mux(struct clk_hw *hw)
 	kfree(mux);
 }
 
-int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+int mtk_clk_register_muxes(struct device *dev,
+			   const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
 			   struct clk_hw_onecell_data *clk_data)
@@ -222,7 +224,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			continue;
 		}
 
-		hw = mtk_clk_register_mux(mux, regmap, lock);
+		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 83ff420f4ebe..7ecb963b0ec6 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -83,7 +83,8 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 			0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,		\
 			mtk_mux_clr_set_upd_ops)
 
-int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+int mtk_clk_register_muxes(struct device *dev,
+			   const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
 			   struct clk_hw_onecell_data *clk_data);
-- 
2.39.0

