Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA906C2C70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCUIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCUIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:31:36 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67844989A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:30:47 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by laurent.telenet-ops.be with bizsmtp
        id awWb2900H1C8whw01wWboT; Tue, 21 Mar 2023 09:30:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peXNR-00E6VF-JW;
        Tue, 21 Mar 2023 09:30:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1peXO7-007g5M-2S;
        Tue, 21 Mar 2023 09:30:35 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pinctrl: renesas: r8a7779: Add bias pinconf support
Date:   Tue, 21 Mar 2023 09:30:33 +0100
Message-Id: <20230321083033.1830063-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for pull-up handling for the R-Car H1 SoC, using the
common R-Car bias handling.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pfc-r8a7779.c | 335 +++++++++++++++++++++++++-
 1 file changed, 328 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7779.c b/drivers/pinctrl/renesas/pfc-r8a7779.c
index fcc8ea48881fb961..e58281bc9c7cc5c2 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7779.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7779.c
@@ -12,13 +12,76 @@
 #include "sh_pfc.h"
 
 #define CPU_ALL_GP(fn, sfx)						\
-	PORT_GP_32(0, fn, sfx),						\
-	PORT_GP_32(1, fn, sfx),						\
-	PORT_GP_32(2, fn, sfx),						\
-	PORT_GP_32(3, fn, sfx),						\
-	PORT_GP_32(4, fn, sfx),						\
-	PORT_GP_32(5, fn, sfx),						\
-	PORT_GP_9(6, fn, sfx)
+	PORT_GP_CFG_32(0, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_32(1, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_1(2, 0, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_1(2, 1, fn, sfx),					\
+	PORT_GP_1(2, 2, fn, sfx),					\
+	PORT_GP_1(2, 3, fn, sfx),					\
+	PORT_GP_1(2, 4, fn, sfx),					\
+	PORT_GP_1(2, 5, fn, sfx),					\
+	PORT_GP_1(2, 6, fn, sfx),					\
+	PORT_GP_1(2, 7, fn, sfx),					\
+	PORT_GP_1(2, 8, fn, sfx),					\
+	PORT_GP_1(2, 9, fn, sfx),					\
+	PORT_GP_1(2, 10, fn, sfx),					\
+	PORT_GP_1(2, 11, fn, sfx),					\
+	PORT_GP_1(2, 12, fn, sfx),					\
+	PORT_GP_1(2, 13, fn, sfx),					\
+	PORT_GP_1(2, 14, fn, sfx),					\
+	PORT_GP_1(2, 15, fn, sfx),					\
+	PORT_GP_1(2, 16, fn, sfx),					\
+	PORT_GP_1(2, 17, fn, sfx),					\
+	PORT_GP_1(2, 18, fn, sfx),					\
+	PORT_GP_1(2, 19, fn, sfx),					\
+	PORT_GP_1(2, 20, fn, sfx),					\
+	PORT_GP_1(2, 21, fn, sfx),					\
+	PORT_GP_1(2, 22, fn, sfx),					\
+	PORT_GP_1(2, 23, fn, sfx),					\
+	PORT_GP_1(2, 24, fn, sfx),					\
+	PORT_GP_1(2, 25, fn, sfx),					\
+	PORT_GP_1(2, 26, fn, sfx),					\
+	PORT_GP_1(2, 27, fn, sfx),					\
+	PORT_GP_1(2, 28, fn, sfx),					\
+	PORT_GP_1(2, 29, fn, sfx),					\
+	PORT_GP_CFG_1(2, 30, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_1(2, 31, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_25(3, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_1(3, 25, fn, sfx),					\
+	PORT_GP_1(3, 26, fn, sfx),					\
+	PORT_GP_1(3, 27, fn, sfx),					\
+	PORT_GP_CFG_1(3, 28, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_1(3, 29, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_1(3, 30, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_1(3, 31, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_32(4, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_32(5, fn, sfx, SH_PFC_PIN_CFG_PULL_UP),		\
+	PORT_GP_CFG_9(6, fn, sfx, SH_PFC_PIN_CFG_PULL_UP)
+
+#define CPU_ALL_NOGP(fn)						\
+	PIN_NOGP_CFG(ASEBRK_N_ACK, "ASEBRK#/ACK", fn, SH_PFC_PIN_CFG_PULL_UP), \
+	PIN_NOGP_CFG(D0, "D0", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D1, "D1", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D2, "D2", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D3, "D3", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D4, "D4", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D5, "D5", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D6, "D6", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D7, "D7", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D8, "D8", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D9, "D9", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D10, "D10", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D11, "D11", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D12, "D12", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D13, "D13", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D14, "D14", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(D15, "D15", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(PRESETOUT_N, "PRESETOUT#", fn, SH_PFC_PIN_CFG_PULL_UP), \
+	PIN_NOGP_CFG(TCK, "TCK", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(TDI, "TDI", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(TDO, "TDO", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(TMS, "TMS", fn, SH_PFC_PIN_CFG_PULL_UP),		\
+	PIN_NOGP_CFG(TRST_N, "TRST#", fn, SH_PFC_PIN_CFG_PULL_UP)
 
 enum {
 	PINMUX_RESERVED = 0,
@@ -1390,8 +1453,17 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP12_17_15, SCK4_B, SEL_SCIF4_1),
 };
 
+/*
+ * Pins not associated with a GPIO port.
+ */
+enum {
+	GP_ASSIGN_LAST(),
+	NOGP_ALL(),
+};
+
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
+	PINMUX_NOGP_ALL(),
 };
 
 /* - DU0 -------------------------------------------------------------------- */
@@ -3922,8 +3994,256 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+static const struct pinmux_bias_reg pinmux_bias_regs[] = {
+	{ PINMUX_BIAS_REG("PUPR0", 0xfffc0100, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(0,  2),	/* A0 */
+		[ 1] = RCAR_GP_PIN(5,  0),	/* A1 */
+		[ 2] = RCAR_GP_PIN(5,  1),	/* A2 */
+		[ 3] = RCAR_GP_PIN(5,  2),	/* A3 */
+		[ 4] = RCAR_GP_PIN(5,  3),	/* A4 */
+		[ 5] = RCAR_GP_PIN(5,  4),	/* A5 */
+		[ 6] = RCAR_GP_PIN(5,  5),	/* A6 */
+		[ 7] = RCAR_GP_PIN(5,  6),	/* A7 */
+		[ 8] = RCAR_GP_PIN(5,  7),	/* A8 */
+		[ 9] = RCAR_GP_PIN(5,  8),	/* A9 */
+		[10] = RCAR_GP_PIN(5,  9),	/* A10 */
+		[11] = RCAR_GP_PIN(5, 10),	/* A11 */
+		[12] = RCAR_GP_PIN(5, 11),	/* A12 */
+		[13] = RCAR_GP_PIN(5, 12),	/* A13 */
+		[14] = RCAR_GP_PIN(5, 13),	/* A14 */
+		[15] = RCAR_GP_PIN(5, 14),	/* A15 */
+		[16] = RCAR_GP_PIN(5, 15),	/* A16 */
+		[17] = RCAR_GP_PIN(0,  3),	/* A17 */
+		[18] = RCAR_GP_PIN(0,  4),	/* A18 */
+		[19] = RCAR_GP_PIN(0,  5),	/* A19 */
+		[20] = RCAR_GP_PIN(0,  6),	/* A20 */
+		[21] = RCAR_GP_PIN(0,  7),	/* A21 */
+		[22] = RCAR_GP_PIN(0,  8),	/* A22 */
+		[23] = RCAR_GP_PIN(0,  9),	/* A23 */
+		[24] = RCAR_GP_PIN(0, 10),	/* A24 */
+		[25] = RCAR_GP_PIN(0, 11),	/* A25 */
+		[26] = RCAR_GP_PIN(0, 15),	/* EX_CS0# */
+		[27] = RCAR_GP_PIN(0, 16),	/* EX_CS1# */
+		[28] = RCAR_GP_PIN(0, 17),	/* EX_CS2# */
+		[29] = RCAR_GP_PIN(0, 18),	/* EX_CS3# */
+		[30] = RCAR_GP_PIN(0, 19),	/* EX_CS4# */
+		[31] = RCAR_GP_PIN(0, 20),	/* EX_CS5# */
+	} },
+	{ PINMUX_BIAS_REG("PUPR1", 0xfffc0104, "N/A", 0) {
+		[ 0] = PIN_PRESETOUT_N,		/* PRESETOUT# */
+		[ 1] = RCAR_GP_PIN(0, 21),	/* BS# */
+		[ 2] = RCAR_GP_PIN(0, 22),	/* RD/WR# */
+		[ 3] = RCAR_GP_PIN(5, 17),	/* WE0# */
+		[ 4] = RCAR_GP_PIN(5, 18),	/* WE1# */
+		[ 5] = RCAR_GP_PIN(5, 19),	/* EX_WAIT0 */
+		[ 6] = RCAR_GP_PIN(0,  0),	/* AVS1 */
+		[ 7] = RCAR_GP_PIN(0,  1),	/* AVS2 */
+		[ 8] = SH_PFC_PIN_NONE,
+		[ 9] = SH_PFC_PIN_NONE,
+		[10] = PIN_TRST_N,		/* TRST# */
+		[11] = PIN_TCK,			/* TCK */
+		[12] = PIN_TMS,			/* TMS */
+		[13] = PIN_TDI,			/* TDI */
+		[14] = PIN_TDO,			/* TDO */
+		[15] = PIN_ASEBRK_N_ACK,	/* ASEBRK#/ACK */
+		[16] = PIN_D0,			/* D0 */
+		[17] = PIN_D1,			/* D1 */
+		[18] = PIN_D2,			/* D2 */
+		[19] = PIN_D3,			/* D3 */
+		[20] = PIN_D4,			/* D4 */
+		[21] = PIN_D5,			/* D5 */
+		[22] = PIN_D6,			/* D6 */
+		[23] = PIN_D7,			/* D7 */
+		[24] = PIN_D8,			/* D8 */
+		[25] = PIN_D9,			/* D9 */
+		[26] = PIN_D10,			/* D10 */
+		[27] = PIN_D11,			/* D11 */
+		[28] = PIN_D12,			/* D12 */
+		[29] = PIN_D13,			/* D13 */
+		[30] = PIN_D14,			/* D14 */
+		[31] = PIN_D15,			/* D15 */
+	} },
+	{ PINMUX_BIAS_REG("PUPR2", 0xfffc0108, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(0, 23),	/* DU0_DR0 */
+		[ 1] = RCAR_GP_PIN(0, 24),	/* DU0_DR1 */
+		[ 2] = RCAR_GP_PIN(5, 23),	/* DU0_DR2 */
+		[ 3] = RCAR_GP_PIN(5, 24),	/* DU0_DR3 */
+		[ 4] = RCAR_GP_PIN(5, 25),	/* DU0_DR4 */
+		[ 5] = RCAR_GP_PIN(5, 26),	/* DU0_DR5 */
+		[ 6] = RCAR_GP_PIN(5, 27),	/* DU0_DR6 */
+		[ 7] = RCAR_GP_PIN(5, 28),	/* DU0_DR7 */
+		[ 8] = RCAR_GP_PIN(0, 25),	/* DU0_DG0 */
+		[ 9] = RCAR_GP_PIN(0, 26),	/* DU0_DG1 */
+		[10] = RCAR_GP_PIN(5, 29),	/* DU0_DG2 */
+		[11] = RCAR_GP_PIN(5, 30),	/* DU0_DG3 */
+		[12] = RCAR_GP_PIN(5, 31),	/* DU0_DG4 */
+		[13] = RCAR_GP_PIN(6,  0),	/* DU0_DG5 */
+		[14] = RCAR_GP_PIN(6,  1),	/* DU0_DG6 */
+		[15] = RCAR_GP_PIN(6,  2),	/* DU0_DG7 */
+		[16] = RCAR_GP_PIN(0, 27),	/* DU0_DB0 */
+		[17] = RCAR_GP_PIN(0, 28),	/* DU0_DB1 */
+		[18] = RCAR_GP_PIN(6,  3),	/* DU0_DB2 */
+		[19] = RCAR_GP_PIN(6,  4),	/* DU0_DB3 */
+		[20] = RCAR_GP_PIN(6,  5),	/* DU0_DB4 */
+		[21] = RCAR_GP_PIN(6,  6),	/* DU0_DB5 */
+		[22] = RCAR_GP_PIN(6,  7),	/* DU0_DB6 */
+		[23] = RCAR_GP_PIN(6,  8),	/* DU0_DB7 */
+		[24] = RCAR_GP_PIN(0, 29),	/* DU0_DOTCLKIN */
+		[25] = RCAR_GP_PIN(5, 20),	/* DU0_DOTCLKOUT0 */
+		[26] = RCAR_GP_PIN(5, 21),	/* DU0_HSYNC */
+		[27] = RCAR_GP_PIN(5, 22),	/* DU0_VSYNC */
+		[28] = RCAR_GP_PIN(0, 31),	/* DU0_EXODDF */
+		[29] = RCAR_GP_PIN(1,  0),	/* DU0_DISP */
+		[30] = RCAR_GP_PIN(1,  1),	/* DU0_CDE */
+		[31] = RCAR_GP_PIN(0, 30),	/* DU0_DOTCLKOUT1 */
+	} },
+	{ PINMUX_BIAS_REG("PUPR3", 0xfffc010c, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(1,  2),	/* DU1_DR0 */
+		[ 1] = RCAR_GP_PIN(1,  3),	/* DU1_DR1 */
+		[ 2] = RCAR_GP_PIN(1,  4),	/* DU1_DR2 */
+		[ 3] = RCAR_GP_PIN(1,  5),	/* DU1_DR3 */
+		[ 4] = RCAR_GP_PIN(1,  6),	/* DU1_DR4 */
+		[ 5] = RCAR_GP_PIN(1,  7),	/* DU1_DR5 */
+		[ 6] = RCAR_GP_PIN(1,  8),	/* DU1_DR6 */
+		[ 7] = RCAR_GP_PIN(1,  9),	/* DU1_DR7 */
+		[ 8] = RCAR_GP_PIN(1, 10),	/* DU1_DG0 */
+		[ 9] = RCAR_GP_PIN(1, 11),	/* DU1_DG1 */
+		[10] = RCAR_GP_PIN(1, 12),	/* DU1_DG2 */
+		[11] = RCAR_GP_PIN(1, 13),	/* DU1_DG3 */
+		[12] = RCAR_GP_PIN(1, 14),	/* DU1_DG4 */
+		[13] = RCAR_GP_PIN(1, 15),	/* DU1_DG5 */
+		[14] = RCAR_GP_PIN(1, 16),	/* DU1_DG6 */
+		[15] = RCAR_GP_PIN(1, 17),	/* DU1_DG7 */
+		[16] = RCAR_GP_PIN(1, 18),	/* DU1_DB0 */
+		[17] = RCAR_GP_PIN(1, 19),	/* DU1_DB1 */
+		[18] = RCAR_GP_PIN(1, 20),	/* DU1_DB2 */
+		[19] = RCAR_GP_PIN(1, 21),	/* DU1_DB3 */
+		[20] = RCAR_GP_PIN(1, 22),	/* DU1_DB4 */
+		[21] = RCAR_GP_PIN(1, 23),	/* DU1_DB5 */
+		[22] = RCAR_GP_PIN(1, 24),	/* DU1_DB6 */
+		[23] = RCAR_GP_PIN(1, 25),	/* DU1_DB7 */
+		[24] = RCAR_GP_PIN(1, 26),	/* DU1_DOTCLKIN */
+		[25] = RCAR_GP_PIN(1, 27),	/* DU1_DOTCLKOUT */
+		[26] = RCAR_GP_PIN(1, 28),	/* DU1_HSYNC */
+		[27] = RCAR_GP_PIN(1, 29),	/* DU1_VSYNC */
+		[28] = RCAR_GP_PIN(1, 30),	/* DU1_EXODDF */
+		[29] = RCAR_GP_PIN(1, 31),	/* DU1_DISP */
+		[30] = RCAR_GP_PIN(2,  0),	/* DU1_CDE */
+		[31] = SH_PFC_PIN_NONE,
+	} },
+	{ PINMUX_BIAS_REG("PUPR4", 0xfffc0110, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(2, 30),	/* VI1_CLK */
+		[ 1] = SH_PFC_PIN_NONE,
+		[ 2] = SH_PFC_PIN_NONE,
+		[ 3] = RCAR_GP_PIN(2, 31),	/* VI1_HSYNC# */
+		[ 4] = RCAR_GP_PIN(3,  0),	/* VI1_VSYNC# */
+		[ 5] = RCAR_GP_PIN(3,  1),	/* VI1_DATA0 */
+		[ 6] = RCAR_GP_PIN(3,  2),	/* VI1_DATA1 */
+		[ 7] = RCAR_GP_PIN(3,  3),	/* VI1_DATA2 */
+		[ 8] = RCAR_GP_PIN(3,  4),	/* VI1_DATA3 */
+		[ 9] = RCAR_GP_PIN(3,  5),	/* VI1_DATA4 */
+		[10] = RCAR_GP_PIN(3,  6),	/* VI1_DATA5 */
+		[11] = RCAR_GP_PIN(3,  7),	/* VI1_DATA6 */
+		[12] = RCAR_GP_PIN(3,  8),	/* VI1_DATA7 */
+		[13] = RCAR_GP_PIN(3,  9),	/* VI1_G0 */
+		[14] = RCAR_GP_PIN(3, 10),	/* VI1_G1 */
+		[15] = RCAR_GP_PIN(3, 11),	/* VI1_G2 */
+		[16] = RCAR_GP_PIN(3, 12),	/* VI1_G3 */
+		[17] = RCAR_GP_PIN(3, 13),	/* VI1_G4 */
+		[18] = RCAR_GP_PIN(3, 14),	/* VI1_G5 */
+		[19] = RCAR_GP_PIN(3, 15),	/* VI1_G6 */
+		[20] = RCAR_GP_PIN(3, 16),	/* VI1_G7 */
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
+	} },
+	{ PINMUX_BIAS_REG("PUPR5", 0xfffc0114, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(3, 30),	/* SSI_SCK0129 */
+		[ 1] = RCAR_GP_PIN(3, 31),	/* SSI_WS0129 */
+		[ 2] = RCAR_GP_PIN(4,  0),	/* SSI_SDATA0 */
+		[ 3] = RCAR_GP_PIN(4,  1),	/* SSI_SDATA1 */
+		[ 4] = RCAR_GP_PIN(4,  2),	/* SSI_SDATA2 */
+		[ 5] = RCAR_GP_PIN(4,  3),	/* SSI_SCK34 */
+		[ 6] = RCAR_GP_PIN(4,  4),	/* SSI_WS34 */
+		[ 7] = RCAR_GP_PIN(4,  5),	/* SSI_SDATA3 */
+		[ 8] = RCAR_GP_PIN(4,  6),	/* SSI_SDATA4 */
+		[ 9] = RCAR_GP_PIN(4,  7),	/* SSI_SCK5 */
+		[10] = RCAR_GP_PIN(4,  8),	/* SSI_WS5 */
+		[11] = RCAR_GP_PIN(4,  9),	/* SSI_SDATA5 */
+		[12] = RCAR_GP_PIN(4, 10),	/* SSI_SCK6 */
+		[13] = RCAR_GP_PIN(4, 11),	/* SSI_WS6 */
+		[14] = RCAR_GP_PIN(4, 12),	/* SSI_SDATA6 */
+		[15] = RCAR_GP_PIN(4, 13),	/* SSI_SCK78 */
+		[16] = RCAR_GP_PIN(4, 14),	/* SSI_WS78 */
+		[17] = RCAR_GP_PIN(4, 15),	/* SSI_SDATA7 */
+		[18] = RCAR_GP_PIN(4, 16),	/* SSI_SDATA8 */
+		[19] = SH_PFC_PIN_NONE,
+		[20] = RCAR_GP_PIN(3, 17),	/* SD0_CLK */
+		[21] = RCAR_GP_PIN(3, 18),	/* SD0_CMD */
+		[22] = RCAR_GP_PIN(3, 21),	/* SD0_DAT0 */
+		[23] = RCAR_GP_PIN(3, 22),	/* SD0_DAT1 */
+		[24] = RCAR_GP_PIN(3, 23),	/* SD0_DAT2 */
+		[25] = RCAR_GP_PIN(3, 24),	/* SD0_DAT3 */
+		[26] = RCAR_GP_PIN(3, 19),	/* SD0_CD */
+		[27] = RCAR_GP_PIN(3, 20),	/* SD0_WP */
+		[28] = RCAR_GP_PIN(3, 28),	/* AUDIO_CLKA */
+		[29] = RCAR_GP_PIN(3, 29),	/* AUDIO_CLKB */
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
+	} },
+	{ PINMUX_BIAS_REG("PUPR6", 0xfffc0118, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(4, 26),	/* PENC0 */
+		[ 1] = RCAR_GP_PIN(4, 27),	/* PENC1 */
+		[ 2] = RCAR_GP_PIN(4, 28),	/* PENC2 */
+		[ 3] = SH_PFC_PIN_NONE,
+		[ 4] = SH_PFC_PIN_NONE,
+		[ 5] = RCAR_GP_PIN(4, 20),	/* HTX0 */
+		[ 6] = RCAR_GP_PIN(4, 21),	/* HRX0 */
+		[ 7] = RCAR_GP_PIN(4, 17),	/* HSCK0 */
+		[ 8] = RCAR_GP_PIN(4, 18),	/* HCTS0# */
+		[ 9] = RCAR_GP_PIN(4, 19),	/* HRTS0# */
+		[10] = RCAR_GP_PIN(4, 22),	/* HSPI_CLK0 */
+		[11] = RCAR_GP_PIN(4, 23),	/* HSPI_CS0# */
+		[12] = RCAR_GP_PIN(4, 24),	/* HSPI_TX0 */
+		[13] = RCAR_GP_PIN(4, 25),	/* HSPI_RX0 */
+		[14] = RCAR_GP_PIN(4, 29),	/* FMCLK */
+		[15] = RCAR_GP_PIN(4, 30),	/* BPFCLK */
+		[16] = RCAR_GP_PIN(4, 31),	/* FMIN */
+		[17] = RCAR_GP_PIN(0, 12),	/* CLKOUT */
+		[18] = RCAR_GP_PIN(0, 13),	/* CS0# */
+		[19] = RCAR_GP_PIN(0, 14),	/* CS1#/A26 */
+		[20] = RCAR_GP_PIN(5, 16),	/* RD# */
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
+	} },
+	{ /* sentinel */ }
+};
+
+static const struct sh_pfc_soc_operations r8a7779_pfc_ops = {
+	.get_bias = rcar_pinmux_get_bias,
+	.set_bias = rcar_pinmux_set_bias,
+};
+
 const struct sh_pfc_soc_info r8a7779_pinmux_info = {
 	.name = "r8a7779_pfc",
+	.ops  = &r8a7779_pfc_ops,
 
 	.unlock_reg = 0xfffc0000, /* PMMR */
 
@@ -3937,6 +4257,7 @@ const struct sh_pfc_soc_info r8a7779_pinmux_info = {
 	.nr_functions = ARRAY_SIZE(pinmux_functions),
 
 	.cfg_regs = pinmux_config_regs,
+	.bias_regs = pinmux_bias_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.34.1

