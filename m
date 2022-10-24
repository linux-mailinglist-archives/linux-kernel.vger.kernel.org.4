Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84BF60B875
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiJXTqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiJXTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:43:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B1CF1A4;
        Mon, 24 Oct 2022 11:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F76CB81203;
        Mon, 24 Oct 2022 15:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BD6C433D7;
        Mon, 24 Oct 2022 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625920;
        bh=pQKambcMoMCDDOPbMIokIUA6JiYO5icPGAl1zr7IYUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzlG6zbKejGSByvSyoIJktSpkAFmsQmAEiwKNH+baRdNCJ4TgY2aOzV60kpH8lGRF
         Bj6wziA8G9SVpl+NQwyD/cDaUBPlMD/lTXIJgkOOSqKwzqKDnO0VUQdctPP6AYwI4J
         k67DIitqYGlHcySOvzXWbdoInHwQQaQCIhIq/uNGqL1IgnNh+g2VdoUplwX6lXG1eO
         /7Bx7A7/MBmQIJjb1saNQrRU01Ogcp7WtakOgVZoCA6+Ufp8upF2cUnQeDGviurRwu
         ckhx9TMZ9UrtE2Oe5eAgcX1+qKcZhW9viKhV+pXSssD4BPZt/ngKEojQh6P3ls9E0o
         I8dNPIBgAA2Iw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/10] ARM: omap2: remove unused omap2_pm_init
Date:   Mon, 24 Oct 2022 17:38:13 +0200
Message-Id: <20221024153814.254652-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The omap2420_init_late() and omap2430_init_late() functions
are never called. Removing them also shows that the entire
arch/arm/mach-omap2/pm24xx.c file is unused and can be
removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Makefile |   1 -
 arch/arm/mach-omap2/common.h |   9 -
 arch/arm/mach-omap2/io.c     |  10 --
 arch/arm/mach-omap2/pm24xx.c | 312 -----------------------------------
 4 files changed, 332 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/pm24xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 43b44e0858c1..daf21127c82f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -80,7 +80,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 omap-4-5-pm-common			+= pm44xx.o
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 112e7966107c..ebf0266e1943 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -44,15 +44,6 @@
 extern int (*omap_pm_soc_init)(void);
 int omap_pm_nop_init(void);
 
-#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP2)
-int omap2_pm_init(void);
-#else
-static inline int omap2_pm_init(void)
-{
-	return 0;
-}
-#endif
-
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
 int omap3_pm_init(void);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e45a3ce97085..81cb175c2dbe 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -435,11 +435,6 @@ void __init omap2420_init_early(void)
 	omap_clk_soc_init = omap2420_dt_clk_init;
 	rate_table = omap2420_rate_table;
 }
-
-void __init omap2420_init_late(void)
-{
-	omap_pm_soc_init = omap2_pm_init;
-}
 #endif
 
 #ifdef CONFIG_SOC_OMAP2430
@@ -459,11 +454,6 @@ void __init omap2430_init_early(void)
 	omap_clk_soc_init = omap2430_dt_clk_init;
 	rate_table = omap2430_rate_table;
 }
-
-void __init omap2430_init_late(void)
-{
-	omap_pm_soc_init = omap2_pm_init;
-}
 #endif
 
 /*
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
deleted file mode 100644
index 6953c47d8dc6..000000000000
--- a/arch/arm/mach-omap2/pm24xx.c
+++ /dev/null
@@ -1,312 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * OMAP2 Power Management Routines
- *
- * Copyright (C) 2005 Texas Instruments, Inc.
- * Copyright (C) 2006-2008 Nokia Corporation
- *
- * Written by:
- * Richard Woodruff <r-woodruff2@ti.com>
- * Tony Lindgren
- * Juha Yrjola
- * Amit Kucheria <amit.kucheria@nokia.com>
- * Igor Stoppa <igor.stoppa@nokia.com>
- *
- * Based on pm.c for omap1
- */
-
-#include <linux/cpu_pm.h>
-#include <linux/suspend.h>
-#include <linux/sched.h>
-#include <linux/proc_fs.h>
-#include <linux/interrupt.h>
-#include <linux/sysfs.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/irq.h>
-#include <linux/time.h>
-
-#include <asm/fncpy.h>
-
-#include <asm/mach/time.h>
-#include <asm/mach/irq.h>
-#include <asm/mach-types.h>
-#include <asm/system_misc.h>
-
-#include <linux/omap-dma.h>
-
-#include "soc.h"
-#include "common.h"
-#include "clock.h"
-#include "prm2xxx.h"
-#include "prm-regbits-24xx.h"
-#include "cm2xxx.h"
-#include "cm-regbits-24xx.h"
-#include "sdrc.h"
-#include "sram.h"
-#include "pm.h"
-#include "control.h"
-#include "powerdomain.h"
-#include "clockdomain.h"
-
-static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
-				  void __iomem *sdrc_power);
-
-static struct powerdomain *mpu_pwrdm, *core_pwrdm;
-static struct clockdomain *dsp_clkdm, *mpu_clkdm, *wkup_clkdm, *gfx_clkdm;
-
-static struct clk *osc_ck, *emul_ck;
-
-static int omap2_enter_full_retention(void)
-{
-	u32 l;
-
-	/* There is 1 reference hold for all children of the oscillator
-	 * clock, the following will remove it. If no one else uses the
-	 * oscillator itself it will be disabled if/when we enter retention
-	 * mode.
-	 */
-	clk_disable(osc_ck);
-
-	/* Clear old wake-up events */
-	/* REVISIT: These write to reserved bits? */
-	omap_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
-	omap_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
-	omap_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
-
-	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
-
-	/* Workaround to kill USB */
-	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
-	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
-
-	/* One last check for pending IRQs to avoid extra latency due
-	 * to sleeping unnecessarily. */
-	if (omap_irq_pending())
-		goto no_sleep;
-
-	/* Jump to SRAM suspend code */
-	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
-			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
-			   OMAP_SDRC_REGADDR(SDRC_POWER));
-
-no_sleep:
-	clk_enable(osc_ck);
-
-	/* clear CORE wake-up events */
-	omap_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
-	omap_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
-
-	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
-	omap_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, 0x4 | 0x1);
-
-	/* MPU domain wake events */
-	omap_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET, 0x1);
-
-	omap_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET, 0x20);
-
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
-	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
-
-	return 0;
-}
-
-static int sti_console_enabled;
-
-static int omap2_allow_mpu_retention(void)
-{
-	if (!omap2xxx_cm_mpu_retention_allowed())
-		return 0;
-	if (sti_console_enabled)
-		return 0;
-
-	return 1;
-}
-
-static void omap2_enter_mpu_retention(void)
-{
-	const int zero = 0;
-
-	/* The peripherals seem not to be able to wake up the MPU when
-	 * it is in retention mode. */
-	if (omap2_allow_mpu_retention()) {
-		/* REVISIT: These write to reserved bits? */
-		omap_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
-		omap_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
-		omap_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
-
-		/* Try to enter MPU retention */
-		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
-
-	} else {
-		/* Block MPU retention */
-		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
-	}
-
-	/* WFI */
-	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
-
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
-}
-
-static int omap2_can_sleep(void)
-{
-	if (omap2xxx_cm_fclks_active())
-		return 0;
-	if (__clk_is_enabled(osc_ck))
-		return 0;
-
-	return 1;
-}
-
-static void omap2_pm_idle(void)
-{
-	int error;
-
-	if (omap_irq_pending())
-		return;
-
-	error = cpu_cluster_pm_enter();
-	if (error || !omap2_can_sleep()) {
-		omap2_enter_mpu_retention();
-		goto out_cpu_cluster_pm;
-	}
-
-	omap2_enter_full_retention();
-
-out_cpu_cluster_pm:
-	cpu_cluster_pm_exit();
-}
-
-static void __init prcm_setup_regs(void)
-{
-	int i, num_mem_banks;
-	struct powerdomain *pwrdm;
-
-	/*
-	 * Enable autoidle
-	 * XXX This should be handled by hwmod code or PRCM init code
-	 */
-	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
-			  OMAP2_PRCM_SYSCONFIG_OFFSET);
-
-	/*
-	 * Set CORE powerdomain memory banks to retain their contents
-	 * during RETENTION
-	 */
-	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
-	for (i = 0; i < num_mem_banks; i++)
-		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
-
-	pwrdm_set_logic_retst(core_pwrdm, PWRDM_POWER_RET);
-
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
-
-	/* Force-power down DSP, GFX powerdomains */
-
-	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
-	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
-
-	pwrdm = clkdm_get_pwrdm(gfx_clkdm);
-	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
-
-	/* Enable hardware-supervised idle for all clkdms */
-	clkdm_for_each(omap_pm_clkdms_setup, NULL);
-	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
-
-	omap_common_suspend_init(omap2_enter_full_retention);
-
-	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
-	 * stabilisation */
-	omap2_prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
-				OMAP2_PRCM_CLKSSETUP_OFFSET);
-
-	/* Configure automatic voltage transition */
-	omap2_prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
-				OMAP2_PRCM_VOLTSETUP_OFFSET);
-	omap2_prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
-				(0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
-				OMAP24XX_MEMRETCTRL_MASK |
-				(0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
-				(0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
-				OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
-
-	/* Enable wake-up events */
-	omap2_prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
-				WKUP_MOD, PM_WKEN);
-
-	/* Enable SYS_CLKEN control when all domains idle */
-	omap2_prm_set_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP24XX_GR_MOD,
-				   OMAP2_PRCM_CLKSRC_CTRL_OFFSET);
-}
-
-int __init omap2_pm_init(void)
-{
-	u32 l;
-
-	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
-	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
-
-	/* Look up important powerdomains */
-
-	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
-	if (!mpu_pwrdm)
-		pr_err("PM: mpu_pwrdm not found\n");
-
-	core_pwrdm = pwrdm_lookup("core_pwrdm");
-	if (!core_pwrdm)
-		pr_err("PM: core_pwrdm not found\n");
-
-	/* Look up important clockdomains */
-
-	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-	if (!mpu_clkdm)
-		pr_err("PM: mpu_clkdm not found\n");
-
-	wkup_clkdm = clkdm_lookup("wkup_clkdm");
-	if (!wkup_clkdm)
-		pr_err("PM: wkup_clkdm not found\n");
-
-	dsp_clkdm = clkdm_lookup("dsp_clkdm");
-	if (!dsp_clkdm)
-		pr_err("PM: dsp_clkdm not found\n");
-
-	gfx_clkdm = clkdm_lookup("gfx_clkdm");
-	if (!gfx_clkdm)
-		pr_err("PM: gfx_clkdm not found\n");
-
-
-	osc_ck = clk_get(NULL, "osc_ck");
-	if (IS_ERR(osc_ck)) {
-		printk(KERN_ERR "could not get osc_ck\n");
-		return -ENODEV;
-	}
-
-	if (cpu_is_omap242x()) {
-		emul_ck = clk_get(NULL, "emul_ck");
-		if (IS_ERR(emul_ck)) {
-			printk(KERN_ERR "could not get emul_ck\n");
-			clk_put(osc_ck);
-			return -ENODEV;
-		}
-	}
-
-	prcm_setup_regs();
-
-	/*
-	 * We copy the assembler sleep/wakeup routines to SRAM.
-	 * These routines need to be in SRAM as that's the only
-	 * memory the MPU can see when it wakes up after the entire
-	 * chip enters idle.
-	 */
-	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
-					    omap24xx_cpu_suspend_sz);
-
-	arm_pm_idle = omap2_pm_idle;
-
-	return 0;
-}
-- 
2.29.2

