Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF986E2D03
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDNXoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDNXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:44:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46655243;
        Fri, 14 Apr 2023 16:44:19 -0700 (PDT)
Message-ID: <20230414232309.385574446@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IHNUiYT/aa+9U/QrFpO4u8KQro95rDNTw6iEEK5ze9o=;
        b=1GGWgmKl+Z16YESLBwfkaJ8pYvl0ibRrRLZ//qbrV6Rn4ejq8Bvi6vo9cC/d06/jSPEXR4
        hvZPrEqwgB1nXc44jqzGpA3g8UhwvIHA09SMd8L91BmwlYgaP2m77BjOpifPA2Jp8FR9F+
        c0G0jy+fXRMuNBDQtZn5Uv5VCIUDjwdIxXIzMKcFSmEiflIS9qbg0CEGaA9Azgv3qTSjMh
        2Q6Nmfsfu+SPkBhJwKselmJZVd9FCtpTg9fyXFZ6j2n8kUoisHbXRgCmcH48m/s4qcThpJ
        o2FriQZJckk/vdgmu5g5vmRYvkI+K74QUFnLD6JN3zpP58uh1nfGpXn5o7XkuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IHNUiYT/aa+9U/QrFpO4u8KQro95rDNTw6iEEK5ze9o=;
        b=cHgI8T+6dl0c5QvmY+jPTGI3Fml5ooLABkADGz2XWt8RyEwXHfElCQYbWkrIndZHTvvRK5
        Onzbq0bjdDoTP8Dg==
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 03/37] x86/smpboot: Avoid pointless delay calibration is TSC
 is synchronized
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:44:18 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TSC is synchronized across sockets then there is no reason in
calibrating the delay for the first CPU which comes up on a socket.

Just reuse the existing calibration value.

This removes 100ms pointlessly wasted time from CPU hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smpboot.c |   38 ++++++++++++++++++++++++--------------
 arch/x86/kernel/tsc.c     |   20 ++++++++++++++++----
 2 files changed, 40 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -178,10 +178,7 @@ static void smp_callin(void)
 	 */
 	apic_ap_setup();
 
-	/*
-	 * Save our processor parameters. Note: this information
-	 * is needed for clock calibration.
-	 */
+	/* Save our processor parameters. */
 	smp_store_cpu_info(cpuid);
 
 	/*
@@ -192,14 +189,6 @@ static void smp_callin(void)
 
 	ap_init_aperfmperf();
 
-	/*
-	 * Get our bogomips.
-	 * Update loops_per_jiffy in cpu_data. Previous call to
-	 * smp_store_cpu_info() stored a value that is close but not as
-	 * accurate as the value just calculated.
-	 */
-	calibrate_delay();
-	cpu_data(cpuid).loops_per_jiffy = loops_per_jiffy;
 	pr_debug("Stack at about %p\n", &cpuid);
 
 	wmb();
@@ -212,8 +201,24 @@ static void smp_callin(void)
 	cpumask_set_cpu(cpuid, cpu_callin_mask);
 }
 
+static void ap_calibrate_delay(void)
+{
+	/*
+	 * Calibrate the delay loop and update loops_per_jiffy in cpu_data.
+	 * smp_store_cpu_info() stored a value that is close but not as
+	 * accurate as the value just calculated.
+	 *
+	 * As this is invoked after the TSC synchronization check,
+	 * calibrate_delay_is_known() will skip the calibration routine
+	 * when TSC is synchronized across sockets.
+	 */
+	calibrate_delay();
+	cpu_data(smp_processor_id()).loops_per_jiffy = loops_per_jiffy;
+}
+
 static int cpu0_logical_apicid;
 static int enable_start_cpu0;
+
 /*
  * Activate a secondary processor.
  */
@@ -240,10 +245,15 @@ static void notrace start_secondary(void
 
 	/* otherwise gcc will move up smp_processor_id before the cpu_init */
 	barrier();
+	/* Check TSC synchronization with the control CPU: */
+	check_tsc_sync_target();
+
 	/*
-	 * Check TSC synchronization with the boot CPU:
+	 * Calibrate the delay loop after the TSC synchronization check.
+	 * This allows to skip the calibration when TSC is synchronized
+	 * across sockets.
 	 */
-	check_tsc_sync_target();
+	ap_calibrate_delay();
 
 	speculative_store_bypass_ht_init();
 
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1598,10 +1598,7 @@ void __init tsc_init(void)
 
 #ifdef CONFIG_SMP
 /*
- * If we have a constant TSC and are using the TSC for the delay loop,
- * we can skip clock calibration if another cpu in the same socket has already
- * been calibrated. This assumes that CONSTANT_TSC applies to all
- * cpus in the socket - this should be a safe assumption.
+ * Check whether existing calibration data can be reused.
  */
 unsigned long calibrate_delay_is_known(void)
 {
@@ -1609,6 +1606,21 @@ unsigned long calibrate_delay_is_known(v
 	int constant_tsc = cpu_has(&cpu_data(cpu), X86_FEATURE_CONSTANT_TSC);
 	const struct cpumask *mask = topology_core_cpumask(cpu);
 
+	/*
+	 * If TSC has constant frequency and TSC is synchronized across
+	 * sockets then reuse CPU0 calibration.
+	 */
+	if (constant_tsc && !tsc_unstable)
+		return cpu_data(0).loops_per_jiffy;
+
+	/*
+	 * If TSC has constant frequency and TSC is not synchronized across
+	 * sockets and this is not the first CPU in the socket, then reuse
+	 * the calibration value of an already online CPU on that socket.
+	 *
+	 * This assumes that CONSTANT_TSC is consistent for all CPUs in a
+	 * socket.
+	 */
 	if (!constant_tsc || !mask)
 		return 0;
 

