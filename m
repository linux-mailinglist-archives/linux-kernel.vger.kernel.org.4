Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666206E2D60
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDNXqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjDNXpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:45:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E685B771;
        Fri, 14 Apr 2023 16:44:55 -0700 (PDT)
Message-ID: <20230414232310.631170657@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=y6SldvuVXq/pw8ptav6ZzZhZk50vNE0+ALorGdATBvE=;
        b=j7ir4M38uyCqNd0WpGFhlMbHqqP22sIUkP6lTXCI4ZoMelPAhB0ZW3jUKq/qNg7dgtIPyr
        wAgHvssp340UT3vn/QZsaFN0BbxJz/50Bk2j/ViCY7pmbdjJltpv6UUhTwyesp5uV/hH5R
        rn30yImLh2MbCenzGtlPdqYodmJQsWXgthmyh3VDgg8IsWfSP8TgZqODKQUJwz+InU8in3
        FyxZW7Fp+CUcayGzDXYKM02cvf34xnDKNWTxsXl+QFRwELU5xV0mCQa2KjOMor4Q501Rct
        0HVatbGD4qEO2xAAV9X3ZovODF8RAMi5ZzvUu9hOjJPsLeNkmpDExwTMMJ6FBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=y6SldvuVXq/pw8ptav6ZzZhZk50vNE0+ALorGdATBvE=;
        b=Qg+tSuukciCk/31JBTMbNipFvroQgicaNOn31ON18qthuCRxjFkOmjqqsu/6PGW7nvHreJ
        GQLRpem8ebEejbCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 23/37] csky/smp: Switch to hotplug core state synchronization
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:44:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the CPU hotplug core state tracking and synchronization
mechanim. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/Kconfig           |    1 +
 arch/csky/include/asm/smp.h |    2 +-
 arch/csky/kernel/smp.c      |    8 ++------
 3 files changed, 4 insertions(+), 7 deletions(-)

--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,6 +96,7 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -23,7 +23,7 @@ void __init set_send_ipi(void (*func)(co
 
 int __cpu_disable(void);
 
-void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 
 #endif /* CONFIG_SMP */
 
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -291,12 +291,8 @@ int __cpu_disable(void)
 	return 0;
 }
 
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: shutdown failed\n", cpu);
-		return;
-	}
 	pr_notice("CPU%u: shutdown\n", cpu);
 }
 
@@ -304,7 +300,7 @@ void arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
 
-	cpu_report_death();
+	cpuhp_ap_report_dead();
 
 	while (!secondary_stack)
 		arch_cpu_idle();

