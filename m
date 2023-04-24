Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA64D6DD8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjDKLHO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDKLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:07:08 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEE3A87
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:06:41 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B704324E2AE;
        Tue, 11 Apr 2023 19:03:39 +0800 (CST)
Received: from EXMBX064.cuchost.com (172.16.6.64) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 19:03:39 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX064.cuchost.com
 (172.16.6.64) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 19:03:39 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 11 Apr 2023 19:03:39 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: RE: [PATCH v8 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v8 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZYtL6gvdXPh7I8Eye4KHkRCEIoq8mBC2Q
Date:   Tue, 11 Apr 2023 11:03:39 +0000
Message-ID: <2ce61462b53242f4beccc21a808d38a3@EXMBX066.cuchost.com>
References: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
 <20230330064321.1008373-5-jeeheng.sia@starfivetech.com>
In-Reply-To: <20230330064321.1008373-5-jeeheng.sia@starfivetech.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.53.70.89]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, may I know if there are any more comments regarding the below patch series?

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Sent: Thursday, March 30, 2023 2:43 PM
> To: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; JeeHeng Sia <jeeheng.sia@starfivetech.com>; Leyfoon Tan
> <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>; Conor Dooley <conor.dooley@microchip.com>;
> Andrew Jones <ajones@ventanamicro.com>
> Subject: [PATCH v8 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
> 
> Arch specific hibernation header is implemented and is utilized by the
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions. The arch specific hibernation header consists of satp, hartid,
> and the cpu_resume address. The kernel built version is also need to be
> saved into the hibernation image header to making sure only the same
> kernel is restore when resume.
> 
> swsusp_arch_resume() creates a temporary page table that covering only
> the linear map. It copies the restore code to a 'safe' page, then start
> to restore the memory image. Once completed, it restores the original
> kernel's page table. It then calls into __hibernate_cpu_resume()
> to restore the CPU context. Finally, it follows the normal hibernation
> path back to the hibernation core.
> 
> To enable hibernation/suspend to disk into RISCV, the below config
> need to be enabled:
> - CONFIG_HIBERNATION
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig                 |   8 +-
>  arch/riscv/include/asm/assembler.h |  20 ++
>  arch/riscv/include/asm/suspend.h   |  19 ++
>  arch/riscv/kernel/Makefile         |   1 +
>  arch/riscv/kernel/asm-offsets.c    |   5 +
>  arch/riscv/kernel/hibernate-asm.S  |  77 ++++++
>  arch/riscv/kernel/hibernate.c      | 427 +++++++++++++++++++++++++++++
>  7 files changed, 556 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/hibernate-asm.S
>  create mode 100644 arch/riscv/kernel/hibernate.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5b182d1c196c..3fc1f3983ea0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -54,7 +54,7 @@ config RISCV
>  	select CLINT_TIMER if !MMU
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> -	select CPU_PM if CPU_IDLE
> +	select CPU_PM if CPU_IDLE || HIBERNATION
>  	select EDAC_SUPPORT
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_ATOMIC64 if !64BIT
> @@ -729,6 +729,12 @@ menu "Power management options"
> 
>  source "kernel/power/Kconfig"
> 
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +
> +config ARCH_HIBERNATION_HEADER
> +	def_bool HIBERNATION
> +
>  endmenu # "Power management options"
> 
>  menu "CPU Power Management"
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> index ba59d38f8937..44b1457d3e95 100644
> --- a/arch/riscv/include/asm/assembler.h
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -59,4 +59,24 @@
>  		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
>  	.endm
> 
> +/*
> + * copy_page - copy 1 page (4KB) of data from source to destination
> + * @a0 - destination
> + * @a1 - source
> + */
> +	.macro	copy_page a0, a1
> +		lui	a2, 0x1
> +		add	a2, a2, a0
> +1 :
> +		REG_L	t0, 0(a1)
> +		REG_L	t1, SZREG(a1)
> +
> +		REG_S	t0, 0(a0)
> +		REG_S	t1, SZREG(a0)
> +
> +		addi	a0, a0, 2 * SZREG
> +		addi	a1, a1, 2 * SZREG
> +		bne	a2, a0, 1b
> +	.endm
> +
>  #endif	/* __ASM_ASSEMBLER_H */
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 67e047445662..02f87867389a 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -21,6 +21,11 @@ struct suspend_context {
>  #endif
>  };
> 
> +/*
> + * Used by hibernation core and cleared during resume sequence
> + */
> +extern int in_suspend;
> +
>  /* Low-level CPU suspend entry function */
>  int __cpu_suspend_enter(struct suspend_context *context);
> 
> @@ -36,4 +41,18 @@ int __cpu_resume_enter(unsigned long hartid, unsigned long context);
>  /* Used to save and restore the CSRs */
>  void suspend_save_csrs(struct suspend_context *context);
>  void suspend_restore_csrs(struct suspend_context *context);
> +
> +/* Low-level API to support hibernation */
> +int swsusp_arch_suspend(void);
> +int swsusp_arch_resume(void);
> +int arch_hibernation_header_save(void *addr, unsigned int max_size);
> +int arch_hibernation_header_restore(void *addr);
> +int __hibernate_cpu_resume(void);
> +
> +/* Used to resume on the CPU we hibernated on */
> +int hibernate_resume_nonboot_cpu_disable(void);
> +
> +asmlinkage void hibernate_restore_image(unsigned long resume_satp, unsigned long satp_temp,
> +					unsigned long cpu_resume);
> +asmlinkage int hibernate_core_restore_code(void);
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..daab341d55e4 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
> 
>  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
> 
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index df9444397908..d6a75aac1d27 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -9,6 +9,7 @@
>  #include <linux/kbuild.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> +#include <linux/suspend.h>
>  #include <asm/kvm_host.h>
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
> @@ -116,6 +117,10 @@ void asm_offsets(void)
> 
>  	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
> 
> +	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> +	OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
> +	OFFSET(HIBERN_PBE_NEXT, pbe, next);
> +
>  	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
>  	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
>  	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> new file mode 100644
> index 000000000000..effaf5ca5da0
> --- /dev/null
> +++ b/arch/riscv/kernel/hibernate-asm.S
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Hibernation low level support for RISCV.
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +#include <asm/csr.h>
> +
> +#include <linux/linkage.h>
> +
> +/*
> + * int __hibernate_cpu_resume(void)
> + * Switch back to the hibernated image's page table prior to restoring the CPU
> + * context.
> + *
> + * Always returns 0
> + */
> +ENTRY(__hibernate_cpu_resume)
> +	/* switch to hibernated image's page table. */
> +	csrw CSR_SATP, s0
> +	sfence.vma
> +
> +	REG_L	a0, hibernate_cpu_context
> +
> +	suspend_restore_csrs
> +	suspend_restore_regs
> +
> +	/* Return zero value. */
> +	mv	a0, zero
> +
> +	ret
> +END(__hibernate_cpu_resume)
> +
> +/*
> + * Prepare to restore the image.
> + * a0: satp of saved page tables.
> + * a1: satp of temporary page tables.
> + * a2: cpu_resume.
> + */
> +ENTRY(hibernate_restore_image)
> +	mv	s0, a0
> +	mv	s1, a1
> +	mv	s2, a2
> +	REG_L	s4, restore_pblist
> +	REG_L	a1, relocated_restore_code
> +
> +	jalr	a1
> +END(hibernate_restore_image)
> +
> +/*
> + * The below code will be executed from a 'safe' page.
> + * It first switches to the temporary page table, then starts to copy the pages
> + * back to the original memory location. Finally, it jumps to __hibernate_cpu_resume()
> + * to restore the CPU context.
> + */
> +ENTRY(hibernate_core_restore_code)
> +	/* switch to temp page table. */
> +	csrw satp, s1
> +	sfence.vma
> +.Lcopy:
> +	/* The below code will restore the hibernated image. */
> +	REG_L	a1, HIBERN_PBE_ADDR(s4)
> +	REG_L	a0, HIBERN_PBE_ORIG(s4)
> +
> +	copy_page a0, a1
> +
> +	REG_L	s4, HIBERN_PBE_NEXT(s4)
> +	bnez	s4, .Lcopy
> +
> +	jalr	s2
> +END(hibernate_core_restore_code)
> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> new file mode 100644
> index 000000000000..264b2dcdd67e
> --- /dev/null
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Hibernation support for RISCV
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#include <asm/barrier.h>
> +#include <asm/cacheflush.h>
> +#include <asm/mmu_context.h>
> +#include <asm/page.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
> +#include <asm/sections.h>
> +#include <asm/set_memory.h>
> +#include <asm/smp.h>
> +#include <asm/suspend.h>
> +
> +#include <linux/cpu.h>
> +#include <linux/memblock.h>
> +#include <linux/pm.h>
> +#include <linux/sched.h>
> +#include <linux/suspend.h>
> +#include <linux/utsname.h>
> +
> +/* The logical cpu number we should resume on, initialised to a non-cpu number. */
> +static int sleep_cpu = -EINVAL;
> +
> +/* Pointer to the temporary resume page table. */
> +static pgd_t *resume_pg_dir;
> +
> +/* CPU context to be saved. */
> +struct suspend_context *hibernate_cpu_context;
> +EXPORT_SYMBOL_GPL(hibernate_cpu_context);
> +
> +unsigned long relocated_restore_code;
> +EXPORT_SYMBOL_GPL(relocated_restore_code);
> +
> +/**
> + * struct arch_hibernate_hdr_invariants - container to store kernel build version.
> + * @uts_version: to save the build number and date so that we do not resume with
> + *		a different kernel.
> + */
> +struct arch_hibernate_hdr_invariants {
> +	char		uts_version[__NEW_UTS_LEN + 1];
> +};
> +
> +/**
> + * struct arch_hibernate_hdr - helper parameters that help us to restore the image.
> + * @invariants: container to store kernel build version.
> + * @hartid: to make sure same boot_cpu executes the hibernate/restore code.
> + * @saved_satp: original page table used by the hibernated image.
> + * @restore_cpu_addr: the kernel's image address to restore the CPU context.
> + */
> +static struct arch_hibernate_hdr {
> +	struct arch_hibernate_hdr_invariants invariants;
> +	unsigned long	hartid;
> +	unsigned long	saved_satp;
> +	unsigned long	restore_cpu_addr;
> +} resume_hdr;
> +
> +static void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
> +{
> +	memset(i, 0, sizeof(*i));
> +	memcpy(i->uts_version, init_utsname()->version, sizeof(i->uts_version));
> +}
> +
> +/*
> + * Check if the given pfn is in the 'nosave' section.
> + */
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn = sym_to_pfn(&__nosave_begin);
> +	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
> +
> +	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn));
> +}
> +
> +void notrace save_processor_state(void)
> +{
> +	WARN_ON(num_online_cpus() != 1);
> +}
> +
> +void notrace restore_processor_state(void)
> +{
> +}
> +
> +/*
> + * Helper parameters need to be saved to the hibernation image header.
> + */
> +int arch_hibernation_header_save(void *addr, unsigned int max_size)
> +{
> +	struct arch_hibernate_hdr *hdr = addr;
> +
> +	if (max_size < sizeof(*hdr))
> +		return -EOVERFLOW;
> +
> +	arch_hdr_invariants(&hdr->invariants);
> +
> +	hdr->hartid = cpuid_to_hartid_map(sleep_cpu);
> +	hdr->saved_satp = csr_read(CSR_SATP);
> +	hdr->restore_cpu_addr = (unsigned long)__hibernate_cpu_resume;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(arch_hibernation_header_save);
> +
> +/*
> + * Retrieve the helper parameters from the hibernation image header.
> + */
> +int arch_hibernation_header_restore(void *addr)
> +{
> +	struct arch_hibernate_hdr_invariants invariants;
> +	struct arch_hibernate_hdr *hdr = addr;
> +	int ret = 0;
> +
> +	arch_hdr_invariants(&invariants);
> +
> +	if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
> +		pr_crit("Hibernate image not generated by this kernel!\n");
> +		return -EINVAL;
> +	}
> +
> +	sleep_cpu = riscv_hartid_to_cpuid(hdr->hartid);
> +	if (sleep_cpu < 0) {
> +		pr_crit("Hibernated on a CPU not known to this kernel!\n");
> +		sleep_cpu = -EINVAL;
> +		return -EINVAL;
> +	}
> +
> +#ifdef CONFIG_SMP
> +	ret = bringup_hibernate_cpu(sleep_cpu);
> +	if (ret) {
> +		sleep_cpu = -EINVAL;
> +		return ret;
> +	}
> +#endif
> +	resume_hdr = *hdr;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(arch_hibernation_header_restore);
> +
> +int swsusp_arch_suspend(void)
> +{
> +	int ret = 0;
> +
> +	if (__cpu_suspend_enter(hibernate_cpu_context)) {
> +		sleep_cpu = smp_processor_id();
> +		suspend_save_csrs(hibernate_cpu_context);
> +		ret = swsusp_save();
> +	} else {
> +		suspend_restore_csrs(hibernate_cpu_context);
> +		flush_tlb_all();
> +		flush_icache_all();
> +
> +		/*
> +		 * Tell the hibernation core that we've just restored the memory.
> +		 */
> +		in_suspend = 0;
> +		sleep_cpu = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
> +				unsigned long end, pgprot_t prot)
> +{
> +	pte_t *src_ptep;
> +	pte_t *dst_ptep;
> +
> +	if (pmd_none(READ_ONCE(*dst_pmdp))) {
> +		dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
> +		if (!dst_ptep)
> +			return -ENOMEM;
> +
> +		pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
> +	}
> +
> +	dst_ptep = pte_offset_kernel(dst_pmdp, start);
> +	src_ptep = pte_offset_kernel(src_pmdp, start);
> +
> +	do {
> +		pte_t pte = READ_ONCE(*src_ptep);
> +
> +		if (pte_present(pte))
> +			set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
> +	} while (dst_ptep++, src_ptep++, start += PAGE_SIZE, start < end);
> +
> +	return 0;
> +}
> +
> +static int temp_pgtable_map_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
> +				unsigned long end, pgprot_t prot)
> +{
> +	unsigned long next;
> +	unsigned long ret;
> +	pmd_t *src_pmdp;
> +	pmd_t *dst_pmdp;
> +
> +	if (pud_none(READ_ONCE(*dst_pudp))) {
> +		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +		if (!dst_pmdp)
> +			return -ENOMEM;
> +
> +		pud_populate(NULL, dst_pudp, dst_pmdp);
> +	}
> +
> +	dst_pmdp = pmd_offset(dst_pudp, start);
> +	src_pmdp = pmd_offset(src_pudp, start);
> +
> +	do {
> +		pmd_t pmd = READ_ONCE(*src_pmdp);
> +
> +		next = pmd_addr_end(start, end);
> +
> +		if (pmd_none(pmd))
> +			continue;
> +
> +		if (pmd_leaf(pmd)) {
> +			set_pmd(dst_pmdp, __pmd(pmd_val(pmd) | pgprot_val(prot)));
> +		} else {
> +			ret = temp_pgtable_map_pte(dst_pmdp, src_pmdp, start, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_pmdp++, src_pmdp++, start = next, start != end);
> +
> +	return 0;
> +}
> +
> +static int temp_pgtable_map_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long start,
> +				unsigned long end, pgprot_t prot)
> +{
> +	unsigned long next;
> +	unsigned long ret;
> +	pud_t *dst_pudp;
> +	pud_t *src_pudp;
> +
> +	if (p4d_none(READ_ONCE(*dst_p4dp))) {
> +		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
> +		if (!dst_pudp)
> +			return -ENOMEM;
> +
> +		p4d_populate(NULL, dst_p4dp, dst_pudp);
> +	}
> +
> +	dst_pudp = pud_offset(dst_p4dp, start);
> +	src_pudp = pud_offset(src_p4dp, start);
> +
> +	do {
> +		pud_t pud = READ_ONCE(*src_pudp);
> +
> +		next = pud_addr_end(start, end);
> +
> +		if (pud_none(pud))
> +			continue;
> +
> +		if (pud_leaf(pud)) {
> +			set_pud(dst_pudp, __pud(pud_val(pud) | pgprot_val(prot)));
> +		} else {
> +			ret = temp_pgtable_map_pmd(dst_pudp, src_pudp, start, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_pudp++, src_pudp++, start = next, start != end);
> +
> +	return 0;
> +}
> +
> +static int temp_pgtable_map_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
> +				unsigned long end, pgprot_t prot)
> +{
> +	unsigned long next;
> +	unsigned long ret;
> +	p4d_t *dst_p4dp;
> +	p4d_t *src_p4dp;
> +
> +	if (pgd_none(READ_ONCE(*dst_pgdp))) {
> +		dst_p4dp = (p4d_t *)get_safe_page(GFP_ATOMIC);
> +		if (!dst_p4dp)
> +			return -ENOMEM;
> +
> +		pgd_populate(NULL, dst_pgdp, dst_p4dp);
> +	}
> +
> +	dst_p4dp = p4d_offset(dst_pgdp, start);
> +	src_p4dp = p4d_offset(src_pgdp, start);
> +
> +	do {
> +		p4d_t p4d = READ_ONCE(*src_p4dp);
> +
> +		next = p4d_addr_end(start, end);
> +
> +		if (p4d_none(p4d))
> +			continue;
> +
> +		if (p4d_leaf(p4d)) {
> +			set_p4d(dst_p4dp, __p4d(p4d_val(p4d) | pgprot_val(prot)));
> +		} else {
> +			ret = temp_pgtable_map_pud(dst_p4dp, src_p4dp, start, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_p4dp++, src_p4dp++, start = next, start != end);
> +
> +	return 0;
> +}
> +
> +static int temp_pgtable_mapping(pgd_t *pgdp, unsigned long start, unsigned long end, pgprot_t prot)
> +{
> +	pgd_t *dst_pgdp = pgd_offset_pgd(pgdp, start);
> +	pgd_t *src_pgdp = pgd_offset_k(start);
> +	unsigned long next;
> +	unsigned long ret;
> +
> +	do {
> +		pgd_t pgd = READ_ONCE(*src_pgdp);
> +
> +		next = pgd_addr_end(start, end);
> +
> +		if (pgd_none(pgd))
> +			continue;
> +
> +		if (pgd_leaf(pgd)) {
> +			set_pgd(dst_pgdp, __pgd(pgd_val(pgd) | pgprot_val(prot)));
> +		} else {
> +			ret = temp_pgtable_map_p4d(dst_pgdp, src_pgdp, start, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_pgdp++, src_pgdp++, start = next, start != end);
> +
> +	return 0;
> +}
> +
> +static unsigned long relocate_restore_code(void)
> +{
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	copy_page(page, hibernate_core_restore_code);
> +
> +	/* Make the page containing the relocated code executable. */
> +	set_memory_x((unsigned long)page, 1);
> +
> +	return (unsigned long)page;
> +}
> +
> +int swsusp_arch_resume(void)
> +{
> +	unsigned long end = (unsigned long)pfn_to_virt(max_low_pfn);
> +	unsigned long start = PAGE_OFFSET;
> +	int ret;
> +
> +	/*
> +	 * Memory allocated by get_safe_page() will be dealt with by the hibernation core,
> +	 * we don't need to free it here.
> +	 */
> +	resume_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!resume_pg_dir)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Create a temporary page table and map the whole linear region as executable and
> +	 * writable.
> +	 */
> +	ret = temp_pgtable_mapping(resume_pg_dir, start, end, __pgprot(_PAGE_WRITE | _PAGE_EXEC));
> +	if (ret)
> +		return ret;
> +
> +	/* Move the restore code to a new page so that it doesn't get overwritten by itself. */
> +	relocated_restore_code = relocate_restore_code();
> +	if (relocated_restore_code == -ENOMEM)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Map the __hibernate_cpu_resume() address to the temporary page table so that the
> +	 * restore code can jumps to it after finished restore the image. The next execution
> +	 * code doesn't find itself in a different address space after switching over to the
> +	 * original page table used by the hibernated image.
> +	 * The __hibernate_cpu_resume() mapping is unnecessary for RV32 since the kernel and
> +	 * linear addresses are identical, but different for RV64. To ensure consistency, we
> +	 * map it for both RV32 and RV64 kernels.
> +	 * Additionally, we should ensure that the page is writable before restoring the image.
> +	 */
> +	start = (unsigned long)resume_hdr.restore_cpu_addr;
> +	end = start + PAGE_SIZE;
> +
> +	ret = temp_pgtable_mapping(resume_pg_dir, start, end, __pgprot(_PAGE_WRITE));
> +	if (ret)
> +		return ret;
> +
> +	hibernate_restore_image(resume_hdr.saved_satp, (PFN_DOWN(__pa(resume_pg_dir)) | satp_mode),
> +				resume_hdr.restore_cpu_addr);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP_SMP
> +int hibernate_resume_nonboot_cpu_disable(void)
> +{
> +	if (sleep_cpu < 0) {
> +		pr_err("Failing to resume from hibernate on an unknown CPU\n");
> +		return -ENODEV;
> +	}
> +
> +	return freeze_secondary_cpus(sleep_cpu);
> +}
> +#endif
> +
> +static int __init riscv_hibernate_init(void)
> +{
> +	hibernate_cpu_context = kzalloc(sizeof(*hibernate_cpu_context), GFP_KERNEL);
> +
> +	if (WARN_ON(!hibernate_cpu_context))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +early_initcall(riscv_hibernate_init);
> --
> 2.34.1

