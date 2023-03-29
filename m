Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070286CD3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjC2Hxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjC2Hxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:53:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7E40F2;
        Wed, 29 Mar 2023 00:52:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so15344565pjz.1;
        Wed, 29 Mar 2023 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680076363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKhnMooh27ljfK1QnQ9/evwUgskAV4ZMTmZuvKU5mBY=;
        b=UgMqHJPBvWDCU91957kpfhVA9CqWRoeGN5MhxED2iSP0Htn2uUfXlasl0MAysQj9C9
         ktAdVuXflLjNYRycjWjedhdObuauEgfg4SaAPT5aPBACWTQdyztRX/pI1pWLbJVgapBo
         mGvbvbDvE0LZkMfarHjyLV6lYr35As1z5yI3fsTFsb6j3GK79H5W2PraZtGa0zXVR6IX
         WkF/qKcJPqP9AD7cBHjGnBYGvFJGvvSApqnF+FJhkTmOtsb4KCEHcf+WXeb347Ydlovj
         KAc7ct9Ki2uBnjHBwDfcWWJRC7PCIVw5jJeoeVWYhnZrJLIU9xr9F4BH5DJxxUFUXGiJ
         3kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKhnMooh27ljfK1QnQ9/evwUgskAV4ZMTmZuvKU5mBY=;
        b=RoeKJY6upXwRdhHtuecC1D2yT4uXcoixGteYRqgRSWFSarVvSU9ygZpWeRH0hMIIaH
         GdtkdosYBWYmLQWLsDIRBfybdLlL6aFOyojOLmyuvrCrBLp5iV0BsankTlcNRALimLkT
         JzhR4mmIujoWnPujwW9pBhYQ8qP9fHTtbsCugUXOdtqq8PvPkQa5pE9iDE4vbcdDrCuJ
         RHWLqglZbMNhnye7X/cN4KZ+t6mS1SSZCeICmOjQF+jN/PnFIRBrfk+3pvw72grcPnZQ
         h3GfABUiKHTYA9O+RuRznHJtkJogZAMbqdWhzsJYpevf/DFJyTaPzhqnc+61rKOJzZa8
         byfg==
X-Gm-Message-State: AAQBX9duOH2T6jkqaBEij0obNxPWtxd5XkIAdh9m+H9MSFo8WIOK9Ic8
        YmztdA+g0EevfebmVrjmchTKMxr57RhCxQRBwD4=
X-Google-Smtp-Source: AKy350asoAfra9mFwDgj9VIOTy7SIa87oCv6vnewIsikK1/pSAhWMN3uwOaB4bQlY2VcSq8QHvSZaA==
X-Received: by 2002:a17:902:db0c:b0:1a2:2091:eebd with SMTP id m12-20020a170902db0c00b001a22091eebdmr19683180plx.22.1680076362461;
        Wed, 29 Mar 2023 00:52:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019a773419a6sm22357976plp.170.2023.03.29.00.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:52:42 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] clk: hisilicon: Convert to platform driver
Date:   Wed, 29 Mar 2023 15:50:52 +0800
Message-Id: <20230329075104.165176-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329075104.165176-1-mmyangfl@gmail.com>
References: <20230329075104.165176-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And use common helper functions.

This patch is part of devm APIs migration.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3620.c  | 195 ++++++++++++------------
 drivers/clk/hisilicon/clk-hi6220.c  | 225 +++++++++++++---------------
 drivers/clk/hisilicon/clk-hip04.c   |  41 +++--
 drivers/clk/hisilicon/clk-hix5hd2.c |  83 ++++++----
 4 files changed, 281 insertions(+), 263 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..1eacf77b0d8c 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -22,48 +23,48 @@
 #include "clk.h"
 
 /* clock parent list */
-static const char *const timer0_mux_p[] __initconst = { "osc32k", "timerclk01", };
-static const char *const timer1_mux_p[] __initconst = { "osc32k", "timerclk01", };
-static const char *const timer2_mux_p[] __initconst = { "osc32k", "timerclk23", };
-static const char *const timer3_mux_p[] __initconst = { "osc32k", "timerclk23", };
-static const char *const timer4_mux_p[] __initconst = { "osc32k", "timerclk45", };
-static const char *const timer5_mux_p[] __initconst = { "osc32k", "timerclk45", };
-static const char *const timer6_mux_p[] __initconst = { "osc32k", "timerclk67", };
-static const char *const timer7_mux_p[] __initconst = { "osc32k", "timerclk67", };
-static const char *const timer8_mux_p[] __initconst = { "osc32k", "timerclk89", };
-static const char *const timer9_mux_p[] __initconst = { "osc32k", "timerclk89", };
-static const char *const uart0_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart1_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart2_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart3_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart4_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const spi0_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
-static const char *const spi1_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
-static const char *const spi2_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
+static const char *const timer0_mux_p[] = { "osc32k", "timerclk01", };
+static const char *const timer1_mux_p[] = { "osc32k", "timerclk01", };
+static const char *const timer2_mux_p[] = { "osc32k", "timerclk23", };
+static const char *const timer3_mux_p[] = { "osc32k", "timerclk23", };
+static const char *const timer4_mux_p[] = { "osc32k", "timerclk45", };
+static const char *const timer5_mux_p[] = { "osc32k", "timerclk45", };
+static const char *const timer6_mux_p[] = { "osc32k", "timerclk67", };
+static const char *const timer7_mux_p[] = { "osc32k", "timerclk67", };
+static const char *const timer8_mux_p[] = { "osc32k", "timerclk89", };
+static const char *const timer9_mux_p[] = { "osc32k", "timerclk89", };
+static const char *const uart0_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart1_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart2_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart3_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart4_mux_p[] = { "osc26m", "pclk", };
+static const char *const spi0_mux_p[] = { "osc26m", "rclk_cfgaxi", };
+static const char *const spi1_mux_p[] = { "osc26m", "rclk_cfgaxi", };
+static const char *const spi2_mux_p[] = { "osc26m", "rclk_cfgaxi", };
 /* share axi parent */
-static const char *const saxi_mux_p[] __initconst = { "armpll3", "armpll2", };
-static const char *const pwm0_mux_p[] __initconst = { "osc32k", "osc26m", };
-static const char *const pwm1_mux_p[] __initconst = { "osc32k", "osc26m", };
-static const char *const sd_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc1_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc1_mux2_p[] __initconst = { "osc26m", "mmc1_div", };
-static const char *const g2d_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const venc_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const vdec_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const vpp_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const edc0_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const ldi0_mux_p[] __initconst = { "armpll2", "armpll4",
+static const char *const saxi_mux_p[] = { "armpll3", "armpll2", };
+static const char *const pwm0_mux_p[] = { "osc32k", "osc26m", };
+static const char *const pwm1_mux_p[] = { "osc32k", "osc26m", };
+static const char *const sd_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc1_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc1_mux2_p[] = { "osc26m", "mmc1_div", };
+static const char *const g2d_mux_p[] = { "armpll2", "armpll3", };
+static const char *const venc_mux_p[] = { "armpll2", "armpll3", };
+static const char *const vdec_mux_p[] = { "armpll2", "armpll3", };
+static const char *const vpp_mux_p[] = { "armpll2", "armpll3", };
+static const char *const edc0_mux_p[] = { "armpll2", "armpll3", };
+static const char *const ldi0_mux_p[] = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
-static const char *const edc1_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const ldi1_mux_p[] __initconst = { "armpll2", "armpll4",
+static const char *const edc1_mux_p[] = { "armpll2", "armpll3", };
+static const char *const ldi1_mux_p[] = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
-static const char *const rclk_hsic_p[] __initconst = { "armpll3", "armpll2", };
-static const char *const mmc2_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc3_mux_p[] __initconst = { "armpll2", "armpll3", };
+static const char *const rclk_hsic_p[] = { "armpll3", "armpll2", };
+static const char *const mmc2_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc3_mux_p[] = { "armpll2", "armpll3", };
 
 
 /* fixed rate clocks */
-static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] = {
 	{ HI3620_OSC32K,   "osc32k",   NULL, 0, 32768, },
 	{ HI3620_OSC26M,   "osc26m",   NULL, 0, 26000000, },
 	{ HI3620_PCLK,     "pclk",     NULL, 0, 26000000, },
@@ -76,13 +77,13 @@ static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
 };
 
 /* fixed factor clocks */
-static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] __initdata = {
+static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] = {
 	{ HI3620_RCLK_TCXO,   "rclk_tcxo",   "osc26m",   1, 4,  0, },
 	{ HI3620_RCLK_CFGAXI, "rclk_cfgaxi", "armpll2",  1, 30, 0, },
 	{ HI3620_RCLK_PICO,   "rclk_pico",   "hsic_div", 1, 40, 0, },
 };
 
-static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
+static struct hisi_mux_clock hi3620_mux_clks[] = {
 	{ HI3620_TIMER0_MUX, "timer0_mux", timer0_mux_p, ARRAY_SIZE(timer0_mux_p), CLK_SET_RATE_PARENT, 0,     15, 2, 0,                   },
 	{ HI3620_TIMER1_MUX, "timer1_mux", timer1_mux_p, ARRAY_SIZE(timer1_mux_p), CLK_SET_RATE_PARENT, 0,     17, 2, 0,                   },
 	{ HI3620_TIMER2_MUX, "timer2_mux", timer2_mux_p, ARRAY_SIZE(timer2_mux_p), CLK_SET_RATE_PARENT, 0,     19, 2, 0,                   },
@@ -120,7 +121,7 @@ static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
 	{ HI3620_MMC3_MUX,   "mmc3_mux",   mmc3_mux_p,   ARRAY_SIZE(mmc3_mux_p),   CLK_SET_RATE_PARENT, 0x140, 9,  1, CLK_MUX_HIWORD_MASK, },
 };
 
-static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
+static struct hisi_divider_clock hi3620_div_clks[] = {
 	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
@@ -130,7 +131,7 @@ static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
 	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
 };
 
-static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
+static struct hisi_gate_clock hi3620_separated_gate_clks[] = {
 	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", CLK_SET_RATE_PARENT, 0x20, 0, 0, },
 	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x20, 1, 0, },
 	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", CLK_SET_RATE_PARENT, 0x20, 2, 0, },
@@ -192,29 +193,19 @@ static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
 	{ HI3620_MCU_CLK,      "mcu_clk",      "acp_clk",      CLK_SET_RATE_PARENT, 0x50, 24, 0, },
 };
 
-static void __init hi3620_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI3620_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hi3620_fixed_rate_clks,
-				     ARRAY_SIZE(hi3620_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
-				       ARRAY_SIZE(hi3620_fixed_factor_clks),
-				       clk_data);
-	hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
-				  clk_data);
-	hisi_clk_register_gate_sep(hi3620_separated_gate_clks,
-				   ARRAY_SIZE(hi3620_separated_gate_clks),
-				   clk_data);
-}
-CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
+static const struct hisi_clocks hi3620_clks = {
+	.nr = HI3620_NR_CLKS,
+	.fixed_rate_clks = hi3620_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3620_fixed_rate_clks),
+	.fixed_factor_clks = hi3620_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3620_fixed_factor_clks),
+	.mux_clks = hi3620_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3620_mux_clks),
+	.divider_clks = hi3620_div_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3620_div_clks),
+	.gate_sep_clks = hi3620_separated_gate_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3620_separated_gate_clks),
+};
 
 struct hisi_mmc_clock {
 	unsigned int		id;
@@ -252,7 +243,7 @@ struct clk_mmc {
 
 #define to_mmc(_hw) container_of(_hw, struct clk_mmc, hw)
 
-static struct hisi_mmc_clock hi3620_mmc_clks[] __initdata = {
+static struct hisi_mmc_clock hi3620_mmc_clks[] = {
 	{ HI3620_SD_CIUCLK,	"sd_bclk1", "sd_clk", CLK_SET_RATE_PARENT, 0x1f8, 0, 0x1f8, 1, 3, 0x1f8, 4, 4, 0x1f8, 8, 4},
 	{ HI3620_MMC_CIUCLK1,   "mmc_bclk1", "mmc_clk1", CLK_SET_RATE_PARENT, 0x1f8, 12, 0x1f8, 13, 3, 0x1f8, 16, 4, 0x1f8, 20, 4},
 	{ HI3620_MMC_CIUCLK2,   "mmc_bclk2", "mmc_clk2", CLK_SET_RATE_PARENT, 0x1f8, 24, 0x1f8, 25, 3, 0x1f8, 28, 4, 0x1fc, 0, 4},
@@ -408,8 +399,9 @@ static const struct clk_ops clk_mmc_ops = {
 	.recalc_rate = mmc_clk_recalc_rate,
 };
 
-static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
-			void __iomem *base, struct device_node *np)
+static struct clk *
+clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
+		      void __iomem *base)
 {
 	struct clk_mmc *mclk;
 	struct clk *clk;
@@ -445,39 +437,52 @@ static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 	return clk;
 }
 
-static void __init hi3620_mmc_clk_init(struct device_node *node)
+static int hisi_register_clk_mmc(struct device *dev, const void *clocks,
+				 int nums, struct hisi_clock_data *data)
 {
-	void __iomem *base;
-	int i, num = ARRAY_SIZE(hi3620_mmc_clks);
-	struct clk_onecell_data *clk_data;
-
-	if (!node) {
-		pr_err("failed to find pctrl node in DTS\n");
-		return;
-	}
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("failed to map pctrl\n");
-		return;
+	const struct hisi_mmc_clock *clks = clocks;
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			return PTR_ERR(clk);
+		}
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (WARN_ON(!clk_data))
-		return;
+	return 0;
+}
 
-	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		return;
+static const struct hisi_clocks hi3620_clks_mmc = {
+	.nr = ARRAY_SIZE(hi3620_mmc_clks),
+	.customized_clks = hi3620_mmc_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3620_mmc_clks),
+	.clk_register_customized = hisi_register_clk_mmc,
+};
 
-	for (i = 0; i < num; i++) {
-		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-		clk_data->clks[mmc_clk->id] =
-			hisi_register_clk_mmc(mmc_clk, base, node);
-	}
+static const struct of_device_id hi3620_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi3620-clock",
+	  .data = &hi3620_clks },
+	{ .compatible = "hisilicon,hi3620-mmc-clock",
+	  .data = &hi3620_clks_mmc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3620_clk_match_table);
+
+static struct platform_driver hi3620_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hi3620-clock",
+		.of_match_table = hi3620_clk_match_table,
+	},
+};
 
-	clk_data->clk_num = num;
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-}
+module_platform_driver(hi3620_clk_driver);
 
-CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon Hi3620 Clock Driver");
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index e7cdf72d4b06..cdc17f82ce2d 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -9,20 +9,15 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hi6220-clock.h>
 
 #include "clk.h"
 
-
 /* clocks in AO (always on) controller */
-static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] = {
 	{ HI6220_REF32K,	"ref32k",	NULL, 0, 32764,     },
 	{ HI6220_CLK_TCXO,	"clk_tcxo",	NULL, 0, 19200000,  },
 	{ HI6220_MMC1_PAD,	"mmc1_pad",	NULL, 0, 100000000, },
@@ -38,7 +33,7 @@ static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] __initdata = {
 	{ HI6220_PLL_DDR,	"ddrpll0",      NULL, 0, 1600000000,},
 };
 
-static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] __initdata = {
+static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] = {
 	{ HI6220_300M,         "clk_300m",    "syspll",          1, 4, 0, },
 	{ HI6220_150M,         "clk_150m",    "clk_300m",        1, 2, 0, },
 	{ HI6220_PICOPHY_SRC,  "picophy_src", "clk_150m",        1, 4, 0, },
@@ -51,7 +46,7 @@ static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] __initdata = {
 	{ HI6220_MMC2_SMP,     "mmc2_sample", "mmc2_sel",        1, 8, 0, },
 };
 
-static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
+static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] = {
 	{ HI6220_WDT0_PCLK,   "wdt0_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 12, 0, },
 	{ HI6220_WDT1_PCLK,   "wdt1_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 13, 0, },
 	{ HI6220_WDT2_PCLK,   "wdt2_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 14, 0, },
@@ -69,47 +64,43 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
 	{ HI6220_RTC1_PCLK,   "rtc1_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 26, 0, },
 };
 
-static void __init hi6220_clk_ao_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data_ao;
-
-	clk_data_ao = hisi_clk_init(np, HI6220_AO_NR_CLKS);
-	if (!clk_data_ao)
-		return;
-
-	hisi_clk_register_fixed_rate(hi6220_fixed_rate_clks,
-				ARRAY_SIZE(hi6220_fixed_rate_clks), clk_data_ao);
-
-	hisi_clk_register_fixed_factor(hi6220_fixed_factor_clks,
-				ARRAY_SIZE(hi6220_fixed_factor_clks), clk_data_ao);
+static const struct hisi_clocks hi6220_ao_clks = {
+	.nr = HI6220_AO_NR_CLKS,
+	.fixed_rate_clks = hi6220_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi6220_fixed_rate_clks),
+	.fixed_factor_clks = hi6220_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi6220_fixed_factor_clks),
+	.gate_sep_clks = hi6220_separated_gate_clks_ao,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_ao),
+};
 
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
-				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
+static void hi6220_clk_ao_early_init(struct device_node *np)
+{
+	hisi_clk_early_init(np, &hi6220_ao_clks);
 }
 /* Allow reset driver to probe as well */
-CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
-
+CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_early_init);
 
 /* clocks in sysctrl */
-static const char *mmc0_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc0_mux1_p[] __initdata = { "mmc0_mux0", "pll_media_gate", };
-static const char *mmc0_src_p[] __initdata = { "mmc0srcsel", "mmc0_div", };
-static const char *mmc1_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc1_mux1_p[] __initdata = { "mmc1_mux0", "pll_media_gate", };
-static const char *mmc1_src_p[]  __initdata = { "mmc1srcsel", "mmc1_div", };
-static const char *mmc2_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc2_mux1_p[] __initdata = { "mmc2_mux0", "pll_media_gate", };
-static const char *mmc2_src_p[]  __initdata = { "mmc2srcsel", "mmc2_div", };
-static const char *mmc0_sample_in[] __initdata = { "mmc0_sample", "mmc0_pad", };
-static const char *mmc1_sample_in[] __initdata = { "mmc1_sample", "mmc1_pad", };
-static const char *mmc2_sample_in[] __initdata = { "mmc2_sample", "mmc2_pad", };
-static const char *uart1_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart2_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart3_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart4_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *hifi_src[] __initdata = { "syspll", "pll_media_gate", };
-
-static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
+static const char * const mmc0_mux0_p[] = { "pll_ddr_gate", "syspll", };
+static const char * const mmc0_mux1_p[] = { "mmc0_mux0", "pll_media_gate", };
+static const char * const mmc0_src_p[] = { "mmc0srcsel", "mmc0_div", };
+static const char * const mmc1_mux0_p[] = { "pll_ddr_gate", "syspll", };
+static const char * const mmc1_mux1_p[] = { "mmc1_mux0", "pll_media_gate", };
+static const char * const mmc1_src_p[]  = { "mmc1srcsel", "mmc1_div", };
+static const char * const mmc2_mux0_p[] = { "pll_ddr_gate", "syspll", };
+static const char * const mmc2_mux1_p[] = { "mmc2_mux0", "pll_media_gate", };
+static const char * const mmc2_src_p[]  = { "mmc2srcsel", "mmc2_div", };
+static const char * const mmc0_sample_in[] = { "mmc0_sample", "mmc0_pad", };
+static const char * const mmc1_sample_in[] = { "mmc1_sample", "mmc1_pad", };
+static const char * const mmc2_sample_in[] = { "mmc2_sample", "mmc2_pad", };
+static const char * const uart1_src[] = { "clk_tcxo", "clk_150m", };
+static const char * const uart2_src[] = { "clk_tcxo", "clk_150m", };
+static const char * const uart3_src[] = { "clk_tcxo", "clk_150m", };
+static const char * const uart4_src[] = { "clk_tcxo", "clk_150m", };
+static const char * const hifi_src[] = { "syspll", "pll_media_gate", };
+
+static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] = {
 	{ HI6220_MMC0_CLK,      "mmc0_clk",      "mmc0_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
 	{ HI6220_MMC0_CIUCLK,   "mmc0_ciuclk",   "mmc0_smp_in",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
 	{ HI6220_MMC1_CLK,      "mmc1_clk",      "mmc1_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 1,  0, },
@@ -146,7 +137,7 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
 	{ HI6220_CS_ATB_SYSPLL, "cs_atb_syspll", "syspll",         CLK_SET_RATE_PARENT|CLK_IS_CRITICAL,   0x270, 12, 0, },
 };
 
-static struct hisi_mux_clock hi6220_mux_clks_sys[] __initdata = {
+static struct hisi_mux_clock hi6220_mux_clks_sys[] = {
 	{ HI6220_MMC0_SRC,    "mmc0_src",    mmc0_src_p,     ARRAY_SIZE(mmc0_src_p),     CLK_SET_RATE_PARENT, 0x4,   0,  1, 0, },
 	{ HI6220_MMC0_SMP_IN, "mmc0_smp_in", mmc0_sample_in, ARRAY_SIZE(mmc0_sample_in), CLK_SET_RATE_PARENT, 0x4,   0,  1, 0, },
 	{ HI6220_MMC1_SRC,    "mmc1_src",    mmc1_src_p,     ARRAY_SIZE(mmc1_src_p),     CLK_SET_RATE_PARENT, 0x4,   2,  1, 0, },
@@ -166,7 +157,7 @@ static struct hisi_mux_clock hi6220_mux_clks_sys[] __initdata = {
 	{ HI6220_MMC2_MUX1,   "mmc2_mux1",   mmc2_mux1_p,    ARRAY_SIZE(mmc2_mux1_p),    CLK_SET_RATE_PARENT, 0x400, 15, 1, CLK_MUX_HIWORD_MASK,},
 };
 
-static struct hi6220_divider_clock hi6220_div_clks_sys[] __initdata = {
+static struct hi6220_divider_clock hi6220_div_clks_sys[] = {
 	{ HI6220_CLK_BUS,     "clk_bus",     "clk_300m",      CLK_SET_RATE_PARENT, 0x490, 0,  4, 7, },
 	{ HI6220_MMC0_DIV,    "mmc0_div",    "mmc0_syspll",   CLK_SET_RATE_PARENT, 0x494, 0,  6, 7, },
 	{ HI6220_MMC1_DIV,    "mmc1_div",    "mmc1_syspll",   CLK_SET_RATE_PARENT, 0x498, 0,  6, 7, },
@@ -177,32 +168,23 @@ static struct hi6220_divider_clock hi6220_div_clks_sys[] __initdata = {
 	{ HI6220_CS_ATB_DIV,  "cs_atb_div",  "cs_atb_syspll", CLK_SET_RATE_PARENT, 0x4a4, 0,  4, 7, },
 };
 
-static void __init hi6220_clk_sys_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI6220_SYS_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_sys,
-			ARRAY_SIZE(hi6220_separated_gate_clks_sys), clk_data);
-
-	hisi_clk_register_mux(hi6220_mux_clks_sys,
-			ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
-
-	hi6220_clk_register_divider(hi6220_div_clks_sys,
-			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
-}
-CLK_OF_DECLARE_DRIVER(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
-
+static const struct hisi_clocks hi6220_sys_clks = {
+	.nr = HI6220_SYS_NR_CLKS,
+	.mux_clks = hi6220_mux_clks_sys,
+	.mux_clks_num = ARRAY_SIZE(hi6220_mux_clks_sys),
+	.gate_sep_clks = hi6220_separated_gate_clks_sys,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_sys),
+	.customized_clks = hi6220_div_clks_sys,
+	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_sys),
+	/* .clk_register_customized = hi6220_clk_register_divider, */
+};
 
 /* clocks in media controller */
-static const char *clk_1000_1200_src[] __initdata = { "pll_gpu_gate", "media_syspll_src", };
-static const char *clk_1440_1200_src[] __initdata = { "media_syspll_src", "media_pll_src", };
-static const char *clk_1000_1440_src[] __initdata = { "pll_gpu_gate", "media_pll_src", };
+static const char * const clk_1000_1200_src[] = { "pll_gpu_gate", "media_syspll_src", };
+static const char * const clk_1440_1200_src[] = { "media_syspll_src", "media_pll_src", };
+static const char * const clk_1000_1440_src[] = { "pll_gpu_gate", "media_pll_src", };
 
-static struct hisi_gate_clock hi6220_separated_gate_clks_media[] __initdata = {
+static struct hisi_gate_clock hi6220_separated_gate_clks_media[] = {
 	{ HI6220_DSI_PCLK,       "dsi_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 0,  0, },
 	{ HI6220_G3D_PCLK,       "g3d_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 1,  0, },
 	{ HI6220_ACLK_CODEC_VPU, "aclk_codec_vpu",   "ade_core_src",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 3,  0, },
@@ -218,13 +200,13 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_media[] __initdata = {
 	{ HI6220_MED_SYSPLL,     "media_syspll_src", "media_syspll",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 17, 0, },
 };
 
-static struct hisi_mux_clock hi6220_mux_clks_media[] __initdata = {
+static struct hisi_mux_clock hi6220_mux_clks_media[] = {
 	{ HI6220_1440_1200, "clk_1440_1200", clk_1440_1200_src, ARRAY_SIZE(clk_1440_1200_src), CLK_SET_RATE_PARENT, 0x51c, 0, 1, 0, },
 	{ HI6220_1000_1200, "clk_1000_1200", clk_1000_1200_src, ARRAY_SIZE(clk_1000_1200_src), CLK_SET_RATE_PARENT, 0x51c, 1, 1, 0, },
 	{ HI6220_1000_1440, "clk_1000_1440", clk_1000_1440_src, ARRAY_SIZE(clk_1000_1440_src), CLK_SET_RATE_PARENT, 0x51c, 6, 1, 0, },
 };
 
-static struct hi6220_divider_clock hi6220_div_clks_media[] __initdata = {
+static struct hi6220_divider_clock hi6220_div_clks_media[] = {
 	{ HI6220_CODEC_JPEG,    "codec_jpeg_aclk", "media_pll_src",  CLK_SET_RATE_PARENT, 0xcbc, 0,  4, 23, },
 	{ HI6220_ISP_SCLK_SRC,  "isp_sclk_src",    "isp_sclk_gate",  CLK_SET_RATE_PARENT, 0xcbc, 8,  4, 15, },
 	{ HI6220_ISP_SCLK1,     "isp_sclk1",       "isp_sclk_gate1", CLK_SET_RATE_PARENT, 0xcbc, 24, 4, 31, },
@@ -234,28 +216,19 @@ static struct hi6220_divider_clock hi6220_div_clks_media[] __initdata = {
 	{ HI6220_CODEC_VPU_SRC, "codec_vpu_src",   "codec_vpu_gate", CLK_SET_RATE_PARENT, 0xcc4, 24, 6, 31, },
 };
 
-static void __init hi6220_clk_media_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI6220_MEDIA_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_media,
-				ARRAY_SIZE(hi6220_separated_gate_clks_media), clk_data);
-
-	hisi_clk_register_mux(hi6220_mux_clks_media,
-				ARRAY_SIZE(hi6220_mux_clks_media), clk_data);
-
-	hi6220_clk_register_divider(hi6220_div_clks_media,
-				ARRAY_SIZE(hi6220_div_clks_media), clk_data);
-}
-CLK_OF_DECLARE_DRIVER(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
-
+static const struct hisi_clocks hi6220_media_clks = {
+	.nr = HI6220_MEDIA_NR_CLKS,
+	.mux_clks = hi6220_mux_clks_media,
+	.mux_clks_num = ARRAY_SIZE(hi6220_mux_clks_media),
+	.gate_sep_clks = hi6220_separated_gate_clks_media,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_media),
+	.customized_clks = hi6220_div_clks_media,
+	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_media),
+	/* .clk_register_customized = hi6220_clk_register_divider, */
+};
 
 /* clocks in pmctrl */
-static struct hisi_gate_clock hi6220_gate_clks_power[] __initdata = {
+static struct hisi_gate_clock hi6220_gate_clks_power[] = {
 	{ HI6220_PLL_GPU_GATE,   "pll_gpu_gate",   "gpupll",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x8,  0,  0, },
 	{ HI6220_PLL1_DDR_GATE,  "pll1_ddr_gate",  "ddrpll1",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x10, 0,  0, },
 	{ HI6220_PLL_DDR_GATE,   "pll_ddr_gate",   "ddrpll0",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x18, 0,  0, },
@@ -263,26 +236,19 @@ static struct hisi_gate_clock hi6220_gate_clks_power[] __initdata = {
 	{ HI6220_PLL0_BBP_GATE,  "pll0_bbp_gate",  "bbppll0",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x48, 0,  0, },
 };
 
-static struct hi6220_divider_clock hi6220_div_clks_power[] __initdata = {
+static struct hi6220_divider_clock hi6220_div_clks_power[] = {
 	{ HI6220_DDRC_SRC,  "ddrc_src",  "ddr_sel_src", CLK_SET_RATE_PARENT, 0x5a8, 0, 4, 0, },
 	{ HI6220_DDRC_AXI1, "ddrc_axi1", "ddrc_src",    CLK_SET_RATE_PARENT, 0x5a8, 8, 2, 0, },
 };
 
-static void __init hi6220_clk_power_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI6220_POWER_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi6220_gate_clks_power,
-				ARRAY_SIZE(hi6220_gate_clks_power), clk_data);
-
-	hi6220_clk_register_divider(hi6220_div_clks_power,
-				ARRAY_SIZE(hi6220_div_clks_power), clk_data);
-}
-CLK_OF_DECLARE(hi6220_clk_power, "hisilicon,hi6220-pmctrl", hi6220_clk_power_init);
+static const struct hisi_clocks hi6220_power_clks = {
+	.nr = HI6220_POWER_NR_CLKS,
+	.gate_clks = hi6220_gate_clks_power,
+	.gate_clks_num = ARRAY_SIZE(hi6220_gate_clks_power),
+	.customized_clks = hi6220_div_clks_power,
+	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_power),
+	/* .clk_register_customized = hi6220_clk_register_divider, */
+};
 
 /* clocks in acpu */
 static const struct hisi_gate_clock hi6220_acpu_sc_gate_sep_clks[] = {
@@ -290,18 +256,37 @@ static const struct hisi_gate_clock hi6220_acpu_sc_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0xc, 11, 0, },
 };
 
-static void __init hi6220_clk_acpu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks);
+static const struct hisi_clocks hi6220_acpu_clks = {
+	.nr = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
+	.gate_sep_clks = hi6220_acpu_sc_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
+static const struct of_device_id hi6220_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi6220-aoctrl",
+	  .data = &hi6220_ao_clks },
+	{ .compatible = "hisilicon,hi6220-sysctrl",
+	  .data = &hi6220_sys_clks },
+	{ .compatible = "hisilicon,hi6220-mediactrl",
+	  .data = &hi6220_media_clks },
+	{ .compatible = "hisilicon,hi6220-pmctrl",
+	  .data = &hi6220_power_clks },
+	{ .compatible = "hisilicon,hi6220-acpu-sctrl",
+	  .data = &hi6220_acpu_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi6220_clk_match_table);
+
+static struct platform_driver hi6220_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hi6220-clock",
+		.of_match_table = hi6220_clk_match_table,
+	},
+};
 
-	hisi_clk_register_gate_sep(hi6220_acpu_sc_gate_sep_clks,
-				   ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
-				   clk_data);
-}
+module_platform_driver(hi6220_clk_driver);
 
-CLK_OF_DECLARE(hi6220_clk_acpu, "hisilicon,hi6220-acpu-sctrl", hi6220_clk_acpu_init);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi6220 Clock Driver");
diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index 785b9faf3ea5..e7d9582acc14 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -9,12 +9,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hip04-clock.h>
 
@@ -27,16 +23,29 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 	{ HIP04_CLK_168M, "clk168m",  NULL, 0, 168750000, },
 };
 
-static void __init hip04_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
+static const struct hisi_clocks hip04_clks = {
+	.nr = ARRAY_SIZE(hip04_fixed_rate_clks),
+	.fixed_rate_clks = hip04_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hip04_fixed_rate_clks),
+};
+
+static const struct of_device_id hip04_clk_match_table[] = {
+	{ .compatible = "hisilicon,hip04-clock",
+	  .data = &hip04_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hip04_clk_match_table);
+
+static struct platform_driver hip04_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hip04-clock",
+		.of_match_table = hip04_clk_match_table,
+	},
+};
 
-	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
-	if (!clk_data)
-		return;
+module_platform_driver(hip04_clk_driver);
 
-	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
-				     ARRAY_SIZE(hip04_fixed_rate_clks),
-				     clk_data);
-}
-CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon HiP04 Clock Driver");
diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 64bdd3f05725..f37a17649d26 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -4,13 +4,17 @@
  * Copyright (c) 2014 Hisilicon Limited.
  */
 
-#include <linux/of_address.h>
 #include <dt-bindings/clock/hix5hd2-clock.h>
+
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
 #include "clk.h"
 
-static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] = {
 	{ HIX5HD2_FIXED_1200M, "1200m", NULL, 0, 1200000000, },
 	{ HIX5HD2_FIXED_400M, "400m", NULL, 0, 400000000, },
 	{ HIX5HD2_FIXED_48M, "48m", NULL, 0, 48000000, },
@@ -43,19 +47,19 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
 	{ HIX5HD2_FIXED_83M, "83m", NULL, 0, 83333333, },
 };
 
-static const char *const sfc_mux_p[] __initconst = {
+static const char *const sfc_mux_p[] = {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
 
-static const char *const sdio_mux_p[] __initconst = {
+static const char *const sdio_mux_p[] = {
 		"75m", "100m", "50m", "15m", };
 static u32 sdio_mux_table[] = {0, 1, 2, 3};
 
-static const char *const fephy_mux_p[] __initconst = { "25m", "125m"};
+static const char *const fephy_mux_p[] = { "25m", "125m"};
 static u32 fephy_mux_table[] = {0, 1};
 
 
-static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
+static struct hisi_mux_clock hix5hd2_mux_clks[] = {
 	{ HIX5HD2_SFC_MUX, "sfc_mux", sfc_mux_p, ARRAY_SIZE(sfc_mux_p),
 		CLK_SET_RATE_PARENT, 0x5c, 8, 3, 0, sfc_mux_table, },
 	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio_mux_p, ARRAY_SIZE(sdio_mux_p),
@@ -67,7 +71,7 @@ static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0x120, 8, 2, 0, fephy_mux_table, },
 };
 
-static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
+static struct hisi_gate_clock hix5hd2_gate_clks[] = {
 	/* sfc */
 	{ HIX5HD2_SFC_CLK, "clk_sfc", "sfc_mux",
 		CLK_SET_RATE_PARENT, 0x5c, 0, 0, },
@@ -153,7 +157,7 @@ struct hix5hd2_clk_complex {
 	u32		phy_rst_mask;
 };
 
-static struct hix5hd2_complex_clock hix5hd2_complex_clks[] __initdata = {
+static struct hix5hd2_complex_clock hix5hd2_complex_clks[] = {
 	{"clk_mac0", "clk_fephy", HIX5HD2_MAC0_CLK,
 		0xcc, 0xa, 0x500, 0x120, 0, 0x10, TYPE_ETHER},
 	{"clk_mac1", "clk_fwd_sys", HIX5HD2_MAC1_CLK,
@@ -249,10 +253,11 @@ static const struct clk_ops clk_complex_ops = {
 	.disable = clk_complex_disable,
 };
 
-static void __init
-hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
+static int
+hix5hd2_clk_register_complex(struct device *dev, const void *clocks, int nums,
 			     struct hisi_clock_data *data)
 {
+	const struct hix5hd2_complex_clock *clks = clocks;
 	void __iomem *base = data->base;
 	int i;
 
@@ -263,7 +268,7 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 
 		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
-			return;
+			return -ENOMEM;
 
 		init.name = clks[i].name;
 		if (clks[i].type == TYPE_ETHER)
@@ -289,31 +294,45 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 			kfree(p_clk);
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(p_clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 	}
-}
 
-static void __init hix5hd2_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hix5hd2_fixed_rate_clks,
-				     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_mux(hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
-					clk_data);
-	hisi_clk_register_gate(hix5hd2_gate_clks,
-			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
-	hix5hd2_clk_register_complex(hix5hd2_complex_clks,
-				     ARRAY_SIZE(hix5hd2_complex_clks),
-				     clk_data);
+	return 0;
 }
 
-CLK_OF_DECLARE(hix5hd2_clk, "hisilicon,hix5hd2-clock", hix5hd2_clk_init);
+static const struct hisi_clocks hix5hd2_clks = {
+	.nr = HIX5HD2_NR_CLKS,
+	.fixed_rate_clks = hix5hd2_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hix5hd2_fixed_rate_clks),
+	.mux_clks = hix5hd2_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hix5hd2_mux_clks),
+	.gate_clks = hix5hd2_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hix5hd2_gate_clks),
+	.customized_clks = hix5hd2_complex_clks,
+	.customized_clks_num = ARRAY_SIZE(hix5hd2_complex_clks),
+	.clk_register_customized = hix5hd2_clk_register_complex,
+};
+
+static const struct of_device_id hix5hd2_clk_match_table[] = {
+	{ .compatible = "hisilicon,hix5hd2-clock",
+	  .data = &hix5hd2_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hix5hd2_clk_match_table);
+
+static struct platform_driver hix5hd2_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hix5hd2-clock",
+		.of_match_table = hix5hd2_clk_match_table,
+	},
+};
+
+module_platform_driver(hix5hd2_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hix5hd2 Clock Driver");
-- 
2.39.2

