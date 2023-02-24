Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8E6A1C27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBXM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBXM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:29:39 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96885653E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:29:30 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 47FC7E000A;
        Fri, 24 Feb 2023 12:29:24 +0000 (UTC)
Message-ID: <4119a2dd-e598-ec22-0872-e352898fa660@ghiti.fr>
Date:   Fri, 24 Feb 2023 13:29:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Content-Language: en-US
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-5-jeeheng.sia@starfivetech.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230221023523.1498500-5-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 03:35, Sia Jee Heng wrote:
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
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>   arch/riscv/Kconfig                 |   7 +
>   arch/riscv/include/asm/assembler.h |  20 ++
>   arch/riscv/include/asm/suspend.h   |  19 ++
>   arch/riscv/kernel/Makefile         |   1 +
>   arch/riscv/kernel/asm-offsets.c    |   5 +
>   arch/riscv/kernel/hibernate-asm.S  |  77 +++++
>   arch/riscv/kernel/hibernate.c      | 447 +++++++++++++++++++++++++++++
>   7 files changed, 576 insertions(+)
>   create mode 100644 arch/riscv/kernel/hibernate-asm.S
>   create mode 100644 arch/riscv/kernel/hibernate.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..4555848a817f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -690,6 +690,13 @@ menu "Power management options"
>   
>   source "kernel/power/Kconfig"
>   
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +
> +config ARCH_HIBERNATION_HEADER
> +	def_bool y
> +	depends on HIBERNATION
> +
>   endmenu # "Power management options"
>   
>   menu "CPU Power Management"
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> index 727a97735493..68c46c0e0ea8 100644
> --- a/arch/riscv/include/asm/assembler.h
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -59,4 +59,24 @@
>   		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
>   	.endm
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
>   #endif	/* __ASM_ASSEMBLER_H */
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 75419c5ca272..3362da56a9d8 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -21,6 +21,11 @@ struct suspend_context {
>   #endif
>   };
>   
> +/*
> + * Used by hibernation core and cleared during resume sequence
> + */
> +extern int in_suspend;
> +
>   /* Low-level CPU suspend entry function */
>   int __cpu_suspend_enter(struct suspend_context *context);
>   
> @@ -36,4 +41,18 @@ int __cpu_resume_enter(unsigned long hartid, unsigned long context);
>   /* Used to save and restore the csr */
>   void suspend_save_csrs(struct suspend_context *context);
>   void suspend_restore_csrs(struct suspend_context *context);
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
>   #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..daab341d55e4 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MODULES)		+= module.o
>   obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>   
>   obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
>   
>   obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>   obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index df9444397908..d6a75aac1d27 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -9,6 +9,7 @@
>   #include <linux/kbuild.h>
>   #include <linux/mm.h>
>   #include <linux/sched.h>
> +#include <linux/suspend.h>
>   #include <asm/kvm_host.h>
>   #include <asm/thread_info.h>
>   #include <asm/ptrace.h>
> @@ -116,6 +117,10 @@ void asm_offsets(void)
>   
>   	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
>   
> +	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> +	OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
> +	OFFSET(HIBERN_PBE_NEXT, pbe, next);
> +
>   	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
>   	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
>   	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> new file mode 100644
> index 000000000000..846affe4dced
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
> +	restore_csr
> +	restore_reg
> +
> +	/* Return zero value. */
> +	add	a0, zero, zero
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
> index 000000000000..46a2f470db6e
> --- /dev/null
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -0,0 +1,447 @@
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
> + * @uts_version: to save the build number and date so that the we do not resume with
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
> +static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
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
> +static unsigned long _temp_pgtable_map_pte(pte_t *dst_ptep, pte_t *src_ptep,
> +					   unsigned long addr, pgprot_t prot)
> +{
> +	pte_t pte = READ_ONCE(*src_ptep);
> +
> +	if (pte_present(pte))
> +		set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
> +
> +	return 0;
> +}


I don't see the need for this function


> +
> +static unsigned long temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp,
> +					  unsigned long start, unsigned long end,
> +					  pgprot_t prot)
> +{
> +	unsigned long addr = start;
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
> +		_temp_pgtable_map_pte(dst_ptep, src_ptep, addr, prot);
> +	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr < end);
> +
> +	return 0;
> +}
> +
> +static unsigned long temp_pgtable_map_pmd(pud_t *dst_pudp, pud_t *src_pudp,
> +					  unsigned long start, unsigned long end,
> +					  pgprot_t prot)
> +{
> +	unsigned long addr = start;
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
> +		next = pmd_addr_end(addr, end);
> +
> +		if (pmd_none(pmd))
> +			continue;
> +
> +		if (pmd_leaf(pmd)) {
> +			set_pmd(dst_pmdp, __pmd(pmd_val(pmd) | pgprot_val(prot)));
> +		} else {
> +			ret = temp_pgtable_map_pte(dst_pmdp, src_pmdp, addr, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static unsigned long temp_pgtable_map_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp,
> +					  unsigned long start,
> +					  unsigned long end, pgprot_t prot)
> +{
> +	unsigned long addr = start;
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
> +		next = pud_addr_end(addr, end);
> +
> +		if (pud_none(pud))
> +			continue;
> +
> +		if (pud_leaf(pud)) {
> +			set_pud(dst_pudp, __pud(pud_val(pud) | pgprot_val(prot)));
> +		} else {
> +			ret = temp_pgtable_map_pmd(dst_pudp, src_pudp, addr, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static unsigned long temp_pgtable_map_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp,
> +					  unsigned long start, unsigned long end,
> +					  pgprot_t prot)
> +{
> +	unsigned long addr = start;


Nit: you don't need the addr variable, you can rename start into addr 
and directly work with it.


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
> +		next = p4d_addr_end(addr, end);
> +
> +		if (p4d_none(READ_ONCE(*src_p4dp)))


You should use p4d here: p4d_none(p4d)


> +			continue;
> +
> +		if (p4d_leaf(p4d)) {
> +			set_p4d(dst_p4dp, __p4d(p4d_val(p4d) | pgprot_val(prot)));


The "| pgprot_val(prot)" happens to work because PAGE_KERNEL will add 
the PAGE_WRITE bit: I'd rather make it more clear by explicitly add 
PAGE_WRITE.


> +		} else {
> +			ret = temp_pgtable_map_pud(dst_p4dp, src_p4dp, addr, next, prot);
> +			if (ret)
> +				return -ENOMEM;
> +		}
> +	} while (dst_p4dp++, src_p4dp++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static unsigned long temp_pgtable_mapping(pgd_t *pgdp)
> +{
> +	unsigned long end = (unsigned long)pfn_to_virt(max_low_pfn);
> +	unsigned long addr = PAGE_OFFSET;
> +	pgd_t *dst_pgdp = pgd_offset_pgd(pgdp, addr);
> +	pgd_t *src_pgdp = pgd_offset_k(addr);
> +	unsigned long next;
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (pgd_none(READ_ONCE(*src_pgdp)))
> +			continue;
> +


We added the pgd_leaf test in kernel_page_present, let's add it here too.


> +		if (temp_pgtable_map_p4d(dst_pgdp, src_pgdp, addr, next, PAGE_KERNEL))
> +			return -ENOMEM;
> +	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static unsigned long temp_pgtable_text_mapping(pgd_t *pgdp, unsigned long addr)
> +{
> +	pgd_t *dst_pgdp = pgd_offset_pgd(pgdp, addr);
> +	pgd_t *src_pgdp = pgd_offset_k(addr);
> +
> +	if (pgd_none(READ_ONCE(*src_pgdp)))
> +		return -EFAULT;
> +
> +	if (temp_pgtable_map_p4d(dst_pgdp, src_pgdp, addr, addr, PAGE_KERNEL_EXEC))
> +		return -ENOMEM;
> +
> +	return 0;
> +}


Ok so if we fall into a huge mapping, you add the exec permission to the 
whole range, which could easily be 1GB. I think that either we can avoid 
this step by mapping the whole linear mapping as executable, or we 
actually use another pgd entry for this page that is not in the linear 
mapping. The latter seems cleaner, what do you think?


> +
> +static unsigned long relocate_restore_code(void)
> +{
> +	unsigned long ret;
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
> +	ret = temp_pgtable_text_mapping(resume_pg_dir, (unsigned long)page);
> +	if (ret)
> +		return ret;
> +
> +	return (unsigned long)page;
> +}
> +
> +int swsusp_arch_resume(void)
> +{
> +	unsigned long ret;
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
> +	 * The pages need to be writable when restoring the image.
> +	 * Create a second copy of page table just for the linear map.
> +	 * Use this temporary page table to restore the image.
> +	 */
> +	ret = temp_pgtable_mapping(resume_pg_dir);
> +	if (ret)
> +		return (int)ret;


The temp_pgtable* functions should return an int to avoid this cast.


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
> +	 */
> +	ret = temp_pgtable_text_mapping(resume_pg_dir, (unsigned long)resume_hdr.restore_cpu_addr);
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


Overall, it is now nicer with the the proper page table walk: but we can 
now see that the code is exactly the same as arm64, what prevents us 
from merging both somewhere in mm/?


