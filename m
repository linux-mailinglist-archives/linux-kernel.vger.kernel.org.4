Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C07669735
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbjAMMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjAMMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A87517E1;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TZQbY9fGQnNuTodI5yBhQPxVA/OJ+m0XfCKeSCiIm0=;
        b=p93oxIvVXL/EPtZc7Jj/vQWrfnxe81Q8prgCnPLoFcfOQdtdiMAlCuyTBMCX+TAame6du+
        H1v2U4JnTVqALRi3GIJ2K6M7ZKs6g/wsDmikP4nDO+diqu89mE9AeCiEmMZKkX5bet9cOB
        onsyQf+QhrVGuG5u6IJbsTtIKQt0bqrm7cCISWg0Cd63EjHh7y44xAEFyQHruc2zda01yK
        es075ak4xq3QQcUNm9pYElhNRazirRUBVzaF1UKD1ngwBOSuHtMcUHptkvrq5gvapQTg8f
        Dx3ThijwIqG8qwkAoyP1qaiVWgKTmFIAiecU8gTwhcW0E7UurcHlIw7DnVZ4Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TZQbY9fGQnNuTodI5yBhQPxVA/OJ+m0XfCKeSCiIm0=;
        b=14yvmZ+qvYRS0NFGSHa9Z4p1nlZoZEEu1iE1FZ8qJ2DoaN2skOIpKOJGUCnYmlqs/z2f5O
        s6Y+2RhnwOF6GOBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm, OMAP2: Use WFI for omap2_pm_idle()
Cc:     Tony Lindgren <tony@atomide.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.721697850@infradead.org>
References: <20230112195541.721697850@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306712.4906.10284730593787878496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     259c95afac6f2758760f158537e1d28358b4639c
Gitweb:        https://git.kernel.org/tip/259c95afac6f2758760f158537e1d28358b4639c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

arm, OMAP2: Use WFI for omap2_pm_idle()

arch_cpu_idle() is a very simple idle interface and exposes only a
single idle state and is expected to not require RCU and not do any
tracing/instrumentation.

As such, omap2_pm_idle() is not a valid implementation. Replace it
with a simple (shallow) omap2_do_wfi() call.

Omap2 doesn't have a cpuidle driver; but adding one would be the
recourse to (re)gain the other idle states.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.721697850@infradead.org
---
 arch/arm/mach-omap2/pm24xx.c | 51 +----------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6953c47..d52cf73 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -116,50 +116,12 @@ no_sleep:
 
 static int sti_console_enabled;
 
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
+static void omap2_do_wfi(void)
 {
 	const int zero = 0;
 
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
 	/* WFI */
 	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
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
 }
 
 static void omap2_pm_idle(void)
@@ -169,16 +131,7 @@ static void omap2_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
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
+	omap2_do_wfi();
 }
 
 static void __init prcm_setup_regs(void)
