Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01732701939
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjEMScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEMScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:32:45 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3071B1FDA
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:32:42 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3E98A130F201;
        Sat, 13 May 2023 20:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1684002754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRMdV3qzOVMwmQcnB02GoMJuuadMUEoFe1zlRRYP5Zw=;
        b=BYkiLxOIWN8IVtlF+nUBPTMaSvVLLm07F0DHp73Z+Eb7fP5wfHLu6+z3tHtGudVAjPmDGo
        cMZS4YuquHcnYJ9oS7feOQiSz26jdOO3YZzY3i1btzZDXY+EaLoZDj8CRG0dAnOPQirDG2
        m5QBpNJvNrr34slkYe3VXn3/zoEgtxo=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [patch V4 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Date:   Sat, 13 May 2023 20:32:31 +0200
Message-ID: <12207466.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20230512203426.452963764@linutronix.de>
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On p=C3=A1tek 12. kv=C4=9Btna 2023 23:06:56 CEST Thomas Gleixner wrote:
> Hi!
>=20
> This is version 4 of the reworked parallel bringup series. Version 3 can =
be
> found here:
>=20
>    https://lore.kernel.org/lkml/20230508181633.089804905@linutronix.de
>=20
> This is just a reiteration to address the following details:
>=20
>   1) Address review feedback (Peter Zijlstra)
>=20
>   2) Fix a MIPS related build problem (0day)
>=20
> Other than that there are no changes and the other details are all the sa=
me
> as in V3 and V2.
>=20
> It's also available from git:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git hotplug
>=20
> Diff to V3 below.
>=20
> Thanks,
>=20
> 	tglx

With this patchset:

```

[    0.137719] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.777312] smpboot: CPU0: AMD Ryzen 9 5950X 16-Core Processor (family: =
0x19, model: 0x21, stepping: 0x2)
[    0.777896] smpboot: Parallel CPU startup enabled: 0x80000000
```

Seems to survive suspend/resume cycle too.

Hence:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

> ---
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index f5e0f4235746..90c71d800b59 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -690,7 +690,7 @@ void flush_tlb_one(unsigned long vaddr)
>  EXPORT_SYMBOL(flush_tlb_page);
>  EXPORT_SYMBOL(flush_tlb_one);
> =20
> -#ifdef CONFIG_HOTPLUG_CPU
> +#ifdef CONFIG_HOTPLUG_CORE_SYNC_DEAD
>  void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
>  {
>  	if (mp_ops->cleanup_dead_cpu)
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 0438802031c3..9cd77d319555 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -290,8 +290,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
> =20
>  	/*  APIC ID not found in the table. Drop the trampoline lock and bail. =
*/
>  	movq	trampoline_lock(%rip), %rax
> -	lock
> -	btrl	$0, (%rax)
> +	movl	$0, (%rax)
> =20
>  1:	cli
>  	hlt
> @@ -320,8 +319,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
>  	movq	trampoline_lock(%rip), %rax
>  	testq	%rax, %rax
>  	jz	.Lsetup_gdt
> -	lock
> -	btrl	$0, (%rax)
> +	movl	$0, (%rax)
> =20
>  .Lsetup_gdt:
>  	/*
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 5caf4897b507..660709e94823 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -161,31 +161,28 @@ static inline void smpboot_restore_warm_reset_vecto=
r(void)
> =20
>  }
> =20
> -/*
> - * Report back to the Boot Processor during boot time or to the caller p=
rocessor
> - * during CPU online.
> - */
> -static void smp_callin(void)
> +/* Run the next set of setup steps for the upcoming CPU */
> +static void ap_starting(void)
>  {
>  	int cpuid =3D smp_processor_id();
> =20
>  	/*
> -	 * If waken up by an INIT in an 82489DX configuration the alive
> -	 * synchronization guarantees we don't get here before an
> -	 * INIT_deassert IPI reaches our local APIC, so it is now safe to
> -	 * touch our local APIC.
> +	 * If woken up by an INIT in an 82489DX configuration the alive
> +	 * synchronization guarantees that the CPU does not reach this
> +	 * point before an INIT_deassert IPI reaches the local APIC, so it
> +	 * is now safe to touch the local APIC.
>  	 *
>  	 * Set up this CPU, first the APIC, which is probably redundant on
>  	 * most boards.
>  	 */
>  	apic_ap_setup();
> =20
> -	/* Save our processor parameters. */
> +	/* Save the processor parameters. */
>  	smp_store_cpu_info(cpuid);
> =20
>  	/*
>  	 * The topology information must be up to date before
> -	 * calibrate_delay() and notify_cpu_starting().
> +	 * notify_cpu_starting().
>  	 */
>  	set_cpu_sibling_map(cpuid);
> =20
> @@ -197,7 +194,7 @@ static void smp_callin(void)
> =20
>  	/*
>  	 * This runs the AP through all the cpuhp states to its target
> -	 * state (CPUHP_ONLINE in the case of serial bringup).
> +	 * state CPUHP_ONLINE.
>  	 */
>  	notify_cpu_starting(cpuid);
>  }
> @@ -274,10 +271,7 @@ static void notrace start_secondary(void *unused)
>  	rcu_cpu_starting(raw_smp_processor_id());
>  	x86_cpuinit.early_percpu_clock_init();
> =20
> -	smp_callin();
> -
> -	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
> -	barrier();
> +	ap_starting();
> =20
>  	/* Check TSC synchronization with the control CPU. */
>  	check_tsc_sync_target();
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/=
trampoline_64.S
> index 2dfb1c400167..c6de4deec746 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -40,17 +40,13 @@
>  .macro LOAD_REALMODE_ESP
>  	/*
>  	 * Make sure only one CPU fiddles with the realmode stack
> -	 */
> +	*/
>  .Llock_rm\@:
> -	btl	$0, tr_lock
> -	jnc	2f
> -	pause
> -	jmp	.Llock_rm\@
> +        lock btsl       $0, tr_lock
> +        jnc             2f
> +        pause
> +        jmp             .Llock_rm\@
>  2:
> -	lock
> -	btsl	$0, tr_lock
> -	jc	.Llock_rm\@
> -
>  	# Setup stack
>  	movl	$rm_stack_end, %esp
>  .endm
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 60b4093fae9e..005f863a3d2b 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -294,14 +294,14 @@ enum cpuhp_sync_state {
>   * cpuhp_ap_update_sync_state - Update synchronization state during brin=
gup/teardown
>   * @state:	The synchronization state to set
>   *
> - * No synchronization point. Just update of the synchronization state.
> + * No synchronization point. Just update of the synchronization state, b=
ut implies
> + * a full barrier so that the AP changes are visible before the control =
CPU proceeds.
>   */
>  static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state stat=
e)
>  {
>  	atomic_t *st =3D this_cpu_ptr(&cpuhp_state.ap_sync_state);
> -	int sync =3D atomic_read(st);
> =20
> -	while (!atomic_try_cmpxchg(st, &sync, state));
> +	(void)atomic_xchg(st, state);
>  }
> =20
>  void __weak arch_cpuhp_sync_state_poll(void) { cpu_relax(); }
> @@ -829,7 +829,11 @@ static int bringup_cpu(unsigned int cpu)
>  	/*
>  	 * Some architectures have to walk the irq descriptors to
>  	 * setup the vector space for the cpu which comes online.
> -	 * Prevent irq alloc/free across the bringup.
> +	 *
> +	 * Prevent irq alloc/free across the bringup by acquiring the
> +	 * sparse irq lock. Hold it until the upcoming CPU completes the
> +	 * startup in cpuhp_online_idle() which allows to avoid
> +	 * intermediate synchronization points in the architecture code.
>  	 */
>  	irq_lock_sparse();
> =20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


