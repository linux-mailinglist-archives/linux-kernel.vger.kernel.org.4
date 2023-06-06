Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B307236AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjFFFMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:12:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3A12D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:11:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so10067217276.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 22:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686028317; x=1688620317;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg5QZP2g60my/74v9bFDX0ytuK3YiKYcw7uy2Evxx/w=;
        b=NhPKZdrYlIvx7iNLVAjsRa8aEHC/++SunSHEGfSq4fN41PBLT9eZcR2/wHJ4nNVR2f
         5X/0qJZ+DCYCVShcxq8ke6LXK+C9/UShkM7LasBWEgOB2lDScl83QpHIK1gmWA98m/ss
         SiduR3KyQD6Hrp/mO9LD07U2/2ZllMy8jd1Pih81/9dWMCLo0uyekAd3DX2sEX+Cw5Yx
         lbDeXr44Hg9suU7r7LOljSJN223vdWS720TPzZ3+aBdeerGpaWsECVKxrVJU3J1sLPwv
         iHtUGdsItYjQDfhX1peOkao4EoBYflXBBDYRnRhxuQWSnFrY4DMOhUaKCtFH6PjCrdp/
         Cd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686028317; x=1688620317;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg5QZP2g60my/74v9bFDX0ytuK3YiKYcw7uy2Evxx/w=;
        b=h0WLY9Gel1IPxzqTitBI8XXNpCfkHsh8dpgHFluaVGYG3cnrYO2OKQvxDia/+mkDjX
         fqTEGsf3bMkwt7lv4v7bKur6tqRZEw50qG7bI5MXJd9QSBgtPCg5Hj6RCt0HyGkDJ+Th
         DKi30C7UbTnynoE+QqaCnqbdEkmRUr77eZ6GeNnYBFimxcCGKAIaVhvqUHjAi+7XiHNG
         QMjKdOJMbMAsLm+xzVqmhD6iXjdOa6AXe3AVTPOwpjodtAKt3WFCtY8M2p0fVRJo0ZeJ
         VmZKiXCBnmLoTALAUSa0pmmqcues0si/OHfACOodWYoTAAXuCWv82eZLCHr2VGlnla5x
         h56w==
X-Gm-Message-State: AC+VfDzwr2kYL5Vf2YQDAm1KOUQmNFdlZ9V0qyvUfWM6t4KKLXPDkWhT
        Y++3QM3iZ+E0xZPm3eMQyGE47Q==
X-Google-Smtp-Source: ACHHUZ7mNDwt5noCg8dzsm+uwzH2YBNGxVJGpnYLqxOLpDnODKyqQEHd1FpsbgO8FPXNURX25I813Q==
X-Received: by 2002:a0d:ccca:0:b0:568:b105:751 with SMTP id o193-20020a0dccca000000b00568b1050751mr12281723ywd.2.1686028316993;
        Mon, 05 Jun 2023 22:11:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t19-20020a81c253000000b0055a7c2375dfsm3718391ywg.101.2023.06.05.22.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:11:56 -0700 (PDT)
Date:   Mon, 5 Jun 2023 22:11:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
In-Reply-To: <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
Message-ID: <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
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

On Sun, 28 May 2023, Hugh Dickins wrote:

> Add s390-specific pte_free_defer(), to call pte_free() via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This precedes
> the generic version to avoid build breakage from incompatible pgtable_t.
> 
> This version is more complicated than others: because page_table_free()
> needs to know which fragment is being freed, and which mm to link it to.
> 
> page_table_free()'s fragment handling is clever, but I could too easily
> break it: what's done here in pte_free_defer() and pte_free_now() might
> be better integrated with page_table_free()'s cleverness, but not by me!
> 
> By the time that page_table_free() gets called via RCU, it's conceivable
> that mm would already have been freed: so mmgrab() in pte_free_defer()
> and mmdrop() in pte_free_now().  No, that is not a good context to call
> mmdrop() from, so make mmdrop_async() public and use that.

But Matthew Wilcox quickly pointed out that sharing one page->rcu_head
between multiple page tables is tricky: something I knew but had lost
sight of.  So the powerpc and s390 patches were broken: powerpc fairly
easily fixed, but s390 more painful.

In https://lore.kernel.org/linux-s390/20230601155751.7c949ca4@thinkpad-T15/
On Thu, 1 Jun 2023 15:57:51 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> 
> Yes, we have 2 pagetables in one 4K page, which could result in same
> rcu_head reuse. It might be possible to use the cleverness from our
> page_table_free() function, e.g. to only do the call_rcu() once, for
> the case where both 2K pagetable fragments become unused, similar to
> how we decide when to actually call __free_page().
> 
> However, it might be much worse, and page->rcu_head from a pagetable
> page cannot be used at all for s390, because we also use page->lru
> to keep our list of free 2K pagetable fragments. I always get confused
> by struct page unions, so not completely sure, but it seems to me that
> page->rcu_head would overlay with page->lru, right?

Sigh, yes, page->rcu_head overlays page->lru.  But (please correct me if
I'm wrong) I think that s390 could use exactly the same technique for
its list of free 2K pagetable fragments as it uses for its list of THP
"deposited" pagetable fragments, over in arch/s390/mm/pgtable.c: use
the first two longs of the page table itself for threading the list.

And while it could use third and fourth longs instead, I don't see any
need for that: a deposited pagetable has been allocated, so would not
be on the list of free fragments.

Below is one of the grossest patches I've ever posted: gross because
it's a rushed attempt to see whether that is viable, while it would take
me longer to understand all the s390 cleverness there (even though the
PP AA commentary above page_table_alloc() is excellent).

I'm hoping the use of page->lru in arch/s390/mm/gmap.c is disjoint.
And cmma_init_nodat()? Ah, that's __init so I guess disjoint.

Gerald, s390 folk: would it be possible for you to give this
a try, suggest corrections and improvements, and then I can make it
a separate patch of the series; and work on avoiding concurrent use
of the rcu_head by pagetable fragment buddies (ideally fit in with
the scheme already there, maybe DD bits to go along with the PP AA).

Why am I even asking you to move away from page->lru: why don't I
thread s390's pte_free_defer() pagetables like THP's deposit does?
I cannot, because the deferred pagetables have to remain accessible
as valid pagetables, until the RCU grace period has elapsed - unless
all the list pointers would appear as pte_none(), which I doubt.

(That may limit our possibilities with the deposited pagetables in
future: I can imagine them too wanting to remain accessible as valid
pagetables.  But that's not needed by this series, and s390 only uses
deposit/withdraw for anon THP; and some are hoping that we might be
able to move away from deposit/withdraw altogther - though powerpc's
special use will make that more difficult.)

Thanks!
Hugh

--- 6.4-rc5/arch/s390/mm/pgalloc.c
+++ linux/arch/s390/mm/pgalloc.c
@@ -232,6 +232,7 @@ void page_table_free_pgste(struct page *
  */
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
+	struct list_head *listed;
 	unsigned long *table;
 	struct page *page;
 	unsigned int mask, bit;
@@ -241,8 +242,8 @@ unsigned long *page_table_alloc(struct m
 		table = NULL;
 		spin_lock_bh(&mm->context.lock);
 		if (!list_empty(&mm->context.pgtable_list)) {
-			page = list_first_entry(&mm->context.pgtable_list,
-						struct page, lru);
+			listed = mm->context.pgtable_list.next;
+			page = virt_to_page(listed);
 			mask = atomic_read(&page->_refcount) >> 24;
 			/*
 			 * The pending removal bits must also be checked.
@@ -259,9 +260,12 @@ unsigned long *page_table_alloc(struct m
 				bit = mask & 1;		/* =1 -> second 2K */
 				if (bit)
 					table += PTRS_PER_PTE;
+				BUG_ON(table != (unsigned long *)listed);
 				atomic_xor_bits(&page->_refcount,
 							0x01U << (bit + 24));
-				list_del(&page->lru);
+				list_del(listed);
+				set_pte((pte_t *)&table[0], __pte(_PAGE_INVALID));
+				set_pte((pte_t *)&table[1], __pte(_PAGE_INVALID));
 			}
 		}
 		spin_unlock_bh(&mm->context.lock);
@@ -288,8 +292,9 @@ unsigned long *page_table_alloc(struct m
 		/* Return the first 2K fragment of the page */
 		atomic_xor_bits(&page->_refcount, 0x01U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
+		listed = (struct list head *)(table + PTRS_PER_PTE);
 		spin_lock_bh(&mm->context.lock);
-		list_add(&page->lru, &mm->context.pgtable_list);
+		list_add(listed, &mm->context.pgtable_list);
 		spin_unlock_bh(&mm->context.lock);
 	}
 	return table;
@@ -310,6 +315,7 @@ static void page_table_release_check(str
 
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
+	struct list_head *listed;
 	unsigned int mask, bit, half;
 	struct page *page;
 
@@ -325,10 +331,24 @@ void page_table_free(struct mm_struct *m
 		 */
 		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 		mask >>= 24;
-		if (mask & 0x03U)
-			list_add(&page->lru, &mm->context.pgtable_list);
-		else
-			list_del(&page->lru);
+		if (mask & 0x03U) {
+			listed = (struct list_head *)table;
+			list_add(listed, &mm->context.pgtable_list);
+		} else {
+			/*
+			 * Get address of the other page table sharing the page.
+			 * There are sure to be MUCH better ways to do all this!
+			 * But I'm rushing, while trying to keep to the obvious.
+			 */
+			listed = (struct list_head *)(table + PTRS_PER_PTE);
+			if (virt_to_page(listed) != page) {
+				/* sizeof(*listed) is twice sizeof(*table) */
+				listed -= PTRS_PER_PTE;
+			}
+			list_del(listed);
+			set_pte((pte_t *)&listed->next, __pte(_PAGE_INVALID));
+			set_pte((pte_t *)&listed->prev, __pte(_PAGE_INVALID));
+		}
 		spin_unlock_bh(&mm->context.lock);
 		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
 		mask >>= 24;
@@ -349,6 +369,7 @@ void page_table_free(struct mm_struct *m
 void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 			 unsigned long vmaddr)
 {
+	struct list_head *listed;
 	struct mm_struct *mm;
 	struct page *page;
 	unsigned int bit, mask;
@@ -370,10 +391,24 @@ void page_table_free_rcu(struct mmu_gath
 	 */
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
-	if (mask & 0x03U)
-		list_add_tail(&page->lru, &mm->context.pgtable_list);
-	else
-		list_del(&page->lru);
+	if (mask & 0x03U) {
+		listed = (struct list_head *)table;
+		list_add_tail(listed, &mm->context.pgtable_list);
+	} else {
+		/*
+		 * Get address of the other page table sharing the page.
+		 * There are sure to be MUCH better ways to do all this!
+		 * But I'm rushing, and trying to keep to the obvious.
+		 */
+		listed = (struct list_head *)(table + PTRS_PER_PTE);
+		if (virt_to_page(listed) != page) {
+			/* sizeof(*listed) is twice sizeof(*table) */
+			listed -= PTRS_PER_PTE;
+		}
+		list_del(listed);
+		set_pte((pte_t *)&listed->next, __pte(_PAGE_INVALID));
+		set_pte((pte_t *)&listed->prev, __pte(_PAGE_INVALID));
+	}
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
