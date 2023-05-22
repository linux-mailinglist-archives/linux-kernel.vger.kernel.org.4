Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53170B444
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjEVFAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjEVFAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:00:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50383C6
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:00:20 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba94605bcd5so4375348276.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731619; x=1687323619;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UuVwG0QveaZLADVtUaHSgqKzTTEqSjST+aR027Vb5lo=;
        b=gG5CM9oziEo3d2xuTQZP2LZGLbyhx6n0Gd07VVIcPAplxjY92fK4ZBhk/PKkZAtjDN
         5xbQCSYDeQd+vsPz3UctEBNNQiAW1PG9SnA0aX9yoaPh6erzg7iRa3/rTzxeaqzGLp7M
         lSM/wuLv0LneLKuxocS16HoYAdzNdVswju/csw1C62EZM/zSg7SkkxlvZsPb/qR4YDiI
         JxhcXWwQQZon4YC+DZWlfAheKEVu+DJEgm81Ja53+XH3TYiVcdE+XisUHVOIOH3c+bhB
         84wXaTSFtqGDpcIfa2zJuBidBN4AfMzBHzdLZY7lpccTQVYK/Jpluc7HpY0MDlN7jzqs
         jXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731619; x=1687323619;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuVwG0QveaZLADVtUaHSgqKzTTEqSjST+aR027Vb5lo=;
        b=dnpRub+PjzLpvWT8CLwsT+aHLeX7fb1rX2nK40S3FTmUyQxt0krHUYkQ6B8lqp3kY6
         d9xEDXcO9vaBh03IUZHEBHQroZo1hQZIC83xm/s/j+sB5wT0TnR5o2VXohDVIMJ7PTGt
         3d4i1i+UhBWyAUdkpMydRMGGoj4EP/Uho4zCATJU5kwYxIgiEe3AwKXaLh/b721QuMIl
         tHtwaHV3A+zcVAYdjzyzTc0Wvyd0yjff6PuEDWcBiTS0aYIjqLpGiLKnT4DfddhjK8e4
         nfEJLZg786o1tVDfl6e2AQdSaTeMf79Rd8T+wGYooUgF60XeI/0ZlWz4w4NiDNewrF8W
         obpA==
X-Gm-Message-State: AC+VfDyzhco+FBatsGTlgqanuBVgmVesJUSlMkidYIJRF3j/LcfLuVT3
        OAYO9YrrzdVXclOYRh02mM/k4Q==
X-Google-Smtp-Source: ACHHUZ7OcXDmRntzMQt9n+hv5KPWL1NcuSYc2shkgSn7zkVgG1IKDeMbUgq8Rk9jU0J7GbmzBFEDoA==
X-Received: by 2002:a81:6d09:0:b0:561:902e:dc0a with SMTP id i9-20020a816d09000000b00561902edc0amr9837501ywc.32.1684731619134;
        Sun, 21 May 2023 22:00:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r63-20020a815d42000000b00555df877a4csm1794565ywb.102.2023.05.21.22.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:00:18 -0700 (PDT)
Date:   Sun, 21 May 2023 22:00:15 -0700 (PDT)
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
Subject: [PATCH 09/31] mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock()
 fails
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <6265ac58-6018-a8c6-cf38-69cba698471@google.com>
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

Simple walk_page_range() users should set ACTION_AGAIN to retry when
pte_offset_map_lock() fails.

No need to check pmd_trans_unstable(): that was precisely to avoid the
possiblity of calling pte_offset_map() on a racily removed or inserted
THP entry, but such cases are now safely handled inside it.  Likewise
there is no need to check pmd_none() or pmd_bad() before calling it.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/proc/task_mmu.c | 32 ++++++++++++++++----------------
 mm/damon/vaddr.c   | 12 ++++++++----
 mm/mempolicy.c     |  7 ++++---
 mm/mincore.c       |  9 ++++-----
 mm/mlock.c         |  4 ++++
 5 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 420510f6a545..dba5052ce09b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -631,14 +631,11 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd))
-		goto out;
-	/*
-	 * The mmap_lock held all the way back in m_start() is what
-	 * keeps khugepaged out of here and from collapsing things
-	 * in here.
-	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
@@ -1191,10 +1188,11 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
@@ -1538,9 +1536,6 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		spin_unlock(ptl);
 		return err;
 	}
-
-	if (pmd_trans_unstable(pmdp))
-		return 0;
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	/*
@@ -1548,6 +1543,10 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	 * goes beyond vma->vm_end.
 	 */
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return err;
+	}
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		pagemap_entry_t pme;
 
@@ -1887,11 +1886,12 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		spin_unlock(ptl);
 		return 0;
 	}
-
-	if (pmd_trans_unstable(pmd))
-		return 0;
 #endif
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
 		if (!page)
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1fec16d7263e..b8762ff15c3c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -318,9 +318,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		spin_unlock(ptl);
 	}
 
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		return 0;
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	if (!pte_present(*pte))
 		goto out;
 	damon_ptep_mkold(pte, walk->mm, addr);
@@ -464,9 +466,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 regular_page:
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		return -EINVAL;
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	if (!pte_present(*pte))
 		goto out;
 	folio = damon_get_folio(pte_pfn(*pte));
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1756389a0609..4d0bcf6f0d52 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -514,10 +514,11 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	if (ptl)
 		return queue_folios_pmd(pmd, ptl, addr, end, walk);
 
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
diff --git a/mm/mincore.c b/mm/mincore.c
index 2d5be013a25a..f33f6a0b1ded 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -113,12 +113,11 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd)) {
-		__mincore_unmapped_range(addr, end, vma, vec);
-		goto out;
-	}
-
 	ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!ptep) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 40b43f8740df..9f2b1173b1b1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -329,6 +329,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 
 	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
-- 
2.35.3

