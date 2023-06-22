Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7623A73A35A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFVOnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjFVOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:42:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4C851FF6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:42:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200F6C14;
        Thu, 22 Jun 2023 07:43:23 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FFBD3F663;
        Thu, 22 Jun 2023 07:42:36 -0700 (PDT)
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
Subject: [PATCH v1 04/14] arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
Date:   Thu, 22 Jun 2023 15:41:59 +0100
Message-Id: <20230622144210.2623299-5-ryan.roberts@arm.com>
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

Create a new layer for the in-table PTE manipulation APIs. For now, The
existing API is prefixed with double underscore to become the
arch-private API and the public API is just a simple wrapper that calls
the private API.

The public API implementation will subsequently be used to transparently
manipulate the contiguous bit where appropriate. But since there are
already some contig-aware users (e.g. hugetlb, kernel mapper), we must
first ensure those users use the private API directly so that the future
contig-bit manipulations in the public API do not interfere with those
existing uses.

No behavioural changes intended.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 ++++++++--
 arch/arm64/mm/hugetlbpage.c      |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 06b5dca469f5..2a525e72537d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -941,8 +941,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
 	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
@@ -1146,6 +1145,13 @@ static inline void pte_clear(struct mm_struct *mm,
 	__pte_clear(mm, addr, ptep);
 }
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep)
+{
+	return __ptep_get_and_clear(mm, addr, ptep);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index eebd3107c7d2..931a17f3c3fb 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -188,7 +188,7 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 	unsigned long i;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
+		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
 
 		/*
 		 * If HW_AFDBM is enabled, then the HW could turn on
@@ -429,7 +429,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	pte_t orig_pte = ptep_get(ptep);
 
 	if (!pte_cont(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
+		return __ptep_get_and_clear(mm, addr, ptep);
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
-- 
2.25.1

