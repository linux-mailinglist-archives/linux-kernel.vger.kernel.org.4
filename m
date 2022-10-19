Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868EF604BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJSPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiJSPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BFE1382DF;
        Wed, 19 Oct 2022 08:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE7061844;
        Wed, 19 Oct 2022 15:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F1EC433C1;
        Wed, 19 Oct 2022 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193631;
        bh=EhYrjUc/DoBZ3roznn9+xX9ayHrVyQruDr9liXnBUYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pP0+sw5G+Asb4oQeOQUW8PrFGIZrLr463EQt86L2CtO6s3XutWT6fJbJC2D1yCuub
         wKU/3wWh82RPxXBLbvk+sbeW1sCbdhDrfWW+TkJ5w/bhi1NcjtP7j08+iwhbA64cVP
         g/0TXprEvUqoVxDL1mkwKN9FJ6sJ85uDFH+52KU3aP3Twl86QzIyHEUUkq3xVDbKbc
         6PclTyW9D89Aekn6w1GH2OZJNpykJBM+/hapOdG/Y3d2Rp8aK552iE2GBSsaXK/Wwr
         hPEqWRe9xLHIv2G+M89GG1j+4s9sIm9stAAEUf8B+bifiuVNX+DTBRrhkwkg4f4FFJ
         bfiHzUpuppb6A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH 04/14] clk: remove davinci dm3xx drivers
Date:   Wed, 19 Oct 2022 17:29:30 +0200
Message-Id: <20221019152947.3857217-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The davinci dm3xx machines are all removed, so the clk driver
is no longer needed. The da8xx platforms are now using DT
exclusively, so those drivers remain untouched.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/davinci/Makefile    |   4 -
 drivers/clk/davinci/pll-dm355.c |  77 -----------------
 drivers/clk/davinci/pll-dm365.c | 146 --------------------------------
 drivers/clk/davinci/psc-dm355.c |  89 -------------------
 drivers/clk/davinci/psc-dm365.c | 111 ------------------------
 5 files changed, 427 deletions(-)
 delete mode 100644 drivers/clk/davinci/pll-dm355.c
 delete mode 100644 drivers/clk/davinci/pll-dm365.c
 delete mode 100644 drivers/clk/davinci/psc-dm355.c
 delete mode 100644 drivers/clk/davinci/psc-dm365.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index be6f55d37b49..5d0ae1ee72ec 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -6,12 +6,8 @@ obj-$(CONFIG_ARCH_DAVINCI_DA8XX)	+= da8xx-cfgchip.o
 obj-y += pll.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
-obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
-obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
 
 obj-y += psc.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
-obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
-obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
 endif
diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
deleted file mode 100644
index 505aed80be9a..000000000000
--- a/drivers/clk/davinci/pll-dm355.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PLL clock descriptions for TI DM355
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/bitops.h>
-#include <linux/clk/davinci.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include "pll.h"
-
-static const struct davinci_pll_clk_info dm355_pll1_info = {
-	.name = "pll1",
-	.pllm_mask = GENMASK(7, 0),
-	.pllm_min = 92,
-	.pllm_max = 184,
-	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED |
-		 PLL_PREDIV_FIXED8 | PLL_HAS_POSTDIV |
-		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
-};
-
-SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-
-int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	struct clk *clk;
-
-	davinci_pll_clk_register(dev, &dm355_pll1_info, "ref_clk", base, cfgchip);
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
-	clk_register_clkdev(clk, "pll1_sysclk1", "dm355-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk2, base);
-	clk_register_clkdev(clk, "pll1_sysclk2", "dm355-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk3, base);
-	clk_register_clkdev(clk, "pll1_sysclk3", "dm355-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk4, base);
-	clk_register_clkdev(clk, "pll1_sysclk4", "dm355-psc");
-
-	clk = davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
-	clk_register_clkdev(clk, "pll1_auxclk", "dm355-psc");
-
-	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
-
-	return 0;
-}
-
-static const struct davinci_pll_clk_info dm355_pll2_info = {
-	.name = "pll2",
-	.pllm_mask = GENMASK(7, 0),
-	.pllm_min = 92,
-	.pllm_max = 184,
-	.flags = PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED | PLL_HAS_POSTDIV |
-		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
-};
-
-SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-
-int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base, cfgchip);
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
-
-	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
-
-	return 0;
-}
diff --git a/drivers/clk/davinci/pll-dm365.c b/drivers/clk/davinci/pll-dm365.c
deleted file mode 100644
index 2d29712753a3..000000000000
--- a/drivers/clk/davinci/pll-dm365.c
+++ /dev/null
@@ -1,146 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PLL clock descriptions for TI DM365
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/bitops.h>
-#include <linux/clkdev.h>
-#include <linux/clk/davinci.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "pll.h"
-
-#define OCSEL_OCSRC_ENABLE	0
-
-static const struct davinci_pll_clk_info dm365_pll1_info = {
-	.name = "pll1",
-	.pllm_mask = GENMASK(9, 0),
-	.pllm_min = 1,
-	.pllm_max = 1023,
-	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_HAS_POSTDIV |
-		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_PLLM_2X,
-};
-
-SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(5, pll1_sysclk5, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(6, pll1_sysclk6, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(7, pll1_sysclk7, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(8, pll1_sysclk8, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(9, pll1_sysclk9, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-
-/*
- * This is a bit of a hack to make OCSEL[OCSRC] on DM365 look like OCSEL[OCSRC]
- * on DA850. On DM365, OCSEL[OCSRC] is just an enable/disable bit instead of a
- * multiplexer. By modeling it as a single parent mux clock, the clock code will
- * still do the right thing in this case.
- */
-static const char * const dm365_pll_obsclk_parent_names[] = {
-	"oscin",
-};
-
-static u32 dm365_pll_obsclk_table[] = {
-	OCSEL_OCSRC_ENABLE,
-};
-
-static const struct davinci_pll_obsclk_info dm365_pll1_obsclk_info = {
-	.name = "pll1_obsclk",
-	.parent_names = dm365_pll_obsclk_parent_names,
-	.num_parents = ARRAY_SIZE(dm365_pll_obsclk_parent_names),
-	.table = dm365_pll_obsclk_table,
-	.ocsrc_mask = BIT(4),
-};
-
-int dm365_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	struct clk *clk;
-
-	davinci_pll_clk_register(dev, &dm365_pll1_info, "ref_clk", base, cfgchip);
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
-	clk_register_clkdev(clk, "pll1_sysclk1", "dm365-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk2, base);
-	clk_register_clkdev(clk, "pll1_sysclk2", "dm365-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk3, base);
-	clk_register_clkdev(clk, "pll1_sysclk3", "dm365-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk4, base);
-	clk_register_clkdev(clk, "pll1_sysclk4", "dm365-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk5, base);
-	clk_register_clkdev(clk, "pll1_sysclk5", "dm365-psc");
-
-	davinci_pll_sysclk_register(dev, &pll1_sysclk6, base);
-
-	davinci_pll_sysclk_register(dev, &pll1_sysclk7, base);
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk8, base);
-	clk_register_clkdev(clk, "pll1_sysclk8", "dm365-psc");
-
-	davinci_pll_sysclk_register(dev, &pll1_sysclk9, base);
-
-	clk = davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
-	clk_register_clkdev(clk, "pll1_auxclk", "dm355-psc");
-
-	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
-
-	davinci_pll_obsclk_register(dev, &dm365_pll1_obsclk_info, base);
-
-	return 0;
-}
-
-static const struct davinci_pll_clk_info dm365_pll2_info = {
-	.name = "pll2",
-	.pllm_mask = GENMASK(9, 0),
-	.pllm_min = 1,
-	.pllm_max = 1023,
-	.flags = PLL_HAS_PREDIV | PLL_HAS_POSTDIV | PLL_POSTDIV_ALWAYS_ENABLED |
-		 PLL_PLLM_2X,
-};
-
-SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(2, pll2_sysclk2, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(3, pll2_sysclk3, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(4, pll2_sysclk4, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(5, pll2_sysclk5, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED);
-
-static const struct davinci_pll_obsclk_info dm365_pll2_obsclk_info = {
-	.name = "pll2_obsclk",
-	.parent_names = dm365_pll_obsclk_parent_names,
-	.num_parents = ARRAY_SIZE(dm365_pll_obsclk_parent_names),
-	.table = dm365_pll_obsclk_table,
-	.ocsrc_mask = BIT(4),
-};
-
-int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	struct clk *clk;
-
-	davinci_pll_clk_register(dev, &dm365_pll2_info, "oscin", base, cfgchip);
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
-
-	clk = davinci_pll_sysclk_register(dev, &pll2_sysclk2, base);
-	clk_register_clkdev(clk, "pll1_sysclk2", "dm365-psc");
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk3, base);
-
-	clk = davinci_pll_sysclk_register(dev, &pll2_sysclk4, base);
-	clk_register_clkdev(clk, "pll1_sysclk4", "dm365-psc");
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk5, base);
-
-	davinci_pll_auxclk_register(dev, "pll2_auxclk", base);
-
-	davinci_pll_obsclk_register(dev, &dm365_pll2_obsclk_info, base);
-
-	return 0;
-}
diff --git a/drivers/clk/davinci/psc-dm355.c b/drivers/clk/davinci/psc-dm355.c
deleted file mode 100644
index ddd250107c4e..000000000000
--- a/drivers/clk/davinci/psc-dm355.c
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PSC clock descriptions for TI DaVinci DM355
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/clk/davinci.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "psc.h"
-
-LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
-LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
-LPSC_CLKDEV1(spi1_clkdev,		NULL,		"spi_davinci.1");
-LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"dm6441-mmc.1");
-LPSC_CLKDEV1(mcbsp1_clkdev,		NULL,		"davinci-mcbsp.1");
-LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
-LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
-LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
-LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"dm6441-mmc.0");
-LPSC_CLKDEV1(mcbsp0_clkdev,		NULL,		"davinci-mcbsp.0");
-LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
-LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
-LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
-LPSC_CLKDEV1(uart2_clkdev,		NULL,		"serial8250.2");
-LPSC_CLKDEV1(spi0_clkdev,		NULL,		"spi_davinci.0");
-/* REVISIT: gpio-davinci.c should be modified to drop con_id */
-LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
-LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
-LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
-LPSC_CLKDEV1(vpss_dac_clkdev,		"vpss_dac",	NULL);
-
-static const struct davinci_lpsc_clk_info dm355_psc_info[] = {
-	LPSC(0,  0, vpss_master, pll1_sysclk4, vpss_master_clkdev, 0),
-	LPSC(1,  0, vpss_slave,  pll1_sysclk4, vpss_slave_clkdev,  0),
-	LPSC(5,  0, timer3,      pll1_auxclk,  NULL,               0),
-	LPSC(6,  0, spi1,        pll1_sysclk2, spi1_clkdev,        0),
-	LPSC(7,  0, mmcsd1,      pll1_sysclk2, mmcsd1_clkdev,      0),
-	LPSC(8,  0, asp1,        pll1_sysclk2, mcbsp1_clkdev,      0),
-	LPSC(9,  0, usb,         pll1_sysclk2, usb_clkdev,         0),
-	LPSC(10, 0, pwm3,        pll1_auxclk,  NULL,               0),
-	LPSC(11, 0, spi2,        pll1_sysclk2, spi2_clkdev,        0),
-	LPSC(12, 0, rto,         pll1_auxclk,  NULL,               0),
-	LPSC(14, 0, aemif,       pll1_sysclk2, aemif_clkdev,       0),
-	LPSC(15, 0, mmcsd0,      pll1_sysclk2, mmcsd0_clkdev,      0),
-	LPSC(17, 0, asp0,        pll1_sysclk2, mcbsp0_clkdev,      0),
-	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
-	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
-	LPSC(20, 0, uart1,       pll1_auxclk,  uart1_clkdev,       0),
-	LPSC(21, 0, uart2,       pll1_sysclk2, uart2_clkdev,       0),
-	LPSC(22, 0, spi0,        pll1_sysclk2, spi0_clkdev,        0),
-	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
-	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
-	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
-	LPSC(26, 0, gpio,        pll1_sysclk2, gpio_clkdev,        0),
-	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      LPSC_ALWAYS_ENABLED),
-	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
-	/* REVISIT: why can't this be disabled? */
-	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,      LPSC_ALWAYS_ENABLED),
-	LPSC(31, 0, arm,         pll1_sysclk1, NULL,               LPSC_ALWAYS_ENABLED),
-	LPSC(40, 0, mjcp,        pll1_sysclk1, NULL,               0),
-	LPSC(41, 0, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
-	{ }
-};
-
-int dm355_psc_init(struct device *dev, void __iomem *base)
-{
-	return davinci_psc_register_clocks(dev, dm355_psc_info, 42, base);
-}
-
-static struct clk_bulk_data dm355_psc_parent_clks[] = {
-	{ .id = "pll1_sysclk1" },
-	{ .id = "pll1_sysclk2" },
-	{ .id = "pll1_sysclk3" },
-	{ .id = "pll1_sysclk4" },
-	{ .id = "pll1_auxclk"  },
-};
-
-const struct davinci_psc_init_data dm355_psc_init_data = {
-	.parent_clks		= dm355_psc_parent_clks,
-	.num_parent_clks	= ARRAY_SIZE(dm355_psc_parent_clks),
-	.psc_init		= &dm355_psc_init,
-};
diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
deleted file mode 100644
index c75424f4ea3b..000000000000
--- a/drivers/clk/davinci/psc-dm365.c
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PSC clock descriptions for TI DaVinci DM365
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/clk/davinci.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "psc.h"
-
-LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
-LPSC_CLKDEV1(spi1_clkdev,		NULL,		"spi_davinci.1");
-LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"da830-mmc.1");
-LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
-LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
-LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
-LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
-					NULL,		"ti-aemif");
-LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"da830-mmc.0");
-LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
-LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
-LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
-LPSC_CLKDEV1(spi0_clkdev,		NULL,		"spi_davinci.0");
-/* REVISIT: gpio-davinci.c should be modified to drop con_id */
-LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
-LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
-LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
-LPSC_CLKDEV1(spi3_clkdev,		NULL,		"spi_davinci.3");
-LPSC_CLKDEV1(spi4_clkdev,		NULL,		"spi_davinci.4");
-LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
-					"fck",		"davinci_mdio.0");
-LPSC_CLKDEV1(voice_codec_clkdev,	NULL,		"davinci_voicecodec");
-LPSC_CLKDEV1(vpss_dac_clkdev,		"vpss_dac",	NULL);
-LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
-
-static const struct davinci_lpsc_clk_info dm365_psc_info[] = {
-	LPSC(1,  0, vpss_slave,  pll1_sysclk5, vpss_slave_clkdev,  0),
-	LPSC(5,  0, timer3,      pll1_auxclk,  NULL,               0),
-	LPSC(6,  0, spi1,        pll1_sysclk4, spi1_clkdev,        0),
-	LPSC(7,  0, mmcsd1,      pll1_sysclk4, mmcsd1_clkdev,      0),
-	LPSC(8,  0, asp0,        pll1_sysclk4, asp0_clkdev,        0),
-	LPSC(9,  0, usb,         pll1_auxclk,  usb_clkdev,         0),
-	LPSC(10, 0, pwm3,        pll1_auxclk,  NULL,               0),
-	LPSC(11, 0, spi2,        pll1_sysclk4, spi2_clkdev,        0),
-	LPSC(12, 0, rto,         pll1_sysclk4, NULL,               0),
-	LPSC(14, 0, aemif,       pll1_sysclk4, aemif_clkdev,       0),
-	LPSC(15, 0, mmcsd0,      pll1_sysclk8, mmcsd0_clkdev,      0),
-	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
-	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
-	LPSC(20, 0, uart1,       pll1_sysclk4, uart1_clkdev,       0),
-	LPSC(22, 0, spi0,        pll1_sysclk4, spi0_clkdev,        0),
-	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
-	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
-	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
-	LPSC(26, 0, gpio,        pll1_sysclk4, gpio_clkdev,        0),
-	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      LPSC_ALWAYS_ENABLED),
-	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
-	/* REVISIT: why can't this be disabled? */
-	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,      LPSC_ALWAYS_ENABLED),
-	LPSC(31, 0, arm,         pll2_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
-	LPSC(38, 0, spi3,        pll1_sysclk4, spi3_clkdev,        0),
-	LPSC(39, 0, spi4,        pll1_auxclk,  spi4_clkdev,        0),
-	LPSC(40, 0, emac,        pll1_sysclk4, emac_clkdev,        0),
-	/*
-	 * The TRM (ARM Subsystem User's Guide) shows two clocks input into
-	 * voice codec module (PLL2 SYSCLK4 with a DIV2 and PLL1 SYSCLK4). Its
-	 * not fully clear from documentation which clock should be considered
-	 * as parent for PSC. The clock chosen here is to maintain
-	 * compatibility with existing code in arch/arm/mach-davinci/dm365.c
-	 */
-	LPSC(44, 0, voice_codec, pll2_sysclk4, voice_codec_clkdev, 0),
-	/*
-	 * Its not fully clear from TRM (ARM Subsystem User's Guide) as to what
-	 * the parent of VPSS DAC LPSC should actually be. PLL1 SYSCLK3 feeds
-	 * into HDVICP and MJCP. The clock chosen here is to remain compatible
-	 * with code existing in arch/arm/mach-davinci/dm365.c
-	 */
-	LPSC(46, 0, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
-	LPSC(47, 0, vpss_master, pll1_sysclk5, vpss_master_clkdev, 0),
-	LPSC(50, 0, mjcp,        pll1_sysclk3, NULL,               0),
-	{ }
-};
-
-int dm365_psc_init(struct device *dev, void __iomem *base)
-{
-	return davinci_psc_register_clocks(dev, dm365_psc_info, 52, base);
-}
-
-static struct clk_bulk_data dm365_psc_parent_clks[] = {
-	{ .id = "pll1_sysclk1" },
-	{ .id = "pll1_sysclk3" },
-	{ .id = "pll1_sysclk4" },
-	{ .id = "pll1_sysclk5" },
-	{ .id = "pll1_sysclk8" },
-	{ .id = "pll2_sysclk2" },
-	{ .id = "pll2_sysclk4" },
-	{ .id = "pll1_auxclk"  },
-};
-
-const struct davinci_psc_init_data dm365_psc_init_data = {
-	.parent_clks		= dm365_psc_parent_clks,
-	.num_parent_clks	= ARRAY_SIZE(dm365_psc_parent_clks),
-	.psc_init		= &dm365_psc_init,
-};
-- 
2.29.2

