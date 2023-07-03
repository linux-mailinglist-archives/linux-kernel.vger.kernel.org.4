Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B19745DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGCNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGCNyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:54:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C171716
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:53:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FD552F4;
        Mon,  3 Jul 2023 06:54:35 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD643F73F;
        Mon,  3 Jul 2023 06:53:50 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 5/5] arm64: mm: Override arch_wants_pte_order()
Date:   Mon,  3 Jul 2023 14:53:30 +0100
Message-Id: <20230703135330.1865927-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703135330.1865927-1-ryan.roberts@arm.com>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
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

Define an arch-specific override of arch_wants_pte_order() so that when
FLEXIBLE_THP is enabled, large folios will be allocated for anonymous
memory with an order that is compatible with arm64's contpte mappings.

arch_wants_pte_order() returns an order according to the following
policy: For the unhinted case, when THP is not requested for the vma,
don't allow anything bigger than 64K. This means we don't waste too much
memory. Additionally, for 4K pages this is the contpte size, and for
16K, this is (usually) the HPA size when the uarch feature is
implemented. For the hinted case, when THP is requested for the vma,
allow the contpte size for all page size configurations; 64K for 4K, 2M
for 16K and 2M for 64K.

Additionally, the THP and NOTHP order constants are defined using
Kconfig so it is possible to override them at build time.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/Kconfig               | 12 ++++++++++++
 arch/arm64/include/asm/pgtable.h |  4 ++++
 arch/arm64/mm/mmu.c              |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 343e1e1cae10..689c5bf13dc1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -281,6 +281,18 @@ config ARM64_CONT_PMD_SHIFT
 	default 5 if ARM64_16K_PAGES
 	default 4
 
+config ARM64_PTE_ORDER_NOTHP
+	int
+	default 0 if ARM64_64K_PAGES	# 64K (1 page)
+	default 2 if ARM64_16K_PAGES	# 64K (4 pages; benefits from HPA where HW supports it)
+	default 4 if ARM64_4K_PAGES	# 64K (16 pages; eligible for contpte-mapping)
+
+config ARM64_PTE_ORDER_THP
+	int
+	default 5 if ARM64_64K_PAGES	# 2M  (32 pages; eligible for contpte-mapping)
+	default 7 if ARM64_16K_PAGES	# 2M  (128 pages; eligible for contpte-mapping)
+	default 4 if ARM64_4K_PAGES	# 64K (16 pages; eligible for contpte-mapping)
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 14 if ARM64_64K_PAGES
 	default 16 if ARM64_16K_PAGES
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6fd012663a01..8463d5f9f307 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1117,6 +1117,10 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
 extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep,
 				    pte_t old_pte, pte_t new_pte);
+
+#define arch_wants_pte_order arch_wants_pte_order
+extern int arch_wants_pte_order(struct vm_area_struct *vma);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index af6bc8403ee4..8556c4a9b507 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1481,3 +1481,11 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
 {
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
+
+int arch_wants_pte_order(struct vm_area_struct *vma)
+{
+	if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
+		return CONFIG_ARM64_PTE_ORDER_THP;
+	else
+		return CONFIG_ARM64_PTE_ORDER_NOTHP;
+}
-- 
2.25.1

