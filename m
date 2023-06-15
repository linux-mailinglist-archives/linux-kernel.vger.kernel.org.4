Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE654731413
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbjFOJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245756AbjFOJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:34:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD930C7;
        Thu, 15 Jun 2023 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821660; x=1718357660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mo/6YXFI51FlQp6qrcqF29Gi2KEab+inLmy2c+v9aDk=;
  b=kAttMUUES/1E9QSeylYPX3YPlrezrkPxG+rKeSxobOebOGfOW1miqvao
   4oIgOqcxIPkFLjMmNng40QO26+Wz7r77MFZXKtCpNox/FnI+FhQwxxRtl
   I71270qyQTQJ6eYOIbn0wAOJaX4I/qCZQ/ZTlxQTXQY/v3cnjRxX79w7x
   uVlK+GLbUCUAeHIBziwmk4JLVFBfTbwrJ2rnScReDtMDb26Zf6ONNZkV2
   sMF5MQOgP/lYWxj+4sAYkOHVoEd3mtaJLXKfOZgV5+2NkenaYETAVaMLy
   0GYi57YXHF7TeenNhy7JPcLIxkoOJEAeQ0R5Xq6vGA10v6D52dcgd8nMD
   w==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="218626898"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:07 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 04/11] clk: at91: clk-peripheral: add support for parent_hw
Date:   Thu, 15 Jun 2023 12:32:20 +0300
Message-ID: <20230615093227.576102-5-claudiu.beznea@microchip.com>
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

Add support for parent_hw in peripheral clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-peripheral were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c     |  2 +-
 drivers/clk/at91/at91sam9260.c    |  2 +-
 drivers/clk/at91/at91sam9g45.c    |  2 +-
 drivers/clk/at91/at91sam9n12.c    |  2 +-
 drivers/clk/at91/at91sam9rl.c     |  2 +-
 drivers/clk/at91/at91sam9x5.c     |  4 ++--
 drivers/clk/at91/clk-peripheral.c | 22 +++++++++++++++-------
 drivers/clk/at91/dt-compat.c      |  3 ++-
 drivers/clk/at91/pmc.h            |  4 +++-
 drivers/clk/at91/sam9x60.c        |  2 +-
 drivers/clk/at91/sama5d2.c        |  4 ++--
 drivers/clk/at91/sama5d3.c        |  2 +-
 drivers/clk/at91/sama5d4.c        |  4 ++--
 drivers/clk/at91/sama7g5.c        |  2 +-
 14 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 259e314ef40f..9eaf54418b7e 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -193,7 +193,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91rm9200_periphck[i].n,
-						  "masterck_div",
+						  "masterck_div", NULL,
 						  at91rm9200_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index f9bf65c77c9b..b124a8da58c7 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -470,7 +470,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	for (i = 0; i < data->num_pck; i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  data->pck[i].n,
-						  "masterck_div",
+						  "masterck_div", NULL,
 						  data->pck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index c9313a7b32ea..be968b428ed7 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -214,7 +214,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9g45_periphck[i].n,
-						  "masterck_div",
+						  "masterck_div", NULL,
 						  at91sam9g45_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 608410bef120..8441eae0daaa 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -240,7 +240,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9n12_pcr_layout,
 							 at91sam9n12_periphck[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 at91sam9n12_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 90911cbd9690..94a6b48352ce 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -170,7 +170,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9rl_periphck[i].n,
-						  "masterck_div",
+						  "masterck_div", NULL,
 						  at91sam9rl_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 63097cdd4809..15fbbcf535bc 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -274,7 +274,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9x5_pcr_layout,
 							 at91sam9x5_periphck[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 at91sam9x5_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
@@ -287,7 +287,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9x5_pcr_layout,
 							 extra_pcks[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 extra_pcks[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 93ea685e27f6..c173a44c800a 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -97,14 +97,15 @@ static const struct clk_ops peripheral_ops = {
 
 struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
-			     const char *parent_name, u32 id)
+			     const char *parent_name, struct clk_hw *parent_hw,
+			     u32 id)
 {
 	struct clk_peripheral *periph;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !parent_name || id > PERIPHERAL_ID_MAX)
+	if (!name || !(parent_name || parent_hw) || id > PERIPHERAL_ID_MAX)
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -113,7 +114,10 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &peripheral_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = 0;
 
@@ -444,15 +448,16 @@ struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
+				    struct clk_hw *parent_hw,
 				    u32 id, const struct clk_range *range,
 				    int chg_pid, unsigned long flags)
 {
 	struct clk_sam9x5_peripheral *periph;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !parent_name)
+	if (!name || !(parent_name || parent_hw))
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -460,7 +465,10 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = flags;
 	if (chg_pid < 0) {
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 4a024bb97312..8995e1cc73c6 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -490,7 +490,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 
 		if (type == PERIPHERAL_AT91RM9200) {
 			hw = at91_clk_register_peripheral(regmap, name,
-							  parent_name, id);
+							  parent_name, NULL, id);
 		} else {
 			struct clk_range range = CLK_RANGE(0, 0);
 			unsigned long flags = 0;
@@ -512,6 +512,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 								 &dt_pcr_layout,
 								 name,
 								 parent_name,
+								 NULL,
 								 id, &range,
 								 INT_MIN,
 								 flags);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index c09abb8ff8fe..6866e810352b 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -199,11 +199,13 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 
 struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
-			     const char *parent_name, u32 id);
+			     const char *parent_name, struct clk_hw *parent_hw,
+			     u32 id);
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
+				    struct clk_hw *parent_hw,
 				    u32 id, const struct clk_range *range,
 				    int chg_pid, unsigned long flags);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 3ff1eb3bee81..71fa8cb86a9d 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -337,7 +337,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sam9x60_pcr_layout,
 							 sam9x60_periphck[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 sam9x60_periphck[i].id,
 							 &range, INT_MIN,
 							 sam9x60_periphck[i].flags);
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c47d43a7e95b..944e1fec8ad2 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -324,7 +324,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periphck[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 sama5d2_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d2_periphck[i].flags);
@@ -338,7 +338,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periph32ck[i].n,
-							 "h32mxck",
+							 "h32mxck", NULL,
 							 sama5d2_periph32ck[i].id,
 							 &sama5d2_periph32ck[i].r,
 							 INT_MIN, 0);
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index d605a540b30f..f61bef0838c9 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -244,7 +244,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d3_pcr_layout,
 							 sama5d3_periphck[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 sama5d3_periphck[i].id,
 							 &sama5d3_periphck[i].r,
 							 INT_MIN,
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 21a61840d5f3..f0bf2096f666 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -267,7 +267,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d4_pcr_layout,
 							 sama5d4_periphck[i].n,
-							 "masterck_div",
+							 "masterck_div", NULL,
 							 sama5d4_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d4_periphck[i].flags);
@@ -281,7 +281,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d4_pcr_layout,
 							 sama5d4_periph32ck[i].n,
-							 "h32mxck",
+							 "h32mxck", NULL,
 							 sama5d4_periph32ck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 989d66f5370e..c913c1c7a9f9 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1079,7 +1079,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 						&sama7g5_pcr_layout,
 						sama7g5_periphck[i].n,
-						sama7g5_periphck[i].p,
+						sama7g5_periphck[i].p, NULL,
 						sama7g5_periphck[i].id,
 						&sama7g5_periphck[i].r,
 						sama7g5_periphck[i].chgp ? 0 :
-- 
2.34.1

