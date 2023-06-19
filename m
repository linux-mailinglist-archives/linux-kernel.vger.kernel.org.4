Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB4734E07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjFSIfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFSIdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:33:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58B4E66;
        Mon, 19 Jun 2023 01:33:27 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8BxpOjJEpBkZswGAA--.3616S3;
        Mon, 19 Jun 2023 16:33:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC8q3EpBkAgsgAA--.15169S29;
        Mon, 19 Jun 2023 16:33:12 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn,
        tangyouling@loongson.cn
Subject: [PATCH v14 27/30] LoongArch: KVM: Implement vcpu world switch
Date:   Mon, 19 Jun 2023 16:32:52 +0800
Message-Id: <20230619083255.3841777-28-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230619083255.3841777-1-zhaotianrui@loongson.cn>
References: <20230619083255.3841777-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxC8q3EpBkAgsgAA--.15169S29
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement LoongArch vcpu world switch, including vcpu enter guest and
vcpu exit from guest, both operations need to save or restore the host
and guest registers.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kernel/asm-offsets.c |  32 +++
 arch/loongarch/kvm/switch.S         | 301 ++++++++++++++++++++++++++++
 2 files changed, 333 insertions(+)
 create mode 100644 arch/loongarch/kvm/switch.S

diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 4bdb203fc66e..cb6c5a5afea9 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/kbuild.h>
 #include <linux/suspend.h>
+#include <linux/kvm_host.h>
 #include <asm/cpu-info.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -272,3 +273,34 @@ void output_pbe_defines(void)
 	BLANK();
 }
 #endif
+
+static void __used output_kvm_defines(void)
+{
+	COMMENT(" KVM/LOONGARCH Specific offsets. ");
+
+	OFFSET(VCPU_FCSR0, kvm_vcpu_arch, fpu.fcsr);
+	OFFSET(VCPU_FCC, kvm_vcpu_arch, fpu.fcc);
+	BLANK();
+
+	OFFSET(KVM_VCPU_ARCH, kvm_vcpu, arch);
+	OFFSET(KVM_VCPU_KVM, kvm_vcpu, kvm);
+	OFFSET(KVM_VCPU_RUN, kvm_vcpu, run);
+	BLANK();
+
+	OFFSET(KVM_ARCH_HSP, kvm_vcpu_arch, host_sp);
+	OFFSET(KVM_ARCH_HTP, kvm_vcpu_arch, host_tp);
+	OFFSET(KVM_ARCH_HANDLE_EXIT, kvm_vcpu_arch, handle_exit);
+	OFFSET(KVM_ARCH_HPGD, kvm_vcpu_arch, host_pgd);
+	OFFSET(KVM_ARCH_GEENTRY, kvm_vcpu_arch, guest_eentry);
+	OFFSET(KVM_ARCH_GPC, kvm_vcpu_arch, pc);
+	OFFSET(KVM_ARCH_GGPR, kvm_vcpu_arch, gprs);
+	OFFSET(KVM_ARCH_HESTAT, kvm_vcpu_arch, host_estat);
+	OFFSET(KVM_ARCH_HBADV, kvm_vcpu_arch, badv);
+	OFFSET(KVM_ARCH_HBADI, kvm_vcpu_arch, badi);
+	OFFSET(KVM_ARCH_HECFG, kvm_vcpu_arch, host_ecfg);
+	OFFSET(KVM_ARCH_HEENTRY, kvm_vcpu_arch, host_eentry);
+	OFFSET(KVM_ARCH_HPERCPU, kvm_vcpu_arch, host_percpu);
+
+	OFFSET(KVM_GPGD, kvm, arch.gpa_mm.pgd);
+	BLANK();
+}
diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
new file mode 100644
index 000000000000..f9f6e0707cd7
--- /dev/null
+++ b/arch/loongarch/kvm/switch.S
@@ -0,0 +1,301 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/linkage.h>
+#include <asm/stackframe.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+#include <asm/loongarch.h>
+#include <asm/export.h>
+
+#define PT_GPR_OFFSET(x)	(PT_R0 + 8*x)
+	.text
+
+.macro kvm_save_host_gpr base
+	.irp n,1,2,3,22,23,24,25,26,27,28,29,30,31
+	st.d	$r\n, \base, PT_GPR_OFFSET(\n)
+	.endr
+.endm
+
+.macro kvm_restore_host_gpr base
+	.irp n,1,2,3,22,23,24,25,26,27,28,29,30,31
+	ld.d	$r\n, \base, PT_GPR_OFFSET(\n)
+	.endr
+.endm
+
+/*
+ * prepare switch to guest, save host reg and restore guest reg.
+ * a2: kvm_vcpu_arch, don't touch it until 'ertn'
+ * t0, t1: temp register
+ */
+.macro kvm_switch_to_guest
+	/* set host excfg.VS=0, all exceptions share one exception entry */
+	csrrd		t0, LOONGARCH_CSR_ECFG
+	bstrins.w	t0, zero, CSR_ECFG_VS_SHIFT_END, CSR_ECFG_VS_SHIFT
+	csrwr		t0, LOONGARCH_CSR_ECFG
+
+	/* Load up the new EENTRY */
+	ld.d	t0, a2, KVM_ARCH_GEENTRY
+	csrwr	t0, LOONGARCH_CSR_EENTRY
+
+	/* Set Guest ERA */
+	ld.d	t0, a2, KVM_ARCH_GPC
+	csrwr	t0, LOONGARCH_CSR_ERA
+
+	/* Save host PGDL */
+	csrrd	t0, LOONGARCH_CSR_PGDL
+	st.d	t0, a2, KVM_ARCH_HPGD
+
+	/* Switch to kvm */
+	ld.d	t1, a2, KVM_VCPU_KVM - KVM_VCPU_ARCH
+
+	/* Load guest PGDL */
+	lu12i.w t0, KVM_GPGD
+	srli.w  t0, t0, 12
+	ldx.d   t0, t1, t0
+	csrwr	t0, LOONGARCH_CSR_PGDL
+
+	/* Mix GID and RID */
+	csrrd		t1, LOONGARCH_CSR_GSTAT
+	bstrpick.w	t1, t1, CSR_GSTAT_GID_SHIFT_END, CSR_GSTAT_GID_SHIFT
+	csrrd		t0, LOONGARCH_CSR_GTLBC
+	bstrins.w	t0, t1, CSR_GTLBC_TGID_SHIFT_END, CSR_GTLBC_TGID_SHIFT
+	csrwr		t0, LOONGARCH_CSR_GTLBC
+
+	/*
+	 * Switch to guest:
+	 *  GSTAT.PGM = 1, ERRCTL.ISERR = 0, TLBRPRMD.ISTLBR = 0
+	 *  ertn
+	 */
+
+	/*
+	 * Enable intr in root mode with future ertn so that host interrupt
+	 * can be responsed during VM runs
+	 * guest crmd comes from separate gcsr_CRMD register
+	 */
+	ori	t0, zero, CSR_PRMD_PIE
+	csrxchg	t0, t0,   LOONGARCH_CSR_PRMD
+
+	/* Set PVM bit to setup ertn to guest context */
+	ori	t0, zero, CSR_GSTAT_PVM
+	csrxchg	t0, t0,   LOONGARCH_CSR_GSTAT
+
+	/* Load Guest gprs */
+	ld.d	ra,	a2,	(KVM_ARCH_GGPR + 8 * REG_RA)
+	ld.d	tp,	a2,	(KVM_ARCH_GGPR + 8 * REG_TP)
+	ld.d	sp,	a2,	(KVM_ARCH_GGPR + 8 * REG_SP)
+	ld.d	a0,	a2,	(KVM_ARCH_GGPR + 8 * REG_A0)
+	ld.d	a1,	a2,	(KVM_ARCH_GGPR + 8 * REG_A1)
+	ld.d	a3,	a2,	(KVM_ARCH_GGPR + 8 * REG_A3)
+	ld.d	a4,	a2,	(KVM_ARCH_GGPR + 8 * REG_A4)
+	ld.d	a5,	a2,	(KVM_ARCH_GGPR + 8 * REG_A5)
+	ld.d	a6,	a2,	(KVM_ARCH_GGPR + 8 * REG_A6)
+	ld.d	a7,	a2,	(KVM_ARCH_GGPR + 8 * REG_A7)
+	ld.d	t0,	a2,	(KVM_ARCH_GGPR + 8 * REG_T0)
+	ld.d	t1,	a2,	(KVM_ARCH_GGPR + 8 * REG_T1)
+	ld.d	t2,	a2,	(KVM_ARCH_GGPR + 8 * REG_T2)
+	ld.d	t3,	a2,	(KVM_ARCH_GGPR + 8 * REG_T3)
+	ld.d	t4,	a2,	(KVM_ARCH_GGPR + 8 * REG_T4)
+	ld.d	t5,	a2,	(KVM_ARCH_GGPR + 8 * REG_T5)
+	ld.d	t6,	a2,	(KVM_ARCH_GGPR + 8 * REG_T6)
+	ld.d	t7,	a2,	(KVM_ARCH_GGPR + 8 * REG_T7)
+	ld.d	t8,	a2,	(KVM_ARCH_GGPR + 8 * REG_T8)
+	ld.d	u0,	a2,	(KVM_ARCH_GGPR + 8 * REG_U0)
+	ld.d	fp,	a2,	(KVM_ARCH_GGPR + 8 * REG_FP)
+	ld.d	s0,	a2,	(KVM_ARCH_GGPR + 8 * REG_S0)
+	ld.d	s1,	a2,	(KVM_ARCH_GGPR + 8 * REG_S1)
+	ld.d	s2,	a2,	(KVM_ARCH_GGPR + 8 * REG_S2)
+	ld.d	s3,	a2,	(KVM_ARCH_GGPR + 8 * REG_S3)
+	ld.d	s4,	a2,	(KVM_ARCH_GGPR + 8 * REG_S4)
+	ld.d	s5,	a2,	(KVM_ARCH_GGPR + 8 * REG_S5)
+	ld.d	s6,	a2,	(KVM_ARCH_GGPR + 8 * REG_S6)
+	ld.d	s7,	a2,	(KVM_ARCH_GGPR + 8 * REG_S7)
+	ld.d	s8,	a2,	(KVM_ARCH_GGPR + 8 * REG_S8)
+	/* Load KVM_ARCH register */
+	ld.d	a2,	a2,	(KVM_ARCH_GGPR + 8 * REG_A2)
+
+	ertn
+.endm
+
+	/*
+	 * exception entry for general exception from guest mode
+	 *  - IRQ is disabled
+	 *  - kernel privilege in root mode
+	 *  - page mode keep unchanged from previous prmd in root mode
+	 *  - Fixme: tlb exception cannot happen since registers relative with TLB
+	 *  -        is still in guest mode, such as pgd table/vmid registers etc,
+	 *  -        will fix with hw page walk enabled in future
+	 * load kvm_vcpu from reserved CSR KVM_VCPU_KS, and save a2 to KVM_TEMP_KS
+	 */
+	.section	.text
+	.cfi_sections	.debug_frame
+SYM_CODE_START(kvm_vector_entry)
+	csrwr	a2,   KVM_TEMP_KS
+	csrrd	a2,   KVM_VCPU_KS
+	addi.d	a2,   a2, KVM_VCPU_ARCH
+
+	/* After save gprs, free to use any gpr */
+	st.d	ra,	a2,	(KVM_ARCH_GGPR + 8 * REG_RA)
+	st.d	tp,	a2,	(KVM_ARCH_GGPR + 8 * REG_TP)
+	st.d	sp,	a2,	(KVM_ARCH_GGPR + 8 * REG_SP)
+	st.d	a0,	a2,	(KVM_ARCH_GGPR + 8 * REG_A0)
+	st.d	a1,	a2,	(KVM_ARCH_GGPR + 8 * REG_A1)
+	st.d	a3,	a2,	(KVM_ARCH_GGPR + 8 * REG_A3)
+	st.d	a4,	a2,	(KVM_ARCH_GGPR + 8 * REG_A4)
+	st.d	a5,	a2,	(KVM_ARCH_GGPR + 8 * REG_A5)
+	st.d	a6,	a2,	(KVM_ARCH_GGPR + 8 * REG_A6)
+	st.d	a7,	a2,	(KVM_ARCH_GGPR + 8 * REG_A7)
+	st.d	t0,	a2,	(KVM_ARCH_GGPR + 8 * REG_T0)
+	st.d	t1,	a2,	(KVM_ARCH_GGPR + 8 * REG_T1)
+	st.d	t2,	a2,	(KVM_ARCH_GGPR + 8 * REG_T2)
+	st.d	t3,	a2,	(KVM_ARCH_GGPR + 8 * REG_T3)
+	st.d	t4,	a2,	(KVM_ARCH_GGPR + 8 * REG_T4)
+	st.d	t5,	a2,	(KVM_ARCH_GGPR + 8 * REG_T5)
+	st.d	t6,	a2,	(KVM_ARCH_GGPR + 8 * REG_T6)
+	st.d	t7,	a2,	(KVM_ARCH_GGPR + 8 * REG_T7)
+	st.d	t8,	a2,	(KVM_ARCH_GGPR + 8 * REG_T8)
+	st.d	u0,	a2,	(KVM_ARCH_GGPR + 8 * REG_U0)
+	st.d	fp,	a2,	(KVM_ARCH_GGPR + 8 * REG_FP)
+	st.d	s0,	a2,	(KVM_ARCH_GGPR + 8 * REG_S0)
+	st.d	s1,	a2,	(KVM_ARCH_GGPR + 8 * REG_S1)
+	st.d	s2,	a2,	(KVM_ARCH_GGPR + 8 * REG_S2)
+	st.d	s3,	a2,	(KVM_ARCH_GGPR + 8 * REG_S3)
+	st.d	s4,	a2,	(KVM_ARCH_GGPR + 8 * REG_S4)
+	st.d	s5,	a2,	(KVM_ARCH_GGPR + 8 * REG_S5)
+	st.d	s6,	a2,	(KVM_ARCH_GGPR + 8 * REG_S6)
+	st.d	s7,	a2,	(KVM_ARCH_GGPR + 8 * REG_S7)
+	st.d	s8,	a2,	(KVM_ARCH_GGPR + 8 * REG_S8)
+	/* Save guest a2 */
+	csrrd	t0,	KVM_TEMP_KS
+	st.d	t0,	a2,	(KVM_ARCH_GGPR + 8 * REG_A2)
+
+	/* a2: kvm_vcpu_arch, a1 is free to use */
+	csrrd	s1,   KVM_VCPU_KS
+	ld.d	s0,   s1, KVM_VCPU_RUN
+
+	csrrd	t0,   LOONGARCH_CSR_ESTAT
+	st.d	t0,   a2, KVM_ARCH_HESTAT
+	csrrd	t0,   LOONGARCH_CSR_ERA
+	st.d	t0,   a2, KVM_ARCH_GPC
+	csrrd	t0,   LOONGARCH_CSR_BADV
+	st.d	t0,   a2, KVM_ARCH_HBADV
+	csrrd	t0,   LOONGARCH_CSR_BADI
+	st.d	t0,   a2, KVM_ARCH_HBADI
+
+	/* Restore host excfg.VS */
+	csrrd	t0, LOONGARCH_CSR_ECFG
+	ld.d	t1, a2, KVM_ARCH_HECFG
+	or	t0, t0, t1
+	csrwr	t0, LOONGARCH_CSR_ECFG
+
+	/* Restore host eentry */
+	ld.d	t0, a2, KVM_ARCH_HEENTRY
+	csrwr	t0, LOONGARCH_CSR_EENTRY
+
+	/* restore host pgd table */
+	ld.d    t0, a2, KVM_ARCH_HPGD
+	csrwr   t0, LOONGARCH_CSR_PGDL
+
+	/*
+	 * Disable PGM bit to enter root mode by default with next ertn
+	 */
+	ori	t0, zero, CSR_GSTAT_PVM
+	csrxchg	zero, t0, LOONGARCH_CSR_GSTAT
+	/*
+	 * Clear GTLBC.TGID field
+	 *       0: for root  tlb update in future tlb instr
+	 *  others: for guest tlb update like gpa to hpa in future tlb instr
+	 */
+	csrrd	t0, LOONGARCH_CSR_GTLBC
+	bstrins.w	t0, zero, CSR_GTLBC_TGID_SHIFT_END, CSR_GTLBC_TGID_SHIFT
+	csrwr	t0, LOONGARCH_CSR_GTLBC
+	ld.d	tp, a2, KVM_ARCH_HTP
+	ld.d	sp, a2, KVM_ARCH_HSP
+	/* restore per cpu register */
+	ld.d	u0, a2, KVM_ARCH_HPERCPU
+	addi.d	sp, sp, -PT_SIZE
+
+	/* Prepare handle exception */
+	or	a0, s0, zero
+	or	a1, s1, zero
+	ld.d	t8, a2, KVM_ARCH_HANDLE_EXIT
+	jirl	ra, t8, 0
+
+	or	a2, s1, zero
+	addi.d	a2, a2, KVM_VCPU_ARCH
+
+	/* resume host when ret <= 0 */
+	bge	zero, a0, ret_to_host
+
+	/*
+         * return to guest
+         * save per cpu register again, maybe switched to another cpu
+         */
+	st.d	u0, a2, KVM_ARCH_HPERCPU
+
+	/* Save kvm_vcpu to kscratch */
+	csrwr	s1, KVM_VCPU_KS
+	kvm_switch_to_guest
+
+ret_to_host:
+	ld.d    a2, a2, KVM_ARCH_HSP
+	addi.d  a2, a2, -PT_SIZE
+	kvm_restore_host_gpr    a2
+	jr      ra
+SYM_CODE_END(kvm_vector_entry)
+kvm_vector_entry_end:
+
+/*
+ * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu)
+ *
+ * @register_param:
+ *  a0: kvm_run* run
+ *  a1: kvm_vcpu* vcpu
+ */
+SYM_FUNC_START(kvm_enter_guest)
+	/* allocate space in stack bottom */
+	addi.d	a2, sp, -PT_SIZE
+	/* save host gprs */
+	kvm_save_host_gpr a2
+
+	/* save host crmd,prmd csr to stack */
+	csrrd	a3, LOONGARCH_CSR_CRMD
+	st.d	a3, a2, PT_CRMD
+	csrrd	a3, LOONGARCH_CSR_PRMD
+	st.d	a3, a2, PT_PRMD
+
+	addi.d	a2, a1, KVM_VCPU_ARCH
+	st.d	sp, a2, KVM_ARCH_HSP
+	st.d	tp, a2, KVM_ARCH_HTP
+	/* Save per cpu register */
+	st.d	u0, a2, KVM_ARCH_HPERCPU
+
+	/* Save kvm_vcpu to kscratch */
+	csrwr	a1, KVM_VCPU_KS
+	kvm_switch_to_guest
+SYM_FUNC_END(kvm_enter_guest)
+kvm_enter_guest_end:
+
+	.section ".rodata"
+SYM_DATA(kvm_vector_size,
+		.quad kvm_vector_entry_end - kvm_vector_entry)
+SYM_DATA(kvm_enter_guest_size,
+		.quad kvm_enter_guest_end - kvm_enter_guest)
+
+
+SYM_FUNC_START(kvm_save_fpu)
+	fpu_save_csr	a0 t1
+	fpu_save_double a0 t1
+	fpu_save_cc	a0 t1 t2
+	jr              ra
+SYM_FUNC_END(kvm_save_fpu)
+
+SYM_FUNC_START(kvm_restore_fpu)
+	fpu_restore_double a0 t1
+	fpu_restore_csr    a0 t1
+	fpu_restore_cc	   a0 t1 t2
+	jr                 ra
+SYM_FUNC_END(kvm_restore_fpu)
-- 
2.39.1

