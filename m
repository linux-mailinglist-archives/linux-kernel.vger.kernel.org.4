Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB76FB76F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjEHTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjEHTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:45:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56A728D;
        Mon,  8 May 2023 12:44:30 -0700 (PDT)
Message-ID: <20230508185218.354392116@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683575039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XHpNsJs5kSVxMByUTgiKML4QfVv98dxDjLlAQchlqtk=;
        b=Ki8zOz4u2YoGQTHxRWvDCdJpS9rUfG7Rt8el1sEQonOE93FQ2t/Ouh6saOF5zSGR/sUwqy
        RGwztYnIhjpNbF8b2PGA4CfI6IE5cG/4pkd5Q33EfIphmoL8ll1Ul99/6dF/RDkEojrYjr
        EB5pH//XxOfXbRz5/okajpcb/SRh9nL9WoyZaL+b0N+3wBhaYWzQ0JAad4Cix7Pxxq45EN
        qoUV3fffrtSRueog+x/R851Gsai56IVP/bi8/TS243MY3shbpmrcRDIo+w8Qw8dLxfZrAJ
        3jwxSYmT//Hz16/1k1wHeOTfsamwVnUrPFdDAmzXRODZAUOo/yfyrnt7BniKSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683575039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XHpNsJs5kSVxMByUTgiKML4QfVv98dxDjLlAQchlqtk=;
        b=nQqE0LEqpdin/188ms5Eh3E7UO6uD16LhW/aIhEdUgOoCpO7X2+xXn/WMrcSUx9PqrxIEc
        Yg+NuqTDvr5KtUBA==
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
Subject: [patch v3 20/36] cpu/hotplug: Remove cpu_report_state() and related
 unused cruft
References: <20230508181633.089804905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  8 May 2023 21:43:59 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>


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


