Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959462ED37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiKRFbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRFbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:31:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E81D87A49
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:31:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4595223A;
        Thu, 17 Nov 2022 21:31:17 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C5873F587;
        Thu, 17 Nov 2022 21:31:07 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Date:   Fri, 18 Nov 2022 11:01:02 +0530
Message-Id: <20221118053102.500216-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__create_pgd_mapping_locked() expects a page allocator used while mapping a
virtual range. This page allocator function propagates down the call chain,
while building intermediate levels in the page table. Passed page allocator
is a necessary ingredient required to build the page table but its presence
can be asserted just once in the very beginning rather than in all the down
stream functions. This consolidates BUG_ON(!pgtable_alloc) checks just in a
single place i.e __create_pgd_mapping_locked().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc5

 arch/arm64/mm/mmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5a19950e7289..97ca82001089 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -207,7 +207,6 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			pmdval |= PMD_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc(PAGE_SHIFT);
 		__pmd_populate(pmdp, pte_phys, pmdval);
 		pmd = READ_ONCE(*pmdp);
@@ -285,7 +284,6 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			pudval |= PUD_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc(PMD_SHIFT);
 		__pud_populate(pudp, pmd_phys, pudval);
 		pud = READ_ONCE(*pudp);
@@ -324,7 +322,6 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			p4dval |= P4D_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc(PUD_SHIFT);
 		__p4d_populate(p4dp, pud_phys, p4dval);
 		p4d = READ_ONCE(*p4dp);
@@ -383,6 +380,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 	phys &= PAGE_MASK;
 	addr = virt & PAGE_MASK;
 	end = PAGE_ALIGN(virt + size);
+	BUG_ON(!pgtable_alloc);
 
 	do {
 		next = pgd_addr_end(addr, end);
-- 
2.25.1

