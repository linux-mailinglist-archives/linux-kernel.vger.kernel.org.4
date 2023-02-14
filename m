Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236A6956D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjBNC5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBNC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:56:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C77D617CCC;
        Mon, 13 Feb 2023 18:56:52 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Axrtpz+OpjJFcAAA--.1083S3;
        Tue, 14 Feb 2023 10:56:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axeb1w+OpjmZwyAA--.28802S3;
        Tue, 14 Feb 2023 10:56:50 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v1 01/24] LoongArch: KVM: Implement kvm module related interface
Date:   Tue, 14 Feb 2023 10:56:25 +0800
Message-Id: <20230214025648.1898508-2-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230214025648.1898508-1-zhaotianrui@loongson.cn>
References: <20230214025648.1898508-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axeb1w+OpjmZwyAA--.28802S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3Aw4DGFW8Xw1fWrWDAF15XFb_yoW8ZryDto
        W3JF4rWw18Wr1ru398Cr17tayUZrZ5KFsrA3ZxA3s5X3W7Jwn8Wr1xKw4FqF13Xrn5KrZx
        uasIqwnrXayIy3Wkn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUkm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64
        kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
        kF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaV
        Av8VWrMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWU
        AVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4RKpBTUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Implement loongarch kvm module init, module exit interface,
using kvm context to save the vpid info and vcpu world switch
interface pointer.
2. Implement kvm hardware enable, disable interface, setting
the guest config reg to enable virtualization features.
3. Add kvm related headers.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h |  22 ++
 arch/loongarch/include/asm/kvm_host.h     | 257 ++++++++++++++++++++++
 arch/loongarch/include/asm/kvm_types.h    |  11 +
 arch/loongarch/include/uapi/asm/kvm.h     | 121 ++++++++++
 arch/loongarch/kvm/main.c                 | 152 +++++++++++++
 include/uapi/linux/kvm.h                  |  15 ++
 6 files changed, 578 insertions(+)
 create mode 100644 arch/loongarch/include/asm/kvm_host.h
 create mode 100644 arch/loongarch/include/asm/kvm_types.h
 create mode 100644 arch/loongarch/include/uapi/asm/kvm.h
 create mode 100644 arch/loongarch/kvm/main.c

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index b07974218..23e7c3ae5 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -64,5 +64,27 @@
 #define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
 #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
 
+#define cpu_has_matc_guest	(cpu_data[0].guest_cfg & (1 << 0))
+#define cpu_has_matc_root	(cpu_data[0].guest_cfg & (1 << 1))
+#define cpu_has_matc_nest	(cpu_data[0].guest_cfg & (1 << 2))
+#define cpu_has_sitp		(cpu_data[0].guest_cfg & (1 << 6))
+#define cpu_has_titp		(cpu_data[0].guest_cfg & (1 << 8))
+#define cpu_has_toep		(cpu_data[0].guest_cfg & (1 << 10))
+#define cpu_has_topp		(cpu_data[0].guest_cfg & (1 << 12))
+#define cpu_has_torup		(cpu_data[0].guest_cfg & (1 << 14))
+#define cpu_has_gcip_all	(cpu_data[0].guest_cfg & (1 << 16))
+#define cpu_has_gcip_hit	(cpu_data[0].guest_cfg & (1 << 17))
+#define cpu_has_gcip_secure	(cpu_data[0].guest_cfg & (1 << 18))
+
+/*
+ * Guest capabilities
+ */
+#define cpu_guest_has_conf1	(cpu_data[0].guest.conf & (1 << 1))
+#define cpu_guest_has_conf2	(cpu_data[0].guest.conf & (1 << 2))
+#define cpu_guest_has_conf3	(cpu_data[0].guest.conf & (1 << 3))
+#define cpu_guest_has_fpu	(cpu_data[0].guest.options & LOONGARCH_CPU_FPU)
+#define cpu_guest_has_perf	(cpu_data[0].guest.options & LOONGARCH_CPU_PMP)
+#define cpu_guest_has_watch	(cpu_data[0].guest.options & LOONGARCH_CPU_WATCH)
+#define cpu_guest_has_lsx	(cpu_data[0].guest.ases & LOONGARCH_ASE_LSX)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
new file mode 100644
index 000000000..fa464e476
--- /dev/null
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_LOONGARCH_KVM_HOST_H__
+#define __ASM_LOONGARCH_KVM_HOST_H__
+
+#include <linux/cpumask.h>
+#include <linux/mutex.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
+#include <linux/threads.h>
+#include <linux/spinlock.h>
+
+#include <asm/inst.h>
+#include <asm/loongarch.h>
+
+/* Loongarch KVM register ids */
+#define LOONGARCH_CSR_32(_R, _S)	\
+	(KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
+
+#define LOONGARCH_CSR_64(_R, _S)	\
+	(KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
+
+#define KVM_IOC_CSRID(id)		LOONGARCH_CSR_64(id, 0)
+#define KVM_GET_IOC_CSRIDX(id)		((id & KVM_CSR_IDX_MASK) >> 3)
+
+#define KVM_MAX_VCPUS			256
+/* memory slots that does not exposed to userspace */
+#define KVM_PRIVATE_MEM_SLOTS		0
+
+#define KVM_HALT_POLL_NS_DEFAULT	500000
+
+struct kvm_vm_stat {
+	struct kvm_vm_stat_generic generic;
+};
+
+struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_generic generic;
+	u64 idle_exits;
+	u64 signal_exits;
+	u64 int_exits;
+	u64 cpucfg_exits;
+};
+
+struct kvm_arch_memory_slot {
+};
+
+struct kvm_context {
+	unsigned long vpid_mask;
+	unsigned long vpid_cache;
+	void *kvm_eentry;
+	void *kvm_enter_guest;
+	unsigned long page_order;
+	struct kvm_vcpu *last_vcpu;
+};
+
+struct kvm_arch {
+	/* Guest physical mm */
+	struct mm_struct gpa_mm;
+	/* Mask of CPUs needing GPA ASID flush */
+	cpumask_t asid_flush_mask;
+
+	unsigned char online_vcpus;
+	unsigned char is_migrate;
+	s64 time_offset;
+	struct kvm_context __percpu *vmcs;
+};
+
+
+#define LOONGARCH_CSRS		0x100
+#define CSR_UCWIN_BASE		0x100
+#define CSR_UCWIN_SIZE		0x10
+#define CSR_DMWIN_BASE		0x180
+#define CSR_DMWIN_SIZE		0x4
+#define CSR_PERF_BASE		0x200
+#define CSR_PERF_SIZE		0x8
+#define CSR_DEBUG_BASE		0x500
+#define CSR_DEBUG_SIZE		0x3
+#define CSR_ALL_SIZE		0x800
+
+struct loongarch_csrs {
+	unsigned long csrs[CSR_ALL_SIZE];
+};
+
+/* Resume Flags */
+#define RESUME_FLAG_DR		(1<<0)	/* Reload guest nonvolatile state? */
+#define RESUME_FLAG_HOST	(1<<1)	/* Resume host? */
+
+#define RESUME_GUEST		0
+#define RESUME_GUEST_DR		RESUME_FLAG_DR
+#define RESUME_HOST		RESUME_FLAG_HOST
+
+enum emulation_result {
+	EMULATE_DONE,		/* no further processing */
+	EMULATE_DO_MMIO,	/* kvm_run filled with MMIO request */
+	EMULATE_FAIL,		/* can't emulate this instruction */
+	EMULATE_WAIT,		/* WAIT instruction */
+	EMULATE_EXCEPT,		/* A guest exception has been generated */
+	EMULATE_DO_IOCSR,	/* handle IOCSR request */
+};
+
+#define KVM_NR_MEM_OBJS		4
+#define KVM_LARCH_FPU		(0x1 << 0)
+
+struct kvm_vcpu_arch {
+	unsigned long guest_eentry;
+	unsigned long host_eentry;
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
+	int (*handle_exit)(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+	/* Host registers preserved across guest mode execution */
+	unsigned long host_stack;
+	unsigned long host_gp;
+	unsigned long host_pgd;
+	unsigned long host_pgdhi;
+	unsigned long host_entryhi;
+
+	/* Host CSR registers used when handling exits from guest */
+	unsigned long badv;
+	unsigned long host_estat;
+	unsigned long badi;
+	unsigned long host_ecfg;
+	unsigned long host_percpu;
+
+	/* GPRS */
+	unsigned long gprs[32];
+	unsigned long pc;
+
+	/* FPU State */
+	struct loongarch_fpu fpu FPU_ALIGN;
+	/* Which auxiliary state is loaded (KVM_LOONGARCH_AUX_*) */
+	unsigned int aux_inuse;
+
+	/* CSR State */
+	struct loongarch_csrs *csr;
+
+	/* GPR used as IO source/target */
+	u32 io_gpr;
+
+	struct hrtimer swtimer;
+	/* Count timer control KVM register */
+	u32 count_ctl;
+
+	/* Bitmask of exceptions that are pending */
+	unsigned long irq_pending;
+	/* Bitmask of pending exceptions to be cleared */
+	unsigned long irq_clear;
+
+	/* Cache some mmu pages needed inside spinlock regions */
+	struct kvm_mmu_memory_cache mmu_page_cache;
+
+	/* vcpu's vpid is different on each host cpu in an smp system */
+	u64 vpid[NR_CPUS];
+
+	/* Period of stable timer tick in ns */
+	u64 timer_period;
+	/* Frequency of stable timer in Hz */
+	u64 timer_mhz;
+	/* Stable bias from the raw time */
+	u64 timer_bias;
+	/* Dynamic nanosecond bias (multiple of timer_period) to avoid overflow */
+	s64 timer_dyn_bias;
+	/* Save ktime */
+	ktime_t stable_ktime_saved;
+
+	u64 core_ext_ioisr[4];
+
+	/* Last CPU the VCPU state was loaded on */
+	int last_sched_cpu;
+	/* Last CPU the VCPU actually executed guest code on */
+	int last_exec_cpu;
+
+	u8 fpu_enabled;
+	struct kvm_guest_debug_arch guest_debug;
+};
+
+static inline unsigned long readl_sw_gcsr(struct loongarch_csrs *csr, int reg)
+{
+	return csr->csrs[reg];
+}
+
+static inline void writel_sw_gcsr(struct loongarch_csrs *csr, int reg,
+		unsigned long val)
+{
+	csr->csrs[reg] = val;
+}
+
+/* Helpers */
+static inline bool _kvm_guest_has_fpu(struct kvm_vcpu_arch *arch)
+{
+	return cpu_has_fpu && arch->fpu_enabled;
+}
+
+void _kvm_init_fault(void);
+
+/* Debug: dump vcpu state */
+int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
+
+/* MMU handling */
+int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long badv, bool write);
+void kvm_flush_tlb_all(void);
+void _kvm_destroy_mm(struct kvm *kvm);
+pgd_t *kvm_pgd_alloc(void);
+
+#define KVM_ARCH_WANT_MMU_NOTIFIER
+int kvm_unmap_hva_range(struct kvm *kvm,
+			unsigned long start, unsigned long end, bool blockable);
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
+
+static inline void update_pc(struct kvm_vcpu_arch *arch)
+{
+	arch->pc += 4;
+}
+
+/**
+ * kvm_is_ifetch_fault() - Find whether a TLBL exception is due to ifetch fault.
+ * @vcpu:	Virtual CPU.
+ *
+ * Returns:	Whether the TLBL exception was likely due to an instruction
+ *		fetch fault rather than a data load fault.
+ */
+static inline bool kvm_is_ifetch_fault(struct kvm_vcpu_arch *arch)
+{
+	if (arch->pc == arch->badv)
+		return true;
+
+	return false;
+}
+
+/* Misc */
+static inline void kvm_arch_hardware_unsetup(void) {}
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
+static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
+static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_free_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot) {}
+void _kvm_check_vmid(struct kvm_vcpu *vcpu, int cpu);
+enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
+int kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa);
+void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
+					const struct kvm_memory_slot *memslot);
+void kvm_init_vmcs(struct kvm *kvm);
+void kvm_vector_entry(void);
+int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
+extern const unsigned long kvm_vector_size;
+extern const unsigned long kvm_enter_guest_size;
+#endif /* __ASM_LOONGARCH_KVM_HOST_H__ */
diff --git a/arch/loongarch/include/asm/kvm_types.h b/arch/loongarch/include/asm/kvm_types.h
new file mode 100644
index 000000000..060647b5f
--- /dev/null
+++ b/arch/loongarch/include/asm/kvm_types.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_KVM_TYPES_H
+#define _ASM_LOONGARCH_KVM_TYPES_H
+
+#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE	4
+
+#endif /* _ASM_LOONGARCH_KVM_TYPES_H */
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
new file mode 100644
index 000000000..0f90e7913
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __UAPI_ASM_LOONGARCH_KVM_H
+#define __UAPI_ASM_LOONGARCH_KVM_H
+
+#include <linux/types.h>
+
+/*
+ * KVM Loongarch specific structures and definitions.
+ *
+ * Some parts derived from the x86 version of this file.
+ */
+
+#define __KVM_HAVE_READONLY_MEM
+
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
+/*
+ * for KVM_GET_REGS and KVM_SET_REGS
+ */
+struct kvm_regs {
+	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
+	__u64 gpr[32];
+	__u64 pc;
+};
+
+/*
+ * for KVM_GET_FPU and KVM_SET_FPU
+ */
+struct kvm_fpu {
+	__u32 fcsr;
+	__u32 none;
+	__u64 fcc;    /* 8x8 */
+	struct kvm_fpureg {
+		__u64 val64[4];	//support max 256 bits
+	} fpr[32];
+};
+
+/*
+ * For LOONGARCH, we use KVM_SET_ONE_REG and KVM_GET_ONE_REG to access various
+ * registers.  The id field is broken down as follows:
+ *
+ *  bits[63..52] - As per linux/kvm.h
+ *  bits[51..32] - Must be zero.
+ *  bits[31..16] - Register set.
+ *
+ * Register set = 0: GP registers from kvm_regs (see definitions below).
+ *
+ * Register set = 1: CSR registers.
+ *
+ * Register set = 2: KVM specific registers (see definitions below).
+ *
+ * Register set = 3: FPU / SIMD registers (see definitions below).
+ *
+ * Other sets registers may be added in the future.  Each set would
+ * have its own identifier in bits[31..16].
+ */
+
+#define KVM_REG_LOONGARCH_GP		(KVM_REG_LOONGARCH | 0x00000ULL)
+#define KVM_REG_LOONGARCH_CSR		(KVM_REG_LOONGARCH | 0x10000ULL)
+#define KVM_REG_LOONGARCH_KVM		(KVM_REG_LOONGARCH | 0x20000ULL)
+#define KVM_REG_LOONGARCH_FPU		(KVM_REG_LOONGARCH | 0x30000ULL)
+#define KVM_REG_LOONGARCH_MASK		(KVM_REG_LOONGARCH | 0x30000ULL)
+#define KVM_CSR_IDX_MASK		(0x10000 - 1)
+
+/*
+ * KVM_REG_LOONGARCH_KVM - KVM specific control registers.
+ */
+
+#define KVM_REG_LOONGARCH_COUNTER	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 3)
+#define KVM_REG_LOONGARCH_VCPU_RESET	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 4)
+
+struct kvm_debug_exit_arch {
+};
+
+/* for KVM_SET_GUEST_DEBUG */
+struct kvm_guest_debug_arch {
+};
+
+/* definition of registers in kvm_run */
+struct kvm_sync_regs {
+};
+
+/* dummy definition */
+struct kvm_sregs {
+};
+
+struct kvm_iocsr_entry {
+	__u32 addr;
+	__u32 pad;
+	__u64 data;
+};
+
+struct kvm_csr_entry {
+	__u32 index;
+	__u32 reserved;
+	__u64 data;
+};
+
+/* for KVM_GET_CSRS and KVM_SET_CSRS */
+struct kvm_csrs {
+	__u32 ncsrs; /* number of csrs in entries */
+	__u32 pad;
+
+	struct kvm_csr_entry entries[0];
+};
+
+struct kvm_loongarch_interrupt {
+	/* in */
+	__u32 cpu;
+	__u32 irq;
+};
+
+#define KVM_NR_IRQCHIPS		1
+#define KVM_IRQCHIP_NUM_PINS	64
+#define KVM_MAX_CORES		256
+
+#endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
new file mode 100644
index 000000000..c16c7e23e
--- /dev/null
+++ b/arch/loongarch/kvm/main.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_host.h>
+#include <asm/cacheflush.h>
+
+static struct kvm_context __percpu *vmcs;
+
+void kvm_init_vmcs(struct kvm *kvm)
+{
+	kvm->arch.vmcs = vmcs;
+}
+
+long kvm_arch_dev_ioctl(struct file *filp,
+		unsigned int ioctl, unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+
+int kvm_arch_check_processor_compat(void *opaque)
+{
+	return 0;
+}
+
+int kvm_arch_hardware_setup(void *opaque)
+{
+	return 0;
+}
+
+int kvm_arch_hardware_enable(void)
+{
+	unsigned long gcfg = 0;
+
+	/* First init gtlbc, gcfg, gstat, gintc. All guest use the same config */
+	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
+	write_csr_gcfg(0);
+	write_csr_gstat(0);
+	write_csr_gintc(0);
+
+	/*
+	 * Enable virtualization features granting guest direct control of
+	 * certain features:
+	 * GCI=2:       Trap on init or unimplement cache instruction.
+	 * TORU=0:      Trap on Root Unimplement.
+	 * CACTRL=1:    Root control cache.
+	 * TOP=0:       Trap on Previlege.
+	 * TOE=0:       Trap on Exception.
+	 * TIT=0:       Trap on Timer.
+	 */
+	if (cpu_has_gcip_all)
+		gcfg |= CSR_GCFG_GCI_SECURE;
+	if (cpu_has_matc_root)
+		gcfg |= CSR_GCFG_MATC_ROOT;
+
+	gcfg |= CSR_GCFG_TIT;
+	write_csr_gcfg(gcfg);
+
+	kvm_flush_tlb_all();
+
+	/* Enable using TGID  */
+	set_csr_gtlbc(CSR_GTLBC_USETGID);
+	kvm_debug("gtlbc:%llx gintc:%llx gstat:%llx gcfg:%llx",
+		read_csr_gtlbc(), read_csr_gintc(),
+		read_csr_gstat(), read_csr_gcfg());
+
+	return 0;
+}
+
+void kvm_arch_hardware_disable(void)
+{
+	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
+	write_csr_gcfg(0);
+	write_csr_gstat(0);
+	write_csr_gintc(0);
+
+	/* Flush any remaining guest TLB entries */
+	kvm_flush_tlb_all();
+}
+
+int kvm_arch_init(void *opaque)
+{
+	struct kvm_context *context;
+	unsigned long vpid_mask;
+	int cpu, order;
+	void *addr;
+
+	vmcs = alloc_percpu(struct kvm_context);
+	if (!vmcs) {
+		pr_err("kvm: failed to allocate percpu kvm_context\n");
+		return -ENOMEM;
+	}
+
+	order = get_order(kvm_vector_size + kvm_enter_guest_size);
+	addr = (void *)__get_free_pages(GFP_KERNEL, order);
+	if (!addr) {
+		free_percpu(vmcs);
+		return -ENOMEM;
+	}
+
+	memcpy(addr, kvm_vector_entry, kvm_vector_size);
+	memcpy(addr + kvm_vector_size, kvm_enter_guest, kvm_enter_guest_size);
+	flush_icache_range((unsigned long)addr, (unsigned long)addr +
+				kvm_vector_size + kvm_enter_guest_size);
+
+	vpid_mask = read_csr_gstat();
+	vpid_mask = (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_GIDBIT_SHIFT;
+	if (vpid_mask)
+		vpid_mask = GENMASK(vpid_mask - 1, 0);
+
+	for_each_possible_cpu(cpu) {
+		context = per_cpu_ptr(vmcs, cpu);
+		context->vpid_mask = vpid_mask;
+		context->vpid_cache = context->vpid_mask + 1;
+		context->last_vcpu = NULL;
+		context->kvm_eentry = addr;
+		context->kvm_enter_guest = addr + kvm_vector_size;
+		context->page_order = order;
+	}
+
+	_kvm_init_fault();
+
+	return 0;
+}
+
+void kvm_arch_exit(void)
+{
+	struct kvm_context *context = per_cpu_ptr(vmcs, 0);
+
+	free_pages((unsigned long)context->kvm_eentry, context->page_order);
+	free_percpu(vmcs);
+}
+
+static int kvm_loongarch_init(void)
+{
+	if (!cpu_has_lvz)
+		return 0;
+
+	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+}
+
+static void kvm_loongarch_exit(void)
+{
+	kvm_exit();
+}
+
+module_init(kvm_loongarch_init);
+module_exit(kvm_loongarch_exit);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 55155e262..6f3259849 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -264,6 +264,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_RISCV_SBI        35
 #define KVM_EXIT_RISCV_CSR        36
 #define KVM_EXIT_NOTIFY           37
+#define KVM_EXIT_LOONGARCH_IOCSR  38
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -336,6 +337,13 @@ struct kvm_run {
 			__u32 len;
 			__u8  is_write;
 		} mmio;
+		/* KVM_EXIT_LOONGARCH_IOCSR */
+		struct {
+			__u64 phys_addr;
+			__u8  data[8];
+			__u32 len;
+			__u8  is_write;
+		} iocsr_io;
 		/* KVM_EXIT_HYPERCALL */
 		struct {
 			__u64 nr;
@@ -1175,6 +1183,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
 #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
+#define KVM_CAP_LOONGARCH_FPU 226
+#define KVM_CAP_LOONGARCH_LSX 227
+#define KVM_CAP_LOONGARCH_VZ 228
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1345,6 +1356,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_ARM64		0x6000000000000000ULL
 #define KVM_REG_MIPS		0x7000000000000000ULL
 #define KVM_REG_RISCV		0x8000000000000000ULL
+#define KVM_REG_LOONGARCH	0x9000000000000000ULL
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
@@ -1662,6 +1674,9 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
+#define KVM_GET_CSRS		_IOWR(KVMIO, 0xc5, struct kvm_csrs)
+#define KVM_SET_CSRS		_IOW(KVMIO,  0xc6, struct kvm_csrs)
+
 struct kvm_s390_pv_sec_parm {
 	__u64 origin;
 	__u64 length;
-- 
2.31.1

