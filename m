Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F566321D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjAIU7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbjAIU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1598E994
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h1-20020a17090a470100b0022646263abfso3630483pjg.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUx/OB3iQQFsS6Pcn0sWsw86mSb+m9wyFp0pF/RbXSk=;
        b=dIxUWUkrPawF5nCoP+HUjvA+1vmI2x8utDxJKsWUDKbZyEnrEFBNIhzaM8Fi8ju0R6
         eFijpcCpNnzwFYn4qQcfR/+HsKpxnsThGu7XxjIktqkOlh8pbTgjPjgxlF3er9jtpiFK
         3GSfGJF3spx9qr3lx0Xbz1tHEn1iO2FRbitd8mVM168Ji21A6WJbwvjHXFAHlbmszk/z
         PHIXCswYcUFMYiFzIipRXQxj+Lq9k2DTCyxkIwApZosMOj5/aAMGnoES19O/qzXO1kO2
         XId6gaep+ySgAUv8E1eSLybQz1XP2tMRZPlcvFIYudobcMhpLFz5bkGWnIsnoWm/3FYR
         M9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUx/OB3iQQFsS6Pcn0sWsw86mSb+m9wyFp0pF/RbXSk=;
        b=ThauEerJsCcZZZExuz6OwOHfGejYCTGA8dOl1iZJZ+kn5p7St/ZNemJe3uUDU/zCy+
         CSKz62k1EBiFB8ULrVC/Y4HHa0JsVgmydZlEjSCSp7TBYF6XZk4wo6ePMT85OQrnRB8w
         A7X9TU3CE5Vl/G1MesSIDzayEL8ML9CLsFzugtKdL6X7YefWIcLf3X0tu4z5QGB1zo4r
         +VBYDi9pSnlfLRp626qsyuK1+HBnhLJK/xR6cSNt9dAaoc9li1cqIJ7K1CE1x4Ed8fiy
         pPbyKnqPcbv5GhOVteQq1ZKgqwKfX5arN/3o/Lw2jstbjBu0vWdX9jgTdMzLJL33f3yv
         pJzQ==
X-Gm-Message-State: AFqh2kocJWrBpJlDppiYhtqnoKRJlPnAqq+BUe/JxcC0sATYgkR3z+Ah
        xCMl7ZkaC7UEt9XU99olEuNmF3TRdLk=
X-Google-Smtp-Source: AMrXdXtKEO5NZ0LV26PgvCCbCCrX8iN+m+pnC68agl9KzwVT0TYKaTzsINmDv+j62IKmNfwju5kMUEnv/YA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a17:90b:370a:b0:226:f53b:d370 with SMTP id
 mg10-20020a17090b370a00b00226f53bd370mr875190pjb.75.1673297716576; Mon, 09
 Jan 2023 12:55:16 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:33 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-39-surenb@google.com>
Subject: [PATCH 38/41] mm: avoid assertion in untrack_pfn
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

untrack_pfn can be called after VMA was isolated and mmap_lock downgraded.
An attempt to lock affected VMA would cause an assertion, therefore
use mod_vm_flags_nolock in such situations.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/mm/pat/memtype.c | 10 +++++++---
 include/linux/mm.h        |  2 +-
 include/linux/pgtable.h   |  5 +++--
 mm/memory.c               | 15 ++++++++-------
 mm/memremap.c             |  4 ++--
 mm/mmap.c                 |  4 ++--
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 9e490a372896..f71c8381430b 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1045,7 +1045,7 @@ void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
  * can be for the entire vma (in which case pfn, size are zero).
  */
 void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
-		 unsigned long size)
+		 unsigned long size, bool lock_vma)
 {
 	resource_size_t paddr;
 	unsigned long prot;
@@ -1064,8 +1064,12 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		size = vma->vm_end - vma->vm_start;
 	}
 	free_pfn_range(paddr, size);
-	if (vma)
-		clear_vm_flags(vma, VM_PAT);
+	if (vma) {
+		if (lock_vma)
+			clear_vm_flags(vma, VM_PAT);
+		else
+			mod_vm_flags_nolock(vma, 0, VM_PAT);
+	}
 }
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7d436a5027cc..3158f33e268c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2135,7 +2135,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 			   unsigned long size, struct zap_details *details);
 void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *start_vma, unsigned long start,
-		unsigned long end);
+		unsigned long end, bool lock_vma);
 
 struct mmu_notifier_range;
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1159b25b0542..eaa831bd675d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1214,7 +1214,8 @@ static inline int track_pfn_copy(struct vm_area_struct *vma)
  * can be for the entire vma (in which case pfn, size are zero).
  */
 static inline void untrack_pfn(struct vm_area_struct *vma,
-			       unsigned long pfn, unsigned long size)
+			       unsigned long pfn, unsigned long size,
+			       bool lock_vma)
 {
 }
 
@@ -1232,7 +1233,7 @@ extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
 extern int track_pfn_copy(struct vm_area_struct *vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
-			unsigned long size);
+			unsigned long size, bool lock_vma);
 extern void untrack_pfn_moved(struct vm_area_struct *vma);
 #endif
 
diff --git a/mm/memory.c b/mm/memory.c
index 12508f4d845a..5c7d5eaa60d8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1610,7 +1610,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 static void unmap_single_vma(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr,
-		struct zap_details *details)
+		struct zap_details *details, bool lock_vma)
 {
 	unsigned long start = max(vma->vm_start, start_addr);
 	unsigned long end;
@@ -1625,7 +1625,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 		uprobe_munmap(vma, start, end);
 
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn(vma, 0, 0);
+		untrack_pfn(vma, 0, 0, lock_vma);
 
 	if (start != end) {
 		if (unlikely(is_vm_hugetlb_page(vma))) {
@@ -1672,7 +1672,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  */
 void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr)
+		unsigned long end_addr, bool lock_vma)
 {
 	struct mmu_notifier_range range;
 	struct zap_details details = {
@@ -1686,7 +1686,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	do {
-		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
+				 lock_vma);
 	} while ((vma = mas_find(&mas, end_addr - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
@@ -1715,7 +1716,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	do {
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+		unmap_single_vma(&tlb, vma, start, range.end, NULL, false);
 	} while ((vma = mas_find(&mas, end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
@@ -1750,7 +1751,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	 * unmap 'address-end' not 'range.start-range.end' as range
 	 * could have been expanded for hugetlb pmd sharing.
 	 */
-	unmap_single_vma(&tlb, vma, address, end, details);
+	unmap_single_vma(&tlb, vma, address, end, details, false);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
@@ -2519,7 +2520,7 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 
 	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
 	if (err)
-		untrack_pfn(vma, pfn, PAGE_ALIGN(size));
+		untrack_pfn(vma, pfn, PAGE_ALIGN(size), true);
 	return err;
 }
 EXPORT_SYMBOL(remap_pfn_range);
diff --git a/mm/memremap.c b/mm/memremap.c
index 08cbf54fe037..2f88f43d4a01 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -129,7 +129,7 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 	}
 	mem_hotplug_done();
 
-	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range));
+	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
 	pgmap_array_delete(range);
 }
 
@@ -276,7 +276,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	if (!is_private)
 		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 err_kasan:
-	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range));
+	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
 err_pfn_remap:
 	pgmap_array_delete(range);
 	return error;
diff --git a/mm/mmap.c b/mm/mmap.c
index a256deca0bc0..332af383f7cd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2209,7 +2209,7 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mt, vma, start, end);
+	unmap_vmas(&tlb, mt, vma, start, end, lock_vma);
 	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING,
 				 lock_vma);
@@ -3127,7 +3127,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX, false);
 	mmap_read_unlock(mm);
 
 	/*
-- 
2.39.0

