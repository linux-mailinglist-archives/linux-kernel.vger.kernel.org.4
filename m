Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FE6750D0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjATJWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjATJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:21:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4D94CB1;
        Fri, 20 Jan 2023 01:21:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14B566602DC9;
        Fri, 20 Jan 2023 09:21:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206474;
        bh=NchnhQJ8/NsCOmF+ugDdtTzoMIg4fvva0j2fRFAtkyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ym3GUvmDcHUhj2hVfLbLhwJu5GrhxUte7qsmKfbw94ljY/MVH0OXQAgiyQtveCvuo
         6MRMEeJVICdC9+k/Q+qEZhOUMjAjmSPsAKMloHpE4qOumlMLgW1gnLIdVM6h99Dl2e
         7yS46Jrnoc1e+O2lsMiIxxF7q0ljkin5CnoHj1T9AsrINr3Jym+ydQjFTXDLaEryc1
         pCTM/5ln51Gwtp72Vw6QisvhH+2/yItFpWBllkf/WNpreK1vgXLctmiLMl6wb0Qc1p
         UFUzo1u2+V8qwbh3zgEwhsrjZrzogrfLNEbAYrYyJCT1PCB1u1YpmjLPvxYz6dmsON
         n6zOoYdgzP0Ig==
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
Subject: [PATCH v4 09/23] clk: mediatek: mt8173: Remove mtk_clk_enable_critical()
Date:   Fri, 20 Jan 2023 10:20:39 +0100
Message-Id: <20230120092053.182923-10-angelogioacchino.delregno@collabora.com>
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

The entire point of mtk_clk_enable_critical() is to raise the refcount
of some clocks so that they won't be turned off during runtime, but
this is the same as what the CLK_IS_CRITICAL flag does.

Set CLK_IS_CRITICAL on all of the critical clocks and remove the
aforementioned function as a cleanup.

No functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8173.c | 41 ++++++++++++-------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 0163d27e8795..787ab87036a0 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -546,8 +546,11 @@ static const struct mtk_composite cpu_muxes[] = {
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX(CLK_TOP_AXI_SEL, "axi_sel", axi_parents, 0x0040, 0, 3),
-	MUX(CLK_TOP_MEM_SEL, "mem_sel", mem_parents, 0x0040, 8, 1),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents, 0x0040, 16, 1, 23),
+	MUX_FLAGS(CLK_TOP_MEM_SEL, "mem_sel", mem_parents, 0x0040, 8, 1,
+		  CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
+	MUX_GATE_FLAGS(CLK_TOP_DDRPHYCFG_SEL, "ddrphycfg_sel",
+		       ddrphycfg_parents, 0x0040, 16, 1, 23,
+		       CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE(CLK_TOP_MM_SEL, "mm_sel", mm_parents, 0x0040, 24, 4, 31),
 	/* CLK_CFG_1 */
 	MUX_GATE(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x0050, 0, 2, 7),
@@ -581,7 +584,9 @@ static const struct mtk_composite top_muxes[] = {
 	 */
 	MUX_GATE_FLAGS(CLK_TOP_DPI0_SEL, "dpi0_sel", dpi0_parents, 0x00a0, 0, 3, 7, 0),
 	MUX_GATE(CLK_TOP_IRDA_SEL, "irda_sel", irda_parents, 0x00a0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_CCI400_SEL, "cci400_sel", cci400_parents, 0x00a0, 16, 3, 23),
+	MUX_GATE_FLAGS(CLK_TOP_CCI400_SEL, "cci400_sel",
+		       cci400_parents, 0x00a0, 16, 3, 23,
+		       CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE(CLK_TOP_AUD_1_SEL, "aud_1_sel", aud_1_parents, 0x00a0, 24, 2, 31),
 	/* CLK_CFG_7 */
 	MUX_GATE(CLK_TOP_AUD_2_SEL, "aud_2_sel", aud_2_parents, 0x00b0, 0, 2, 7),
@@ -596,7 +601,8 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents, 0x00d0, 0, 3, 7),
 	MUX_GATE(CLK_TOP_HDCP_SEL, "hdcp_sel", hdcp_parents, 0x00d0, 8, 2, 15),
 	MUX_GATE(CLK_TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents, 0x00d0, 16, 2, 23),
-	MUX(CLK_TOP_RTC_SEL, "rtc_sel", rtc_parents, 0x00d0, 24, 2),
+	MUX_FLAGS(CLK_TOP_RTC_SEL, "rtc_sel", rtc_parents, 0x00d0, 24, 2,
+		  CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 
 	DIV_GATE(CLK_TOP_APLL1_DIV0, "apll1_div0", "aud_1_sel", 0x12c, 8, 0x120, 4, 24),
 	DIV_GATE(CLK_TOP_APLL1_DIV1, "apll1_div1", "aud_1_sel", 0x12c, 9, 0x124, 8, 0),
@@ -846,23 +852,8 @@ static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	}
 };
 
-static struct clk_hw_onecell_data *mt8173_top_clk_data;
-static struct clk_hw_onecell_data *mt8173_pll_clk_data;
 static struct clk_hw_onecell_data *infra_clk_data;
 
-static void mtk_clk_enable_critical(void)
-{
-	if (!mt8173_top_clk_data || !mt8173_pll_clk_data)
-		return;
-
-	clk_prepare_enable(mt8173_pll_clk_data->hws[CLK_APMIXED_ARMCA15PLL]->clk);
-	clk_prepare_enable(mt8173_pll_clk_data->hws[CLK_APMIXED_ARMCA7PLL]->clk);
-	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_MEM_SEL]->clk);
-	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
-	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_CCI400_SEL]->clk);
-	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_RTC_SEL]->clk);
-}
-
 static int clk_mt8173_topck_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -874,7 +865,7 @@ static int clk_mt8173_topck_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mt8173_top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 	if (IS_ERR_OR_NULL(clk_data))
 		return -ENOMEM;
 
@@ -896,7 +887,6 @@ static int clk_mt8173_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_composites;
 
-	mtk_clk_enable_critical();
 	return 0;
 
 unregister_composites:
@@ -1051,8 +1041,10 @@ static const struct mtk_pll_div_table mmpll_div_table[] = {
 };
 
 static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0, 0, 21, 0x204, 24, 0x0, 0x204, 0),
-	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0, 0, 21, 0x214, 24, 0x0, 0x214, 0),
+	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0, PLL_AO,
+	    21, 0x204, 24, 0x0, 0x204, 0),
+	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0, PLL_AO,
+	    21, 0x214, 24, 0x0, 0x214, 0),
 	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000100, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
 	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000000, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
 	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
@@ -1079,7 +1071,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	if (!base)
 		return PTR_ERR(base);
 
-	mt8173_pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (IS_ERR_OR_NULL(clk_data))
 		return -ENOMEM;
 
@@ -1104,7 +1096,6 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_ref2usb;
 
-	mtk_clk_enable_critical();
 	return 0;
 
 unregister_ref2usb:
-- 
2.39.0

