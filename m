Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBADE66976E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbjAMMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjAMMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E556574E6;
        Fri, 13 Jan 2023 04:31:18 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MOxP0q2phAy5N9tYdA2yH6rtSrdxa7nUWRoM0QGD4w=;
        b=BBZeA2BwDQQm++usnWAjDk+vVSD7jfBQYKfOtrOyZ0w7yv/C3M/FvTLazOos8yDvK/4i2s
        RPGzMzucvFF0OIhSK4z+aVRjFgnTg2TcE5lA1RP29i432ndTcnc24KYqkxnpySjjJmyBw6
        rxFn+MTf8pZGeIJQbWtj8nRFe2j9amYfOJVjD1BbZAvw+s6v4joCO1brWJdUJC65fXww5W
        a3N/8PaUJvDYAGR4guHQX6Bm0A0QOQze5aO1tNCnIGOzwWFH5eCxB1rXoZ+TMbOTj65qtd
        UUIsBTPzmd0kbNplTFO6H5yEoccLO59gtj00C9qEQWwWs16UjJsuovv15hB9NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MOxP0q2phAy5N9tYdA2yH6rtSrdxa7nUWRoM0QGD4w=;
        b=cGuHc95dHNUBFN/XqiM++Jfzl7pxgFnHr9UUYtAKVH8vkmSQS48eOS1TUBBUzEW7i4Zl/h
        uUeP3IPftFB9SWCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/idle: Replace 'x86_idle' function pointer with
 a static_call
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195539.453613251@infradead.org>
References: <20230112195539.453613251@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307658.4906.13785875807510499856.tip-bot2@tip-bot2>
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

Commit-ID:     aaa3896b969bdf946e0fd6aa6199da17b5da8d5c
Gitweb:        https://git.kernel.org/tip/aaa3896b969bdf946e0fd6aa6199da17b5da8d5c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:03:21 +01:00

x86/idle: Replace 'x86_idle' function pointer with a static_call

Typical boot time setup; no need to suffer an indirect call for that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230112195539.453613251@infradead.org
---
 arch/x86/kernel/process.c | 50 +++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 40d156a..8481fbe 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -24,6 +24,7 @@
 #include <linux/cpuidle.h>
 #include <linux/acpi.h>
 #include <linux/elf-randomize.h>
+#include <linux/static_call.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
@@ -694,7 +695,23 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-static void (*x86_idle)(void);
+/*
+ * We use this if we don't have any better idle routine..
+ */
+void __cpuidle default_idle(void)
+{
+	raw_safe_halt();
+}
+#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+EXPORT_SYMBOL(default_idle);
+#endif
+
+DEFINE_STATIC_CALL_NULL(x86_idle, default_idle);
+
+static bool x86_idle_set(void)
+{
+	return !!static_call_query(x86_idle);
+}
 
 #ifndef CONFIG_SMP
 static inline void play_dead(void)
@@ -717,28 +734,17 @@ void arch_cpu_idle_dead(void)
 /*
  * Called from the generic idle code.
  */
-void arch_cpu_idle(void)
-{
-	x86_idle();
-}
-
-/*
- * We use this if we don't have any better idle routine..
- */
-void __cpuidle default_idle(void)
+void __cpuidle arch_cpu_idle(void)
 {
-	raw_safe_halt();
+	static_call(x86_idle)();
 }
-#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
-EXPORT_SYMBOL(default_idle);
-#endif
 
 #ifdef CONFIG_XEN
 bool xen_set_default_idle(void)
 {
-	bool ret = !!x86_idle;
+	bool ret = x86_idle_set();
 
-	x86_idle = default_idle;
+	static_call_update(x86_idle, default_idle);
 
 	return ret;
 }
@@ -880,20 +886,20 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
 #endif
-	if (x86_idle || boot_option_idle_override == IDLE_POLL)
+	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
 		return;
 
 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
 		pr_info("using AMD E400 aware idle routine\n");
-		x86_idle = amd_e400_idle;
+		static_call_update(x86_idle, amd_e400_idle);
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
-		x86_idle = mwait_idle;
+		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		x86_idle = tdx_safe_halt;
+		static_call_update(x86_idle, tdx_safe_halt);
 	} else
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 }
 
 void amd_e400_c1e_apic_setup(void)
@@ -946,7 +952,7 @@ static int __init idle_setup(char *str)
 		 * To continue to load the CPU idle driver, don't touch
 		 * the boot_option_idle_override.
 		 */
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 		boot_option_idle_override = IDLE_HALT;
 	} else if (!strcmp(str, "nomwait")) {
 		/*
