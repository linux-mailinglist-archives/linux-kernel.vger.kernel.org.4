Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE07235D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFFDkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFFDkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:40:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E577219C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:40:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bad142be0ebso6600388276.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686022813; x=1688614813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppdA1HOEm1YrutAbUD+A9qZwrkXnWHAEzQEcPuSUQvw=;
        b=AaSiNAsIPj5e3tOnCQ/aDowLknZMLmU1vqGBzyA4VjJt+CZ0FWqvIx2oN71D86IR0v
         FLViUws5VQumFsM7KuBRwAT9VyLPyIW6vadfXNFCVtZX1vDhmNuhC/0Zy2It8DAerBJ7
         8xLEzAq1ZdtK+acCt5qtqT32IDaYRv8zVMNcJrHWVabmhyjuksDG7D9pQLYr3kwY8eb5
         sFUu+DxLJxSAb/iCrBbAGJGyTG8qDwYsB+chGm1QZBtw3mPwOv5o7/isigAxJcvEVc+8
         uMzKkJ3fuweEFhICAeW4n1QGGYEv+F56c310I8HaydTlCx1+CH3/oUQ5UXKHP1tzbapc
         IwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686022813; x=1688614813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppdA1HOEm1YrutAbUD+A9qZwrkXnWHAEzQEcPuSUQvw=;
        b=Ac7WjQNl8whcOqPyTcbVmMH4c2MQnGcBKWcycOtZKs58FpLi3QoMyZgDuDy0UZ8/zt
         2P1wQstwpGDqXgsDr2OMkSUKiANlAe0rN3nvuzO3g1lnFE8VE+OMzGCb6I6GuAr5hn5Y
         5Ztc9oI2V90QT033UcQBrAiVilLZx77eleUDjGoFZYAOX3bp9BzE8L9Jr3soS9FgcHxu
         wmTFAq6oUMLBM3B1MHXHrXo37hKEgAnfWWNwvTj35zEdQ9iWFYLltiHGUwkhK4E7fDH+
         0GGpRWVJTicubBoOjN7X1WVRGEqD1nrGBIyx+yJStWSEcyDx5B1IDMsFFDvgvO+Kgh7G
         7Dog==
X-Gm-Message-State: AC+VfDyyqeXBAdHAjPF841GGHkabnytDjRiib/czBm3LJsOh9nVRy12o
        voAYJTcnXcqP3xzHrHQbSQU1tA==
X-Google-Smtp-Source: ACHHUZ5z/giZNmIrlQ3cgoOoM3851R87uLopCghqIrYrEcOCft5W4FkKF+LeL6IbE2hJ4M6UbpPI1w==
X-Received: by 2002:a81:7d84:0:b0:565:a8dd:c6f4 with SMTP id y126-20020a817d84000000b00565a8ddc6f4mr535188ywc.33.1686022812680;
        Mon, 05 Jun 2023 20:40:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z128-20020a0dd786000000b00568e5a65698sm3754537ywd.28.2023.06.05.20.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:40:11 -0700 (PDT)
Date:   Mon, 5 Jun 2023 20:40:01 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Zack Rusin <zackr@vmware.com>,
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
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <ZHn6n5eVTsr4Wl8x@ziepe.ca>
Message-ID: <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com> <ZHSwWgLWaEd+zi/g@casper.infradead.org> <ZHn6n5eVTsr4Wl8x@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023, Jason Gunthorpe wrote:
> On Mon, May 29, 2023 at 03:02:02PM +0100, Matthew Wilcox wrote:
> > On Sun, May 28, 2023 at 11:20:21PM -0700, Hugh Dickins wrote:
> > > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > > +{
> > > +	struct page *page;
> > > +
> > > +	page = virt_to_page(pgtable);
> > > +	call_rcu(&page->rcu_head, pte_free_now);
> > > +}
> > 
> > This can't be safe (on ppc).  IIRC you might have up to 16x4k page
> > tables sharing one 64kB page.  So if you have two page tables from the
> > same page being defer-freed simultaneously, you'll reuse the rcu_head
> > and I cannot imagine things go well from that point.
> > 
> > I have no idea how to solve this problem.
> 
> Maybe power and s390 should allocate a side structure, sort of a
> pre-memdesc thing to store enough extra data?
> 
> If we can get enough bytes then something like this would let a single
> rcu head be shared to manage the free bits.
> 
> struct 64k_page {
>     u8 free_pages;
>     u8 pending_rcu_free_pages;
>     struct rcu_head head;
> }
> 
> free_sub_page(sub_id)
>     if (atomic_fetch_or(1 << sub_id, &64k_page->pending_rcu_free_pages))
>          call_rcu(&64k_page->head)
> 
> rcu_func()
>    64k_page->free_pages |= atomic_xchg(0, &64k_page->pending_rcu_free_pages)
> 
>    if (64k_pages->free_pages == all_ones)
>       free_pgea(64k_page);

Or simply allocate as many rcu_heads as page tables.

I have not thought through your suggestion above, because I'm against
asking s390, or any other architecture, to degrade its page table
implementation by demanding more memory, just for the sake of my patch
series.  In a future memdesc world it might turn out to be reasonable,
but not for this (if I can possibly avoid it).

Below is what I believe to be the correct powerpc patch (built but not
retested).  sparc I thought was going to be an equal problem, but turns
out not: I'll comment on 06/12.  And let's move s390 discussion to 07/12.

[PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing page

Add powerpc-specific pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This is awkward because the struct page contains only one rcu_head, but
that page may be shared between PTE_FRAG_NR pagetables, each wanting to
use the rcu_head at the same time: account concurrent deferrals with a
heightened refcount, only the first making use of the rcu_head, but
re-deferring if more deferrals arrived during its grace period.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/include/asm/pgalloc.h |  4 +++
 arch/powerpc/mm/pgtable-frag.c     | 51 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 3360cad78ace..3a971e2a8c73 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -45,6 +45,10 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
+/* arch use pte_free_defer() implementation in arch/powerpc/mm/pgtable-frag.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 /*
  * Functions that deal with pagetables that could be at any level of
  * the table need to be passed an "index_size" so they know how to
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 20652daa1d7e..e4f58c5fc2ac 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
 		__free_page(page);
 	}
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
+
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+	int refcount;
+
+	page = container_of(head, struct page, rcu_head);
+	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
+				     &page->pt_frag_refcount);
+	if (refcount < PTE_FREE_DEFERRED) {
+		pte_fragment_free((unsigned long *)page_address(page), 0);
+		return;
+	}
+	/*
+	 * One page may be shared between PTE_FRAG_NR pagetables.
+	 * At least one more call to pte_free_defer() came in while we
+	 * were already deferring, so the free must be deferred again;
+	 * but just for one grace period, however many calls came in.
+	 */
+	while (refcount >= PTE_FREE_DEFERRED + PTE_FREE_DEFERRED) {
+		refcount = atomic_sub_return(PTE_FREE_DEFERRED,
+					     &page->pt_frag_refcount);
+	}
+	/* Remove that refcount of 1 left for fragment freeing above */
+	atomic_dec(&page->pt_frag_refcount);
+	call_rcu(&page->rcu_head, pte_free_now);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	/*
+	 * One page may be shared between PTE_FRAG_NR pagetables: only queue
+	 * it once for freeing, but note whenever the free must be deferred.
+	 *
+	 * (This would be much simpler if the struct page had an rcu_head for
+	 * each fragment, or if we could allocate a separate array for that.)
+	 *
+	 * Convert our refcount of 1 to a refcount of PTE_FREE_DEFERRED, and
+	 * proceed to call_rcu() only when the rcu_head is not already in use.
+	 */
+	if (atomic_add_return(PTE_FREE_DEFERRED - 1, &page->pt_frag_refcount) <
+			      PTE_FREE_DEFERRED + PTE_FREE_DEFERRED)
+		call_rcu(&page->rcu_head, pte_free_now);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.35.3

