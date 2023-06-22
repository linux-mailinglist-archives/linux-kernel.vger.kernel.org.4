Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C84739F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFVLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFVLeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:34:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C8281BE7;
        Thu, 22 Jun 2023 04:33:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.00,263,1681138800"; 
   d="scan'208";a="168532777"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2023 20:33:59 +0900
Received: from mulinux.example.org (unknown [10.226.93.117])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B8A0E40CCB9C;
        Thu, 22 Jun 2023 20:33:56 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v2 2/5] clk: renesas: r9a09g011: Add CSI related clocks
Date:   Thu, 22 Jun 2023 12:33:38 +0100
Message-Id: <20230622113341.657842-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/V2M SoC comes with 6 CSI IPs (CSI0, CSI1, CSI2
CSI3, CSI4, and CSI5), however Linux is only allowed control
of CSI0 and CSI4.
CSI0 shares its reset and PCLK lines with CSI1, CSI2, and CSI3.
CSI4 shares its reset and PCLK lines with CSI5.

This commit adds support for the relevant clocks.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v2: no changes

 drivers/clk/renesas/r9a09g011-cpg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index 3d06baf5061d..dda9f29dff33 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -28,6 +28,8 @@
 #define DIV_W		DDIV_PACK(0x328, 0, 3)
 
 #define SEL_B		SEL_PLL_PACK(0x214, 0, 1)
+#define SEL_CSI0	SEL_PLL_PACK(0x330, 0, 1)
+#define SEL_CSI4	SEL_PLL_PACK(0x330, 4, 1)
 #define SEL_D		SEL_PLL_PACK(0x214, 1, 1)
 #define SEL_E		SEL_PLL_PACK(0x214, 2, 1)
 #define SEL_SDI		SEL_PLL_PACK(0x300, 0, 1)
@@ -58,6 +60,8 @@ enum clk_ids {
 	CLK_DIV_W,
 	CLK_SEL_B,
 	CLK_SEL_B_D2,
+	CLK_SEL_CSI0,
+	CLK_SEL_CSI4,
 	CLK_SEL_D,
 	CLK_SEL_E,
 	CLK_SEL_SDI,
@@ -108,6 +112,7 @@ static const struct clk_div_table dtable_divw[] = {
 
 /* Mux clock tables */
 static const char * const sel_b[] = { ".main", ".divb" };
+static const char * const sel_csi[] = { ".main_24", ".main" };
 static const char * const sel_d[] = { ".main", ".divd" };
 static const char * const sel_e[] = { ".main", ".dive" };
 static const char * const sel_w[] = { ".main", ".divw" };
@@ -139,6 +144,8 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 	DEF_MUX_RO(".seld",	CLK_SEL_D,	SEL_D,		sel_d),
 	DEF_MUX_RO(".sele",	CLK_SEL_E,	SEL_E,		sel_e),
 	DEF_MUX(".selsdi",	CLK_SEL_SDI,	SEL_SDI,	sel_sdi),
+	DEF_MUX(".selcsi0",	CLK_SEL_CSI0,	SEL_CSI0,	sel_csi),
+	DEF_MUX(".selcsi4",	CLK_SEL_CSI4,	SEL_CSI4,	sel_csi),
 	DEF_MUX(".selw0",	CLK_SEL_W0,	SEL_W0,		sel_w),
 
 	DEF_FIXED(".selb_d2",	CLK_SEL_B_D2,	CLK_SEL_B,	1,	2),
@@ -196,8 +203,12 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_MOD("pwm12_clk",	R9A09G011_PWM12_CLK,	 CLK_MAIN,     0x434, 8),
 	DEF_MOD("pwm13_clk",	R9A09G011_PWM13_CLK,	 CLK_MAIN,     0x434, 9),
 	DEF_MOD("pwm14_clk",	R9A09G011_PWM14_CLK,	 CLK_MAIN,     0x434, 10),
+	DEF_MOD("cperi_grpg",	R9A09G011_CPERI_GRPG_PCLK, CLK_SEL_E,  0x438, 0),
+	DEF_MOD("cperi_grph",	R9A09G011_CPERI_GRPH_PCLK, CLK_SEL_E,  0x438, 1),
 	DEF_MOD("urt_pclk",	R9A09G011_URT_PCLK,	 CLK_SEL_E,    0x438, 4),
 	DEF_MOD("urt0_clk",	R9A09G011_URT0_CLK,	 CLK_SEL_W0,   0x438, 5),
+	DEF_MOD("csi0_clk",	R9A09G011_CSI0_CLK,	 CLK_SEL_CSI0, 0x438, 8),
+	DEF_MOD("csi4_clk",	R9A09G011_CSI4_CLK,	 CLK_SEL_CSI4, 0x438, 12),
 	DEF_MOD("ca53",		R9A09G011_CA53_CLK,	 CLK_DIV_A,    0x448, 0),
 };
 
@@ -215,6 +226,8 @@ static const struct rzg2l_reset r9a09g011_resets[] = {
 	DEF_RST(R9A09G011_TIM_GPB_PRESETN,	0x614, 1),
 	DEF_RST(R9A09G011_TIM_GPC_PRESETN,	0x614, 2),
 	DEF_RST_MON(R9A09G011_PWM_GPF_PRESETN,	0x614, 5, 23),
+	DEF_RST_MON(R9A09G011_CSI_GPG_PRESETN,	0x614, 6, 22),
+	DEF_RST_MON(R9A09G011_CSI_GPH_PRESETN,	0x614, 7, 23),
 	DEF_RST(R9A09G011_IIC_GPA_PRESETN,	0x614, 8),
 	DEF_RST(R9A09G011_IIC_GPB_PRESETN,	0x614, 9),
 	DEF_RST_MON(R9A09G011_WDT0_PRESETN,	0x614, 12, 19),
@@ -225,6 +238,8 @@ static const unsigned int r9a09g011_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A09G011_CPERI_GRPB_PCLK,
 	MOD_CLK_BASE + R9A09G011_CPERI_GRPC_PCLK,
 	MOD_CLK_BASE + R9A09G011_CPERI_GRPF_PCLK,
+	MOD_CLK_BASE + R9A09G011_CPERI_GRPG_PCLK,
+	MOD_CLK_BASE + R9A09G011_CPERI_GRPH_PCLK,
 	MOD_CLK_BASE + R9A09G011_GIC_CLK,
 	MOD_CLK_BASE + R9A09G011_SYC_CNT_CLK,
 	MOD_CLK_BASE + R9A09G011_URT_PCLK,
-- 
2.34.1

