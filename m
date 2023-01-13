Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB3669745
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbjAMMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbjAMMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32C54D92;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfvJ12KBO7hWHRPUGWws8lue1lKj5HuYtS9ZayYMaIM=;
        b=nHE+WgjAB1uENE8uZvcwBXk9qtJ5yk5OAa3+hSxBzkMNOrAQL/Wg/tE9VU7qDOGP+kF3Dn
        z9LwA0675Uk2P1YV2DfK+pTPBV5vHUuyKcHrh75qnSKs2CBQj/Wlk/uR5X800iWBI5uLlT
        SSqLNrvDQJnudviU1xlYMRP9Um99Z2HhBmKR2ge5Kpb9UZci5qGOlt4ydqThCCXCJD5C7y
        df/pSMo+YqPvMkz4V89LxFp1uOWLJ1vf7Dbldt/MeD+joiAKVLzM+/4xgNGJsCSyCxCLUL
        DQ6GlgZ8YBBh7BZlfudofyHx8kRtXG0ZiCY6i1T7mV3Y4aFvLKy7Rfoua6zx7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfvJ12KBO7hWHRPUGWws8lue1lKj5HuYtS9ZayYMaIM=;
        b=5e1t83Kvgd3RL8RikkKCAr28LITJ4nu3KfS7fm8b9+KW30ExI2T2gYB7sEOu+ZKvpl5487
        lVey7+KiT+/K7gDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, xenpv: Make more PARAVIRT_XXL noinstr clean
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.171918174@infradead.org>
References: <20230112195541.171918174@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306902.4906.10248394765054869117.tip-bot2@tip-bot2>
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

Commit-ID:     10a099405fdf96c3205ae775abf19fcd301b31b4
Gitweb:        https://git.kernel.org/tip/10a099405fdf96c3205ae775abf19fcd301b31b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

cpuidle, xenpv: Make more PARAVIRT_XXL noinstr clean

objtool found a few cases where this code called out into instrumented
code:

  vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0xde: call to wbinvd() leaves .noinstr.text section
  vmlinux.o: warning: objtool: default_idle+0x4: call to arch_safe_halt() leaves .noinstr.text section
  vmlinux.o: warning: objtool: xen_safe_halt+0xa: call to HYPERVISOR_sched_op.constprop.0() leaves .noinstr.text section

Solve this by:

 - marking arch_safe_halt(), wbinvd(), native_wbinvd() and
   HYPERVISOR_sched_op() as __always_inline().

 - Explicitly uninlining xen_safe_halt() and pv_native_wbinvd() [they were
   already uninlined by the compiler on use as function pointers] and
   annotating them as 'noinstr'.

 - Annotating pv_native_safe_halt() as 'noinstr'.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.171918174@infradead.org
---
 arch/x86/include/asm/paravirt.h      |  6 ++++--
 arch/x86/include/asm/special_insns.h |  4 ++--
 arch/x86/include/asm/xen/hypercall.h |  2 +-
 arch/x86/kernel/paravirt.c           | 14 ++++++++++++--
 arch/x86/xen/enlighten_pv.c          |  2 +-
 arch/x86/xen/irq.c                   |  2 +-
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 73e9522..86c9d83 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -168,7 +168,7 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static inline void arch_safe_halt(void)
+static __always_inline void arch_safe_halt(void)
 {
 	PVOP_VCALL0(irq.safe_halt);
 }
@@ -178,7 +178,9 @@ static inline void halt(void)
 	PVOP_VCALL0(irq.halt);
 }
 
-static inline void wbinvd(void)
+extern noinstr void pv_native_wbinvd(void);
+
+static __always_inline void wbinvd(void)
 {
 	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 54621e7..f358a23 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -115,7 +115,7 @@ static inline void wrpkru(u32 pkru)
 }
 #endif
 
-static inline void native_wbinvd(void)
+static __always_inline void native_wbinvd(void)
 {
 	asm volatile("wbinvd": : :"memory");
 }
@@ -179,7 +179,7 @@ static inline void __write_cr4(unsigned long x)
 	native_write_cr4(x);
 }
 
-static inline void wbinvd(void)
+static __always_inline void wbinvd(void)
 {
 	native_wbinvd();
 }
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index e5e0fe1..a2dd249 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -382,7 +382,7 @@ MULTI_stack_switch(struct multicall_entry *mcl,
 }
 #endif
 
-static inline int
+static __always_inline int
 HYPERVISOR_sched_op(int cmd, void *arg)
 {
 	return _hypercall2(int, sched_op, cmd, arg);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 327757a..5bf4f0b 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -216,6 +216,11 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 	native_set_debugreg(regno, val);
 }
 
+noinstr void pv_native_wbinvd(void)
+{
+	native_wbinvd();
+}
+
 static noinstr void pv_native_irq_enable(void)
 {
 	native_irq_enable();
@@ -225,6 +230,11 @@ static noinstr void pv_native_irq_disable(void)
 {
 	native_irq_disable();
 }
+
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -256,7 +266,7 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-	.cpu.wbinvd		= native_wbinvd,
+	.cpu.wbinvd		= pv_native_wbinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
 	.cpu.read_msr_safe	= native_read_msr_safe,
@@ -290,7 +300,7 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
-	.irq.safe_halt		= native_safe_halt,
+	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
 #endif /* CONFIG_PARAVIRT_XXL */
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5b13796..5cacd48 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1068,7 +1068,7 @@ static const typeof(pv_ops) xen_cpu_ops __initconst = {
 
 		.write_cr4 = xen_write_cr4,
 
-		.wbinvd = native_wbinvd,
+		.wbinvd = pv_native_wbinvd,
 
 		.read_msr = xen_read_msr,
 		.write_msr = xen_write_msr,
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 06c3c2f..6092fea 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -24,7 +24,7 @@ noinstr void xen_force_evtchn_callback(void)
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
 
-static void xen_safe_halt(void)
+static noinstr void xen_safe_halt(void)
 {
 	/* Blocking includes an implicit local_irq_enable(). */
 	if (HYPERVISOR_sched_op(SCHEDOP_block, NULL) != 0)
