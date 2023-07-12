Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD574FE54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGLEir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGLEin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:38:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49623136
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:38:42 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57026f4bccaso75165387b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136721; x=1691728721;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rHJ9EBJseZz5NJPKd2al59RdAa4H3OEyFlgk3ZwFK8=;
        b=VScKSufrGoiqmfI5RZZYxJxerglEQwWGwaRIv4A99gzC5wJzMKOiB64T2ejMrKgdKr
         uIsr2UxYwE3cYtc0YUlrcv6XMngYfWOsRl2pmomrgY/4Edb1ge3kiot7EKm/tncs7eVO
         cviypSqX9Re7SHqz2WACixffhKyzowkQkyHwSCtoVoDAd6Q8rADqqRRBehW9D7VhpQdy
         jfgIrKIpQWTLP3aZ5s4wAOm/AaPgQQr3FnxMyz0tHHSwgjN2BrSIYEujRK8n8SFaFHmr
         K+rhj1orR1amsxhQKit13Cu51WvZx8T3KsnjlJzFYQueSSTzV4TQi444dJi6Q49LPgkz
         NF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136721; x=1691728721;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rHJ9EBJseZz5NJPKd2al59RdAa4H3OEyFlgk3ZwFK8=;
        b=P0B1MktLqu7/nfh2oN3wjB7r6+jccQ95KqUcxyzFAFIlVU836fpXCidl6weXR0Utqy
         TQYQDqbEb2wcHYS0bHunUNell0uO8hRMLafRevRURJZPlKj7nZSkWPmwmm9TRwt+ReTs
         PqfdFweygX8g4s1/BNzVron7FC2L9b5UThbaEBJU/GnEOuC6oPq4re4wPyl0/oR2iBR0
         7bNhT5rFK9RN5GUnqNgP4AnCOC7KGc6CLSfYsNzCff4ifnTD1uLiq2i28O8H32o8BikI
         VccDffHvRKidCpf6WIPzINQvResD1cGgL4pw+gaMy8iZJUvZANl5GDYOGfivmb+XByvP
         2+wA==
X-Gm-Message-State: ABy/qLar4Jd/xJS83L+hOfe5htysa/caaRAwb9sLTFHbRXxkBnHn3hhV
        1fO/PQb75mG0pXltpwdLtm/r9A==
X-Google-Smtp-Source: APBJJlETkafvYhmOQMedWmY36OTxgXTWTltj88mfBOb4d+VWzX0jPtePMxWmYiYJC8wVDqt9xdrh6g==
X-Received: by 2002:a81:7105:0:b0:573:d3cd:3d2a with SMTP id m5-20020a817105000000b00573d3cd3d2amr17575683ywc.28.1689136721012;
        Tue, 11 Jul 2023 21:38:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b126-20020a0dc084000000b0056d443372f0sm977038ywd.119.2023.07.11.21.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:38:40 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:38:35 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 07/13] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <94eccf5f-264c-8abe-4567-e77f4b4e14a@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add s390-specific pte_free_defer(), to free table page via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This version is more complicated than others: because s390 fits two 2K
page tables into one 4K page (so page->rcu_head must be shared between
both halves), and already uses page->lru (which page->rcu_head overlays)
to list any free halves; with clever management by page->_refcount bits.

Build upon the existing management, adjusted to follow a new rule: that
a page is never on the free list if pte_free_defer() was used on either
half (marked by PageActive).  And for simplicity, delay calling RCU until
both halves are freed.

Not adding back unallocated fragments to the list in pte_free_defer()
can result in wasting some amount of memory for pagetables, depending
on how long the allocated fragment will stay in use. In practice, this
effect is expected to be insignificant, and not justify a far more
complex approach, which might allow to add the fragments back later
in __tlb_remove_table(), where we might not have a stable mm any more.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/include/asm/pgalloc.h |  4 ++
 arch/s390/mm/pgalloc.c          | 80 +++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 17eb618f1348..89a9d5ef94f8 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -143,6 +143,10 @@ static inline void pmd_populate(struct mm_struct *mm,
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
 
+/* arch use pte_free_defer() implementation in arch/s390/mm/pgalloc.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 void vmem_map_init(void);
 void *vmem_crst_alloc(unsigned long val);
 pte_t *vmem_pte_alloc(void);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 66ab68db9842..760b4ace475e 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -229,6 +229,15 @@ void page_table_free_pgste(struct page *page)
  * logic described above. Both AA bits are set to 1 to denote a 4KB-pgtable
  * while the PP bits are never used, nor such a page is added to or removed
  * from mm_context_t::pgtable_list.
+ *
+ * pte_free_defer() overrides those rules: it takes the page off pgtable_list,
+ * and prevents both 2K fragments from being reused. pte_free_defer() has to
+ * guarantee that its pgtable cannot be reused before the RCU grace period
+ * has elapsed (which page_table_free_rcu() does not actually guarantee).
+ * But for simplicity, because page->rcu_head overlays page->lru, and because
+ * the RCU callback might not be called before the mm_context_t has been freed,
+ * pte_free_defer() in this implementation prevents both fragments from being
+ * reused, and delays making the call to RCU until both fragments are freed.
  */
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
@@ -261,7 +270,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 					table += PTRS_PER_PTE;
 				atomic_xor_bits(&page->_refcount,
 							0x01U << (bit + 24));
-				list_del(&page->lru);
+				list_del_init(&page->lru);
 			}
 		}
 		spin_unlock_bh(&mm->context.lock);
@@ -281,6 +290,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	table = (unsigned long *) page_to_virt(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
+		INIT_LIST_HEAD(&page->lru);
 		atomic_xor_bits(&page->_refcount, 0x03U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
@@ -300,7 +310,9 @@ static void page_table_release_check(struct page *page, void *table,
 {
 	char msg[128];
 
-	if (!IS_ENABLED(CONFIG_DEBUG_VM) || !mask)
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return;
+	if (!mask && list_empty(&page->lru))
 		return;
 	snprintf(msg, sizeof(msg),
 		 "Invalid pgtable %p release half 0x%02x mask 0x%02x",
@@ -308,6 +320,15 @@ static void page_table_release_check(struct page *page, void *table,
 	dump_page(page, msg);
 }
 
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	unsigned int mask, bit, half;
@@ -325,10 +346,17 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		 */
 		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 		mask >>= 24;
-		if (mask & 0x03U)
+		if ((mask & 0x03U) && !PageActive(page)) {
+			/*
+			 * Other half is allocated, and neither half has had
+			 * its free deferred: add page to head of list, to make
+			 * this freed half available for immediate reuse.
+			 */
 			list_add(&page->lru, &mm->context.pgtable_list);
-		else
-			list_del(&page->lru);
+		} else {
+			/* If page is on list, now remove it. */
+			list_del_init(&page->lru);
+		}
 		spin_unlock_bh(&mm->context.lock);
 		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
 		mask >>= 24;
@@ -342,8 +370,10 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	}
 
 	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	if (TestClearPageActive(page))
+		call_rcu(&page->rcu_head, pte_free_now);
+	else
+		pte_free_now(&page->rcu_head);
 }
 
 void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
@@ -370,10 +400,18 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	 */
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
-	if (mask & 0x03U)
+	if ((mask & 0x03U) && !PageActive(page)) {
+		/*
+		 * Other half is allocated, and neither half has had
+		 * its free deferred: add page to end of list, to make
+		 * this freed half available for reuse once its pending
+		 * bit has been cleared by __tlb_remove_table().
+		 */
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
-	else
-		list_del(&page->lru);
+	} else {
+		/* If page is on list, now remove it. */
+		list_del_init(&page->lru);
+	}
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
@@ -403,10 +441,28 @@ void __tlb_remove_table(void *_table)
 	}
 
 	page_table_release_check(page, table, half, mask);
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	if (TestClearPageActive(page))
+		call_rcu(&page->rcu_head, pte_free_now);
+	else
+		pte_free_now(&page->rcu_head);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	SetPageActive(page);
+	page_table_free(mm, (unsigned long *)pgtable);
+	/*
+	 * page_table_free() does not do the pgste gmap_unlink() which
+	 * page_table_free_rcu() does: warn us if pgste ever reaches here.
+	 */
+	WARN_ON_ONCE(mm_alloc_pgste(mm));
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.
-- 
2.35.3

