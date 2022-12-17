Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1FC64FBE5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLQS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLQSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548D12A;
        Sat, 17 Dec 2022 10:55:37 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Mz5GXQfbHDecaBqJZchwDyXbKPEjtIlNaAaB5rBLAfk=;
        b=3jvRN8RZOFq2XrQX+zg1FWu/xnknk1LDjcJArYoysk+a7wrxY6DiBXX35cKa8IRDozVepw
        5g8SDUFlF6juLN0FNowICYt2UBJExez6BkLE3XR/GEUHfAWnL569jervmMyExJYMgCPiZI
        PUctfnvXi9UZ+9G4zF75CRo6N75liHPnJ0otO883Byxla9cSJFu2a+3iD6pX6Idjvma/WB
        x0Xfxp3Gn32WPyH+U7wj5LHznc7nxTwjX3nGNJPifjguiERoPY09SGBPpGDUswCPARk2kP
        FKWIRCbD1RlbjaN2Vpj0O8586/4C+DnBK8UsEkB/F1YNgoOGQOyXAlBuC0K8PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Mz5GXQfbHDecaBqJZchwDyXbKPEjtIlNaAaB5rBLAfk=;
        b=EyqK6ktFr8xShHQnrhlLeds2FDj42EvrBkEs7f9Eb0pxWKQNCvoaqez58GkXt801iIbnkH
        L95yWBVG2/HnIrCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Rename pmd_read_atomic()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333324.4906.10203222530240302852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     dab6e717429e5ec795d558a0e9a5337a1ed33a3d
Gitweb:        https://git.kernel.org/tip/dab6e717429e5ec795d558a0e9a5337a1ed33a3d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:20:28 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

mm: Rename pmd_read_atomic()

There's no point in having the identical routines for PTE/PMD have
different names.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.841277397%40infradead.org
---
 include/linux/pgtable.h    |  9 ++-------
 mm/hmm.c                   |  2 +-
 mm/khugepaged.c            |  2 +-
 mm/mapping_dirty_helpers.c |  2 +-
 mm/mprotect.c              |  2 +-
 mm/userfaultfd.c           |  2 +-
 mm/vmscan.c                |  4 ++--
 7 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 7dd3df7..2334852 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1352,11 +1352,6 @@ static inline int pud_trans_unstable(pud_t *pud)
 #endif
 }
 
-static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
-{
-	return pmdp_get_lockless(pmdp);
-}
-
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)
 #endif
@@ -1383,13 +1378,13 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
  */
 static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 	/*
 	 * The barrier will stabilize the pmdval in a register or on
 	 * the stack so that it will stop changing under the code.
 	 *
 	 * When CONFIG_TRANSPARENT_HUGEPAGE=y on x86 32bit PAE,
-	 * pmd_read_atomic is allowed to return a not atomic pmdval
+	 * pmdp_get_lockless is allowed to return a not atomic pmdval
 	 * (for example pointing to an hugepage that has never been
 	 * mapped in the pmd). The below checks will only care about
 	 * the low part of the pmd with 32bit PAE x86 anyway, with the
diff --git a/mm/hmm.c b/mm/hmm.c
index 3850fb6..39cf50d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -361,7 +361,7 @@ again:
 		 * huge or device mapping one and compute corresponding pfn
 		 * values.
 		 */
-		pmd = pmd_read_atomic(pmdp);
+		pmd = pmdp_get_lockless(pmdp);
 		barrier();
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315..52237a7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -862,7 +862,7 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 	if (!*pmd)
 		return SCAN_PMD_NULL;
 
-	pmde = pmd_read_atomic(*pmd);
+	pmde = pmdp_get_lockless(*pmd);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* See comments in pmd_none_or_trans_huge_or_clear_bad() */
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 1b0ab8f..175e424 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -126,7 +126,7 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	if (!pmd_trans_unstable(&pmdval))
 		return 0;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa..f006baf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -294,7 +294,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
  */
 static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3d0fef3..89a1c9c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -630,7 +630,7 @@ retry:
 			break;
 		}
 
-		dst_pmdval = pmd_read_atomic(dst_pmd);
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
 		/*
 		 * If the dst_pmd is mapped as THP don't
 		 * override it and just be strict.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88..88ef873 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4039,9 +4039,9 @@ restart:
 	/* walk_pte_range() may call get_next_vma() */
 	vma = args->vma;
 	for (i = pmd_index(start), addr = start; addr != end; i++, addr = next) {
-		pmd_t val = pmd_read_atomic(pmd + i);
+		pmd_t val = pmdp_get_lockless(pmd + i);
 
-		/* for pmd_read_atomic() */
+		/* for pmdp_get_lockless() */
 		barrier();
 
 		next = pmd_addr_end(addr, end);
