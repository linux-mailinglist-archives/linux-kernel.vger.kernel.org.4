Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDA70B483
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEVFWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjEVFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:22:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8347CA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:22:17 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba829f93da3so8148830276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732937; x=1687324937;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bf4ovlbip9o2eAgzZYzeIq4fNWAxMs47VtohjgZo/Hc=;
        b=xxliRdiYq491ddtLAOp7IvlP6Tgs09+WixlM6YG4PIP9hmkihY34Mp7pqS8UXaXWhi
         RqkBsAewEsCIX9b0ejcCa5E2jV6uN+a3W57TZ3FlG9ZI/Xxbjh+C1MSqcwhmQFBu25PN
         rRzcJXLhWTtkRDhu7m269tBf4pXwAXhsMjAzMdb8HFMIiX2bUkp/5SZfLmQ8JxH4T0vk
         wKyQPeorZ9iGKOGhWx6oCTIHOln7Bg8pdmjG1PPm7ouSR3zthhZvslly93YlThiYWoSt
         Uq6if1E3nt9EtldOeJnlIf2uspBMjaO0EQ7qGUle/0SCGanLsme+EJIaES6VTaJRp/ZR
         yfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732937; x=1687324937;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf4ovlbip9o2eAgzZYzeIq4fNWAxMs47VtohjgZo/Hc=;
        b=XbgnM2eD0eOUhKeTJb/YcZu+b7myoXKFCdSuRo1xLr1rJRyPucBV/tNQjRpafiVBqE
         AmBYdR55lX4wMxlp7YIdKrrzAZq8LYovhWLkuc2uLHqia0ElNsYeR8hPQetQuLRUqO2p
         LduEJpg/DpFF6/sVHIv3T6NN8yXoC/Fdp+qUf4Neyi7OOKq1oJgq0KqgaAYQEdVOsSgF
         etd7qqvPuP6Z3kdQ58JI+swGrggIlT49dIDujJ4eZTiGImaQ3jzQeGljh2cwP28ZOZ7A
         KUe7fmsHN99LPsWnzNDyJJ0kN5Y3HlyG6Hdb8Iy3LJww9NiAiYPb8OYY27Pz+WjenG7g
         y/aQ==
X-Gm-Message-State: AC+VfDweAb3yJIMOD7a0CuEeZnlsgaUn8NHR/FQ9ee0swtUxdxKy6pjx
        gz/0FtdgNe0wfIUTrk6y7JfByw==
X-Google-Smtp-Source: ACHHUZ6vQXHbZLVvPerE0Fu3jg6OZ5EHbThB/3RtX3VnGbimP3VA+F9C2VHWinuyuwC+mVweYmLjPw==
X-Received: by 2002:a25:f812:0:b0:ba8:3590:4302 with SMTP id u18-20020a25f812000000b00ba835904302mr10377914ybd.36.1684732936746;
        Sun, 21 May 2023 22:22:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x7-20020a259a07000000b00b8f6ec5a955sm1266497ybn.49.2023.05.21.22.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:22:16 -0700 (PDT)
Date:   Sun, 21 May 2023 22:22:13 -0700 (PDT)
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
Subject: [PATCH 25/31] mm/gup: remove FOLL_SPLIT_PMD use of
 pmd_trans_unstable()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com>
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

There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block to
distinguish huge_zero_page from a normal THP: follow_page_pte() handles
any instability, and here it's a good idea to replace any pmd_none(*pmd)
by a page table a.s.a.p, in the huge_zero_page case as for a normal THP.
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

