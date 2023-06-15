Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE473141F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjFOJgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245747AbjFOJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:36:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D9C358C;
        Thu, 15 Jun 2023 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686821723; x=1718357723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6S7fBvJMryuXc9NJ//LZErtsGf/tBr9F4503HKO5kT0=;
  b=sKYBEJgu+WGI/0j7DwIp7hORmg3Qzjroe/55YOh0gMWy9p2jujb5UXtt
   Oip8RomJJwVbZLJEGgFHPDF9g7rcGsCM3U/IfMgdtumNy9Ci6H4rj77eM
   zg0MIdpglSltMl/L5RtUl02nTZ6TKncbEypG79VmaalwrSZjJu8GCAuZx
   IPWH1BqQpDXjS0cHa7h0vO7j5Bzl8CeYROm+cSKirRIR0UBT62LmEX4FR
   rzicYCOhaPaiQqolXreB8vcSKjGjNyGP/w65wn/IJ/oMRvQKpi30MSyEW
   AIctA7qqpTfF3E6GwEnNEMSU6/5+p2/OiAdmnDUJvVK0HBvC9z8Br1LV+
   w==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="216166897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 02:34:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 02:34:29 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 02:34:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 09/11] clk: at91: sckc: switch to parent_data/parent_hw
Date:   Thu, 15 Jun 2023 12:32:25 +0300
Message-ID: <20230615093227.576102-10-claudiu.beznea@microchip.com>
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

Switch slow clock drivers to use parent_data and parent_hw.
With this parent-child relation is described with pointers rather
than strings.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 75 ++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index fdc9b669f8a7..fdd963eb9f0f 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -117,17 +117,17 @@ static const struct clk_ops slow_osc_ops = {
 static struct clk_hw * __init
 at91_clk_register_slow_osc(void __iomem *sckcr,
 			   const char *name,
-			   const char *parent_name,
+			   const struct clk_parent_data *parent_data,
 			   unsigned long startup,
 			   bool bypass,
 			   const struct clk_slow_bits *bits)
 {
 	struct clk_slow_osc *osc;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
-	if (!sckcr || !name || !parent_name)
+	if (!sckcr || !name || !parent_data)
 		return ERR_PTR(-EINVAL);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
@@ -136,7 +136,7 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 
 	init.name = name;
 	init.ops = &slow_osc_ops;
-	init.parent_names = &parent_name;
+	init.parent_data = parent_data;
 	init.num_parents = 1;
 	init.flags = CLK_IGNORE_UNUSED;
 
@@ -317,16 +317,16 @@ static const struct clk_ops sam9x5_slow_ops = {
 static struct clk_hw * __init
 at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 			      const char *name,
-			      const char **parent_names,
+			      const struct clk_hw **parent_hws,
 			      int num_parents,
 			      const struct clk_slow_bits *bits)
 {
 	struct clk_sam9x5_slow *slowck;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
-	if (!sckcr || !name || !parent_names || !num_parents)
+	if (!sckcr || !name || !parent_hws || !num_parents)
 		return ERR_PTR(-EINVAL);
 
 	slowck = kzalloc(sizeof(*slowck), GFP_KERNEL);
@@ -335,7 +335,7 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 
 	init.name = name;
 	init.ops = &sam9x5_slow_ops;
-	init.parent_names = parent_names;
+	init.parent_hws = parent_hws;
 	init.num_parents = num_parents;
 	init.flags = 0;
 
@@ -366,18 +366,21 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 					    unsigned int rc_osc_startup_us,
 					    const struct clk_slow_bits *bits)
 {
-	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
 	void __iomem *regbase = of_iomap(np, 0);
 	struct device_node *child = NULL;
 	const char *xtal_name;
 	struct clk_hw *slow_rc, *slow_osc, *slowck;
+	static struct clk_parent_data parent_data = {
+		.name = "slow_xtal",
+	};
+	const struct clk_hw *parent_hws[2];
 	bool bypass;
 	int ret;
 
 	if (!regbase)
 		return;
 
-	slow_rc = at91_clk_register_slow_rc_osc(regbase, parent_names[0],
+	slow_rc = at91_clk_register_slow_rc_osc(regbase, "slow_rc_osc",
 						32768, 50000000,
 						rc_osc_startup_us, bits);
 	if (IS_ERR(slow_rc))
@@ -401,12 +404,16 @@ static void __init at91sam9x5_sckc_register(struct device_node *np,
 	if (!xtal_name)
 		goto unregister_slow_rc;
 
-	slow_osc = at91_clk_register_slow_osc(regbase, parent_names[1],
-					      xtal_name, 1200000, bypass, bits);
+	parent_data.fw_name = xtal_name;
+
+	slow_osc = at91_clk_register_slow_osc(regbase, "slow_osc",
+					      &parent_data, 1200000, bypass, bits);
 	if (IS_ERR(slow_osc))
 		goto unregister_slow_rc;
 
-	slowck = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names,
+	parent_hws[0] = slow_rc;
+	parent_hws[1] = slow_osc;
+	slowck = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_hws,
 					       2, bits);
 	if (IS_ERR(slowck))
 		goto unregister_slow_osc;
@@ -464,14 +471,17 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw *slow_rc, *slow_osc;
 	const char *xtal_name;
-	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
+	const struct clk_hw *parent_hws[2];
+	static struct clk_parent_data parent_data = {
+		.name = "slow_xtal",
+	};
 	bool bypass;
 	int ret;
 
 	if (!regbase)
 		return;
 
-	slow_rc = clk_hw_register_fixed_rate_with_accuracy(NULL, parent_names[0],
+	slow_rc = clk_hw_register_fixed_rate_with_accuracy(NULL, "slow_rc_osc",
 							   NULL, 0, 32768,
 							   93750000);
 	if (IS_ERR(slow_rc))
@@ -481,9 +491,10 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	if (!xtal_name)
 		goto unregister_slow_rc;
 
+	parent_data.fw_name = xtal_name;
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
-	slow_osc = at91_clk_register_slow_osc(regbase, parent_names[1],
-					      xtal_name, 5000000, bypass,
+	slow_osc = at91_clk_register_slow_osc(regbase, "slow_osc",
+					      &parent_data, 5000000, bypass,
 					      &at91sam9x60_bits);
 	if (IS_ERR(slow_osc))
 		goto unregister_slow_rc;
@@ -494,14 +505,16 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 
 	/* MD_SLCK and TD_SLCK. */
 	clk_data->num = 2;
-	clk_data->hws[0] = clk_hw_register_fixed_rate(NULL, "md_slck",
-						      parent_names[0],
-						      0, 32768);
+	clk_data->hws[0] = clk_hw_register_fixed_rate_parent_hw(NULL, "md_slck",
+								slow_rc,
+								0, 32768);
 	if (IS_ERR(clk_data->hws[0]))
 		goto clk_data_free;
 
+	parent_hws[0] = slow_rc;
+	parent_hws[1] = slow_osc;
 	clk_data->hws[1] = at91_clk_register_sam9x5_slow(regbase, "td_slck",
-							 parent_names, 2,
+							 parent_hws, 2,
 							 &at91sam9x60_bits);
 	if (IS_ERR(clk_data->hws[1]))
 		goto unregister_md_slck;
@@ -572,30 +585,36 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	void __iomem *regbase = of_iomap(np, 0);
 	struct clk_hw *slow_rc, *slowck;
 	struct clk_sama5d4_slow_osc *osc;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *xtal_name;
-	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
+	const struct clk_hw *parent_hws[2];
+	static struct clk_parent_data parent_data = {
+		.name = "slow_xtal",
+	};
 	int ret;
 
 	if (!regbase)
 		return;
 
 	slow_rc = clk_hw_register_fixed_rate_with_accuracy(NULL,
-							   parent_names[0],
+							   "slow_rc_osc",
 							   NULL, 0, 32768,
 							   250000000);
 	if (IS_ERR(slow_rc))
 		return;
 
 	xtal_name = of_clk_get_parent_name(np, 0);
+	if (!xtal_name)
+		goto unregister_slow_rc;
+	parent_data.fw_name = xtal_name;
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
 	if (!osc)
 		goto unregister_slow_rc;
 
-	init.name = parent_names[1];
+	init.name = "slow_osc";
 	init.ops = &sama5d4_slow_osc_ops;
-	init.parent_names = &xtal_name;
+	init.parent_data = &parent_data;
 	init.num_parents = 1;
 	init.flags = CLK_IGNORE_UNUSED;
 
@@ -608,8 +627,10 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	if (ret)
 		goto free_slow_osc_data;
 
+	parent_hws[0] = slow_rc;
+	parent_hws[1] = &osc->hw;
 	slowck = at91_clk_register_sam9x5_slow(regbase, "slowck",
-					       parent_names, 2,
+					       parent_hws, 2,
 					       &at91sama5d4_bits);
 	if (IS_ERR(slowck))
 		goto unregister_slow_osc;
-- 
2.34.1

