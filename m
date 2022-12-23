Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9B654E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiLWJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiLWJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:43:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB860379D5;
        Fri, 23 Dec 2022 01:43:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 781736602CF6;
        Fri, 23 Dec 2022 09:43:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788598;
        bh=Q79Cdsx41x4f+YPxKYF83Ryep4djnWlEAq5arTZPmB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+YXAXl3bBhx2arl+3/9PBNym83Sf3n1R232xc66spDcHgmnmPR7/w7+YVVYMI37H
         DuzSU4DkAbieAD00d4x/+yDQfZ+cww8Yn6uWS86IeFi6b5qJpbkvyK1FZaX+/XcW6H
         ExEHvLjGDAQDQVMNgIc5+8v6HtHAySA82rB538bAYGW8p+tNwB2gdNYG779usiCotg
         D7n8qCjXTt4hT3Oz2J2VmYVsq4Sr/wG3eKvx0Q3k9qJkMpFPUXAqcU++vvRvbkGu1m
         uzge/gLq0/PXALvb6Elmb+QuWlfvtXyKB/2solZx4l+TKTm+75qsIQ5gsc4HJezcGW
         i5pBbbXBqVe5w==
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
Subject: [PATCH v2 08/23] clk: mediatek: mt8173: Migrate to platform driver and common probe
Date:   Fri, 23 Dec 2022 10:42:44 +0100
Message-Id: <20221223094259.87373-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
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

This driver is using CLK_OF_DECLARE() for all clocks: while this
definitely works, it's not preferred as this makes it impossible
to compile non boot critical clock drivers as modules and to take
advantage of clock controller Runtime PM.

As a preparation for a larger cleanup, migrate all of the clock
controller drivers for MT8173 to platform_driver and use the
common mtk_clk_simple_probe() where possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 478 +++++++++++++++++-------------
 1 file changed, 273 insertions(+), 205 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 617f68274004..70cdc0719658 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -7,6 +7,8 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include "clk-cpumux.h"
 #include "clk-gate.h"
@@ -15,6 +17,9 @@
 
 #include <dt-bindings/clock/mt8173-clk.h>
 
+#define REGOFF_REF2USB	0x8
+#define REGOFF_HDMI_REF	0x40
+
 /*
  * For some clocks, we don't care what their actual rates are. And these
  * clocks may change their rate on different products or different scenarios.
@@ -24,7 +29,7 @@
 
 static DEFINE_SPINLOCK(mt8173_clk_lock);
 
-static const struct mtk_fixed_clk fixed_clks[] __initconst = {
+static const struct mtk_fixed_clk fixed_clks[] = {
 	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", DUMMY_RATE),
 	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
 	FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", DUMMY_RATE),
@@ -33,7 +38,7 @@ static const struct mtk_fixed_clk fixed_clks[] __initconst = {
 	FIXED_CLK(CLK_TOP_LVDS_CTS, "lvds_cts", "lvdspll", DUMMY_RATE),
 };
 
-static const struct mtk_fixed_factor top_divs[] __initconst = {
+static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_ARMCA7PLL_754M, "armca7pll_754m", "armca7pll", 1, 2),
 	FACTOR(CLK_TOP_ARMCA7PLL_502M, "armca7pll_502m", "armca7pll", 1, 3),
 
@@ -129,7 +134,7 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_VENCPLL_D4, "vencpll_d4", "vencpll", 1, 4),
 };
 
-static const char * const axi_parents[] __initconst = {
+static const char * const axi_parents[] = {
 	"clk26m",
 	"syspll1_d2",
 	"syspll_d5",
@@ -140,17 +145,17 @@ static const char * const axi_parents[] __initconst = {
 	"dmpll_d4"
 };
 
-static const char * const mem_parents[] __initconst = {
+static const char * const mem_parents[] = {
 	"clk26m",
 	"dmpll_ck"
 };
 
-static const char * const ddrphycfg_parents[] __initconst = {
+static const char * const ddrphycfg_parents[] = {
 	"clk26m",
 	"syspll1_d8"
 };
 
-static const char * const mm_parents[] __initconst = {
+static const char * const mm_parents[] = {
 	"clk26m",
 	"vencpll_d2",
 	"main_h364m",
@@ -162,14 +167,14 @@ static const char * const mm_parents[] __initconst = {
 	"dmpll_d2"
 };
 
-static const char * const pwm_parents[] __initconst = {
+static const char * const pwm_parents[] = {
 	"clk26m",
 	"univpll2_d4",
 	"univpll3_d2",
 	"univpll1_d4"
 };
 
-static const char * const vdec_parents[] __initconst = {
+static const char * const vdec_parents[] = {
 	"clk26m",
 	"vcodecpll_ck",
 	"tvdpll_445p5m",
@@ -182,7 +187,7 @@ static const char * const vdec_parents[] __initconst = {
 	"dmpll_d4"
 };
 
-static const char * const venc_parents[] __initconst = {
+static const char * const venc_parents[] = {
 	"clk26m",
 	"vcodecpll_ck",
 	"tvdpll_445p5m",
@@ -195,7 +200,7 @@ static const char * const venc_parents[] __initconst = {
 	"dmpll_d4"
 };
 
-static const char * const mfg_parents[] __initconst = {
+static const char * const mfg_parents[] = {
 	"clk26m",
 	"mmpll_ck",
 	"dmpll_ck",
@@ -214,7 +219,7 @@ static const char * const mfg_parents[] __initconst = {
 	"univpll2_d2"
 };
 
-static const char * const camtg_parents[] __initconst = {
+static const char * const camtg_parents[] = {
 	"clk26m",
 	"univpll_d26",
 	"univpll2_d2",
@@ -223,12 +228,12 @@ static const char * const camtg_parents[] __initconst = {
 	"univpll1_d4"
 };
 
-static const char * const uart_parents[] __initconst = {
+static const char * const uart_parents[] = {
 	"clk26m",
 	"univpll2_d8"
 };
 
-static const char * const spi_parents[] __initconst = {
+static const char * const spi_parents[] = {
 	"clk26m",
 	"syspll3_d2",
 	"syspll1_d4",
@@ -238,20 +243,20 @@ static const char * const spi_parents[] __initconst = {
 	"univpll1_d8"
 };
 
-static const char * const usb20_parents[] __initconst = {
+static const char * const usb20_parents[] = {
 	"clk26m",
 	"univpll1_d8",
 	"univpll3_d4"
 };
 
-static const char * const usb30_parents[] __initconst = {
+static const char * const usb30_parents[] = {
 	"clk26m",
 	"univpll3_d2",
 	"usb_syspll_125m",
 	"univpll2_d4"
 };
 
-static const char * const msdc50_0_h_parents[] __initconst = {
+static const char * const msdc50_0_h_parents[] = {
 	"clk26m",
 	"syspll1_d2",
 	"syspll2_d2",
@@ -260,7 +265,7 @@ static const char * const msdc50_0_h_parents[] __initconst = {
 	"univpll1_d4"
 };
 
-static const char * const msdc50_0_parents[] __initconst = {
+static const char * const msdc50_0_parents[] = {
 	"clk26m",
 	"msdcpll_ck",
 	"msdcpll_d2",
@@ -278,7 +283,7 @@ static const char * const msdc50_0_parents[] __initconst = {
 	"msdcpll2_d4"
 };
 
-static const char * const msdc30_1_parents[] __initconst = {
+static const char * const msdc30_1_parents[] = {
 	"clk26m",
 	"univpll2_d2",
 	"msdcpll_d4",
@@ -289,7 +294,7 @@ static const char * const msdc30_1_parents[] __initconst = {
 	"vencpll_d4"
 };
 
-static const char * const msdc30_2_parents[] __initconst = {
+static const char * const msdc30_2_parents[] = {
 	"clk26m",
 	"univpll2_d2",
 	"msdcpll_d4",
@@ -300,7 +305,7 @@ static const char * const msdc30_2_parents[] __initconst = {
 	"vencpll_d2"
 };
 
-static const char * const msdc30_3_parents[] __initconst = {
+static const char * const msdc30_3_parents[] = {
 	"clk26m",
 	"msdcpll2_ck",
 	"msdcpll2_d2",
@@ -317,14 +322,14 @@ static const char * const msdc30_3_parents[] __initconst = {
 	"msdcpll_d4"
 };
 
-static const char * const audio_parents[] __initconst = {
+static const char * const audio_parents[] = {
 	"clk26m",
 	"syspll3_d4",
 	"syspll4_d4",
 	"syspll1_d16"
 };
 
-static const char * const aud_intbus_parents[] __initconst = {
+static const char * const aud_intbus_parents[] = {
 	"clk26m",
 	"syspll1_d4",
 	"syspll4_d2",
@@ -334,7 +339,7 @@ static const char * const aud_intbus_parents[] __initconst = {
 	"dmpll_d8"
 };
 
-static const char * const pmicspi_parents[] __initconst = {
+static const char * const pmicspi_parents[] = {
 	"clk26m",
 	"syspll1_d8",
 	"syspll3_d4",
@@ -345,7 +350,7 @@ static const char * const pmicspi_parents[] __initconst = {
 	"dmpll_d16"
 };
 
-static const char * const scp_parents[] __initconst = {
+static const char * const scp_parents[] = {
 	"clk26m",
 	"syspll1_d2",
 	"univpll_d5",
@@ -354,14 +359,14 @@ static const char * const scp_parents[] __initconst = {
 	"dmpll_d4"
 };
 
-static const char * const atb_parents[] __initconst = {
+static const char * const atb_parents[] = {
 	"clk26m",
 	"syspll1_d2",
 	"univpll_d5",
 	"dmpll_d2"
 };
 
-static const char * const venc_lt_parents[] __initconst = {
+static const char * const venc_lt_parents[] = {
 	"clk26m",
 	"univpll_d3",
 	"vcodecpll_ck",
@@ -376,7 +381,7 @@ static const char * const venc_lt_parents[] __initconst = {
 	"dmpll_ck"
 };
 
-static const char * const dpi0_parents[] __initconst = {
+static const char * const dpi0_parents[] = {
 	"clk26m",
 	"tvdpll_d2",
 	"tvdpll_d4",
@@ -386,13 +391,13 @@ static const char * const dpi0_parents[] __initconst = {
 	"tvdpll_d16"
 };
 
-static const char * const irda_parents[] __initconst = {
+static const char * const irda_parents[] = {
 	"clk26m",
 	"univpll2_d4",
 	"syspll2_d4"
 };
 
-static const char * const cci400_parents[] __initconst = {
+static const char * const cci400_parents[] = {
 	"clk26m",
 	"vencpll_ck",
 	"armca7pll_754m",
@@ -403,41 +408,41 @@ static const char * const cci400_parents[] __initconst = {
 	"dmpll_ck"
 };
 
-static const char * const aud_1_parents[] __initconst = {
+static const char * const aud_1_parents[] = {
 	"clk26m",
 	"apll1_ck",
 	"univpll2_d4",
 	"univpll2_d8"
 };
 
-static const char * const aud_2_parents[] __initconst = {
+static const char * const aud_2_parents[] = {
 	"clk26m",
 	"apll2_ck",
 	"univpll2_d4",
 	"univpll2_d8"
 };
 
-static const char * const mem_mfg_in_parents[] __initconst = {
+static const char * const mem_mfg_in_parents[] = {
 	"clk26m",
 	"mmpll_ck",
 	"dmpll_ck",
 	"clk26m"
 };
 
-static const char * const axi_mfg_in_parents[] __initconst = {
+static const char * const axi_mfg_in_parents[] = {
 	"clk26m",
 	"axi_sel",
 	"dmpll_d2"
 };
 
-static const char * const scam_parents[] __initconst = {
+static const char * const scam_parents[] = {
 	"clk26m",
 	"syspll3_d2",
 	"univpll2_d4",
 	"dmpll_d4"
 };
 
-static const char * const spinfi_ifr_parents[] __initconst = {
+static const char * const spinfi_ifr_parents[] = {
 	"clk26m",
 	"univpll2_d8",
 	"univpll3_d4",
@@ -448,14 +453,14 @@ static const char * const spinfi_ifr_parents[] __initconst = {
 	"univpll1_d4"
 };
 
-static const char * const hdmi_parents[] __initconst = {
+static const char * const hdmi_parents[] = {
 	"clk26m",
 	"hdmitx_dig_cts",
 	"hdmitxpll_d2",
 	"hdmitxpll_d3"
 };
 
-static const char * const dpilvds_parents[] __initconst = {
+static const char * const dpilvds_parents[] = {
 	"clk26m",
 	"lvdspll",
 	"lvdspll_d2",
@@ -464,7 +469,7 @@ static const char * const dpilvds_parents[] __initconst = {
 	"fpc_ck"
 };
 
-static const char * const msdc50_2_h_parents[] __initconst = {
+static const char * const msdc50_2_h_parents[] = {
 	"clk26m",
 	"syspll1_d2",
 	"syspll2_d2",
@@ -473,72 +478,72 @@ static const char * const msdc50_2_h_parents[] __initconst = {
 	"univpll1_d4"
 };
 
-static const char * const hdcp_parents[] __initconst = {
+static const char * const hdcp_parents[] = {
 	"clk26m",
 	"syspll4_d2",
 	"syspll3_d4",
 	"univpll2_d4"
 };
 
-static const char * const hdcp_24m_parents[] __initconst = {
+static const char * const hdcp_24m_parents[] = {
 	"clk26m",
 	"univpll_d26",
 	"univpll_d52",
 	"univpll2_d8"
 };
 
-static const char * const rtc_parents[] __initconst = {
+static const char * const rtc_parents[] = {
 	"clkrtc_int",
 	"clkrtc_ext",
 	"clk26m",
 	"univpll3_d8"
 };
 
-static const char * const i2s0_m_ck_parents[] __initconst = {
+static const char * const i2s0_m_ck_parents[] = {
 	"apll1_div1",
 	"apll2_div1"
 };
 
-static const char * const i2s1_m_ck_parents[] __initconst = {
+static const char * const i2s1_m_ck_parents[] = {
 	"apll1_div2",
 	"apll2_div2"
 };
 
-static const char * const i2s2_m_ck_parents[] __initconst = {
+static const char * const i2s2_m_ck_parents[] = {
 	"apll1_div3",
 	"apll2_div3"
 };
 
-static const char * const i2s3_m_ck_parents[] __initconst = {
+static const char * const i2s3_m_ck_parents[] = {
 	"apll1_div4",
 	"apll2_div4"
 };
 
-static const char * const i2s3_b_ck_parents[] __initconst = {
+static const char * const i2s3_b_ck_parents[] = {
 	"apll1_div5",
 	"apll2_div5"
 };
 
-static const char * const ca53_parents[] __initconst = {
+static const char * const ca53_parents[] = {
 	"clk26m",
 	"armca7pll",
 	"mainpll",
 	"univpll"
 };
 
-static const char * const ca72_parents[] __initconst = {
+static const char * const ca72_parents[] = {
 	"clk26m",
 	"armca15pll",
 	"mainpll",
 	"univpll"
 };
 
-static const struct mtk_composite cpu_muxes[] __initconst = {
+static const struct mtk_composite cpu_muxes[] = {
 	MUX(CLK_INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
 	MUX(CLK_INFRA_CA72SEL, "infra_ca72_sel", ca72_parents, 0x0000, 2, 2),
 };
 
-static const struct mtk_composite top_muxes[] __initconst = {
+static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX(CLK_TOP_AXI_SEL, "axi_sel", axi_parents, 0x0040, 0, 3),
 	MUX(CLK_TOP_MEM_SEL, "mem_sel", mem_parents, 0x0040, 8, 1),
@@ -614,7 +619,7 @@ static const struct mtk_composite top_muxes[] __initconst = {
 	MUX(CLK_TOP_I2S3_B_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
 };
 
-static const struct mtk_gate_regs infra_cg_regs __initconst = {
+static const struct mtk_gate_regs infra_cg_regs = {
 	.set_ofs = 0x0040,
 	.clr_ofs = 0x0044,
 	.sta_ofs = 0x0048,
@@ -629,7 +634,7 @@ static const struct mtk_gate_regs infra_cg_regs __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr,		\
 	}
 
-static const struct mtk_gate infra_clks[] __initconst = {
+static const struct mtk_gate infra_clks[] = {
 	GATE_ICG(CLK_INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
 	GATE_ICG(CLK_INFRA_SMI, "infra_smi", "mm_sel", 1),
 	GATE_ICG(CLK_INFRA_AUDIO, "infra_audio", "aud_intbus_sel", 5),
@@ -643,17 +648,17 @@ static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMICWRAP, "infra_pmicwrap", "axi_sel", 23),
 };
 
-static const struct mtk_fixed_factor infra_divs[] __initconst = {
+static const struct mtk_fixed_factor infra_early_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
-static const struct mtk_gate_regs peri0_cg_regs __initconst = {
+static const struct mtk_gate_regs peri0_cg_regs = {
 	.set_ofs = 0x0008,
 	.clr_ofs = 0x0010,
 	.sta_ofs = 0x0018,
 };
 
-static const struct mtk_gate_regs peri1_cg_regs __initconst = {
+static const struct mtk_gate_regs peri1_cg_regs = {
 	.set_ofs = 0x000c,
 	.clr_ofs = 0x0014,
 	.sta_ofs = 0x001c,
@@ -677,7 +682,7 @@ static const struct mtk_gate_regs peri1_cg_regs __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr,		\
 	}
 
-static const struct mtk_gate peri_gates[] __initconst = {
+static const struct mtk_gate peri_gates[] = {
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_NFI, "peri_nfi", "axi_sel", 0),
 	GATE_PERI0(CLK_PERI_THERM, "peri_therm", "axi_sel", 1),
@@ -717,19 +722,19 @@ static const struct mtk_gate peri_gates[] __initconst = {
 	GATE_PERI1(CLK_PERI_I2C6, "peri_i2c6", "axi_sel", 2),
 };
 
-static const char * const uart_ck_sel_parents[] __initconst = {
+static const char * const uart_ck_sel_parents[] = {
 	"clk26m",
 	"uart_sel",
 };
 
-static const struct mtk_composite peri_clks[] __initconst = {
+static const struct mtk_composite peri_clks[] = {
 	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
 	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
 	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
-static const struct mtk_gate_regs cg_regs_4_8_0 __initconst = {
+static const struct mtk_gate_regs cg_regs_4_8_0 = {
 	.set_ofs = 0x0004,
 	.clr_ofs = 0x0008,
 	.sta_ofs = 0x0000,
@@ -744,7 +749,8 @@ static const struct mtk_gate_regs cg_regs_4_8_0 __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr,		\
 	}
 
-static const struct mtk_gate img_clks[] __initconst = {
+static const struct mtk_gate img_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "img_dummy"),
 	GATE_IMG(CLK_IMG_LARB2_SMI, "img_larb2_smi", "mm_sel", 0),
 	GATE_IMG(CLK_IMG_CAM_SMI, "img_cam_smi", "mm_sel", 5),
 	GATE_IMG(CLK_IMG_CAM_CAM, "img_cam_cam", "mm_sel", 6),
@@ -754,13 +760,13 @@ static const struct mtk_gate img_clks[] __initconst = {
 	GATE_IMG(CLK_IMG_FD, "img_fd", "mm_sel", 11),
 };
 
-static const struct mtk_gate_regs vdec0_cg_regs __initconst = {
+static const struct mtk_gate_regs vdec0_cg_regs = {
 	.set_ofs = 0x0000,
 	.clr_ofs = 0x0004,
 	.sta_ofs = 0x0000,
 };
 
-static const struct mtk_gate_regs vdec1_cg_regs __initconst = {
+static const struct mtk_gate_regs vdec1_cg_regs = {
 	.set_ofs = 0x0008,
 	.clr_ofs = 0x000c,
 	.sta_ofs = 0x0008,
@@ -784,7 +790,8 @@ static const struct mtk_gate_regs vdec1_cg_regs __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr_inv,		\
 	}
 
-static const struct mtk_gate vdec_clks[] __initconst = {
+static const struct mtk_gate vdec_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "vdec_dummy"),
 	GATE_VDEC0(CLK_VDEC_CKEN, "vdec_cken", "vdec_sel", 0),
 	GATE_VDEC1(CLK_VDEC_LARB_CKEN, "vdec_larb_cken", "mm_sel", 0),
 };
@@ -798,7 +805,8 @@ static const struct mtk_gate vdec_clks[] __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr_inv,		\
 	}
 
-static const struct mtk_gate venc_clks[] __initconst = {
+static const struct mtk_gate venc_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "venc_dummy"),
 	GATE_VENC(CLK_VENC_CKE0, "venc_cke0", "mm_sel", 0),
 	GATE_VENC(CLK_VENC_CKE1, "venc_cke1", "venc_sel", 4),
 	GATE_VENC(CLK_VENC_CKE2, "venc_cke2", "venc_sel", 8),
@@ -814,7 +822,8 @@ static const struct mtk_gate venc_clks[] __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr_inv,		\
 	}
 
-static const struct mtk_gate venclt_clks[] __initconst = {
+static const struct mtk_gate venclt_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "venclt_dummy"),
 	GATE_VENCLT(CLK_VENCLT_CKE0, "venclt_cke0", "mm_sel", 0),
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
@@ -837,10 +846,11 @@ static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	}
 };
 
-static struct clk_hw_onecell_data *mt8173_top_clk_data __initdata;
-static struct clk_hw_onecell_data *mt8173_pll_clk_data __initdata;
+static struct clk_hw_onecell_data *mt8173_top_clk_data;
+static struct clk_hw_onecell_data *mt8173_pll_clk_data;
+static struct clk_hw_onecell_data *infra_clk_data;
 
-static void __init mtk_clk_enable_critical(void)
+static void mtk_clk_enable_critical(void)
 {
 	if (!mt8173_top_clk_data || !mt8173_pll_clk_data)
 		return;
@@ -853,102 +863,149 @@ static void __init mtk_clk_enable_critical(void)
 	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_RTC_SEL]->clk);
 }
 
-static void __init mtk_topckgen_init(struct device_node *node)
+static int clk_mt8173_topck_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	mt8173_top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (IS_ERR_OR_NULL(clk_data))
+		return -ENOMEM;
 
-	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8173_clk_lock, clk_data, NULL);
+	r = mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
+	if (r)
+		goto free_clk_data;
+
+	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	if (r)
+		goto unregister_fixed_clks;
+
+	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+					&mt8173_clk_lock, clk_data, &pdev->dev);
+	if (r)
+		goto unregister_factors;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+		goto unregister_composites;
 
 	mtk_clk_enable_critical();
+	return 0;
+
+unregister_composites:
+	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
+unregister_factors:
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+unregister_fixed_clks:
+	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
-CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8173-topckgen", mtk_topckgen_init);
 
-static void __init mtk_infrasys_init(struct device_node *node)
+static void clk_mt8173_infra_init_early(struct device_node *node)
 {
-	struct clk_hw_onecell_data *clk_data;
+	int i;
+
+	infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!infra_clk_data)
+		return;
+
+	for (i = 0; i < CLK_INFRA_NR_CLK; i++)
+		infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	mtk_clk_register_factors(infra_early_divs, ARRAY_SIZE(infra_early_divs), infra_clk_data);
+
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
+}
+CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
+		      clk_mt8173_infra_init_early);
+
+static int clk_mt8173_infra_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
+				   infra_clk_data, &pdev->dev);
+	if (r)
+		return r;
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data, NULL);
-	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
+	r = mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
+				      infra_clk_data, &pdev->dev);
+	if (r)
+		goto unregister_gates;
 
-	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
-				  clk_data, NULL);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
+	if (r)
+		goto unregister_cpumuxes;
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = mtk_register_reset_controller(node, &clk_rst_desc[0]);
 	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+		goto unregister_clk_hw;
+
+	return 0;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+unregister_clk_hw:
+	of_clk_del_provider(node);
+unregister_cpumuxes:
+	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), infra_clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), infra_clk_data);
+	return r;
 }
-CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
-static void __init mtk_pericfg_init(struct device_node *node)
+static int clk_mt8173_peri_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (IS_ERR_OR_NULL(clk_data))
+		return -ENOMEM;
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-			       clk_data, NULL);
-	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8173_clk_lock, clk_data, NULL);
+	r = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
+				   clk_data, &pdev->dev);
+	if (r)
+		goto free_clk_data;
+
+	r = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
+					&mt8173_clk_lock, clk_data, &pdev->dev);
+	if (r)
+		goto unregister_gates;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+		goto unregister_composites;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	r = mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	if (r)
+		goto unregister_clk_hw;
+
+	return 0;
+
+unregister_clk_hw:
+	of_clk_del_provider(node);
+unregister_composites:
+	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
-CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
-
-struct mtk_clk_usb {
-	int id;
-	const char *name;
-	const char *parent;
-	u32 reg_ofs;
-};
-
-#define APMIXED_USB(_id, _name, _parent, _reg_ofs) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent = _parent,					\
-		.reg_ofs = _reg_ofs,					\
-	}
-
-static const struct mtk_clk_usb apmixed_usb[] __initconst = {
-	APMIXED_USB(CLK_APMIXED_REF2USB_TX, "ref2usb_tx", "clk26m", 0x8),
-};
 
 #define MT8173_PLL_FMAX		(3000UL * MHZ)
 
@@ -1007,119 +1064,130 @@ static const struct mtk_pll_data plls[] = {
 	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
 };
 
-static void __init mtk_apmixedsys_init(struct device_node *node)
+static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct clk_hw *hw;
-	int r, i;
+	int r;
 
 	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
+	if (!base)
+		return PTR_ERR(base);
 
 	mt8173_pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data) {
-		iounmap(base);
-		return;
-	}
-
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (IS_ERR_OR_NULL(clk_data))
+		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(apmixed_usb); i++) {
-		const struct mtk_clk_usb *cku = &apmixed_usb[i];
-
-		hw = mtk_clk_register_ref2usb_tx(cku->name, cku->parent, base + cku->reg_ofs);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n", cku->name, PTR_ERR(hw));
-			continue;
-		}
+	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (r)
+		goto free_clk_data;
 
-		clk_data->hws[cku->id] = hw;
+	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
+	if (IS_ERR(hw)) {
+		r = PTR_ERR(hw);
+		dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
+		goto unregister_plls;
 	}
+	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
 
-	hw = clk_hw_register_divider(NULL, "hdmi_ref", "tvdpll_594m", 0,
-				     base + 0x40, 16, 3, CLK_DIVIDER_POWER_OF_TWO,
-				     NULL);
+	hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
+					  base + REGOFF_HDMI_REF, 16, 3,
+					  CLK_DIVIDER_POWER_OF_TWO, NULL);
 	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+		goto unregister_ref2usb;
 
 	mtk_clk_enable_critical();
+	return 0;
+
+unregister_ref2usb:
+	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
-CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
-		mtk_apmixedsys_init);
-
-static void __init mtk_imgsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-			       clk_data, NULL);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
 
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
 
-static void __init mtk_vdecsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
 
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
+static const struct mtk_clk_desc venc_lt_desc = {
+	.clks = venclt_clks,
+	.num_clks = ARRAY_SIZE(venclt_clks),
+};
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-			       clk_data, NULL);
+static const struct of_device_id of_match_clk_mt8173_simple[] = {
+	{ .compatible = "mediatek,mt8173-imgsys", .data = &img_desc },
+	{ .compatible = "mediatek,mt8173-vdecsys", .data = &vdec_desc },
+	{ .compatible = "mediatek,mt8173-vencsys", .data = &venc_desc },
+	{ .compatible = "mediatek,mt8173-vencltsys", .data = &venc_lt_desc },
+	{ /* sentinel */ }
+};
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt8173-vdecsys", mtk_vdecsys_init);
+static struct platform_driver clk_mt8173_simple_drv = {
+	.driver = {
+		.name = "clk-mt8173-simple",
+		.of_match_table = of_match_clk_mt8173_simple,
+	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+};
 
-static void __init mtk_vencsys_init(struct device_node *node)
+static int clk_mt8173_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *clk_data;
+	int (*clk_probe)(struct platform_device *pdev);
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
+	clk_probe = of_device_get_match_data(&pdev->dev);
+	if (!clk_probe)
+		return -EINVAL;
 
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-			       clk_data, NULL);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = clk_probe(pdev);
 	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+		dev_err(&pdev->dev, "could not register clock provider: %s: %d\n", pdev->name, r);
+
+	return r;
 }
-CLK_OF_DECLARE(mtk_vencsys, "mediatek,mt8173-vencsys", mtk_vencsys_init);
 
-static void __init mtk_vencltsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
+static const struct of_device_id of_match_clk_mt8173[] = {
+	{ .compatible = "mediatek,mt8173-apmixedsys", .data = clk_mt8173_apmixed_probe },
+	{ .compatible = "mediatek,mt8173-infracfg", .data = clk_mt8173_infra_probe },
+	{ .compatible = "mediatek,mt8173-topckgen", .data = clk_mt8173_topck_probe },
+	{ .compatible = "mediatek,mt8173-pericfg", .data = clk_mt8173_peri_probe },
+	{ /* sentinel */ }
+};
 
-	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
+static struct platform_driver clk_mt8173_drv = {
+	.probe = clk_mt8173_probe,
+	.driver = {
+		.name = "clk-mt8173",
+		.of_match_table = of_match_clk_mt8173,
+	},
+};
 
-	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
-			       clk_data, NULL);
+static int __init clk_mt8173_init(void)
+{
+	int ret = platform_driver_register(&clk_mt8173_drv);
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+	if (ret)
+		return ret;
+	return platform_driver_register(&clk_mt8173_simple_drv);
 }
-CLK_OF_DECLARE(mtk_vencltsys, "mediatek,mt8173-vencltsys", mtk_vencltsys_init);
+arch_initcall(clk_mt8173_init);
-- 
2.39.0

