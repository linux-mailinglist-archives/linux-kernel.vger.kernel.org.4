Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2AB6F72C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjEDTEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjEDTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:03:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420C7A8A;
        Thu,  4 May 2023 12:02:53 -0700 (PDT)
Message-ID: <20230504185937.423370586@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=axTWYuKGRsLuY3sP+yWW8AcC0JvmEXRH4k+OCDSDm2U=;
        b=JAJHUpAZ99ml9kYEJFLumTtqdUWusgMhRKrkATvPmN/E+Np81ottt9W5maLBM9NBIbWnTJ
        ySXLTT+Kor4hdXfzIlODt/giO0VNStwSizmA019ybO7WFnSPuKbPIPcG3oj4yklxtxS7aU
        n5N8P25WOp3c7sKTlX7jtclRMC9dib+OWP5+g0u3XA7xjm7H0BSCVrqlJV/pGkhcRHSFVC
        ZhGGbdg5oKi9BMbxdVDZ/bAYmjvP7467rF6XY91JkA52gVUbdvWtKdomwEUWHzXE5dZyQO
        7dxtw3w6CHviPJabbTdmg6NJJm327vynExXUs6x1WAljoJBJhWhlKD3vNmVT4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=axTWYuKGRsLuY3sP+yWW8AcC0JvmEXRH4k+OCDSDm2U=;
        b=AkOrbIV4f+h48OPko5LlDDOWxYQnlMZwftJ+TMWfHtwe4frm64xHt5Hf1EzpPa/P2tJZ7D
        0WESNcwn3qKK6QDA==
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch V2 20/38] cpu/hotplug: Remove cpu_report_state() and related
 unused cruft
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:30 +0200 (CEST)
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

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/cpu.h |    2 -
 kernel/smpboot.c    |   90 ----------------------------------------------------
 2 files changed, 92 deletions(-)
---
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -184,8 +184,6 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
 
-int cpu_report_state(int cpu);
-int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
 
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -329,97 +329,7 @@ EXPORT_SYMBOL_GPL(smpboot_unregister_per
 #ifndef CONFIG_HOTPLUG_CORE_SYNC
 static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
 
-/*
- * Called to poll specified CPU's state, for example, when waiting for
- * a CPU to come online.
- */
-int cpu_report_state(int cpu)
-{
-	return atomic_read(&per_cpu(cpu_hotplug_state, cpu));
-}
-
-/*
- * If CPU has died properly, set its state to CPU_UP_PREPARE and
- * return success.  Otherwise, return -EBUSY if the CPU died after
- * cpu_wait_death() timed out.  And yet otherwise again, return -EAGAIN
- * if cpu_wait_death() timed out and the CPU still hasn't gotten around
- * to dying.  In the latter two cases, the CPU might not be set up
- * properly, but it is up to the arch-specific code to decide.
- * Finally, -EIO indicates an unanticipated problem.
- *
- * Note that it is permissible to omit this call entirely, as is
- * done in architectures that do no CPU-hotplug error checking.
- */
-int cpu_check_up_prepare(int cpu)
-{
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
-		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
-		return 0;
-	}
-
-	switch (atomic_read(&per_cpu(cpu_hotplug_state, cpu))) {
-
-	case CPU_POST_DEAD:
-
-		/* The CPU died properly, so just start it up again. */
-		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
-		return 0;
-
-	case CPU_DEAD_FROZEN:
-
-		/*
-		 * Timeout during CPU death, so let caller know.
-		 * The outgoing CPU completed its processing, but after
-		 * cpu_wait_death() timed out and reported the error. The
-		 * caller is free to proceed, in which case the state
-		 * will be reset properly by cpu_set_state_online().
-		 * Proceeding despite this -EBUSY return makes sense
-		 * for systems where the outgoing CPUs take themselves
-		 * offline, with no post-death manipulation required from
-		 * a surviving CPU.
-		 */
-		return -EBUSY;
-
-	case CPU_BROKEN:
-
-		/*
-		 * The most likely reason we got here is that there was
-		 * a timeout during CPU death, and the outgoing CPU never
-		 * did complete its processing.  This could happen on
-		 * a virtualized system if the outgoing VCPU gets preempted
-		 * for more than five seconds, and the user attempts to
-		 * immediately online that same CPU.  Trying again later
-		 * might return -EBUSY above, hence -EAGAIN.
-		 */
-		return -EAGAIN;
-
-	case CPU_UP_PREPARE:
-		/*
-		 * Timeout while waiting for the CPU to show up. Allow to try
-		 * again later.
-		 */
-		return 0;
-
-	default:
-
-		/* Should not happen.  Famous last words. */
-		return -EIO;
-	}
-}
-
-/*
- * Mark the specified CPU online.
- *
- * Note that it is permissible to omit this call entirely, as is
- * done in architectures that do no CPU-hotplug error checking.
- */
-void cpu_set_state_online(int cpu)
-{
-	(void)atomic_xchg(&per_cpu(cpu_hotplug_state, cpu), CPU_ONLINE);
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
-
 /*
  * Wait for the specified CPU to exit the idle loop and die.
  */

