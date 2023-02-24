Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2018E6A1671
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBXF7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBXF7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:59:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391E14987;
        Thu, 23 Feb 2023 21:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677218389; x=1708754389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R5NBjxvkaqtaaJ4TmqWj3x6WJKNUrFtcTEu66pm45sI=;
  b=YI2yTVvA3OFAxncFwjBwtDsRsttck1rR/2nqwW3a8wkYv9OnC70MtVsh
   nzLqtWWTd5snR77K1k87TyzpLb7WArAE9gKUo7BoCGSvkPMCsv0U45OYO
   SOmYOMcQBnWLNiNx2ASlA5ptqigdpv1aiHd4ELK/nHd/kXmREWK3+coTt
   yU9azw/YDLg0au6X0e2W6C4LAjD5ilOnEmhrjBWLFFBqgVFxRadvbBS7J
   DziM1AGD8hTWUps2zK8wm7f3MWdcjj5ejKI9iz1W41u6gReM7fHCRq+PP
   RcKNustVym+lTd3j/exQNYop+vEXRw94GzW3SCoaZTlNMs4Ui4roNV7g8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="334824628"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="334824628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 21:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="672780699"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="672780699"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2023 21:59:41 -0800
Date:   Fri, 24 Feb 2023 13:59:41 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v10 6/8] x86/smpboot: Support parallel startup of
 secondary CPUs
Message-ID: <20230224055941.fbr6wenbdsnzjf7q@yy-desk-7060>
References: <20230221223352.2288528-1-usama.arif@bytedance.com>
 <20230221223352.2288528-7-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221223352.2288528-7-usama.arif@bytedance.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:33:50PM +0000, Usama Arif wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Rework the real-mode startup code to allow for APs to be brought up in
> parallel. This is in two parts:
>
> 1. Introduce a bit-spinlock to prevent them from all using the real
>    mode stack at the same time.
>
> 2. Avoid the use of global variables for passing per-CPU information to
>    the APs.
>
> To achieve the latter, export the cpuid_to_apicid[] array so that each
> AP can find its own per_cpu data (and thus initial_gs, initial_stack and
> early_gdt_descr) by searching therein based on its APIC ID.
>
> Introduce a global variable 'smpboot_control' indicating to the AP how
> it should find its APIC ID. For a serialized bringup, the APIC ID is
> explicitly passed in the low bits of smpboot_control, while for parallel
> mode there are flags directing the AP to find its APIC ID in CPUID leaf
> 0x0b (for X2APIC mode) or CPUID leaf 0x01 where 8 bits are sufficient.
>
> Parallel startup may be disabled by a command line option, and also if:
>  • AMD SEV-ES is in use, since the AP may not use CPUID that early.
>  • X2APIC is enabled, but CPUID leaf 0xb is not present and correect.
>  • X2APIC is not enabled but not even CPUID leaf 0x01 exists.
>
> Aside from the fact that APs will now look up their per-cpu data via the
> newly-exported cpuid_to_apicid[] table, there is no behavioural change
> intended yet, since new parallel CPUHP states have not — yet — been
> added.
>
> [ tglx: Initial proof of concept patch with bitlock and APIC ID lookup ]
> [ dwmw2: Rework and testing, commit message, CPUID 0x1 and CPU0 support ]
> [ seanc: Fix stray override of initial_gs in common_cpu_up() ]
> [ Oleksandr Natalenko: reported suspend/resume issue fixed in
>   x86_acpi_suspend_lowlevel ]
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Kim Phillips <kim.phillips@amd.com>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +
>  arch/x86/include/asm/realmode.h               |  3 +
>  arch/x86/include/asm/smp.h                    | 10 +-
>  arch/x86/kernel/acpi/sleep.c                  |  7 ++
>  arch/x86/kernel/apic/apic.c                   |  2 +-
>  arch/x86/kernel/head_64.S                     | 99 ++++++++++++++++++-
>  arch/x86/kernel/smpboot.c                     | 62 +++++++++++-
>  arch/x86/realmode/init.c                      |  3 +
>  arch/x86/realmode/rm/trampoline_64.S          | 14 +++
>  kernel/smpboot.c                              |  2 +-
>  10 files changed, 197 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..ee099b8aac6d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3819,6 +3819,9 @@
>
>  	nomodule	Disable module load
>
> +	no_parallel_bringup
> +			[X86,SMP] Disable parallel brinugp of secondary cores.
> +
>  	nopat		[X86] Disable PAT (page attribute table extension of
>  			pagetables) support.
>
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index a336feef0af1..f0357cfe2fb0 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -52,6 +52,7 @@ struct trampoline_header {
>  	u64 efer;
>  	u32 cr4;
>  	u32 flags;
> +	u32 lock;
>  #endif
>  };
>
> @@ -65,6 +66,8 @@ extern unsigned long initial_stack;
>  extern unsigned long initial_vc_handler;
>  #endif
>
> +extern u32 *trampoline_lock;
> +
>  extern unsigned char real_mode_blob[];
>  extern unsigned char real_mode_relocs[];
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index b4dbb20dab1a..33c0d5fd8af6 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -199,5 +199,13 @@ extern void nmi_selftest(void);
>  #define nmi_selftest() do { } while (0)
>  #endif
>
> -#endif /* __ASSEMBLY__ */
> +extern unsigned int smpboot_control;
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +/* Control bits for startup_64 */
> +#define STARTUP_SECONDARY	0x80000000
> +#define STARTUP_APICID_CPUID_0B	0x40000000
> +#define STARTUP_APICID_CPUID_01	0x20000000
> +
>  #endif /* _ASM_X86_SMP_H */
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 3b7f4cdbf2e0..47e75c056cb5 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -16,6 +16,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/realmode.h>
>  #include <asm/hypervisor.h>
> +#include <asm/smp.h>
>
>  #include <linux/ftrace.h>
>  #include "../../realmode/rm/wakeup.h"
> @@ -57,6 +58,7 @@ asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8 state)
>   */
>  int x86_acpi_suspend_lowlevel(void)
>  {
> +	unsigned int __maybe_unused saved_smpboot_ctrl;
>  	struct wakeup_header *header =
>  		(struct wakeup_header *) __va(real_mode_header->wakeup_header);
>
> @@ -115,6 +117,8 @@ int x86_acpi_suspend_lowlevel(void)
>  	early_gdt_descr.address =
>  			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
>  	initial_gs = per_cpu_offset(smp_processor_id());
> +	/* Force the startup into boot mode */
> +	saved_smpboot_ctrl = xchg(&smpboot_control, 0);
>  #endif
>  	initial_code = (unsigned long)wakeup_long64;
>         saved_magic = 0x123456789abcdef0L;
> @@ -127,6 +131,9 @@ int x86_acpi_suspend_lowlevel(void)
>  	pause_graph_tracing();
>  	do_suspend_lowlevel();
>  	unpause_graph_tracing();
> +
> +	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_SMP))
> +		smpboot_control = saved_smpboot_ctrl;
>  	return 0;
>  }
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 20d9a604da7c..ac1d7e5da1f2 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2377,7 +2377,7 @@ static int nr_logical_cpuids = 1;
>  /*
>   * Used to store mapping between logical CPU IDs and APIC IDs.
>   */
> -static int cpuid_to_apicid[] = {
> +int cpuid_to_apicid[] = {
>  	[0 ... NR_CPUS - 1] = -1,
>  };
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 222efd4a09bc..0e4e53d231db 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -25,6 +25,7 @@
>  #include <asm/export.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/fixmap.h>
> +#include <asm/smp.h>
>
>  /*
>   * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
> @@ -241,6 +242,83 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	UNWIND_HINT_EMPTY
>  	ANNOTATE_NOENDBR // above
>
> +#ifdef CONFIG_SMP
> +	/*
> +	 * Is this the boot CPU coming up? If so everything is available
> +	 * in initial_gs, initial_stack and early_gdt_descr.
> +	 */
> +	movl	smpboot_control(%rip), %edx
> +	testl	$STARTUP_SECONDARY, %edx
> +	jz	.Lsetup_cpu
> +
> +	/*
> +	 * Secondary CPUs find out the offsets via the APIC ID. For parallel
> +	 * boot the APIC ID is retrieved from CPUID, otherwise it's encoded
> +	 * in smpboot_control:
> +	 * Bit 31	STARTUP_SECONDARY flag (checked above)
> +	 * Bit 30	STARTUP_APICID_CPUID_0B flag (use CPUID 0x0b)
> +	 * Bit 29	STARTUP_APICID_CPUID_01 flag (use CPUID 0x01)
> +	 * Bit 0-24	APIC ID if STARTUP_APICID_CPUID_xx flags are not set
> +	 */
> +	testl	$STARTUP_APICID_CPUID_0B, %edx
> +	jnz	.Luse_cpuid_0b
> +	testl	$STARTUP_APICID_CPUID_01, %edx
> +	jnz	.Luse_cpuid_01
> +	andl	$0x0FFFFFFF, %edx
> +	jmp	.Lsetup_AP
> +
> +.Luse_cpuid_01:
> +	mov	$0x01, %eax
> +	cpuid
> +	mov	%ebx, %edx
> +	shr	$24, %edx
> +	jmp	.Lsetup_AP
> +
> +.Luse_cpuid_0b:
> +	mov	$0x0B, %eax
> +	xorl	%ecx, %ecx
> +	cpuid
> +
> +.Lsetup_AP:
> +	/* EDX contains the APIC ID of the current CPU */
> +	xorq	%rcx, %rcx
> +	leaq	cpuid_to_apicid(%rip), %rbx
> +
> +.Lfind_cpunr:
> +	cmpl	(%rbx,%rcx,4), %edx
> +	jz	.Linit_cpu_data
> +	inc	%ecx
> +	cmpl	nr_cpu_ids(%rip), %ecx
> +	jb	.Lfind_cpunr
> +
> +	/*  APIC ID not found in the table. Drop the trampoline lock and bail. */
> +	movq	trampoline_lock(%rip), %rax
> +	lock
> +	btrl	$0, (%rax)
> +
> +1:	cli
> +	hlt
> +	jmp	1b
> +
> +.Linit_cpu_data:
> +	/* Get the per cpu offset for the given CPU# which is in ECX */
> +	leaq	__per_cpu_offset(%rip), %rbx
> +	movq	(%rbx,%rcx,8), %rbx
> +	/* Save it for GS BASE setup */
> +	movq	%rbx, initial_gs(%rip)
> +
> +	/* Calculate the GDT address */
> +	movq	$gdt_page, %rcx
> +	addq	%rbx, %rcx
> +	movq	%rcx, early_gdt_descr_base(%rip)
> +
> +	/* Find the idle task stack */
> +	movq	idle_threads(%rbx), %rcx
> +	movq	TASK_threadsp(%rcx), %rcx
> +	movq	%rcx, initial_stack(%rip)
> +#endif /* CONFIG_SMP */
> +
> +.Lsetup_cpu:
>  	/*
>  	 * We must switch to a new descriptor in kernel space for the GDT
>  	 * because soon the kernel won't have access anymore to the userspace
> @@ -281,6 +359,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	 */
>  	movq initial_stack(%rip), %rsp
>
> +	/* Drop the realmode protection. For the boot CPU the pointer is NULL! */
> +	movq	trampoline_lock(%rip), %rax
> +	testq	%rax, %rax
> +	jz	.Lsetup_idt
> +	lock
> +	btrl	$0, (%rax)
> +
> +.Lsetup_idt:
>  	/* Setup and Load IDT */
>  	pushq	%rsi
>  	call	early_setup_idt
> @@ -372,7 +458,14 @@ SYM_CODE_END(secondary_startup_64)
>  SYM_CODE_START(start_cpu0)
>  	ANNOTATE_NOENDBR
>  	UNWIND_HINT_EMPTY
> -	movq	initial_stack(%rip), %rsp
> +	/* Load the per-cpu base for CPU#0 */
> +	leaq	__per_cpu_offset(%rip), %rbx
> +	movq	(%rbx), %rbx
> +
> +	/* Find the idle task stack */
> +	movq	idle_threads(%rbx), %rcx
> +	movq	TASK_threadsp(%rcx), %rsp
> +
>  	jmp	.Ljump_to_C_code
>  SYM_CODE_END(start_cpu0)
>  #endif
> @@ -426,6 +519,7 @@ SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
>   * reliably detect the end of the stack.
>   */
>  SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
> +SYM_DATA(trampoline_lock, .quad 0);
>  	__FINITDATA
>
>  	__INIT
> @@ -660,6 +754,9 @@ SYM_DATA_END(level1_fixmap_pgt)
>  SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
>  SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
>
> +	.align 16
> +SYM_DATA(smpboot_control,		.long 0)
> +
>  	.align 16
>  /* This must match the first entry in level2_kernel_pgt */
>  SYM_DATA(phys_base, .quad 0x0)
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b18c1385e181..6924d91b69ca 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -797,6 +797,16 @@ static int __init cpu_init_udelay(char *str)
>  }
>  early_param("cpu_init_udelay", cpu_init_udelay);
>
> +static bool do_parallel_bringup __ro_after_init = true;
> +
> +static int __init no_parallel_bringup(char *str)
> +{
> +	do_parallel_bringup = false;
> +
> +	return 0;
> +}
> +early_param("no_parallel_bringup", no_parallel_bringup);
> +
>  static void __init smp_quirk_init_udelay(void)
>  {
>  	/* if cmdline changed it from default, leave it alone */
> @@ -1084,8 +1094,6 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>  #ifdef CONFIG_X86_32
>  	/* Stack for startup_32 can be just as for start_secondary onwards */
>  	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
> -#else
> -	initial_gs = per_cpu_offset(cpu);
>  #endif
>  	return 0;
>  }
> @@ -1110,9 +1118,14 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  		start_ip = real_mode_header->trampoline_start64;
>  #endif
>  	idle->thread.sp = (unsigned long)task_pt_regs(idle);
> -	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
>  	initial_code = (unsigned long)start_secondary;
> -	initial_stack  = idle->thread.sp;
> +
> +	if (IS_ENABLED(CONFIG_X86_32)) {
> +		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
> +		initial_stack  = idle->thread.sp;
> +	} else if (!do_parallel_bringup) {
> +		smpboot_control = STARTUP_SECONDARY | apicid;
> +	}
>
>  	/* Enable the espfix hack for this CPU */
>  	init_espfix_ap(cpu);
> @@ -1512,6 +1525,47 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>
>  	speculative_store_bypass_ht_init();
>
> +	/*
> +	 * We can do 64-bit AP bringup in parallel if the CPU reports
> +	 * its APIC ID in CPUID (either leaf 0x0B if we need the full
> +	 * APIC ID in X2APIC mode, or leaf 0x01 if 8 bits are
> +	 * sufficient). Otherwise it's too hard. And not for SEV-ES
> +	 * guests because they can't use CPUID that early.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_32) || boot_cpu_data.cpuid_level < 1 ||
> +	    (x2apic_mode && boot_cpu_data.cpuid_level < 0xb) ||
> +	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +		do_parallel_bringup = false;
> +
> +	if (do_parallel_bringup && x2apic_mode) {
> +		unsigned int eax, ebx, ecx, edx;
> +
> +		/*
> +		 * To support parallel bringup in x2apic mode, the AP will need
> +		 * to obtain its APIC ID from CPUID 0x0B, since CPUID 0x01 has
> +		 * only 8 bits. Check that it is present and seems correct.
> +		 */
> +		cpuid_count(0xb, 0, &eax, &ebx, &ecx, &edx);
> +
> +		/*
> +		 * AMD says that if executed with an umimplemented level in
> +		 * ECX, then it will return all zeroes in EAX. Intel says it
> +		 * will return zeroes in both EAX and EBX. Checking only EAX
> +		 * should be sufficient.
> +		 */
> +		if (eax) {
> +			pr_debug("Using CPUID 0xb for parallel CPU startup\n");
> +			smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_0B;
> +		} else {
> +			pr_info("Disabling parallel bringup because CPUID 0xb looks untrustworthy\n");
> +			do_parallel_bringup = false;
> +		}
> +	} else if (do_parallel_bringup) {
> +		/* Without X2APIC, what's in CPUID 0x01 should suffice. */
> +		pr_debug("Using CPUID 0x1 for parallel CPU startup\n");
> +		smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_01;
> +	}
> +
>  	snp_set_wakeup_secondary_cpu();
>  }
>
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index af565816d2ba..788e5559549f 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -154,6 +154,9 @@ static void __init setup_real_mode(void)
>
>  	trampoline_header->flags = 0;
>
> +	trampoline_lock = &trampoline_header->lock;
> +	*trampoline_lock = 0;
> +
>  	trampoline_pgd = (u64 *) __va(real_mode_header->trampoline_pgd);
>
>  	/* Map the real mode stub as virtual == physical */
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index e38d61d6562e..49ebc1636ffd 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -49,6 +49,19 @@ SYM_CODE_START(trampoline_start)
>  	mov	%ax, %es
>  	mov	%ax, %ss
>
> +	/*
> +	 * Make sure only one CPU fiddles with the realmode stack
> +	 */
> +.Llock_rm:
> +	btl	$0, tr_lock
> +	jnc	2f
> +	pause
> +	jmp	.Llock_rm
> +2:
> +	lock
> +	btsl	$0, tr_lock
> +	jc	.Llock_rm
> +

Looks these changes should be applied to trampoline_start64()
yet, which is used for boot up APs when apic->wakeup_secondary_cpu_64
is available, e.g when ACPI_MADT_TYPE_MULTIPROC_WAKEUP is available.

One case I know is the INTEL TD guest, which using the MADT wakeup
for AP wake up now.

>  	# Setup stack
>  	movl	$rm_stack_end, %esp
>
> @@ -241,6 +254,7 @@ SYM_DATA_START(trampoline_header)
>  	SYM_DATA(tr_efer,		.space 8)
>  	SYM_DATA(tr_cr4,		.space 4)
>  	SYM_DATA(tr_flags,		.space 4)
> +	SYM_DATA(tr_lock,		.space 4)
>  SYM_DATA_END(trampoline_header)
>
>  #include "trampoline_common.S"
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index 2c7396da470c..a18a21dff9bc 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -25,7 +25,7 @@
>   * For the hotplug case we keep the task structs around and reuse
>   * them.
>   */
> -static DEFINE_PER_CPU(struct task_struct *, idle_threads);
> +DEFINE_PER_CPU(struct task_struct *, idle_threads);
>
>  struct task_struct *idle_thread_get(unsigned int cpu)
>  {
> --
> 2.25.1
>
