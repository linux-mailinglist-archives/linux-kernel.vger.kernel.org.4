Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1F731414
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbjFOJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbjFOJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:35:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E8272A;
        Thu, 15 Jun 2023 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821669; x=1718357669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7aJEM9mHWOSMr0Y5kPc7DQIyFWDtyhtlHJQcuo9H1Zw=;
  b=GhzbNYlRSeoAFKlUi4diZTRns5MhCx4EB2JhliLeSMsPJp+4kSSp7xu1
   0SfTmcxHU7pUcPVu3zF2YMPyyj7pl1vrSRtYKBrvjtU7zDgEudPzgjgv0
   E7B60mDcAHRo3gj4MhGUtQ5wc3i8paqHm78qMrS/AA2y/WJQBtwDWkqoF
   kQ5Ivkv+Env7LrpYkXT8Hb1YZ3guk0okVBB+kRx4+wM6lEBCYgY7r8EPI
   EcnI8996FuMQHSwZnnEKcnD3u6PDXnKGPWjtmdX4tqAn5HvedWxc7d3XQ
   sUWQnOrWfHCTHPpt06OkeNK0VyxuK/QL6yZd+kAhKDG4PShFAsrAnhT5x
   A==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="230266472"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:25 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 08/11] clk: at91: clk-sam9x60-pll: add support for parent_hw
Date:   Thu, 15 Jun 2023 12:32:24 +0300
Message-ID: <20230615093227.576102-9-claudiu.beznea@microchip.com>
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

Add support for parent_hw in SAM9X60 PLL clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-sam9x60-pll were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 17 ++++++++++++-----
 drivers/clk/at91/pmc.h             |  3 ++-
 drivers/clk/at91/sam9x60.c         |  4 ++--
 drivers/clk/at91/sama7g5.c         |  2 +-
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index d757003004cb..7143a160cdcc 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -616,7 +616,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 {
 	struct sam9x60_frac *frac;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	unsigned long parent_rate, irqflags;
 	unsigned int val;
 	int ret;
@@ -629,7 +629,10 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.parent_names = &parent_name;
+	if (parent_name)
+		init.parent_names = &parent_name;
+	else
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_frac_pll_ops;
@@ -692,14 +695,15 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
-			     const char *name, const char *parent_name, u8 id,
+			     const char *name, const char *parent_name,
+			     struct clk_hw *parent_hw, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
 			     const struct clk_pll_layout *layout, u32 flags,
 			     u32 safe_div)
 {
 	struct sam9x60_div *div;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	unsigned long irqflags;
 	unsigned int val;
 	int ret;
@@ -716,7 +720,10 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_div_pll_ops;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 8e32be004843..0f52e80bcd49 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -220,7 +220,8 @@ at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
-			     const char *name, const char *parent_name, u8 id,
+			     const char *name, const char *parent_name,
+			     struct clk_hw *parent_hw, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
 			     const struct clk_pll_layout *layout, u32 flags,
 			     u32 safe_div);
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 505827013b46..e309cbf3cb9a 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -246,7 +246,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "pllack_divck",
-					  "pllack_fracck", 0, &plla_characteristics,
+					  "pllack_fracck", NULL, 0, &plla_characteristics,
 					  &pll_div_layout,
 					   /*
 					    * This feeds CPU. It should not
@@ -266,7 +266,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "upllck_divck",
-					  "upllck_fracck", 1, &upll_characteristics,
+					  "upllck_fracck", NULL, 1, &upll_characteristics,
 					  &pll_div_layout,
 					  CLK_SET_RATE_GATE |
 					  CLK_SET_PARENT_GATE |
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 42f2f61cc6d1..3297e028c2c5 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -975,7 +975,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			case PLL_TYPE_DIV:
 				hw = sam9x60_clk_register_div_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					sama7g5_plls[i][j].p, i,
+					sama7g5_plls[i][j].p, NULL, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f,
-- 
2.34.1

