Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409896F72DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEDTFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjEDTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:04:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C707A24C;
        Thu,  4 May 2023 12:03:32 -0700 (PDT)
Message-ID: <20230504185937.806324260@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PIHn3pYsUJ8IshGaa3kU/Fr0bIJzVI5udpOrlPrYz+E=;
        b=QNGmIIt+/To56nrNKLo3wlp/uoA0S+O2aHLtwODYUDkrU8Guyvv03S4Uol8KKlrIgPdDLI
        qPjhMQNUAIZdRs2om4WUPJMT1jXnWhngn8GF42pSedv+mPXqPDg6dporcNAvFdzUw+egQ+
        Vqg53SlSVRiuRBZMIzV5FPs2l5GIv84C01a0Qxu+Mq65QbnphJFA5Ir3subA78ZM6E8kf2
        ZWThMRZ9iqmdUJfsdKFtkK4qDI92/cMPImPqXf9PZUVb/qwqechT+XgrR1ZcB+r0K7YQf/
        HeZhI+W/xkNZVJpDF4ppx/B//2tg7mVNz3rodO8pj9sfyrrX+kNXbJXXhJW8oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PIHn3pYsUJ8IshGaa3kU/Fr0bIJzVI5udpOrlPrYz+E=;
        b=wXxqyLYYRXuQOss/+ZoLBYE+oLaf2tb90zR4AxAwAajqpA22CmYoLXhycZjVGB2N2Jkdnq
        PQRh0paL0Sj8j3Bw==
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
Subject: [patch V2 27/38] cpu/hotplug: Remove unused state functions
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:42 +0200 (CEST)
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

All users converted to the hotplug core mechanism.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/cpu.h |    2 -
 kernel/smpboot.c    |   75 ----------------------------------------------------
 2 files changed, 77 deletions(-)
---
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -193,8 +193,6 @@ static inline void play_idle(unsigned lo
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-bool cpu_wait_death(unsigned int cpu, int seconds);
-bool cpu_report_death(void);
 void cpuhp_report_idle_dead(void);
 #else
 static inline void cpuhp_report_idle_dead(void) { }
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -325,78 +325,3 @@ void smpboot_unregister_percpu_thread(st
 	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
-
-#ifndef CONFIG_HOTPLUG_CORE_SYNC
-static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
-
-#ifdef CONFIG_HOTPLUG_CPU
-/*
- * Wait for the specified CPU to exit the idle loop and die.
- */
-bool cpu_wait_death(unsigned int cpu, int seconds)
-{
-	int jf_left = seconds * HZ;
-	int oldstate;
-	bool ret = true;
-	int sleep_jf = 1;
-
-	might_sleep();
-
-	/* The outgoing CPU will normally get done quite quickly. */
-	if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
-		goto update_state_early;
-	udelay(5);
-
-	/* But if the outgoing CPU dawdles, wait increasingly long times. */
-	while (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) != CPU_DEAD) {
-		schedule_timeout_uninterruptible(sleep_jf);
-		jf_left -= sleep_jf;
-		if (jf_left <= 0)
-			break;
-		sleep_jf = DIV_ROUND_UP(sleep_jf * 11, 10);
-	}
-update_state_early:
-	oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
-update_state:
-	if (oldstate == CPU_DEAD) {
-		/* Outgoing CPU died normally, update state. */
-		smp_mb(); /* atomic_read() before update. */
-		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_POST_DEAD);
-	} else {
-		/* Outgoing CPU still hasn't died, set state accordingly. */
-		if (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
-					&oldstate, CPU_BROKEN))
-			goto update_state;
-		ret = false;
-	}
-	return ret;
-}
-
-/*
- * Called by the outgoing CPU to report its successful death.  Return
- * false if this report follows the surviving CPU's timing out.
- *
- * A separate "CPU_DEAD_FROZEN" is used when the surviving CPU
- * timed out.  This approach allows architectures to omit calls to
- * cpu_check_up_prepare() and cpu_set_state_online() without defeating
- * the next cpu_wait_death()'s polling loop.
- */
-bool cpu_report_death(void)
-{
-	int oldstate;
-	int newstate;
-	int cpu = smp_processor_id();
-
-	oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
-	do {
-		if (oldstate != CPU_BROKEN)
-			newstate = CPU_DEAD;
-		else
-			newstate = CPU_DEAD_FROZEN;
-	} while (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
-				     &oldstate, newstate));
-	return newstate == CPU_DEAD;
-}
-
-#endif /* #ifdef CONFIG_HOTPLUG_CPU */
-#endif /* !CONFIG_HOTPLUG_CORE_SYNC */

