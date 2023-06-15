Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DE731411
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbjFOJfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245599AbjFOJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:34:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687E2D4B;
        Thu, 15 Jun 2023 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821653; x=1718357653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uarGFVNbImsCBT3wNrBtjfwwEBkwkQ2ktJO+9YXSNc=;
  b=SQRSMcU55fbSGu9VvAi3Gwic5vDmwvckQr+yuF0Ekn3ziafJTvMMtR7/
   IzFbGpXTCCWpKnVMWsgslNnkFd2dwIO4X1LDVEeQeBw2EeIB4ZEfSDg+2
   OuWzmmNwxdy+GEKfx4L1UkM4pGaRUe1Hv0H33J3tyNzFqiiFnyK2kgKRg
   PAjfEggt2G1RF+L84xkf5S6yWTZKZNSk3m1pCtwRtz8JQQDiX5T0gY6oJ
   13LuU9itbv+KeNH0Z1+JDv+rHG/+MwXTS6i86ft6B65rE9OqhDvWjR3bi
   oxxaWrwrYvf0y7muGm2vf/oHHutJVran7k3FijHRTBFPCyg3KbI5+0iXu
   g==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="218626871"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 05/11] clk: at91: clk-programmable: add support for parent_hw
Date:   Thu, 15 Jun 2023 12:32:21 +0300
Message-ID: <20230615093227.576102-6-claudiu.beznea@microchip.com>
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

Add support for parent_hw in programmable clock driver.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-programmable were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c       |  2 +-
 drivers/clk/at91/at91sam9260.c      |  2 +-
 drivers/clk/at91/at91sam9g45.c      |  2 +-
 drivers/clk/at91/at91sam9n12.c      |  2 +-
 drivers/clk/at91/at91sam9rl.c       |  2 +-
 drivers/clk/at91/at91sam9x5.c       |  2 +-
 drivers/clk/at91/clk-programmable.c | 11 +++++++----
 drivers/clk/at91/dt-compat.c        |  2 +-
 drivers/clk/at91/pmc.h              |  3 ++-
 drivers/clk/at91/sam9x60.c          |  2 +-
 drivers/clk/at91/sama5d2.c          |  2 +-
 drivers/clk/at91/sama5d3.c          |  2 +-
 drivers/clk/at91/sama5d4.c          |  2 +-
 drivers/clk/at91/sama7g5.c          |  2 +-
 14 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 9eaf54418b7e..2dd69628b7ba 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -171,7 +171,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 4, i,
+						    parent_names, NULL, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index b124a8da58c7..7d292d0c2bfc 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -448,7 +448,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 4, i,
+						    parent_names, NULL, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index be968b428ed7..b49415952510 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -191,7 +191,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 5, i,
+						    parent_names, NULL, 5, i,
 						    &at91sam9g45_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 8441eae0daaa..63151cd0d3b2 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -216,7 +216,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 5, i,
+						    parent_names, NULL, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 94a6b48352ce..858987757b87 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -148,7 +148,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 5, i,
+						    parent_names, NULL, 5, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 15fbbcf535bc..6a971b34f7dd 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -241,7 +241,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 5, i,
+						    parent_names, NULL, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 6c4b259d31d3..1195fb405503 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -215,16 +215,16 @@ static const struct clk_ops programmable_ops = {
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap,
 			       const char *name, const char **parent_names,
-			       u8 num_parents, u8 id,
+			       struct clk_hw **parent_hws, u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout,
 			       u32 *mux_table)
 {
 	struct clk_programmable *prog;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
-	if (id > PROG_ID_MAX)
+	if (id > PROG_ID_MAX || !(parent_names || parent_hws))
 		return ERR_PTR(-EINVAL);
 
 	prog = kzalloc(sizeof(*prog), GFP_KERNEL);
@@ -233,7 +233,10 @@ at91_clk_register_programmable(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &programmable_ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 8995e1cc73c6..96ce2287e13a 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -770,7 +770,7 @@ of_at91_clk_prog_setup(struct device_node *np,
 			name = progclknp->name;
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, num_parents,
+						    parent_names, NULL, num_parents,
 						    id, layout, mux_table);
 		if (IS_ERR(hw))
 			continue;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 6866e810352b..658bbf574af9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -234,7 +234,8 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap, const char *name,
-			       const char **parent_names, u8 num_parents, u8 id,
+			       const char **parent_names, struct clk_hw **parent_hws,
+			       u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout,
 			       u32 *mux_table);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 71fa8cb86a9d..369123dc009c 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -313,7 +313,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 6, i,
+						    parent_names, NULL, 6, i,
 						    &sam9x60_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 944e1fec8ad2..8eda5f95d142 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -300,7 +300,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 6, i,
+						    parent_names, NULL, 6, i,
 						    &sama5d2_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index f61bef0838c9..68a540cf8eda 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -220,7 +220,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 5, i,
+						    parent_names, NULL, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index f0bf2096f666..9145fa184388 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -243,7 +243,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, 5, i,
+						    parent_names, NULL, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index c913c1c7a9f9..22942af8dce4 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1056,7 +1056,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name, parent_names,
-						    9, i,
+						    NULL, 9, i,
 						    &programmable_layout,
 						    sama7g5_prog_mux_table);
 		if (IS_ERR(hw))
-- 
2.34.1

