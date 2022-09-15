Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F85B9551
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIOHZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIOHZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:25:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288163F36;
        Thu, 15 Sep 2022 00:25:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB076660201C;
        Thu, 15 Sep 2022 08:25:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663226712;
        bh=tqzHv7pN26chTkKpPZzEDlhEkywicueCNMzL2GoOwi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOvz7zrPFKjkKHkA6emQrQsOE61k6cCUSADIcPAW9rpaXRDilwkuIL8NN8FqC9hVU
         ZlndR2vEJ1iC3X2Lxu8FQ35ivNezD+gG+VlYr/OopeRX1EnQhK8Nk5cvMskqmVYvw8
         OYNOujU3DW+wP9KJeFeN+qocdWf+zyc9GhGacfRN+99J15/Axi/1KIisPafqCIOl6h
         WEYpRaKpvdAlFSoMui6JlcD0uKyeNxbQtSXCjKE+LIZjlXHt1KK4/58O+6gQdRAEsY
         fiAoVMQPu95SwOePQ9fGYuG9TKeZllnj1TnHDijLhM0OzWDkZ+q+6YT43bZbvqc273
         j2RJ2G3Jf3m5w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 06/10] clk: mediatek: clk-mt8195-topckgen: Register mfg_ck_fast_ref as generic mux
Date:   Thu, 15 Sep 2022 09:24:54 +0200
Message-Id: <20220915072458.18232-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock was being registered as clk-composite through the helpers
for the same in the MediaTek clock APIs but, in reality, this isn't
a composite clock.

Appropriately register this clock with devm_clk_hw_register_mux().
No functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index ec70e1f65eaf..e1c3ab4e146b 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1149,11 +1149,6 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	 */
 };
 
-static struct mtk_composite top_muxes[] = {
-	/* CLK_MISC_CFG_3 */
-	MUX(CLK_TOP_MFG_CK_FAST_REF, "mfg_ck_fast_ref", mfg_fast_parents, 0x0250, 8, 1),
-};
-
 static const struct mtk_composite top_adj_divs[] = {
 	DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0", "top_i2si1_mck", 0x0320, 0, 0x0328, 8, 0),
 	DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1", "top_i2si2_mck", 0x0320, 1, 0x0328, 8, 8),
@@ -1226,6 +1221,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *top_clk_data;
 	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw *hw;
 	int r;
 	void __iomem *base;
 
@@ -1253,15 +1249,17 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_factors;
 
-	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-					&mt8195_clk_lock, top_clk_data);
-	if (r)
+	hw = devm_clk_hw_register_mux(&pdev->dev, "mfg_ck_fast_ref", mfg_fast_parents,
+				      ARRAY_SIZE(mfg_fast_parents), CLK_SET_RATE_PARENT,
+				      (base + 0x250), 8, 1, 0, &mt8195_clk_lock);
+	if (IS_ERR(hw))
 		goto unregister_muxes;
+	top_clk_data->hws[CLK_TOP_MFG_CK_FAST_REF] = hw;
 
 	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 					&mt8195_clk_lock, top_clk_data);
 	if (r)
-		goto unregister_composite_muxes;
+		goto unregister_muxes;
 
 	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
 	if (r)
@@ -1279,8 +1277,6 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
 unregister_composite_divs:
 	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
-unregister_composite_muxes:
-	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
 unregister_muxes:
 	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
 unregister_factors:
@@ -1300,7 +1296,6 @@ static int clk_mt8195_topck_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
 	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
-	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
 	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
 	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-- 
2.37.2

