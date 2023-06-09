Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F79728D30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbjFIBkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjFIBkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:40:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B22D74
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:40:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba8151a744fso1359054276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274804; x=1688866804;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwuVNK2fY7F7iaoH+tt2s4ap3NLwMgK8mAcGkUuV1QI=;
        b=xtJR0sJIJzLTXBky/wVlZo29dNTxzgA54BszS4z+bL4XgGa67uu8WNTm+JM7XI/l9k
         6m4Lc80dzOLZH5qTELBlC5YxGQJLyz1bh8ZNW1tEJ8D6xjLzQ+u4+WAilxn55/jW0XRb
         Epze0ZHSodQnM7E7VM26/xnDCzhsJKvRWH4eXMeV0AMMehd09rxHboGfxvtXMtgKk1Z4
         SnsamQypCiUjdvefoXG4abvyN6tDU3XIw1oNbEazjBhrMx+Kg+mHF/zkH+Ct85cC8hz5
         iw1woW6T1GIXQ5NWzRO4+D6+WwHZuB7CFNtHE38x8bXk+v2L1K3lyzT2dxXGxy6c449H
         V+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274804; x=1688866804;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwuVNK2fY7F7iaoH+tt2s4ap3NLwMgK8mAcGkUuV1QI=;
        b=HHCUPVwH6Pu6J90z7bTkRR990AxFGLSltMLkiN/w1tlhkDCdReKZX1ywKT90oXKurf
         tQ4PBPZYK3WdwWHAGfFZGpVuppKZOvqlVBUxtI75kvOFMom5yOIZbbqLJitXDRwkD0J1
         nT3zqRd1ZpY8azVF0lv13D2KrSoOHhOHoewXt2qhuD6ces52u49a0JrLQuxAxQ7WtHJ3
         jA2f+ktQTOdWGhy/vMNbomQ8AhyulxPjMH8Gf5A/olT7HawVPys6u2dOigSXKzf9mfnR
         3PVKx6eIR55he04t5Sy6aXY04k9kL9mzuLEmOxLL5cVt3gSYY7R5mEC2Ij9Zt4J/vSVr
         DZow==
X-Gm-Message-State: AC+VfDxeMQyPB4hU6wkrOiIrFrCjrxcHKKwTBitmBdjwuQ52KeJjQkTC
        UMri3ZeLisMoQLaP1kH06vxhfA==
X-Google-Smtp-Source: ACHHUZ4q7dBjgPopIYtcorM5R7hyIrmP9CgiCOnb4btr582PPdFwrjvxsL7Fli0sAzIP7Ak/8SJsSA==
X-Received: by 2002:a0d:f543:0:b0:561:ce93:b560 with SMTP id e64-20020a0df543000000b00561ce93b560mr1378798ywf.43.1686274804318;
        Thu, 08 Jun 2023 18:40:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t202-20020a8183d3000000b005619cfb1b88sm306230ywf.52.2023.06.08.18.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:40:03 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:39:59 -0700 (PDT)
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
Subject: [PATCH v2 25/32] mm/gup: remove FOLL_SPLIT_PMD use of
 pmd_trans_unstable()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <59fd15dd-4d39-5ec-2043-1d5117f7f85@google.com>
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

There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block to
distinguish huge_zero_page from a normal THP: follow_page_pte() handles
any instability, and here it's a good idea to replace any pmd_none(*pmd)
by a page table a.s.a.p, in the huge_zero_page case as for a normal THP;
and this removes an unnecessary possibility of -EBUSY failure.

(Hmm, couldn't the normal THP case have hit an unstably refaulted THP
before?  But there are only two, exceptional, users of FOLL_SPLIT_PMD.)

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/gup.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index bb67193c5460..4ad50a59897f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -681,21 +681,10 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	if (flags & FOLL_SPLIT_PMD) {
-		int ret;
-		page = pmd_page(*pmd);
-		if (is_huge_zero_page(page)) {
-			spin_unlock(ptl);
-			ret = 0;
-			split_huge_pmd(vma, pmd, address);
-			if (pmd_trans_unstable(pmd))
-				ret = -EBUSY;
-		} else {
-			spin_unlock(ptl);
-			split_huge_pmd(vma, pmd, address);
-			ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
-		}
-
-		return ret ? ERR_PTR(ret) :
+		spin_unlock(ptl);
+		split_huge_pmd(vma, pmd, address);
+		/* If pmd was left empty, stuff a page table in there quickly */
+		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
-- 
2.35.3

