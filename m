Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CC6114A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJ1OfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJ1Oer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:34:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF11741D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:34:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEC5wW037454;
        Fri, 28 Oct 2022 14:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0jDdH7cLRC+O+hE2k8x8vzh09W07pgMUg78vKZTz8QY=;
 b=mWDv9GFUFzhxo7XmuOmXAH6CbtulVmmEhrEES0VG75WHUG2L2iPVnHF9Gg6lgT+tWkuW
 z3uCnPcwPRlrtpjWDynDoWdhkb3tge3zpap4xWtZ1MoCR5UnRVMr2y3DPkR8Detpfwm5
 cBeJ3RW11HGRBZEZG4wUpCm9jFmp+k4LQdoM783roOez0XfxKWZfHwJQaSKJH89ADV8K
 lbP/3fByrtytgp5h7coq2SvOZzKdKXUufGs9rJbkEXQsYde2O9LhJSuA/kc7RrWXvIzZ
 08Z5miAV4Bahya55ThswERjHwUKM+LEyal9tgR4cBT7KN/N8mPpktndnT46PfhJXBvl3 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kggmqgtu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:34:27 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SECQsu038584;
        Fri, 28 Oct 2022 14:34:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kggmqgtr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:34:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SEL9QG026481;
        Fri, 28 Oct 2022 14:34:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3kfahu3wwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:34:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SEYLcU25493954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:34:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D61DA404D;
        Fri, 28 Oct 2022 14:34:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 882BCA4040;
        Fri, 28 Oct 2022 14:34:17 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.124.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 14:34:17 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v5 03/16] powerpc: Fix objtool unannotated intra-function call warnings
Date:   Fri, 28 Oct 2022 20:03:33 +0530
Message-Id: <20221028143346.183569-4-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028143346.183569-1-sv@linux.ibm.com>
References: <20221028143346.183569-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DL3JH237_zCIWkZ5zxXBpyA3qsYQquC9
X-Proofpoint-GUID: dR0hZLzn8eLIaISDxRJkomXQ56qwLUks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool throws unannotated intra-function call warnings in the following
assembly files:

arch/powerpc/kernel/vector.o: warning: objtool: .text+0x53c: unannotated intra-function call

arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x60: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x124: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x5d4: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x5dc: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xcb8: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xd0c: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x1030: unannotated intra-function call

arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x358: unannotated intra-function call
arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x728: unannotated intra-function call
arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x4d94: unannotated intra-function call
arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x4ec4: unannotated intra-function call

arch/powerpc/kvm/book3s_hv_interrupts.o: warning: objtool: .text+0x6c: unannotated intra-function call
arch/powerpc/kernel/misc_64.o: warning: objtool: .text+0x64: unannotated intra-function call

Objtool does not add STT_NOTYPE symbols with size 0 to the rbtree, which
is why find_call_destination() function is not able to find the
destination symbol for 'bl' instruction. For such symbols, objtool is
throwing unannotated intra-function call warnings in assembly files. Fix
these warnings by annotating those symbols with SYM_FUNC_START_LOCAL and
SYM_FUNC_END macros, inorder to set symbol type to STT_FUNC and symbol
size accordingly.

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S    |  4 +++-
 arch/powerpc/kernel/head_64.S           |  7 +++++--
 arch/powerpc/kernel/misc_64.S           |  4 +++-
 arch/powerpc/kernel/vector.S            |  4 +++-
 arch/powerpc/kvm/book3s_hv_interrupts.S |  4 +++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 22 +++++++++++++++-------
 6 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5381a43e50fe..77201ad9f329 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/linkage.h>
 #include <asm/hw_irq.h>
 #include <asm/exception-64s.h>
 #include <asm/ptrace.h>
@@ -3112,7 +3113,7 @@ _GLOBAL(enable_machine_check)
 	blr
 
 /* MSR[RI] should be clear because this uses SRR[01] */
-disable_machine_check:
+SYM_FUNC_START_LOCAL(disable_machine_check)
 	mflr	r0
 	bcl	20,31,$+4
 0:	mflr	r3
@@ -3125,3 +3126,4 @@ disable_machine_check:
 	RFI_TO_KERNEL
 1:	mtlr	r0
 	blr
+SYM_FUNC_END(disable_machine_check)
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index dedcc6fe2263..874efd25cc45 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -18,6 +18,7 @@
  *  variants.
  */
 
+#include <linux/linkage.h>
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <asm/reg.h>
@@ -462,7 +463,7 @@ generic_secondary_common_init:
  * Assumes we're mapped EA == RA if the MMU is on.
  */
 #ifdef CONFIG_PPC_BOOK3S
-__mmu_off:
+SYM_FUNC_START_LOCAL(__mmu_off)
 	mfmsr	r3
 	andi.	r0,r3,MSR_IR|MSR_DR
 	beqlr
@@ -473,6 +474,7 @@ __mmu_off:
 	sync
 	rfid
 	b	.	/* prevent speculative execution */
+SYM_FUNC_END(__mmu_off)
 #endif
 
 
@@ -869,7 +871,7 @@ _GLOBAL(start_secondary_resume)
 /*
  * This subroutine clobbers r11 and r12
  */
-enable_64b_mode:
+SYM_FUNC_START_LOCAL(enable_64b_mode)
 	mfmsr	r11			/* grab the current MSR */
 #ifdef CONFIG_PPC_BOOK3E_64
 	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
@@ -881,6 +883,7 @@ enable_64b_mode:
 	isync
 #endif
 	blr
+SYM_FUNC_END(enable_64b_mode)
 
 /*
  * This puts the TOC pointer into r2, offset by 0x8000 (as expected
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 36184cada00b..c61a7ba446a8 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -9,6 +9,7 @@
  * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
  */
 
+#include <linux/linkage.h>
 #include <linux/sys.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
@@ -353,7 +354,7 @@ _GLOBAL(kexec_smp_wait)
  *
  * don't overwrite r3 here, it is live for kexec_wait above.
  */
-real_mode:	/* assume normal blr return */
+SYM_FUNC_START_LOCAL(real_mode)	/* assume normal blr return */
 #ifdef CONFIG_PPC_BOOK3E_64
 	/* Create an identity mapping. */
 	b	kexec_create_tlb
@@ -370,6 +371,7 @@ real_mode:	/* assume normal blr return */
 	mtspr	SPRN_SRR0,r11
 	rfid
 #endif
+SYM_FUNC_END(real_mode)
 
 /*
  * kexec_sequence(newstack, start, image, control, clear_all(),
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 5cf64740edb8..ffe5d90abe17 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/reg.h>
@@ -185,7 +186,7 @@ fphalf:
  * Internal routine to enable floating point and set FPSCR to 0.
  * Don't call it from C; it doesn't use the normal calling convention.
  */
-fpenable:
+SYM_FUNC_START_LOCAL(fpenable)
 #ifdef CONFIG_PPC32
 	stwu	r1,-64(r1)
 #else
@@ -202,6 +203,7 @@ fpenable:
 	mffs	fr31
 	MTFSF_L(fr1)
 	blr
+SYM_FUNC_END(fpenable)
 
 fpdisable:
 	mtlr	r12
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 59d89e4b154a..c0deeea7eef3 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -9,6 +9,7 @@
  * Authors: Alexander Graf <agraf@suse.de>
  */
 
+#include <linux/linkage.h>
 #include <asm/ppc_asm.h>
 #include <asm/kvm_asm.h>
 #include <asm/reg.h>
@@ -107,7 +108,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 /*
  * void kvmhv_save_host_pmu(void)
  */
-kvmhv_save_host_pmu:
+SYM_FUNC_START_LOCAL(kvmhv_save_host_pmu)
 BEGIN_FTR_SECTION
 	/* Work around P8 PMAE bug */
 	li	r3, -1
@@ -154,3 +155,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	stw	r8, HSTATE_PMC5(r13)
 	stw	r9, HSTATE_PMC6(r13)
 31:	blr
+SYM_FUNC_END(kvmhv_save_host_pmu)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 37f50861dd98..a69d36cbf43b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -10,6 +10,7 @@
  * Authors: Alexander Graf <agraf@suse.de>
  */
 
+#include <linux/linkage.h>
 #include <asm/ppc_asm.h>
 #include <asm/code-patching-asm.h>
 #include <asm/kvm_asm.h>
@@ -2358,7 +2359,7 @@ hmi_realmode:
  * This routine calls kvmppc_read_intr, a C function, if an external
  * interrupt is pending.
  */
-kvmppc_check_wake_reason:
+SYM_FUNC_START_LOCAL(kvmppc_check_wake_reason)
 	mfspr	r6, SPRN_SRR1
 BEGIN_FTR_SECTION
 	rlwinm	r6, r6, 45-31, 0xf	/* extract wake reason field (P8) */
@@ -2427,6 +2428,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	addi	r1, r1, PPC_MIN_STKFRM
 	mtlr	r0
 	blr
+SYM_FUNC_END(kvmppc_check_wake_reason)
 
 /*
  * Save away FP, VMX and VSX registers.
@@ -2434,7 +2436,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
  * N.B. r30 and r31 are volatile across this function,
  * thus it is not callable from C.
  */
-kvmppc_save_fp:
+SYM_FUNC_START_LOCAL(kvmppc_save_fp)
 	mflr	r30
 	mr	r31,r3
 	mfmsr	r5
@@ -2462,6 +2464,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	stw	r6,VCPU_VRSAVE(r31)
 	mtlr	r30
 	blr
+SYM_FUNC_END(kvmppc_save_fp)
 
 /*
  * Load up FP, VMX and VSX registers
@@ -2469,7 +2472,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
  * N.B. r30 and r31 are volatile across this function,
  * thus it is not callable from C.
  */
-kvmppc_load_fp:
+SYM_FUNC_START_LOCAL(kvmppc_load_fp)
 	mflr	r30
 	mr	r31,r4
 	mfmsr	r9
@@ -2498,6 +2501,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	mtlr	r30
 	mr	r4,r31
 	blr
+SYM_FUNC_END(kvmppc_load_fp)
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 /*
@@ -2746,7 +2750,7 @@ kvmppc_bad_host_intr:
  *   r9 has a vcpu pointer (in)
  *   r0 is used as a scratch register
  */
-kvmppc_msr_interrupt:
+SYM_FUNC_START_LOCAL(kvmppc_msr_interrupt)
 	rldicl	r0, r11, 64 - MSR_TS_S_LG, 62
 	cmpwi	r0, 2 /* Check if we are in transactional state..  */
 	ld	r11, VCPU_INTR_MSR(r9)
@@ -2755,13 +2759,14 @@ kvmppc_msr_interrupt:
 	li	r0, 1
 1:	rldimi	r11, r0, MSR_TS_S_LG, 63 - MSR_TS_T_LG
 	blr
+SYM_FUNC_END(kvmppc_msr_interrupt)
 
 /*
  * void kvmhv_load_guest_pmu(struct kvm_vcpu *vcpu)
  *
  * Load up guest PMU state.  R3 points to the vcpu struct.
  */
-kvmhv_load_guest_pmu:
+SYM_FUNC_START_LOCAL(kvmhv_load_guest_pmu)
 	mr	r4, r3
 	mflr	r0
 	li	r3, 1
@@ -2811,13 +2816,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	isync
 	mtlr	r0
 	blr
+SYM_FUNC_END(kvmhv_load_guest_pmu)
 
 /*
  * void kvmhv_load_host_pmu(void)
  *
  * Reload host PMU state saved in the PACA by kvmhv_save_host_pmu.
  */
-kvmhv_load_host_pmu:
+SYM_FUNC_START_LOCAL(kvmhv_load_host_pmu)
 	mflr	r0
 	lbz	r4, PACA_PMCINUSE(r13) /* is the host using the PMU? */
 	cmpwi	r4, 0
@@ -2859,6 +2865,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	isync
 	mtlr	r0
 23:	blr
+SYM_FUNC_END(kvmhv_load_host_pmu)
 
 /*
  * void kvmhv_save_guest_pmu(struct kvm_vcpu *vcpu, bool pmu_in_use)
@@ -2866,7 +2873,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
  * Save guest PMU state into the vcpu struct.
  * r3 = vcpu, r4 = full save flag (PMU in use flag set in VPA)
  */
-kvmhv_save_guest_pmu:
+SYM_FUNC_START_LOCAL(kvmhv_save_guest_pmu)
 	mr	r9, r3
 	mr	r8, r4
 BEGIN_FTR_SECTION
@@ -2942,6 +2949,7 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_MMCRS, r4
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 22:	blr
+SYM_FUNC_END(kvmhv_save_guest_pmu)
 
 /*
  * This works around a hardware bug on POWER8E processors, where
-- 
2.31.1

