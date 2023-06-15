Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A61731409
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbjFOJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245577AbjFOJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:33:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635F26AA;
        Thu, 15 Jun 2023 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821635; x=1718357635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DP5OdKqj1D84yqaG/GeThc9/POEoEnWjBojZ5uISPW8=;
  b=UEGJWBR69qEWBhSztw8QvDWu5TYv2pByrFAG/pp6sPZKQlS0AW88Trgj
   HuYaOj4OnIyUZT7fA5LqL2KpU1XLpMEr5fWq6Z7MgHV6LIB9ftdHYvI4y
   UAC/TeN3P7w+vbfBOyeVZWUyxdUv51Ae243Z+YZLsPlJQTl1OajrucrLH
   bLhkaDHzqirWTMToatp7AFADyN2phUqmx/37FQ8v8Jloej1z2yIson9OP
   szwisbGzs/IKkEU4CMt7EP2VAbHF+hIdPijWSB7UCP/c01U4Thg2K8Q26
   kjdwP3caIuWY7aaVk7FJv7in1F57cJHVKciU1vMoBrZ+cYseRKw12E67a
   A==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="230266342"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:33:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:33:54 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:33:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 01/11] clk: at91: clk-main: add support for parent_data/parent_hw
Date:   Thu, 15 Jun 2023 12:32:17 +0300
Message-ID: <20230615093227.576102-2-claudiu.beznea@microchip.com>
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

Add support for parent_data and parent_hw in main oscillator clock drivers.
With this parent-child relations are described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-main were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  |  4 ++--
 drivers/clk/at91/at91sam9260.c |  4 ++--
 drivers/clk/at91/at91sam9g45.c |  4 ++--
 drivers/clk/at91/at91sam9n12.c |  4 ++--
 drivers/clk/at91/at91sam9rl.c  |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  4 ++--
 drivers/clk/at91/clk-main.c    | 32 ++++++++++++++++++++++----------
 drivers/clk/at91/dt-compat.c   |  6 +++---
 drivers/clk/at91/pmc.h         |  9 ++++++---
 drivers/clk/at91/sam9x60.c     |  4 ++--
 drivers/clk/at91/sama5d2.c     |  4 ++--
 drivers/clk/at91/sama5d3.c     |  4 ++--
 drivers/clk/at91/sama5d4.c     |  4 ++--
 drivers/clk/at91/sama7g5.c     |  4 ++--
 14 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 0b860126d589..83917a2c31bd 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -108,12 +108,12 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc");
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index b521f470428f..e9b56826a9be 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -363,12 +363,12 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc");
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 5099669ddcbd..e25fb1bcafc7 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -123,12 +123,12 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc");
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 08a10e12d08d..35f137fb89e9 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -147,14 +147,14 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 1a1b6b2bb0e3..d3186dd34c26 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -95,7 +95,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	if (!at91sam9rl_pmc)
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", mainxtal_name);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", mainxtal_name, NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 13e589c95907..57f41aab94b2 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -169,14 +169,14 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 8601b27c1ae0..4b5f0ff9e287 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -152,14 +152,15 @@ struct clk_hw * __init
 at91_clk_register_main_osc(struct regmap *regmap,
 			   const char *name,
 			   const char *parent_name,
+			   struct clk_parent_data *parent_data,
 			   bool bypass)
 {
 	struct clk_main_osc *osc;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !parent_name)
+	if (!name || !(parent_name || parent_data))
 		return ERR_PTR(-EINVAL);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
@@ -168,7 +169,10 @@ at91_clk_register_main_osc(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &main_osc_ops;
-	init.parent_names = &parent_name;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_IGNORE_UNUSED;
 
@@ -397,17 +401,18 @@ static const struct clk_ops rm9200_main_ops = {
 struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
-			      const char *parent_name)
+			      const char *parent_name,
+			      struct clk_hw *parent_hw)
 {
 	struct clk_rm9200_main *clkmain;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
 	int ret;
 
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!parent_name)
+	if (!(parent_name || parent_hw))
 		return ERR_PTR(-EINVAL);
 
 	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
@@ -416,7 +421,10 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &rm9200_main_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = 0;
 
@@ -543,10 +551,11 @@ struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap,
 			      const char *name,
 			      const char **parent_names,
+			      struct clk_hw **parent_hws,
 			      int num_parents)
 {
 	struct clk_sam9x5_main *clkmain;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	unsigned int status;
 	struct clk_hw *hw;
 	int ret;
@@ -554,7 +563,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!parent_names || !num_parents)
+	if (!(parent_hws || parent_names) || !num_parents)
 		return ERR_PTR(-EINVAL);
 
 	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
@@ -563,7 +572,10 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sam9x5_main_ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_PARENT_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 97f67e23ef80..ecb0bebb8a7d 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -269,7 +269,7 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91_clk_register_main_osc(regmap, name, parent_name, bypass);
+	hw = at91_clk_register_main_osc(regmap, name, parent_name, NULL, bypass);
 	if (IS_ERR(hw))
 		return;
 
@@ -323,7 +323,7 @@ static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, name, parent_name);
+	hw = at91_clk_register_rm9200_main(regmap, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
@@ -354,7 +354,7 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names,
+	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names, NULL,
 					   num_parents);
 	if (IS_ERR(hw))
 		return;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 1b3ca7dd9b57..487e44deeca0 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -161,14 +161,17 @@ at91_clk_register_main_rc_osc(struct regmap *regmap, const char *name,
 			      u32 frequency, u32 accuracy);
 struct clk_hw * __init
 at91_clk_register_main_osc(struct regmap *regmap, const char *name,
-			   const char *parent_name, bool bypass);
+			   const char *parent_name,
+			   struct clk_parent_data *parent_data, bool bypass);
 struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
-			      const char *parent_name);
+			      const char *parent_name,
+			      struct clk_hw *parent_hw);
 struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
-			      const char **parent_names, int num_parents);
+			      const char **parent_names,
+			      struct clk_hw **parent_hws, int num_parents);
 
 struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index ac070db58195..e2f40f167c08 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -219,14 +219,14 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, 0);
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 	main_osc_hw = hw;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c0e3e1a4bbf3..2ee8f10d3b03 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -202,14 +202,14 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index ad6068b884de..88de1cccbb46 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -150,14 +150,14 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index e876ec971a39..4e6e276bbc4c 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -165,14 +165,14 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index f135b662f1ff..42dc74dbfc28 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -936,14 +936,14 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.34.1

