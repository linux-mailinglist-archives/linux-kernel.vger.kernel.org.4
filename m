Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742170B487
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjEVFYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVFYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:24:35 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BEDF9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:24:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561c1436c75so78162957b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733073; x=1687325073;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aUzicIbTynIqE9awb1KUIJU7FYy6E6iJhesHPP8TVA=;
        b=FCyyq681fiCl9+MbURk3V7VS6u/az3wH03OAXe0MvSy7niV7M+xCTcD3LFVHKqg1yQ
         ike7yvjl4pZ53eTIQqFm0t5pi4r6AsMUJr4uYJMWzl0YHx8ZPfzSAps1Y7Xpi29TZEWv
         oF3xEY1+E9kXiv/OXuel6wSjjlu4EU8KZchqn8ox3RdwN6yhtrdyc37IOWvkIHSmyayR
         wIwLertYdChnzsX/BWtNMS+OritTekYale8j0KLTkGM2OoyaSuh4ZrnXK1pihTZaxeir
         zEXvAqI7WXP5/kZeI5P2fpOTxrVe/RXgYq45Sc6JeGL/JmIWIWy78rlaXhstJBzFaLu3
         cGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733073; x=1687325073;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aUzicIbTynIqE9awb1KUIJU7FYy6E6iJhesHPP8TVA=;
        b=PIqUenp1QqXMWlcsejB5NWwwUUArP4lLVhBSwEfDc+dqDfYDNn2oq1FIsCktv4Mq6q
         e+tyl7fg9VVQTGQJnL3ov9viN1TpkDt/SjO3sMPC+ue1dA/ke2E7c9HdmMBBMqZGKxjn
         G9mzJgNpJObKmEwo+HbzQeY0fv3lqvl1hf1sHhpMuQBOwmHvht4QxeLzcEpvU6WMM83I
         wkK0G26OmmtmgY5JOqHnU9a5LwEWDDjynPlYPJfi+JxGJu5el4gaCml48S78dA5GzIVk
         f4+VMF+6AcRhfoKTxFTlsODhggyaD/4c5HnAwzeFY7GAAx4NJ+vPgDJ5ySlOmeveqskE
         wrPw==
X-Gm-Message-State: AC+VfDwXRrmRByIWTUKr1TEGc5KX26WoLf21vkN/uHDav6HWMmAxWBXQ
        DbwzSknkP4PPlnp8pO5h+Q7J9g==
X-Google-Smtp-Source: ACHHUZ5k0AE/kz26DrRpHOYfkL1f8tXo8j4DB4kKzH+Hlu6k3+yZrZ26Tvg/gU/iOROW9T7xGJmWkw==
X-Received: by 2002:a81:8a01:0:b0:561:b5cc:e10a with SMTP id a1-20020a818a01000000b00561b5cce10amr9111246ywg.6.1684733073356;
        Sun, 21 May 2023 22:24:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g189-20020a8152c6000000b00555e1886350sm1840019ywb.78.2023.05.21.22.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:24:33 -0700 (PDT)
Date:   Sun, 21 May 2023 22:24:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 27/31] mm/khugepaged: allow pte_offset_map[_lock]() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <aef43be2-f877-b0f8-b41c-37f847d3a7b4@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_swapin(): don't drop the map after every pte, it
only has to be dropped by do_swap_page(); give up if pte_offset_map()
fails; trace_mm_collapse_huge_page_swapin() at the end, with result;
fix comment on returned result; fix vmf.pgoff, though it's not used.

collapse_huge_page(): use pte_offset_map_lock() on the _pmd returned
from clearing; allow failure, but it should be impossible there.
hpage_collapse_scan_pmd() and collapse_pte_mapped_thp() allow for
pte_offset_map_lock() failure.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 72 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 732f9ac393fc..49cfa7cdfe93 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -993,9 +993,8 @@ static int check_pmd_still_valid(struct mm_struct *mm,
  * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
  *
  * Called and returns without pte mapped or spinlocks held.
- * Note that if false is returned, mmap_lock will be released.
+ * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
  */
-
 static int __collapse_huge_page_swapin(struct mm_struct *mm,
 				       struct vm_area_struct *vma,
 				       unsigned long haddr, pmd_t *pmd,
@@ -1004,23 +1003,35 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
 	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
+	int result;
+	pte_t *pte = NULL;
 
 	for (address = haddr; address < end; address += PAGE_SIZE) {
 		struct vm_fault vmf = {
 			.vma = vma,
 			.address = address,
-			.pgoff = linear_page_index(vma, haddr),
+			.pgoff = linear_page_index(vma, address),
 			.flags = FAULT_FLAG_ALLOW_RETRY,
 			.pmd = pmd,
 		};
 
-		vmf.pte = pte_offset_map(pmd, address);
-		vmf.orig_pte = *vmf.pte;
-		if (!is_swap_pte(vmf.orig_pte)) {
-			pte_unmap(vmf.pte);
-			continue;
+		if (!pte++) {
+			pte = pte_offset_map(pmd, address);
+			if (!pte) {
+				mmap_read_unlock(mm);
+				result = SCAN_PMD_NULL;
+				goto out;
+			}
 		}
+
+		vmf.orig_pte = *pte;
+		if (!is_swap_pte(vmf.orig_pte))
+			continue;
+
+		vmf.pte = pte;
 		ret = do_swap_page(&vmf);
+		/* Which unmaps pte (after perhaps re-checking the entry) */
+		pte = NULL;
 
 		/*
 		 * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
@@ -1029,24 +1040,29 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		 * resulting in later failure.
 		 */
 		if (ret & VM_FAULT_RETRY) {
-			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 			/* Likely, but not guaranteed, that page lock failed */
-			return SCAN_PAGE_LOCK;
+			result = SCAN_PAGE_LOCK;
+			goto out;
 		}
 		if (ret & VM_FAULT_ERROR) {
 			mmap_read_unlock(mm);
-			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-			return SCAN_FAIL;
+			result = SCAN_FAIL;
+			goto out;
 		}
 		swapped_in++;
 	}
 
+	if (pte)
+		pte_unmap(pte);
+
 	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
 	if (swapped_in)
 		lru_add_drain();
 
-	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 1);
-	return SCAN_SUCCEED;
+	result = SCAN_SUCCEED;
+out:
+	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result);
+	return result;
 }
 
 static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
@@ -1146,9 +1162,6 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 				address + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-	pte = pte_offset_map(pmd, address);
-	pte_ptl = pte_lockptr(mm, pmd);
-
 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
 	/*
 	 * This removes any huge TLB entry from the CPU so we won't allow
@@ -1163,13 +1176,18 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_remove_table_sync_one();
 
-	spin_lock(pte_ptl);
-	result =  __collapse_huge_page_isolate(vma, address, pte, cc,
-					       &compound_pagelist);
-	spin_unlock(pte_ptl);
+	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
+	if (pte) {
+		result = __collapse_huge_page_isolate(vma, address, pte, cc,
+						      &compound_pagelist);
+		spin_unlock(pte_ptl);
+	} else {
+		result = SCAN_PMD_NULL;
+	}
 
 	if (unlikely(result != SCAN_SUCCEED)) {
-		pte_unmap(pte);
+		if (pte)
+			pte_unmap(pte);
 		spin_lock(pmd_ptl);
 		BUG_ON(!pmd_none(*pmd));
 		/*
@@ -1253,6 +1271,11 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!pte) {
+		result = SCAN_PMD_NULL;
+		goto out;
+	}
+
 	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
@@ -1622,8 +1645,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * lockless_pages_from_mm() and the hardware page walker can access page
 	 * tables while all the high-level locks are held in write mode.
 	 */
-	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 	result = SCAN_FAIL;
+	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
+	if (!start_pte)
+		goto drop_immap;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1697,6 +1722,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+drop_immap:
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	goto drop_hpage;
 }
-- 
2.35.3

