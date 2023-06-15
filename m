Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B273141A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbjFOJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbjFOJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:35:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B92D295B;
        Thu, 15 Jun 2023 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821679; x=1718357679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLNRzz+RVfaPfA3VTibLI4v2I7mcxMycYFslneaYUi8=;
  b=Lky7gDzN/s7fjTtonydE8Mb6TXectvjoQUeKbgdjHGoy6o1y+IVXaFWN
   W0hH/DPlqJ3savLwbNiflTyzhv9cnxjssNLmsJgYcawHhIArSjlknIHGq
   AJkXCiQO4JmXEqOPQe5drCJCQm62xQP4UakZtjh9MKpev7roxH7lIFWPn
   +FsCDaBJWUBTMbZv2YP3RRiMRllfyXMr3JPJIg7j900yDO06oPwoWqp+m
   0nvq7Qzzds0u9RdtZtkQOwfm8y6cJxQjzRRPgDJhfClP5V/rkTUpVED0u
   Xxf4aBPQZtfnsko8Mi8X+5si48VZlKUmidXYYzd7cb3A54TcmTFEhWdaQ
   A==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="216166847"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 06/11] clk: at91: clk-system: add support for parent_hw
Date:   Thu, 15 Jun 2023 12:32:22 +0300
Message-ID: <20230615093227.576102-7-claudiu.beznea@microchip.com>
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

Add support for parent_hw in system clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-system were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  |  2 +-
 drivers/clk/at91/at91sam9260.c |  2 +-
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9n12.c |  2 +-
 drivers/clk/at91/at91sam9rl.c  |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  4 ++--
 drivers/clk/at91/clk-system.c  | 12 ++++++++----
 drivers/clk/at91/dt-compat.c   |  4 ++--
 drivers/clk/at91/pmc.h         |  3 ++-
 drivers/clk/at91/sam9x60.c     |  2 +-
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 drivers/clk/at91/sama7g5.c     |  2 +-
 14 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 2dd69628b7ba..3f19e737ae4d 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -182,7 +182,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n,
-					      at91rm9200_systemck[i].p,
+					      at91rm9200_systemck[i].p, NULL,
 					      at91rm9200_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 7d292d0c2bfc..0799a13060ea 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -459,7 +459,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	for (i = 0; i < data->num_sck; i++) {
 		hw = at91_clk_register_system(regmap, data->sck[i].n,
-					      data->sck[i].p,
+					      data->sck[i].p, NULL,
 					      data->sck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index b49415952510..ec2f26c3a80a 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -202,7 +202,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9g45_systemck[i].n,
-					      at91sam9g45_systemck[i].p,
+					      at91sam9g45_systemck[i].p, NULL,
 					      at91sam9g45_systemck[i].id,
 					      at91sam9g45_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 63151cd0d3b2..751786184ae2 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -227,7 +227,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9n12_systemck[i].n,
-					      at91sam9n12_systemck[i].p,
+					      at91sam9n12_systemck[i].p, NULL,
 					      at91sam9n12_systemck[i].id,
 					      at91sam9n12_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 858987757b87..051b2eeb9276 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -159,7 +159,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n,
-					      at91sam9rl_systemck[i].p,
+					      at91sam9rl_systemck[i].p, NULL,
 					      at91sam9rl_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 6a971b34f7dd..e1be2c4c54be 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -252,7 +252,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9x5_systemck[i].n,
-					      at91sam9x5_systemck[i].p,
+					      at91sam9x5_systemck[i].p, NULL,
 					      at91sam9x5_systemck[i].id,
 					      at91sam9x5_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -263,7 +263,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	if (has_lcdck) {
 		hw = at91_clk_register_system(regmap, "lcdck", "masterck_div",
-					      3, 0);
+					      NULL, 3, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 10193650429e..90eed39d0785 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -105,14 +105,15 @@ static const struct clk_ops system_ops = {
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, u8 id, unsigned long flags)
+			 const char *parent_name, struct clk_hw *parent_hw, u8 id,
+			 unsigned long flags)
 {
 	struct clk_system *sys;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
-	if (!parent_name || id > SYSTEM_MAX_ID)
+	if (!(parent_name || parent_hw) || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
 
 	sys = kzalloc(sizeof(*sys), GFP_KERNEL);
@@ -121,7 +122,10 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &system_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_PARENT | flags;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 96ce2287e13a..e5fcf2e0d235 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -908,8 +908,8 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 		if (!strcmp(sysclknp->name, "ddrck"))
 			flags = CLK_IS_CRITICAL;
 
-		hw = at91_clk_register_system(regmap, name, parent_name, id,
-					      flags);
+		hw = at91_clk_register_system(regmap, name, parent_name, NULL,
+					      id, flags);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 658bbf574af9..101e005a9550 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -251,7 +251,8 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, u8 id, unsigned long flags);
+			 const char *parent_name, struct clk_hw *parent_hw,
+			 u8 id, unsigned long flags);
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 369123dc009c..505827013b46 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -324,7 +324,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sam9x60_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sam9x60_systemck[i].n,
-					      sam9x60_systemck[i].p,
+					      sam9x60_systemck[i].p, NULL,
 					      sam9x60_systemck[i].id,
 					      sam9x60_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 8eda5f95d142..c5df06190e1c 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -311,7 +311,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d2_systemck[i].n,
-					      sama5d2_systemck[i].p,
+					      sama5d2_systemck[i].p, NULL,
 					      sama5d2_systemck[i].id,
 					      sama5d2_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 68a540cf8eda..15fa180a3f58 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -231,7 +231,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d3_systemck[i].n,
-					      sama5d3_systemck[i].p,
+					      sama5d3_systemck[i].p, NULL,
 					      sama5d3_systemck[i].id,
 					      sama5d3_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 9145fa184388..2440a34d1d67 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -254,7 +254,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d4_systemck[i].n,
-					      sama5d4_systemck[i].p,
+					      sama5d4_systemck[i].p, NULL,
 					      sama5d4_systemck[i].id,
 					      sama5d4_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 22942af8dce4..b606d642a22b 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1067,7 +1067,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama7g5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama7g5_systemck[i].n,
-					      sama7g5_systemck[i].p,
+					      sama7g5_systemck[i].p, NULL,
 					      sama7g5_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.34.1

