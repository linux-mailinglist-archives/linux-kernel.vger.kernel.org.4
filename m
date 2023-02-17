Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75D169A613
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBQH07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBQH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:26:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D3B885F5B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:42 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJ_AyLO9jOq4BAA--.4179S3;
        Fri, 17 Feb 2023 15:26:42 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+QmLO9jiSQ1AA--.63745S5;
        Fri, 17 Feb 2023 15:26:41 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] LoongArch: Add la_abs macro implementation
Date:   Fri, 17 Feb 2023 15:26:27 +0800
Message-Id: <1676618789-20485-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
References: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Cxf+QmLO9jiSQ1AA--.63745S5
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw1xAF18Xr4xWFWktw1DZFb_yoWrXw48pw
        n8Zr1kJF40gryfZFyDKwnrurW5Jw1qgrW2ganrCrZ5u3ZrXF1jqryvyrWvvF97Ga97XF40
        gFn3Xw4vvayUtwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b2xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7eT5DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "la_abs macro" instead of the "la.abs pseudo instruction" to prepare
for the subsequent PIE kernel. When PIE is not enabled, la_abs is equivalent
to la.abs.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/asmmacro.h   |  4 ++++
 arch/loongarch/include/asm/stackframe.h |  2 +-
 arch/loongarch/kernel/genex.S           |  8 ++++----
 arch/loongarch/mm/tlbex.S               | 14 +++++++-------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index 328bb956f241..adc92464afa6 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -667,4 +667,8 @@
 	nor	\dst, \src, zero
 .endm
 
+.macro la_abs reg, sym
+	la.abs \reg, \sym
+.endm
+
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 855c9d9e3210..3e1cf97f56e6 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -78,7 +78,7 @@
  * new value in sp.
  */
 	.macro	get_saved_sp docfi=0
-	la.abs	  t1, kernelsp
+	la_abs	  t1, kernelsp
 #ifdef CONFIG_SMP
 	csrrd	  t0, PERCPU_BASE_KS
 	LONG_ADD  t1, t1, t0
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 7e5c293ed89f..44ff1ff64260 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -34,7 +34,7 @@ SYM_FUNC_END(__arch_cpu_idle)
 SYM_FUNC_START(handle_vint)
 	BACKUP_T0T1
 	SAVE_ALL
-	la.abs	t1, __arch_cpu_idle
+	la_abs	t1, __arch_cpu_idle
 	LONG_L	t0, sp, PT_ERA
 	/* 32 byte rollback region */
 	ori	t0, t0, 0x1f
@@ -43,7 +43,7 @@ SYM_FUNC_START(handle_vint)
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
 	move	a1, sp
-	la.abs	t0, do_vint
+	la_abs	t0, do_vint
 	jirl	ra, t0, 0
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_vint)
@@ -72,7 +72,7 @@ SYM_FUNC_END(except_vec_cex)
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
-	la.abs	t0, do_\handler
+	la_abs	t0, do_\handler
 	jirl	ra, t0, 0
 	668:
 	RESTORE_ALL_AND_RET
@@ -93,6 +93,6 @@ SYM_FUNC_END(except_vec_cex)
 	BUILD_HANDLER reserved reserved none	/* others */
 
 SYM_FUNC_START(handle_sys)
-	la.abs	t0, handle_syscall
+	la_abs	t0, handle_syscall
 	jr	t0
 SYM_FUNC_END(handle_sys)
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 3dd2a9615cd9..244e2f5aeee5 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -39,7 +39,7 @@ SYM_FUNC_START(handle_tlb_protect)
 	move		a1, zero
 	csrrd		a2, LOONGARCH_CSR_BADV
 	REG_S		a2, sp, PT_BVADDR
-	la.abs		t0, do_page_fault
+	la_abs		t0, do_page_fault
 	jirl		ra, t0, 0
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_tlb_protect)
@@ -115,7 +115,7 @@ smp_pgtable_change_load:
 
 #ifdef CONFIG_64BIT
 vmalloc_load:
-	la.abs		t1, swapper_pg_dir
+	la_abs		t1, swapper_pg_dir
 	b		vmalloc_done_load
 #endif
 
@@ -186,7 +186,7 @@ tlb_huge_update_load:
 nopage_tlb_load:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_0
+	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
 SYM_FUNC_END(handle_tlb_load)
 
@@ -262,7 +262,7 @@ smp_pgtable_change_store:
 
 #ifdef CONFIG_64BIT
 vmalloc_store:
-	la.abs		t1, swapper_pg_dir
+	la_abs		t1, swapper_pg_dir
 	b		vmalloc_done_store
 #endif
 
@@ -335,7 +335,7 @@ tlb_huge_update_store:
 nopage_tlb_store:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_1
+	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_store)
 
@@ -410,7 +410,7 @@ smp_pgtable_change_modify:
 
 #ifdef CONFIG_64BIT
 vmalloc_modify:
-	la.abs		t1, swapper_pg_dir
+	la_abs		t1, swapper_pg_dir
 	b		vmalloc_done_modify
 #endif
 
@@ -482,7 +482,7 @@ tlb_huge_update_modify:
 nopage_tlb_modify:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_1
+	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_modify)
 
-- 
2.37.3

