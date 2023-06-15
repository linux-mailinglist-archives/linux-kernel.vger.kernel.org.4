Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5395973231C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjFOXKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjFOXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:10:06 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1258272C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:10:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so343010276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686870605; x=1689462605;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmZFNeoisH6VwOe/2FJwnr1e9y/lbk2gv9RdAR57kqc=;
        b=IEuubg8vIRqVRwSn1395G+XEtc7B85JxK43FvVybY07OWsveSyZ5wJsa/qhDJi5K+f
         2z4BB1oTpAZfWgHVO7bVGZxY63p2SO5CN3m2htDHyqWLCEY32bbtbvtLrdtb+FZx9aAg
         Hn4hagDUFw6lLpntWGZgt3Pm9gXqbOprY6Vv+qxOIl2OH5+lAY6GAulcnIHVr+LwoRzX
         1F4cCgdXmMAp6621pzgpHLgPeICxIK6qNeguYPRpzPl9EfF9iflGyA51t6FRtYmkXa9U
         NFseJoNQRVWNARaoQ294DgGMeBDt15bo6QIrYusvgfytMyJ+SESA1p0/o5IZ7QbwvdW0
         Iplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686870605; x=1689462605;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmZFNeoisH6VwOe/2FJwnr1e9y/lbk2gv9RdAR57kqc=;
        b=bKApWOqj1gSCiBquiRH1SIpmggThh/SIJpqzDqnA/LzCVuea1OEg/ioGCBvguBe6iq
         UOhOy5nTV48+SatUXI4TmvParRsTeCc0xn9EIx3DsBu+g5oQwj4h7j6A8IrUsaxZAhAF
         fm0Jc7uWbhGtsPw5Y4wopY+0lMwdk04dvMSWiWwaQUJ1Qe0z6zBNu2+A7MvC1mTN8dfX
         D868vgDelFBfAhEOgBf5FXYR43U1rMnY21kmJECfp245aLK8/Qm4T8hSkm7H/rtgul1L
         JnXfcsA0IuEmTOdRqN8poRtHoirIVHKeAhca/UxUqp3WQyY0oNGoRSVOuMRjjX0K48mw
         K72g==
X-Gm-Message-State: AC+VfDxnMbP1e/RMge8E6W0DG3odAClj+zqQUJOzWYfHz3/EurczFRdU
        7EiSUjTVgkfgwZsdAGTf5WRVig==
X-Google-Smtp-Source: ACHHUZ5bj4OcfS4JGbdLn1PLFW20i4mt9bA9DhWl+JUawc2n48xRkdgNXjwewweE3GNAnBMSOhAY6g==
X-Received: by 2002:a25:4288:0:b0:bad:2353:2454 with SMTP id p130-20020a254288000000b00bad23532454mr8207229yba.11.1686870604660;
        Thu, 15 Jun 2023 16:10:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k7-20020a258c07000000b00bb0ae4221b8sm4175977ybl.43.2023.06.15.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:10:04 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:10:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
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
Subject: [PATCH v2 28/32 fix] mm/memory: allow pte_offset_map[_lock]() to
 fail: fix
In-Reply-To: <bb548d50-e99a-f29e-eab1-a43bef2a1287@google.com>
Message-ID: <1a4db221-7872-3594-57ce-42369945ec8d@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <bb548d50-e99a-f29e-eab1-a43bef2a1287@google.com>
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

__wp_page_copy_user() was liable to call update_mmu_tlb() with NULL
vmf->pte in two places: not a problem today, but could become a problem
later when pte_offset_map_lock() fails.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Andrew, please add this as a fix patch for later merge into my
"mm/memory: allow" patch in mm-unstable: it's something noticed while
researching the bug Nathan reported, but not so serious - thanks.

 mm/memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4ec46eecefd3..cdadcff5ab26 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2843,7 +2843,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 			 * Other thread has already handled the fault
 			 * and update local tlb only
 			 */
-			update_mmu_tlb(vma, addr, vmf->pte);
+			if (vmf->pte)
+				update_mmu_tlb(vma, addr, vmf->pte);
 			ret = -EAGAIN;
 			goto pte_unlock;
 		}
@@ -2867,7 +2868,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
 		if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
-			update_mmu_tlb(vma, addr, vmf->pte);
+			if (vmf->pte)
+				update_mmu_tlb(vma, addr, vmf->pte);
 			ret = -EAGAIN;
 			goto pte_unlock;
 		}
-- 
2.35.3

