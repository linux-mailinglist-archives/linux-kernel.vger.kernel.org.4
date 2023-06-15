Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3D731424
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbjFOJhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbjFOJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:36:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39642711;
        Thu, 15 Jun 2023 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821736; x=1718357736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fsE1GKEJT9o8hF3oHTltxYGtWY7BpO1yfiwFiBAYakM=;
  b=x+Hye9DK0ei6JSsjZBtRZBBt/YyFvgM7x83/CVwbTVKI6egnYwS1lZq/
   z/+3FXmU6tTcCFiupN+v+0spFhuerseMpsGqcmO6wBkgPfusms8RNmb2P
   Ksf857reDkSgQuvqybWqeOgJFoN/Uwq2JTJZckWSO3IV4ZYKPLtSsCegx
   mqC8eKo3jYy37KgqNqs/0OUJYnEcZCquItQmS9oaCL426Go2xJU/I4kIK
   CZQs+zR2EMTHNO25kHqvtiwBiHgC1eiBVZKEz/wyM8PA/bDgLmAgbxhxR
   pd7Wr0M0lka2M+JpmkSqr3jKkKSy2pPeQv2M0M8P27uo6TW4l5OLxdC+M
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="216166903"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:33 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 10/11] clk: at91: sama7g5: switch to parent_hw and parent_data
Date:   Thu, 15 Jun 2023 12:32:26 +0300
Message-ID: <20230615093227.576102-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615093227.576102-1-claudiu.beznea@microchip.com>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch SAMA7G5 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting. Extra time saved on registration is
~250us when running at 800MHz.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 796 +++++++++++++++++++++----------------
 1 file changed, 454 insertions(+), 342 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 3297e028c2c5..7e06ea22c8af 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -56,6 +56,18 @@ enum pll_ids {
 	PLL_ID_MAX,
 };
 
+/*
+ * PLL component identifier
+ * @PLL_COMPID_FRAC: Fractional PLL component identifier
+ * @PLL_COMPID_DIV0: 1st PLL divider component identifier
+ * @PLL_COMPID_DIV1: 2nd PLL divider component identifier
+ */
+enum pll_component_id {
+	PLL_COMPID_FRAC,
+	PLL_COMPID_DIV0,
+	PLL_COMPID_DIV1,
+};
+
 /*
  * PLL type identifiers
  * @PLL_TYPE_FRAC:	fractional PLL identifier
@@ -118,186 +130,234 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.output = pll_outputs,
 };
 
+/*
+ * SAMA7G5 PLL possible parents
+ * @SAMA7G5_PLL_PARENT_MAINCK: MAINCK is PLL a parent
+ * @SAMA7G5_PLL_PARENT_MAIN_XTAL: MAIN XTAL is a PLL parent
+ * @SAMA7G5_PLL_PARENT_FRACCK: Frac PLL is a PLL parent (for PLL dividers)
+ */
+enum sama7g5_pll_parent {
+	SAMA7G5_PLL_PARENT_MAINCK,
+	SAMA7G5_PLL_PARENT_MAIN_XTAL,
+	SAMA7G5_PLL_PARENT_FRACCK,
+};
+
 /*
  * PLL clocks description
  * @n:		clock name
- * @p:		clock parent
  * @l:		clock layout
  * @c:		clock characteristics
+ * @hw:		pointer to clk_hw
  * @t:		clock type
  * @f:		clock flags
+ * @p:		clock parent
  * @eid:	export index in sama7g5->chws[] array
  * @safe_div:	intermediate divider need to be set on PRE_RATE_CHANGE
  *		notification
  */
-static const struct {
+static struct sama7g5_pll {
 	const char *n;
-	const char *p;
 	const struct clk_pll_layout *l;
 	const struct clk_pll_characteristics *c;
+	struct clk_hw *hw;
 	unsigned long f;
+	enum sama7g5_pll_parent p;
 	u8 t;
 	u8 eid;
 	u8 safe_div;
 } sama7g5_plls[][PLL_ID_MAX] = {
 	[PLL_ID_CPU] = {
-		{ .n = "cpupll_fracck",
-		  .p = "mainck",
-		  .l = &pll_layout_frac,
-		  .c = &cpu_pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		   /*
-		    * This feeds cpupll_divpmcck which feeds CPU. It should
-		    * not be disabled.
-		    */
-		  .f = CLK_IS_CRITICAL, },
-
-		{ .n = "cpupll_divpmcck",
-		  .p = "cpupll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &cpu_pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		   /* This feeds CPU. It should not be disabled. */
-		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-		  .eid = PMC_CPUPLL,
-		  /*
-		   * Safe div=15 should be safe even for switching b/w 1GHz and
-		   * 90MHz (frac pll might go up to 1.2GHz).
-		   */
-		  .safe_div = 15, },
+		[PLL_COMPID_FRAC] = {
+			.n = "cpupll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAINCK,
+			.l = &pll_layout_frac,
+			.c = &cpu_pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			/*
+			 * This feeds cpupll_divpmcck which feeds CPU. It should
+			 * not be disabled.
+			 */
+			.f = CLK_IS_CRITICAL,
+		},
+
+		[PLL_COMPID_DIV0] = {
+			.n = "cpupll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &cpu_pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			/* This feeds CPU. It should not be disabled. */
+			.f = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
+			.eid = PMC_CPUPLL,
+			/*
+			 * Safe div=15 should be safe even for switching b/w 1GHz and
+			 * 90MHz (frac pll might go up to 1.2GHz).
+			 */
+			.safe_div = 15,
+		},
 	},
 
 	[PLL_ID_SYS] = {
-		{ .n = "syspll_fracck",
-		  .p = "mainck",
-		  .l = &pll_layout_frac,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		   /*
-		    * This feeds syspll_divpmcck which may feed critical parts
-		    * of the systems like timers. Therefore it should not be
-		    * disabled.
-		    */
-		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
-
-		{ .n = "syspll_divpmcck",
-		  .p = "syspll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		   /*
-		    * This may feed critical parts of the systems like timers.
-		    * Therefore it should not be disabled.
-		    */
-		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
-		  .eid = PMC_SYSPLL, },
+		[PLL_COMPID_FRAC] = {
+			.n = "syspll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAINCK,
+			.l = &pll_layout_frac,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			/*
+			 * This feeds syspll_divpmcck which may feed critical parts
+			 * of the systems like timers. Therefore it should not be
+			 * disabled.
+			 */
+			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
+		},
+
+		[PLL_COMPID_DIV0] = {
+			.n = "syspll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			/*
+			 * This may feed critical parts of the systems like timers.
+			 * Therefore it should not be disabled.
+			 */
+			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
+			.eid = PMC_SYSPLL,
+		},
 	},
 
 	[PLL_ID_DDR] = {
-		{ .n = "ddrpll_fracck",
-		  .p = "mainck",
-		  .l = &pll_layout_frac,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		   /*
-		    * This feeds ddrpll_divpmcck which feeds DDR. It should not
-		    * be disabled.
-		    */
-		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
-
-		{ .n = "ddrpll_divpmcck",
-		  .p = "ddrpll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		   /* This feeds DDR. It should not be disabled. */
-		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
+		[PLL_COMPID_FRAC] = {
+			.n = "ddrpll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAINCK,
+			.l = &pll_layout_frac,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			/*
+			 * This feeds ddrpll_divpmcck which feeds DDR. It should not
+			 * be disabled.
+			 */
+			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
+		},
+
+		[PLL_COMPID_DIV0] = {
+			.n = "ddrpll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			/* This feeds DDR. It should not be disabled. */
+			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
+		},
 	},
 
 	[PLL_ID_IMG] = {
-		{ .n = "imgpll_fracck",
-		  .p = "mainck",
-		  .l = &pll_layout_frac,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		  .f = CLK_SET_RATE_GATE, },
-
-		{ .n = "imgpll_divpmcck",
-		  .p = "imgpll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		       CLK_SET_RATE_PARENT, },
+		[PLL_COMPID_FRAC] = {
+			.n = "imgpll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAINCK,
+			.l = &pll_layout_frac,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			.f = CLK_SET_RATE_GATE,
+		},
+
+		[PLL_COMPID_DIV0] = {
+			.n = "imgpll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			     CLK_SET_RATE_PARENT,
+		},
 	},
 
 	[PLL_ID_BAUD] = {
-		{ .n = "baudpll_fracck",
-		  .p = "mainck",
-		  .l = &pll_layout_frac,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		  .f = CLK_SET_RATE_GATE, },
-
-		{ .n = "baudpll_divpmcck",
-		  .p = "baudpll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		       CLK_SET_RATE_PARENT, },
+		[PLL_COMPID_FRAC] = {
+			.n = "baudpll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAINCK,
+			.l = &pll_layout_frac,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			.f = CLK_SET_RATE_GATE, },
+
+		[PLL_COMPID_DIV0] = {
+			.n = "baudpll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			     CLK_SET_RATE_PARENT,
+		},
 	},
 
 	[PLL_ID_AUDIO] = {
-		{ .n = "audiopll_fracck",
-		  .p = "main_xtal",
-		  .l = &pll_layout_frac,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		  .f = CLK_SET_RATE_GATE, },
-
-		{ .n = "audiopll_divpmcck",
-		  .p = "audiopll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		       CLK_SET_RATE_PARENT,
-		  .eid = PMC_AUDIOPMCPLL, },
-
-		{ .n = "audiopll_diviock",
-		  .p = "audiopll_fracck",
-		  .l = &pll_layout_divio,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		       CLK_SET_RATE_PARENT,
-		  .eid = PMC_AUDIOIOPLL, },
+		[PLL_COMPID_FRAC] = {
+			.n = "audiopll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAIN_XTAL,
+			.l = &pll_layout_frac,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			.f = CLK_SET_RATE_GATE,
+		},
+
+		[PLL_COMPID_DIV0] = {
+			.n = "audiopll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			     CLK_SET_RATE_PARENT,
+			.eid = PMC_AUDIOPMCPLL,
+		},
+
+		[PLL_COMPID_DIV1] = {
+			.n = "audiopll_diviock",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divio,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			     CLK_SET_RATE_PARENT,
+			.eid = PMC_AUDIOIOPLL,
+		},
 	},
 
 	[PLL_ID_ETH] = {
-		{ .n = "ethpll_fracck",
-		  .p = "main_xtal",
-		  .l = &pll_layout_frac,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_FRAC,
-		  .f = CLK_SET_RATE_GATE, },
-
-		{ .n = "ethpll_divpmcck",
-		  .p = "ethpll_fracck",
-		  .l = &pll_layout_divpmc,
-		  .c = &pll_characteristics,
-		  .t = PLL_TYPE_DIV,
-		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		       CLK_SET_RATE_PARENT, },
+		[PLL_COMPID_FRAC] = {
+			.n = "ethpll_fracck",
+			.p = SAMA7G5_PLL_PARENT_MAIN_XTAL,
+			.l = &pll_layout_frac,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_FRAC,
+			.f = CLK_SET_RATE_GATE,
+		},
+
+		[PLL_COMPID_DIV0] = {
+			.n = "ethpll_divpmcck",
+			.p = SAMA7G5_PLL_PARENT_FRACCK,
+			.l = &pll_layout_divpmc,
+			.c = &pll_characteristics,
+			.t = PLL_TYPE_DIV,
+			.f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			     CLK_SET_RATE_PARENT,
+		},
 	},
 };
 
+/* Used to create an array entry identifying a PLL by its components. */
+#define PLL_IDS_TO_ARR_ENTRY(_id, _comp) { PLL_ID_##_id, PLL_COMPID_##_comp}
+
 /*
  * Master clock (MCK[1..4]) description
  * @n:			clock name
- * @ep:			extra parents names array
  * @ep_chg_chg_id:	index in parents array that specifies the changeable
+ * @ep:			extra parents names array (entry formed by PLL components
+ *			identifiers (see enum pll_component_id))
+ * @hw:			pointer to clk_hw
  *			parent
  * @ep_count:		extra parents count
  * @ep_mux_table:	mux table for extra parents
@@ -305,9 +365,13 @@ static const struct {
  * @eid:		export index in sama7g5->chws[] array
  * @c:			true if clock is critical and cannot be disabled
  */
-static const struct {
+static struct {
 	const char *n;
-	const char *ep[4];
+	struct {
+		int pll_id;
+		int pll_compid;
+	} ep[4];
+	struct clk_hw *hw;
 	int ep_chg_id;
 	u8 ep_count;
 	u8 ep_mux_table[4];
@@ -315,9 +379,10 @@ static const struct {
 	u8 eid;
 	u8 c;
 } sama7g5_mckx[] = {
+	{ .n = "mck0", }, /* Dummy entry for MCK0 to store hw in probe. */
 	{ .n = "mck1",
 	  .id = 1,
-	  .ep = { "syspll_divpmcck", },
+	  .ep = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), },
 	  .ep_mux_table = { 5, },
 	  .ep_count = 1,
 	  .ep_chg_id = INT_MIN,
@@ -326,7 +391,7 @@ static const struct {
 
 	{ .n = "mck2",
 	  .id = 2,
-	  .ep = { "ddrpll_divpmcck", },
+	  .ep = { PLL_IDS_TO_ARR_ENTRY(DDR, DIV0), },
 	  .ep_mux_table = { 6, },
 	  .ep_count = 1,
 	  .ep_chg_id = INT_MIN,
@@ -334,14 +399,15 @@ static const struct {
 
 	{ .n = "mck3",
 	  .id = 3,
-	  .ep = { "syspll_divpmcck", "ddrpll_divpmcck", "imgpll_divpmcck", },
+	  .ep = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(DDR, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(IMG, DIV0), },
 	  .ep_mux_table = { 5, 6, 7, },
 	  .ep_count = 3,
 	  .ep_chg_id = 5, },
 
 	{ .n = "mck4",
 	  .id = 4,
-	  .ep = { "syspll_divpmcck", },
+	  .ep = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), },
 	  .ep_mux_table = { 5, },
 	  .ep_count = 1,
 	  .ep_chg_id = INT_MIN,
@@ -351,120 +417,137 @@ static const struct {
 /*
  * System clock description
  * @n:	clock name
- * @p:	clock parent name
  * @id: clock id
  */
 static const struct {
 	const char *n;
-	const char *p;
 	u8 id;
 } sama7g5_systemck[] = {
-	{ .n = "pck0",		.p = "prog0", .id = 8, },
-	{ .n = "pck1",		.p = "prog1", .id = 9, },
-	{ .n = "pck2",		.p = "prog2", .id = 10, },
-	{ .n = "pck3",		.p = "prog3", .id = 11, },
-	{ .n = "pck4",		.p = "prog4", .id = 12, },
-	{ .n = "pck5",		.p = "prog5", .id = 13, },
-	{ .n = "pck6",		.p = "prog6", .id = 14, },
-	{ .n = "pck7",		.p = "prog7", .id = 15, },
+	{ .n = "pck0", .id = 8, },
+	{ .n = "pck1", .id = 9, },
+	{ .n = "pck2", .id = 10, },
+	{ .n = "pck3", .id = 11, },
+	{ .n = "pck4", .id = 12, },
+	{ .n = "pck5", .id = 13, },
+	{ .n = "pck6", .id = 14, },
+	{ .n = "pck7", .id = 15, },
 };
 
 /* Mux table for programmable clocks. */
 static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 5, 6, 7, 8, 9, 10, };
 
+/*
+ * Peripheral clock parent hw identifier (used to index in sama7g5_mckx[])
+ * @PCK_PARENT_HW_MCK0: pck parent hw identifier is MCK0
+ * @PCK_PARENT_HW_MCK1: pck parent hw identifier is MCK1
+ * @PCK_PARENT_HW_MCK2: pck parent hw identifier is MCK2
+ * @PCK_PARENT_HW_MCK3: pck parent hw identifier is MCK3
+ * @PCK_PARENT_HW_MCK4: pck parent hw identifier is MCK4
+ * @PCK_PARENT_HW_MAX: max identifier
+ */
+enum sama7g5_pck_parent_hw_id {
+	PCK_PARENT_HW_MCK0,
+	PCK_PARENT_HW_MCK1,
+	PCK_PARENT_HW_MCK2,
+	PCK_PARENT_HW_MCK3,
+	PCK_PARENT_HW_MCK4,
+	PCK_PARENT_HW_MAX,
+};
+
 /*
  * Peripheral clock description
  * @n:		clock name
- * @p:		clock parent name
+ * @p:		clock parent hw id
  * @r:		clock range values
  * @id:		clock id
  * @chgp:	index in parent array of the changeable parent
  */
-static const struct {
+static struct {
 	const char *n;
-	const char *p;
+	enum sama7g5_pck_parent_hw_id p;
 	struct clk_range r;
 	u8 chgp;
 	u8 id;
 } sama7g5_periphck[] = {
-	{ .n = "pioA_clk",	.p = "mck0", .id = 11, },
-	{ .n = "securam_clk",	.p = "mck0", .id = 18, },
-	{ .n = "sfr_clk",	.p = "mck1", .id = 19, },
-	{ .n = "hsmc_clk",	.p = "mck1", .id = 21, },
-	{ .n = "xdmac0_clk",	.p = "mck1", .id = 22, },
-	{ .n = "xdmac1_clk",	.p = "mck1", .id = 23, },
-	{ .n = "xdmac2_clk",	.p = "mck1", .id = 24, },
-	{ .n = "acc_clk",	.p = "mck1", .id = 25, },
-	{ .n = "aes_clk",	.p = "mck1", .id = 27, },
-	{ .n = "tzaesbasc_clk",	.p = "mck1", .id = 28, },
-	{ .n = "asrc_clk",	.p = "mck1", .id = 30, .r = { .max = 200000000, }, },
-	{ .n = "cpkcc_clk",	.p = "mck0", .id = 32, },
-	{ .n = "csi_clk",	.p = "mck3", .id = 33, .r = { .max = 266000000, }, .chgp = 1, },
-	{ .n = "csi2dc_clk",	.p = "mck3", .id = 34, .r = { .max = 266000000, }, .chgp = 1, },
-	{ .n = "eic_clk",	.p = "mck1", .id = 37, },
-	{ .n = "flex0_clk",	.p = "mck1", .id = 38, },
-	{ .n = "flex1_clk",	.p = "mck1", .id = 39, },
-	{ .n = "flex2_clk",	.p = "mck1", .id = 40, },
-	{ .n = "flex3_clk",	.p = "mck1", .id = 41, },
-	{ .n = "flex4_clk",	.p = "mck1", .id = 42, },
-	{ .n = "flex5_clk",	.p = "mck1", .id = 43, },
-	{ .n = "flex6_clk",	.p = "mck1", .id = 44, },
-	{ .n = "flex7_clk",	.p = "mck1", .id = 45, },
-	{ .n = "flex8_clk",	.p = "mck1", .id = 46, },
-	{ .n = "flex9_clk",	.p = "mck1", .id = 47, },
-	{ .n = "flex10_clk",	.p = "mck1", .id = 48, },
-	{ .n = "flex11_clk",	.p = "mck1", .id = 49, },
-	{ .n = "gmac0_clk",	.p = "mck1", .id = 51, },
-	{ .n = "gmac1_clk",	.p = "mck1", .id = 52, },
-	{ .n = "icm_clk",	.p = "mck1", .id = 55, },
-	{ .n = "isc_clk",	.p = "mck3", .id = 56, .r = { .max = 266000000, }, .chgp = 1, },
-	{ .n = "i2smcc0_clk",	.p = "mck1", .id = 57, .r = { .max = 200000000, }, },
-	{ .n = "i2smcc1_clk",	.p = "mck1", .id = 58, .r = { .max = 200000000, }, },
-	{ .n = "matrix_clk",	.p = "mck1", .id = 60, },
-	{ .n = "mcan0_clk",	.p = "mck1", .id = 61, .r = { .max = 200000000, }, },
-	{ .n = "mcan1_clk",	.p = "mck1", .id = 62, .r = { .max = 200000000, }, },
-	{ .n = "mcan2_clk",	.p = "mck1", .id = 63, .r = { .max = 200000000, }, },
-	{ .n = "mcan3_clk",	.p = "mck1", .id = 64, .r = { .max = 200000000, }, },
-	{ .n = "mcan4_clk",	.p = "mck1", .id = 65, .r = { .max = 200000000, }, },
-	{ .n = "mcan5_clk",	.p = "mck1", .id = 66, .r = { .max = 200000000, }, },
-	{ .n = "pdmc0_clk",	.p = "mck1", .id = 68, .r = { .max = 200000000, }, },
-	{ .n = "pdmc1_clk",	.p = "mck1", .id = 69, .r = { .max = 200000000, }, },
-	{ .n = "pit64b0_clk",	.p = "mck1", .id = 70, },
-	{ .n = "pit64b1_clk",	.p = "mck1", .id = 71, },
-	{ .n = "pit64b2_clk",	.p = "mck1", .id = 72, },
-	{ .n = "pit64b3_clk",	.p = "mck1", .id = 73, },
-	{ .n = "pit64b4_clk",	.p = "mck1", .id = 74, },
-	{ .n = "pit64b5_clk",	.p = "mck1", .id = 75, },
-	{ .n = "pwm_clk",	.p = "mck1", .id = 77, },
-	{ .n = "qspi0_clk",	.p = "mck1", .id = 78, },
-	{ .n = "qspi1_clk",	.p = "mck1", .id = 79, },
-	{ .n = "sdmmc0_clk",	.p = "mck1", .id = 80, },
-	{ .n = "sdmmc1_clk",	.p = "mck1", .id = 81, },
-	{ .n = "sdmmc2_clk",	.p = "mck1", .id = 82, },
-	{ .n = "sha_clk",	.p = "mck1", .id = 83, },
-	{ .n = "spdifrx_clk",	.p = "mck1", .id = 84, .r = { .max = 200000000, }, },
-	{ .n = "spdiftx_clk",	.p = "mck1", .id = 85, .r = { .max = 200000000, }, },
-	{ .n = "ssc0_clk",	.p = "mck1", .id = 86, .r = { .max = 200000000, }, },
-	{ .n = "ssc1_clk",	.p = "mck1", .id = 87, .r = { .max = 200000000, }, },
-	{ .n = "tcb0_ch0_clk",	.p = "mck1", .id = 88, .r = { .max = 200000000, }, },
-	{ .n = "tcb0_ch1_clk",	.p = "mck1", .id = 89, .r = { .max = 200000000, }, },
-	{ .n = "tcb0_ch2_clk",	.p = "mck1", .id = 90, .r = { .max = 200000000, }, },
-	{ .n = "tcb1_ch0_clk",	.p = "mck1", .id = 91, .r = { .max = 200000000, }, },
-	{ .n = "tcb1_ch1_clk",	.p = "mck1", .id = 92, .r = { .max = 200000000, }, },
-	{ .n = "tcb1_ch2_clk",	.p = "mck1", .id = 93, .r = { .max = 200000000, }, },
-	{ .n = "tcpca_clk",	.p = "mck1", .id = 94, },
-	{ .n = "tcpcb_clk",	.p = "mck1", .id = 95, },
-	{ .n = "tdes_clk",	.p = "mck1", .id = 96, },
-	{ .n = "trng_clk",	.p = "mck1", .id = 97, },
-	{ .n = "udphsa_clk",	.p = "mck1", .id = 104, },
-	{ .n = "udphsb_clk",	.p = "mck1", .id = 105, },
-	{ .n = "uhphs_clk",	.p = "mck1", .id = 106, },
+	{ .n = "pioA_clk",	.p = PCK_PARENT_HW_MCK0, .id = 11, },
+	{ .n = "securam_clk",	.p = PCK_PARENT_HW_MCK0, .id = 18, },
+	{ .n = "sfr_clk",	.p = PCK_PARENT_HW_MCK1, .id = 19, },
+	{ .n = "hsmc_clk",	.p = PCK_PARENT_HW_MCK1, .id = 21, },
+	{ .n = "xdmac0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 22, },
+	{ .n = "xdmac1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 23, },
+	{ .n = "xdmac2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 24, },
+	{ .n = "acc_clk",	.p = PCK_PARENT_HW_MCK1, .id = 25, },
+	{ .n = "aes_clk",	.p = PCK_PARENT_HW_MCK1, .id = 27, },
+	{ .n = "tzaesbasc_clk",	.p = PCK_PARENT_HW_MCK1, .id = 28, },
+	{ .n = "asrc_clk",	.p = PCK_PARENT_HW_MCK1, .id = 30, .r = { .max = 200000000, }, },
+	{ .n = "cpkcc_clk",	.p = PCK_PARENT_HW_MCK0, .id = 32, },
+	{ .n = "csi_clk",	.p = PCK_PARENT_HW_MCK3, .id = 33, .r = { .max = 266000000, }, .chgp = 1, },
+	{ .n = "csi2dc_clk",	.p = PCK_PARENT_HW_MCK3, .id = 34, .r = { .max = 266000000, }, .chgp = 1, },
+	{ .n = "eic_clk",	.p = PCK_PARENT_HW_MCK1, .id = 37, },
+	{ .n = "flex0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 38, },
+	{ .n = "flex1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 39, },
+	{ .n = "flex2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 40, },
+	{ .n = "flex3_clk",	.p = PCK_PARENT_HW_MCK1, .id = 41, },
+	{ .n = "flex4_clk",	.p = PCK_PARENT_HW_MCK1, .id = 42, },
+	{ .n = "flex5_clk",	.p = PCK_PARENT_HW_MCK1, .id = 43, },
+	{ .n = "flex6_clk",	.p = PCK_PARENT_HW_MCK1, .id = 44, },
+	{ .n = "flex7_clk",	.p = PCK_PARENT_HW_MCK1, .id = 45, },
+	{ .n = "flex8_clk",	.p = PCK_PARENT_HW_MCK1, .id = 46, },
+	{ .n = "flex9_clk",	.p = PCK_PARENT_HW_MCK1, .id = 47, },
+	{ .n = "flex10_clk",	.p = PCK_PARENT_HW_MCK1, .id = 48, },
+	{ .n = "flex11_clk",	.p = PCK_PARENT_HW_MCK1, .id = 49, },
+	{ .n = "gmac0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 51, },
+	{ .n = "gmac1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 52, },
+	{ .n = "icm_clk",	.p = PCK_PARENT_HW_MCK1, .id = 55, },
+	{ .n = "isc_clk",	.p = PCK_PARENT_HW_MCK3, .id = 56, .r = { .max = 266000000, }, .chgp = 1, },
+	{ .n = "i2smcc0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 57, .r = { .max = 200000000, }, },
+	{ .n = "i2smcc1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 58, .r = { .max = 200000000, }, },
+	{ .n = "matrix_clk",	.p = PCK_PARENT_HW_MCK1, .id = 60, },
+	{ .n = "mcan0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 61, .r = { .max = 200000000, }, },
+	{ .n = "mcan1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 62, .r = { .max = 200000000, }, },
+	{ .n = "mcan2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 63, .r = { .max = 200000000, }, },
+	{ .n = "mcan3_clk",	.p = PCK_PARENT_HW_MCK1, .id = 64, .r = { .max = 200000000, }, },
+	{ .n = "mcan4_clk",	.p = PCK_PARENT_HW_MCK1, .id = 65, .r = { .max = 200000000, }, },
+	{ .n = "mcan5_clk",	.p = PCK_PARENT_HW_MCK1, .id = 66, .r = { .max = 200000000, }, },
+	{ .n = "pdmc0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 68, .r = { .max = 200000000, }, },
+	{ .n = "pdmc1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 69, .r = { .max = 200000000, }, },
+	{ .n = "pit64b0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 70, },
+	{ .n = "pit64b1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 71, },
+	{ .n = "pit64b2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 72, },
+	{ .n = "pit64b3_clk",	.p = PCK_PARENT_HW_MCK1, .id = 73, },
+	{ .n = "pit64b4_clk",	.p = PCK_PARENT_HW_MCK1, .id = 74, },
+	{ .n = "pit64b5_clk",	.p = PCK_PARENT_HW_MCK1, .id = 75, },
+	{ .n = "pwm_clk",	.p = PCK_PARENT_HW_MCK1, .id = 77, },
+	{ .n = "qspi0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 78, },
+	{ .n = "qspi1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 79, },
+	{ .n = "sdmmc0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 80, },
+	{ .n = "sdmmc1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 81, },
+	{ .n = "sdmmc2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 82, },
+	{ .n = "sha_clk",	.p = PCK_PARENT_HW_MCK1, .id = 83, },
+	{ .n = "spdifrx_clk",	.p = PCK_PARENT_HW_MCK1, .id = 84, .r = { .max = 200000000, }, },
+	{ .n = "spdiftx_clk",	.p = PCK_PARENT_HW_MCK1, .id = 85, .r = { .max = 200000000, }, },
+	{ .n = "ssc0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 86, .r = { .max = 200000000, }, },
+	{ .n = "ssc1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 87, .r = { .max = 200000000, }, },
+	{ .n = "tcb0_ch0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 88, .r = { .max = 200000000, }, },
+	{ .n = "tcb0_ch1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 89, .r = { .max = 200000000, }, },
+	{ .n = "tcb0_ch2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 90, .r = { .max = 200000000, }, },
+	{ .n = "tcb1_ch0_clk",	.p = PCK_PARENT_HW_MCK1, .id = 91, .r = { .max = 200000000, }, },
+	{ .n = "tcb1_ch1_clk",	.p = PCK_PARENT_HW_MCK1, .id = 92, .r = { .max = 200000000, }, },
+	{ .n = "tcb1_ch2_clk",	.p = PCK_PARENT_HW_MCK1, .id = 93, .r = { .max = 200000000, }, },
+	{ .n = "tcpca_clk",	.p = PCK_PARENT_HW_MCK1, .id = 94, },
+	{ .n = "tcpcb_clk",	.p = PCK_PARENT_HW_MCK1, .id = 95, },
+	{ .n = "tdes_clk",	.p = PCK_PARENT_HW_MCK1, .id = 96, },
+	{ .n = "trng_clk",	.p = PCK_PARENT_HW_MCK1, .id = 97, },
+	{ .n = "udphsa_clk",	.p = PCK_PARENT_HW_MCK1, .id = 104, },
+	{ .n = "udphsb_clk",	.p = PCK_PARENT_HW_MCK1, .id = 105, },
+	{ .n = "uhphs_clk",	.p = PCK_PARENT_HW_MCK1, .id = 106, },
 };
 
 /*
  * Generic clock description
  * @n:			clock name
- * @pp:			PLL parents
+ * @pp:			PLL parents (entry formed by PLL components identifiers
+ *			(see enum pll_component_id))
  * @pp_mux_table:	PLL parents mux table
  * @r:			clock output range
  * @pp_chg_id:		id in parent array of changeable PLL parent
@@ -473,7 +556,10 @@ static const struct {
  */
 static const struct {
 	const char *n;
-	const char *pp[8];
+	struct {
+		int pll_id;
+		int pll_compid;
+	} pp[8];
 	const char pp_mux_table[8];
 	struct clk_range r;
 	int pp_chg_id;
@@ -483,7 +569,8 @@ static const struct {
 	{ .n  = "adc_gclk",
 	  .id = 26,
 	  .r = { .max = 100000000, },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 7, 9, },
 	  .pp_count = 3,
 	  .pp_chg_id = INT_MIN, },
@@ -491,7 +578,7 @@ static const struct {
 	{ .n  = "asrc_gclk",
 	  .id = 30,
 	  .r = { .max = 200000000 },
-	  .pp = { "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 9, },
 	  .pp_count = 1,
 	  .pp_chg_id = 3, },
@@ -499,7 +586,7 @@ static const struct {
 	{ .n  = "csi_gclk",
 	  .id = 33,
 	  .r = { .max = 27000000  },
-	  .pp = { "ddrpll_divpmcck", "imgpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(DDR, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0), },
 	  .pp_mux_table = { 6, 7, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -507,7 +594,7 @@ static const struct {
 	{ .n  = "flex0_gclk",
 	  .id = 38,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -515,7 +602,7 @@ static const struct {
 	{ .n  = "flex1_gclk",
 	  .id = 39,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -523,7 +610,7 @@ static const struct {
 	{ .n  = "flex2_gclk",
 	  .id = 40,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -531,7 +618,7 @@ static const struct {
 	{ .n  = "flex3_gclk",
 	  .id = 41,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -539,7 +626,7 @@ static const struct {
 	{ .n  = "flex4_gclk",
 	  .id = 42,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -547,7 +634,7 @@ static const struct {
 	{ .n  = "flex5_gclk",
 	  .id = 43,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -555,7 +642,7 @@ static const struct {
 	{ .n  = "flex6_gclk",
 	  .id = 44,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -563,7 +650,7 @@ static const struct {
 	{ .n  = "flex7_gclk",
 	  .id = 45,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -571,7 +658,7 @@ static const struct {
 	{ .n  = "flex8_gclk",
 	  .id = 46,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -579,7 +666,7 @@ static const struct {
 	{ .n  = "flex9_gclk",
 	  .id = 47,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -587,7 +674,7 @@ static const struct {
 	{ .n  = "flex10_gclk",
 	  .id = 48,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -595,7 +682,7 @@ static const struct {
 	{ .n  = "flex11_gclk",
 	  .id = 49,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -603,7 +690,7 @@ static const struct {
 	{ .n  = "gmac0_gclk",
 	  .id = 51,
 	  .r = { .max = 125000000 },
-	  .pp = { "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 10, },
 	  .pp_count = 1,
 	  .pp_chg_id = 3, },
@@ -611,7 +698,7 @@ static const struct {
 	{ .n  = "gmac1_gclk",
 	  .id = 52,
 	  .r = { .max = 50000000  },
-	  .pp = { "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 10, },
 	  .pp_count = 1,
 	  .pp_chg_id = INT_MIN, },
@@ -619,7 +706,7 @@ static const struct {
 	{ .n  = "gmac0_tsu_gclk",
 	  .id = 53,
 	  .r = { .max = 300000000 },
-	  .pp = { "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 9, 10, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -627,7 +714,7 @@ static const struct {
 	{ .n  = "gmac1_tsu_gclk",
 	  .id = 54,
 	  .r = { .max = 300000000 },
-	  .pp = { "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 9, 10, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -635,7 +722,7 @@ static const struct {
 	{ .n  = "i2smcc0_gclk",
 	  .id = 57,
 	  .r = { .max = 100000000 },
-	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -643,7 +730,7 @@ static const struct {
 	{ .n  = "i2smcc1_gclk",
 	  .id = 58,
 	  .r = { .max = 100000000 },
-	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -651,7 +738,7 @@ static const struct {
 	{ .n  = "mcan0_gclk",
 	  .id = 61,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -659,7 +746,7 @@ static const struct {
 	{ .n  = "mcan1_gclk",
 	  .id = 62,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -667,7 +754,7 @@ static const struct {
 	{ .n  = "mcan2_gclk",
 	  .id = 63,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -675,7 +762,7 @@ static const struct {
 	{ .n  = "mcan3_gclk",
 	  .id = 64,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -683,7 +770,7 @@ static const struct {
 	{ .n  = "mcan4_gclk",
 	  .id = 65,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -691,7 +778,7 @@ static const struct {
 	{ .n  = "mcan5_gclk",
 	  .id = 66,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -699,7 +786,7 @@ static const struct {
 	{ .n  = "pdmc0_gclk",
 	  .id = 68,
 	  .r = { .max = 50000000  },
-	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -707,7 +794,7 @@ static const struct {
 	{ .n  = "pdmc1_gclk",
 	  .id = 69,
 	  .r = { .max = 50000000, },
-	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -715,8 +802,9 @@ static const struct {
 	{ .n  = "pit64b0_gclk",
 	  .id = 70,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -724,8 +812,9 @@ static const struct {
 	{ .n  = "pit64b1_gclk",
 	  .id = 71,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -733,8 +822,9 @@ static const struct {
 	{ .n  = "pit64b2_gclk",
 	  .id = 72,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -742,8 +832,9 @@ static const struct {
 	{ .n  = "pit64b3_gclk",
 	  .id = 73,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -751,8 +842,9 @@ static const struct {
 	{ .n  = "pit64b4_gclk",
 	  .id = 74,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -760,8 +852,9 @@ static const struct {
 	{ .n  = "pit64b5_gclk",
 	  .id = 75,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -769,7 +862,7 @@ static const struct {
 	{ .n  = "qspi0_gclk",
 	  .id = 78,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -777,7 +870,7 @@ static const struct {
 	{ .n  = "qspi1_gclk",
 	  .id = 79,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
@@ -785,7 +878,7 @@ static const struct {
 	{ .n  = "sdmmc0_gclk",
 	  .id = 80,
 	  .r = { .max = 208000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -793,7 +886,7 @@ static const struct {
 	{ .n  = "sdmmc1_gclk",
 	  .id = 81,
 	  .r = { .max = 208000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -801,7 +894,7 @@ static const struct {
 	{ .n  = "sdmmc2_gclk",
 	  .id = 82,
 	  .r = { .max = 208000000 },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -809,7 +902,7 @@ static const struct {
 	{ .n  = "spdifrx_gclk",
 	  .id = 84,
 	  .r = { .max = 150000000 },
-	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -817,7 +910,7 @@ static const struct {
 	{ .n = "spdiftx_gclk",
 	  .id = 85,
 	  .r = { .max = 25000000  },
-	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0), },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = 4, },
@@ -825,8 +918,9 @@ static const struct {
 	{ .n  = "tcb0_ch0_gclk",
 	  .id = 88,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -834,8 +928,9 @@ static const struct {
 	{ .n  = "tcb1_ch0_gclk",
 	  .id = 91,
 	  .r = { .max = 200000000 },
-	  .pp = { "syspll_divpmcck", "imgpll_divpmcck", "baudpll_divpmcck",
-		  "audiopll_divpmcck", "ethpll_divpmcck", },
+	  .pp = { PLL_IDS_TO_ARR_ENTRY(SYS, DIV0), PLL_IDS_TO_ARR_ENTRY(IMG, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(BAUD, DIV0), PLL_IDS_TO_ARR_ENTRY(AUDIO, DIV0),
+		  PLL_IDS_TO_ARR_ENTRY(ETH, DIV0), },
 	  .pp_mux_table = { 5, 7, 8, 9, 10, },
 	  .pp_count = 5,
 	  .pp_chg_id = INT_MIN, },
@@ -884,34 +979,25 @@ static const struct clk_pcr_layout sama7g5_pcr_layout = {
 
 static void __init sama7g5_pmc_setup(struct device_node *np)
 {
-	const char *td_slck_name, *md_slck_name, *mainxtal_name;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *sama7g5_pmc;
-	const char *parent_names[10];
 	void **alloc_mem = NULL;
 	int alloc_mem_size = 0;
 	struct regmap *regmap;
-	struct clk_hw *hw;
+	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
+	struct clk_hw *td_slck_hw, *md_slck_hw;
+	static struct clk_parent_data parent_data;
+	struct clk_hw *parent_hws[10];
 	bool bypass;
 	int i, j;
 
-	i = of_property_match_string(np, "clock-names", "td_slck");
-	if (i < 0)
-		return;
-
-	td_slck_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "md_slck");
-	if (i < 0)
-		return;
-
-	md_slck_name = of_clk_get_parent_name(np, i);
+	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
+	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
+	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
 
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
+	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
 		return;
 
-	mainxtal_name = of_clk_get_parent_name(np, i);
-
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
@@ -929,21 +1015,23 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	if (!alloc_mem)
 		goto err_free;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   50000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   50000000);
+	if (IS_ERR(main_rc_hw))
 		goto err_free;
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	parent_data.name = main_xtal_name;
+	parent_data.fw_name = main_xtal_name;
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+						 &parent_data, bypass);
+	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_names[0] = "main_rc_osc";
-	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
+	parent_hws[0] = main_rc_hw;
+	parent_hws[1] = main_osc_hw;
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -958,15 +1046,22 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 			switch (sama7g5_plls[i][j].t) {
 			case PLL_TYPE_FRAC:
-				if (!strcmp(sama7g5_plls[i][j].p, "mainck"))
+				switch (sama7g5_plls[i][j].p) {
+				case SAMA7G5_PLL_PARENT_MAINCK:
 					parent_hw = sama7g5_pmc->chws[PMC_MAIN];
-				else
-					parent_hw = __clk_get_hw(of_clk_get_by_name(np,
-						sama7g5_plls[i][j].p));
+					break;
+				case SAMA7G5_PLL_PARENT_MAIN_XTAL:
+					parent_hw = main_xtal_hw;
+					break;
+				default:
+					/* Should not happen. */
+					parent_hw = NULL;
+					break;
+				}
 
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					sama7g5_plls[i][j].p, parent_hw, i,
+					NULL, parent_hw, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f);
@@ -975,7 +1070,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			case PLL_TYPE_DIV:
 				hw = sam9x60_clk_register_div_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					sama7g5_plls[i][j].p, NULL, i,
+					NULL, sama7g5_plls[i][0].hw, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f,
@@ -989,25 +1084,27 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			if (IS_ERR(hw))
 				goto err_free;
 
+			sama7g5_plls[i][j].hw = hw;
 			if (sama7g5_plls[i][j].eid)
 				sama7g5_pmc->chws[sama7g5_plls[i][j].eid] = hw;
 		}
 	}
 
-	parent_names[0] = "cpupll_divpmcck";
-	hw = at91_clk_register_master_div(regmap, "mck0", "cpupll_divpmcck", NULL,
+	hw = at91_clk_register_master_div(regmap, "mck0", NULL,
+					  sama7g5_plls[PLL_ID_CPU][1].hw,
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	sama7g5_pmc->chws[PMC_MCK] = hw;
+	sama7g5_mckx[PCK_PARENT_HW_MCK0].hw = sama7g5_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = md_slck_name;
-	parent_names[1] = td_slck_name;
-	parent_names[2] = "mainck";
-	for (i = 0; i < ARRAY_SIZE(sama7g5_mckx); i++) {
+	parent_hws[0] = md_slck_hw;
+	parent_hws[1] = td_slck_hw;
+	parent_hws[2] = sama7g5_pmc->chws[PMC_MAIN];
+	for (i = PCK_PARENT_HW_MCK1; i < ARRAY_SIZE(sama7g5_mckx); i++) {
 		u8 num_parents = 3 + sama7g5_mckx[i].ep_count;
+		struct clk_hw *tmp_parent_hws[8];
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -1018,11 +1115,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		SAMA7G5_INIT_TABLE(mux_table, 3);
 		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
 				   sama7g5_mckx[i].ep_count);
-		SAMA7G5_FILL_TABLE(&parent_names[3], sama7g5_mckx[i].ep,
+		for (j = 0; j < sama7g5_mckx[i].ep_count; j++) {
+			u8 pll_id = sama7g5_mckx[i].ep[j].pll_id;
+			u8 pll_compid = sama7g5_mckx[i].ep[j].pll_compid;
+
+			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
+		}
+		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
 				   sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
-				   num_parents, parent_names, NULL, mux_table,
+				   num_parents, NULL, parent_hws, mux_table,
 				   &pmc_mckX_lock, sama7g5_mckx[i].id,
 				   sama7g5_mckx[i].c,
 				   sama7g5_mckx[i].ep_chg_id);
@@ -1031,32 +1134,33 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 		alloc_mem[alloc_mem_size++] = mux_table;
 
+		sama7g5_mckx[i].hw = hw;
 		if (sama7g5_mckx[i].eid)
 			sama7g5_pmc->chws[sama7g5_mckx[i].eid] = hw;
 	}
 
-	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", "main_xtal", NULL);
+	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", NULL, main_xtal_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama7g5_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = md_slck_name;
-	parent_names[1] = td_slck_name;
-	parent_names[2] = "mainck";
-	parent_names[3] = "syspll_divpmcck";
-	parent_names[4] = "ddrpll_divpmcck";
-	parent_names[5] = "imgpll_divpmcck";
-	parent_names[6] = "baudpll_divpmcck";
-	parent_names[7] = "audiopll_divpmcck";
-	parent_names[8] = "ethpll_divpmcck";
+	parent_hws[0] = md_slck_hw;
+	parent_hws[1] = td_slck_hw;
+	parent_hws[2] = sama7g5_pmc->chws[PMC_MAIN];
+	parent_hws[3] = sama7g5_plls[PLL_ID_SYS][PLL_COMPID_DIV0].hw;
+	parent_hws[4] = sama7g5_plls[PLL_ID_DDR][PLL_COMPID_DIV0].hw;
+	parent_hws[5] = sama7g5_plls[PLL_ID_IMG][PLL_COMPID_DIV0].hw;
+	parent_hws[6] = sama7g5_plls[PLL_ID_BAUD][PLL_COMPID_DIV0].hw;
+	parent_hws[7] = sama7g5_plls[PLL_ID_AUDIO][PLL_COMPID_DIV0].hw;
+	parent_hws[8] = sama7g5_plls[PLL_ID_ETH][PLL_COMPID_DIV0].hw;
 	for (i = 0; i < 8; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
-		hw = at91_clk_register_programmable(regmap, name, parent_names,
-						    NULL, 9, i,
+		hw = at91_clk_register_programmable(regmap, name, NULL, parent_hws,
+						    9, i,
 						    &programmable_layout,
 						    sama7g5_prog_mux_table);
 		if (IS_ERR(hw))
@@ -1067,7 +1171,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama7g5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama7g5_systemck[i].n,
-					      sama7g5_systemck[i].p, NULL,
+					      NULL, sama7g5_pmc->pchws[i],
 					      sama7g5_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -1079,7 +1183,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 						&sama7g5_pcr_layout,
 						sama7g5_periphck[i].n,
-						sama7g5_periphck[i].p, NULL,
+						NULL,
+						sama7g5_mckx[sama7g5_periphck[i].p].hw,
 						sama7g5_periphck[i].id,
 						&sama7g5_periphck[i].r,
 						sama7g5_periphck[i].chgp ? 0 :
@@ -1090,11 +1195,12 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		sama7g5_pmc->phws[sama7g5_periphck[i].id] = hw;
 	}
 
-	parent_names[0] = md_slck_name;
-	parent_names[1] = td_slck_name;
-	parent_names[2] = "mainck";
+	parent_hws[0] = md_slck_hw;
+	parent_hws[1] = td_slck_hw;
+	parent_hws[2] = sama7g5_pmc->chws[PMC_MAIN];
 	for (i = 0; i < ARRAY_SIZE(sama7g5_gck); i++) {
 		u8 num_parents = 3 + sama7g5_gck[i].pp_count;
+		struct clk_hw *tmp_parent_hws[8];
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -1105,13 +1211,19 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		SAMA7G5_INIT_TABLE(mux_table, 3);
 		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
 				   sama7g5_gck[i].pp_count);
-		SAMA7G5_FILL_TABLE(&parent_names[3], sama7g5_gck[i].pp,
+		for (j = 0; j < sama7g5_gck[i].pp_count; j++) {
+			u8 pll_id = sama7g5_gck[i].pp[j].pll_id;
+			u8 pll_compid = sama7g5_gck[i].pp[j].pll_compid;
+
+			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
+		}
+		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
 				   sama7g5_gck[i].pp_count);
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama7g5_pcr_layout,
-						 sama7g5_gck[i].n,
-						 parent_names, NULL, mux_table,
+						 sama7g5_gck[i].n, NULL,
+						 parent_hws, mux_table,
 						 num_parents,
 						 sama7g5_gck[i].id,
 						 &sama7g5_gck[i].r,
-- 
2.34.1

