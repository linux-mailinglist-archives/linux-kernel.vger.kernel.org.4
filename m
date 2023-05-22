Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D614A70B443
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjEVE7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEVE7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:59:05 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E10ED
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:59:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56190515833so47623467b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731541; x=1687323541;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VYOFAJpcVHpYrrS1TQZcIVdYEqSjI0GrwCgA5USRTU=;
        b=TGvacnGGV6vCjNoR60zApDSkblq671aMycg9KRLogEr52U+VDqJD6c9LnImDcePwXP
         E+oOLSRKY3QnKjySzwhyx6yXTUVprQkKKmDGsyxWBnNRAxybbHWPE+dZuUWqHGT3elWd
         KJzJqVN+sTGBo7NuVZnh1kpo/iER1/+XPOJgROkPPAZo27SecID8MF0vNrn6JwCjXzCa
         UJM1gcqwPlnlc9FLHaIRUz/YKXEVOCkEBbD5opmzBt0US/6C6qPiSdxH6LlPD5UCxU/z
         zjtg+pK6HvaDdyOshiCuMXpAmIJoOt9KExIMuIDdOzn/Rpr/BNUdc7KJhSnoFWJGvEir
         v0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731541; x=1687323541;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VYOFAJpcVHpYrrS1TQZcIVdYEqSjI0GrwCgA5USRTU=;
        b=CNrRo7uQLhJLoLnrvcUqnXnPXEXQVtaBP0NIuRtlzFFis5ETVp+V1zZ+Gfz7CcauPe
         Ufim+Q1Nk+a9A3HWlVBJ2PPw4qfbBNZEa0t1nujVoiTRoOcx8tWasjPG6kj1bXfBNmGG
         EpNlWkjxxscgGqJPv8krNr9R9jOZMUAb70pgBgkxm6YU0WSx03cjICEqBTcIdNWNN85R
         65CrtRk3aiYuJnlgT1+70B2ZP0Fxt5RL+c+N+Hvtoqm5MytAsd+Giu6/WcnMCdG8QlAX
         3IyfXmCYTLisORN7IF9+MMjvrkI3gx1eqn7doyW5IWZ8bxEkPE+WE4++xzvkrt5CcH3W
         dtWw==
X-Gm-Message-State: AC+VfDz2w9ckXRYexFbjFOJSaC8zoUZ3mtMv8f/M7p92y9wCt7wM4TV+
        0uDX1NyeFUwwCzXDVW9B60IipA==
X-Google-Smtp-Source: ACHHUZ4Kg3oHxKZR/9CKF00axRzhTRl1agKzGrSrlAst7zhZTlHx2mXvNeak2L2x7OdVQNGzScOvHA==
X-Received: by 2002:a81:1e45:0:b0:560:d022:53ac with SMTP id e66-20020a811e45000000b00560d02253acmr10367255ywe.5.1684731541606;
        Sun, 21 May 2023 21:59:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g189-20020a8152c6000000b00555e1886350sm1827794ywb.78.2023.05.21.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:59:01 -0700 (PDT)
Date:   Sun, 21 May 2023 21:58:58 -0700 (PDT)
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
Subject: [PATCH 08/31] mm/page_vma_mapped: pte_offset_map_nolock() not
 pte_lockptr()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <8fa3fb6e-2e39-cbea-c529-ee9e64c7d2d0@google.com>
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

map_pte() use pte_offset_map_nolock(), to make sure of the ptl belonging
to pte, even if pmd entry is then changed racily: page_vma_mapped_walk()
use that instead of getting pte_lockptr() later, or restart if map_pte()
found no page table.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_vma_mapped.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 947dc7491815..2af734274073 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -13,16 +13,28 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 	return false;
 }
 
-static bool map_pte(struct page_vma_mapped_walk *pvmw)
+static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 {
 	if (pvmw->flags & PVMW_SYNC) {
 		/* Use the stricter lookup */
 		pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
 						pvmw->address, &pvmw->ptl);
-		return true;
+		*ptlp = pvmw->ptl;
+		return !!pvmw->pte;
 	}
 
-	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
+	/*
+	 * It is important to return the ptl corresponding to pte,
+	 * in case *pvmw->pmd changes underneath us; so we need to
+	 * return it even when choosing not to lock, in case caller
+	 * proceeds to loop over next ptes, and finds a match later.
+	 * Though, in most cases, page lock already protects this.
+	 */
+	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
+					  pvmw->address, ptlp);
+	if (!pvmw->pte)
+		return false;
+
 	if (pvmw->flags & PVMW_MIGRATION) {
 		if (!is_swap_pte(*pvmw->pte))
 			return false;
@@ -51,7 +63,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	} else if (!pte_present(*pvmw->pte)) {
 		return false;
 	}
-	pvmw->ptl = pte_lockptr(pvmw->vma->vm_mm, pvmw->pmd);
+	pvmw->ptl = *ptlp;
 	spin_lock(pvmw->ptl);
 	return true;
 }
@@ -156,6 +168,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long end;
+	spinlock_t *ptl;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -257,8 +270,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw))
+		if (!map_pte(pvmw, &ptl)) {
+			if (!pvmw->pte)
+				goto restart;
 			goto next_pte;
+		}
 this_pte:
 		if (check_pte(pvmw))
 			return true;
@@ -281,7 +297,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-			pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
+			pvmw->ptl = ptl;
 			spin_lock(pvmw->ptl);
 		}
 		goto this_pte;
-- 
2.35.3

