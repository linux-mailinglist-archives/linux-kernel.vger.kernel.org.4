Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E68654078
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiLVL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiLVLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:55:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE232EF98;
        Thu, 22 Dec 2022 03:49:48 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC5EF6602CF3;
        Thu, 22 Dec 2022 11:49:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709787;
        bh=Uhu9GD9MVCGtK+Cy9WGWrUBM/Iih3hCMigVFtPFuyag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ7Y1OfjWDQSfYUvuiRpJyqcgzD8sVyttmEbfKRMBXxg6khzgKulYwYmrL6BYjIW9
         BpP3OX3XZHjqDq71xfIeGQcM1DS/SwXtNa2/K0Y0h+8b2ptFPzHY97uZnk6df9UZS4
         3hj8hLPWqp7crHDNi6ZWjb7zlhZ+Jne7akKDERwfP/c/43j1Ahd5pLFXb4amrSDMIg
         QPunovZHTobnEc+2uv1qQ01pB5XumRwVAamsRTvby1TuEhxMJrG7wiUztJN01uWg2M
         5ztKNmOdK0hD7d0X3E4XI6HIsSf2Y+Plf+++MG+o6MpxwqmThVC+teLHEziylC+r7e
         UnLQQgEYnB9VQ==
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
Subject: [PATCH v1 19/25] clk: mediatek: clk-mt8183: Join top_aud_muxes and top_aud_divs
Date:   Thu, 22 Dec 2022 12:48:51 +0100
Message-Id: <20221222114857.120060-20-angelogioacchino.delregno@collabora.com>
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

Join the two to register them in one shot.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 34 +++++++++++++------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index f1d84c0730d5..be2a53b3a881 100644
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
@@ -1169,10 +1166,7 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
 		node, &mt8183_clk_lock, top_clk_data, &pdev->dev);
 
-	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-		base, &mt8183_clk_lock, top_clk_data, &pdev->dev);
-
-	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
+	mtk_clk_register_composites(top_aud_comp, ARRAY_SIZE(top_aud_comp),
 		base, &mt8183_clk_lock, top_clk_data, &pdev->dev);
 
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-- 
2.39.0

