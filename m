Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A0728CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbjFIBKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFIBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:10:39 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F4184
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:10:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565bd368e19so10730187b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273037; x=1688865037;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQBwLL4HlECbSO5gR059+G6dephAddbWEgO6E2LDWZA=;
        b=pehkqmIu5uuC2/B3POt5qXky+VS7UB4H0MKZKoA0UPHDqWhVIxnSWvN2qZj214i7Wi
         xlP2w3eBKNw5TWHpEBt8Ykvx85JhHDfFCoQrHuZvQV3gF+6AdXASRaQWOncyvod5v/cn
         lgCa62bmqNVztpuFb1tB0iswKKgr36t6UpOuDeHZ2gPb/O3B3TO2wbqCc1yTI1noFll7
         3JosUpTyMIooa8ybR3xoSKQBoApqEb5yRt0CGd4bkYJ/922RqEv0JAPqXk9hzJKhIMnT
         DFobijIf2lK30P2q6urus71da4ADA/iomZybOe90CAfsWC55Rzl6LoyMj3bmbkCn6ZM3
         5Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273037; x=1688865037;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQBwLL4HlECbSO5gR059+G6dephAddbWEgO6E2LDWZA=;
        b=k9orL6bekU9n1yjUwy70/IBXEuBqTSiI6JJCngPfJA5XjB4jfKspmi7SkIZx9jbR2I
         BOul06UomJR+USyX0CTWEpmZea9FFJOVOj6Zp6toYOTsnTDcQbtFLmIgo7Kn/Q119cPH
         d+UkRTlwYWm8QtzVNOyYrRfUCUMw3kdTPdD2kGZzQMyIt4/b9KVJ6EuVCs417sRawYl+
         3pvUwDsiR0DgQgheGRiAxQmI8w7Jmv4+BKQ0DXRvJvHVmO7PLUUM6l4v1NWC1s08bK5r
         dMo4PVMEL7CK2V+DQAmXTgI/kZTtvSxTOhaNWPL9WGofsHniKYv1FaroZuIngTxIGl4z
         UbYg==
X-Gm-Message-State: AC+VfDxIYdaltIfQG+Lq3tgs37r2J9o0bf0sMA6GZsBrX4z6b3xG/Opn
        ZGMM4TPaBWDUCCV45BY7XgsMEA==
X-Google-Smtp-Source: ACHHUZ4RPJYEqOW+mRJ0KmB3JL8CSbjs+Mlo2tkty+xU7pqquzaJQl3sBeIwjaFrTRmmS8IvpanSCg==
X-Received: by 2002:a81:47d4:0:b0:565:9d00:8a14 with SMTP id u203-20020a8147d4000000b005659d008a14mr1378760ywa.20.1686273036762;
        Thu, 08 Jun 2023 18:10:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a17-20020a81bb51000000b00545a08184fdsm265795ywl.141.2023.06.08.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:10:36 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:10:32 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 04/32] mm/pgtable: allow pte_offset_map[_lock]() to fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
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

