Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DE662121
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjAIJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbjAIJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:11:50 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7399A17E23
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:08:14 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxrvB82btjgHUAAA--.1723S3;
        Mon, 09 Jan 2023 17:08:12 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxTuRw2btj_6sWAA--.4042S3;
        Mon, 09 Jan 2023 17:08:11 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] LoongArch: Use trampoline for exception handlers and kill la.abs
Date:   Mon,  9 Jan 2023 17:07:51 +0800
Message-Id: <1673255274-18238-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxTuRw2btj_6sWAA--.4042S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GF1rXry3tFWfXFW3CrWDtwb_yoW3WF17pw
        nxAr4DJa10gFn5Za4UKw1UurW5JwnFga1aga17CrWru3W2vF18X34vy397uF9rKay8XF40
        9F1rJw4IvFWUJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Ruoyao <xry111@xry111.site>

Use a trampoline as an exception handlers, which can kill some use of
la.abs in preparation for the subsequent support of the PIE kernel.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h |  8 +++----
 arch/loongarch/include/asm/uaccess.h    |  1 -
 arch/loongarch/kernel/entry.S           |  6 +++---
 arch/loongarch/kernel/genex.S           | 20 +++++++++---------
 arch/loongarch/kernel/head.S            |  2 +-
 arch/loongarch/kernel/traps.c           |  4 +++-
 arch/loongarch/mm/tlbex.S               | 28 +++++++------------------
 7 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca953062b5b..96c94035b5d0 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -76,8 +76,8 @@
  * kernelsp array for it. It stores the current sp in t0 and loads the
  * new value in sp.
  */
-	.macro	get_saved_sp docfi=0
-	la.abs	  t1, kernelsp
+	.macro	  get_saved_sp docfi=0
+	la.pcrel  t1, kernelsp
 #ifdef CONFIG_SMP
 	csrrd	  t0, PERCPU_BASE_KS
 	LONG_ADD  t1, t1, t0
@@ -89,8 +89,8 @@
 	LONG_L	  sp, t1, 0
 	.endm
 
-	.macro	set_saved_sp stackp temp temp2
-	la.abs	  \temp, kernelsp
+	.macro	  set_saved_sp stackp temp temp2
+	la.pcrel  \temp, kernelsp
 #ifdef CONFIG_SMP
 	LONG_ADD  \temp, \temp, u0
 #endif
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index 255899d4a7c3..0d22991ae430 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -22,7 +22,6 @@
 extern u64 __ua_limit;
 
 #define __UA_ADDR	".dword"
-#define __UA_LA		"la.abs"
 #define __UA_LIMIT	__ua_limit
 
 /*
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d53b631c9022..ca01afdbec3f 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -18,9 +18,9 @@
 	.text
 	.cfi_sections	.debug_frame
 	.align	5
-SYM_FUNC_START(handle_syscall)
+SYM_FUNC_START(handle_sys)
 	csrrd	t0, PERCPU_BASE_KS
-	la.abs	t1, kernelsp
+	la.pcrel	t1, kernelsp
 	add.d	t1, t1, t0
 	move	t2, sp
 	ld.d	sp, t1, 0
@@ -66,7 +66,7 @@ SYM_FUNC_START(handle_syscall)
 	bl	do_syscall
 
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_syscall)
+SYM_FUNC_END(handle_sys)
 
 SYM_CODE_START(ret_from_fork)
 	bl	schedule_tail		# a0 = struct task_struct *prev
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 75e5be807a0d..d3df0fa725a2 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -32,9 +32,8 @@ SYM_FUNC_START(__arch_cpu_idle)
 SYM_FUNC_END(__arch_cpu_idle)
 
 SYM_FUNC_START(handle_vint)
-	BACKUP_T0T1
 	SAVE_ALL
-	la.abs	t1, __arch_cpu_idle
+	la.pcrel	t1, __arch_cpu_idle
 	LONG_L	t0, sp, PT_ERA
 	/* 32 byte rollback region */
 	ori	t0, t0, 0x1f
@@ -43,8 +42,7 @@ SYM_FUNC_START(handle_vint)
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
 	move	a1, sp
-	la.abs	t0, do_vint
-	jirl	ra, t0, 0
+	bl	do_vint
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_vint)
 
@@ -67,12 +65,10 @@ SYM_FUNC_END(except_vec_cex)
 	.macro	BUILD_HANDLER exception handler prep
 	.align	5
 	SYM_FUNC_START(handle_\exception)
-	BACKUP_T0T1
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
-	la.abs	t0, do_\handler
-	jirl	ra, t0, 0
+	bl	do_\handler
 	RESTORE_ALL_AND_RET
 	SYM_FUNC_END(handle_\exception)
 	.endm
@@ -89,7 +85,11 @@ SYM_FUNC_END(except_vec_cex)
 	BUILD_HANDLER watch watch none
 	BUILD_HANDLER reserved reserved none	/* others */
 
-SYM_FUNC_START(handle_sys)
-	la.abs	t0, handle_syscall
+SYM_FUNC_START(handler_trampoline)
+	csrwr	t0, EXCEPTION_KS0
+	csrwr	t1, EXCEPTION_KS1
+	pcaddi	t0, 0
+	ld.d	t0, t0, 16
 	jr	t0
-SYM_FUNC_END(handle_sys)
+	nop
+SYM_FUNC_END(handler_trampoline)
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 57bada6b4e93..aa6181714ec3 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -117,7 +117,7 @@ SYM_CODE_START(smpboot_entry)
 	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
 	csrwr		t0, LOONGARCH_CSR_EUEN
 
-	la.abs		t0, cpuboot_data
+	la.pcrel	t0, cpuboot_data
 	ld.d		sp, t0, CPU_BOOT_STACK
 	ld.d		tp, t0, CPU_BOOT_TINFO
 
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 7ea62faeeadb..0e8faaca3679 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -61,6 +61,7 @@ extern asmlinkage void handle_lasx(void);
 extern asmlinkage void handle_reserved(void);
 extern asmlinkage void handle_watch(void);
 extern asmlinkage void handle_vint(void);
+extern asmlinkage void handler_trampoline(void);
 
 static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 			   const char *loglvl, bool user)
@@ -716,7 +717,8 @@ void per_cpu_trap_init(int cpu)
 /* Install CPU exception handler */
 void set_handler(unsigned long offset, void *addr, unsigned long size)
 {
-	memcpy((void *)(eentry + offset), addr, size);
+	memcpy((void *)(eentry + offset), &handler_trampoline, 24);
+	memcpy((void *)(eentry + offset + 24), &addr, 8);
 	local_flush_icache_range(eentry + offset, eentry + offset + size);
 }
 
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 58781c6e4191..cfaacdac518c 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -24,8 +24,7 @@
 	move		a0, sp
 	REG_S		a2, sp, PT_BVADDR
 	li.w		a1, \write
-	la.abs		t0, do_page_fault
-	jirl		ra, t0, 0
+	bl		do_page_fault
 	RESTORE_ALL_AND_RET
 	SYM_FUNC_END(tlb_do_page_fault_\write)
 	.endm
@@ -34,20 +33,16 @@
 	tlb_do_page_fault 1
 
 SYM_FUNC_START(handle_tlb_protect)
-	BACKUP_T0T1
 	SAVE_ALL
 	move		a0, sp
 	move		a1, zero
 	csrrd		a2, LOONGARCH_CSR_BADV
 	REG_S		a2, sp, PT_BVADDR
-	la.abs		t0, do_page_fault
-	jirl		ra, t0, 0
+	bl		do_page_fault
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_tlb_protect)
 
 SYM_FUNC_START(handle_tlb_load)
-	csrwr		t0, EXCEPTION_KS0
-	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
 
 	/*
@@ -116,7 +111,7 @@ smp_pgtable_change_load:
 
 #ifdef CONFIG_64BIT
 vmalloc_load:
-	la.abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_load
 #endif
 
@@ -187,13 +182,10 @@ tlb_huge_update_load:
 nopage_tlb_load:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_0
-	jr		t0
+	b		tlb_do_page_fault_0
 SYM_FUNC_END(handle_tlb_load)
 
 SYM_FUNC_START(handle_tlb_store)
-	csrwr		t0, EXCEPTION_KS0
-	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
 
 	/*
@@ -263,7 +255,7 @@ smp_pgtable_change_store:
 
 #ifdef CONFIG_64BIT
 vmalloc_store:
-	la.abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_store
 #endif
 
@@ -336,13 +328,10 @@ tlb_huge_update_store:
 nopage_tlb_store:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_1
-	jr		t0
+	b		tlb_do_page_fault_1
 SYM_FUNC_END(handle_tlb_store)
 
 SYM_FUNC_START(handle_tlb_modify)
-	csrwr		t0, EXCEPTION_KS0
-	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
 
 	/*
@@ -411,7 +400,7 @@ smp_pgtable_change_modify:
 
 #ifdef CONFIG_64BIT
 vmalloc_modify:
-	la.abs		t1, swapper_pg_dir
+	la.pcrel	t1, swapper_pg_dir
 	b		vmalloc_done_modify
 #endif
 
@@ -483,8 +472,7 @@ tlb_huge_update_modify:
 nopage_tlb_modify:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_1
-	jr		t0
+	b		tlb_do_page_fault_1
 SYM_FUNC_END(handle_tlb_modify)
 
 SYM_FUNC_START(handle_tlb_refill)
-- 
2.37.1

