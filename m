Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFA56E763E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjDSJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjDSJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:28:51 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E1FA269;
        Wed, 19 Apr 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681896522; bh=zeObvZm8dtQxYO14cpBrQ4sCv7bVHzw8TkncElZbjZg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bG4RS2fVBk44egHyhTZHh8Cu6H2AEIKlc7Cc/E47VDWVKP4M+W46eIRPQXC4GtGsu
         +LTUldGRUGwPDJEqjNccSvcoN9vrIAscbsmkdu4KfAJUjZ9uk92vuHEUl3O1rV9VOb
         DrlwbUzKkJGfGqRBldYVY89aF1bVpgHcd+0G1CK4=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4353C6011C;
        Wed, 19 Apr 2023 17:28:42 +0800 (CST)
Message-ID: <f80d89fb-3428-a0c3-b41e-9619ed5adc8c@xen0n.name>
Date:   Wed, 19 Apr 2023 17:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 01/30] LoongArch: KVM: Add kvm related header files
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
References: <20230417094649.874671-1-zhaotianrui@loongson.cn>
 <20230417094649.874671-2-zhaotianrui@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230417094649.874671-2-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/17 17:46, Tianrui Zhao wrote:
> Add LoongArch KVM related header files, including kvm.h,
> kvm_host.h, kvm_types.h. All of those are about LoongArch
> virtualization features and kvm interfaces.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>   arch/loongarch/include/asm/cpu-features.h |  22 ++
>   arch/loongarch/include/asm/kvm_host.h     | 268 ++++++++++++++++++++++
>   arch/loongarch/include/asm/kvm_types.h    |  11 +
>   arch/loongarch/include/uapi/asm/kvm.h     | 107 +++++++++
>   include/uapi/linux/kvm.h                  |   9 +
>   5 files changed, 417 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/kvm_host.h
>   create mode 100644 arch/loongarch/include/asm/kvm_types.h
>   create mode 100644 arch/loongarch/include/uapi/asm/kvm.h
> 
> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
> index b07974218393..345b7674a15f 100644
> --- a/arch/loongarch/include/asm/cpu-features.h
> +++ b/arch/loongarch/include/asm/cpu-features.h
> @@ -64,5 +64,27 @@
>   #define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
>   #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
>   
> +#define cpu_has_matc_guest	(cpu_data[0].guest_cfg & BIT(0))
> +#define cpu_has_matc_root	(cpu_data[0].guest_cfg & BIT(1))
> +#define cpu_has_matc_nest	(cpu_data[0].guest_cfg & BIT(2))
> +#define cpu_has_sitp		(cpu_data[0].guest_cfg & BIT(6))
> +#define cpu_has_titp		(cpu_data[0].guest_cfg & BIT(8))
> +#define cpu_has_toep		(cpu_data[0].guest_cfg & BIT(10))
> +#define cpu_has_topp		(cpu_data[0].guest_cfg & BIT(12))
> +#define cpu_has_torup		(cpu_data[0].guest_cfg & BIT(14))
> +#define cpu_has_gcip_all	(cpu_data[0].guest_cfg & BIT(16))
> +#define cpu_has_gcip_hit	(cpu_data[0].guest_cfg & BIT(17))
> +#define cpu_has_gcip_secure	(cpu_data[0].guest_cfg & BIT(18))

We don't have guest_cfg yet in the cpu_data structure. You may have to 
re-organize a little bit to avoid referencing things from future commits.

Also you may want to make more use of the definitions already in 
<asm/loongarch.h>, e.g. the BIT(6) here is just CSR_GCFG_SITP, and it 
seems the matc_{guest,root,nest} definitions here conflict with the 
definitions in <asm/loongarch.h> which implies the MATC is a plain value 
instead of a bunch of bit flags.

> +
> +/*
> + * Guest capabilities
> + */
> +#define cpu_guest_has_conf1	(cpu_data[0].guest.conf & BIT(1))
> +#define cpu_guest_has_conf2	(cpu_data[0].guest.conf & BIT(2))
> +#define cpu_guest_has_conf3	(cpu_data[0].guest.conf & BIT(3))
> +#define cpu_guest_has_fpu	(cpu_data[0].guest.options & LOONGARCH_CPU_FPU)
> +#define cpu_guest_has_perf	(cpu_data[0].guest.options & LOONGARCH_CPU_PMP)
> +#define cpu_guest_has_watch	(cpu_data[0].guest.options & LOONGARCH_CPU_WATCH)
> +#define cpu_guest_has_lsx	(cpu_data[0].guest.ases & LOONGARCH_ASE_LSX)

There is no LOONGARCH_ASE_LSX either.

>   
>   #endif /* __ASM_CPU_FEATURES_H */
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> new file mode 100644
> index 000000000000..bd239079b36f
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -0,0 +1,268 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_LOONGARCH_KVM_HOST_H__
> +#define __ASM_LOONGARCH_KVM_HOST_H__
> +
> +#include <linux/cpumask.h>
> +#include <linux/mutex.h>
> +#include <linux/hrtimer.h>
> +#include <linux/interrupt.h>
> +#include <linux/types.h>
> +#include <linux/kvm.h>
> +#include <linux/kvm_types.h>
> +#include <linux/threads.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/inst.h>
> +#include <asm/loongarch.h>
> +
> +/* Loongarch KVM register ids */
> +#define LOONGARCH_CSR_32(_R, _S)	\
> +	(KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
> +
> +#define LOONGARCH_CSR_64(_R, _S)	\
> +	(KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
> +
> +#define KVM_IOC_CSRID(id)		LOONGARCH_CSR_64(id, 0)
> +#define KVM_GET_IOC_CSRIDX(id)		((id & KVM_CSR_IDX_MASK) >> 3)
> +
> +#define KVM_MAX_VCPUS			256
> +/* memory slots that does not exposed to userspace */
> +#define KVM_PRIVATE_MEM_SLOTS		0
> +
> +#define KVM_HALT_POLL_NS_DEFAULT	500000
> +
> +struct kvm_vm_stat {
> +	struct kvm_vm_stat_generic generic;
> +};
> +
> +struct kvm_vcpu_stat {
> +	struct kvm_vcpu_stat_generic generic;
> +	u64 idle_exits;
> +	u64 signal_exits;
> +	u64 int_exits;
> +	u64 cpucfg_exits;
> +};
> +
> +struct kvm_arch_memory_slot {
> +};
> +
> +struct kvm_context {
> +	unsigned long vpid_cache;
> +	struct kvm_vcpu *last_vcpu;
> +};
> +
> +struct kvm_world_switch {
> +	int (*guest_eentry)(void);
> +	int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +	unsigned long page_order;
> +};
> +
> +struct kvm_arch {
> +	/* Guest physical mm */
> +	struct mm_struct gpa_mm;
> +	/* Mask of CPUs needing GPA ASID flush */
> +	cpumask_t asid_flush_mask;
> +
> +	unsigned char online_vcpus;
> +	unsigned char is_migrate;
> +	s64 time_offset;
> +	struct kvm_context __percpu *vmcs;
> +	unsigned long gpa_size;
> +};
> +
> +
> +#define LOONGARCH_CSRS		0x100
> +#define CSR_UCWIN_BASE		0x100
> +#define CSR_UCWIN_SIZE		0x10
> +#define CSR_DMWIN_BASE		0x180
> +#define CSR_DMWIN_SIZE		0x4 > +#define CSR_PERF_BASE		0x200
> +#define CSR_PERF_SIZE		0x8
> +#define CSR_DEBUG_BASE		0x500
> +#define CSR_DEBUG_SIZE		0x3
> +#define CSR_ALL_SIZE		0x800

Is the "SIZE"'s actually "numbers"? 16-byte or even 3-byte CSRs make 
absolutely no sense in LoongArch. However e.g. there are indeed 4 DMWINs 
in total, so I think you may want to say "number of xxx" instead (in 
which case you should probably name them "CSR_XXX_NUM").

Also there are duplications here too.  CSR_UCWIN_BASE is just 
LOONGARCH_CSR_UCAWIN, CSR_DMWIN_BASE is LOONGARCH_CSR_DMWIN0, 
CSR_PERF_BASE is LOONGARCH_CSR_PERFCTRL0, and CSR_DEBUG_BASE is 
LOONGARCH_CSR_DEBUG. You should at least avoid repeating the magic numbers.

> +
> +struct loongarch_csrs {
> +	unsigned long csrs[CSR_ALL_SIZE];
> +};
> +
> +/* Resume Flags */
> +#define RESUME_GUEST		1
> +#define RESUME_HOST		0
> +
> +enum emulation_result {
> +	EMULATE_DONE,		/* no further processing */
> +	EMULATE_DO_MMIO,	/* kvm_run filled with MMIO request */
> +	EMULATE_FAIL,		/* can't emulate this instruction */
> +	EMULATE_WAIT,		/* WAIT instruction */
> +	EMULATE_EXCEPT,		/* A guest exception has been generated */
> +	EMULATE_DO_IOCSR,	/* handle IOCSR request */
> +};
> +
> +#define KVM_NR_MEM_OBJS		4
> +#define KVM_LARCH_FPU		(0x1 << 0)
> +#define KVM_LARCH_CSR		(0x1 << 1)
> +
> +struct kvm_vcpu_arch {
> +	/*
> +	 * Switch pointer-to-function type to unsigned long
> +	 * for loading the value into register directly.
> +	 */
> +	unsigned long guest_eentry;
> +	unsigned long host_eentry;
> +
> +	/* Pointers stored here for easy access from assembly code. */

nit: remove trailing period

> +	int (*handle_exit)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +
> +	/* Host registers preserved across guest mode execution */
> +	unsigned long host_stack;
> +	unsigned long host_gp;
> +	unsigned long host_pgd;
> +	unsigned long host_pgdhi;
> +	unsigned long host_entryhi;
> +
> +	/* Host CSR registers used when handling exits from guest */

nit: "Host CSRs"

> +	unsigned long badv;
> +	unsigned long host_estat;
> +	unsigned long badi;
> +	unsigned long host_ecfg;
> +	unsigned long host_percpu;
> +
> +	/* GPRS */

nit: "GPRs"

> +	unsigned long gprs[32];
> +	unsigned long pc;
> +
> +	/* FPU State */

nit: "state"

> +	struct loongarch_fpu fpu FPU_ALIGN;
> +	/* Which auxiliary state is loaded (KVM_LOONGARCH_AUX_*) */
> +	unsigned int aux_inuse;
> +
> +	/* CSR State */
> +	struct loongarch_csrs *csr;
> +
> +	/* GPR used as IO source/target */
> +	u32 io_gpr;
> +
> +	struct hrtimer swtimer;
> +	/* Count timer control KVM register */

This doesn't make sense, how can the timer control KVM? Seems something 
like "KVM register to control count timer" but I'm not sure.

> +	u32 count_ctl;
> +
> +	/* Bitmask of exceptions that are pending */
> +	unsigned long irq_pending;
> +	/* Bitmask of pending exceptions to be cleared */
> +	unsigned long irq_clear;
> +
> +	/* Cache some mmu pages needed inside spinlock regions */

"Cache for pages needed inside ..."?

> +	struct kvm_mmu_memory_cache mmu_page_cache;
> +
> +	/* vcpu's vpid */
> +	u64 vpid;
> +
> +	/* Period of stable timer tick in ns */
> +	u64 timer_period;

Can you make it "timer_period_ns" or are you following other arches' 
conventions?

> +	/* Frequency of stable timer in Hz */
> +	u64 timer_mhz;

Is it really MHz or Hz?

> +	/* Stable bias from the raw time */
> +	u64 timer_bias;
> +	/* Dynamic nanosecond bias (multiple of timer_period) to avoid overflow */
> +	s64 timer_dyn_bias;
> +	/* Save ktime */

The comment seems redundant (code is too trivial so the comment doesn't 
add any information).

> +	ktime_t stable_ktime_saved;
> +
> +	u64 core_ext_ioisr[4];
> +
> +	/* Last CPU the VCPU state was loaded on */

Use consistent spelling: "vCPU".

> +	int last_sched_cpu;
> +	/* Last CPU the VCPU actually executed guest code on */
> +	int last_exec_cpu;
> +	/* mp state */
> +	struct kvm_mp_state mp_state;
> +};
> +
> +static inline unsigned long readl_sw_gcsr(struct loongarch_csrs *csr, int reg)
> +{
> +	return csr->csrs[reg];
> +}
> +
> +static inline void writel_sw_gcsr(struct loongarch_csrs *csr, int reg,
> +		unsigned long val)
> +{
> +	csr->csrs[reg] = val;
> +}
> +
> +/* Helpers */
> +static inline bool _kvm_guest_has_fpu(struct kvm_vcpu_arch *arch)
> +{
> +	return cpu_has_fpu;
> +}
> +
> +void _kvm_init_fault(void);
> +
> +/* Debug: dump vcpu state */
> +int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
> +
> +/* MMU handling */
> +int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long badv, bool write);
> +void kvm_flush_tlb_all(void);
> +void _kvm_destroy_mm(struct kvm *kvm);
> +pgd_t *kvm_pgd_alloc(void);
> +
> +#define KVM_ARCH_WANT_MMU_NOTIFIER
> +int kvm_unmap_hva_range(struct kvm *kvm,
> +			unsigned long start, unsigned long end, bool blockable);
> +void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
> +int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
> +int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
> +
> +static inline void update_pc(struct kvm_vcpu_arch *arch)
> +{
> +	arch->pc += 4;
> +}
> +
> +/**
> + * kvm_is_ifetch_fault() - Find whether a TLBL exception is due to ifetch fault.
> + * @vcpu:	Virtual CPU.
> + *
> + * Returns:	Whether the TLBL exception was likely due to an instruction
> + *		fetch fault rather than a data load fault.
> + */
> +static inline bool kvm_is_ifetch_fault(struct kvm_vcpu_arch *arch)
> +{
> +	if (arch->pc == arch->badv)
> +		return true;
> +
> +	return false;

return arch->pc == arch->badv;

All other such occurrences should preferably be simplified too.

> +}
> +
> +/* Misc */
> +static inline void kvm_arch_hardware_unsetup(void) {}
> +static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> +static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
> +static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
> +static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_arch_free_memslot(struct kvm *kvm,
> +				   struct kvm_memory_slot *slot) {}
> +void _kvm_check_vmid(struct kvm_vcpu *vcpu, int cpu);
> +enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
> +int kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa);
> +void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
> +					const struct kvm_memory_slot *memslot);
> +void kvm_init_vmcs(struct kvm *kvm);
> +void kvm_vector_entry(void);
> +int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +extern const unsigned long kvm_vector_size;
> +extern const unsigned long kvm_enter_guest_size;
> +extern unsigned long vpid_mask;
> +extern struct kvm_world_switch *kvm_loongarch_ops;
> +
> +#define SW_GCSR	(1 << 0)
> +#define HW_GCSR	(1 << 1)
> +int get_gcsr_flag(int csr);
> +extern void set_hw_gcsr(int csr_id, unsigned long val);
> +#endif /* __ASM_LOONGARCH_KVM_HOST_H__ */
> diff --git a/arch/loongarch/include/asm/kvm_types.h b/arch/loongarch/include/asm/kvm_types.h
> new file mode 100644
> index 000000000000..060647b5fe2e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kvm_types.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef _ASM_LOONGARCH_KVM_TYPES_H
> +#define _ASM_LOONGARCH_KVM_TYPES_H
> +
> +#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE	4

Is there any difference with KVM_NR_MEM_OBJS in <asm/kvm_host.h> in the 
same commit? If they are actually the same thing you should avoid 
duplicating the "4".

> +
> +#endif /* _ASM_LOONGARCH_KVM_TYPES_H */
> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
> new file mode 100644
> index 000000000000..074d86ba532c
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __UAPI_ASM_LOONGARCH_KVM_H
> +#define __UAPI_ASM_LOONGARCH_KVM_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * KVM Loongarch specific structures and definitions.
> + *
> + * Some parts derived from the x86 version of this file.
> + */
> +
> +#define __KVM_HAVE_READONLY_MEM
> +
> +#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +
> +/*
> + * for KVM_GET_REGS and KVM_SET_REGS
> + */
> +struct kvm_regs {
> +	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
> +	__u64 gpr[32];
> +	__u64 pc;
> +};
> +
> +/*
> + * for KVM_GET_FPU and KVM_SET_FPU
> + */
> +struct kvm_fpu {
> +	__u32 fcsr;
> +	__u32 none;

Is this field an explicit padding? Probably it's better to use a more 
descriptive name like __pad0 if it's the case.

> +	__u64 fcc;    /* 8x8 */
> +	struct kvm_fpureg {
> +		__u64 val64[4];
> +	} fpr[32];
> +};
> +
> +/*
> + * For LoongArch, we use KVM_SET_ONE_REG and KVM_GET_ONE_REG to access various
> + * registers.  The id field is broken down as follows:
> + *
> + *  bits[63..52] - As per linux/kvm.h
> + *  bits[51..32] - Must be zero.
> + *  bits[31..16] - Register set.
> + *
> + * Register set = 0: GP registers from kvm_regs (see definitions below).
> + *
> + * Register set = 1: CSR registers.
> + *
> + * Register set = 2: KVM specific registers (see definitions below).
> + *
> + * Register set = 3: FPU / SIMD registers (see definitions below).
> + *
> + * Other sets registers may be added in the future.  Each set would
> + * have its own identifier in bits[31..16].
> + */
> +
> +#define KVM_REG_LOONGARCH_GP		(KVM_REG_LOONGARCH | 0x00000ULL)
> +#define KVM_REG_LOONGARCH_CSR		(KVM_REG_LOONGARCH | 0x10000ULL)
> +#define KVM_REG_LOONGARCH_KVM		(KVM_REG_LOONGARCH | 0x20000ULL)
> +#define KVM_REG_LOONGARCH_FPU		(KVM_REG_LOONGARCH | 0x30000ULL)
> +#define KVM_REG_LOONGARCH_MASK		(KVM_REG_LOONGARCH | 0x30000ULL)
> +#define KVM_CSR_IDX_MASK		(0x10000 - 1)
> +
> +/*
> + * KVM_REG_LOONGARCH_KVM - KVM specific control registers.
> + */
> +
> +#define KVM_REG_LOONGARCH_COUNTER	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 3)
> +#define KVM_REG_LOONGARCH_VCPU_RESET	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 4)
> +
> +struct kvm_debug_exit_arch {
> +};
> +
> +/* for KVM_SET_GUEST_DEBUG */
> +struct kvm_guest_debug_arch {
> +};
> +
> +/* definition of registers in kvm_run */
> +struct kvm_sync_regs {
> +};
> +
> +/* dummy definition */
> +struct kvm_sregs {
> +};
> +
> +struct kvm_iocsr_entry {
> +	__u32 addr;
> +	__u32 pad;
> +	__u64 data;
> +};
> +
> +struct kvm_loongarch_interrupt {
> +	/* in */
> +	__u32 cpu;
> +	__u32 irq;
> +};
> +
> +#define KVM_NR_IRQCHIPS		1
> +#define KVM_IRQCHIP_NUM_PINS	64
> +#define KVM_MAX_CORES		256
> +
> +#endif /* __UAPI_ASM_LOONGARCH_KVM_H */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d77aef872a0a..d14fde87ae35 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -264,6 +264,7 @@ struct kvm_xen_exit {
>   #define KVM_EXIT_RISCV_SBI        35
>   #define KVM_EXIT_RISCV_CSR        36
>   #define KVM_EXIT_NOTIFY           37
> +#define KVM_EXIT_LOONGARCH_IOCSR  38
>   
>   /* For KVM_EXIT_INTERNAL_ERROR */
>   /* Emulate instruction failed. */
> @@ -336,6 +337,13 @@ struct kvm_run {
>   			__u32 len;
>   			__u8  is_write;
>   		} mmio;
> +		/* KVM_EXIT_LOONGARCH_IOCSR */
> +		struct {
> +			__u64 phys_addr;
> +			__u8  data[8];
> +			__u32 len;
> +			__u8  is_write;
> +		} iocsr_io;
>   		/* KVM_EXIT_HYPERCALL */
>   		struct {
>   			__u64 nr;
> @@ -1354,6 +1362,7 @@ struct kvm_dirty_tlb {
>   #define KVM_REG_ARM64		0x6000000000000000ULL
>   #define KVM_REG_MIPS		0x7000000000000000ULL
>   #define KVM_REG_RISCV		0x8000000000000000ULL
> +#define KVM_REG_LOONGARCH	0x9000000000000000ULL
>   
>   #define KVM_REG_SIZE_SHIFT	52
>   #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

