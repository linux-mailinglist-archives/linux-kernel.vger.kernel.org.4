Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0B680D56
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjA3MPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjA3MPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:15:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0CF110F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:15:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7691756;
        Mon, 30 Jan 2023 04:15:58 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.51.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BD2A3F71E;
        Mon, 30 Jan 2023 04:15:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/mm: Intercept pfn changes in set_pte_at()
Date:   Mon, 30 Jan 2023 17:44:57 +0530
Message-Id: <20230130121457.1607675-1-anshuman.khandual@arm.com>
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

Changing pfn on a user page table mapped entry, without first going through
break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
to intercept such changes, via an updated pgattr_change_is_safe(). This new
check happens via __check_racy_pte_update(), which has now been renamed as
__check_safe_pte_update().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.2-rc6

Changes in V3:

- Changed pgattr_change_is_safe() as suggested by Mark

Changes in V2:

https://lore.kernel.org/all/20230109052816.405335-1-anshuman.khandual@arm.com/

Changes in V1:

https://lore.kernel.org/all/20221116031001.292236-1-anshuman.khandual@arm.com/

 arch/arm64/include/asm/pgtable.h | 8 ++++++--
 arch/arm64/mm/mmu.c              | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 65e78999c75d..27455bfd64bc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -275,6 +275,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 }
 
 extern void __sync_icache_dcache(pte_t pteval);
+bool pgattr_change_is_safe(u64 old, u64 new);
 
 /*
  * PTE bits configuration in the presence of hardware Dirty Bit Management
@@ -292,7 +293,7 @@ extern void __sync_icache_dcache(pte_t pteval);
  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
  */
 
-static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
+static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
 					   pte_t pte)
 {
 	pte_t old_pte;
@@ -318,6 +319,9 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
 	VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
 		     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
 		     __func__, pte_val(old_pte), pte_val(pte));
+	VM_WARN_ONCE(!pgattr_change_is_safe(pte_val(old_pte), pte_val(pte)),
+		     "%s: unsafe attribute change: 0x%016llx -> 0x%016llx",
+		     __func__, pte_val(old_pte), pte_val(pte));
 }
 
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
@@ -346,7 +350,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 			mte_sync_tags(old_pte, pte);
 	}
 
-	__check_racy_pte_update(mm, ptep, pte);
+	__check_safe_pte_update(mm, ptep, pte);
 
 	set_pte(ptep, pte);
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d77c9f56b7b4..6f9d8898a025 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -133,7 +133,7 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
 	return phys;
 }
 
-static bool pgattr_change_is_safe(u64 old, u64 new)
+bool pgattr_change_is_safe(u64 old, u64 new)
 {
 	/*
 	 * The following mapping attributes may be updated in live
@@ -142,9 +142,13 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
 
 	/* creating or taking down mappings is always safe */
-	if (old == 0 || new == 0)
+	if (!pte_valid(__pte(old)) || !pte_valid(__pte(new)))
 		return true;
 
+	/* A live entry's pfn should not change */
+	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
+		return false;
+
 	/* live contiguous mappings may not be manipulated at all */
 	if ((old | new) & PTE_CONT)
 		return false;
-- 
2.30.2

