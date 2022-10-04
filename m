Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA85F450A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJDOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDOCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:02:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF3855D0F4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:02:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [112.22.233.62])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxnmv6PDxjsOQlAA--.60093S2;
        Tue, 04 Oct 2022 22:02:39 +0800 (CST)
From:   Rui Wang <wangrui@loongson.cn>
To:     loongarch@lists.linux.dev
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        Rui Wang <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: mm: Refactor TLB handlers
Date:   Tue,  4 Oct 2022 22:02:30 +0800
Message-Id: <20221004140230.748788-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxnmv6PDxjsOQlAA--.60093S2
X-Coremail-Antispam: 1UD129KBjvAXoW3KFyrJFWkZF1xGryruF1ftFb_yoW8Jr1DCo
        W8WF4UJ3Z7Ww1rurn8Za17AanrGF10y3saq34jyr1Fga4F93s8K3yDJa1j9FZ09r109F18
        Zay7GFn5Zr47AFykn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYY7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWU
        JVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUe_M3DUUUU
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies TLB load, store and modify exception handlers:

1. Reduce instructions. such as alu/csr and memory access
2. Execute tlbsrch only in the fast path.
3. Return directly from the fast path for huge pages.

And fixes the concurrent modification issue of fast path for huge pages.
This issue will occur in the following steps:

   CPU-1 (In TLB exception)         CPU-2 (In THP)
1: Load PMD entry (HUGE=1)
2: Goto huge path
3:                                  Store PMD entry (HUGE=0)
4: Reload PMD entry (HUGE=0)
5: Fill TLB entry (PA is incorrect)

This also slightly improves the TLB processing performance:

* Normal pages: 2.15%
* Huge pages:   1.70%

  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <sys/mman.h>

  int main(int argc, char *argv[])
  {
        size_t page_size;
        size_t mem_size;
        size_t off;
        void *base;
        int flags;
        int i;

        if (argc < 2) {
                fprintf(stderr, "%s MEM_SIZE [HUGE]\n", argv[0]);
                return -1;
        }

        page_size = sysconf(_SC_PAGESIZE);
        flags = MAP_PRIVATE | MAP_ANONYMOUS;
        mem_size = strtoul(argv[1], NULL, 10);
        if (argc > 2)
                flags |= MAP_HUGETLB;

        for (i = 0; i < 10; i++) {
                base = mmap(NULL, mem_size, PROT_READ, flags, -1, 0);
                if (base == MAP_FAILED) {
                        fprintf(stderr, "Map memory failed!\n");
                        return -1;
                }

                for (off = 0; off < mem_size; off += page_size)
                        *(volatile int *)(base + off);

                munmap(base, mem_size);
        }

        return 0;
  }

Signed-off-by: Rui Wang <wangrui@loongson.cn>
---
 arch/loongarch/mm/tlbex.S | 223 ++++++++++++++++----------------------
 1 file changed, 93 insertions(+), 130 deletions(-)

diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 39743337999e..c97bcaad2ff4 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -10,6 +10,11 @@
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 
+#define PTRS_PER_PGD_BITS	(PAGE_SHIFT - 3)
+#define PTRS_PER_PUD_BITS	(PAGE_SHIFT - 3)
+#define PTRS_PER_PMD_BITS	(PAGE_SHIFT - 3)
+#define PTRS_PER_PTE_BITS	(PAGE_SHIFT - 3)
+
 	.macro tlb_do_page_fault, write
 	SYM_FUNC_START(tlb_do_page_fault_\write)
 	SAVE_ALL
@@ -52,25 +57,17 @@ SYM_FUNC_START(handle_tlb_load)
 
 vmalloc_done_load:
 	/* Get PGD offset in bytes */
-	srli.d	t0, t0, PGDIR_SHIFT
-	andi	t0, t0, (PTRS_PER_PGD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
+	alsl.d		t1, ra, t1, 3
 #if CONFIG_PGTABLE_LEVELS > 3
-	csrrd	t0, LOONGARCH_CSR_BADV
 	ld.d	t1, t1, 0
-	srli.d	t0, t0, PUD_SHIFT
-	andi	t0, t0, (PTRS_PER_PUD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
+	alsl.d		t1, ra, t1, 3
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-	csrrd	t0, LOONGARCH_CSR_BADV
 	ld.d	t1, t1, 0
-	srli.d	t0, t0, PMD_SHIFT
-	andi	t0, t0, (PTRS_PER_PMD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
+	alsl.d		t1, ra, t1, 3
 #endif
 	ld.d	ra, t1, 0
 
@@ -79,27 +76,20 @@ vmalloc_done_load:
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	andi	t0, ra, _PAGE_HUGE
-	bnez	t0, tlb_huge_update_load
+	rotri.d	ra, ra, _PAGE_HUGE_SHIFT + 1
+	bltz	ra, tlb_huge_update_load
 
-	csrrd	t0, LOONGARCH_CSR_BADV
-	srli.d	t0, t0, PAGE_SHIFT
-	andi	t0, t0, (PTRS_PER_PTE - 1)
-	slli.d	t0, t0, _PTE_T_LOG2
-	add.d	t1, ra, t0
+	rotri.d	ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
+	alsl.d	t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
 smp_pgtable_change_load:
-#endif
-#ifdef CONFIG_SMP
 	ll.d	t0, t1, 0
 #else
 	ld.d	t0, t1, 0
 #endif
-	tlbsrch
-
-	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
-	andi	ra, ra, 1
+	andi	ra, t0, _PAGE_PRESENT
 	beqz	ra, nopage_tlb_load
 
 	ori	t0, t0, _PAGE_VALID
@@ -109,8 +99,8 @@ smp_pgtable_change_load:
 #else
 	st.d	t0, t1, 0
 #endif
-	ori	t1, t1, 8
-	xori	t1, t1, 8
+	tlbsrch
+	bstrins.d	t1, zero, 3, 3
 	ld.d	t0, t1, 0
 	ld.d	t1, t1, 8
 	csrwr	t0, LOONGARCH_CSR_TLBELO0
@@ -133,23 +123,22 @@ vmalloc_load:
 	 */
 tlb_huge_update_load:
 #ifdef CONFIG_SMP
-	ll.d	t0, t1, 0
-#else
-	ld.d	t0, t1, 0
+	ll.d	ra, t1, 0
 #endif
-	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
-	andi	ra, ra, 1
-	beqz	ra, nopage_tlb_load
-	tlbsrch
+	andi	t0, ra, _PAGE_PRESENT
+	beqz	t0, nopage_tlb_load
 
-	ori	t0, t0, _PAGE_VALID
 #ifdef CONFIG_SMP
+	ori	t0, ra, _PAGE_VALID
 	sc.d	t0, t1, 0
 	beqz	t0, tlb_huge_update_load
-	ld.d	t0, t1, 0
+	ori	t0, ra, _PAGE_VALID
 #else
+	rotri.d	ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	ori	t0, ra, _PAGE_VALID
 	st.d	t0, t1, 0
 #endif
+	tlbsrch
 	addu16i.d	t1, zero, -(CSR_TLBIDX_EHINV >> 16)
 	addi.d		ra, t1, 0
 	csrxchg		ra, t1, LOONGARCH_CSR_TLBIDX
@@ -173,9 +162,8 @@ tlb_huge_update_load:
 	srli.d	t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
 	or	t0, t0, t1
 
-	addi.d	ra, t0, 0
-	csrwr	t0, LOONGARCH_CSR_TLBELO0
-	addi.d	t0, ra, 0
+	move	ra, t0
+	csrwr	ra, LOONGARCH_CSR_TLBELO0
 
 	/* Convert to entrylo1 */
 	addi.d	t1, zero, 1
@@ -193,6 +181,11 @@ tlb_huge_update_load:
 	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
 	addu16i.d	t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
+leave_huge_load:
+	csrrd	t0, EXCEPTION_KS0
+	csrrd	t1, EXCEPTION_KS1
+	csrrd	ra, EXCEPTION_KS2
+	ertn
 
 nopage_tlb_load:
 	dbar	0
@@ -215,26 +208,17 @@ SYM_FUNC_START(handle_tlb_store)
 
 vmalloc_done_store:
 	/* Get PGD offset in bytes */
-	srli.d	t0, t0, PGDIR_SHIFT
-	andi	t0, t0, (PTRS_PER_PGD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
-
+	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
+	alsl.d		t1, ra, t1, 3
 #if CONFIG_PGTABLE_LEVELS > 3
-	csrrd	t0, LOONGARCH_CSR_BADV
 	ld.d	t1, t1, 0
-	srli.d	t0, t0, PUD_SHIFT
-	andi	t0, t0, (PTRS_PER_PUD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
+	alsl.d		t1, ra, t1, 3
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-	csrrd	t0, LOONGARCH_CSR_BADV
 	ld.d	t1, t1, 0
-	srli.d	t0, t0, PMD_SHIFT
-	andi	t0, t0, (PTRS_PER_PMD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
+	alsl.d		t1, ra, t1, 3
 #endif
 	ld.d	ra, t1, 0
 
@@ -243,28 +227,21 @@ vmalloc_done_store:
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	andi	t0, ra, _PAGE_HUGE
-	bnez	t0, tlb_huge_update_store
+	rotri.d	ra, ra, _PAGE_HUGE_SHIFT + 1
+	bltz	ra, tlb_huge_update_store
 
-	csrrd	t0, LOONGARCH_CSR_BADV
-	srli.d	t0, t0, PAGE_SHIFT
-	andi	t0, t0, (PTRS_PER_PTE - 1)
-	slli.d	t0, t0, _PTE_T_LOG2
-	add.d	t1, ra, t0
+	rotri.d	ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
+	alsl.d	t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
 smp_pgtable_change_store:
-#endif
-#ifdef CONFIG_SMP
 	ll.d	t0, t1, 0
 #else
 	ld.d	t0, t1, 0
 #endif
-	tlbsrch
-
-	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
-	andi	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
-	xori	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
+	andi	ra, t0, _PAGE_PRESENT | _PAGE_WRITE
+	xori	ra, ra, _PAGE_PRESENT | _PAGE_WRITE
 	bnez	ra, nopage_tlb_store
 
 	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
@@ -274,9 +251,8 @@ smp_pgtable_change_store:
 #else
 	st.d	t0, t1, 0
 #endif
-
-	ori	t1, t1, 8
-	xori	t1, t1, 8
+	tlbsrch
+	bstrins.d	t1, zero, 3, 3
 	ld.d	t0, t1, 0
 	ld.d	t1, t1, 8
 	csrwr	t0, LOONGARCH_CSR_TLBELO0
@@ -299,25 +275,23 @@ vmalloc_store:
 	 */
 tlb_huge_update_store:
 #ifdef CONFIG_SMP
-	ll.d	t0, t1, 0
-#else
-	ld.d	t0, t1, 0
+	ll.d	ra, t1, 0
 #endif
-	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
-	andi	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
-	xori	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
-	bnez	ra, nopage_tlb_store
-
-	tlbsrch
-	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+	andi	t0, ra, _PAGE_PRESENT | _PAGE_WRITE
+	xori	t0, t0, _PAGE_PRESENT | _PAGE_WRITE
+	bnez	t0, nopage_tlb_store
 
 #ifdef CONFIG_SMP
+	ori	t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 	sc.d	t0, t1, 0
 	beqz	t0, tlb_huge_update_store
-	ld.d	t0, t1, 0
+	ori	t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 #else
+	rotri.d	ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	ori	t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 	st.d	t0, t1, 0
 #endif
+	tlbsrch
 	addu16i.d	t1, zero, -(CSR_TLBIDX_EHINV >> 16)
 	addi.d		ra, t1, 0
 	csrxchg		ra, t1, LOONGARCH_CSR_TLBIDX
@@ -340,9 +314,8 @@ tlb_huge_update_store:
 	srli.d	t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
 	or	t0, t0, t1
 
-	addi.d	ra, t0, 0
-	csrwr	t0, LOONGARCH_CSR_TLBELO0
-	addi.d	t0, ra, 0
+	move	ra, t0
+	csrwr	ra, LOONGARCH_CSR_TLBELO0
 
 	/* Convert to entrylo1 */
 	addi.d	t1, zero, 1
@@ -361,6 +334,11 @@ tlb_huge_update_store:
 	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
 	addu16i.d	t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
+leave_huge_store:
+	csrrd	t0, EXCEPTION_KS0
+	csrrd	t1, EXCEPTION_KS1
+	csrrd	ra, EXCEPTION_KS2
+	ertn
 
 nopage_tlb_store:
 	dbar	0
@@ -383,25 +361,17 @@ SYM_FUNC_START(handle_tlb_modify)
 
 vmalloc_done_modify:
 	/* Get PGD offset in bytes */
-	srli.d	t0, t0, PGDIR_SHIFT
-	andi	t0, t0, (PTRS_PER_PGD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
+	alsl.d		t1, ra, t1, 3
 #if CONFIG_PGTABLE_LEVELS > 3
-	csrrd	t0, LOONGARCH_CSR_BADV
 	ld.d	t1, t1, 0
-	srli.d	t0, t0, PUD_SHIFT
-	andi	t0, t0, (PTRS_PER_PUD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
+	alsl.d		t1, ra, t1, 3
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-	csrrd	t0, LOONGARCH_CSR_BADV
 	ld.d	t1, t1, 0
-	srli.d	t0, t0, PMD_SHIFT
-	andi	t0, t0, (PTRS_PER_PMD - 1)
-	slli.d	t0, t0, 3
-	add.d	t1, t1, t0
+	bstrpick.d	ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
+	alsl.d		t1, ra, t1, 3
 #endif
 	ld.d	ra, t1, 0
 
@@ -410,27 +380,20 @@ vmalloc_done_modify:
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	andi	t0, ra, _PAGE_HUGE
-	bnez	t0, tlb_huge_update_modify
+	rotri.d	ra, ra, _PAGE_HUGE_SHIFT + 1
+	bltz	ra, tlb_huge_update_modify
 
-	csrrd	t0, LOONGARCH_CSR_BADV
-	srli.d	t0, t0, PAGE_SHIFT
-	andi	t0, t0, (PTRS_PER_PTE - 1)
-	slli.d	t0, t0, _PTE_T_LOG2
-	add.d	t1, ra, t0
+	rotri.d	ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
+	alsl.d	t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
 smp_pgtable_change_modify:
-#endif
-#ifdef CONFIG_SMP
 	ll.d	t0, t1, 0
 #else
 	ld.d	t0, t1, 0
 #endif
-	tlbsrch
-
-	srli.d	ra, t0, _PAGE_WRITE_SHIFT
-	andi	ra, ra, 1
+	andi	ra, t0, _PAGE_WRITE
 	beqz	ra, nopage_tlb_modify
 
 	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
@@ -440,8 +403,8 @@ smp_pgtable_change_modify:
 #else
 	st.d	t0, t1, 0
 #endif
-	ori	t1, t1, 8
-	xori	t1, t1, 8
+	tlbsrch
+	bstrins.d	t1, zero, 3, 3
 	ld.d	t0, t1, 0
 	ld.d	t1, t1, 8
 	csrwr	t0, LOONGARCH_CSR_TLBELO0
@@ -464,23 +427,19 @@ vmalloc_modify:
 	 */
 tlb_huge_update_modify:
 #ifdef CONFIG_SMP
-	ll.d	t0, t1, 0
-#else
-	ld.d	t0, t1, 0
+	ll.d	ra, t1, 0
 #endif
-
-	srli.d	ra, t0, _PAGE_WRITE_SHIFT
-	andi	ra, ra, 1
-	beqz	ra, nopage_tlb_modify
-
-	tlbsrch
-	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+	andi	t0, ra, _PAGE_WRITE
+	beqz	t0, nopage_tlb_modify
 
 #ifdef CONFIG_SMP
+	ori	t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 	sc.d	t0, t1, 0
 	beqz	t0, tlb_huge_update_modify
-	ld.d	t0, t1, 0
+	ori	t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 #else
+	rotri.d	ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
+	ori	t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 	st.d	t0, t1, 0
 #endif
 	/*
@@ -499,9 +458,8 @@ tlb_huge_update_modify:
 	srli.d	t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
 	or	t0, t0, t1
 
-	addi.d	ra, t0, 0
-	csrwr	t0, LOONGARCH_CSR_TLBELO0
-	addi.d	t0, ra, 0
+	move	ra, t0
+	csrwr	ra, LOONGARCH_CSR_TLBELO0
 
 	/* Convert to entrylo1 */
 	addi.d	t1, zero, 1
@@ -520,6 +478,11 @@ tlb_huge_update_modify:
 	addu16i.d	t0, zero, (CSR_TLBIDX_PS >> 16)
 	addu16i.d	t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
+leave_huge_modify:
+	csrrd	t0, EXCEPTION_KS0
+	csrrd	t1, EXCEPTION_KS1
+	csrrd	ra, EXCEPTION_KS2
+	ertn
 
 nopage_tlb_modify:
 	dbar	0
-- 
2.37.3

