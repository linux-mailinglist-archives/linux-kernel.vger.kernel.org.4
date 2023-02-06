Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4776368C170
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjBFPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjBFPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDFA2A163;
        Mon,  6 Feb 2023 07:30:04 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB1926602F95;
        Mon,  6 Feb 2023 15:30:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697403;
        bh=XVC9FTPZpMoiDl28u/ygcIEs2xLwmdee412SgtM/oho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0PqhFdMIsoDZJUB0nsNdrbWMTzWg5ih6PUijYPxh4geM5TaY0F3firLVTIzrtEJr
         7fjMH59hvaunn6YQnyXNin6ZcS+h2s5Q/zEoZqQmisYXgeGrQfE+6ftjxp2AzcBbsu
         /nXt05u3d2KnnfdSu2FDVvu8SywdlvournPNylUbp9LxSQb6XBELt50+cQ3UkKTpX2
         1NiMiwLv/pK2lBdcPnGc/kqer6YhoLmcVO12krdf2IV2y2IzR9zqSBWSq1GQZ9R0Bl
         CNOVoudl1/7ctk41WWOFZ/pJbvBKFg+R6zTXh5+aJiqXVoiwPFIM03DK8YOmB9T+vf
         01uM6vOYhIZTQ==
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
Subject: [PATCH v1 12/45] clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
Date:   Mon,  6 Feb 2023 16:28:55 +0100
Message-Id: <20230206152928.918562-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

Change the custom mt8365_simple_gate to be mtk_gate clocks and
audio clocks to be composites to be consistent with all of the
other MediaTek clock drivers, allowing to convert this entire
driver to use the common mtk_clk_simple_probe() mechanism that
also allows building this driver as module.

While at it, also perform some macro compression cleanups and
switch to use module_platform_driver().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 460 ++++++++----------------------
 1 file changed, 124 insertions(+), 336 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 69f293497778..4bd624884b62 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2022 MediaTek Inc.
+ * Copyright (C) 2023 Collabora Ltd.
  */
 
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
@@ -17,7 +18,6 @@
 #include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-mux.h"
-#include "clk-pll.h"
 
 static DEFINE_SPINLOCK(mt8365_clk_lock);
 
@@ -383,31 +383,23 @@ static const char * const mbist_diag_parents[] = {
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
-struct mt8365_clk_audio_mux {
-	int id;
-	const char *name;
-	u8 shift;
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
@@ -570,35 +562,56 @@ static const struct mtk_clk_divider top_adj_divs[] = {
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
@@ -631,50 +644,24 @@ static const struct mtk_gate_regs ifr6_cg_regs = {
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
-
-#define GATE_IFR3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_IFR4(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr4_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_IFR5(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr5_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_IFR6(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr6_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFRX(_id, _name, _parent, _shift, _regs)	\
+	GATE_MTK(_id, _name, _parent, _regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr)
+
+#define GATE_IFR2(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr2_cg_regs)
+
+#define GATE_IFR3(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr3_cg_regs)
+
+#define GATE_IFR4(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr4_cg_regs)
+
+#define GATE_IFR5(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr5_cg_regs)
+
+#define GATE_IFR6(_id, _name, _parent, _shift)		\
+	GATE_IFRX(_id, _name, _parent, _shift, &ifr6_cg_regs)
 
 static const struct mtk_gate ifr_clks[] = {
 	/* IFR2 */
@@ -753,263 +740,64 @@ static const struct mtk_gate ifr_clks[] = {
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
-
-static int clk_mt8365_top_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	int ret;
-	int i;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_fixed_clks(top_fixed_clks,
-					  ARRAY_SIZE(top_fixed_clks), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
-				       clk_data);
-	if (ret)
-		goto unregister_fixed_clks;
-
-	ret = mtk_clk_register_muxes(&pdev->dev, top_muxes,
-				     ARRAY_SIZE(top_muxes), node,
-				     &mt8365_clk_lock, clk_data);
-	if (ret)
-		goto unregister_factors;
-
-	ret = mtk_clk_register_composites(&pdev->dev, top_misc_mux_gates,
-					  ARRAY_SIZE(top_misc_mux_gates), base,
-					  &mt8365_clk_lock, clk_data);
-	if (ret)
-		goto unregister_muxes;
-
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
-	ret = mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
-					base, &mt8365_clk_lock, clk_data);
-	if (ret)
-		goto unregister_composites;
-
-	ret = clk_mt8365_register_mtk_simple_gates(dev, base, clk_data,
-						   top_clk_gates,
-						   ARRAY_SIZE(top_clk_gates));
-	if (ret)
-		goto unregister_dividers;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_dividers;
-
-	return 0;
-unregister_dividers:
-	mtk_clk_unregister_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
-				    clk_data);
-unregister_composites:
-	mtk_clk_unregister_composites(top_misc_mux_gates,
-				      ARRAY_SIZE(top_misc_mux_gates), clk_data);
-unregister_muxes:
-	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
-unregister_factors:
-	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-unregister_fixed_clks:
-	mtk_clk_unregister_fixed_clks(top_fixed_clks,
-				      ARRAY_SIZE(top_fixed_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-
-	return ret;
-}
-
-static int clk_mt8365_infra_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int ret;
-
-	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
-				     ARRAY_SIZE(ifr_clks), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_gates;
-
-	return 0;
-
-unregister_gates:
-	mtk_clk_unregister_gates(ifr_clks, ARRAY_SIZE(ifr_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-
-	return ret;
-}
-
-static int clk_mt8365_peri_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct clk_hw_onecell_data *clk_data;
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_devm_alloc_clk_data(dev, CLK_PERI_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = clk_mt8365_register_mtk_simple_gates(dev, base, clk_data,
-						   peri_clks,
-						   ARRAY_SIZE(peri_clks));
-	if (ret)
-		return ret;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	return ret;
-}
-
-static int clk_mt8365_mcu_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
-					  ARRAY_SIZE(mcu_muxes), base,
-					  &mt8365_clk_lock, clk_data);
-	if (ret)
-		goto free_clk_data;
+static const struct mtk_gate peri_clks[] = {
+	GATE_MTK(CLK_PERIAXI, "periaxi", "axi_sel", &peri_cg_regs, 31,
+		 &mtk_clk_gate_ops_no_setclr),
+};
 
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_composites;
+static const struct mtk_clk_desc topck_desc = {
+	.clks = top_clk_gates,
+	.num_clks = ARRAY_SIZE(top_clk_gates),
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.composite_clks = top_misc_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_misc_muxes),
+	.divider_clks = top_adj_divs,
+	.num_divider_clks = ARRAY_SIZE(top_adj_divs),
+	.clk_lock = &mt8365_clk_lock,
+};
 
-	return 0;
+static const struct mtk_clk_desc infra_desc = {
+	.clks = ifr_clks,
+	.num_clks = ARRAY_SIZE(ifr_clks),
+};
 
-unregister_composites:
-	mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes),
-				      clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
+static const struct mtk_clk_desc peri_desc = {
+	.clks = peri_clks,
+	.num_clks = ARRAY_SIZE(peri_clks),
+};
 
-	return ret;
-}
+static const struct mtk_clk_desc mcu_desc = {
+	.composite_clks = mcu_muxes,
+	.num_composite_clks = ARRAY_SIZE(mcu_muxes),
+	.clk_lock = &mt8365_clk_lock,
+};
 
 static const struct of_device_id of_match_clk_mt8365[] = {
-	{
-		.compatible = "mediatek,mt8365-topckgen",
-		.data = clk_mt8365_top_probe,
-	}, {
-		.compatible = "mediatek,mt8365-infracfg",
-		.data = clk_mt8365_infra_probe,
-	}, {
-		.compatible = "mediatek,mt8365-pericfg",
-		.data = clk_mt8365_peri_probe,
-	}, {
-		.compatible = "mediatek,mt8365-mcucfg",
-		.data = clk_mt8365_mcu_probe,
-	}, {
-		/* sentinel */
-	}
-};
-
-static int clk_mt8365_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *pdev);
-	int ret;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	ret = clk_probe(pdev);
-	if (ret)
-		dev_err(&pdev->dev,
-			"%s: could not register clock provider: %d\n",
-			pdev->name, ret);
-
-	return ret;
-}
+	{ .compatible = "mediatek,mt8365-topckgen", .data = &topck_desc },
+	{ .compatible = "mediatek,mt8365-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt8365-pericfg", .data = &peri_desc },
+	{ .compatible = "mediatek,mt8365-mcucfg", .data = &mcu_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt8365_drv = {
-	.probe = clk_mt8365_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365",
 		.of_match_table = of_match_clk_mt8365,
 	},
 };
-
-static int __init clk_mt8365_init(void)
-{
-	return platform_driver_register(&clk_mt8365_drv);
-}
-arch_initcall(clk_mt8365_init);
+module_platform_driver(clk_mt8365_drv);
 MODULE_LICENSE("GPL");
-- 
2.39.1

