Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC86F72B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjEDTES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEDTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:03:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8378692;
        Thu,  4 May 2023 12:02:48 -0700 (PDT)
Message-ID: <20230504185937.753526411@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t+vCm64b4itQSl2LfKU8VrA27XKQ2KG5zUbd2mh4iV8=;
        b=ml6E+TXawV3yhhGCubFqgqufAZpTjpSiELyk/vrlZ3ms0dhrtAmXtDWQA1yMzAcLqw6EXj
        bFhc2tyQcBuQ33Bsz5zsKXgWIdU4zRB8yjhEhspCgWXshlokE4Q+JyTBI+TjRiiOk+rcml
        fl/hAT8Iw2GAj9Ot9oyk6BKqozcGuo7sJpNIvJzE2R06g9w52Mgyku0JBRkEGvJz486uRf
        KmExkb3oHx2qMv2bo4NLcSHevFECI+NeAIr4un5UMnquDQpRk4nWHteXJM1j5VItMYBQJc
        o8sXV0liH2x+qJwyn7FfgcHXOI887Tp59x5IcGaiawsgGKlKejdPBbAmAX9ZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t+vCm64b4itQSl2LfKU8VrA27XKQ2KG5zUbd2mh4iV8=;
        b=9+U6SgXZ5rZ8A4IIpjwy8ijpc6qsJ1JIDkx+eqNJ7PC4GKp6PdTneYgE7ZC/9vOEWcjfFc
        AmLbek9quVdxpeCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [patch V2 26/38] riscv: Switch to hotplug core state synchronization
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:40 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Switch to the CPU hotplug core state tracking and synchronization
mechanim. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org

---
 arch/riscv/Kconfig              |    1 +
 arch/riscv/include/asm/smp.h    |    2 +-
 arch/riscv/kernel/cpu-hotplug.c |   14 +++++++-------
 3 files changed, 9 insertions(+), 8 deletions(-)
---
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -122,6 +122,7 @@ config RISCV
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -70,7 +70,7 @@ asmlinkage void smp_callin(void);
 
 #if defined CONFIG_HOTPLUG_CPU
 int __cpu_disable(void);
-void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 #endif /* CONFIG_HOTPLUG_CPU */
 
 #else
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <linux/irq.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpu.h>
 #include <linux/sched/hotplug.h>
 #include <asm/irq.h>
@@ -49,17 +50,15 @@ int __cpu_disable(void)
 	return ret;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
- * Called on the thread which is asking for a CPU to be shutdown.
+ * Called on the thread which is asking for a CPU to be shutdown, if the
+ * CPU reported dead to the hotplug core.
  */
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
 	int ret = 0;
 
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_err("CPU %u: didn't die\n", cpu);
-		return;
-	}
 	pr_notice("CPU%u: off\n", cpu);
 
 	/* Verify from the firmware if the cpu is really stopped*/
@@ -76,9 +75,10 @@ void __noreturn arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
 
-	(void)cpu_report_death();
+	cpuhp_ap_report_dead();
 
 	cpu_ops[smp_processor_id()]->cpu_stop();
 	/* It should never reach here */
 	BUG();
 }
+#endif

