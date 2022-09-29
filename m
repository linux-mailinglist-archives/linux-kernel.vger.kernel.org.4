Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5321A5EF6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiI2N4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiI2N4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:56:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A341109610
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664459772; x=1695995772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WwbuSrIureuAESIsPqRwHu3uZ+jBu9bXhmfVTHj1FQA=;
  b=GidSncxfnGkVtXLIDX0ISMHyntuT1WyUPMAXGFddIHX8GDO9ZWIwJUzg
   4sOj1Pdtz2qA4N3FEpsCmo95tIqCCBU0z/T9mOmZBH6S68LBenD8RmP8k
   k4Oj+bxSts7bv+p/AEUgIF6+ZQrJHRf9te+YPCiv6jPYcBs/RfPq2Xpi8
   2jtNuxV1L8IocilhddUfWVEMBkBtUylv47hl/HAZ2zqeRJAiXKZlBYqE5
   bLLW0EkJnj1hPRz7riwEhUIJdL/hDeWqWt03mcbGb6eaYByfX246mhetk
   eaTYtzPRCtQ0TNLGNbQSRvttR3P2B3A0ZRbbi6ZhE2IVmKVjbvPzEmxOk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="301873361"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="301873361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 06:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="690831120"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="690831120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2022 06:56:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odu1H-009Q6C-2P;
        Thu, 29 Sep 2022 16:56:07 +0300
Date:   Thu, 29 Sep 2022 16:56:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ferry Toth <fntoth@gmail.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Message-ID: <YzWj9zjTJI3RCDf2@smile.fi.intel.com>
References: <cover.1613243844.git.luto@kernel.org>
 <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Ferry

On Sat, Feb 13, 2021 at 11:19:44AM -0800, Andy Lutomirski wrote:
> On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> percpu storage.  It's even nastier because it means that whether %gs
> contains userspace state or kernel state while running kernel code
> depends on whether stackprotector is enabled (this is
> CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> that segment selectors work.  Supporting both variants is a
> maintenance and testing mess.
> 
> Merely rearranging so that percpu and the stack canary
> share the same segment would be messy as the 32-bit percpu address
> layout isn't currently compatible with putting a variable at a fixed
> offset.
> 
> Fortunately, GCC 8.1 added options that allow the stack canary to be
> accessed as %fs:__stack_chk_guard, effectively turning it into an ordinary
> percpu variable.  This lets us get rid of all of the code to manage the
> stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> 
> (That name is special.  We could use any symbol we want for the
>  %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to let us use any
>  name other than __stack_chk_guard.)
> 
> This patch forcibly disables stackprotector on older compilers that
> don't support the new options and makes the stack canary into a
> percpu variable.  The "lazy GS" approach is now used for all 32-bit
> configurations.
> 
> This patch also makes load_gs_index() work on 32-bit kernels.  On
> 64-bit kernels, it loads the GS selector and updates the user
> GSBASE accordingly.  (This is unchanged.)  On 32-bit kernels,
> it loads the GS selector and updates GSBASE, which is now
> always the user base.  This means that the overall effect is
> the same on 32-bit and 64-bit, which avoids some ifdeffery.

This patch broke 32-bit boot on Intel Merrifield

git bisect start
# good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
# bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect bad 62fb9874f5da54fdb243003b386128037319b219
# bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.13
git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
# good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag 'regulator-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
git bisect good ca62e9090d229926f43f20291bb44d67897baab7
# bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
# good: [49c70ece54b0d1c51bc31b2b0c1070777c992c26] drm/amd/display: Change input parameter for set_drr
git bisect good 49c70ece54b0d1c51bc31b2b0c1070777c992c26
# good: [0b276e470a4d43e1365d3eb53c608a3d208cabd4] media: coda: fix macroblocks count control usage
git bisect good 0b276e470a4d43e1365d3eb53c608a3d208cabd4
# bad: [c6536676c7fe3f572ba55842e59c3c71c01e7fb3] Merge tag 'x86_core_for_v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad c6536676c7fe3f572ba55842e59c3c71c01e7fb3
# good: [d1466bc583a81830cef2399a4b8a514398351b40] Merge branch 'work.inode-type-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good d1466bc583a81830cef2399a4b8a514398351b40
# good: [fafe1e39ed213221c0bce6b0b31669334368dc97] Merge tag 'afs-netfs-lib-20210426' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect good fafe1e39ed213221c0bce6b0b31669334368dc97
# bad: [b1f480bc0686e65d5413c035bd13af2ea4888784] Merge branch 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve a semantic conflict
git bisect bad b1f480bc0686e65d5413c035bd13af2ea4888784
# bad: [0c925c61dae18ee3cb93a61cc9dd9562a066034d] x86/tools/insn_decoder_test: Convert to insn_decode()
git bisect bad 0c925c61dae18ee3cb93a61cc9dd9562a066034d
# bad: [514ef77607b9ff184c11b88e8f100bc27f07460d] x86/boot/compressed/sev-es: Convert to insn_decode()
git bisect bad 514ef77607b9ff184c11b88e8f100bc27f07460d
# bad: [9e761296c52dcdb1aaa151b65bd39accb05740d9] x86/insn: Rename insn_decode() to insn_decode_from_regs()
git bisect bad 9e761296c52dcdb1aaa151b65bd39accb05740d9
# bad: [d0962f2b24c99889a386f0658c71535f56358f77] x86/entry/32: Remove leftover macros after stackprotector cleanups
git bisect bad d0962f2b24c99889a386f0658c71535f56358f77
# bad: [3fb0fdb3bbe7aed495109b3296b06c2409734023] x86/stackprotector/32: Make the canary into a regular percpu variable
git bisect bad 3fb0fdb3bbe7aed495109b3296b06c2409734023
# first bad commit: [3fb0fdb3bbe7aed495109b3296b06c2409734023] x86/stackprotector/32: Make the canary into a regular percpu variable

Any suggestions how to fix are welcome!

Configuration is based on in-tree i386_defconfig with some drivers enabled
on top (no core stuff was altered, but if you wish to check, it's here:
https://github.com/andy-shev/linux/blob/eds-acpi/arch/x86/configs/i386_defconfig).

> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/Kconfig                          |  7 +-
>  arch/x86/Makefile                         |  8 +++
>  arch/x86/entry/entry_32.S                 | 56 ++--------------
>  arch/x86/include/asm/processor.h          | 15 ++---
>  arch/x86/include/asm/ptrace.h             |  5 +-
>  arch/x86/include/asm/segment.h            | 30 +++------
>  arch/x86/include/asm/stackprotector.h     | 79 +++++------------------
>  arch/x86/include/asm/suspend_32.h         |  6 +-
>  arch/x86/kernel/asm-offsets_32.c          |  5 --
>  arch/x86/kernel/cpu/common.c              |  5 +-
>  arch/x86/kernel/doublefault_32.c          |  4 +-
>  arch/x86/kernel/head_32.S                 | 18 +-----
>  arch/x86/kernel/setup_percpu.c            |  1 -
>  arch/x86/kernel/tls.c                     |  8 +--
>  arch/x86/kvm/svm/svm.c                    | 10 +--
>  arch/x86/lib/insn-eval.c                  |  4 --
>  arch/x86/platform/pvh/head.S              | 14 ----
>  arch/x86/power/cpu.c                      |  6 +-
>  arch/x86/xen/enlighten_pv.c               |  1 -
>  scripts/gcc-x86_32-has-stack-protector.sh |  6 +-
>  20 files changed, 62 insertions(+), 226 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..12d8bf011d08 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -353,10 +353,6 @@ config X86_64_SMP
>  	def_bool y
>  	depends on X86_64 && SMP
>  
> -config X86_32_LAZY_GS
> -	def_bool y
> -	depends on X86_32 && !STACKPROTECTOR
> -
>  config ARCH_SUPPORTS_UPROBES
>  	def_bool y
>  
> @@ -379,7 +375,8 @@ config CC_HAS_SANE_STACKPROTECTOR
>  	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
>  	help
>  	   We have to make sure stack protector is unconditionally disabled if
> -	   the compiler produces broken code.
> +	   the compiler produces broken code or if it does not let us control
> +	   the segment on 32-bit kernels.
>  
>  menu "Processor type and features"
>  
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7116da3980be..0b5cd8c49ccb 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -76,6 +76,14 @@ ifeq ($(CONFIG_X86_32),y)
>  
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS += -ffreestanding
> +
> +	ifeq ($(CONFIG_STACKPROTECTOR),y)
> +		ifeq ($(CONFIG_SMP),y)
> +			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
> +		else
> +			KBUILD_CFLAGS += -mstack-protector-guard=global
> +		endif
> +	endif
>  else
>          BITS := 64
>          UTS_MACHINE := x86_64
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index df8c017e6161..eb0cb662bca5 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -20,7 +20,7 @@
>   *	1C(%esp) - %ds
>   *	20(%esp) - %es
>   *	24(%esp) - %fs
> - *	28(%esp) - %gs		saved iff !CONFIG_X86_32_LAZY_GS
> + *	28(%esp) - unused -- was %gs on old stackprotector kernels
>   *	2C(%esp) - orig_eax
>   *	30(%esp) - %eip
>   *	34(%esp) - %cs
> @@ -56,14 +56,9 @@
>  /*
>   * User gs save/restore
>   *
> - * %gs is used for userland TLS and kernel only uses it for stack
> - * canary which is required to be at %gs:20 by gcc.  Read the comment
> - * at the top of stackprotector.h for more info.
> - *
> - * Local labels 98 and 99 are used.
> + * This is leftover junk from CONFIG_X86_32_LAZY_GS.  A subsequent patch
> + * will remove it entirely.
>   */
> -#ifdef CONFIG_X86_32_LAZY_GS
> -
>   /* unfortunately push/pop can't be no-op */
>  .macro PUSH_GS
>  	pushl	$0
> @@ -86,49 +81,6 @@
>  .macro SET_KERNEL_GS reg
>  .endm
>  
> -#else	/* CONFIG_X86_32_LAZY_GS */
> -
> -.macro PUSH_GS
> -	pushl	%gs
> -.endm
> -
> -.macro POP_GS pop=0
> -98:	popl	%gs
> -  .if \pop <> 0
> -	add	$\pop, %esp
> -  .endif
> -.endm
> -.macro POP_GS_EX
> -.pushsection .fixup, "ax"
> -99:	movl	$0, (%esp)
> -	jmp	98b
> -.popsection
> -	_ASM_EXTABLE(98b, 99b)
> -.endm
> -
> -.macro PTGS_TO_GS
> -98:	mov	PT_GS(%esp), %gs
> -.endm
> -.macro PTGS_TO_GS_EX
> -.pushsection .fixup, "ax"
> -99:	movl	$0, PT_GS(%esp)
> -	jmp	98b
> -.popsection
> -	_ASM_EXTABLE(98b, 99b)
> -.endm
> -
> -.macro GS_TO_REG reg
> -	movl	%gs, \reg
> -.endm
> -.macro REG_TO_PTGS reg
> -	movl	\reg, PT_GS(%esp)
> -.endm
> -.macro SET_KERNEL_GS reg
> -	movl	$(__KERNEL_STACK_CANARY), \reg
> -	movl	\reg, %gs
> -.endm
> -
> -#endif /* CONFIG_X86_32_LAZY_GS */
>  
>  /* Unconditionally switch to user cr3 */
>  .macro SWITCH_TO_USER_CR3 scratch_reg:req
> @@ -779,7 +731,7 @@ SYM_CODE_START(__switch_to_asm)
>  
>  #ifdef CONFIG_STACKPROTECTOR
>  	movl	TASK_stack_canary(%edx), %ebx
> -	movl	%ebx, PER_CPU_VAR(stack_canary)+stack_canary_offset
> +	movl	%ebx, PER_CPU_VAR(__stack_chk_guard)
>  #endif
>  
>  #ifdef CONFIG_RETPOLINE
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index c20a52b5534b..c59dff4bbc38 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -441,6 +441,9 @@ struct fixed_percpu_data {
>  	 * GCC hardcodes the stack canary as %gs:40.  Since the
>  	 * irq_stack is the object at %gs:0, we reserve the bottom
>  	 * 48 bytes of the irq stack for the canary.
> +	 *
> +	 * Once we are willing to require -mstack-protector-guard-symbol=
> +	 * support for x86_64 stackprotector, we can get rid of this.
>  	 */
>  	char		gs_base[40];
>  	unsigned long	stack_canary;
> @@ -461,17 +464,7 @@ extern asmlinkage void ignore_sysret(void);
>  void current_save_fsgs(void);
>  #else	/* X86_64 */
>  #ifdef CONFIG_STACKPROTECTOR
> -/*
> - * Make sure stack canary segment base is cached-aligned:
> - *   "For Intel Atom processors, avoid non zero segment base address
> - *    that is not aligned to cache line boundary at all cost."
> - * (Optim Ref Manual Assembly/Compiler Coding Rule 15.)
> - */
> -struct stack_canary {
> -	char __pad[20];		/* canary at %gs:20 */
> -	unsigned long canary;
> -};
> -DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
> +DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
>  #endif
>  /* Per CPU softirq stack pointer */
>  DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index d8324a236696..b2c4c12d237c 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -37,7 +37,10 @@ struct pt_regs {
>  	unsigned short __esh;
>  	unsigned short fs;
>  	unsigned short __fsh;
> -	/* On interrupt, gs and __gsh store the vector number. */
> +	/*
> +	 * On interrupt, gs and __gsh store the vector number.  They never
> +	 * store gs any more.
> +	 */
>  	unsigned short gs;
>  	unsigned short __gsh;
>  	/* On interrupt, this is the error code. */
> diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
> index 7fdd4facfce7..72044026eb3c 100644
> --- a/arch/x86/include/asm/segment.h
> +++ b/arch/x86/include/asm/segment.h
> @@ -95,7 +95,7 @@
>   *
>   *  26 - ESPFIX small SS
>   *  27 - per-cpu			[ offset to per-cpu data area ]
> - *  28 - stack_canary-20		[ for stack protector ]		<=== cacheline #8
> + *  28 - unused
>   *  29 - unused
>   *  30 - unused
>   *  31 - TSS for double fault handler
> @@ -118,7 +118,6 @@
>  
>  #define GDT_ENTRY_ESPFIX_SS		26
>  #define GDT_ENTRY_PERCPU		27
> -#define GDT_ENTRY_STACK_CANARY		28
>  
>  #define GDT_ENTRY_DOUBLEFAULT_TSS	31
>  
> @@ -158,12 +157,6 @@
>  # define __KERNEL_PERCPU		0
>  #endif
>  
> -#ifdef CONFIG_STACKPROTECTOR
> -# define __KERNEL_STACK_CANARY		(GDT_ENTRY_STACK_CANARY*8)
> -#else
> -# define __KERNEL_STACK_CANARY		0
> -#endif
> -
>  #else /* 64-bit: */
>  
>  #include <asm/cache.h>
> @@ -364,22 +357,15 @@ static inline void __loadsegment_fs(unsigned short value)
>  	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
>  
>  /*
> - * x86-32 user GS accessors:
> + * x86-32 user GS accessors.  This is ugly and could do with some cleaning up.
>   */
>  #ifdef CONFIG_X86_32
> -# ifdef CONFIG_X86_32_LAZY_GS
> -#  define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
> -#  define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
> -#  define task_user_gs(tsk)		((tsk)->thread.gs)
> -#  define lazy_save_gs(v)		savesegment(gs, (v))
> -#  define lazy_load_gs(v)		loadsegment(gs, (v))
> -# else	/* X86_32_LAZY_GS */
> -#  define get_user_gs(regs)		(u16)((regs)->gs)
> -#  define set_user_gs(regs, v)		do { (regs)->gs = (v); } while (0)
> -#  define task_user_gs(tsk)		(task_pt_regs(tsk)->gs)
> -#  define lazy_save_gs(v)		do { } while (0)
> -#  define lazy_load_gs(v)		do { } while (0)
> -# endif	/* X86_32_LAZY_GS */
> +# define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
> +# define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
> +# define task_user_gs(tsk)		((tsk)->thread.gs)
> +# define lazy_save_gs(v)		savesegment(gs, (v))
> +# define lazy_load_gs(v)		loadsegment(gs, (v))
> +# define load_gs_index(v)		loadsegment(gs, (v))
>  #endif	/* X86_32 */
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
> index 7fb482f0f25b..b6ffe58c70fa 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -5,30 +5,23 @@
>   * Stack protector works by putting predefined pattern at the start of
>   * the stack frame and verifying that it hasn't been overwritten when
>   * returning from the function.  The pattern is called stack canary
> - * and unfortunately gcc requires it to be at a fixed offset from %gs.
> - * On x86_64, the offset is 40 bytes and on x86_32 20 bytes.  x86_64
> - * and x86_32 use segment registers differently and thus handles this
> - * requirement differently.
> + * and unfortunately gcc historically required it to be at a fixed offset
> + * from the percpu segment base.  On x86_64, the offset is 40 bytes.
>   *
> - * On x86_64, %gs is shared by percpu area and stack canary.  All
> - * percpu symbols are zero based and %gs points to the base of percpu
> - * area.  The first occupant of the percpu area is always
> - * fixed_percpu_data which contains stack_canary at offset 40.  Userland
> - * %gs is always saved and restored on kernel entry and exit using
> - * swapgs, so stack protector doesn't add any complexity there.
> + * The same segment is shared by percpu area and stack canary.  On
> + * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
> + * base of percpu area.  The first occupant of the percpu area is always
> + * fixed_percpu_data which contains stack_canary at the approproate
> + * offset.  On x86_32, the stack canary is just a regular percpu
> + * variable.
>   *
> - * On x86_32, it's slightly more complicated.  As in x86_64, %gs is
> - * used for userland TLS.  Unfortunately, some processors are much
> - * slower at loading segment registers with different value when
> - * entering and leaving the kernel, so the kernel uses %fs for percpu
> - * area and manages %gs lazily so that %gs is switched only when
> - * necessary, usually during task switch.
> + * Putting percpu data in %fs on 32-bit is a minor optimization compared to
> + * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
> + * to load 0 into %fs on exit to usermode, whereas with percpu data in
> + * %gs, we are likely to load a non-null %gs on return to user mode.
>   *
> - * As gcc requires the stack canary at %gs:20, %gs can't be managed
> - * lazily if stack protector is enabled, so the kernel saves and
> - * restores userland %gs on kernel entry and exit.  This behavior is
> - * controlled by CONFIG_X86_32_LAZY_GS and accessors are defined in
> - * system.h to hide the details.
> + * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
> + * support, we can remove some of this complexity.
>   */
>  
>  #ifndef _ASM_STACKPROTECTOR_H
> @@ -44,14 +37,6 @@
>  #include <linux/random.h>
>  #include <linux/sched.h>
>  
> -/*
> - * 24 byte read-only segment initializer for stack canary.  Linker
> - * can't handle the address bit shifting.  Address will be set in
> - * head_32 for boot CPU and setup_per_cpu_areas() for others.
> - */
> -#define GDT_STACK_CANARY_INIT						\
> -	[GDT_ENTRY_STACK_CANARY] = GDT_ENTRY_INIT(0x4090, 0, 0x18),
> -
>  /*
>   * Initialize the stackprotector canary value.
>   *
> @@ -86,7 +71,7 @@ static __always_inline void boot_init_stack_canary(void)
>  #ifdef CONFIG_X86_64
>  	this_cpu_write(fixed_percpu_data.stack_canary, canary);
>  #else
> -	this_cpu_write(stack_canary.canary, canary);
> +	this_cpu_write(__stack_chk_guard, canary);
>  #endif
>  }
>  
> @@ -95,48 +80,16 @@ static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
>  #ifdef CONFIG_X86_64
>  	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
>  #else
> -	per_cpu(stack_canary.canary, cpu) = idle->stack_canary;
> -#endif
> -}
> -
> -static inline void setup_stack_canary_segment(int cpu)
> -{
> -#ifdef CONFIG_X86_32
> -	unsigned long canary = (unsigned long)&per_cpu(stack_canary, cpu);
> -	struct desc_struct *gdt_table = get_cpu_gdt_rw(cpu);
> -	struct desc_struct desc;
> -
> -	desc = gdt_table[GDT_ENTRY_STACK_CANARY];
> -	set_desc_base(&desc, canary);
> -	write_gdt_entry(gdt_table, GDT_ENTRY_STACK_CANARY, &desc, DESCTYPE_S);
> -#endif
> -}
> -
> -static inline void load_stack_canary_segment(void)
> -{
> -#ifdef CONFIG_X86_32
> -	asm("mov %0, %%gs" : : "r" (__KERNEL_STACK_CANARY) : "memory");
> +	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
>  #endif
>  }
>  
>  #else	/* STACKPROTECTOR */
>  
> -#define GDT_STACK_CANARY_INIT
> -
>  /* dummy boot_init_stack_canary() is defined in linux/stackprotector.h */
>  
> -static inline void setup_stack_canary_segment(int cpu)
> -{ }
> -
>  static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
>  { }
>  
> -static inline void load_stack_canary_segment(void)
> -{
> -#ifdef CONFIG_X86_32
> -	asm volatile ("mov %0, %%gs" : : "r" (0));
> -#endif
> -}
> -
>  #endif	/* STACKPROTECTOR */
>  #endif	/* _ASM_STACKPROTECTOR_H */
> diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> index fdbd9d7b7bca..7b132d0312eb 100644
> --- a/arch/x86/include/asm/suspend_32.h
> +++ b/arch/x86/include/asm/suspend_32.h
> @@ -13,12 +13,10 @@
>  /* image of the saved processor state */
>  struct saved_context {
>  	/*
> -	 * On x86_32, all segment registers, with the possible exception of
> -	 * gs, are saved at kernel entry in pt_regs.
> +	 * On x86_32, all segment registers except gs are saved at kernel
> +	 * entry in pt_regs.
>  	 */
> -#ifdef CONFIG_X86_32_LAZY_GS
>  	u16 gs;
> -#endif
>  	unsigned long cr0, cr2, cr3, cr4;
>  	u64 misc_enable;
>  	bool misc_enable_saved;
> diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
> index 6e043f295a60..2b411cd00a4e 100644
> --- a/arch/x86/kernel/asm-offsets_32.c
> +++ b/arch/x86/kernel/asm-offsets_32.c
> @@ -53,11 +53,6 @@ void foo(void)
>  	       offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
>  	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
>  
> -#ifdef CONFIG_STACKPROTECTOR
> -	BLANK();
> -	OFFSET(stack_canary_offset, stack_canary, canary);
> -#endif
> -
>  	BLANK();
>  	DEFINE(EFI_svam, offsetof(efi_runtime_services_t, set_virtual_address_map));
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 35ad8480c464..f208569d2d3b 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -161,7 +161,6 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
>  
>  	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
>  	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
> -	GDT_STACK_CANARY_INIT
>  #endif
>  } };
>  EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
> @@ -599,7 +598,6 @@ void load_percpu_segment(int cpu)
>  	__loadsegment_simple(gs, 0);
>  	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
>  #endif
> -	load_stack_canary_segment();
>  }
>  
>  #ifdef CONFIG_X86_32
> @@ -1793,7 +1791,8 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
>  EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
>  
>  #ifdef CONFIG_STACKPROTECTOR
> -DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
> +DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
> +EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
>  #endif
>  
>  #endif	/* CONFIG_X86_64 */
> diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
> index 759d392cbe9f..d1d49e3d536b 100644
> --- a/arch/x86/kernel/doublefault_32.c
> +++ b/arch/x86/kernel/doublefault_32.c
> @@ -100,9 +100,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
>  		.ss		= __KERNEL_DS,
>  		.ds		= __USER_DS,
>  		.fs		= __KERNEL_PERCPU,
> -#ifndef CONFIG_X86_32_LAZY_GS
> -		.gs		= __KERNEL_STACK_CANARY,
> -#endif
> +		.gs		= 0,
>  
>  		.__cr3		= __pa_nodebug(swapper_pg_dir),
>  	},
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index 7ed84c282233..67f590425d90 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -318,8 +318,8 @@ SYM_FUNC_START(startup_32_smp)
>  	movl $(__KERNEL_PERCPU), %eax
>  	movl %eax,%fs			# set this cpu's percpu
>  
> -	movl $(__KERNEL_STACK_CANARY),%eax
> -	movl %eax,%gs
> +	xorl %eax,%eax
> +	movl %eax,%gs			# clear possible garbage in %gs
>  
>  	xorl %eax,%eax			# Clear LDT
>  	lldt %ax
> @@ -339,20 +339,6 @@ SYM_FUNC_END(startup_32_smp)
>   */
>  __INIT
>  setup_once:
> -#ifdef CONFIG_STACKPROTECTOR
> -	/*
> -	 * Configure the stack canary. The linker can't handle this by
> -	 * relocation.  Manually set base address in stack canary
> -	 * segment descriptor.
> -	 */
> -	movl $gdt_page,%eax
> -	movl $stack_canary,%ecx
> -	movw %cx, 8 * GDT_ENTRY_STACK_CANARY + 2(%eax)
> -	shrl $16, %ecx
> -	movb %cl, 8 * GDT_ENTRY_STACK_CANARY + 4(%eax)
> -	movb %ch, 8 * GDT_ENTRY_STACK_CANARY + 7(%eax)
> -#endif
> -
>  	andl $0,setup_once_ref	/* Once is enough, thanks */
>  	ret
>  
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index fd945ce78554..0941d2f44f2a 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -224,7 +224,6 @@ void __init setup_per_cpu_areas(void)
>  		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
>  		per_cpu(cpu_number, cpu) = cpu;
>  		setup_percpu_segment(cpu);
> -		setup_stack_canary_segment(cpu);
>  		/*
>  		 * Copy data used in early init routines from the
>  		 * initial arrays to the per cpu data areas.  These
> diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
> index 64a496a0687f..3c883e064242 100644
> --- a/arch/x86/kernel/tls.c
> +++ b/arch/x86/kernel/tls.c
> @@ -164,17 +164,11 @@ int do_set_thread_area(struct task_struct *p, int idx,
>  		savesegment(fs, sel);
>  		if (sel == modified_sel)
>  			loadsegment(fs, sel);
> -
> -		savesegment(gs, sel);
> -		if (sel == modified_sel)
> -			load_gs_index(sel);
>  #endif
>  
> -#ifdef CONFIG_X86_32_LAZY_GS
>  		savesegment(gs, sel);
>  		if (sel == modified_sel)
> -			loadsegment(gs, sel);
> -#endif
> +			load_gs_index(sel);
>  	} else {
>  #ifdef CONFIG_X86_64
>  		if (p->thread.fsindex == modified_sel)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f923e14e87df..ec39073b4897 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1467,12 +1467,8 @@ static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>  #ifdef CONFIG_X86_64
>  		loadsegment(fs, svm->host.fs);
>  		wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> -		load_gs_index(svm->host.gs);
> -#else
> -#ifdef CONFIG_X86_32_LAZY_GS
> -		loadsegment(gs, svm->host.gs);
> -#endif
>  #endif
> +		load_gs_index(svm->host.gs);
>  
>  		for (i = 0; i < NR_HOST_SAVE_USER_MSRS; i++)
>  			wrmsrl(host_save_user_msrs[i].index,
> @@ -3705,13 +3701,11 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	} else {
>  		__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
>  
> +		/* Restore the percpu segment immediately. */
>  #ifdef CONFIG_X86_64
>  		native_wrmsrl(MSR_GS_BASE, svm->host.gs_base);
>  #else
>  		loadsegment(fs, svm->host.fs);
> -#ifndef CONFIG_X86_32_LAZY_GS
> -		loadsegment(gs, svm->host.gs);
> -#endif
>  #endif
>  	}
>  
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 4229950a5d78..7f89a091f1fb 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -404,10 +404,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
>  	case INAT_SEG_REG_FS:
>  		return (unsigned short)(regs->fs & 0xffff);
>  	case INAT_SEG_REG_GS:
> -		/*
> -		 * GS may or may not be in regs as per CONFIG_X86_32_LAZY_GS.
> -		 * The macro below takes care of both cases.
> -		 */
>  		return get_user_gs(regs);
>  	case INAT_SEG_REG_IGNORE:
>  	default:
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index 43b4d864817e..afbf0bb252da 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -45,10 +45,8 @@
>  
>  #define PVH_GDT_ENTRY_CS	1
>  #define PVH_GDT_ENTRY_DS	2
> -#define PVH_GDT_ENTRY_CANARY	3
>  #define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
>  #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
> -#define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
>  
>  SYM_CODE_START_LOCAL(pvh_start_xen)
>  	cld
> @@ -109,17 +107,6 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>  
>  #else /* CONFIG_X86_64 */
>  
> -	/* Set base address in stack canary descriptor. */
> -	movl $_pa(gdt_start),%eax
> -	movl $_pa(canary),%ecx
> -	movw %cx, (PVH_GDT_ENTRY_CANARY * 8) + 2(%eax)
> -	shrl $16, %ecx
> -	movb %cl, (PVH_GDT_ENTRY_CANARY * 8) + 4(%eax)
> -	movb %ch, (PVH_GDT_ENTRY_CANARY * 8) + 7(%eax)
> -
> -	mov $PVH_CANARY_SEL,%eax
> -	mov %eax,%gs
> -
>  	call mk_early_pgtbl_32
>  
>  	mov $_pa(initial_page_table), %eax
> @@ -163,7 +150,6 @@ SYM_DATA_START_LOCAL(gdt_start)
>  	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* PVH_CS_SEL */
>  #endif
>  	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
> -	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
>  SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
>  
>  	.balign 16
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index db1378c6ff26..ef4329d67a5f 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -99,11 +99,8 @@ static void __save_processor_state(struct saved_context *ctxt)
>  	/*
>  	 * segment registers
>  	 */
> -#ifdef CONFIG_X86_32_LAZY_GS
>  	savesegment(gs, ctxt->gs);
> -#endif
>  #ifdef CONFIG_X86_64
> -	savesegment(gs, ctxt->gs);
>  	savesegment(fs, ctxt->fs);
>  	savesegment(ds, ctxt->ds);
>  	savesegment(es, ctxt->es);
> @@ -232,7 +229,6 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>  	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
>  #else
>  	loadsegment(fs, __KERNEL_PERCPU);
> -	loadsegment(gs, __KERNEL_STACK_CANARY);
>  #endif
>  
>  	/* Restore the TSS, RO GDT, LDT, and usermode-relevant MSRs. */
> @@ -255,7 +251,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>  	 */
>  	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
>  	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
> -#elif defined(CONFIG_X86_32_LAZY_GS)
> +#else
>  	loadsegment(gs, ctxt->gs);
>  #endif
>  
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 9a5a50cdaab5..e18235a6390d 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1190,7 +1190,6 @@ static void __init xen_setup_gdt(int cpu)
>  	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
>  	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
>  
> -	setup_stack_canary_segment(cpu);
>  	switch_to_new_gdt(cpu);
>  
>  	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
> diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
> index f5c119495254..825c75c5b715 100755
> --- a/scripts/gcc-x86_32-has-stack-protector.sh
> +++ b/scripts/gcc-x86_32-has-stack-protector.sh
> @@ -1,4 +1,8 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
> +# This requires GCC 8.1 or better.  Specifically, we require
> +# -mstack-protector-guard-reg, added by
> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
> +
> +echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
> -- 
> 2.29.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


