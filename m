Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04F86909EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBIN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjBIN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:28:17 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D75EBE6;
        Thu,  9 Feb 2023 05:28:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id iz19so1419234plb.13;
        Thu, 09 Feb 2023 05:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmKNB364VpXNxLSlk2WwT0hBcIoK+MM60GR5nBv3Xp4=;
        b=NeGG4i+CI/rmtxkh/HhxFQMP4lE6pEzzDF058C7V/Ooz3fEUJ69EY324iwd03+BMsw
         Ncnv4gqFbKT5T0BMXZ7HoXHdHWU+hrGoxSZT+po7yze7H3qoTENeLV9OKEyuApgVD0wQ
         m2CngiUXTSUDz117Geb3UG5jM31E0BAYlRhF0tZk5gfT1+HxcXDrjrAVBBLFj3+VfXTz
         oFslG1L+qDGdWLvd9R9sz62EXxEqV6LpO6m1NW/vghH9RMQx/PXxtfipjkb7Qd1rqmPj
         PRdxvuFVqujgqG16Cxd2cKolQFEf5C8jsRXYBtGEICk6IsFApd2/o35xmMjl1Mq2GLYR
         Nmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmKNB364VpXNxLSlk2WwT0hBcIoK+MM60GR5nBv3Xp4=;
        b=WeNUtGS53t5yYuieYzs9XodyzUmyZmEcnHvPbTicvaOjnzBcNs++rRXR3ZpgxFLgBQ
         RWlr3C1dSz4D5XgDeqC20NYLtZZIFur+2cl8YfcS8qo7+oPoIFvKVI0hpkJY1S+DuO2K
         kFmLc9aaDoz5Zx0pAHFmoI7/O5H0WRPh+tHxiIXMaOxPdfKNX7rvAuYIOu/Na8zMFLm3
         pYxYfhHEJHnKGNsxfE09LeGKjK72ObxxCsv8VfXjgFMLbElAi+e+heBeErGyviGdJOq0
         T1ctTOXANrTPfpqusuIHZgvzJ1Z4pRCp7ZX86zUNqwZ+YkIoTtmZHk4hpzQtabf4F1lm
         fIDg==
X-Gm-Message-State: AO0yUKWtLni75sXvGaVT2EeVoIQwp20dHcXUp34LqS2CYLcByBNvja4l
        M836mi7mYM3Qb7tpt3ANdZJDJ/jsC/kI7w==
X-Google-Smtp-Source: AK7set82xaLh8AvXPszU36FKE3b8ywara494sq5tfb3bmF44VUmjiKa5JkowOAhXjC8AWcurmQ09xg==
X-Received: by 2002:a17:903:4101:b0:19a:5a2c:31a9 with SMTP id r1-20020a170903410100b0019a5a2c31a9mr1870836pld.2.1675949294710;
        Thu, 09 Feb 2023 05:28:14 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019339f3368asm1493972plp.3.2023.02.09.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:28:14 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V2 2/3] clk: loongson1: Remove the outdated driver
Date:   Thu,  9 Feb 2023 21:26:13 +0800
Message-Id: <20230209132614.1079198-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209132614.1079198-1-keguang.zhang@gmail.com>
References: <20230209132614.1079198-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the outdated driver due to the following aspects.
- no DT support
- duplicate code across LS1B and LS1C
- does not fit into the current clock framework

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Split the driver removal to a separate patch
---
 drivers/clk/Makefile                   |   1 -
 drivers/clk/loongson1/Makefile         |   4 -
 drivers/clk/loongson1/clk-loongson1b.c | 118 -------------------------
 drivers/clk/loongson1/clk-loongson1c.c |  95 --------------------
 drivers/clk/loongson1/clk.c            |  41 ---------
 drivers/clk/loongson1/clk.h            |  15 ----
 6 files changed, 274 deletions(-)
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..b7b2c6d64636 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -93,7 +93,6 @@ obj-y					+= imx/
 obj-y					+= ingenic/
 obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
-obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
 obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-y					+= microchip/
diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
deleted file mode 100644
index 251d0fe9dcd1..000000000000
--- a/drivers/clk/loongson1/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y				+= clk.o
-obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
-obj-$(CONFIG_LOONGSON1_LS1C)	+= clk-loongson1c.o
diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
deleted file mode 100644
index 13a2ca23a159..000000000000
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ /dev/null
@@ -1,118 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/err.h>
-
-#include <loongson1.h>
-#include "clk.h"
-
-#define OSC		(33 * 1000000)
-#define DIV_APB		2
-
-static DEFINE_SPINLOCK(_lock);
-
-static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
-					  unsigned long parent_rate)
-{
-	u32 pll, rate;
-
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = 12 + (pll & GENMASK(5, 0));
-	rate *= OSC;
-	rate >>= 1;
-
-	return rate;
-}
-
-static const struct clk_ops ls1x_pll_clk_ops = {
-	.recalc_rate = ls1x_pll_recalc_rate,
-};
-
-static const char *const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
-static const char *const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
-static const char *const dc_parents[] = { "dc_clk_div", "osc_clk", };
-
-void __init ls1x_clk_init(void)
-{
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_clk", NULL);
-
-	/* clock derived from 33 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
-				 &ls1x_pll_clk_ops, 0);
-	clk_hw_register_clkdev(hw, "pll_clk", NULL);
-
-	/* clock derived from PLL clk */
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ CPU CLK
-	 *        \___ PLL ___ CPU DIV ___|     |
-	 *                                |_____|
-	 */
-	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
-				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
-				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "cpu_clk", cpu_parents,
-			       ARRAY_SIZE(cpu_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
-
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ DC  CLK
-	 *        \___ PLL ___ DC  DIV ___|     |
-	 *                                |_____|
-	 */
-	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "dc_clk", dc_parents,
-			       ARRAY_SIZE(dc_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk", NULL);
-
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ DDR CLK
-	 *        \___ PLL ___ DDR DIV ___|     |
-	 *                                |_____|
-	 */
-	hw = clk_hw_register_divider(NULL, "ahb_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
-				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
-				   &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "ahb_clk", ahb_parents,
-			       ARRAY_SIZE(ahb_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
-	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
-
-	/* clock derived from AHB clk */
-	/* APB clk is always half of the AHB clk */
-	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
-					DIV_APB);
-	clk_hw_register_clkdev(hw, "apb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
-	clk_hw_register_clkdev(hw, "serial8250", NULL);
-}
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
deleted file mode 100644
index 1ebf740380ef..000000000000
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
- */
-
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-
-#include <loongson1.h>
-#include "clk.h"
-
-#define OSC		(24 * 1000000)
-#define DIV_APB		1
-
-static DEFINE_SPINLOCK(_lock);
-
-static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
-					  unsigned long parent_rate)
-{
-	u32 pll, rate;
-
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
-	rate *= OSC;
-	rate >>= 2;
-
-	return rate;
-}
-
-static const struct clk_ops ls1x_pll_clk_ops = {
-	.recalc_rate = ls1x_pll_recalc_rate,
-};
-
-static const struct clk_div_table ahb_div_table[] = {
-	[0] = { .val = 0, .div = 2 },
-	[1] = { .val = 1, .div = 4 },
-	[2] = { .val = 2, .div = 3 },
-	[3] = { .val = 3, .div = 3 },
-	[4] = { /* sentinel */ }
-};
-
-void __init ls1x_clk_init(void)
-{
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_clk", NULL);
-
-	/* clock derived from 24 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
-				&ls1x_pll_clk_ops, 0);
-	clk_hw_register_clkdev(hw, "pll_clk", NULL);
-
-	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
-				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
-				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
-
-	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "dc_clk", "dc_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "dc_clk", NULL);
-
-	hw = clk_hw_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
-				0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
-				DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
-				ahb_div_table, &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
-	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
-
-	/* clock derived from AHB clk */
-	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
-					DIV_APB);
-	clk_hw_register_clkdev(hw, "apb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
-	clk_hw_register_clkdev(hw, "serial8250", NULL);
-}
diff --git a/drivers/clk/loongson1/clk.c b/drivers/clk/loongson1/clk.c
deleted file mode 100644
index f336a3126d31..000000000000
--- a/drivers/clk/loongson1/clk.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/slab.h>
-
-#include "clk.h"
-
-struct clk_hw *__init clk_hw_register_pll(struct device *dev,
-					  const char *name,
-					  const char *parent_name,
-					  const struct clk_ops *ops,
-					  unsigned long flags)
-{
-	int ret;
-	struct clk_hw *hw;
-	struct clk_init_data init;
-
-	/* allocate the divider */
-	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
-	if (!hw)
-		return ERR_PTR(-ENOMEM);
-
-	init.name = name;
-	init.ops = ops;
-	init.flags = flags;
-	init.parent_names = parent_name ? &parent_name : NULL;
-	init.num_parents = parent_name ? 1 : 0;
-	hw->init = &init;
-
-	/* register the clock */
-	ret = clk_hw_register(dev, hw);
-	if (ret) {
-		kfree(hw);
-		hw = ERR_PTR(ret);
-	}
-
-	return hw;
-}
diff --git a/drivers/clk/loongson1/clk.h b/drivers/clk/loongson1/clk.h
deleted file mode 100644
index 124642302b12..000000000000
--- a/drivers/clk/loongson1/clk.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#ifndef __LOONGSON1_CLK_H
-#define __LOONGSON1_CLK_H
-
-struct clk_hw *clk_hw_register_pll(struct device *dev,
-				   const char *name,
-				   const char *parent_name,
-				   const struct clk_ops *ops,
-				   unsigned long flags);
-
-#endif /* __LOONGSON1_CLK_H */
-- 
2.34.1

