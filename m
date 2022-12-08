Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35A2646EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLHLkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:40:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B169312;
        Thu,  8 Dec 2022 03:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670499603; x=1702035603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qgxkm+hslu5ANNtRAJnguOiLY8Ma4a1dwPWoNFooZGw=;
  b=CfRMkNzJLslfy7lsfyNHfHIq/kMOBoKnkfDh6MDO0Ng1OfeIY9UgKMMv
   MQJsEmE8FgeF2HBVSvbk7XiJl1mLC2LYFKUU7q8gStBUFUof2Z5D7+zBZ
   LfubPOjSjyLj+NG83caBkcE8ZOHs1VUjWmiMwvpde7t41lGwk8j1Iy5j4
   CyOBklxXJxdYgJlZNoSE+pMfjZRJQuxsHmkZ6NtyUFSr1WnfRxLx4laIB
   lHLxh4TCg1Wo0Xx3CBRXiDNaX60zGyFeHE0r+FB89Ztzw0esdYKGjspnV
   7NBYo9CkySK6TyqipVCorpaYl4m/kxcGuuAIdGw84XJtjSEVYo9q/E0RX
   g==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="192220462"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 04:40:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 04:40:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Dec 2022 04:39:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] clk: at91: mark ddr clocks as critical
Date:   Thu, 8 Dec 2022 13:45:13 +0200
Message-ID: <20221208114515.35179-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221208114515.35179-1-claudiu.beznea@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark DDR clocks as critical for AT91 devices. These clocks are enabled
by bootloader when initializing DDR and needs to stay enabled. Up to
this patch the DDR clocks were requested from drivers/memory/atmel-sdramc.c
which does only clock request and enable. There is no need to have
a separate driver just for this, thus the atmel-sdramc.c will be deleted
in a subsequent patch.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c     |  2 +-
 drivers/clk/at91/at91sam9260.c    |  2 +-
 drivers/clk/at91/at91sam9g45.c    | 10 ++++++++--
 drivers/clk/at91/at91sam9n12.c    | 12 +++++++++---
 drivers/clk/at91/at91sam9rl.c     |  2 +-
 drivers/clk/at91/at91sam9x5.c     | 17 ++++++++++++-----
 drivers/clk/at91/clk-peripheral.c |  8 ++++----
 drivers/clk/at91/clk-system.c     |  4 ++--
 drivers/clk/at91/dt-compat.c      | 25 +++++++++++++++++++++++--
 drivers/clk/at91/pmc.h            |  4 ++--
 drivers/clk/at91/sam9x60.c        | 20 ++++++++++++++++----
 drivers/clk/at91/sama5d2.c        | 22 +++++++++++++++++-----
 drivers/clk/at91/sama5d3.c        | 20 ++++++++++++++++----
 drivers/clk/at91/sama5d4.c        | 22 +++++++++++++++++-----
 drivers/clk/at91/sama7g5.c        |  4 ++--
 15 files changed, 131 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 16870943a13e..0b860126d589 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -183,7 +183,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n,
 					      at91rm9200_systemck[i].p,
-					      at91rm9200_systemck[i].id);
+					      at91rm9200_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 11550e50cd9f..b521f470428f 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -460,7 +460,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	for (i = 0; i < data->num_sck; i++) {
 		hw = at91_clk_register_system(regmap, data->sck[i].n,
 					      data->sck[i].p,
-					      data->sck[i].id);
+					      data->sck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 8c9344451f46..5099669ddcbd 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -40,9 +40,14 @@ static const struct clk_pll_characteristics plla_characteristics = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } at91sam9g45_systemck[] = {
-	{ .n = "ddrck", .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "uhpck", .p = "usbck",        .id = 6 },
 	{ .n = "pck0",  .p = "prog0",        .id = 8 },
 	{ .n = "pck1",  .p = "prog1",        .id = 9 },
@@ -198,7 +203,8 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9g45_systemck[i].n,
 					      at91sam9g45_systemck[i].p,
-					      at91sam9g45_systemck[i].id);
+					      at91sam9g45_systemck[i].id,
+					      at91sam9g45_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 0bb19400d199..08a10e12d08d 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -54,9 +54,14 @@ static const struct clk_pll_characteristics pllb_characteristics = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } at91sam9n12_systemck[] = {
-	{ .n = "ddrck", .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
 	{ .n = "uhpck", .p = "usbck",        .id = 6 },
 	{ .n = "udpck", .p = "usbck",        .id = 7 },
@@ -223,7 +228,8 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9n12_systemck[i].n,
 					      at91sam9n12_systemck[i].p,
-					      at91sam9n12_systemck[i].id);
+					      at91sam9n12_systemck[i].id,
+					      at91sam9n12_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -236,7 +242,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 							 at91sam9n12_periphck[i].n,
 							 "masterck_div",
 							 at91sam9n12_periphck[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index b992137bab02..1a1b6b2bb0e3 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -160,7 +160,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n,
 					      at91sam9rl_systemck[i].p,
-					      at91sam9rl_systemck[i].id);
+					      at91sam9rl_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 3857db2e144b..13e589c95907 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -41,9 +41,14 @@ static const struct clk_pll_characteristics plla_characteristics = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } at91sam9x5_systemck[] = {
-	{ .n = "ddrck", .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "smdck", .p = "smdclk",   .id = 4 },
 	{ .n = "uhpck", .p = "usbck",    .id = 6 },
 	{ .n = "udpck", .p = "usbck",    .id = 7 },
@@ -248,7 +253,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9x5_systemck[i].n,
 					      at91sam9x5_systemck[i].p,
-					      at91sam9x5_systemck[i].id);
+					      at91sam9x5_systemck[i].id,
+					      at91sam9x5_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -256,7 +262,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	}
 
 	if (has_lcdck) {
-		hw = at91_clk_register_system(regmap, "lcdck", "masterck_div", 3);
+		hw = at91_clk_register_system(regmap, "lcdck", "masterck_div",
+					      3, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -269,7 +276,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 							 at91sam9x5_periphck[i].n,
 							 "masterck_div",
 							 at91sam9x5_periphck[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -282,7 +289,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 							 extra_pcks[i].n,
 							 "masterck_div",
 							 extra_pcks[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 5104d4025484..93ea685e27f6 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -445,7 +445,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
 				    u32 id, const struct clk_range *range,
-				    int chg_pid)
+				    int chg_pid, unsigned long flags)
 {
 	struct clk_sam9x5_peripheral *periph;
 	struct clk_init_data init;
@@ -462,12 +462,12 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 	init.name = name;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
+	init.flags = flags;
 	if (chg_pid < 0) {
-		init.flags = 0;
 		init.ops = &sam9x5_peripheral_ops;
 	} else {
-		init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-			     CLK_SET_RATE_PARENT;
+		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			      CLK_SET_RATE_PARENT;
 		init.ops = &sam9x5_peripheral_chg_ops;
 	}
 
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 80720fd1a9cf..10193650429e 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -105,7 +105,7 @@ static const struct clk_ops system_ops = {
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, u8 id)
+			 const char *parent_name, u8 id, unsigned long flags)
 {
 	struct clk_system *sys;
 	struct clk_hw *hw;
@@ -123,7 +123,7 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 	init.ops = &system_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	init.flags = CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT | flags;
 
 	sys->id = id;
 	sys->hw.init = &init;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 85a964cb2d89..97f67e23ef80 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -493,18 +493,28 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 							  parent_name, id);
 		} else {
 			struct clk_range range = CLK_RANGE(0, 0);
+			unsigned long flags = 0;
 
 			of_at91_get_clk_range(periphclknp,
 					      "atmel,clk-output-range",
 					      &range);
 
+			/*
+			 * mpddr_clk feed DDR controller and is enabled by
+			 * bootloader thus we need to keep it enabled in case
+			 * there is no Linux consumer for it.
+			 */
+			if (!strcmp(periphclknp->name, "mpddr_clk"))
+				flags = CLK_IS_CRITICAL;
+
 			hw = at91_clk_register_sam9x5_peripheral(regmap,
 								 &pmc_pcr_lock,
 								 &dt_pcr_layout,
 								 name,
 								 parent_name,
 								 id, &range,
-								 INT_MIN);
+								 INT_MIN,
+								 flags);
 		}
 
 		if (IS_ERR(hw))
@@ -879,6 +889,8 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 		return;
 
 	for_each_child_of_node(np, sysclknp) {
+		unsigned long flags = 0;
+
 		if (of_property_read_u32(sysclknp, "reg", &id))
 			continue;
 
@@ -887,7 +899,16 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 
 		parent_name = of_clk_get_parent_name(sysclknp, 0);
 
-		hw = at91_clk_register_system(regmap, name, parent_name, id);
+		/*
+		 * ddrck feeds DDR controller and is enabled by bootloader thus
+		 * we need to keep it enabled in case there is no Linux consumer
+		 * for it.
+		 */
+		if (!strcmp(sysclknp->name, "ddrck"))
+			flags = CLK_IS_CRITICAL;
+
+		hw = at91_clk_register_system(regmap, name, parent_name, id,
+					      flags);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index efe4975bddc3..1b3ca7dd9b57 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -199,7 +199,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
 				    u32 id, const struct clk_range *range,
-				    int chg_pid);
+				    int chg_pid, unsigned long flags);
 
 struct clk_hw * __init
 at91_clk_register_pll(struct regmap *regmap, const char *name,
@@ -242,7 +242,7 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, u8 id);
+			 const char *parent_name, u8 id, unsigned long flags);
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 9ea4ce501bad..ac070db58195 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -75,9 +75,14 @@ static const struct clk_pcr_layout sam9x60_pcr_layout = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } sam9x60_systemck[] = {
-	{ .n = "ddrck",  .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck",  .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "uhpck",  .p = "usbck",    .id = 6 },
 	{ .n = "pck0",   .p = "prog0",    .id = 8 },
 	{ .n = "pck1",   .p = "prog1",    .id = 9 },
@@ -86,6 +91,7 @@ static const struct {
 
 static const struct {
 	char *n;
+	unsigned long flags;
 	u8 id;
 } sam9x60_periphck[] = {
 	{ .n = "pioA_clk",   .id = 2, },
@@ -132,7 +138,11 @@ static const struct {
 	{ .n = "pioD_clk",   .id = 44, },
 	{ .n = "tcb1_clk",   .id = 45, },
 	{ .n = "dbgu_clk",   .id = 47, },
-	{ .n = "mpddr_clk",  .id = 49, },
+	/*
+	 * mpddr_clk feeds DDR controller and is enabled by bootloader thus we
+	 * need to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "mpddr_clk",  .id = 49, .flags = CLK_IS_CRITICAL },
 };
 
 static const struct {
@@ -315,7 +325,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(sam9x60_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sam9x60_systemck[i].n,
 					      sam9x60_systemck[i].p,
-					      sam9x60_systemck[i].id);
+					      sam9x60_systemck[i].id,
+					      sam9x60_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -328,7 +339,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 							 sam9x60_periphck[i].n,
 							 "masterck_div",
 							 sam9x60_periphck[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN,
+							 sam9x60_periphck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 84156dc52bff..c0e3e1a4bbf3 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -40,9 +40,14 @@ static const struct clk_pcr_layout sama5d2_pcr_layout = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } sama5d2_systemck[] = {
-	{ .n = "ddrck", .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
 	{ .n = "uhpck", .p = "usbck",        .id = 6 },
 	{ .n = "udpck", .p = "usbck",        .id = 7 },
@@ -97,6 +102,7 @@ static const struct {
 
 static const struct {
 	char *n;
+	unsigned long flags;
 	u8 id;
 } sama5d2_periphck[] = {
 	{ .n = "dma0_clk",    .id = 6, },
@@ -104,7 +110,11 @@ static const struct {
 	{ .n = "aes_clk",     .id = 9, },
 	{ .n = "aesb_clk",    .id = 10, },
 	{ .n = "sha_clk",     .id = 12, },
-	{ .n = "mpddr_clk",   .id = 13, },
+	/*
+	 * mpddr_clk feeds DDR controller and is enabled by bootloader thus we
+	 * need to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "mpddr_clk",   .id = 13, .flags = CLK_IS_CRITICAL },
 	{ .n = "matrix0_clk", .id = 15, },
 	{ .n = "sdmmc0_hclk", .id = 31, },
 	{ .n = "sdmmc1_hclk", .id = 32, },
@@ -302,7 +312,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d2_systemck[i].n,
 					      sama5d2_systemck[i].p,
-					      sama5d2_systemck[i].id);
+					      sama5d2_systemck[i].id,
+					      sama5d2_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -315,7 +326,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 							 sama5d2_periphck[i].n,
 							 "masterck_div",
 							 sama5d2_periphck[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN,
+							 sama5d2_periphck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -329,7 +341,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 							 "h32mxck",
 							 sama5d2_periph32ck[i].id,
 							 &sama5d2_periph32ck[i].r,
-							 INT_MIN);
+							 INT_MIN, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 7e93c6edf305..ad6068b884de 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -40,9 +40,14 @@ static const struct clk_pcr_layout sama5d3_pcr_layout = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } sama5d3_systemck[] = {
-	{ .n = "ddrck", .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
 	{ .n = "smdck", .p = "smdclk",       .id = 4 },
 	{ .n = "uhpck", .p = "usbck",        .id = 6 },
@@ -56,6 +61,7 @@ static const struct {
 	char *n;
 	u8 id;
 	struct clk_range r;
+	unsigned long flags;
 } sama5d3_periphck[] = {
 	{ .n = "dbgu_clk", .id = 2, },
 	{ .n = "hsmc_clk", .id = 5, },
@@ -99,7 +105,11 @@ static const struct {
 	{ .n = "tdes_clk", .id = 44, },
 	{ .n = "trng_clk", .id = 45, },
 	{ .n = "fuse_clk", .id = 48, },
-	{ .n = "mpddr_clk", .id = 49, },
+	/*
+	 * mpddr_clk feeds DDR controller and is enabled by bootloader thus we
+	 * need to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "mpddr_clk", .id = 49, .flags = CLK_IS_CRITICAL },
 };
 
 static void __init sama5d3_pmc_setup(struct device_node *np)
@@ -222,7 +232,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d3_systemck[i].n,
 					      sama5d3_systemck[i].p,
-					      sama5d3_systemck[i].id);
+					      sama5d3_systemck[i].id,
+					      sama5d3_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -236,7 +247,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 							 "masterck_div",
 							 sama5d3_periphck[i].id,
 							 &sama5d3_periphck[i].r,
-							 INT_MIN);
+							 INT_MIN,
+							 sama5d3_periphck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 1a14a9bce308..e876ec971a39 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -39,9 +39,14 @@ static const struct clk_pcr_layout sama5d4_pcr_layout = {
 static const struct {
 	char *n;
 	char *p;
+	unsigned long flags;
 	u8 id;
 } sama5d4_systemck[] = {
-	{ .n = "ddrck", .p = "masterck_div", .id = 2 },
+	/*
+	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
+	 * to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
 	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
 	{ .n = "smdck", .p = "smdclk",       .id = 4 },
 	{ .n = "uhpck", .p = "usbck",        .id = 6 },
@@ -103,12 +108,17 @@ static const struct {
 
 static const struct {
 	char *n;
+	unsigned long flags;
 	u8 id;
 } sama5d4_periphck[] = {
 	{ .n = "dma0_clk", .id = 8 },
 	{ .n = "cpkcc_clk", .id = 10 },
 	{ .n = "aesb_clk", .id = 13 },
-	{ .n = "mpddr_clk", .id = 16 },
+	/*
+	 * mpddr_clk feeds DDR controller and is enabled by bootloader thus we
+	 * need to keep it enabled in case there is no Linux consumer for it.
+	 */
+	{ .n = "mpddr_clk", .id = 16, .flags = CLK_IS_CRITICAL },
 	{ .n = "matrix0_clk", .id = 18 },
 	{ .n = "vdec_clk", .id = 19 },
 	{ .n = "dma1_clk", .id = 50 },
@@ -245,7 +255,8 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d4_systemck[i].n,
 					      sama5d4_systemck[i].p,
-					      sama5d4_systemck[i].id);
+					      sama5d4_systemck[i].id,
+					      sama5d4_systemck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -258,7 +269,8 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 							 sama5d4_periphck[i].n,
 							 "masterck_div",
 							 sama5d4_periphck[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN,
+							 sama5d4_periphck[i].flags);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -271,7 +283,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 							 sama5d4_periph32ck[i].n,
 							 "h32mxck",
 							 sama5d4_periph32ck[i].id,
-							 &range, INT_MIN);
+							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 9a213ba9e58b..f135b662f1ff 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1068,7 +1068,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(sama7g5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama7g5_systemck[i].n,
 					      sama7g5_systemck[i].p,
-					      sama7g5_systemck[i].id);
+					      sama7g5_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -1083,7 +1083,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 						sama7g5_periphck[i].id,
 						&sama7g5_periphck[i].r,
 						sama7g5_periphck[i].chgp ? 0 :
-						INT_MIN);
+						INT_MIN, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.34.1

