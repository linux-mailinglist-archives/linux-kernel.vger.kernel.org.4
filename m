Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE60874FE59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGLEj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGLEj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:39:56 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76678195
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:39:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5703d12ab9aso76389277b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136793; x=1691728793;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2t2oc+yeedMzdUFXYKBxRHbKcZMzrhHMUkscNN4bTko=;
        b=XYfimDGolFEty51TCKUyAZmm69LKogtUNWLIyMCuw81Si1ZjaboZJMyonyZe8BlA1H
         4dw7ywAuqviGzR+cqYGZtxV+ytY3jiQkgFAvjXIkhqrYEAwOpEMsZRaoOyR5rEd3GDD+
         6LnUt02lOICM7P8CDg5UfhiUAjvip1TQsKWkNZqXUfOXl95Q2+l607lxyvF7WfoMEkup
         n8srQ8rKA7PHkhNMQEN57jpX0Q3gk0ZBR2Liws8TUdU4okAi97PytXAsy84/ZZk7I96p
         LrZbc0ZAQKs4VNt1L3qD7duolPC2jOZozxLhx0DiCnOdCct9HdR1WwipR08docsFv3CN
         0s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136793; x=1691728793;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t2oc+yeedMzdUFXYKBxRHbKcZMzrhHMUkscNN4bTko=;
        b=Fb1tgEEfZET9Tz5YkiCQqdq2ti9vjzR5GnB7E8ka3KlO6teEglWtzZqholIlsqwRwS
         KT+DTmbJWSL9ICgYccIdbaaYzlxaN4ho/DsU8y9u4HJxd3aMrgQe/u99zlRtgBkXdU2w
         WbBH60Yo5HqOqU0NTuKEY/lnmt4aKBAZohUIBmDmRXMFIc3RIUGt/FGIuXsLGARzYbCG
         nmZmcXDm24kSu36lxoLaNdzErsPGnrMhcpdqZHt33J7u1tH3HIwygcMH7PLw5x/fWJ3M
         Hf3pUnBIgKENMne+r6Te3ev8y+IkhkzVHFwCZMLoj5++iffhZc33fBA6PmLCXtMk+pQX
         iWBw==
X-Gm-Message-State: ABy/qLZmDYTOdqNDb1SeqsS2YKR9c/l4IjFv0sX6BzHmfHr51Ut4YKbh
        S7SDzzRxZ8kC9a8WeuiPBiqe/A==
X-Google-Smtp-Source: APBJJlH7ohd7+cM8rUQREK94h0qZle8YpJFolayyIig71Hbg47eK0cJuvgfSIYJvI0oB6MYKn3tkcQ==
X-Received: by 2002:a81:a187:0:b0:579:efb4:7d08 with SMTP id y129-20020a81a187000000b00579efb47d08mr15922621ywg.27.1689136793558;
        Tue, 11 Jul 2023 21:39:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f130-20020a816a88000000b005702bfb19bfsm974843ywc.130.2023.07.11.21.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:39:53 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:39:48 -0700 (PDT)
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
Subject: [PATCH v3 08/13] mm/pgtable: add pte_free_defer() for pgtable as
 page
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <78e921b0-b681-a1b0-dc20-44c9efa4ef3c@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
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

Add the generic pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This version
suits all those architectures which use an unfragmented page for one page
table (none of whose pte_free()s use the mm arg which was passed to it).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm_types.h |  4 ++++
 include/linux/pgtable.h  |  2 ++
 mm/pgtable-generic.c     | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..17a7868f00bd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -144,6 +144,10 @@ struct page {
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
+			/*
+			 * A PTE page table page might be freed by use of
+			 * rcu_head: which overlays those two fields above.
+			 */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 7f2db400f653..9fa34be65159 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -112,6 +112,8 @@ static inline void pte_unmap(pte_t *pte)
 }
 #endif
 
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 /* Find an entry in the second-level page table.. */
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b9a0c2137cc1..fa9d4d084291 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mm_inline.h>
+#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 /*
@@ -230,6 +231,25 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	return pmd;
 }
 #endif
+
+/* arch define pte_free_defer in asm/pgalloc.h for its own implementation */
+#ifndef pte_free_defer
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	pte_free(NULL /* mm not passed and not used */, (pgtable_t)page);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = pgtable;
+	call_rcu(&page->rcu_head, pte_free_now);
+}
+#endif /* pte_free_defer */
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
-- 
2.35.3

