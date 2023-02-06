Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E068C177
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjBFPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjBFPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59470C650;
        Mon,  6 Feb 2023 07:30:11 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D94EB6602EC7;
        Mon,  6 Feb 2023 15:30:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697410;
        bh=rVIZwOv1lVqrfGH40KERixGvOgnC4BRbxSCtwjh30p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ez1Fi0VkRgyXpBsnG//MS1fTnkhCG1j6+RcYFedPLv4bvxy89vu3GQyiIvweK4EF7
         8Hs1ekmfhIfkQ19jy/lnWFsv8VYakVcN/6AfGD6x+n8v6xeMhrkJoZ+R9pRerkIkv6
         lIekezc2EKHh4QPi1Dz0+tvLa//yC0scY3CAdhix5qzRdWZHK0SWNuIFTG25vnBzs9
         V7tOt4/c3zwaRhlhJvy9jN1V2phMNGsBVRkMvOlwjCeeBzHRG/hNZnNuw6Gq4zwXK6
         fi75FH3k2udzb53Dz2gA2K7DcXZTE/9Bg1UrNs7KSCo84ID2SajWRVO02qbCqrr8KG
         PQoq3gzoFy/TA==
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
Subject: [PATCH v1 17/45] clk: mediatek: mt8183: Move apmixedsys clock driver to its own file
Date:   Mon,  6 Feb 2023 16:29:00 +0100
Message-Id: <20230206152928.918562-18-angelogioacchino.delregno@collabora.com>
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

In preparation for migrating all other mt8183 clocks to the common
mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
While at it, use the builtin_platform_driver() macro for it and fix
some indentation issues in the PLLs table.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile                |   2 +-
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c | 192 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8183.c            | 153 ---------------
 3 files changed, 193 insertions(+), 154 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8183-apmixedsys.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 7fda42b76533..10038a0f25e0 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_COMMON_CLK_MT8173_IMGSYS) += clk-mt8173-img.o
 obj-$(CONFIG_COMMON_CLK_MT8173_MMSYS) += clk-mt8173-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8173_VDECSYS) += clk-mt8173-vdecsys.o
 obj-$(CONFIG_COMMON_CLK_MT8173_VENCSYS) += clk-mt8173-vencsys.o
-obj-$(CONFIG_COMMON_CLK_MT8183) += clk-mt8183.o
+obj-$(CONFIG_COMMON_CLK_MT8183) += clk-mt8183.o clk-mt8183-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8183_AUDIOSYS) += clk-mt8183-audio.o
 obj-$(CONFIG_COMMON_CLK_MT8183_CAMSYS) += clk-mt8183-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8183_IMGSYS) += clk-mt8183-img.o
diff --git a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
new file mode 100644
index 000000000000..710d344fa2cd
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Copyright (c) 2023 Collabora, Ltd.
+ *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8183-clk.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+static const struct mtk_gate_regs apmixed_cg_regs = {
+	.set_ofs = 0x20,
+	.clr_ofs = 0x20,
+	.sta_ofs = 0x20,
+};
+
+#define GATE_APMIXED_FLAGS(_id, _name, _parent, _shift, _flags)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &apmixed_cg_regs,	\
+		_shift, &mtk_clk_gate_ops_no_setclr_inv, _flags)
+
+#define GATE_APMIXED(_id, _name, _parent, _shift)		\
+	GATE_APMIXED_FLAGS(_id, _name, _parent, _shift,	0)
+
+/*
+ * CRITICAL CLOCK:
+ * apmixed_appll26m is the toppest clock gate of all PLLs.
+ */
+static const struct mtk_gate apmixed_clks[] = {
+	/* AUDIO0 */
+	GATE_APMIXED(CLK_APMIXED_SSUSB_26M, "apmixed_ssusb26m", "f_f26m_ck", 4),
+	GATE_APMIXED_FLAGS(CLK_APMIXED_APPLL_26M, "apmixed_appll26m",
+			   "f_f26m_ck", 5, CLK_IS_CRITICAL),
+	GATE_APMIXED(CLK_APMIXED_MIPIC0_26M, "apmixed_mipic026m", "f_f26m_ck", 6),
+	GATE_APMIXED(CLK_APMIXED_MDPLLGP_26M, "apmixed_mdpll26m", "f_f26m_ck", 7),
+	GATE_APMIXED(CLK_APMIXED_MMSYS_26M, "apmixed_mmsys26m", "f_f26m_ck", 8),
+	GATE_APMIXED(CLK_APMIXED_UFS_26M, "apmixed_ufs26m", "f_f26m_ck", 9),
+	GATE_APMIXED(CLK_APMIXED_MIPIC1_26M, "apmixed_mipic126m", "f_f26m_ck", 11),
+	GATE_APMIXED(CLK_APMIXED_MEMPLL_26M, "apmixed_mempll26m", "f_f26m_ck", 13),
+	GATE_APMIXED(CLK_APMIXED_CLKSQ_LVPLL_26M, "apmixed_lvpll26m", "f_f26m_ck", 14),
+	GATE_APMIXED(CLK_APMIXED_MIPID0_26M, "apmixed_mipid026m", "f_f26m_ck", 16),
+	GATE_APMIXED(CLK_APMIXED_MIPID1_26M, "apmixed_mipid126m", "f_f26m_ck", 17),
+};
+
+#define MT8183_PLL_FMAX		(3800UL * MHZ)
+#define MT8183_PLL_FMIN		(1500UL * MHZ)
+
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
+			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
+			_pd_shift, _tuner_reg,  _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcw_chg_reg, _div_table) {			\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT8183_PLL_FMAX,				\
+		.fmin = MT8183_PLL_FMIN,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = _pcwibits,					\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcw_chg_reg = _pcw_chg_reg,				\
+		.div_table = _div_table,				\
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
+			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcw_chg_reg)					\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
+			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcw_chg_reg, NULL)
+
+static const struct mtk_pll_div_table armpll_div_table[] = {
+	{ .div = 0, .freq = MT8183_PLL_FMAX },
+	{ .div = 1, .freq = 1500 * MHZ },
+	{ .div = 2, .freq = 750 * MHZ },
+	{ .div = 3, .freq = 375 * MHZ },
+	{ .div = 4, .freq = 187500000 },
+	{ /* sentinel */ }
+};
+
+static const struct mtk_pll_div_table mfgpll_div_table[] = {
+	{ .div = 0, .freq = MT8183_PLL_FMAX },
+	{ .div = 1, .freq = 1600 * MHZ },
+	{ .div = 2, .freq = 800 * MHZ },
+	{ .div = 3, .freq = 400 * MHZ },
+	{ .div = 4, .freq = 200 * MHZ },
+	{ /* sentinel */ }
+};
+
+static const struct mtk_pll_data plls[] = {
+	PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0,
+	      HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0204, 24, 0x0, 0x0, 0,
+	      0x0204, 0, 0, armpll_div_table),
+	PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0,
+	      HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0214, 24, 0x0, 0x0, 0,
+	      0x0214, 0, 0, armpll_div_table),
+	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0,
+	    HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0294, 24, 0x0, 0x0, 0,
+	    0x0294, 0, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0,
+	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24, 0x0, 0x0, 0,
+	    0x0224, 0, 0),
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0,
+	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24, 0x0, 0x0, 0,
+	    0x0234, 0, 0),
+	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0,
+	      0, 0, 22, 8, 0x0244, 24, 0x0, 0x0, 0, 0x0244, 0, 0,
+	      mfgpll_div_table),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0,
+	    0, 0, 22, 8, 0x0254, 24, 0x0, 0x0, 0, 0x0254, 0, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0,
+	    0, 0, 22, 8, 0x0264, 24, 0x0, 0x0, 0, 0x0264, 0, 0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0,
+	    HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24, 0x0, 0x0, 0,
+	    0x0274, 0, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0,
+	    0, 0, 32, 8, 0x02A0, 1, 0x02A8, 0x0014, 0, 0x02A4, 0, 0x02A0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0,
+	    0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
+};
+
+static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_devm_alloc_clk_data(dev, CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (ret)
+		return ret;
+
+	ret = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				     ARRAY_SIZE(apmixed_clks), clk_data);
+	if (ret)
+		goto unregister_plls;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_gates;
+
+	return 0;
+
+unregister_gates:
+	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+
+	return ret;
+}
+
+static const struct of_device_id of_match_clk_mt8183_apmixed[] = {
+	{ .compatible = "mediatek,mt8183-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8183_apmixed_drv = {
+	.probe = clk_mt8183_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8183-apmixed",
+		.of_match_table = of_match_clk_mt8183_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt8183_apmixed_drv)
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 722d913f0b4d..84b970f33316 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -14,7 +14,6 @@
 #include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-mux.h"
-#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8183-clk.h>
 
@@ -941,140 +940,6 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI(CLK_PERI_AXI, "peri_axi", "axi_sel", 31),
 };
 
-static const struct mtk_gate_regs apmixed_cg_regs = {
-	.set_ofs = 0x20,
-	.clr_ofs = 0x20,
-	.sta_ofs = 0x20,
-};
-
-#define GATE_APMIXED_FLAGS(_id, _name, _parent, _shift, _flags)	\
-	GATE_MTK_FLAGS(_id, _name, _parent, &apmixed_cg_regs,		\
-		_shift, &mtk_clk_gate_ops_no_setclr_inv, _flags)
-
-#define GATE_APMIXED(_id, _name, _parent, _shift)	\
-	GATE_APMIXED_FLAGS(_id, _name, _parent, _shift,	0)
-
-/*
- * CRITICAL CLOCK:
- * apmixed_appll26m is the toppest clock gate of all PLLs.
- */
-static const struct mtk_gate apmixed_clks[] = {
-	/* AUDIO0 */
-	GATE_APMIXED(CLK_APMIXED_SSUSB_26M, "apmixed_ssusb26m",
-		"f_f26m_ck", 4),
-	GATE_APMIXED_FLAGS(CLK_APMIXED_APPLL_26M, "apmixed_appll26m",
-		"f_f26m_ck", 5, CLK_IS_CRITICAL),
-	GATE_APMIXED(CLK_APMIXED_MIPIC0_26M, "apmixed_mipic026m",
-		"f_f26m_ck", 6),
-	GATE_APMIXED(CLK_APMIXED_MDPLLGP_26M, "apmixed_mdpll26m",
-		"f_f26m_ck", 7),
-	GATE_APMIXED(CLK_APMIXED_MMSYS_26M, "apmixed_mmsys26m",
-		"f_f26m_ck", 8),
-	GATE_APMIXED(CLK_APMIXED_UFS_26M, "apmixed_ufs26m",
-		"f_f26m_ck", 9),
-	GATE_APMIXED(CLK_APMIXED_MIPIC1_26M, "apmixed_mipic126m",
-		"f_f26m_ck", 11),
-	GATE_APMIXED(CLK_APMIXED_MEMPLL_26M, "apmixed_mempll26m",
-		"f_f26m_ck", 13),
-	GATE_APMIXED(CLK_APMIXED_CLKSQ_LVPLL_26M, "apmixed_lvpll26m",
-		"f_f26m_ck", 14),
-	GATE_APMIXED(CLK_APMIXED_MIPID0_26M, "apmixed_mipid026m",
-		"f_f26m_ck", 16),
-	GATE_APMIXED(CLK_APMIXED_MIPID1_26M, "apmixed_mipid126m",
-		"f_f26m_ck", 17),
-};
-
-#define MT8183_PLL_FMAX		(3800UL * MHZ)
-#define MT8183_PLL_FMIN		(1500UL * MHZ)
-
-#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
-			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
-			_pd_shift, _tuner_reg,  _tuner_en_reg,		\
-			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
-			_pcw_chg_reg, _div_table) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.reg = _reg,						\
-		.pwr_reg = _pwr_reg,					\
-		.en_mask = _en_mask,					\
-		.flags = _flags,					\
-		.rst_bar_mask = _rst_bar_mask,				\
-		.fmax = MT8183_PLL_FMAX,				\
-		.fmin = MT8183_PLL_FMIN,				\
-		.pcwbits = _pcwbits,					\
-		.pcwibits = _pcwibits,					\
-		.pd_reg = _pd_reg,					\
-		.pd_shift = _pd_shift,					\
-		.tuner_reg = _tuner_reg,				\
-		.tuner_en_reg = _tuner_en_reg,				\
-		.tuner_en_bit = _tuner_en_bit,				\
-		.pcw_reg = _pcw_reg,					\
-		.pcw_shift = _pcw_shift,				\
-		.pcw_chg_reg = _pcw_chg_reg,				\
-		.div_table = _div_table,				\
-	}
-
-#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
-			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
-			_pd_shift, _tuner_reg, _tuner_en_reg,		\
-			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
-			_pcw_chg_reg)					\
-		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
-			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
-			_pd_shift, _tuner_reg, _tuner_en_reg,		\
-			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
-			_pcw_chg_reg, NULL)
-
-static const struct mtk_pll_div_table armpll_div_table[] = {
-	{ .div = 0, .freq = MT8183_PLL_FMAX },
-	{ .div = 1, .freq = 1500 * MHZ },
-	{ .div = 2, .freq = 750 * MHZ },
-	{ .div = 3, .freq = 375 * MHZ },
-	{ .div = 4, .freq = 187500000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_div_table mfgpll_div_table[] = {
-	{ .div = 0, .freq = MT8183_PLL_FMAX },
-	{ .div = 1, .freq = 1600 * MHZ },
-	{ .div = 2, .freq = 800 * MHZ },
-	{ .div = 3, .freq = 400 * MHZ },
-	{ .div = 4, .freq = 200 * MHZ },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_data plls[] = {
-	PLL_B(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, 0,
-		HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0204, 24, 0x0, 0x0, 0,
-		0x0204, 0, 0, armpll_div_table),
-	PLL_B(CLK_APMIXED_ARMPLL_L, "armpll_l", 0x0210, 0x021C, 0,
-		HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0214, 24, 0x0, 0x0, 0,
-		0x0214, 0, 0, armpll_div_table),
-	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0290, 0x029C, 0,
-		HAVE_RST_BAR | PLL_AO, BIT(24), 22, 8, 0x0294, 24, 0x0, 0x0, 0,
-		0x0294, 0, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0220, 0x022C, 0,
-		HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24, 0x0, 0x0, 0,
-		0x0224, 0, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0230, 0x023C, 0,
-		HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24, 0x0, 0x0, 0,
-		0x0234, 0, 0),
-	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0240, 0x024C, 0,
-		0, 0, 22, 8, 0x0244, 24, 0x0, 0x0, 0, 0x0244, 0, 0,
-		mfgpll_div_table),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0250, 0x025C, 0,
-		0, 0, 22, 8, 0x0254, 24, 0x0, 0x0, 0, 0x0254, 0, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0260, 0x026C, 0,
-		0, 0, 22, 8, 0x0264, 24, 0x0, 0x0, 0, 0x0264, 0, 0),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0270, 0x027C, 0,
-		HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24, 0x0, 0x0, 0,
-		0x0274, 0, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x02A0, 0x02B0, 0,
-		0, 0, 32, 8, 0x02A0, 1, 0x02A8, 0x0014, 0, 0x02A4, 0, 0x02A0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x02b4, 0x02c4, 0,
-		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
-};
-
 static u16 infra_rst_ofs[] = {
 	INFRA_RST0_SET_OFFSET,
 	INFRA_RST1_SET_OFFSET,
@@ -1088,21 +953,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
 };
 
-static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-
-	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
-			       ARRAY_SIZE(apmixed_clks), clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
-
 static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt8183_top_init_early(struct device_node *node)
@@ -1204,9 +1054,6 @@ static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 
 static const struct of_device_id of_match_clk_mt8183[] = {
 	{
-		.compatible = "mediatek,mt8183-apmixedsys",
-		.data = clk_mt8183_apmixed_probe,
-	}, {
 		.compatible = "mediatek,mt8183-topckgen",
 		.data = clk_mt8183_top_probe,
 	}, {
-- 
2.39.1

