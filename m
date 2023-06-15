Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC78E73141D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjFOJgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbjFOJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:35:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6842D6B;
        Thu, 15 Jun 2023 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821703; x=1718357703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A1dmJ+pItK/gMLz16UT2MdMrZ6M2X5XJ/pGGBcR7j2U=;
  b=vkAR01MwNc4zAGttBqiOdHa7liVduxB5cQpheJAbQkm57T6mm6XNjgot
   Q+uELvs/qXmJ+D5jiNH43QraVo71DhdGYHwt57v+dXn1iMsorWMXu/4H+
   GvOa5y5PhhDYbhENqDE2EkFjueoye/3swKUJO9EtrV78/UsLOkRxvoO0a
   33oXciWTXYv8fMKBR5pCxA1MSfZgDZlg6j8Ck1rIh3TWr32UwSHditV8u
   BBCFC3suO0q4nfqX/kaLVK/J93G8Gk0zsgnGMJNm6op/cHDiD3bcq8pIu
   jDmpcBUTg2MV58+qeTL1IDTJdpMglaKMHMqGOmTJALEq3Soszsnj2zL8n
   w==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="216166862"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:20 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 07/11] clk: at91: clk-utmi: add support for parent_hw
Date:   Thu, 15 Jun 2023 12:32:23 +0300
Message-ID: <20230615093227.576102-8-claudiu.beznea@microchip.com>
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

Add support for parent_hw in utmi clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-utmi were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9rl.c  |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/clk-utmi.c    | 24 +++++++++++++++++-------
 drivers/clk/at91/dt-compat.c   |  2 +-
 drivers/clk/at91/pmc.h         |  5 +++--
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 drivers/clk/at91/sama7g5.c     |  2 +-
 10 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index ec2f26c3a80a..f45a7b80f7d8 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -145,7 +145,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	at91sam9g45_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 051b2eeb9276..969f809e7d65 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -109,7 +109,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index e1be2c4c54be..3b801d12fac0 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -193,7 +193,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	at91sam9x5_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index a22c10d9a1b9..40c84f5af5e8 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -144,21 +144,30 @@ static struct clk_hw * __init
 at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 				struct regmap *regmap_sfr,
 				const char *name, const char *parent_name,
+				struct clk_hw *parent_hw,
 				const struct clk_ops *ops, unsigned long flags)
 {
 	struct clk_utmi *utmi;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
+	if (!(parent_name || parent_hw))
+		return ERR_PTR(-EINVAL);
+
 	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
 	if (!utmi)
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
 	init.ops = ops;
-	init.parent_names = parent_name ? &parent_name : NULL;
-	init.num_parents = parent_name ? 1 : 0;
+	if (parent_hw) {
+		init.parent_hws = parent_hw ? (const struct clk_hw **)&parent_hw : NULL;
+		init.num_parents = parent_hw ? 1 : 0;
+	} else {
+		init.parent_names = parent_name ? &parent_name : NULL;
+		init.num_parents = parent_name ? 1 : 0;
+	}
 	init.flags = flags;
 
 	utmi->hw.init = &init;
@@ -177,10 +186,11 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
-		       const char *name, const char *parent_name)
+		       const char *name, const char *parent_name,
+		       struct clk_hw *parent_hw)
 {
 	return at91_clk_register_utmi_internal(regmap_pmc, regmap_sfr, name,
-			parent_name, &utmi_ops, CLK_SET_RATE_GATE);
+			parent_name, parent_hw, &utmi_ops, CLK_SET_RATE_GATE);
 }
 
 static int clk_utmi_sama7g5_prepare(struct clk_hw *hw)
@@ -279,8 +289,8 @@ static const struct clk_ops sama7g5_utmi_ops = {
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap_pmc, const char *name,
-			       const char *parent_name)
+			       const char *parent_name, struct clk_hw *parent_hw)
 {
 	return at91_clk_register_utmi_internal(regmap_pmc, NULL, name,
-			parent_name, &sama7g5_utmi_ops, 0);
+			parent_name, parent_hw, &sama7g5_utmi_ops, 0);
 }
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index e5fcf2e0d235..a32dc2111b90 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -1055,7 +1055,7 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 			regmap_sfr = NULL;
 	}
 
-	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_name);
+	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 101e005a9550..8e32be004843 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -269,10 +269,11 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
-		       const char *name, const char *parent_name);
+		       const char *name, const char *parent_name,
+		       struct clk_hw *parent_hw);
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *name,
-			       const char *parent_name);
+			       const char *parent_name, struct clk_hw *parent_hw);
 
 #endif /* __PMC_H_ */
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c5df06190e1c..c16594fce90c 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -249,7 +249,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap_sfr))
 		regmap_sfr = NULL;
 
-	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", "mainck");
+	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 15fa180a3f58..522ce6031446 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -172,7 +172,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	sama5d3_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 2440a34d1d67..160c0bddb6a3 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -187,7 +187,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	sama5d4_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index b606d642a22b..42f2f61cc6d1 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1035,7 +1035,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			sama7g5_pmc->chws[sama7g5_mckx[i].eid] = hw;
 	}
 
-	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", "main_xtal");
+	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", "main_xtal", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.34.1

