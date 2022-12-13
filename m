Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4964C023
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiLMXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiLMXBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:01:46 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4692EC2;
        Tue, 13 Dec 2022 15:01:45 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="143231090"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 08:01:44 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F23E6400D4F6;
        Wed, 14 Dec 2022 08:01:38 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 1/4] clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
Date:   Tue, 13 Dec 2022 23:01:26 +0000
Message-Id: <20221213230129.549968-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Add SDHI/eMMC clock/reset entries to CPG driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---

This patch can clash with the below patch (which hasn't been reviewed
yet):
https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221212172804.1277751-2-biju.das.jz@bp.renesas.com/

 drivers/clk/renesas/r9a09g011-cpg.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index dd5e442ec4a9..8437b7d38e94 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -23,11 +23,14 @@
 
 #define DIV_A		DDIV_PACK(0x200, 0, 3)
 #define DIV_B		DDIV_PACK(0x204, 0, 2)
+#define DIV_D		DDIV_PACK(0x204, 4, 2)
 #define DIV_E		DDIV_PACK(0x204, 8, 1)
 #define DIV_W		DDIV_PACK(0x328, 0, 3)
 
 #define SEL_B		SEL_PLL_PACK(0x214, 0, 1)
+#define SEL_D		SEL_PLL_PACK(0x214, 1, 1)
 #define SEL_E		SEL_PLL_PACK(0x214, 2, 1)
+#define SEL_SDI		SEL_PLL_PACK(0x300, 0, 1)
 #define SEL_W0		SEL_PLL_PACK(0x32C, 0, 1)
 
 enum clk_ids {
@@ -50,11 +53,14 @@ enum clk_ids {
 	CLK_PLL4,
 	CLK_DIV_A,
 	CLK_DIV_B,
+	CLK_DIV_D,
 	CLK_DIV_E,
 	CLK_DIV_W,
 	CLK_SEL_B,
 	CLK_SEL_B_D2,
+	CLK_SEL_D,
 	CLK_SEL_E,
+	CLK_SEL_SDI,
 	CLK_SEL_W0,
 
 	/* Module Clocks */
@@ -81,6 +87,14 @@ static const struct clk_div_table dtable_divb[] = {
 	{0, 0},
 };
 
+
+static const struct clk_div_table dtable_divd[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_divw[] = {
 	{0, 6},
 	{1, 7},
@@ -94,8 +108,10 @@ static const struct clk_div_table dtable_divw[] = {
 
 /* Mux clock tables */
 static const char * const sel_b[] = { ".main", ".divb" };
+static const char * const sel_d[] = { ".main", ".divd" };
 static const char * const sel_e[] = { ".main", ".dive" };
 static const char * const sel_w[] = { ".main", ".divw" };
+static const char * const sel_sdi[] = { ".main", ".pll2_200" };
 
 static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 	/* External Clock Inputs */
@@ -115,11 +131,14 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 
 	DEF_DIV_RO(".diva",	CLK_DIV_A,	CLK_PLL1,	DIV_A,	dtable_diva),
 	DEF_DIV_RO(".divb",	CLK_DIV_B,	CLK_PLL2_400,	DIV_B,	dtable_divb),
+	DEF_DIV_RO(".divd",	CLK_DIV_D,	CLK_PLL2_200,	DIV_D,	dtable_divd),
 	DEF_DIV_RO(".dive",	CLK_DIV_E,	CLK_PLL2_100,	DIV_E,	NULL),
 	DEF_DIV_RO(".divw",	CLK_DIV_W,	CLK_PLL4,	DIV_W,	dtable_divw),
 
 	DEF_MUX_RO(".selb",	CLK_SEL_B,	SEL_B,		sel_b),
+	DEF_MUX_RO(".seld",	CLK_SEL_D,	SEL_D,		sel_d),
 	DEF_MUX_RO(".sele",	CLK_SEL_E,	SEL_E,		sel_e),
+	DEF_MUX(".selsdi",	CLK_SEL_SDI,	SEL_SDI,	sel_sdi),
 	DEF_MUX(".selw0",	CLK_SEL_W0,	SEL_W0,		sel_w),
 
 	DEF_FIXED(".selb_d2",	CLK_SEL_B_D2,	CLK_SEL_B,	1,	2),
@@ -128,6 +147,18 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_MOD("pfc",		R9A09G011_PFC_PCLK,	 CLK_MAIN,     0x400, 2),
 	DEF_MOD("gic",		R9A09G011_GIC_CLK,	 CLK_SEL_B_D2, 0x400, 5),
+	DEF_MOD("sdi0_aclk",	R9A09G011_SDI0_ACLK,	 CLK_SEL_D,    0x408, 0),
+	DEF_MOD("sdi0_imclk",	R9A09G011_SDI0_IMCLK,	 CLK_SEL_SDI,  0x408, 1),
+	DEF_MOD("sdi0_imclk2",	R9A09G011_SDI0_IMCLK2,	 CLK_SEL_SDI,  0x408, 2),
+	DEF_MOD("sdi0_clk_hs",	R9A09G011_SDI0_CLK_HS,	 CLK_PLL2_800, 0x408, 3),
+	DEF_MOD("sdi1_aclk",	R9A09G011_SDI1_ACLK,	 CLK_SEL_D,    0x408, 4),
+	DEF_MOD("sdi1_imclk",	R9A09G011_SDI1_IMCLK,	 CLK_SEL_SDI,  0x408, 5),
+	DEF_MOD("sdi1_imclk2",	R9A09G011_SDI1_IMCLK2,	 CLK_SEL_SDI,  0x408, 6),
+	DEF_MOD("sdi1_clk_hs",	R9A09G011_SDI1_CLK_HS,	 CLK_PLL2_800, 0x408, 7),
+	DEF_MOD("emm_aclk",	R9A09G011_EMM_ACLK,	 CLK_SEL_D,    0x408, 8),
+	DEF_MOD("emm_imclk",	R9A09G011_EMM_IMCLK,	 CLK_SEL_SDI,  0x408, 9),
+	DEF_MOD("emm_imclk2",	R9A09G011_EMM_IMCLK2,	 CLK_SEL_SDI,  0x408, 10),
+	DEF_MOD("emm_clk_hs",	R9A09G011_EMM_CLK_HS,	 CLK_PLL2_800, 0x408, 11),
 	DEF_COUPLED("eth_axi",	R9A09G011_ETH0_CLK_AXI,	 CLK_PLL2_200, 0x40c, 8),
 	DEF_COUPLED("eth_chi",	R9A09G011_ETH0_CLK_CHI,	 CLK_PLL2_100, 0x40c, 8),
 	DEF_MOD("eth_clk_gptp",	R9A09G011_ETH0_GPTP_EXT, CLK_PLL2_100, 0x40c, 9),
@@ -151,6 +182,9 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 
 static const struct rzg2l_reset r9a09g011_resets[] = {
 	DEF_RST(R9A09G011_PFC_PRESETN,		0x600, 2),
+	DEF_RST_MON(R9A09G011_SDI0_IXRST,	0x608, 0,  6),
+	DEF_RST_MON(R9A09G011_SDI1_IXRST,	0x608, 1,  7),
+	DEF_RST_MON(R9A09G011_EMM_IXRST,	0x608, 2,  8),
 	DEF_RST_MON(R9A09G011_ETH0_RST_HW_N,	0x608, 11, 11),
 	DEF_RST_MON(R9A09G011_SYC_RST_N,	0x610, 9,  13),
 	DEF_RST(R9A09G011_IIC_GPA_PRESETN,	0x614, 8),
-- 
2.34.1

