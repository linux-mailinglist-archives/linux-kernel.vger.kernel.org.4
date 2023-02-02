Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF7A687365
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBBCnV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 21:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBCnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:43:20 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBC6FD25
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:43:16 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7E8EA24DFC2;
        Thu,  2 Feb 2023 10:43:14 +0800 (CST)
Received: from EXMBX164.cuchost.com (172.16.7.74) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Feb
 2023 10:43:14 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX164.cuchost.com
 (172.16.7.74) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Feb
 2023 10:43:14 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Thu, 2 Feb 2023 10:43:13 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZMi9ZN0+4F1UUIkevO0NjoPA20663GzgAgAPO2bA=
Date:   Thu, 2 Feb 2023 02:43:13 +0000
Message-ID: <1e578a1a4a4d45c5be0216ac49d9027f@EXMBX066.cuchost.com>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-5-jeeheng.sia@starfivetech.com>
 <Y9hTGo6dfgeusW4B@spud>
In-Reply-To: <Y9hTGo6dfgeusW4B@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, 31 January, 2023 7:31 AM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>; Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v3 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> +CC Alex
> 
> Alex, could you take a look at the page table bits here when you get a
> chance please?
> 
> On Fri, Jan 27, 2023 at 05:10:51PM +0800, Sia Jee Heng wrote:
> > Low level Arch functions were created to support hibernation.
> > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > cpu state onto the stack, then calling swsusp_save() to save the memory
> > image.
> >
> > Arch specific hibernation header is implemented and is utilized by the
> > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > functions. The arch specific hibernation header consists of satp, hartid,
> > and the cpu_resume address. The kernel built version is also need to be
> > saved into the hibernation image header to making sure only the same
> > kernel is restore when resume.
> >
> > swsusp_arch_resume() creates a temporary page table that covering only
> > the linear map. It copies the restore code to a 'safe' page, then start
> > to restore the memory image. Once completed, it restores the original
> > kernel's page table. It then calls into __hibernate_cpu_resume()
> > to restore the CPU context. Finally, it follows the normal hibernation
> > path back to the hibernation core.
> >
> > To enable hibernation/suspend to disk into RISCV, the below config
> > need to be enabled:
> > - CONFIG_ARCH_HIBERNATION_HEADER
> > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  arch/riscv/Kconfig                 |   7 +
> >  arch/riscv/include/asm/assembler.h |  20 ++
> >  arch/riscv/include/asm/suspend.h   |  21 ++
> >  arch/riscv/kernel/Makefile         |   1 +
> >  arch/riscv/kernel/asm-offsets.c    |   5 +
> >  arch/riscv/kernel/hibernate-asm.S  |  89 +++++++
> >  arch/riscv/kernel/hibernate.c      | 360 +++++++++++++++++++++++++++++
> >  7 files changed, 503 insertions(+)
> >  create mode 100644 arch/riscv/kernel/hibernate-asm.S
> >  create mode 100644 arch/riscv/kernel/hibernate.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e2b656043abf..4555848a817f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -690,6 +690,13 @@ menu "Power management options"
> >
> >  source "kernel/power/Kconfig"
> >
> > +config ARCH_HIBERNATION_POSSIBLE
> > +	def_bool y
> > +
> > +config ARCH_HIBERNATION_HEADER
> > +	def_bool y
> > +	depends on HIBERNATION
> > +
> >  endmenu # "Power management options"
> >
> >  menu "CPU Power Management"
> > diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> > index ef1283d04b70..3de70d3e6ceb 100644
> > --- a/arch/riscv/include/asm/assembler.h
> > +++ b/arch/riscv/include/asm/assembler.h
> > @@ -59,4 +59,24 @@
> >  		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> >  	.endm
> >
> > +/**
> > + * copy_page - copy 1 page (4KB) of data from source to destination
> 
> arch/riscv/include/asm/assembler.h:64: warning: Incorrect use of kernel-doc format:  * copy_page - copy 1 page (4KB) of data from
> source to destination
will replace the /** with /* doc format

> 
> > + * @a0 - destination
> > + * @a1 - source
> > + */
> > +	.macro	copy_page a0, a1
> > +		lui	a2, 0x1
> > +		add	a2, a2, a0
> > +.1 :
> > +		REG_L	t0, 0(a1)
> > +		REG_L	t1, SZREG(a1)
> > +
> > +		REG_S	t0, 0(a0)
> > +		REG_S	t1, SZREG(a0)
> > +
> > +		addi	a0, a0, 2 * SZREG
> > +		addi	a1, a1, 2 * SZREG
> > +		bne	a2, a0, .1
> 
> allmodconfig, clang 15.0.4:
> 
> <instantiation>:3:1: error: unexpected token at start of statement
> .1 :
> ^
> /stuff/linux/arch/riscv/kernel/hibernate-asm.S:83:2: note: while in macro instantiation
>  copy_page a0, a1
>  ^
> <instantiation>:12:15: error: unknown operand
>   bne a2, a0, .1
>               ^
> /stuff/linux/arch/riscv/kernel/hibernate-asm.S:83:2: note: while in macro instantiation
>  copy_page a0, a1
>  ^
> make[5]: *** [/stuff/linux/scripts/Makefile.build:384: arch/riscv/kernel/hibernate-asm.o] Error 1
> 
> > +	.endm
> > +
> >  #endif	/* __ASM_ASSEMBLER_H */
> > diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> > index 75419c5ca272..db40ae433aa9 100644
> > --- a/arch/riscv/include/asm/suspend.h
> > +++ b/arch/riscv/include/asm/suspend.h
> > @@ -21,6 +21,12 @@ struct suspend_context {
> >  #endif
> >  };
> >
> > +/*
> > + * This parameter will be assigned to 0 during resume and will be used by
> > + * hibernation core for the subsequent resume sequence
> 
> This isn't a parameter! I'm not sure that the comment really adds
> anything to be honest, but "Used by the hibernation core and cleared
> during the resume sequence" probably gets the point across equally well.
Sure, will update the comment
> 
> > + */
> > +extern int in_suspend;
> > +
> >  /* Low-level CPU suspend entry function */
> >  int __cpu_suspend_enter(struct suspend_context *context);
> >
> > @@ -36,4 +42,19 @@ int __cpu_resume_enter(unsigned long hartid, unsigned long context);
> >  /* Used to save and restore the csr */
> >  void suspend_save_csrs(struct suspend_context *context);
> >  void suspend_restore_csrs(struct suspend_context *context);
> > +
> > +/* Low-level API to support hibernation */
> > +int swsusp_arch_suspend(void);
> > +int swsusp_arch_resume(void);
> > +int arch_hibernation_header_save(void *addr, unsigned int max_size);
> > +int arch_hibernation_header_restore(void *addr);
> > +int __hibernate_cpu_resume(void);
> > +
> > +/* Used to resume on the CPU we hibernated on */
> > +int hibernate_resume_nonboot_cpu_disable(void);
> > +
> > +/* Used to restore the hibernated image */
> 
> I think this comment is kinda stating the obvious, no?
> 
> > +asmlinkage void restore_image(unsigned long resume_satp, unsigned long satp_temp,
> > +				unsigned long cpu_resume);
> > +asmlinkage int core_restore_code(void);
> 
> How about dropping the comment and prepending hiberate_ to this function
> names?
Good idea, will remove the comment and add hibernate_ prefix
> 
> >  #endif
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 4cf303a779ab..daab341d55e4 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -64,6 +64,7 @@ obj-$(CONFIG_MODULES)		+= module.o
> >  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
> >
> >  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> > +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
> >
> >  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
> >  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> > index df9444397908..d6a75aac1d27 100644
> > --- a/arch/riscv/kernel/asm-offsets.c
> > +++ b/arch/riscv/kernel/asm-offsets.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/kbuild.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> > +#include <linux/suspend.h>
> >  #include <asm/kvm_host.h>
> >  #include <asm/thread_info.h>
> >  #include <asm/ptrace.h>
> > @@ -116,6 +117,10 @@ void asm_offsets(void)
> >
> >  	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
> >
> > +	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> > +	OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
> > +	OFFSET(HIBERN_PBE_NEXT, pbe, next);
> > +
> >  	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
> >  	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
> >  	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> > new file mode 100644
> > index 000000000000..a83d534b89bd
> > --- /dev/null
> > +++ b/arch/riscv/kernel/hibernate-asm.S
> > @@ -0,0 +1,89 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Hibernation support specific for RISCV
> > + *
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + *
> > + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > + */
> > +
> > +#include <asm/asm.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/assembler.h>
> > +#include <asm/csr.h>
> > +
> > +#include <linux/linkage.h>
> > +
> > +/*
> > + * This code is executed when resume from the hibernation.
> > + *
> > + * It begins with loading the temporary page table then restores the memory image.
> > + * Finally branches to __hibernate_cpu_resume() to restore the state saved by
> > + * swsusp_arch_suspend().
> > + */
> 
> This file looks to be confusingly ordered. You lead with a comment
> describing a sequence but the file doesn't follow it.
> I suggest removing this comment.
Sure, will remove it
> 
> > +
> > +/*
> > + * int __hibernate_cpu_resume(void)
> > + * Switch back to the hibernated image's page table prior to restore the CPU
> 
> nit: s/restore/restoring
> 
> > + * context.
> > + *
> > + * Always returns 0 to the C code.
> 
> s/to the C code//
Ok

> 
> > + */
> > +ENTRY(__hibernate_cpu_resume)
> > +	/* switch to hibernated image's page table */
> > +	csrw CSR_SATP, s0
> > +	sfence.vma
> > +
> > +	REG_L	a0, hibernate_cpu_context
> > +
> > +	/* Restore CSRs */
> 
> Stating the obvious again here, no?
Will remove it. thanks
>
> > +	restore_csr
> > +
> > +	/* Restore registers (except A0 and T0-T6) */
> 
> Do we need to mention the (except A0 & T0-T6) here and elsewhere?
> If they're lost across calls anyway, is it worth mentioning that they're
> lost across hibernation?
Can remove the comment, but it is worth to mention it in the macro description
> 
> > +	restore_reg
> > +
> > +	/* Return zero value */
> > +	add	a0, zero, zero
> > +
> > +	/* Return to C code */
> 
> I'd drop this comment. I don't think the presumed caller of the function
> needs to be mentioned here.
Sure. will remove it.
> 
> > +	ret
> > +END(__hibernate_cpu_resume)
> > +
> > +/*
> > + * Prepare to restore the image.
> > + * a0: satp of saved page tables
> > + * a1: satp of temporary page tables
> > + * a2: cpu_resume
> > + */
> > +ENTRY(restore_image)
> > +	mv	s0, a0
> > +	mv	s1, a1
> > +	mv	s2, a2
> > +	REG_L	s4, restore_pblist
> > +	REG_L	a1, relocated_restore_code
> > +
> > +	jalr	a1
> > +END(restore_image)
> > +
> > +/*
> > + * The below code will be executed from a 'safe' page.
> > + * It first switches to the temporary page table, then start to copy the pages
> 
> nit: s/start/starts/
ok
> 
> > + * back to the original memory location. Finally, it jumps to the __hibernate_cpu_resume()
> 
> nit: s/jumps to the/jumps to/
ok
> 
> > + * to restore the CPU context.
> > + */
> > +ENTRY(core_restore_code)
> > +	/* switch to temp page table */
> > +	csrw satp, s1
> > +	sfence.vma
> > +.Lcopy:
> > +	/* The below code will restore the hibernated image. */
> 
> I think this should be moved to the top of the pre-function comment.
The idea is that this comment make it easier for readers to understand.
> 
> > +	REG_L	a1, HIBERN_PBE_ADDR(s4)
> > +	REG_L	a0, HIBERN_PBE_ORIG(s4)
> > +
> > +	copy_page a0, a1
> > +
> > +	REG_L	s4, HIBERN_PBE_NEXT(s4)
> > +	bnez	s4, .Lcopy
> > +
> > +	jalr	s2
> > +END(core_restore_code)
> > diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> > new file mode 100644
> > index 000000000000..bf7f3c781820
> > --- /dev/null
> > +++ b/arch/riscv/kernel/hibernate.c
> > @@ -0,0 +1,360 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Hibernation support specific for RISCV
> 
> Well, it'd be odd if it was for another arch but sitting in arch/riscv!
> ;)
Sure.
> 
> Thanks for your patches though, it'll be great to have hibernation
> support going.
> 
> > + *
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + *
> > + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > + */
> > +
> > +#include <asm/barrier.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/mmu_context.h>
> > +#include <asm/page.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/sections.h>
> > +#include <asm/set_memory.h>
> > +#include <asm/smp.h>
> > +#include <asm/suspend.h>
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/memblock.h>
> > +#include <linux/pm.h>
> > +#include <linux/sched.h>
> > +#include <linux/suspend.h>
> > +#include <linux/utsname.h>
> > +
> > +/* The logical cpu number we should resume on, initialised to a non-cpu number */
> > +static int sleep_cpu = -EINVAL;
> > +
> > +/* CPU context to be saved */
> > +struct suspend_context *hibernate_cpu_context;
> > +
> > +unsigned long relocated_restore_code;
> > +
> > +/* Pointer to the temporary resume page table */
> > +pgd_t *resume_pg_dir;
> 
> sparse doesn't like what you've done here:
> /stuff/linux/arch/riscv/kernel/hibernate.c:31:24: warning: symbol 'hibernate_cpu_context' was not declared. Should it be static?
> /stuff/linux/arch/riscv/kernel/hibernate.c:33:15: warning: symbol 'relocated_restore_code' was not declared. Should it be static?
> /stuff/linux/arch/riscv/kernel/hibernate.c:36:7: warning: symbol 'resume_pg_dir' was not declared. Should it be static?
Thanks. will improve it.
> > +
> > +/**
> > + * struct arch_hibernate_hdr_invariants - container to store kernel build version
> > + * @uts_version: to save the build number and date so that the we are not resume with
> 
> nit: "so that we do not resume"
sure. thanks
> 
> > + *		a different kernel
> > + */
> > +struct arch_hibernate_hdr_invariants {
> > +	char		uts_version[__NEW_UTS_LEN + 1];
> > +};
> > +
> > +/**
> > + * struct arch_hibernate_hdr - helper parameters that help us to restore the image
> > + * @invariants: container to store kernel build version
> > + * @hartid: to make sure same boot_cpu executing the hibernate/restore code.
> 
> nit: s/executing/executes
sure. thanks
> 
> Also, my OCD is triggered by the inconsistent full stops at EOL.
oops. will fix it. thanks
> 
> > + * @saved_satp: original page table used by the hibernated image.
> > + * @restore_cpu_addr: the kernel's image address to restore the CPU context.
> > + */
> > +static struct arch_hibernate_hdr {
> > +	struct arch_hibernate_hdr_invariants invariants;
> > +	unsigned long	hartid;
> > +	unsigned long	saved_satp;
> > +	unsigned long	restore_cpu_addr;
> > +} resume_hdr;
> > +
> > +static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
> > +{
> > +	memset(i, 0, sizeof(*i));
> > +	memcpy(i->uts_version, init_utsname()->version, sizeof(i->uts_version));
> > +}
> > +
> > +/*
> > + * Check if the given pfn is in the 'nosave' section.
> > + */
> > +int pfn_is_nosave(unsigned long pfn)
> > +{
> > +	unsigned long nosave_begin_pfn = sym_to_pfn(&__nosave_begin);
> > +	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
> > +
> > +	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn));
> > +}
> > +
> > +void notrace save_processor_state(void)
> > +{
> > +	WARN_ON(num_online_cpus() != 1);
> > +}
> > +
> > +void notrace restore_processor_state(void)
> > +{
> > +}
> > +
> > +/*
> > + * Helper parameters need to be saved to the hibernation image header.
> > + */
> > +int arch_hibernation_header_save(void *addr, unsigned int max_size)
> > +{
> > +	struct arch_hibernate_hdr *hdr = addr;
> > +
> > +	if (max_size < sizeof(*hdr))
> > +		return -EOVERFLOW;
> > +
> > +	arch_hdr_invariants(&hdr->invariants);
> > +
> > +	hdr->hartid = cpuid_to_hartid_map(sleep_cpu);
> > +	hdr->saved_satp = csr_read(CSR_SATP);
> > +	hdr->restore_cpu_addr = (unsigned long)__hibernate_cpu_resume;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(arch_hibernation_header_save);
> 
> EXPORT_SYMBOL_GPL(), no? Same below.
you are right. will fix it
> 
> > +/*
> > + * Retrieve the helper parameters from the hibernation image header
> > + */
> > +int arch_hibernation_header_restore(void *addr)
> > +{
> > +	struct arch_hibernate_hdr_invariants invariants;
> > +	struct arch_hibernate_hdr *hdr = addr;
> > +	int ret = 0;
> > +
> > +	arch_hdr_invariants(&invariants);
> > +
> > +	if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
> > +		pr_crit("Hibernate image not generated by this kernel!\n");
> 
> Out of curiosity more than anything else, why pr_crit()? Copy-paste from
> arm64?
The idea is from arm, and ok with the log level. 
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	sleep_cpu = riscv_hartid_to_cpuid(hdr->hartid);
> > +	if (sleep_cpu < 0) {
> > +		pr_crit("Hibernated on a CPU not known to this kernel!\n");
> > +		sleep_cpu = -EINVAL;
> > +		return -EINVAL;
> > +	}
> > +
> > +#ifdef CONFIG_SMP
> > +	ret = bringup_hibernate_cpu(sleep_cpu);
> > +	if (ret) {
> > +		sleep_cpu = -EINVAL;
> > +		return ret;
> > +	}
> > +#endif
> > +	resume_hdr = *hdr;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(arch_hibernation_header_restore);
> > +
> > +int swsusp_arch_suspend(void)
> > +{
> > +	int ret = 0;
> > +
> > +	if (__cpu_suspend_enter(hibernate_cpu_context)) {
> > +		sleep_cpu = smp_processor_id();
> > +		suspend_save_csrs(hibernate_cpu_context);
> > +		ret = swsusp_save();
> > +	} else {
> > +		suspend_restore_csrs(hibernate_cpu_context);
> > +		flush_tlb_all();
> > +
> > +		/* Invalidated Icache */
> 
> Think this comment can go, no?
sure. will remove it.
> 
> > +		flush_icache_all();
> > +
> > +		/*
> > +		 * Tell the hibernation core that we've just restored
> > +		 * the memory
> 
> I noticed arm64 manipulates the crash kernel in this function too.
> How come we don't?
kexec_tool doesn't support RISCV yet. We can enable it once it is supported by kexec_tool.
> 
> > +		 */
> > +		in_suspend = 0;
> > +		sleep_cpu = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> 
> The page table stuff here is beyond me... Hopefully Alex can take a look!
> 
> I noticed arm64's one of these is not gated, what is different about
> RISC-V that requires it to be?
Do you mean the CONFIG_PM_SLEEP_SMP? It causes compile error if build with SMP disabled. Not sure about arm as I didn't try it.
> 
> > +int hibernate_resume_nonboot_cpu_disable(void)
> > +{
> > +	if (sleep_cpu < 0) {
> > +		pr_err("Failing to resume from hibernate on an unknown CPU.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return freeze_secondary_cpus(sleep_cpu);
> > +}
> > +#endif
> > +
> > +static int __init riscv_hibernate_init(void)
> > +{
> > +	hibernate_cpu_context = kcalloc(1, sizeof(struct suspend_context), GFP_KERNEL);
> > +
> > +	if (WARN_ON(!hibernate_cpu_context))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> Conor.

