Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D1728D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbjFIBhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjFIBhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:37:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582F22D72
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:37:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-568ba7abc11so11571467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274636; x=1688866636;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zu44LOJFUZSfjUzXfaM7AXaMVzmcNQ9SKaG/n0S1Di4=;
        b=g/fK8hP5bFpFVjO76tLNArCNe2GlcEYd1TR7ZwQdCtSODKo9bn2ob62ekzm4ZsThhU
         yjQK+8xMaXjxfJ1yZWY7NOanC9yVcDVOaMe2iZYwQzT6eJ8h5uTrJC9oVwwCDxswbBHp
         l/xid7bUgRR1+bdWUBBbvmFDZ/iNYOS5AHsDau932Tn9EMZ4WD6ylqBkwxof8Mw7/egD
         Ww4k6FcpaXFX8Vqb/E2HUbm90tkOaEYqBxZ6KyMuDMKUc0iBxBMpA3o8pXAN+XBCXRzs
         f8EIBhd27TS5I+YyqHsJshT+x1siX1ieudcplgI00w6T7xrRyEgdPl7QxJSf2yBgKL3/
         hKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274636; x=1688866636;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu44LOJFUZSfjUzXfaM7AXaMVzmcNQ9SKaG/n0S1Di4=;
        b=BkAcWE0/HBrOzTrkMOrCSUbtIY7MNRxodkTQvGzYPbaDBpIHfgZwHFOjecZDc2ff6w
         MI/xgy7N9EPvM4MM911Fk3uH6xw9oxxTi4VKvvL5bF02I7B4wHffQXFqpXkm9xbsDvoO
         GIgopXEJcKpmjPEiKKxlvbwGDH549hkK9M1zQWKADQ9Kf4jKk1o3n3IwQWeqj+WWH5tT
         XhwEuQBiG0E3cgADvnigbcbMuN+vmByhRvREFSmLwZkJhNIGqNFfF55c46pOPa9MGVJI
         mlZWeUJdLSgVwnXUTpQUorZbE1DYM5GsUJ2OavEmMmoknZ274ljF0mKsh2Gilbgza2c0
         Pfbg==
X-Gm-Message-State: AC+VfDz3NjF5iI86q8ZHokLDPr7fL/1ivpqJyGdP20+IYDo7OctquOoQ
        qdRe69pvQQbtT74+YKrepnqdjg==
X-Google-Smtp-Source: ACHHUZ5BEYGpIOz49tbHOiOve9aTVph95zxtniJYmBvQce3mSMb/qY9GD2nlVpV9ClVLYloJKEZjzA==
X-Received: by 2002:a81:46d7:0:b0:565:eedc:8dbe with SMTP id t206-20020a8146d7000000b00565eedc8dbemr1425297ywa.27.1686274636468;
        Thu, 08 Jun 2023 18:37:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k124-20020a816f82000000b00565b26a9c9csm292968ywc.64.2023.06.08.18.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:37:15 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:37:12 -0700 (PDT)
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
Subject: [PATCH v2 23/32] mm/mglru: allow pte_offset_map_nolock() to fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <51ece73e-7398-2e4a-2384-56708c87844f@google.com>
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

MGLRU's walk_pte_range() use the safer pte_offset_map_nolock(), rather
than pte_lockptr(), to get the ptl for its trylock.  Just return false
and move on to next extent if it fails, like when the trylock fails.
Remove the VM_WARN_ON_ONCE(pmd_leaf) since that will happen, rarely.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d0cd2840cf0..6a9bb6b30dc8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3993,15 +3993,15 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
 
-	VM_WARN_ON_ONCE(pmd_leaf(*pmd));
-
-	ptl = pte_lockptr(args->mm, pmd);
-	if (!spin_trylock(ptl))
+	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	if (!pte)
 		return false;
+	if (!spin_trylock(ptl)) {
+		pte_unmap(pte);
+		return false;
+	}
 
 	arch_enter_lazy_mmu_mode();
-
-	pte = pte_offset_map(pmd, start & PMD_MASK);
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
@@ -4042,10 +4042,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	if (i < PTRS_PER_PTE && get_next_vma(PMD_MASK, PAGE_SIZE, args, &start, &end))
 		goto restart;
 
-	pte_unmap(pte);
-
 	arch_leave_lazy_mmu_mode();
-	spin_unlock(ptl);
+	pte_unmap_unlock(pte, ptl);
 
 	return suitable_to_scan(total, young);
 }
-- 
2.35.3

