Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441D744086
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjF3Q7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjF3Q6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1013C23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so19147175e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144321; x=1690736321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmOMajD2YZSE+eel7VcvLzIVOnwOse/rnS6+x3C70yU=;
        b=FyShIEE8ur0fhetXt5zPzBSidrR54AJP5/e2Lw//yreQyw4erZQfmV8a+V/FjlusBq
         w8I0pbS/rPj775Mz6f2JIvefOIDOXJ5nZDkbsxuiYNYm82CliA0Fe4T5CMTPe+4pj6m9
         H0RAW3JW8o5zTswmguMhgLlexP1RDfrlWXQvTK9/l5rWtLXfmNBGk/eb2PqgKRI0y1Bt
         KCdEqNdhgr5mUpeFZvuyZyhqWLRO8uV6NbbCtwYx3KtXO1iaFUnjCWu61m0zQLORIRua
         P4sHQFpSstj8NE5tkZ8I6XQnGgrW5O+J2M1Pnmihjo/DOXizWAgltrSKlRNBjh2vtCdu
         RD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144321; x=1690736321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmOMajD2YZSE+eel7VcvLzIVOnwOse/rnS6+x3C70yU=;
        b=g9hVOSDysO7MP4gplHyIwa+Y0e5ifUPdim1wlcu0C9Tz6r9VJifNwrSxgh+dm4dG1O
         LMSEJ7tSubnYkgwJs3WPUcZOsAFGDxZSqS7nGNbY3Yij2vJHV1s0xysQjzehuvLjfd3D
         m1xzW+YsalEts85DjEwNDgcFYZBZkfBfOaz+ner03iDuk5zMeCN+N5BmBKjZPQoGsai8
         Rt8JgCN4tfSUT5AgGyQVu+PA7PkUT5SgI/y+ciEe7gKbQMr5f01t7xG5wxWx+WlIUEDH
         jz59qbfWCz1VJPF2+Xz2mTgylzgP3gmU/N3yp8wVC8Ct+VFAmmKQeor5F3xaFEQHQOnN
         8saA==
X-Gm-Message-State: ABy/qLYOWPWNAqCXYHggyfu1hKFx1f15Qwn1SAoIfDc4oqaBKgcbu0x2
        RtmAwnHIhczBQelWv4M22l7vkA==
X-Google-Smtp-Source: APBJJlH+WLO58Dsl5GTbdy9kidf6z2vq4lgBCLoHMljM4mx0veKMawVUIe+m9zc/05aH2be2DXGCOw==
X-Received: by 2002:adf:dc84:0:b0:313:e591:94ec with SMTP id r4-20020adfdc84000000b00313e59194ecmr2412436wrj.67.1688144320967;
        Fri, 30 Jun 2023 09:58:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:40 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:58:28 +0200
Subject: [PATCH v2 03/15] clksource: timer-oxnas-rps: remove obsolete timer
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-3-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9387;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OS+eBvSlx7DwBmhrfLY6QF+vMfbdyLJj8rLmG2ne3WQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm1abamxIw9Q1cu56fLZ7ZrcsS8fTUVPjdmIPHm
 8tI36nqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtQAKCRB33NvayMhJ0Ug+D/
 9iCGhYuRWDonKOcmDlJ5tRofvt7eO4c5xe+WnpQD0GlxL98f4NbqpB+vI+jQ0hBN6gP5apCF2fNze+
 DbTRJZ1XVv44EbFpJ60Hcf95zAF3x4aYpNv0hBC4M/bNZ3FILAkVhPxVxWIIZuaTBNxRmycnLTB10r
 S81L9sUzDXhmHUSjM9XiDMsNf76LOSt6o2/VMz6becHzPBhy27MptVdUdET3CBa2ZSZHSKs32LBE0k
 6L9UJ7QiX3RnZ25PrfUucLceECUeCutDAvoJXB1FMm1tsBBzLK0aQCXLk+b351leW4VJNBoIjgPmj6
 2q0HkmSwAhnLgzEZGQZ/ISzLHj+hrc2fNxfx2Bvxk/mKHDsllz0u9s0FBVI77cGxhoza3yxLv48XZp
 vAw3m46ZiOzFBiaHsnNSCwvP3Y8q6rcTHgHJgUQDV7LkCt6UnNvT9BCXeo/GMHbzthYPIQPlKvTavN
 pP6uCdH3OvGh6d7Z3+k51mL6s0aEEypFNT6RRHnRbWjDLpt9MthqUiJcq9LUIL+0CjKYq8mRR2tTlx
 DCgE0wddZ2pIKF1LpncBc+TiRHtVT/lCOWqwQFb9NeDF49v3HlG9A4jK1oRH7AKsswGD9TluRtbIDi
 euhdRsyZH+fi+P7TeyHZlj5EGlr3kc/MHtKW2fXGj269nr0qVt8PuO2FURyQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 timer.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clocksource/Kconfig           |   7 -
 drivers/clocksource/Makefile          |   1 -
 drivers/clocksource/timer-oxnas-rps.c | 288 ----------------------------------
 3 files changed, 296 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c4d671a5a13d..0ba0dc4ecf06 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -461,13 +461,6 @@ config VF_PIT_TIMER
 	help
 	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
 
-config OXNAS_RPS_TIMER
-	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
-	select TIMER_OF
-	select CLKSRC_MMIO
-	help
-	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
-
 config SYS_SUPPORTS_SH_CMT
 	bool
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5d93c9e3fc55..368c3461dab8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
 obj-$(CONFIG_MTK_CPUX_TIMER)	+= timer-mediatek-cpux.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
-obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
deleted file mode 100644
index d514b44e67dd..000000000000
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ /dev/null
@@ -1,288 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * drivers/clocksource/timer-oxnas-rps.c
- *
- * Copyright (C) 2009 Oxford Semiconductor Ltd
- * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/clockchips.h>
-#include <linux/sched_clock.h>
-
-/* TIMER1 used as tick
- * TIMER2 used as clocksource
- */
-
-/* Registers definitions */
-
-#define TIMER_LOAD_REG		0x0
-#define TIMER_CURR_REG		0x4
-#define TIMER_CTRL_REG		0x8
-#define TIMER_CLRINT_REG	0xC
-
-#define TIMER_BITS		24
-
-#define TIMER_MAX_VAL		(BIT(TIMER_BITS) - 1)
-
-#define TIMER_PERIODIC		BIT(6)
-#define TIMER_ENABLE		BIT(7)
-
-#define TIMER_DIV1		(0)
-#define TIMER_DIV16		(1 << 2)
-#define TIMER_DIV256		(2 << 2)
-
-#define TIMER1_REG_OFFSET	0
-#define TIMER2_REG_OFFSET	0x20
-
-/* Clockevent & Clocksource data */
-
-struct oxnas_rps_timer {
-	struct clock_event_device clkevent;
-	void __iomem *clksrc_base;
-	void __iomem *clkevt_base;
-	unsigned long timer_period;
-	unsigned int timer_prescaler;
-	struct clk *clk;
-	int irq;
-};
-
-static irqreturn_t oxnas_rps_timer_irq(int irq, void *dev_id)
-{
-	struct oxnas_rps_timer *rps = dev_id;
-
-	writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
-
-	rps->clkevent.event_handler(&rps->clkevent);
-
-	return IRQ_HANDLED;
-}
-
-static void oxnas_rps_timer_config(struct oxnas_rps_timer *rps,
-				   unsigned long period,
-				   unsigned int periodic)
-{
-	uint32_t cfg = rps->timer_prescaler;
-
-	if (period)
-		cfg |= TIMER_ENABLE;
-
-	if (periodic)
-		cfg |= TIMER_PERIODIC;
-
-	writel_relaxed(period, rps->clkevt_base + TIMER_LOAD_REG);
-	writel_relaxed(cfg, rps->clkevt_base + TIMER_CTRL_REG);
-}
-
-static int oxnas_rps_timer_shutdown(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, 0, 0);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_set_periodic(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, rps->timer_period, 1);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_set_oneshot(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, rps->timer_period, 0);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, delta, 0);
-
-	return 0;
-}
-
-static int __init oxnas_rps_clockevent_init(struct oxnas_rps_timer *rps)
-{
-	ulong clk_rate = clk_get_rate(rps->clk);
-	ulong timer_rate;
-
-	/* Start with prescaler 1 */
-	rps->timer_prescaler = TIMER_DIV1;
-	rps->timer_period = DIV_ROUND_UP(clk_rate, HZ);
-	timer_rate = clk_rate;
-
-	if (rps->timer_period > TIMER_MAX_VAL) {
-		rps->timer_prescaler = TIMER_DIV16;
-		timer_rate = clk_rate / 16;
-		rps->timer_period = DIV_ROUND_UP(timer_rate, HZ);
-	}
-	if (rps->timer_period > TIMER_MAX_VAL) {
-		rps->timer_prescaler = TIMER_DIV256;
-		timer_rate = clk_rate / 256;
-		rps->timer_period = DIV_ROUND_UP(timer_rate, HZ);
-	}
-
-	rps->clkevent.name = "oxnas-rps";
-	rps->clkevent.features = CLOCK_EVT_FEAT_PERIODIC |
-				 CLOCK_EVT_FEAT_ONESHOT |
-				 CLOCK_EVT_FEAT_DYNIRQ;
-	rps->clkevent.tick_resume = oxnas_rps_timer_shutdown;
-	rps->clkevent.set_state_shutdown = oxnas_rps_timer_shutdown;
-	rps->clkevent.set_state_periodic = oxnas_rps_timer_set_periodic;
-	rps->clkevent.set_state_oneshot = oxnas_rps_timer_set_oneshot;
-	rps->clkevent.set_next_event = oxnas_rps_timer_next_event;
-	rps->clkevent.rating = 200;
-	rps->clkevent.cpumask = cpu_possible_mask;
-	rps->clkevent.irq = rps->irq;
-	clockevents_config_and_register(&rps->clkevent,
-					timer_rate,
-					1,
-					TIMER_MAX_VAL);
-
-	pr_info("Registered clock event rate %luHz prescaler %x period %lu\n",
-			clk_rate,
-			rps->timer_prescaler,
-			rps->timer_period);
-
-	return 0;
-}
-
-/* Clocksource */
-
-static void __iomem *timer_sched_base;
-
-static u64 notrace oxnas_rps_read_sched_clock(void)
-{
-	return ~readl_relaxed(timer_sched_base);
-}
-
-static int __init oxnas_rps_clocksource_init(struct oxnas_rps_timer *rps)
-{
-	ulong clk_rate = clk_get_rate(rps->clk);
-	int ret;
-
-	/* use prescale 16 */
-	clk_rate = clk_rate / 16;
-
-	writel_relaxed(TIMER_MAX_VAL, rps->clksrc_base + TIMER_LOAD_REG);
-	writel_relaxed(TIMER_PERIODIC | TIMER_ENABLE | TIMER_DIV16,
-			rps->clksrc_base + TIMER_CTRL_REG);
-
-	timer_sched_base = rps->clksrc_base + TIMER_CURR_REG;
-	sched_clock_register(oxnas_rps_read_sched_clock,
-			     TIMER_BITS, clk_rate);
-	ret = clocksource_mmio_init(timer_sched_base,
-				    "oxnas_rps_clocksource_timer",
-				    clk_rate, 250, TIMER_BITS,
-				    clocksource_mmio_readl_down);
-	if (WARN_ON(ret)) {
-		pr_err("can't register clocksource\n");
-		return ret;
-	}
-
-	pr_info("Registered clocksource rate %luHz\n", clk_rate);
-
-	return 0;
-}
-
-static int __init oxnas_rps_timer_init(struct device_node *np)
-{
-	struct oxnas_rps_timer *rps;
-	void __iomem *base;
-	int ret;
-
-	rps = kzalloc(sizeof(*rps), GFP_KERNEL);
-	if (!rps)
-		return -ENOMEM;
-
-	rps->clk = of_clk_get(np, 0);
-	if (IS_ERR(rps->clk)) {
-		ret = PTR_ERR(rps->clk);
-		goto err_alloc;
-	}
-
-	ret = clk_prepare_enable(rps->clk);
-	if (ret)
-		goto err_clk;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -ENXIO;
-		goto err_clk_prepare;
-	}
-
-	rps->irq = irq_of_parse_and_map(np, 0);
-	if (!rps->irq) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
-
-	rps->clkevt_base = base + TIMER1_REG_OFFSET;
-	rps->clksrc_base = base + TIMER2_REG_OFFSET;
-
-	/* Disable timers */
-	writel_relaxed(0, rps->clkevt_base + TIMER_CTRL_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_CTRL_REG);
-	writel_relaxed(0, rps->clkevt_base + TIMER_LOAD_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_LOAD_REG);
-	writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_CLRINT_REG);
-
-	ret = request_irq(rps->irq, oxnas_rps_timer_irq,
-			  IRQF_TIMER | IRQF_IRQPOLL,
-			  "rps-timer", rps);
-	if (ret)
-		goto err_iomap;
-
-	ret = oxnas_rps_clocksource_init(rps);
-	if (ret)
-		goto err_irqreq;
-
-	ret = oxnas_rps_clockevent_init(rps);
-	if (ret)
-		goto err_irqreq;
-
-	return 0;
-
-err_irqreq:
-	free_irq(rps->irq, rps);
-err_iomap:
-	iounmap(base);
-err_clk_prepare:
-	clk_disable_unprepare(rps->clk);
-err_clk:
-	clk_put(rps->clk);
-err_alloc:
-	kfree(rps);
-
-	return ret;
-}
-
-TIMER_OF_DECLARE(ox810se_rps,
-		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
-TIMER_OF_DECLARE(ox820_rps,
-		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);

-- 
2.34.1

