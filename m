Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B774FD97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGLDQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGLDQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:16:27 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F92810E5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:16:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8AxEvAHG65kjscDAA--.9821S3;
        Wed, 12 Jul 2023 11:16:23 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM0GG65kA7cpAA--.53483S5;
        Wed, 12 Jul 2023 11:16:22 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 3/3] LoongArch: mm: Add unified function populate_kernel_pte
Date:   Wed, 12 Jul 2023 11:16:22 +0800
Message-Id: <20230712031622.1888321-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230712031622.1888321-1-maobibo@loongson.cn>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM0GG65kA7cpAA--.53483S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZry3uF15JFWkGr1xXryktFc_yoWrKrWrpF
        9xCw1vvr4rGr97J39rJr93Wr1UJw4kK3Waga9rWFyrAF4aqr17Wr1kWwn7ZFyUtFWfZayS
        gr4rtasIva1qqwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pcpu_populate_pte and fixmap_pte are similar, they populate
one page from kernel address space. And there is confusion between
pgd and p4d in function fixmap_pte, such as pgd_none always returns
zero. This patch adds unified function populate_kernel_pte and replaces
pcpu_populate_pte and fixmap_pte.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/pgalloc.h |  1 +
 arch/loongarch/kernel/numa.c         | 40 +--------------------
 arch/loongarch/mm/init.c             | 52 ++++++++++++++++------------
 3 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..ca17b573dba6 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -91,4 +91,5 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
+extern pte_t * __init populate_kernel_pte(unsigned long addr);
 #endif /* _ASM_PGALLOC_H */
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 778e1c20bfb0..24a693b76873 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -67,46 +67,8 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 
 void __init pcpu_populate_pte(unsigned long addr)
 {
-	pgd_t *pgd = pgd_offset_k(addr);
-	p4d_t *p4d = p4d_offset(pgd, addr);
-	pud_t *pud;
-	pmd_t *pmd;
-
-	if (p4d_none(*p4d)) {
-		pud = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
-		if (!pud)
-			goto err_alloc;
-		p4d_populate(&init_mm, p4d, pud);
-#ifndef __PAGETABLE_PUD_FOLDED
-		pud_init(pud);
-#endif
-	}
-
-	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
-		pmd = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
-		if (!pmd)
-			goto err_alloc;
-		pud_populate(&init_mm, pud, pmd);
-#ifndef __PAGETABLE_PMD_FOLDED
-		pmd_init(pmd);
-#endif
-	}
-
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd)) {
-		pte_t *pte;
-
-		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		if (!pte)
-			goto err_alloc;
-		pmd_populate_kernel(&init_mm, pmd, pte);
-	}
-
+	populate_kernel_pte(addr);
 	return;
-
-err_alloc:
-	panic("%s: Failed to allocate memory\n", __func__);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3b7d8129570b..6cd2948373ae 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -191,46 +191,49 @@ void vmemmap_free(unsigned long start, unsigned long end, struct vmem_altmap *al
 #endif
 #endif
 
-static pte_t *fixmap_pte(unsigned long addr)
+pte_t * __init populate_kernel_pte(unsigned long addr)
 {
-	pgd_t *pgd;
-	p4d_t *p4d;
+	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud;
 	pmd_t *pmd;
 
-	pgd = pgd_offset_k(addr);
-	p4d = p4d_offset(pgd, addr);
-
-	if (pgd_none(*pgd)) {
-		pud_t *new __maybe_unused;
-
-		new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-		pgd_populate(&init_mm, pgd, new);
+	if (p4d_none(*p4d)) {
+		pud = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
+		if (!pud)
+			goto err_alloc;
+		p4d_populate(&init_mm, p4d, pud);
 #ifndef __PAGETABLE_PUD_FOLDED
-		pud_init(new);
+		pud_init(pud);
 #endif
 	}
 
 	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
-		pmd_t *new __maybe_unused;
-
-		new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-		pud_populate(&init_mm, pud, new);
+		pmd = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
+		if (!pmd)
+			goto err_alloc;
+		pud_populate(&init_mm, pud, pmd);
 #ifndef __PAGETABLE_PMD_FOLDED
-		pmd_init(new);
+		pmd_init(pmd);
 #endif
 	}
 
 	pmd = pmd_offset(pud, addr);
-	if (pmd_none(*pmd)) {
-		pte_t *new __maybe_unused;
+	if (!pmd_present(*pmd)) {
+		pte_t *pte;
 
-		new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-		pmd_populate_kernel(&init_mm, pmd, new);
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!pte)
+			goto err_alloc;
+		pmd_populate_kernel(&init_mm, pmd, pte);
 	}
 
 	return pte_offset_kernel(pmd, addr);
+
+err_alloc:
+	panic("%s: Failed to allocate memory\n", __func__);
+	return NULL;
 }
 
 void __init __set_fixmap(enum fixed_addresses idx,
@@ -241,7 +244,12 @@ void __init __set_fixmap(enum fixed_addresses idx,
 
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
-	ptep = fixmap_pte(addr);
+	/*
+	 * Now only FIX_EARLYCON_MEM_BASE fixed map is used
+	 * __set_fixmap must be called before mem_init since function
+	 * populate_kernel_pte allocates memory with memblock_alloc method.
+	 */
+	ptep = populate_kernel_pte(addr);
 	if (!pte_none(*ptep)) {
 		pte_ERROR(*ptep);
 		return;
-- 
2.27.0

