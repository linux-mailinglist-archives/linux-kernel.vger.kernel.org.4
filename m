Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED0C6E2D67
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDNXqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDNXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:45:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D979754;
        Fri, 14 Apr 2023 16:44:56 -0700 (PDT)
Message-ID: <20230414232310.754812729@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R05iW7fNVcum8Q+mjf2E3yOsCRNZdrRM4MkZfsXKqKc=;
        b=aUiik8SryxpjaeRHuGDH1CVCPJrHdz4ToboDiBvyrgybp5D/pPkGbz7paiwVK8VODAE0fl
        SgTT+QXtuBbN0fpZxUWKztpQGU0bjPZSUW3fxyRe9IQVkvcbXWq/0x43vpjbVvOarJH7HV
        uIjYrrAOYGCrtSVeXL3Klmw/1hn994FxUZywCAJZ5ETy96ETN4uYpOv1uP93+BscjKqka+
        yexDk6oAjmOIdMrSOugyHKVHXN1255/Us+8JjFFS+8Qfs8u4ygXpDFKFDNp8KDDwtuiQU3
        N8RPw7aSRn8YI2NswkTZsr81vwh3F5+iNvqvFAUv07ki8YW+7xmZPHzCBoIC9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R05iW7fNVcum8Q+mjf2E3yOsCRNZdrRM4MkZfsXKqKc=;
        b=caenbNdiUoGPpEuAuhFVb0nh5RPBSUL+B8V0qrD3LKpWvQp6oNtGy6pLTh0H4xLk3s7H+h
        2RFNt+MohEqWQ1CQ==
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 25/37] parisc: Switch to hotplug core state synchronization
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:44:54 +0200 (CEST)
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
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/Kconfig          |    1 +
 arch/parisc/kernel/process.c |    4 ++--
 arch/parisc/kernel/smp.c     |    7 +++----
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -56,6 +56,7 @@ config PARISC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_IRQ_MIGRATION if SMP
 	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -166,8 +166,8 @@ void arch_cpu_idle_dead(void)
 
 	local_irq_disable();
 
-	/* Tell __cpu_die() that this CPU is now safe to dispose of. */
-	(void)cpu_report_death();
+	/* Tell the core that this CPU is now safe to dispose of. */
+	cpuhp_ap_report_dead();
 
 	/* Ensure that the cache lines are written out. */
 	flush_cache_all_local();
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -500,11 +500,10 @@ int __cpu_disable(void)
 void __cpu_die(unsigned int cpu)
 {
 	pdc_cpu_rendezvous_lock();
+}
 
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
+{
 	pr_info("CPU%u: is shutting down\n", cpu);
 
 	/* set task's state to interruptible sleep */

