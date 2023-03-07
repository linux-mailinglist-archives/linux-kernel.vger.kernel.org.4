Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA506AD5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCGDZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCGDZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:25:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A12457DD;
        Mon,  6 Mar 2023 19:25:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so10694665pjz.1;
        Mon, 06 Mar 2023 19:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678159503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLzZHqL9WDRVGnePjQNNc3Xx0tLOUWtULszDoChdvHo=;
        b=qitAt8ONHvxaW+4QDZDf8in19VNCj+711/6BoEAJA/EFzDAdVrK2uyLAzMjoHhCnAH
         Qj0g8VlxfevB4zYpEIJgPdOyO0L0xpq9AEY1FikfG0lOgVJ0npb1YADT2/pkkFBAMcMc
         d/wu1GcWiVwKPSKoxYR2rQwCLLOSliecSPMJUkcVmVDxUcawN7Xx2xofGR7ROWeQ5lBo
         kD3Cr1X4kEHEAqLWF5FmJxXbkFpnVrukqeBQmP8WRMMVFEor/7d/p2riBUjIuoeDEN3N
         Oizcz2O05Cc+R1euyDbYmTNbNW4RMDkcUu1pFdDDQy8oPMY6NhPeuFtNLbZprGBozv6L
         Lnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678159503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLzZHqL9WDRVGnePjQNNc3Xx0tLOUWtULszDoChdvHo=;
        b=QJLuNcPpj2Rt5UePhMzIWrwjLP5F1lwz41pZHIZzd3xyLbVDE1tADSq1aR/SO4u+5Z
         8qpgLFdOGmzzvaPd98p3ahhUVm3PXyFmrrTo0lPp4XMMTZQZz8BtUocYrT0ufbAHB3Y/
         lPbskei22NGUn5X+3Y/PLWBBqY0kFtGM1DP3igDvt0cjIDqFJv1KwCOn/h7hDpQzEpxy
         r/yVrG/8O9ff8ujLMBrAsxCGCtsMlUIh/9R5p0GS6gsbHVfPt8u1o9bRXjm6nn34nVNL
         8LRS+aiP9imzha8NYm3+qwyM20p9zBg33owKUTqbgVJ9s1yFqwwe6C3ol6FjYSgL8w/j
         CqDQ==
X-Gm-Message-State: AO0yUKUaeaxF5t1zmVD6EyEJMATmTxNcrJo4oOqnV+jePsN6IzNI6Yh+
        weZIMKpyMnqEkkH1z6F2edg=
X-Google-Smtp-Source: AK7set+qWHBXfDcjH7VCXNMQ3EVmJEIdQ3sZKnGuzSUu1uH+oD0QxaGa/ekiH46ex8jhnsSyAb4rkg==
X-Received: by 2002:a17:903:228b:b0:19c:bae2:681a with SMTP id b11-20020a170903228b00b0019cbae2681amr14076042plh.66.1678159502938;
        Mon, 06 Mar 2023 19:25:02 -0800 (PST)
Received: from y.ha.lan ([2a09:bac5:21b4:1246::1d2:a])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b0019a997bca5csm7380022plh.121.2023.03.06.19.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 19:25:02 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] clk: hisilicon: Rename Hi3798CV200 to Hi3798
Date:   Tue,  7 Mar 2023 11:22:35 +0800
Message-Id: <20230307032243.14988-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307032243.14988-1-mmyangfl@gmail.com>
References: <20230307032243.14988-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename Hisilicon Hi3798CV200 to Hi3798, to be reused with other Hi3798
series SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 .../{crg-hi3798cv200.c => crg-hi3798.c}       | 181 +++++++++---------
 3 files changed, 95 insertions(+), 94 deletions(-)
 rename drivers/clk/hisilicon/{crg-hi3798cv200.c => crg-hi3798.c} (68%)

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index c1ec75aa4..fa2d9920f 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -37,13 +37,13 @@ config COMMON_CLK_HI3670
 	help
 	  Build the clock driver for hi3670.
 
-config COMMON_CLK_HI3798CV200
-	tristate "Hi3798CV200 Clock Driver"
+config COMMON_CLK_HI3798
+	tristate "Hi3798 Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
 	select RESET_HISI
 	default ARCH_HISI
 	help
-	  Build the clock driver for hi3798cv200.
+	  Build the clock driver for hi3798.
 
 config COMMON_CLK_HI6220
 	bool "Hi6220 Clock Driver"
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 2978e56cb..cfef47a19 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
 obj-$(CONFIG_COMMON_CLK_HI3559A)	+= clk-hi3559a.o
 obj-$(CONFIG_COMMON_CLK_HI3660) += clk-hi3660.o
 obj-$(CONFIG_COMMON_CLK_HI3670) += clk-hi3670.o
-obj-$(CONFIG_COMMON_CLK_HI3798CV200)	+= crg-hi3798cv200.o
+obj-$(CONFIG_COMMON_CLK_HI3798)	+= crg-hi3798.o
 obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
 obj-$(CONFIG_RESET_HISI)	+= reset.o
 obj-$(CONFIG_STUB_CLK_HI6220)	+= clk-hi6220-stub.o
diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798.c
similarity index 68%
rename from drivers/clk/hisilicon/crg-hi3798cv200.c
rename to drivers/clk/hisilicon/crg-hi3798.c
index 08a19ba77..7e9507de2 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Hi3798CV200 Clock and Reset Generator Driver
+ * Hi3798 Clock and Reset Generator Driver
  *
  * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
  */
@@ -14,75 +14,76 @@
 #include "crg.h"
 #include "reset.h"
 
-/* hi3798CV200 core CRG */
-#define HI3798CV200_INNER_CLK_OFFSET		64
-#define HI3798CV200_FIXED_24M			65
-#define HI3798CV200_FIXED_25M			66
-#define HI3798CV200_FIXED_50M			67
-#define HI3798CV200_FIXED_75M			68
-#define HI3798CV200_FIXED_100M			69
-#define HI3798CV200_FIXED_150M			70
-#define HI3798CV200_FIXED_200M			71
-#define HI3798CV200_FIXED_250M			72
-#define HI3798CV200_FIXED_300M			73
-#define HI3798CV200_FIXED_400M			74
-#define HI3798CV200_MMC_MUX			75
-#define HI3798CV200_ETH_PUB_CLK			76
-#define HI3798CV200_ETH_BUS_CLK			77
-#define HI3798CV200_ETH_BUS0_CLK		78
-#define HI3798CV200_ETH_BUS1_CLK		79
-#define HI3798CV200_COMBPHY1_MUX		80
-#define HI3798CV200_FIXED_12M			81
-#define HI3798CV200_FIXED_48M			82
-#define HI3798CV200_FIXED_60M			83
-#define HI3798CV200_FIXED_166P5M		84
-#define HI3798CV200_SDIO0_MUX			85
-#define HI3798CV200_COMBPHY0_MUX		86
-
-#define HI3798CV200_CRG_NR_CLKS			128
-
-static const struct hisi_fixed_rate_clock hi3798cv200_fixed_rate_clks[] = {
+/* hi3798 core CRG */
+#define HI3798_INNER_CLK_OFFSET		64
+#define HI3798_FIXED_24M			65
+#define HI3798_FIXED_25M			66
+#define HI3798_FIXED_50M			67
+#define HI3798_FIXED_75M			68
+#define HI3798_FIXED_100M			69
+#define HI3798_FIXED_150M			70
+#define HI3798_FIXED_200M			71
+#define HI3798_FIXED_250M			72
+#define HI3798_FIXED_300M			73
+#define HI3798_FIXED_400M			74
+#define HI3798_MMC_MUX			75
+#define HI3798_ETH_PUB_CLK			76
+#define HI3798_ETH_BUS_CLK			77
+#define HI3798_ETH_BUS0_CLK		78
+#define HI3798_ETH_BUS1_CLK		79
+#define HI3798_COMBPHY1_MUX		80
+#define HI3798_FIXED_12M			81
+#define HI3798_FIXED_48M			82
+#define HI3798_FIXED_60M			83
+#define HI3798_FIXED_166P5M		84
+#define HI3798_SDIO0_MUX			85
+#define HI3798_COMBPHY0_MUX		86
+
+#define HI3798_CRG_NR_CLKS			128
+
+static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
 	{ HISTB_AHB_CLK, "clk_ahb", NULL, 0, 200000000, },
-	{ HI3798CV200_FIXED_12M, "12m", NULL, 0, 12000000, },
-	{ HI3798CV200_FIXED_24M, "24m", NULL, 0, 24000000, },
-	{ HI3798CV200_FIXED_25M, "25m", NULL, 0, 25000000, },
-	{ HI3798CV200_FIXED_48M, "48m", NULL, 0, 48000000, },
-	{ HI3798CV200_FIXED_50M, "50m", NULL, 0, 50000000, },
-	{ HI3798CV200_FIXED_60M, "60m", NULL, 0, 60000000, },
-	{ HI3798CV200_FIXED_75M, "75m", NULL, 0, 75000000, },
-	{ HI3798CV200_FIXED_100M, "100m", NULL, 0, 100000000, },
-	{ HI3798CV200_FIXED_150M, "150m", NULL, 0, 150000000, },
-	{ HI3798CV200_FIXED_166P5M, "166p5m", NULL, 0, 165000000, },
-	{ HI3798CV200_FIXED_200M, "200m", NULL, 0, 200000000, },
-	{ HI3798CV200_FIXED_250M, "250m", NULL, 0, 250000000, },
+	{ HI3798_FIXED_12M, "12m", NULL, 0, 12000000, },
+	{ HI3798_FIXED_24M, "24m", NULL, 0, 24000000, },
+	{ HI3798_FIXED_25M, "25m", NULL, 0, 25000000, },
+	{ HI3798_FIXED_48M, "48m", NULL, 0, 48000000, },
+	{ HI3798_FIXED_50M, "50m", NULL, 0, 50000000, },
+	{ HI3798_FIXED_60M, "60m", NULL, 0, 60000000, },
+	{ HI3798_FIXED_75M, "75m", NULL, 0, 75000000, },
+	{ HI3798_FIXED_100M, "100m", NULL, 0, 100000000, },
+	{ HI3798_FIXED_150M, "150m", NULL, 0, 150000000, },
+	{ HI3798_FIXED_166P5M, "166p5m", NULL, 0, 165000000, },
+	{ HI3798_FIXED_200M, "200m", NULL, 0, 200000000, },
+	{ HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
 
-static const char *const mmc_mux_p[] = {
+static const char *const hi3798cv200_mmc_mux_p[] = {
 		"100m", "50m", "25m", "200m", "150m" };
-static u32 mmc_mux_table[] = {0, 1, 2, 3, 6};
+static u32 hi3798cv200_mmc_mux_table[] = {0, 1, 2, 3, 6};
 
-static const char *const comphy_mux_p[] = {
+static const char *const hi3798cv200_comphy_mux_p[] = {
 		"100m", "25m"};
-static u32 comphy_mux_table[] = {2, 3};
+static u32 hi3798cv200_comphy_mux_table[] = {2, 3};
 
-static const char *const sdio_mux_p[] = {
+static const char *const hi3798cv200_sdio_mux_p[] = {
 		"100m", "50m", "150m", "166p5m" };
-static u32 sdio_mux_table[] = {0, 1, 2, 3};
+static u32 hi3798cv200_sdio_mux_table[] = {0, 1, 2, 3};
 
 static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
-	{ HI3798CV200_MMC_MUX, "mmc_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
-		CLK_SET_RATE_PARENT, 0xa0, 8, 3, 0, mmc_mux_table, },
-	{ HI3798CV200_COMBPHY0_MUX, "combphy0_mux",
-		comphy_mux_p, ARRAY_SIZE(comphy_mux_p),
-		CLK_SET_RATE_PARENT, 0x188, 2, 2, 0, comphy_mux_table, },
-	{ HI3798CV200_COMBPHY1_MUX, "combphy1_mux",
-		comphy_mux_p, ARRAY_SIZE(comphy_mux_p),
-		CLK_SET_RATE_PARENT, 0x188, 10, 2, 0, comphy_mux_table, },
-	{ HI3798CV200_SDIO0_MUX, "sdio0_mux", sdio_mux_p,
-		ARRAY_SIZE(sdio_mux_p), CLK_SET_RATE_PARENT,
-		0x9c, 8, 2, 0, sdio_mux_table, },
+	{ HI3798_MMC_MUX, "mmc_mux", hi3798cv200_mmc_mux_p,
+		ARRAY_SIZE(hi3798cv200_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0xa0, 8, 3, 0, hi3798cv200_mmc_mux_table, },
+	{ HI3798_COMBPHY0_MUX, "combphy0_mux", hi3798cv200_comphy_mux_p,
+		ARRAY_SIZE(hi3798cv200_comphy_mux_p), CLK_SET_RATE_PARENT,
+		0x188, 2, 2, 0, hi3798cv200_comphy_mux_table, },
+	{ HI3798_COMBPHY1_MUX, "combphy1_mux", hi3798cv200_comphy_mux_p,
+		ARRAY_SIZE(hi3798cv200_comphy_mux_p), CLK_SET_RATE_PARENT,
+		0x188, 10, 2, 0, hi3798cv200_comphy_mux_table, },
+	{ HI3798_SDIO0_MUX, "sdio0_mux", hi3798cv200_sdio_mux_p,
+		ARRAY_SIZE(hi3798cv200_sdio_mux_p), CLK_SET_RATE_PARENT,
+		0x9c, 8, 2, 0, hi3798cv200_sdio_mux_table, },
 };
 
 static u32 mmc_phase_regvals[] = {0, 1, 2, 3, 4, 5, 6, 7};
@@ -117,7 +118,7 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x70, 0, 0, },
 	/* SDIO */
 	{ HISTB_SDIO0_BIU_CLK, "clk_sdio0_biu", "200m",
-			CLK_SET_RATE_PARENT, 0x9c, 0, 0, },
+		CLK_SET_RATE_PARENT, 0x9c, 0, 0, },
 	{ HISTB_SDIO0_CIU_CLK, "clk_sdio0_ciu", "sdio0_mux",
 		CLK_SET_RATE_PARENT, 0x9c, 1, 0, },
 	/* EMMC */
@@ -135,13 +136,13 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 	{ HISTB_PCIE_AUX_CLK, "clk_pcie_aux", "24m",
 		CLK_SET_RATE_PARENT, 0x18c, 3, 0, },
 	/* Ethernet */
-	{ HI3798CV200_ETH_PUB_CLK, "clk_pub", NULL,
+	{ HI3798_ETH_PUB_CLK, "clk_pub", NULL,
 		CLK_SET_RATE_PARENT, 0xcc, 5, 0, },
-	{ HI3798CV200_ETH_BUS_CLK, "clk_bus", "clk_pub",
+	{ HI3798_ETH_BUS_CLK, "clk_bus", "clk_pub",
 		CLK_SET_RATE_PARENT, 0xcc, 0, 0, },
-	{ HI3798CV200_ETH_BUS0_CLK, "clk_bus_m0", "clk_bus",
+	{ HI3798_ETH_BUS0_CLK, "clk_bus_m0", "clk_bus",
 		CLK_SET_RATE_PARENT, 0xcc, 1, 0, },
-	{ HI3798CV200_ETH_BUS1_CLK, "clk_bus_m1", "clk_bus",
+	{ HI3798_ETH_BUS1_CLK, "clk_bus_m1", "clk_bus",
 		CLK_SET_RATE_PARENT, 0xcc, 2, 0, },
 	{ HISTB_ETH0_MAC_CLK, "clk_mac0", "clk_bus_m0",
 		CLK_SET_RATE_PARENT, 0xcc, 3, 0, },
@@ -199,7 +200,7 @@ static struct hisi_clock_data *hi3798cv200_clk_register(
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_CRG_NR_CLKS);
+	clk_data = hisi_clk_alloc(pdev, HI3798_CRG_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -211,8 +212,8 @@ static struct hisi_clock_data *hi3798cv200_clk_register(
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_fixed_rate(hi3798cv200_fixed_rate_clks,
-				     ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
+	ret = hisi_clk_register_fixed_rate(hi3798_fixed_rate_clks,
+				     ARRAY_SIZE(hi3798_fixed_rate_clks),
 				     clk_data);
 	if (ret)
 		return ERR_PTR(ret);
@@ -245,8 +246,8 @@ static struct hisi_clock_data *hi3798cv200_clk_register(
 				ARRAY_SIZE(hi3798cv200_mux_clks),
 				clk_data);
 unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
+	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
+				ARRAY_SIZE(hi3798_fixed_rate_clks),
 				clk_data);
 	return ERR_PTR(ret);
 }
@@ -263,8 +264,8 @@ static void hi3798cv200_clk_unregister(struct platform_device *pdev)
 	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
 				ARRAY_SIZE(hi3798cv200_mux_clks),
 				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
+	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
+				ARRAY_SIZE(hi3798_fixed_rate_clks),
 				crg->clk_data);
 }
 
@@ -273,9 +274,9 @@ static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
 	.unregister_clks = hi3798cv200_clk_unregister,
 };
 
-/* hi3798CV200 sysctrl CRG */
+/* hi3798 sysctrl CRG */
 
-#define HI3798CV200_SYSCTRL_NR_CLKS 16
+#define HI3798_SYSCTRL_NR_CLKS 16
 
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
@@ -292,7 +293,7 @@ static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_SYSCTRL_NR_CLKS);
+	clk_data = hisi_clk_alloc(pdev, HI3798_SYSCTRL_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -332,16 +333,16 @@ static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
 	.unregister_clks = hi3798cv200_sysctrl_clk_unregister,
 };
 
-static const struct of_device_id hi3798cv200_crg_match_table[] = {
+static const struct of_device_id hi3798_crg_match_table[] = {
 	{ .compatible = "hisilicon,hi3798cv200-crg",
 		.data = &hi3798cv200_crg_funcs },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
 		.data = &hi3798cv200_sysctrl_funcs },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, hi3798cv200_crg_match_table);
+MODULE_DEVICE_TABLE(of, hi3798_crg_match_table);
 
-static int hi3798cv200_crg_probe(struct platform_device *pdev)
+static int hi3798_crg_probe(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg;
 
@@ -367,7 +368,7 @@ static int hi3798cv200_crg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3798cv200_crg_remove(struct platform_device *pdev)
+static int hi3798_crg_remove(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
@@ -376,26 +377,26 @@ static int hi3798cv200_crg_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver hi3798cv200_crg_driver = {
-	.probe          = hi3798cv200_crg_probe,
-	.remove		= hi3798cv200_crg_remove,
-	.driver         = {
-		.name   = "hi3798cv200-crg",
-		.of_match_table = hi3798cv200_crg_match_table,
+static struct platform_driver hi3798_crg_driver = {
+	.probe = hi3798_crg_probe,
+	.remove = hi3798_crg_remove,
+	.driver = {
+		.name = "hi3798-crg",
+		.of_match_table = hi3798_crg_match_table,
 	},
 };
 
-static int __init hi3798cv200_crg_init(void)
+static int __init hi3798_crg_init(void)
 {
-	return platform_driver_register(&hi3798cv200_crg_driver);
+	return platform_driver_register(&hi3798_crg_driver);
 }
-core_initcall(hi3798cv200_crg_init);
+core_initcall(hi3798_crg_init);
 
-static void __exit hi3798cv200_crg_exit(void)
+static void __exit hi3798_crg_exit(void)
 {
-	platform_driver_unregister(&hi3798cv200_crg_driver);
+	platform_driver_unregister(&hi3798_crg_driver);
 }
-module_exit(hi3798cv200_crg_exit);
+module_exit(hi3798_crg_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("HiSilicon Hi3798CV200 CRG Driver");
+MODULE_DESCRIPTION("HiSilicon Hi3798 CRG Driver");
-- 
2.39.2

