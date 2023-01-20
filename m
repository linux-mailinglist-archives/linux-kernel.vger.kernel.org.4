Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE36750B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjATJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjATJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:21:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BD9AAA8;
        Fri, 20 Jan 2023 01:21:07 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2A856602E25;
        Fri, 20 Jan 2023 09:21:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206466;
        bh=VLyQ7b5PEhwlNqFgT8LoCLJGcpSBKmnNMZrQfmbCXcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my8rp57JWGfg2zV2Yf80RPuvKLsMICVTuQg96qaqRjr6BRe7c8iUlCyx02j7pT6AC
         vvrr2ufWdA8yZ2fpSy5ymmjeZoZapFSsLT37ihRk/Wqh/R+7kx3EzF1nu3VVA0cqQG
         lh2LNXWNLo4HsrC5cQxM9GCY8rCUM/pRs+Dqxlap1+kWnWY+IaqCj4VcAMF68nZkEh
         vLxY9Z9eWXJtGavBpUYmJFFTl/MYCoHsGayvvz/dSQv/g70toGZLIHFPk4aeacaSHF
         vt4wPpIVRhMA9UMW2QtEqsMDoIsJYtGze0qRIz2cAMYYMkqVTswpBIwG/e00bZ1lzf
         rRlb4XAHISh8g==
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
Subject: [PATCH v4 04/23] clk: mediatek: cpumux: Propagate struct device where possible
Date:   Fri, 20 Jan 2023 10:20:34 +0100
Message-Id: <20230120092053.182923-5-angelogioacchino.delregno@collabora.com>
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

Take a pointer to a struct device in mtk_clk_register_cpumuxes() and
propagate the same to mtk_clk_register_cpumux() => clk_hw_register().
Even though runtime pm is unlikely to be used with CPU muxes, this
helps with code consistency and possibly opens to commonization of
some mtk_clk_register_(x) functions.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-cpumux.c          | 8 ++++----
 drivers/clk/mediatek/clk-cpumux.h          | 2 +-
 drivers/clk/mediatek/clk-mt2701.c          | 2 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c | 3 ++-
 drivers/clk/mediatek/clk-mt7622.c          | 4 ++--
 drivers/clk/mediatek/clk-mt7629.c          | 4 ++--
 drivers/clk/mediatek/clk-mt8173.c          | 4 ++--
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 25618eff6f2a..da05f06192c0 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -58,7 +58,7 @@ static const struct clk_ops clk_cpumux_ops = {
 };
 
 static struct clk_hw *
-mtk_clk_register_cpumux(const struct mtk_composite *mux,
+mtk_clk_register_cpumux(struct device *dev, const struct mtk_composite *mux,
 			struct regmap *regmap)
 {
 	struct mtk_clk_cpumux *cpumux;
@@ -81,7 +81,7 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
 	cpumux->regmap = regmap;
 	cpumux->hw.init = &init;
 
-	ret = clk_hw_register(NULL, &cpumux->hw);
+	ret = clk_hw_register(dev, &cpumux->hw);
 	if (ret) {
 		kfree(cpumux);
 		return ERR_PTR(ret);
@@ -102,7 +102,7 @@ static void mtk_clk_unregister_cpumux(struct clk_hw *hw)
 	kfree(cpumux);
 }
 
-int mtk_clk_register_cpumuxes(struct device_node *node,
+int mtk_clk_register_cpumuxes(struct device *dev, struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_hw_onecell_data *clk_data)
 {
@@ -125,7 +125,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			continue;
 		}
 
-		hw = mtk_clk_register_cpumux(mux, regmap);
+		hw = mtk_clk_register_cpumux(dev, mux, regmap);
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
 			       hw);
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
index 325adbef25d1..64e45c63b4a0 100644
--- a/drivers/clk/mediatek/clk-cpumux.h
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -11,7 +11,7 @@ struct clk_hw_onecell_data;
 struct device_node;
 struct mtk_composite;
 
-int mtk_clk_register_cpumuxes(struct device_node *node,
+int mtk_clk_register_cpumuxes(struct device *dev, struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 61f1f358104b..3d56ab25aeac 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -769,7 +769,7 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
-	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
+	mtk_clk_register_cpumuxes(NULL, node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
 				  infra_clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index 8025d171d692..23d9fc057e61 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -106,7 +106,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
+	ret = mtk_clk_register_cpumuxes(&pdev->dev, node, cpu_muxes,
+					ARRAY_SIZE(cpu_muxes), clk_data);
 	if (ret)
 		goto unregister_gates;
 
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 976f318c2e5e..a51a6ed9c4b8 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -673,8 +673,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
 			       ARRAY_SIZE(infra_clks), clk_data);
 
-	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
-				  clk_data);
+	mtk_clk_register_cpumuxes(&pdev->dev, node, infra_muxes,
+				  ARRAY_SIZE(infra_muxes), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				   clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index aadf5d1bc986..0fa158d61a29 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -608,8 +608,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
 			       ARRAY_SIZE(infra_clks), clk_data);
 
-	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
-				  clk_data);
+	mtk_clk_register_cpumuxes(&pdev->dev, node, infra_muxes,
+				  ARRAY_SIZE(infra_muxes), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index c6545f9c759f..767368463ec5 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -892,8 +892,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 			       ARRAY_SIZE(infra_clks), clk_data);
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
-	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
-				  clk_data);
+	mtk_clk_register_cpumuxes(NULL, node, cpu_muxes,
+				  ARRAY_SIZE(cpu_muxes), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-- 
2.39.0

