Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5670B47A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjEVFRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjEVFRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:17:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE6AB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:17:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561c5b5e534so74337747b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732653; x=1687324653;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzsL+M6cdepZgQw4hIUfWIci6E11MaKNkaWhV1yArkY=;
        b=f6H5lzyEl/529vvBXo7cjHFatUfG3YtCbKZO/m7kkdLuuofbAW6JB7TNcMTLxhS2Fa
         oCscaMoZSrdZFIADmHM3vqeNvKHSfDv45YS3VG0xINc3KnCVeYBUvVx6KUlmN5IVqTQ3
         eea7j8ExK19Opvsc5Spx705Pw81qEdSQc02WpxsCt2PFWo+K9ekVeiRw9nrsNx+U4KaQ
         G9GGOC4mudc6X5o4tr3EZNzo4YmhfN4UtuJyHpWp81+YRZq+yrHLruWf2ZHUJUdTErJk
         SGxCiEVvSkiDFU5p6ro7GOO7WaLMeSjUeJjhiSiayQPvsPwDptONLF8o1b8tv18mP3Yi
         FtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732653; x=1687324653;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzsL+M6cdepZgQw4hIUfWIci6E11MaKNkaWhV1yArkY=;
        b=g97ZtBmScaqaAot69+fV6O0BnK8P/eGAmm/8V2NEsqhXmsDouMlRHRXi0fi5ZwcF0+
         s5s5kwjdxKoZAN2/RExCqC5txpgQWRZW6/650z4dJguGhGWbyvM+DX0xr9mSc0VVahMc
         7MxGqDg9Al/Psl6qSAfeLgI9qVoXzUOcnR6Q+aICSDwlM7KINS77tI4Vynoap8eEUXId
         rbIwieaGRAAF0eVzFfgI7UQPwGHN6HR3o2O6eoBhzM46RUWPu3LLEc++9OEO7TDf6aFP
         fdmtvKiUv9Dqzsmt0CYsFNRfeqwvq7H+8LcPhy8epy5D850bvuSBudklzkliE+Jixh7V
         sbXw==
X-Gm-Message-State: AC+VfDyYoaKVEphFd79KXSECBr4pAUrt0J60iQ1pczR769nj1m8mcLFJ
        Vy1ryh81ocfVDIYiO/EXcCVWog==
X-Google-Smtp-Source: ACHHUZ7HPZHU/c0SUjH6d0BWcOB8eLdBcSfh1g/VsYEO0pbi+eAMTALQvB8Hsf5hIiR7CjUOpnbz8A==
X-Received: by 2002:a81:6ec5:0:b0:561:e944:a559 with SMTP id j188-20020a816ec5000000b00561e944a559mr9577004ywc.31.1684732652960;
        Sun, 21 May 2023 22:17:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e129-20020a0dc287000000b00545a08184f8sm1818483ywd.136.2023.05.21.22.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:17:32 -0700 (PDT)
Date:   Sun, 21 May 2023 22:17:29 -0700 (PDT)
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
Subject: [PATCH 21/31] mm/madvise: clean up force_shm_swapin_readahead()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <f098a89f-35a4-8aa2-3abb-7f2480e2291e@google.com>
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

Some nearby MADV_WILLNEED cleanup unrelated to pte_offset_map_lock().
shmem_swapin_range() is a better name than force_shm_swapin_readahead().
Fix unimportant off-by-one on end_index.  Call the swp_entry_t "entry"
rather than "swap": either is okay, but entry is the name used elsewhere
in mm/madvise.c.  Do not assume GFP_HIGHUSER_MOVABLE: that's right for
anon swap, but shmem should take gfp from mapping.  Pass the actual vma
and address to read_swap_cache_async(), in case a NUMA mempolicy applies.
lru_add_drain() at outer level, like madvise_willneed()'s other branch.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/madvise.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0af64c4a8f82..9b3c9610052f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -235,30 +235,34 @@ static const struct mm_walk_ops swapin_walk_ops = {
 	.pmd_entry		= swapin_walk_pmd_entry,
 };
 
-static void force_shm_swapin_readahead(struct vm_area_struct *vma,
+static void shmem_swapin_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end,
 		struct address_space *mapping)
 {
 	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
-	pgoff_t end_index = linear_page_index(vma, end + PAGE_SIZE - 1);
+	pgoff_t end_index = linear_page_index(vma, end) - 1;
 	struct page *page;
 	struct swap_iocb *splug = NULL;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_index) {
-		swp_entry_t swap;
+		unsigned long addr;
+		swp_entry_t entry;
 
 		if (!xa_is_value(page))
 			continue;
-		swap = radix_to_swp_entry(page);
+		entry = radix_to_swp_entry(page);
 		/* There might be swapin error entries in shmem mapping. */
-		if (non_swap_entry(swap))
+		if (non_swap_entry(entry))
 			continue;
+
+		addr = vma->vm_start +
+			((xas.xa_index - vma->vm_pgoff) << PAGE_SHIFT);
 		xas_pause(&xas);
 		rcu_read_unlock();
 
-		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
-					     NULL, 0, false, &splug);
+		page = read_swap_cache_async(entry, mapping_gfp_mask(mapping),
+					     vma, addr, false, &splug);
 		if (page)
 			put_page(page);
 
@@ -266,8 +270,6 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	}
 	rcu_read_unlock();
 	swap_read_unplug(splug);
-
-	lru_add_drain();	/* Push any new pages onto the LRU now */
 }
 #endif		/* CONFIG_SWAP */
 
@@ -291,8 +293,8 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	}
 
 	if (shmem_mapping(file->f_mapping)) {
-		force_shm_swapin_readahead(vma, start, end,
-					file->f_mapping);
+		shmem_swapin_range(vma, start, end, file->f_mapping);
+		lru_add_drain(); /* Push any new pages onto the LRU now */
 		return 0;
 	}
 #else
-- 
2.35.3

