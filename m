Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8669F174
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjBVJ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjBVJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:26:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECFB37F1D;
        Wed, 22 Feb 2023 01:26:14 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 39F5B660215E;
        Wed, 22 Feb 2023 09:26:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677057973;
        bh=Iu6k+PbPBvtvaUy/uF3aIBmcGMGBX1+Dm5St8Qyg5Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VP1r4Nca1HN30QGUdL3e6Zco8UR2mSkMgMB6alrC3slWmG6oFJ2GyhiENSFOgz+Jx
         JbvFx2JcoexmJ3Elx/EoAlAAQeClOhr5I9niBPXyzAPIoPNqJJ/8eWp4DboMWDDqiV
         7qBfVLJzTsb95XNekrxSdm3lB6c/2qOWroDDKzbHSs/BhBN2xpOS6tdL6HPY2+ROz/
         GUvhHRraiTzCZ7c2so2qEAZwONWErJl0NfPcBe2d9Ud1khpWAzmYum/1ncKtLWruf7
         aQO9704mEvakH2zrDGxpiVkGPyJcycJK5m6sgpQdtaj1zlA37jA0aeXBsZxSq9jaBE
         ikYuZ3mR82w6g==
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
Subject: [PATCH v5 13/54] clk: mediatek: mt8365: Join top_misc_mux_gates and top_misc_muxes arrays
Date:   Wed, 22 Feb 2023 10:25:02 +0100
Message-Id: <20230222092543.19187-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
References: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
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

In preparation for migrating this driver to the simple probe mechanism,
join the audio gates to the top_misc_mux_gates array of mtk_composite
clocks in one top_misc_muxes array.

While at it, since the `apll_i2s0_parents` array is for all i2s clocks,
rename that to `apll_i2s_parents`.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8365.c | 46 ++++++++++---------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 85fe7586a69b..fef6c653c9ce 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -384,25 +384,23 @@ static const char * const mbist_diag_parents[] = {
 	"univpll2_d8"
 };
 
-static const char * const apll_i2s0_parents[] = {
+static const char * const apll_i2s_parents[] = {
 	"aud_1_sel",
 	"aud_2_sel"
 };
 
-static struct mtk_composite top_misc_mux_gates[] = {
+static struct mtk_composite top_misc_muxes[] = {
 	/* CLK_CFG_11 */
 	MUX_GATE(CLK_TOP_MBIST_DIAG_SEL, "mbist_diag_sel", mbist_diag_parents,
 		 0x0ec, 0, 2, 7),
-};
-
-static struct mt8365_clk_audio_mux top_misc_muxes[] = {
-	{ CLK_TOP_APLL_I2S0_SEL, "apll_i2s0_sel", 11},
-	{ CLK_TOP_APLL_I2S1_SEL, "apll_i2s1_sel", 12},
-	{ CLK_TOP_APLL_I2S2_SEL, "apll_i2s2_sel", 13},
-	{ CLK_TOP_APLL_I2S3_SEL, "apll_i2s3_sel", 14},
-	{ CLK_TOP_APLL_TDMOUT_SEL, "apll_tdmout_sel", 15},
-	{ CLK_TOP_APLL_TDMIN_SEL, "apll_tdmin_sel", 16},
-	{ CLK_TOP_APLL_SPDIF_SEL, "apll_spdif_sel", 17},
+	/* Audio MUX */
+	MUX(CLK_TOP_APLL_I2S0_SEL, "apll_i2s0_sel", apll_i2s_parents, 0x0320, 11, 1),
+	MUX(CLK_TOP_APLL_I2S1_SEL, "apll_i2s1_sel", apll_i2s_parents, 0x0320, 12, 1),
+	MUX(CLK_TOP_APLL_I2S2_SEL, "apll_i2s2_sel", apll_i2s_parents, 0x0320, 13, 1),
+	MUX(CLK_TOP_APLL_I2S3_SEL, "apll_i2s3_sel", apll_i2s_parents, 0x0320, 14, 1),
+	MUX(CLK_TOP_APLL_TDMOUT_SEL, "apll_tdmout_sel", apll_i2s_parents, 0x0320, 15, 1),
+	MUX(CLK_TOP_APLL_TDMIN_SEL, "apll_tdmin_sel", apll_i2s_parents, 0x0320, 16, 1),
+	MUX(CLK_TOP_APLL_SPDIF_SEL, "apll_spdif_sel", apll_i2s_parents, 0x0320, 17, 1),
 };
 
 #define CLK_CFG_UPDATE 0x004
@@ -787,28 +785,12 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_factors;
 
-	ret = mtk_clk_register_composites(&pdev->dev, top_misc_mux_gates,
-					  ARRAY_SIZE(top_misc_mux_gates), base,
+	ret = mtk_clk_register_composites(&pdev->dev, top_misc_muxes,
+					  ARRAY_SIZE(top_misc_muxes), base,
 					  &mt8365_clk_lock, clk_data);
 	if (ret)
 		goto unregister_muxes;
 
-	for (i = 0; i != ARRAY_SIZE(top_misc_muxes); ++i) {
-		struct mt8365_clk_audio_mux *mux = &top_misc_muxes[i];
-		struct clk_hw *hw;
-
-		hw = devm_clk_hw_register_mux(dev, mux->name, apll_i2s0_parents,
-					      ARRAY_SIZE(apll_i2s0_parents),
-					      CLK_SET_RATE_PARENT, base + 0x320,
-					      mux->shift, 1, 0, NULL);
-		if (IS_ERR(hw)) {
-			ret = PTR_ERR(hw);
-			goto unregister_composites;
-		}
-
-		clk_data->hws[mux->id] = hw;
-	}
-
 	ret = mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 					base, &mt8365_clk_lock, clk_data);
 	if (ret)
@@ -830,8 +812,8 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 	mtk_clk_unregister_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				    clk_data);
 unregister_composites:
-	mtk_clk_unregister_composites(top_misc_mux_gates,
-				      ARRAY_SIZE(top_misc_mux_gates), clk_data);
+	mtk_clk_unregister_composites(top_misc_muxes,
+				      ARRAY_SIZE(top_misc_muxes), clk_data);
 unregister_muxes:
 	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
 unregister_factors:
-- 
2.39.2

