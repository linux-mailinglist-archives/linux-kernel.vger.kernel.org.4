Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2B73140C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbjFOJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbjFOJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:34:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BDA2728;
        Thu, 15 Jun 2023 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821643; x=1718357643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rtSGHQH+TiGeHwbsMLir4gXm6vMflKlMIN8yJet5ZzI=;
  b=MYkSc85jJtawlanBjQ+UDLVNYflkyAX9h2rta0dEfRe8yyzR+2ddDXGc
   qLUMqHiN636HZW5mT7uFVOAs1JgYa3dxRooJaN1RKwSRRT6ocCBzKYzq5
   fNpyoujOx3l41Kzuvm4rOYP2kzskwJi8iZqQXlipOsMoUO/ikXjgWpUzR
   4Mzf8HTQQownWWoMgihJ/DkkZW4AT11ibXFjJPsFEhLo+f8ANeitUFQzy
   2zy82IoNjCviIo5SU+9zuAFXS5si8ld1cJyXewTTUITypYsrF03Tzdzdk
   iQq2Njl3vUSzTrsntJjJHX/t/0MDqsZMD+PinFRIJaHwFN1ATdqF+flMc
   A==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="230266374"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:02 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:33:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 03/11] clk: at91: clk-master: add support for parent_hw
Date:   Thu, 15 Jun 2023 12:32:19 +0300
Message-ID: <20230615093227.576102-4-claudiu.beznea@microchip.com>
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

Add support for parent_hw in master clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-master were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  |  4 ++--
 drivers/clk/at91/at91sam9260.c |  4 ++--
 drivers/clk/at91/at91sam9g45.c |  4 ++--
 drivers/clk/at91/at91sam9n12.c |  4 ++--
 drivers/clk/at91/at91sam9rl.c  |  4 ++--
 drivers/clk/at91/at91sam9x5.c  |  4 ++--
 drivers/clk/at91/clk-master.c  | 28 +++++++++++++++++++---------
 drivers/clk/at91/dt-compat.c   |  4 ++--
 drivers/clk/at91/pmc.h         |  6 ++++--
 drivers/clk/at91/sam9x60.c     |  4 ++--
 drivers/clk/at91/sama5d2.c     |  4 ++--
 drivers/clk/at91/sama5d3.c     |  4 ++--
 drivers/clk/at91/sama5d4.c     |  4 ++--
 drivers/clk/at91/sama7g5.c     |  4 ++--
 14 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 83917a2c31bd..259e314ef40f 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -140,7 +140,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	parent_names[2] = "pllack";
 	parent_names[3] = "pllbck";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91rm9200_master_layout,
 					   &rm9200_mck_characteristics,
 					   &rm9200_mck_lock);
@@ -148,7 +148,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91rm9200_master_layout,
 					  &rm9200_mck_characteristics,
 					  &rm9200_mck_lock, CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index e9b56826a9be..f9bf65c77c9b 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -416,7 +416,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	parent_names[2] = "pllack";
 	parent_names[3] = "pllbck";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91rm9200_master_layout,
 					   data->mck_characteristics,
 					   &at91sam9260_mck_lock);
@@ -424,7 +424,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91rm9200_master_layout,
 					  data->mck_characteristics,
 					  &at91sam9260_mck_lock,
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index e25fb1bcafc7..c9313a7b32ea 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -156,7 +156,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91rm9200_master_layout,
 					   &mck_characteristics,
 					   &at91sam9g45_mck_lock);
@@ -164,7 +164,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91rm9200_master_layout,
 					  &mck_characteristics,
 					  &at91sam9g45_mck_lock,
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 35f137fb89e9..608410bef120 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -183,7 +183,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	parent_names[2] = "plladivck";
 	parent_names[3] = "pllbck";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics,
 					   &at91sam9n12_mck_lock);
@@ -191,7 +191,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics,
 					  &at91sam9n12_mck_lock,
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index d3186dd34c26..90911cbd9690 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -120,7 +120,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	parent_names[2] = "pllack";
 	parent_names[3] = "utmick";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91rm9200_master_layout,
 					   &sam9rl_mck_characteristics,
 					   &sam9rl_mck_lock);
@@ -128,7 +128,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91rm9200_master_layout,
 					  &sam9rl_mck_characteristics,
 					  &sam9rl_mck_lock, CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 57f41aab94b2..63097cdd4809 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -204,14 +204,14 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index b7cd1924de52..15c46489ba85 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -473,18 +473,19 @@ static struct clk_hw * __init
 at91_clk_register_master_internal(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
+		struct clk_hw **parent_hws,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		const struct clk_ops *ops, spinlock_t *lock, u32 flags)
 {
 	struct clk_master *master;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
 	unsigned int mckr;
 	unsigned long irqflags;
 	int ret;
 
-	if (!name || !num_parents || !parent_names || !lock)
+	if (!name || !num_parents || !(parent_names || parent_hws) || !lock)
 		return ERR_PTR(-EINVAL);
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -493,7 +494,10 @@ at91_clk_register_master_internal(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = flags;
 
@@ -527,12 +531,13 @@ struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
+		struct clk_hw **parent_hws,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		spinlock_t *lock)
 {
 	return at91_clk_register_master_internal(regmap, name, num_parents,
-						 parent_names, layout,
+						 parent_names, parent_hws, layout,
 						 characteristics,
 						 &master_pres_ops,
 						 lock, CLK_SET_RATE_GATE);
@@ -541,7 +546,7 @@ at91_clk_register_master_pres(struct regmap *regmap,
 struct clk_hw * __init
 at91_clk_register_master_div(struct regmap *regmap,
 		const char *name, const char *parent_name,
-		const struct clk_master_layout *layout,
+		struct clk_hw *parent_hw, const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		spinlock_t *lock, u32 flags, u32 safe_div)
 {
@@ -554,7 +559,8 @@ at91_clk_register_master_div(struct regmap *regmap,
 		ops = &master_div_ops_chg;
 
 	hw = at91_clk_register_master_internal(regmap, name, 1,
-					       &parent_name, layout,
+					       parent_name ? &parent_name : NULL,
+					       parent_hw ? &parent_hw : NULL, layout,
 					       characteristics, ops,
 					       lock, flags);
 
@@ -806,18 +812,19 @@ struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
 				 const char *name, int num_parents,
 				 const char **parent_names,
+				 struct clk_hw **parent_hws,
 				 u32 *mux_table,
 				 spinlock_t *lock, u8 id,
 				 bool critical, int chg_pid)
 {
 	struct clk_master *master;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	unsigned long flags;
 	unsigned int val;
 	int ret;
 
-	if (!name || !num_parents || !parent_names || !mux_table ||
+	if (!name || !num_parents || !(parent_names || parent_hws) || !mux_table ||
 	    !lock || id > MASTER_MAX_ID)
 		return ERR_PTR(-EINVAL);
 
@@ -827,7 +834,10 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sama7g5_master_ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	if (chg_pid >= 0)
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index e5a56aaff96d..4a024bb97312 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -420,12 +420,12 @@ of_at91_clk_master_setup(struct device_node *np,
 		return;
 
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", num_parents,
-					   parent_names, layout,
+					   parent_names, NULL, layout,
 					   characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
-	hw = at91_clk_register_master_div(regmap, name, "masterck_pres",
+	hw = at91_clk_register_master_div(regmap, name, "masterck_pres", NULL,
 					  layout, characteristics,
 					  &mck_lock, CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index e947c78a82d0..c09abb8ff8fe 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -177,13 +177,14 @@ at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap, const char *name,
 			      int num_parents, const char **parent_names,
+			      struct clk_hw **parent_hws,
 			      const struct clk_master_layout *layout,
 			      const struct clk_master_characteristics *characteristics,
 			      spinlock_t *lock);
 
 struct clk_hw * __init
 at91_clk_register_master_div(struct regmap *regmap, const char *name,
-			     const char *parent_names,
+			     const char *parent_names, struct clk_hw *parent_hw,
 			     const struct clk_master_layout *layout,
 			     const struct clk_master_characteristics *characteristics,
 			     spinlock_t *lock, u32 flags, u32 safe_div);
@@ -191,7 +192,8 @@ at91_clk_register_master_div(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
 				 const char *name, int num_parents,
-				 const char **parent_names, u32 *mux_table,
+				 const char **parent_names,
+				 struct clk_hw **parent_hws, u32 *mux_table,
 				 spinlock_t *lock, u8 id, bool critical,
 				 int chg_pid);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index dcc8f8142180..3ff1eb3bee81 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -280,13 +280,13 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_names[1] = "mainck";
 	parent_names[2] = "pllack_divck";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 3,
-					   parent_names, &sam9x60_master_layout,
+					   parent_names, NULL, &sam9x60_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", &sam9x60_master_layout,
+					  "masterck_pres", NULL, &sam9x60_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 18695c9c9beb..c47d43a7e95b 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -260,14 +260,14 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 88de1cccbb46..d605a540b30f 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -183,14 +183,14 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 4e6e276bbc4c..21a61840d5f3 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -198,14 +198,14 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names,
+					   parent_names, NULL,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres",
+					  "masterck_pres", NULL,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index e754c127b2b8..989d66f5370e 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -995,7 +995,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	}
 
 	parent_names[0] = "cpupll_divpmcck";
-	hw = at91_clk_register_master_div(regmap, "mck0", "cpupll_divpmcck",
+	hw = at91_clk_register_master_div(regmap, "mck0", "cpupll_divpmcck", NULL,
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
@@ -1022,7 +1022,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 				   sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
-				   num_parents, parent_names, mux_table,
+				   num_parents, parent_names, NULL, mux_table,
 				   &pmc_mckX_lock, sama7g5_mckx[i].id,
 				   sama7g5_mckx[i].c,
 				   sama7g5_mckx[i].ep_chg_id);
-- 
2.34.1

