Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE76CB987
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC1IfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjC1Iet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992135A1;
        Tue, 28 Mar 2023 01:34:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHyIWvp8YsbpW9TCHuLZxtLPsbBI8Qr4S2z12fpH9tE=;
        b=Jq0Cu27CmZER6ykMiH1BI3D8ps+5SRPhU2kt/npjY24OunD9FYEIinnpQCfQiwKXWCHAlS
        Tyybb7Ows/tB6Paala5690GpUJd3vZVNp5Yp9I8BS5ZYGXaSDIJ8faQtzIR7U39E4uQa7J
        T3AFTtvtLqZWESZQbbT0RohPWJjrlrXJZbZvwZ8/Ty4PI2nHkNRhC3KYhmmzO5Wc3Ai7wG
        i6XfiAR1odlFj/AsE+7xlrn6ORgCYJ2fbnLw3fFFUN+oeu7Kq2K0hpGJjO38O3NoO00cY4
        ceLI9TuieMBQm7pgUmGkJ/zNXpBWAPbdYB7nuCZE4BLPg0wfn5J6u1g1PkuPyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHyIWvp8YsbpW9TCHuLZxtLPsbBI8Qr4S2z12fpH9tE=;
        b=/9Wzj3O5BjNu8YPJS8yaU7wXJO3C8B8yYuscIIg10LSiHL0yFQKa2LExLnnnxKjIOY9EeS
        ZEqPEft9FvzQcECA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] treewide: Trace IPIs sent via smp_send_reschedule()
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307143558.294354-6-vschneid@redhat.com>
References: <20230307143558.294354-6-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167999248560.5837.1994916608629398014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     4c8c3c7f70a6779d30f5492acbc9978f4636fe7a
Gitweb:        https://git.kernel.org/tip/4c8c3c7f70a6779d30f5492acbc9978f4636fe7a
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Tue, 07 Mar 2023 14:35:56 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:28 +01:00

treewide: Trace IPIs sent via smp_send_reschedule()

To be able to trace invocations of smp_send_reschedule(), rename the
arch-specific definitions of it to arch_smp_send_reschedule() and wrap it
into an smp_send_reschedule() that contains a tracepoint.

Changes to include the declaration of the tracepoint were driven by the
following coccinelle script:

  @func_use@
  @@
  smp_send_reschedule(...);

  @include@
  @@
  #include <trace/events/ipi.h>

  @no_include depends on func_use && !include@
  @@
    #include <...>
  +
  + #include <trace/events/ipi.h>

[csky bits]
[riscv bits]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230307143558.294354-6-vschneid@redhat.com
---
 arch/alpha/kernel/smp.c                  |  2 +-
 arch/arc/kernel/smp.c                    |  2 +-
 arch/arm/kernel/smp.c                    |  2 +-
 arch/arm/mach-actions/platsmp.c          |  2 ++
 arch/arm64/kernel/smp.c                  |  2 +-
 arch/csky/kernel/smp.c                   |  2 +-
 arch/hexagon/kernel/smp.c                |  2 +-
 arch/ia64/kernel/smp.c                   |  4 ++--
 arch/loongarch/kernel/smp.c              |  4 ++--
 arch/mips/include/asm/smp.h              |  2 +-
 arch/mips/kernel/rtlx-cmp.c              |  2 ++
 arch/openrisc/kernel/smp.c               |  2 +-
 arch/parisc/kernel/smp.c                 |  4 ++--
 arch/powerpc/kernel/smp.c                |  6 ++++--
 arch/powerpc/kvm/book3s_hv.c             |  3 +++
 arch/powerpc/platforms/powernv/subcore.c |  2 ++
 arch/riscv/kernel/smp.c                  |  4 ++--
 arch/s390/kernel/smp.c                   |  2 +-
 arch/sh/kernel/smp.c                     |  2 +-
 arch/sparc/kernel/smp_32.c               |  2 +-
 arch/sparc/kernel/smp_64.c               |  2 +-
 arch/x86/include/asm/smp.h               |  2 +-
 arch/x86/kvm/svm/svm.c                   |  4 ++++
 arch/x86/kvm/x86.c                       |  2 ++
 arch/xtensa/kernel/smp.c                 |  2 +-
 include/linux/smp.h                      | 11 +++++++++--
 virt/kvm/kvm_main.c                      |  3 +++
 27 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 0ede4b0..7439b23 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -562,7 +562,7 @@ handle_ipi(struct pt_regs *regs)
 }
 
 void
-smp_send_reschedule(int cpu)
+arch_smp_send_reschedule(int cpu)
 {
 #ifdef DEBUG_IPI_MSG
 	if (cpu == hard_smp_processor_id())
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index ad93fe6..409cfa4 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -292,7 +292,7 @@ static void ipi_send_msg(const struct cpumask *callmap, enum ipi_msg_type msg)
 		ipi_send_msg_one(cpu, msg);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	ipi_send_msg_one(cpu, IPI_RESCHEDULE);
 }
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5edf092..b350bfc 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -746,7 +746,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	ipi_setup(smp_processor_id());
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index f26618b..7b208e9 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -20,6 +20,8 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
+#include <trace/events/ipi.h>
+
 #define OWL_CPU1_ADDR	0x50
 #define OWL_CPU1_FLAG	0x5c
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 438c16f..66f2745 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -976,7 +976,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	ipi_setup(smp_processor_id());
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b45d107..be77383 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -140,7 +140,7 @@ void smp_send_stop(void)
 	on_each_cpu(ipi_stop, NULL, 1);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 4ba93e5..4e8bee2 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -217,7 +217,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
index e2cc59d..ea4f009 100644
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -220,11 +220,11 @@ kdump_smp_send_init(void)
  * Called with preemption disabled.
  */
 void
-smp_send_reschedule (int cpu)
+arch_smp_send_reschedule (int cpu)
 {
 	ia64_send_ipi(cpu, IA64_IPI_RESCHEDULE, IA64_IPI_DM_INT, 0);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 /*
  * Called with preemption disabled.
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 8c6e227..8322561 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -155,11 +155,11 @@ void loongson_send_ipi_mask(const struct cpumask *mask, unsigned int action)
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 {
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 5d9ff61..9806e79 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -66,7 +66,7 @@ extern void calculate_cpu_foreign_map(void);
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-static inline void smp_send_reschedule(int cpu)
+static inline void arch_smp_send_reschedule(int cpu)
 {
 	extern const struct plat_smp_ops *mp_ops;	/* private */
 
diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
index d26dcc4..e991cc9 100644
--- a/arch/mips/kernel/rtlx-cmp.c
+++ b/arch/mips/kernel/rtlx-cmp.c
@@ -17,6 +17,8 @@
 #include <asm/vpe.h>
 #include <asm/rtlx.h>
 
+#include <trace/events/ipi.h>
+
 static int major;
 
 static void rtlx_interrupt(void)
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index e141909..0a7a059 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -173,7 +173,7 @@ void handle_IPI(unsigned int ipi_msg)
 	}
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 7dbd92c..b7fc859 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -246,8 +246,8 @@ void kgdb_roundup_cpus(void)
 inline void 
 smp_send_stop(void)	{ send_IPI_allbutself(IPI_CPU_STOP); }
 
-void 
-smp_send_reschedule(int cpu) { send_IPI_single(cpu, IPI_RESCHEDULE); }
+void
+arch_smp_send_reschedule(int cpu) { send_IPI_single(cpu, IPI_RESCHEDULE); }
 
 void
 smp_send_all_nop(void)
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6b90f10..35f101c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -61,6 +61,8 @@
 #include <asm/kup.h>
 #include <asm/fadump.h>
 
+#include <trace/events/ipi.h>
+
 #ifdef DEBUG
 #include <asm/udbg.h>
 #define DBG(fmt...) udbg_printf(fmt)
@@ -364,12 +366,12 @@ static inline void do_message_pass(int cpu, int msg)
 #endif
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	if (likely(smp_ops))
 		do_message_pass(cpu, PPC_MSG_RESCHEDULE);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 void arch_send_call_function_single_ipi(int cpu)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6ba68dd..3b70b5f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -43,6 +43,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/smp.h>
 
 #include <asm/ftrace.h>
 #include <asm/reg.h>
@@ -80,6 +81,8 @@
 #include <asm/dtl.h>
 #include <asm/plpar_wrappers.h>
 
+#include <trace/events/ipi.h>
+
 #include "book3s.h"
 #include "book3s_hv.h"
 
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 7e98b00..c53c4c7 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -20,6 +20,8 @@
 #include <asm/opal.h>
 #include <asm/smp.h>
 
+#include <trace/events/ipi.h>
+
 #include "subcore.h"
 #include "powernv.h"
 
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8c3b59f..42e9656 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -328,8 +328,8 @@ bool smp_crash_stop_failed(void)
 }
 #endif
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index d488845..a710319 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -553,7 +553,7 @@ void arch_send_call_function_single_ipi(int cpu)
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	pcpu_ec_call(pcpu_devices + cpu, ec_schedule);
 }
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 65924d9..5cf35a7 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -256,7 +256,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	       (bogosum / (5000/HZ)) % 100);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	mp_ops->send_ipi(cpu, SMP_MSG_RESCHEDULE);
 }
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index ad8094d..87eaa77 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -120,7 +120,7 @@ void cpu_panic(void)
 
 struct linux_prom_registers smp_penguin_ctable = { 0 };
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	/*
 	 * CPU model dependent way of implementing IPI generation targeting
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a55295d..e5964d1 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1430,7 +1430,7 @@ static unsigned long send_cpu_poke(int cpu)
 	return hv_err;
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	if (cpu == smp_processor_id()) {
 		WARN_ON_ONCE(preemptible());
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4dbb20..f975712 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -98,7 +98,7 @@ static inline void play_dead(void)
 	smp_ops.play_dead();
 }
 
-static inline void smp_send_reschedule(int cpu)
+static inline void arch_smp_send_reschedule(int cpu)
 {
 	smp_ops.smp_send_reschedule(cpu);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 252e7f3..424fcdb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/rwsem.h>
 #include <linux/cc_platform.h>
+#include <linux/smp.h>
 
 #include <asm/apic.h>
 #include <asm/perf_event.h>
@@ -41,6 +42,9 @@
 #include <asm/fpu/api.h>
 
 #include <asm/virtext.h>
+
+#include <trace/events/ipi.h>
+
 #include "trace.h"
 
 #include "svm.h"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7713420..07ba937 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -60,7 +60,9 @@
 #include <linux/mem_encrypt.h>
 #include <linux/entry-kvm.h>
 #include <linux/suspend.h>
+#include <linux/smp.h>
 
+#include <trace/events/ipi.h>
 #include <trace/events/kvm.h>
 
 #include <asm/debugreg.h>
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 4dc109d..d95907b 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -389,7 +389,7 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58..c036a22 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -125,8 +125,15 @@ extern void smp_send_stop(void);
 /*
  * sends a 'reschedule' event to another CPU:
  */
-extern void smp_send_reschedule(int cpu);
-
+extern void arch_smp_send_reschedule(int cpu);
+/*
+ * scheduler_ipi() is inline so can't be passed as callback reason, but the
+ * callsite IP should be sufficient for root-causing IPIs sent from here.
+ */
+#define smp_send_reschedule(cpu) ({				  \
+	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);  \
+	arch_smp_send_reschedule(cpu);				  \
+})
 
 /*
  * Prepare machine for booting other CPUs.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d255964..7d18896 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -62,11 +62,14 @@
 #include "kvm_mm.h"
 #include "vfio.h"
 
+#include <trace/events/ipi.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/kvm.h>
 
 #include <linux/kvm_dirty_ring.h>
 
+
 /* Worst case buffer size needed for holding an integer. */
 #define ITOA_MAX_LEN 12
 
