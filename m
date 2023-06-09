Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB99728CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbjFIBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjFIBM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:12:58 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630A1B9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:12:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5659d85876dso10704177b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273177; x=1688865177;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTm3eSBiFsuHpLmgEmMbxBID/kzy6WIASRGS/m4xNS4=;
        b=W/4m2uxIgiBxYZeqFiaOJ+t56Xk1lzeX/0joWZYYIlyVr9x1rZQ0PVY6idfgJo3YAs
         J06WtHIbHcuFZFi7CTRbs4r/YWp12HHJP2GIpjC6Vtuxoe9P0OFgcqDXalAZfOXD7v9f
         PF1TUdN6QUVjLjHU9HZGO/hqyJB/REsEub0tjNaQLQmNIjXpYIuYk+iYoQFltIweg+DY
         h7yV6zg9eLJCboUD4lcwwTs6Aiti1k/7W+hJoajF2B88W4XFTVhUJC0bytvim02PYS13
         jSNRaWmPHUADOzQcYjUwHqikvc9EsK2V2BuWiEGpR+wVTRiltwgLI4HXCzIB2BRua0U+
         cdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273177; x=1688865177;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTm3eSBiFsuHpLmgEmMbxBID/kzy6WIASRGS/m4xNS4=;
        b=UVSSapVj1y1RVmv+xCo6QBK9LzR/L2ZGa3fhWlQOEJjhVmWp4HqG7Enl44vCFKXZP/
         w/cdcFvp/huelKrBfARW93AFFTfCIwyAobGZi7NByGwIoB6vb2eTeta1UGgz/FES76Sn
         k6Iyfm9KoYKiv06AcNJEe3vSF4zkfebX6B0w0uCsyQwB+jvfsE2lxHgOFUb9zE0UfD0P
         AvI0Gt4v72awmF4UofyXjC4zZilnMejXOpOPltTtP+G5DjMWYJFF0zQP88lgek+ULGqc
         jF5eT/ysuMHtA8ZFoQWBArqVbM1FRLWW/uye2EDp7GbjxUIcYcBBpL1wRs4X6UVQIcSD
         b2wQ==
X-Gm-Message-State: AC+VfDxdKgfKKspsouo8MAWWO95yWf64Lj2bxxaGLA/Jb6kA7MnHISN2
        YhyQsCMM9INK+1Bw1mYhpzhUGw==
X-Google-Smtp-Source: ACHHUZ7s2CfLundXAjg1vKJyhl3Rk4a+SVhLQYBVIqG94BbiAa+Lman4+SqaG4ekKQNDIkezzL6CKw==
X-Received: by 2002:a25:b11e:0:b0:b8e:cb88:1b69 with SMTP id g30-20020a25b11e000000b00b8ecb881b69mr1064722ybj.34.1686273176726;
        Thu, 08 Jun 2023 18:12:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b1-20020a252e41000000b00ba6ffc7ef35sm573643ybn.65.2023.06.08.18.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:12:56 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:12:52 -0700 (PDT)
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
Subject: [PATCH v2 06/32] mm/page_vma_mapped: delete bogosity in
 page_vma_mapped_walk()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <87475a22-e59e-2d8b-d78a-df376d314bd@google.com>
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

Revert commit a7a69d8ba88d ("mm/thp: another PVMW_SYNC fix in
page_vma_mapped_walk()"): I was proud of that "Aha!" commit at the time,
but in revisiting page_vma_mapped_walk() for pte_offset_map() failure,
that block raised a doubt: and it now seems utterly bogus.  The prior
map_pte() has taken ptl unconditionally when PVMW_SYNC: I must have
forgotten that when making the change.  It did no harm, but could not
have fixed a BUG or WARN, and is hard to reconcile with coming changes.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_vma_mapped.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 64aff6718bdb..007dc7456f0e 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -275,10 +275,6 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-			if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
-				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
-				spin_lock(pvmw->ptl);
-			}
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-- 
2.35.3

