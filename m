Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73270B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjEVExi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjEVExf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:53:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D1F9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:53:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9daef8681fso4777466276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731213; x=1687323213;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQBwLL4HlECbSO5gR059+G6dephAddbWEgO6E2LDWZA=;
        b=QlhUE6K0ATPFlt6KGVkJhXqSKL2ZPZOFukSr2LTyU5JBI1yxIy3RC9hQaumaw7cyuQ
         ADgG035cRuNduod0FxNhIZ0JZ4NHX+U32x2wiEFQa00gNFi56c3mSK3uiJdpEyXYIUsT
         ROwP4RLPq5CG77EbsJtEYQtkmgcTOVN5CnUNanq9+UFDyx0pkaHUzcdHI1z5w0XPUSmi
         o2MufvhNsbrbye+c4cFuachrzWPeZh2+I5zinfMV/dyW4naX4xe0MJ9MR0i12bBzFRCj
         8PLk4Zikwq2ioFjQFgXXXofFctLjXIybQaGA/r+no+6O/pmdY3s7wDE/uJygGJA7s2KN
         wLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731213; x=1687323213;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQBwLL4HlECbSO5gR059+G6dephAddbWEgO6E2LDWZA=;
        b=jFGs5QlzkSezGPHzoFA0OrmIe97hl2nWtDFwovQn/erngHfXis/FxJOnAK+Q+tPXFO
         tFB+yZKSsK2HSqOKXjbYBWZbL55pY8E+AaSZRDrLd9ROQikfY8C+LIJBCp+6RW8BnIBL
         exTeeNSiwO18b8J0zpHJJ69G3VDF/bHVEkzPnRyGvksuHOBlXX5bNJUgkX4CZ3HzZuXk
         0p90HtSomiH//FwwV/kpuzBuZ/Fk27wjrG/oRtTyCgfPx3U6K1wzkr69iKkMlealyHy6
         G+mUZMt02Boz8UkmznXayYJGNcD0DdBvPHckIKNTdXLVmqfw+r3aQ1VEJ7elX060q9oW
         ZTTg==
X-Gm-Message-State: AC+VfDx0HaJUzBIb/nTOGhAi9aQTqRJ5H6PyvgNLrhpDAB05OIeAz0Jh
        BKLdWuxNY3bV4SDLMiGs60IV3g==
X-Google-Smtp-Source: ACHHUZ4a/wUx7HBHObnjrL9fmwJm9cuLSPhXj2yvWOXUl7AxoJ4/x4VelqXRKeaAtFJsJWrg4u9aMA==
X-Received: by 2002:a25:cfc6:0:b0:ba8:62ed:2221 with SMTP id f189-20020a25cfc6000000b00ba862ed2221mr9802761ybg.62.1684731212645;
        Sun, 21 May 2023 21:53:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x7-20020a259a07000000b00b8f6ec5a955sm1255333ybn.49.2023.05.21.21.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:53:32 -0700 (PDT)
Date:   Sun, 21 May 2023 21:53:28 -0700 (PDT)
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
Subject: [PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <8218ffdc-8be-54e5-0a8-83f5542af283@google.com>
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

Make pte_offset_map() a wrapper for __pte_offset_map() (optionally
outputs pmdval), pte_offset_map_lock() a sparse __cond_lock wrapper for
__pte_offset_map_lock(): those __funcs added in mm/pgtable-generic.c.

__pte_offset_map() do pmdval validation (including pmd_clear_bad()
when pmd_bad()), returning NULL if pmdval is not for a page table.
__pte_offset_map_lock() verify pmdval unchanged after getting the
lock, trying again if it changed.

No #ifdef CONFIG_TRANSPARENT_HUGEPAGE around them: that could be done
to cover the imminent case, but we expect to generalize it later, and
it makes a mess of where to do the pmd_bad() clearing.

Add pte_offset_map_nolock(): outputs ptl like pte_offset_map_lock(),
without actually taking the lock.  This will be preferred to open uses of
pte_lockptr(), because (when split ptlock is in page table's struct page)
it points to the right lock for the returned pte pointer, even if *pmd
gets changed racily afterwards.

Update corresponding Documentation.

Do not add the anticipated rcu_read_lock() and rcu_read_unlock()s yet:
they have to wait until all architectures are balancing pte_offset_map()s
with pte_unmap()s (as in the arch series posted earlier).  But comment
where they will go, so that it's easy to add them for experiments.  And
only when those are in place can transient racy failure cases be enabled.
Add more safety for the PAE mismatched pmd_low pmd_high case at that time.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/mm/split_page_table_lock.rst | 17 ++++---
 include/linux/mm.h                         | 27 +++++++----
 include/linux/pgtable.h                    | 22 ++++++---
 mm/pgtable-generic.c                       | 56 ++++++++++++++++++++++
 4 files changed, 101 insertions(+), 21 deletions(-)

diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index 50ee0dfc95be..a834fad9de12 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -14,15 +14,20 @@ tables. Access to higher level tables protected by mm->page_table_lock.
 There are helpers to lock/unlock a table and other accessor functions:
 
  - pte_offset_map_lock()
-	maps pte and takes PTE table lock, returns pointer to the taken
-	lock;
+	maps PTE and takes PTE table lock, returns pointer to PTE with
+	pointer to its PTE table lock, or returns NULL if no PTE table;
+ - pte_offset_map_nolock()
+	maps PTE, returns pointer to PTE with pointer to its PTE table
+	lock (not taken), or returns NULL if no PTE table;
+ - pte_offset_map()
+	maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
+ - pte_unmap()
+	unmaps PTE table;
  - pte_unmap_unlock()
 	unlocks and unmaps PTE table;
  - pte_alloc_map_lock()
-	allocates PTE table if needed and take the lock, returns pointer
-	to taken lock or NULL if allocation failed;
- - pte_lockptr()
-	returns pointer to PTE table lock;
+	allocates PTE table if needed and takes its lock, returns pointer to
+	PTE with pointer to its lock, or returns NULL if allocation failed;
  - pmd_lock()
 	takes PMD table lock, returns pointer to taken lock;
  - pmd_lockptr()
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..3c2e56980853 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2787,14 +2787,25 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
-#define pte_offset_map_lock(mm, pmd, address, ptlp)	\
-({							\
-	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
-	pte_t *__pte = pte_offset_map(pmd, address);	\
-	*(ptlp) = __ptl;				\
-	spin_lock(__ptl);				\
-	__pte;						\
-})
+pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
+static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
+{
+	return __pte_offset_map(pmd, addr, NULL);
+}
+
+pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, spinlock_t **ptlp);
+static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, spinlock_t **ptlp)
+{
+	pte_t *pte;
+
+	__cond_lock(*ptlp, pte = __pte_offset_map_lock(mm, pmd, addr, ptlp));
+	return pte;
+}
+
+pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, spinlock_t **ptlp);
 
 #define pte_unmap_unlock(pte, ptl)	do {		\
 	spin_unlock(ptl);				\
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 94235ff2706e..3fabbb018557 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -94,14 +94,22 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #define pte_offset_kernel pte_offset_kernel
 #endif
 
-#if defined(CONFIG_HIGHPTE)
-#define pte_offset_map(dir, address)				\
-	((pte_t *)kmap_local_page(pmd_page(*(dir))) +		\
-	 pte_index((address)))
-#define pte_unmap(pte) kunmap_local((pte))
+#ifdef CONFIG_HIGHPTE
+#define __pte_map(pmd, address) \
+	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
+#define pte_unmap(pte)	do {	\
+	kunmap_local((pte));	\
+	/* rcu_read_unlock() to be added later */	\
+} while (0)
 #else
-#define pte_offset_map(dir, address)	pte_offset_kernel((dir), (address))
-#define pte_unmap(pte) ((void)(pte))	/* NOP */
+static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
+{
+	return pte_offset_kernel(pmd, address);
+}
+static inline void pte_unmap(pte_t *pte)
+{
+	/* rcu_read_unlock() to be added later */
+}
 #endif
 
 /* Find an entry in the second-level page table.. */
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index d2fc52bffafc..c7ab18a5fb77 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -10,6 +10,8 @@
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <linux/mm_inline.h>
 #include <asm/tlb.h>
 
@@ -229,3 +231,57 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
+{
+	pmd_t pmdval;
+
+	/* rcu_read_lock() to be added later */
+	pmdval = pmdp_get_lockless(pmd);
+	if (pmdvalp)
+		*pmdvalp = pmdval;
+	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
+		goto nomap;
+	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+		goto nomap;
+	if (unlikely(pmd_bad(pmdval))) {
+		pmd_clear_bad(pmd);
+		goto nomap;
+	}
+	return __pte_map(&pmdval, addr);
+nomap:
+	/* rcu_read_unlock() to be added later */
+	return NULL;
+}
+
+pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
+			     unsigned long addr, spinlock_t **ptlp)
+{
+	pmd_t pmdval;
+	pte_t *pte;
+
+	pte = __pte_offset_map(pmd, addr, &pmdval);
+	if (likely(pte))
+		*ptlp = pte_lockptr(mm, &pmdval);
+	return pte;
+}
+
+pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			     unsigned long addr, spinlock_t **ptlp)
+{
+	spinlock_t *ptl;
+	pmd_t pmdval;
+	pte_t *pte;
+again:
+	pte = __pte_offset_map(pmd, addr, &pmdval);
+	if (unlikely(!pte))
+		return pte;
+	ptl = pte_lockptr(mm, &pmdval);
+	spin_lock(ptl);
+	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		*ptlp = ptl;
+		return pte;
+	}
+	pte_unmap_unlock(pte, ptl);
+	goto again;
+}
-- 
2.35.3

