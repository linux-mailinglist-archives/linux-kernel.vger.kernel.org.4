Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F39647ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLIHzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLIHzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:55:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521E5288D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:55:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF96361DC9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58B1C433F0;
        Fri,  9 Dec 2022 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670572529;
        bh=G8p5lEpoC0IJRgyX0ViKkP39BN1oR2/+srREqX4vjII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/Y5oQ1R1fQk0p75Es5TVozwX8WtFOPnJPpbmT9TWa6bbZzLgojHdAtNZz7mKsLw9
         bYR7ojiz78Ex1AkC7FNddLg9yQQcj5JPD3eKZXxbs501S7hby7iyQgZvgK5irCwx/j
         Udez3TcBSOO/O+/TJHNmiwOXfxWsZaV2PGgVsNK6SD+D9dIfdE3x5tMEuQLk/rnFrC
         93An4dsCPDJcq760TFHiSv30XIFRRVk73Ah62GCNjC1oAMmIAna9WoZuFVbh7voz8A
         d5l655ZeMyTzvbm/Q6+BVlYGGBf4hJTahoE/KZGMPl+SZSIX99gxpMETtxsohnCrU9
         hGOC1o7ca37FA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, conor.Dooley@microchip.com, guoren@kernel.org,
        heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        crash-utility@redhat.com, Guo Ren <guoren@linux.alibaba.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH -next V6 2/2] riscv: kexec: Make crash save multi harts' context
Date:   Fri,  9 Dec 2022 02:55:13 -0500
Message-Id: <20221209075513.532249-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221209075513.532249-1-guoren@kernel.org>
References: <20221209075513.532249-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current crash_smp_send_stop is the same as the generic one in
kernel/panic and misses crash_save_cpu in percpu. This patch is
inspired by 'commit 78fd584cdec0 ("arm64: kdump: implement
machine_crash_shutdown()") and adds the same mechanism for riscv.

Original implementation: 'commit ad943893d5f1 ("RISC-V: Fixup
schedule out issue in machine_crash_shutdown()")'. Before this
patch, test result:

crash> help -r
CPU 0: [OFFLINE]

CPU 1:
epc : ffffffff80009ff0 ra : ffffffff800b789a sp : ff2000001098bb40
 gp : ffffffff815fca60 tp : ff60000004680000 t0 : 6666666666663c5b
 t1 : 0000000000000000 t2 : 666666666666663c s0 : ff2000001098bc90
 s1 : ffffffff81600798 a0 : ff2000001098bb48 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
 a5 : ff60000004690800 a6 : 0000000000000000 a7 : 0000000000000000
 s2 : ff2000001098bb48 s3 : ffffffff81093ec8 s4 : ffffffff816004ac
 s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80e7f720
 s8 : 00fffffffffff3f0 s9 : 0000000000000007 s10: 00aaaaaaaab98700
 s11: 0000000000000001 t3 : ffffffff819a8097 t4 : ffffffff819a8097
 t5 : ffffffff819a8098 t6 : ff2000001098b9a8

CPU 2: [OFFLINE]

CPU 3: [OFFLINE]

After this patch, test result:
crash> help -r
CPU 0:
epc : ffffffff80003f34 ra : ffffffff808caa7c sp : ffffffff81403eb0
 gp : ffffffff815fcb48 tp : ffffffff81413400 t0 : 0000000000000000
 t1 : 0000000000000000 t2 : 0000000000000000 s0 : ffffffff81403ec0
 s1 : 0000000000000000 a0 : 0000000000000000 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
 s2 : ffffffff816001c8 s3 : ffffffff81600370 s4 : ffffffff80c32e18
 s5 : ffffffff819d3018 s6 : ffffffff810e2110 s7 : 0000000000000000
 s8 : 0000000000000000 s9 : 0000000080039eac s10: 0000000000000000
 s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000000

CPU 1:
epc : ffffffff80003f34 ra : ffffffff808caa7c sp : ff2000000068bf30
 gp : ffffffff815fcb48 tp : ff6000000240d400 t0 : 0000000000000000
 t1 : 0000000000000000 t2 : 0000000000000000 s0 : ff2000000068bf40
 s1 : 0000000000000001 a0 : 0000000000000000 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
 s2 : ffffffff816001c8 s3 : ffffffff81600370 s4 : ffffffff80c32e18
 s5 : ffffffff819d3018 s6 : ffffffff810e2110 s7 : 0000000000000000
 s8 : 0000000000000000 s9 : 0000000080039ea8 s10: 0000000000000000
 s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000000

CPU 2:
epc : ffffffff80003f34 ra : ffffffff808caa7c sp : ff20000000693f30
 gp : ffffffff815fcb48 tp : ff6000000240e900 t0 : 0000000000000000
 t1 : 0000000000000000 t2 : 0000000000000000 s0 : ff20000000693f40
 s1 : 0000000000000002 a0 : 0000000000000000 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
 s2 : ffffffff816001c8 s3 : ffffffff81600370 s4 : ffffffff80c32e18
 s5 : ffffffff819d3018 s6 : ffffffff810e2110 s7 : 0000000000000000
 s8 : 0000000000000000 s9 : 0000000080039eb0 s10: 0000000000000000
 s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000000

CPU 3:
epc : ffffffff8000a1e4 ra : ffffffff800b7bba sp : ff200000109bbb40
 gp : ffffffff815fcb48 tp : ff6000000373aa00 t0 : 6666666666663c5b
 t1 : 0000000000000000 t2 : 666666666666663c s0 : ff200000109bbc90
 s1 : ffffffff816007a0 a0 : ff200000109bbb48 a1 : 0000000000000000
 a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
 a5 : ff60000002c61c00 a6 : 0000000000000000 a7 : 0000000000000000
 s2 : ff200000109bbb48 s3 : ffffffff810941a8 s4 : ffffffff816004b4
 s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80e7f7a0
 s8 : 00fffffffffff3f0 s9 : 0000000000000007 s10: 00aaaaaaaab98700
 s11: 0000000000000001 t3 : ffffffff819a8097 t4 : ffffffff819a8097
 t5 : ffffffff819a8098 t6 : ff200000109bb9a8

Reviewed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/smp.h      |  3 +
 arch/riscv/kernel/machine_kexec.c | 21 ++-----
 arch/riscv/kernel/smp.c           | 97 ++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index d3443be7eedc..3831b638ecab 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -50,6 +50,9 @@ void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
 /* Clear IPI for current CPU */
 void riscv_clear_ipi(void);
 
+/* Check other CPUs stop or not */
+bool smp_crash_stop_failed(void);
+
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
 
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index db41c676e5a2..2d139b724bc8 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -140,22 +140,6 @@ void machine_shutdown(void)
 #endif
 }
 
-/* Override the weak function in kernel/panic.c */
-void crash_smp_send_stop(void)
-{
-	static int cpus_stopped;
-
-	/*
-	 * This function can be called twice in panic path, but obviously
-	 * we execute this only once.
-	 */
-	if (cpus_stopped)
-		return;
-
-	smp_send_stop();
-	cpus_stopped = 1;
-}
-
 static void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
@@ -230,6 +214,11 @@ machine_kexec(struct kimage *image)
 	void *control_code_buffer = page_address(image->control_code_page);
 	riscv_kexec_method kexec_method = NULL;
 
+#ifdef CONFIG_SMP
+	WARN(smp_crash_stop_failed(),
+		"Some CPUs may be stale, kdump will be unreliable.\n");
+#endif
+
 	if (image->type != KEXEC_TYPE_CRASH)
 		kexec_method = control_code_buffer;
 	else
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 760a64518c58..785e44308526 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -12,6 +12,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/kexec.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
@@ -22,11 +23,13 @@
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
+#include <asm/cpu_ops.h>
 
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
 	IPI_IRQ_WORK,
 	IPI_TIMER,
 	IPI_MAX
@@ -71,6 +74,32 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
+#ifdef CONFIG_KEXEC_CORE
+static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
+
+static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	crash_save_cpu(regs, cpu);
+
+	atomic_dec(&waiting_for_crash_ipi);
+
+	local_irq_disable();
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_has_hotplug(cpu))
+		cpu_ops[cpu]->cpu_stop();
+#endif
+
+	while (1)
+		wait_for_interrupt();
+}
+#else
+static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	unreachable();
+}
+#endif
+
 static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
 
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
@@ -124,8 +153,9 @@ void arch_irq_work_raise(void)
 
 void handle_IPI(struct pt_regs *regs)
 {
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-	unsigned long *stats = ipi_data[smp_processor_id()].stats;
+	unsigned int cpu = smp_processor_id();
+	unsigned long *pending_ipis = &ipi_data[cpu].bits;
+	unsigned long *stats = ipi_data[cpu].stats;
 
 	riscv_clear_ipi();
 
@@ -154,6 +184,10 @@ void handle_IPI(struct pt_regs *regs)
 			ipi_stop();
 		}
 
+		if (ops & (1 << IPI_CPU_CRASH_STOP)) {
+			ipi_cpu_crash_stop(cpu, get_irq_regs());
+		}
+
 		if (ops & (1 << IPI_IRQ_WORK)) {
 			stats[IPI_IRQ_WORK]++;
 			irq_work_run();
@@ -176,6 +210,7 @@ static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 };
@@ -235,6 +270,64 @@ void smp_send_stop(void)
 			   cpumask_pr_args(cpu_online_mask));
 }
 
+#ifdef CONFIG_KEXEC_CORE
+/*
+ * The number of CPUs online, not counting this CPU (which may not be
+ * fully online and so not counted in num_online_cpus()).
+ */
+static inline unsigned int num_other_online_cpus(void)
+{
+	unsigned int this_cpu_online = cpu_online(smp_processor_id());
+
+	return num_online_cpus() - this_cpu_online;
+}
+
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	cpumask_t mask;
+	unsigned long timeout;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	cpus_stopped = 1;
+
+	/*
+	 * If this cpu is the only one alive at this point in time, online or
+	 * not, there are no stop messages to be sent around, so just back out.
+	 */
+	if (num_other_online_cpus() == 0)
+		return;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
+
+	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
+
+	pr_crit("SMP: stopping secondary CPUs\n");
+	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
+
+	/* Wait up to one second for other CPUs to stop */
+	timeout = USEC_PER_SEC;
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
+		udelay(1);
+
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+}
+
+bool smp_crash_stop_failed(void)
+{
+	return (atomic_read(&waiting_for_crash_ipi) > 0);
+}
+#endif
+
 void smp_send_reschedule(int cpu)
 {
 	send_ipi_single(cpu, IPI_RESCHEDULE);
-- 
2.36.1

