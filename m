Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EB654E94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiLWJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiLWJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:43:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DFE3722C;
        Fri, 23 Dec 2022 01:43:09 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B7EC6602CE1;
        Fri, 23 Dec 2022 09:43:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788588;
        bh=4EyQ1OjZT/baUayxYK+ueqc8j67gyi4x2llaOGk/ij8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8rBp5+Td/KdXaiYh1HKJVsvFExiZTNHsA4pbwlj2Ib5yTsKddTj2iqzedjY949yg
         7V16FMf2Y9RNJFRj4xZYP3/cpaX4VGGMRWnhWHz9WBakWMPKhi3RAiwbdhPep1rIAT
         ZR+Kfx6LVN/14FoLLIY9VH2qlukGG7RoDAqCGa+QGWVT17kvsOlINu8sWQ6hCNZm0e
         ons2Cx3HgBuTv6r/WiDWoSJ0UJapkS+RsCAWND78w3aK/eym2XsmymuWsUqQXtQSwe
         AGZ1HJ36EFjFk2r2DIy3MUqtNx59UhMl7DXftMgo2roTd+WIab8HYpSR1ftVE0vlUC
         //DeYYDMtMFUw==
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
Subject: [PATCH v2 01/23] clk: mediatek: mt8192: Correctly unregister and free clocks on failure
Date:   Fri, 23 Dec 2022 10:42:37 +0100
Message-Id: <20221223094259.87373-2-angelogioacchino.delregno@collabora.com>
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

If anything fails during probe of the clock controller(s), unregister
(and kfree!) whatever we have previously registered to leave with a
clean state and prevent leaks.

Fixes: 710573dee31b ("clk: mediatek: Add MT8192 basic clocks support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 72 ++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 0e88588b2c49..eff66ca6c6a7 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1100,27 +1100,61 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node, &mt8192_clk_lock,
-			       top_clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base, &mt8192_clk_lock,
-				    top_clk_data);
-	mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base, &mt8192_clk_lock,
-				    top_clk_data);
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
 	if (r)
 		return r;
 
+	r = mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
+	if (r)
+		goto unregister_fixed_clks;
+
+	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+	if (r)
+		goto unregister_early_factors;
+
+	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+				   &mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_factors;
+
+	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+					&mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_muxes;
+
+	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+					&mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_top_composites;
+
+	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	if (r)
+		goto unregister_adj_divs_composites;
+
 	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
 					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
 	if (r)
-		return r;
-
+		goto unregister_gates;
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      top_clk_data);
+
+unregister_gates:
+	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+unregister_adj_divs_composites:
+	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
+unregister_top_composites:
+	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
+unregister_muxes:
+	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
+unregister_factors:
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+unregister_early_factors:
+	mtk_clk_unregister_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
+unregister_fixed_clks:
+	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
+				      top_clk_data);
+	return r;
 }
 
 static int clk_mt8192_infra_probe(struct platform_device *pdev)
@@ -1139,14 +1173,16 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 
 	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -1168,10 +1204,12 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -1194,10 +1232,12 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
-- 
2.39.0

