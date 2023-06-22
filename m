Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4B73A365
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjFVOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFVOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:43:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E009270B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:43:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0FCAC14;
        Thu, 22 Jun 2023 07:43:45 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C4793F663;
        Thu, 22 Jun 2023 07:42:59 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 12/14] arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
Date:   Thu, 22 Jun 2023 15:42:07 +0100
Message-Id: <20230622144210.2623299-13-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622144210.2623299-1-ryan.roberts@arm.com>
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptep_get_and_clear_full() adds a 'full' parameter which is not present
for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
a full address space teardown is in progress. We use this information to
optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
contiguous neighbours to keep their contig bit set, because we know we
are about to clear the rest too.

Before this optimization, the cost of arm64_sys_exit_group() exploded to
32x what it was before PTE_CONT support was wired up, when compiling the
kernel. With this optimization in place, we are back down to the
original cost.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 18 ++++++++-
 arch/arm64/mm/contpte.c          | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 17ea534bc5b0..5963da651da7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1128,6 +1128,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
+extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
@@ -1252,12 +1254,24 @@ static inline void pte_clear(struct mm_struct *mm,
 	__pte_clear(mm, addr, ptep);
 }
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
+static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep, int full)
+{
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte) || !full) {
+		contpte_try_unfold(mm, addr, ptep, orig_pte);
+		return __ptep_get_and_clear(mm, addr, ptep);
+	} else
+		return contpte_ptep_get_and_clear_full(mm, addr, ptep);
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-	return __ptep_get_and_clear(mm, addr, ptep);
+	return ptep_get_and_clear_full(mm, addr, ptep, 0);
 }
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index e8e4a298fd53..0b585d1c4c94 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -241,6 +241,74 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 	} while (addr != end);
 }
 
+pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep)
+{
+	/*
+	 * When doing a full address space teardown, we can avoid unfolding the
+	 * contiguous range, and therefore avoid the associated tlbi. Instead,
+	 * just clear the pte. The caller is promising to call us for every pte,
+	 * so every pte in the range will be cleared by the time the tlbi is
+	 * issued.
+	 *
+	 * However, this approach will leave the ptes in an inconsistent state
+	 * until ptep_get_and_clear_full() has been called for every pte in the
+	 * range. This could cause ptep_get() to fail to return the correct
+	 * access/dirty bits, if ptep_get() calls are interleved with
+	 * ptep_get_and_clear_full() (which they are). Solve this by copying the
+	 * access/dirty bits to every pte in the range so that ptep_get() still
+	 * sees them if we have already cleared pte that the hw chose to update.
+	 * Note that a full teardown will only happen when the process is
+	 * exiting, so we do not expect anymore accesses and therefore no more
+	 * access/dirty bit updates, so there is no race here.
+	 */
+
+	pte_t *orig_ptep = ptep;
+	pte_t pte;
+	bool flags_propagated = false;
+	bool dirty = false;
+	bool young = false;
+	int i;
+
+	/* First, gather access and dirty bits. */
+	ptep = contpte_align_down(orig_ptep);
+	for (i = 0; i < CONT_PTES; i++, ptep++) {
+		pte = __ptep_get(ptep);
+
+		/*
+		 * If we find a zeroed PTE, contpte_ptep_get_and_clear_full()
+		 * must have already been called for it, so we have already
+		 * propagated the flags to the other ptes.
+		 */
+		if (pte_val(pte) == 0) {
+			flags_propagated = true;
+			break;
+		}
+
+		if (pte_dirty(pte))
+			dirty = true;
+
+		if (pte_young(pte))
+			young = true;
+	}
+
+	/* Now copy the access and dirty bits into each pte in the range. */
+	if (!flags_propagated) {
+		ptep = contpte_align_down(orig_ptep);
+		for (i = 0; i < CONT_PTES; i++, ptep++) {
+			pte = __ptep_get(ptep);
+
+			if (dirty)
+				pte = pte_mkdirty(pte);
+
+			if (young)
+				pte = pte_mkyoung(pte);
+		}
+	}
+
+	return __ptep_get_and_clear(mm, addr, orig_ptep);
+}
+
 int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
-- 
2.25.1

