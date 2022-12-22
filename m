Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2D654030
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiLVLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiLVLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:52:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14A2B27F;
        Thu, 22 Dec 2022 03:49:18 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96FCC6602CD5;
        Thu, 22 Dec 2022 11:49:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709757;
        bh=4EyQ1OjZT/baUayxYK+ueqc8j67gyi4x2llaOGk/ij8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLu1r3saZ07hI+faIHU2SyfBGedPrOO1Wr5j8LjB+e7idzRKdObgmSZBBO+YfMIg8
         HMM8Bk2UpQItINsMZSCB05SCrpfnU5dsVu3JYAVSE8cRg5KXANy3R9AAIeKXv578oD
         QO/t9RxjkhJSJnYNKljXHkmwRqNPmrxFaJlozEJO8DuXoA3pr/zAv10ExM79yZYcg/
         hYAZc5zqt4SwZXRR87+EKe6g9zZdoD6smkujxRsWmknLqecwd3r8bA0jLci6nqUIJO
         oyyaHt3cHX6a3oFMFreiMGpz1A1BsArUQyNSFUsUAwvx4CYoL+WF1OafHiDg6JcQBM
         BRUHVvyddox9Q==
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
Subject: [PATCH v1 01/25] clk: mediatek: mt8192: Correctly unregister and free clocks on failure
Date:   Thu, 22 Dec 2022 12:48:33 +0100
Message-Id: <20221222114857.120060-2-angelogioacchino.delregno@collabora.com>
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

