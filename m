Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF46EF88B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjDZQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:37:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE9076A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:37:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682527021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hn8NieWkqdkuAmPQepj6vdqp9UsnhNDUClAxwfJ3wZA=;
        b=ETL1S7p12kuhdIw1P0NLvO1OWqaBna/2XPVyoFajVnYh7ckAoFmC+g6G7VPsG7mVrer+9q
        KTLGZ/Qg+ao0vTXl0wYAOa0QRQHzCjZbPIfs+FO6O3IBsC4Dunao5j9cgaxMJg2bPrOhd3
        GKaO3jrGRm5ZG9wrW2xdifrWYCeCXBkSFTuug4xNwv0kx5yuzr7rVss6VpTS/xn7HBAlAv
        /ZVcIEvEu55G3/p99/mCb4hNWgT9IfTW1WdV/+r7w3elgkTiPiWOWRHFYFnA3UvLQbBq/4
        rfAmUzR/Uz/jahpMprmrNad2gF8B8zEcHkUoo03R1YvSszCpkPHRief8C6CXBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682527021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hn8NieWkqdkuAmPQepj6vdqp9UsnhNDUClAxwfJ3wZA=;
        b=NgMOoIN9k7onzQn6f7JFsROAq5NXRcleF0ETQ2dZdLKESpYEWYyIkQsB6a2XrZawz/2wN+
        no8P5FpcBkxskmBA==
To:     Tony Battersby <tonyb@cybernetics.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
In-Reply-To: <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com>
Date:   Wed, 26 Apr 2023 18:37:00 +0200
Message-ID: <87y1mey503.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony!

On Wed, Apr 26 2023 at 10:45, Tony Battersby wrote:
> On 4/25/23 17:05, Thomas Gleixner wrote:
> For test #1, I have never used IPI before, so I would have to look into
> how to do that.=C2=A0 Or you could send me a patch to test if you still w=
ant
> the test done.=C2=A0 But test #2 produced results, so maybe it is not
> necessary.

I think we can spare that exercise.

> For test #2, I re-enabled native_wbinvd() by reverting the patch that I
> sent, and then I applied the following patch:
>
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> index 375b33ecafa2..1a9b225c85b6 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -212,6 +212,7 @@ static void native_stop_other_cpus(int wait)
>                         udelay(1);
>         }
>=20=20
> +       mdelay(100);
>         local_irq_save(flags);
>         disable_local_APIC();
>         mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>
> With that I got a successful power-off 10 times in a row.

Thanks for trying this!

The problem really seems to be that the control CPU goes off before the
other CPUs have finished and depending on timing that causes the
wreckage. Otherwise the mdelay(100) would not have helped at all.

But looking at it, that num_online_cpus() =3D=3D 1 check in
stop_other_cpus() is fragile as hell independent of that wbinvd() issue.

Something like the completely untested below should cure that.

Thanks,

        tglx
---
 arch/x86/include/asm/cpu.h |    2 ++
 arch/x86/kernel/process.c  |   10 ++++++++++
 arch/x86/kernel/smp.c      |   15 ++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
=20
+extern atomic_t stop_cpus_count;
+
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -752,6 +752,8 @@ bool xen_set_default_idle(void)
 }
 #endif
=20
+atomic_t stop_cpus_count;
+
 void __noreturn stop_this_cpu(void *dummy)
 {
 	local_irq_disable();
@@ -776,6 +778,14 @@ void __noreturn stop_this_cpu(void *dumm
 	 */
 	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
+
+	/*
+	 * native_stop_other_cpus() will write to @stop_cpus_count after
+	 * observing that it went down to zero, which will invalidate the
+	 * cacheline on this CPU.
+	 */
+	atomic_dec(&stop_cpus_count);
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/apic.h>
+#include <asm/cpu.h>
 #include <asm/idtentry.h>
 #include <asm/nmi.h>
 #include <asm/mce.h>
@@ -171,6 +172,8 @@ static void native_stop_other_cpus(int w
 		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) !=3D -1)
 			return;
=20
+		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
+
 		/* sync above data before sending IRQ */
 		wmb();
=20
@@ -183,12 +186,12 @@ static void native_stop_other_cpus(int w
 		 * CPUs reach shutdown state.
 		 */
 		timeout =3D USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (atomic_read(&stop_cpus_count) > 0 && timeout--)
 			udelay(1);
 	}
=20
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	if (atomic_read(&stop_cpus_count) > 0) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
@@ -208,7 +211,7 @@ static void native_stop_other_cpus(int w
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout =3D USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (atomic_read(&stop_cpus_count) > 0 && (wait || timeout--))
 			udelay(1);
 	}
=20
@@ -216,6 +219,12 @@ static void native_stop_other_cpus(int w
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
+
+	/*
+	 * Ensure that the cache line is invalidated on the other CPUs. See
+	 * comment vs. SME in stop_this_cpu().
+	 */
+	atomic_set(&stop_cpus_count, INT_MAX);
 }
=20
 /*

