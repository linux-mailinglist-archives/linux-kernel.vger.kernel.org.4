Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D856695AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjAMLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbjAMLdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:33:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B948827;
        Fri, 13 Jan 2023 03:07:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 659916602DD0;
        Fri, 13 Jan 2023 11:07:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673608045;
        bh=L0Mz/P3KB8addEISdXHQv+iKk4/hljSZDtHjdPB07W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3NMTqFnOD4XKNcv1qoKa8tDJ685PPecyHWBsS25XBib08oLin0V2NkRBZ2iEP/17
         sQuXG3vBs983FZ4lnGCDG5hLbk/rGx7SAr9xXbHl7F6eWpYlFC24WqHLyOfdmcLZTp
         AociwIORtq+ouvO3P5QWBAdsA4yIBG7ZcJHwMh2ZNtrf0NgReZUI+AeQx8f5S4KTiF
         muJKCrURB7PLtovSvEKWL5FKKIDydGIuqrupQweW8tFw5ZlQ/7PICpoaGzk3itLviI
         Hc0eaVt2mqIh32GQccNDtxz+WJuAgU7XtmP9YdS5BDDur9+LbASk9VvcSt3/jML7iS
         CqK+cefxFkCbg==
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
Subject: [PATCH v3 17/23] clk: mediatek: clk-mt8183: Join top_aud_muxes and top_aud_divs
Date:   Fri, 13 Jan 2023 12:06:10 +0100
Message-Id: <20230113110616.111001-18-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
References: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
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

Join the two to register them in one shot.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8183.c | 37 +++++++++++++------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index cc4f71bffba1..722d913f0b4d 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -613,21 +613,6 @@ static const char * const apll_i2s5_parents[] = {
 	"aud_2_sel"
 };
 
-static struct mtk_composite top_aud_muxes[] = {
-	MUX(CLK_TOP_MUX_APLL_I2S0, "apll_i2s0_sel", apll_i2s0_parents,
-		0x320, 8, 1),
-	MUX(CLK_TOP_MUX_APLL_I2S1, "apll_i2s1_sel", apll_i2s1_parents,
-		0x320, 9, 1),
-	MUX(CLK_TOP_MUX_APLL_I2S2, "apll_i2s2_sel", apll_i2s2_parents,
-		0x320, 10, 1),
-	MUX(CLK_TOP_MUX_APLL_I2S3, "apll_i2s3_sel", apll_i2s3_parents,
-		0x320, 11, 1),
-	MUX(CLK_TOP_MUX_APLL_I2S4, "apll_i2s4_sel", apll_i2s4_parents,
-		0x320, 12, 1),
-	MUX(CLK_TOP_MUX_APLL_I2S5, "apll_i2s5_sel", apll_i2s5_parents,
-		0x328, 20, 1),
-};
-
 static const char * const mcu_mp0_parents[] = {
 	"clk26m",
 	"armpll_ll",
@@ -658,7 +643,19 @@ static struct mtk_composite mcu_muxes[] = {
 	MUX(CLK_MCU_BUS_SEL, "mcu_bus_sel", mcu_bus_parents, 0x7C0, 9, 2),
 };
 
-static struct mtk_composite top_aud_divs[] = {
+static struct mtk_composite top_aud_comp[] = {
+	MUX(CLK_TOP_MUX_APLL_I2S0, "apll_i2s0_sel", apll_i2s0_parents,
+		0x320, 8, 1),
+	MUX(CLK_TOP_MUX_APLL_I2S1, "apll_i2s1_sel", apll_i2s1_parents,
+		0x320, 9, 1),
+	MUX(CLK_TOP_MUX_APLL_I2S2, "apll_i2s2_sel", apll_i2s2_parents,
+		0x320, 10, 1),
+	MUX(CLK_TOP_MUX_APLL_I2S3, "apll_i2s3_sel", apll_i2s3_parents,
+		0x320, 11, 1),
+	MUX(CLK_TOP_MUX_APLL_I2S4, "apll_i2s4_sel", apll_i2s4_parents,
+		0x320, 12, 1),
+	MUX(CLK_TOP_MUX_APLL_I2S5, "apll_i2s5_sel", apll_i2s5_parents,
+		0x328, 20, 1),
 	DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0", "apll_i2s0_sel",
 		0x320, 2, 0x324, 8, 0),
 	DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1", "apll_i2s1_sel",
@@ -1170,12 +1167,8 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 			       ARRAY_SIZE(top_muxes), node,
 			       &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
-				    ARRAY_SIZE(top_aud_muxes), base,
-				    &mt8183_clk_lock, top_clk_data);
-
-	mtk_clk_register_composites(&pdev->dev, top_aud_divs,
-				    ARRAY_SIZE(top_aud_divs), base,
+	mtk_clk_register_composites(&pdev->dev, top_aud_comp,
+				    ARRAY_SIZE(top_aud_comp), base,
 				    &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_gates(&pdev->dev, node, top_clks,
-- 
2.39.0

