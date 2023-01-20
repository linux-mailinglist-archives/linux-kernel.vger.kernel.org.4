Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F367675110
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjATJ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjATJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:27:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7959E6E;
        Fri, 20 Jan 2023 01:27:30 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 99CF86602F47;
        Fri, 20 Jan 2023 09:21:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206488;
        bh=L0Mz/P3KB8addEISdXHQv+iKk4/hljSZDtHjdPB07W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUkt+K5RSojrMkgun+wpkaHJFYH9xXyk4ZYN70U/AF5Qxd177UQk5Gct/97gYDgCa
         UJQkmMtNoeIakpBLASllVC5slDcfu1VicsRJfBD4Dz7ydTQEIWutldJ01Dzy9hQR9Z
         1/F7eZa7Pf8tF/lhaxCTd8Cu/pukJSNpX6epakR1ifY52jMWgFAjE7ytP4ynn0i3UF
         jDUABniB4s63auGugKADDM7yYjqo2UA4oPC0urlnM/08lpn7Al6l9Y2bumq4OSd/lM
         IKlxXA3uODBFqdzS6m7a4ZlhTotOOWlEhjEO/wNYOIh5JnrJihqppQ5yGzIjdWnsTd
         rLJ+nkK/g+iBQ==
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
Subject: [PATCH v4 17/23] clk: mediatek: clk-mt8183: Join top_aud_muxes and top_aud_divs
Date:   Fri, 20 Jan 2023 10:20:47 +0100
Message-Id: <20230120092053.182923-18-angelogioacchino.delregno@collabora.com>
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

