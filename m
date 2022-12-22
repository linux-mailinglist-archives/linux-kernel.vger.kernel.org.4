Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE826654063
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiLVL4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiLVLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:55:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BA2CCB8;
        Thu, 22 Dec 2022 03:49:45 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A3A76602D06;
        Thu, 22 Dec 2022 11:49:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709784;
        bh=p4HuxSnc6rYIjz4n4YZOsHO8uVPvIY0fR52pGIHTaV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbP/ly7JKiBIW4uKo5D7fUJv2akHh+vniPP8hKkXDl1Uj4J463fdO8zKB4Ch6jfVa
         DtQd7nsrAkZbvgRY18+/u74sAyjKdZMNP3TpcrNoKTrHiXcFDsyvOCOJFCzpVJCCPb
         WqTdql2eb0HFsqOeHxK9k8cw5O5cU2+kFrcIUm4a5vVmcSbhdmXjbVeqMTJ9wiQkFV
         0eOBNaFeRHSJxXDA0PoPNf+QVkOubUd8xLknnZudnSkBoNhQEq2+uqYA/KwxXQk4ZL
         ZVDDVAz7ZCQE5BEshotByCmn6XH/gvlMrrEMsTnjKi3PNGQVuNKyl3Lx9BFUGboRq3
         syfLUhNenEjCQ==
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
Subject: [PATCH v1 17/25] clk: mediatek: mt8192: Join top_adj_divs and top_muxes
Date:   Thu, 22 Dec 2022 12:48:49 +0100
Message-Id: <20221222114857.120060-18-angelogioacchino.delregno@collabora.com>
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

These two are both mtk_composite arrays, one dependent on another, but
that's something that the clock framework is supposed to sort out and
anyway registering them separately isn't going to ease the framework's
job in checking dependencies.

Put the contents of top_adj_divs in top_muxes to join them together
and register them in one shot.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ec9dc7fe848e..702770326286 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -698,9 +698,7 @@ static struct mtk_composite top_muxes[] = {
 	MUX(CLK_TOP_APLL_I2S7_M_SEL, "apll_i2s7_m_sel", apll_i2s_m_parents, 0x320, 23, 1),
 	MUX(CLK_TOP_APLL_I2S8_M_SEL, "apll_i2s8_m_sel", apll_i2s_m_parents, 0x320, 24, 1),
 	MUX(CLK_TOP_APLL_I2S9_M_SEL, "apll_i2s9_m_sel", apll_i2s_m_parents, 0x320, 25, 1),
-};
-
-static const struct mtk_composite top_adj_divs[] = {
+	/* APLL_DIV */
 	DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0", "apll_i2s0_m_sel", 0x320, 0, 0x328, 8, 0),
 	DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1", "apll_i2s1_m_sel", 0x320, 1, 0x328, 8, 8),
 	DIV_GATE(CLK_TOP_APLL12_DIV2, "apll12_div2", "apll_i2s2_m_sel", 0x320, 2, 0x328, 8, 16),
@@ -1099,15 +1097,10 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
-					&mt8192_clk_lock, top_clk_data, &pdev->dev);
-	if (r)
-		goto unregister_top_composites;
-
 	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 					    top_clk_data, &pdev->dev);
 	if (r)
-		goto unregister_adj_divs_composites;
+		goto unregister_top_composites;
 
 	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
 					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
@@ -1119,8 +1112,6 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 
 unregister_gates:
 	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
-unregister_adj_divs_composites:
-	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
 unregister_top_composites:
 	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
 unregister_muxes:
-- 
2.39.0

