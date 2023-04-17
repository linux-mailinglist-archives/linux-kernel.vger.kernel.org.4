Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F716E45B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjDQKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDQKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C07EE5;
        Mon, 17 Apr 2023 03:50:01 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mq/umlOxqawASo910s5i5eyYf8oTyR6gQPtYMDwyGS8=;
        b=KFCJVJhqW9awGCcjEMZv3lcM416afrADALl6h892MqEo9Otsaetn64NW6axKRf1iwq9t7r
        +q5b8DpkO4KWr+3Z8dXW1Yq9Neqr1+pR6KqlEvsm0euSM7OIioTwvgyw+0t2I5wNfW6g6V
        cCi/eYhhsNoZbmxpBxOoJ8/eNrKyF1YXB9JiLax8zJjHH9/Gd9bNcTuNBw1P50X27u+IiS
        Kdf7BXTKZaO1llRWJvdNrbgkWQ3hOCNWMRWwqbaOHjAfbReU3l13BwZbZSpbdRy8ngW8ju
        IIyW1UE7LpT1EDxLia+u8HonxCGzd1TlhiO5EEPn9v6pM/4/eFssuT8rkhnEkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mq/umlOxqawASo910s5i5eyYf8oTyR6gQPtYMDwyGS8=;
        b=xLD1xzroqwzLJWnLOJ8pprXlgNOhoSQr7xfq0NNXgYc9k/mLs7r3zOoDGoaSdd19luh+pL
        PbohuRCr+IqNSUBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] arm64/cpu: Mark cpu_park_loop() and friends __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <55787d3193ea3e295ccbb097abfab0a10ae49d45.1681342859.git.jpoimboe@kernel.org>
References: <55787d3193ea3e295ccbb097abfab0a10ae49d45.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840728.404.16097273612224314980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5ab6876c7843db5fe8bef691c5fdb92518b12070
Gitweb:        https://git.kernel.org/tip/5ab6876c7843db5fe8bef691c5fdb92518b12070
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:24 +02:00

arm64/cpu: Mark cpu_park_loop() and friends __noreturn

In preparation for marking panic_smp_self_stop() __noreturn across the
kernel, first mark the arm64 implementation of cpu_park_loop() and
related functions __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/55787d3193ea3e295ccbb097abfab0a10ae49d45.1681342859.git.jpoimboe@kernel.org
---
 arch/arm64/include/asm/exception.h | 4 ++--
 arch/arm64/include/asm/smp.h       | 6 +++---
 arch/arm64/kernel/entry-common.c   | 2 +-
 arch/arm64/kernel/smp.c            | 8 +++++---
 arch/arm64/kernel/traps.c          | 3 +--
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 92963f9..e73af70 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -31,7 +31,7 @@ static inline unsigned long disr_to_esr(u64 disr)
 	return esr;
 }
 
-asmlinkage void handle_bad_stack(struct pt_regs *regs);
+asmlinkage void __noreturn handle_bad_stack(struct pt_regs *regs);
 
 asmlinkage void el1t_64_sync_handler(struct pt_regs *regs);
 asmlinkage void el1t_64_irq_handler(struct pt_regs *regs);
@@ -80,5 +80,5 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
 void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
 
-void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far);
+void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far);
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 5733a31..07f4ea1 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -101,9 +101,9 @@ extern int __cpu_disable(void);
 
 extern void __cpu_die(unsigned int cpu);
 extern void __noreturn cpu_die(void);
-extern void cpu_die_early(void);
+extern void __noreturn cpu_die_early(void);
 
-static inline void cpu_park_loop(void)
+static inline void __noreturn cpu_park_loop(void)
 {
 	for (;;) {
 		wfe();
@@ -123,7 +123,7 @@ static inline void update_cpu_boot_status(int val)
  * which calls for a kernel panic. Update the boot status and park the calling
  * CPU.
  */
-static inline void cpu_panic_kernel(void)
+static inline void __noreturn cpu_panic_kernel(void)
 {
 	update_cpu_boot_status(CPU_PANIC_KERNEL);
 	cpu_park_loop();
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cce1167..3af3c01 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -840,7 +840,7 @@ UNHANDLED(el0t, 32, error)
 #endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_VMAP_STACK
-asmlinkage void noinstr handle_bad_stack(struct pt_regs *regs)
+asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
 	unsigned long far = read_sysreg(far_el1);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d5d09a1..07d156f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -398,7 +398,7 @@ static void __cpu_try_die(int cpu)
  * Kill the calling secondary CPU, early in bringup before it is turned
  * online.
  */
-void cpu_die_early(void)
+void __noreturn cpu_die_early(void)
 {
 	int cpu = smp_processor_id();
 
@@ -816,7 +816,7 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void local_cpu_stop(void)
+static void __noreturn local_cpu_stop(void)
 {
 	set_cpu_online(smp_processor_id(), false);
 
@@ -839,7 +839,7 @@ void panic_smp_self_stop(void)
 static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 #endif
 
-static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
 	crash_save_cpu(regs, cpu);
@@ -854,6 +854,8 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	/* just in case */
 	cpu_park_loop();
+#else
+	BUG();
 #endif
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4a79ba1..4bb1b8f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -863,7 +863,7 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr)
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
 
-void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
+void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
@@ -905,7 +905,6 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 	nmi_panic(regs, "Asynchronous SError Interrupt");
 
 	cpu_park_loop();
-	unreachable();
 }
 
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned long esr)
