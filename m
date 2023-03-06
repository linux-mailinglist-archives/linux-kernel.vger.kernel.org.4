Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A26AC266
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCFOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCFOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:08:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7D311EF;
        Mon,  6 Mar 2023 06:07:14 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DBC46602EDC;
        Mon,  6 Mar 2023 14:06:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111585;
        bh=WqZ5UvGPIzWucu4sfsY6VhDy9AwB8hhVyU31QRmaiDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vexw+aBJykvKqa94RRpLU430ruPYXw2BwPIdMGb+WK/pw8qh5L5WJqLF6N6KCAZw0
         tRY+VbrjzCZHxEaWPnFI3ykToEkmcqdy0mPsWn22y9V4ryy87/Dm2NS/WDXX8AADEJ
         eX1eS3RMy6EIo/fIBSamzEgSDVFpjPUSDCA0Tcfb7t0bgq1IQyQg5r4hU+JQDrHYhD
         MOv4eZMSZGWs/ykW/+GrJxlAeUUO1eyvj84oNeo16L+9grA/rhLCxvrjmLsvS3BCbX
         iaUmCYwAi6Zx/rON4AyY5bOorCQh/PQODLuRq90q5D2vaFrhpK+sVV4rxSDmuEUUkJ
         0ODJZAzyVMZSw==
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 23/54] clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag
Date:   Mon,  6 Mar 2023 15:05:12 +0100
Message-Id: <20230306140543.1813621-24-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
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

Instead of calling clk_prepare_enable() for clocks that shall stay
enabled, use the CLK_IS_CRITICAL flag, which purpose is exactly that.

Fixes: 2fc0a509e4ee ("clk: mediatek: add clock support for MT7622 SoC")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt7622.c | 35 +++++++++++++------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 41af8d420bbf..1c0049fbeb69 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -50,9 +50,9 @@
 		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,  \
 		 NULL, "clkxtal")
 
-#define GATE_APMIXED(_id, _name, _parent, _shift)			\
-	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift,		\
-		 &mtk_clk_gate_ops_no_setclr_inv)
+#define GATE_APMIXED_AO(_id, _name, _parent, _shift)			\
+	GATE_MTK_FLAGS(_id, _name, _parent, &apmixed_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv, CLK_IS_CRITICAL)
 
 #define GATE_INFRA(_id, _name, _parent, _shift)				\
 	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
@@ -66,6 +66,10 @@
 #define GATE_PERI0(_id, _name, _parent, _shift)				\
 	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_PERI0_AO(_id, _name, _parent, _shift)			\
+	GATE_MTK_FLAGS(_id, _name, _parent, &peri0_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL)
+
 #define GATE_PERI1(_id, _name, _parent, _shift)				\
 	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
@@ -315,7 +319,7 @@ static const struct mtk_pll_data plls[] = {
 };
 
 static const struct mtk_gate apmixed_clks[] = {
-	GATE_APMIXED(CLK_APMIXED_MAIN_CORE_EN, "main_core_en", "mainpll", 5),
+	GATE_APMIXED_AO(CLK_APMIXED_MAIN_CORE_EN, "main_core_en", "mainpll", 5),
 };
 
 static const struct mtk_gate infra_clks[] = {
@@ -450,7 +454,7 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI0(CLK_PERI_AP_DMA_PD, "peri_ap_dma_pd", "axi_sel", 12),
 	GATE_PERI0(CLK_PERI_MSDC30_0_PD, "peri_msdc30_0", "msdc30_0_sel", 13),
 	GATE_PERI0(CLK_PERI_MSDC30_1_PD, "peri_msdc30_1", "msdc30_1_sel", 14),
-	GATE_PERI0(CLK_PERI_UART0_PD, "peri_uart0_pd", "axi_sel", 17),
+	GATE_PERI0_AO(CLK_PERI_UART0_PD, "peri_uart0_pd", "axi_sel", 17),
 	GATE_PERI0(CLK_PERI_UART1_PD, "peri_uart1_pd", "axi_sel", 18),
 	GATE_PERI0(CLK_PERI_UART2_PD, "peri_uart2_pd", "axi_sel", 19),
 	GATE_PERI0(CLK_PERI_UART3_PD, "peri_uart3_pd", "axi_sel", 20),
@@ -478,12 +482,12 @@ static struct mtk_composite infra_muxes[] = {
 
 static struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
-		 0x040, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, "mem_sel", mem_parents,
-		 0x040, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents,
-		 0x040, 16, 1, 23),
+	MUX_GATE_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
+		       0x040, 0, 3, 7, CLK_IS_CRITICAL),
+	MUX_GATE_FLAGS(CLK_TOP_MEM_SEL, "mem_sel", mem_parents,
+		       0x040, 8, 1, 15, CLK_IS_CRITICAL),
+	MUX_GATE_FLAGS(CLK_TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents,
+		       0x040, 16, 1, 23, CLK_IS_CRITICAL),
 	MUX_GATE(CLK_TOP_ETH_SEL, "eth_sel", eth_parents,
 		 0x040, 24, 3, 31),
 
@@ -621,10 +625,6 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, top_clks,
 			       ARRAY_SIZE(top_clks), clk_data);
 
-	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
-
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
@@ -667,9 +667,6 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
-	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
-
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
@@ -697,8 +694,6 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
-
 	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
-- 
2.39.2

