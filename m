Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DE721245
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFCUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjFCUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:06:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E41E79;
        Sat,  3 Jun 2023 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685822746; x=1717358746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1vZxGX1bQbKSfZcKlrfvcDK8ijv8cWPUwImYu7FhdA=;
  b=E5MOIDfyg9X+PHynpO7f/1V9xQK8+Ka19uJbPq9kGESgd38kJ8upd6FH
   HjXm+jwZO09zWFvBXs837o8swoOb5oERWLOgN7/57SEtiQTKvP0r9gwkr
   Cmb/eMgVsCg+iEOJNh57GmZRrvnODrnoQzf0PVy2Svz00td5SiRHBZN+O
   KcGFeUODGN458krF4BgWF29K4rmtZ02yt2g+Xk2jekVnKk0rLrsg7gT0J
   ONR6+lBoRuQXI5zFEt05VgBwRkP9WDSSQEQyG6JmpMkv8WsoTTnRrq6kr
   lTU9ihvleIsocTfgyJpt3r/ljMM2oLsYeLgefp0VpcUIH+CNkDrcWnGIq
   w==;
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="214485442"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jun 2023 13:05:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 3 Jun 2023 13:05:43 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sat, 3 Jun 2023 13:05:31 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <sre@kernel.org>,
        <broonie@kernel.org>, <varshini.rajendran@microchip.com>,
        <arnd@arndb.de>, <gregory.clement@bootlin.com>,
        <sudeep.holla@arm.com>, <balamanikandan.gunasundar@microchip.com>,
        <mihai.sain@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <Hari.PrasathGE@microchip.com>, <cristian.birsan@microchip.com>,
        <durai.manickamkr@microchip.com>, <manikandan.m@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>
Subject: [PATCH 12/21] clk: at91: clk-sam9x60-pll: re-factor to support individual core freq outputs
Date:   Sun, 4 Jun 2023 01:32:34 +0530
Message-ID: <20230603200243.243878-13-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230603200243.243878-1-varshini.rajendran@microchip.com>
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Support SoCs with different core frequency outputs for different PLL IDs
by adding a separate parameter for handling the same in the PLL driver
-Align sam9x60 and sama7g5 Soc PMC driver to PLL driver by adding core
output freq range in the PLL characteristics configurations

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 12 ++++++------
 drivers/clk/at91/pmc.h             |  1 +
 drivers/clk/at91/sam9x60.c         |  7 +++++++
 drivers/clk/at91/sama7g5.c         |  7 +++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 0882ed01d5c2..b3012641214c 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -23,9 +23,6 @@
 #define UPLL_DIV		2
 #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
 
-#define FCORE_MIN		(600000000)
-#define FCORE_MAX		(1200000000)
-
 #define PLL_MAX_ID		7
 
 struct sam9x60_pll_core {
@@ -194,7 +191,8 @@ static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
 	unsigned long nmul = 0;
 	unsigned long nfrac = 0;
 
-	if (rate < FCORE_MIN || rate > FCORE_MAX)
+	if (rate < core->characteristics->core_output[0].min ||
+	    rate > core->characteristics->core_output[0].max)
 		return -ERANGE;
 
 	/*
@@ -214,7 +212,8 @@ static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
 	}
 
 	/* Check if resulted rate is a valid.  */
-	if (tmprate < FCORE_MIN || tmprate > FCORE_MAX)
+	if (tmprate < core->characteristics->core_output[0].min ||
+	    tmprate > core->characteristics->core_output[0].max)
 		return -ERANGE;
 
 	if (update) {
@@ -666,7 +665,8 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			goto free;
 		}
 
-		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
+		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core,
+							characteristics->core_output[0].min,
 							parent_rate, true);
 		if (ret < 0) {
 			hw = ERR_PTR(ret);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 1b3ca7dd9b57..3e36dcc464c1 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -75,6 +75,7 @@ struct clk_pll_characteristics {
 	struct clk_range input;
 	int num_output;
 	const struct clk_range *output;
+	const struct clk_range *core_output;
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index ac070db58195..452ad45cf251 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -26,10 +26,16 @@ static const struct clk_range plla_outputs[] = {
 	{ .min = 2343750, .max = 1200000000 },
 };
 
+/* Fractional PLL core output range. */
+static const struct clk_range core_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
 static const struct clk_pll_characteristics plla_characteristics = {
 	.input = { .min = 12000000, .max = 48000000 },
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
+	.core_output = core_outputs,
 };
 
 static const struct clk_range upll_outputs[] = {
@@ -40,6 +46,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.input = { .min = 12000000, .max = 48000000 },
 	.num_output = ARRAY_SIZE(upll_outputs),
 	.output = upll_outputs,
+	.core_output = core_outputs,
 	.upll = true,
 };
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index f135b662f1ff..468a3c5449b5 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -104,11 +104,17 @@ static const struct clk_range pll_outputs[] = {
 	{ .min = 2343750, .max = 1200000000 },
 };
 
+/* Fractional PLL core output range. */
+static const struct clk_range core_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
 /* CPU PLL characteristics. */
 static const struct clk_pll_characteristics cpu_pll_characteristics = {
 	.input = { .min = 12000000, .max = 50000000 },
 	.num_output = ARRAY_SIZE(cpu_pll_outputs),
 	.output = cpu_pll_outputs,
+	.core_output = core_outputs,
 };
 
 /* PLL characteristics. */
@@ -116,6 +122,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.input = { .min = 12000000, .max = 50000000 },
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
+	.core_output = core_outputs,
 };
 
 /*
-- 
2.25.1

