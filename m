Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACD669733
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbjAMMeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjAMMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBE5373C;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0lO5s0BlGqs/dCckz+ZdrpgCPAhdNQATe6DxgG7kp0=;
        b=mXJ57Tu9tpih38G8bYh9cn8IcCS/81kDxX0KppnvQRlrfTLLXlXf4+k7YqdnlApn10l8Kq
        ABfkjPe6GUA7piij3s7ZRgNhHmzKxZVfLENbVaCn/RebusoX4YBrGy2Zvom351ZifN9Rsn
        w6OlFR3SxOEyPgwAL1nRwNT7VkF5eeIdnsfK6Qpgas416fzhQKSHmsUf1Vijduzv7uSiUO
        zMGVOQ5N0JMpJtImfTHRq2Qp/MxhwgCwxELPgF2D3o44kzt9J1vS1UApWwc1/5g3ymFIPe
        wiiQbCu8BXHe65FrZngyQ0TIfKtMAKt62yW0u2buhTn0w87UmPW0+VuoTOLEsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0lO5s0BlGqs/dCckz+ZdrpgCPAhdNQATe6DxgG7kp0=;
        b=sDs79vXf/kFTtFU7u3ZmHDqVsAqri10GwOBfKd8W5l+coGJkMB3CmwUcPkugbWAMWKJ3uD
        2SRTjftfXRiSAsDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, OMAP3: Push RCU-idle into omap_sram_idle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.599561742@infradead.org>
References: <20230112195541.599561742@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306760.4906.9133049852449204892.tip-bot2@tip-bot2>
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

Commit-ID:     8c0956aa76f97003e2ac96e86b00a2a4e82abf8e
Gitweb:        https://git.kernel.org/tip/8c0956aa76f97003e2ac96e86b00a2a4e82abf8e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

cpuidle, OMAP3: Push RCU-idle into omap_sram_idle()

OMAP3 uses full SoC suspend modes as idle states, as such it needs the
whole power-domain and clock-domain code from the idle path.

All that code is not suitable to run with RCU disabled, as such push
RCU-idle deeper still.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.599561742@infradead.org
---
 arch/arm/mach-omap2/cpuidle34xx.c |  4 +---
 arch/arm/mach-omap2/pm.h          |  2 +-
 arch/arm/mach-omap2/pm34xx.c      | 12 ++++++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 6d63769..2ab5dcb 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -133,9 +133,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	}
 
 	/* Execute ARM wfi */
-	ct_cpuidle_enter();
-	omap_sram_idle();
-	ct_cpuidle_exit();
+	omap_sram_idle(true);
 
 	/*
 	 * Call idle CPU PM enter notifier chain to restore
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 80e84ae..4a6c9d1 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -29,7 +29,7 @@ static inline int omap4_idle_init(void)
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
-extern void omap_sram_idle(void);
+extern void omap_sram_idle(bool rcuidle);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 
 #if defined(CONFIG_PM_OPP)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9a3535b..9856091 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/cpuidle.h>
 
 #include <trace/events/power.h>
 
@@ -174,7 +175,7 @@ static int omap34xx_do_sram_idle(unsigned long save_state)
 	return 0;
 }
 
-void omap_sram_idle(void)
+void omap_sram_idle(bool rcuidle)
 {
 	/* Variable to tell what needs to be saved and restored
 	 * in omap_sram_idle*/
@@ -254,11 +255,18 @@ void omap_sram_idle(void)
 	 */
 	if (save_state)
 		omap34xx_save_context(omap3_arm_context);
+
+	if (rcuidle)
+		ct_cpuidle_enter();
+
 	if (save_state == 1 || save_state == 3)
 		cpu_suspend(save_state, omap34xx_do_sram_idle);
 	else
 		omap34xx_do_sram_idle(save_state);
 
+	if (rcuidle)
+		ct_cpuidle_exit();
+
 	/* Restore normal SDRC POWER settings */
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
@@ -316,7 +324,7 @@ static int omap3_pm_suspend(void)
 
 	omap3_intc_suspend();
 
-	omap_sram_idle();
+	omap_sram_idle(false);
 
 restore:
 	/* Restore next_pwrsts */
