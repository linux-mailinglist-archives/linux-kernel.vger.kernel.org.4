Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703216AC275
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCFOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCFOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:08:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFF311E3;
        Mon,  6 Mar 2023 06:07:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9B2C6602FCC;
        Mon,  6 Mar 2023 14:06:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111567;
        bh=KYUKmBCM6m36pnBejNkGZ8Rl2chsK2oCkXVuxlTrIws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6qr5+zAl8YcNSX/ukms2YzUUPxL7vloFTpE7LRtS4Bi3k9sTwl/FuoQ2x0NnyHve
         FFceSN3AHEB3i3KPa2MjVQSL0+h42BKiUeEgn99/3nom0y69vq5fGjtJyDy+mp9hcH
         YBb5vVtIcgLXAaA8h82KSkOu/Jw5mDqpfHuuM8W6YQlMKFNOawpw8dKe7s8n6OmPRH
         anMT+vk65E+4uOO1D9Bg1L7hwyPOp8MjAbrAluSp9M2fGvI9hOpiZKyLaNiUFjn24D
         9fJSjDZDmZeT29EhSgT/rclpX4s6yxY53ietVPtDiicpp4WBnZt8S5SxV508yzrP5d
         /f8ooyiXs3URQ==
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
Subject: [PATCH v6 12/54] clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks
Date:   Mon,  6 Mar 2023 15:05:01 +0100
Message-Id: <20230306140543.1813621-13-angelogioacchino.delregno@collabora.com>
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

On this SoC some clocks apparently don't have different offsets for
set/clr/sta registers hence they can be set, cleared and status-read
on one register: this means that it was possible to use simpler gate
clocks instead of custom mtk_gate ones.

In preparation for converting this clock driver to the common probe
mechanism for MediaTek clocks, perform a conversion from simple_gate
to mtk_gate clocks since the latter does provide implicit support
for simple gate clocks as well.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8365.c | 189 +++++++++++++-----------------
 1 file changed, 82 insertions(+), 107 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 91449a7cf608..85fe7586a69b 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2022 MediaTek Inc.
+ * Copyright (C) 2023 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
@@ -393,12 +395,6 @@ static struct mtk_composite top_misc_mux_gates[] = {
 		 0x0ec, 0, 2, 7),
 };
 
-struct mt8365_clk_audio_mux {
-	int id;
-	const char *name;
-	u8 shift;
-};
-
 static struct mt8365_clk_audio_mux top_misc_muxes[] = {
 	{ CLK_TOP_APLL_I2S0_SEL, "apll_i2s0_sel", 11},
 	{ CLK_TOP_APLL_I2S1_SEL, "apll_i2s1_sel", 12},
@@ -569,35 +565,56 @@ static const struct mtk_clk_divider top_adj_divs[] = {
 		  0x32c, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
 };
 
-struct mtk_simple_gate {
-	int id;
-	const char *name;
-	const char *parent;
-	u32 reg;
-	u8 shift;
-	unsigned long gate_flags;
-};
-
-static const struct mtk_simple_gate top_clk_gates[] = {
-	{ CLK_TOP_CONN_32K, "conn_32k", "clk32k", 0x0, 10, CLK_GATE_SET_TO_DISABLE },
-	{ CLK_TOP_CONN_26M, "conn_26m", "clk26m", 0x0, 11, CLK_GATE_SET_TO_DISABLE },
-	{ CLK_TOP_DSP_32K, "dsp_32k", "clk32k", 0x0, 16, CLK_GATE_SET_TO_DISABLE },
-	{ CLK_TOP_DSP_26M, "dsp_26m", "clk26m", 0x0, 17, CLK_GATE_SET_TO_DISABLE },
-	{ CLK_TOP_USB20_48M_EN, "usb20_48m_en", "usb20_192m_d4", 0x104, 8, 0 },
-	{ CLK_TOP_UNIVPLL_48M_EN, "univpll_48m_en", "usb20_192m_d4", 0x104, 9, 0 },
-	{ CLK_TOP_LVDSTX_CLKDIG_EN, "lvdstx_dig_en", "lvdstx_dig_cts", 0x104, 20, 0 },
-	{ CLK_TOP_VPLL_DPIX_EN, "vpll_dpix_en", "vpll_dpix", 0x104, 21, 0 },
-	{ CLK_TOP_SSUSB_TOP_CK_EN, "ssusb_top_ck_en", NULL, 0x104, 22, 0 },
-	{ CLK_TOP_SSUSB_PHY_CK_EN, "ssusb_phy_ck_en", NULL, 0x104, 23, 0 },
-	{ CLK_TOP_AUD_I2S0_M, "aud_i2s0_m_ck", "apll12_ck_div0", 0x320, 0, 0 },
-	{ CLK_TOP_AUD_I2S1_M, "aud_i2s1_m_ck", "apll12_ck_div1", 0x320, 1, 0 },
-	{ CLK_TOP_AUD_I2S2_M, "aud_i2s2_m_ck", "apll12_ck_div2", 0x320, 2, 0 },
-	{ CLK_TOP_AUD_I2S3_M, "aud_i2s3_m_ck", "apll12_ck_div3", 0x320, 3, 0 },
-	{ CLK_TOP_AUD_TDMOUT_M, "aud_tdmout_m_ck", "apll12_ck_div4", 0x320, 4, 0 },
-	{ CLK_TOP_AUD_TDMOUT_B, "aud_tdmout_b_ck", "apll12_ck_div4b", 0x320, 5, 0 },
-	{ CLK_TOP_AUD_TDMIN_M, "aud_tdmin_m_ck", "apll12_ck_div5", 0x320, 6, 0 },
-	{ CLK_TOP_AUD_TDMIN_B, "aud_tdmin_b_ck", "apll12_ck_div5b", 0x320, 7, 0 },
-	{ CLK_TOP_AUD_SPDIF_M, "aud_spdif_m_ck", "apll12_ck_div6", 0x320, 8, 0 },
+static const struct mtk_gate_regs top0_cg_regs = {
+	.set_ofs = 0,
+	.clr_ofs = 0,
+	.sta_ofs = 0,
+};
+
+static const struct mtk_gate_regs top1_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x104,
+	.sta_ofs = 0x104,
+};
+
+static const struct mtk_gate_regs top2_cg_regs = {
+	.set_ofs = 0x320,
+	.clr_ofs = 0x320,
+	.sta_ofs = 0x320,
+};
+
+#define GATE_TOP0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs,		\
+		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_TOP1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs,		\
+		 _shift, &mtk_clk_gate_ops_no_setclr)
+
+#define GATE_TOP2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs,		\
+		 _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate top_clk_gates[] = {
+	GATE_TOP0(CLK_TOP_CONN_32K, "conn_32k", "clk32k", 10),
+	GATE_TOP0(CLK_TOP_CONN_26M, "conn_26m", "clk26m", 11),
+	GATE_TOP0(CLK_TOP_DSP_32K, "dsp_32k", "clk32k", 16),
+	GATE_TOP0(CLK_TOP_DSP_26M, "dsp_26m", "clk26m", 17),
+	GATE_TOP1(CLK_TOP_USB20_48M_EN, "usb20_48m_en", "usb20_192m_d4", 8),
+	GATE_TOP1(CLK_TOP_UNIVPLL_48M_EN, "univpll_48m_en", "usb20_192m_d4", 9),
+	GATE_TOP1(CLK_TOP_LVDSTX_CLKDIG_EN, "lvdstx_dig_en", "lvdstx_dig_cts", 20),
+	GATE_TOP1(CLK_TOP_VPLL_DPIX_EN, "vpll_dpix_en", "vpll_dpix", 21),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_CK_EN, "ssusb_top_ck_en", NULL, 22),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_CK_EN, "ssusb_phy_ck_en", NULL, 23),
+	GATE_TOP2(CLK_TOP_AUD_I2S0_M, "aud_i2s0_m_ck", "apll12_ck_div0", 0),
+	GATE_TOP2(CLK_TOP_AUD_I2S1_M, "aud_i2s1_m_ck", "apll12_ck_div1", 1),
+	GATE_TOP2(CLK_TOP_AUD_I2S2_M, "aud_i2s2_m_ck", "apll12_ck_div2", 2),
+	GATE_TOP2(CLK_TOP_AUD_I2S3_M, "aud_i2s3_m_ck", "apll12_ck_div3", 3),
+	GATE_TOP2(CLK_TOP_AUD_TDMOUT_M, "aud_tdmout_m_ck", "apll12_ck_div4", 4),
+	GATE_TOP2(CLK_TOP_AUD_TDMOUT_B, "aud_tdmout_b_ck", "apll12_ck_div4b", 5),
+	GATE_TOP2(CLK_TOP_AUD_TDMIN_M, "aud_tdmin_m_ck", "apll12_ck_div5", 6),
+	GATE_TOP2(CLK_TOP_AUD_TDMIN_B, "aud_tdmin_b_ck", "apll12_ck_div5b", 7),
+	GATE_TOP2(CLK_TOP_AUD_SPDIF_M, "aud_spdif_m_ck", "apll12_ck_div6", 8),
 };
 
 static const struct mtk_gate_regs ifr2_cg_regs = {
@@ -630,50 +647,24 @@ static const struct mtk_gate_regs ifr6_cg_regs = {
 	.sta_ofs = 0xd8,
 };
 
-#define GATE_IFR2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFRX(_id, _name, _parent, _shift, _regs)	\
+	GATE_MTK(_id, _name, _parent, _regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR2(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr2_cg_regs)
 
-#define GATE_IFR4(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr4_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR3(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr3_cg_regs)
 
-#define GATE_IFR5(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr5_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR4(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr4_cg_regs)
 
-#define GATE_IFR6(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr6_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR5(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr5_cg_regs)
+
+#define GATE_IFR6(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr6_cg_regs)
 
 static const struct mtk_gate ifr_clks[] = {
 	/* IFR2 */
@@ -752,33 +743,16 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR6(CLK_IFR_SSUSB_XHCI, "ifr_ssusb_xhci", "ssusb_xhci_sel", 11),
 };
 
-static const struct mtk_simple_gate peri_clks[] = {
-	{ CLK_PERIAXI, "periaxi", "axi_sel", 0x20c, 31, 0 },
+static const struct mtk_gate_regs peri_cg_regs = {
+	.set_ofs = 0x20c,
+	.clr_ofs = 0x20c,
+	.sta_ofs = 0x20c,
 };
 
-static int
-clk_mt8365_register_mtk_simple_gates(struct device *dev, void __iomem *base,
-				     struct clk_hw_onecell_data *clk_data,
-				     const struct mtk_simple_gate *gates,
-				     unsigned int num_gates)
-{
-	unsigned int i;
-
-	for (i = 0; i != num_gates; ++i) {
-		const struct mtk_simple_gate *gate = &gates[i];
-		struct clk_hw *hw;
-
-		hw = devm_clk_hw_register_gate(dev, gate->name, gate->parent, 0,
-					       base + gate->reg, gate->shift,
-					       gate->gate_flags, NULL);
-		if (IS_ERR(hw))
-			return PTR_ERR(hw);
-
-		clk_data->hws[gate->id] = hw;
-	}
-
-	return 0;
-}
+static const struct mtk_gate peri_clks[] = {
+	GATE_MTK(CLK_PERIAXI, "periaxi", "axi_sel", &peri_cg_regs, 31,
+		 &mtk_clk_gate_ops_no_setclr),
+};
 
 static int clk_mt8365_top_probe(struct platform_device *pdev)
 {
@@ -840,17 +814,18 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_composites;
 
-	ret = clk_mt8365_register_mtk_simple_gates(dev, base, clk_data,
-						   top_clk_gates,
-						   ARRAY_SIZE(top_clk_gates));
+	ret = mtk_clk_register_gates(&pdev->dev, node, top_clk_gates,
+				     ARRAY_SIZE(top_clk_gates), clk_data);
 	if (ret)
 		goto unregister_dividers;
 
 	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (ret)
-		goto unregister_dividers;
+		goto unregister_gates;
 
 	return 0;
+unregister_gates:
+	mtk_clk_unregister_gates(top_clk_gates, ARRAY_SIZE(top_clk_gates), clk_data);
 unregister_dividers:
 	mtk_clk_unregister_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				    clk_data);
@@ -915,9 +890,9 @@ static int clk_mt8365_peri_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = clk_mt8365_register_mtk_simple_gates(dev, base, clk_data,
-						   peri_clks,
-						   ARRAY_SIZE(peri_clks));
+
+	ret = mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+				     ARRAY_SIZE(peri_clks), clk_data);
 	if (ret)
 		return ret;
 
-- 
2.39.2

