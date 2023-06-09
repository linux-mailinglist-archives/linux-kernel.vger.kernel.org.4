Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73002728D23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjFIBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjFIBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:35:21 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB52D68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:35:19 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565bd368e19so10878147b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274519; x=1688866519;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzsL+M6cdepZgQw4hIUfWIci6E11MaKNkaWhV1yArkY=;
        b=Sak7mjF34nMHTvCHP5NeKRtkES8TSscUHlyC9R0R46SCrhEJJ2Wo+n7dfWrX77uQe8
         nf+QSJZI16aTp4GUl6IGu9WutySoxO4BhydtYaduPdP51lxLi8Eo7UzEJvf+9zsLlQKg
         1uAWQEdqAQK63Qji2NQKBkmHFaElkPHhKBew+iyAcD1FGdj+qH73dMkXTiCWxIZUVbNy
         fXN+aUpQp9yRvXbnP1DZhFGyMAkNlSUaOV8BRQ3aucz5IbMfcsCH3z+WaSedYI9tzU4M
         sRC3DhkA8g6Vrf7EurgcGfyAeEcYsIRAt7OjP2hbNUKH6TRoKes6M9tBjy+ai0vdg3/i
         pdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274519; x=1688866519;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzsL+M6cdepZgQw4hIUfWIci6E11MaKNkaWhV1yArkY=;
        b=jz8bfDKuaI078HJ+V6g9I9mQKdgBOwYxXI3uRPeWVrH+h2nZC8QWOOTlSwKyzzE4iz
         al9sAFr0+ELYO2mapanjT+vpfujxvbZa/NcnPnQbuas9t2s3F4NLcazb8DR8i3fw2Klx
         /GhxSIN3YEzBccOmgIGvwWI3ejQyQ8VTr0McUX+dcS0OoRCzgT4juPcNibsBKL7w5Z3B
         MNIhtSof1JwmHzc5JozeRWZMyqsB4w6DqIb1wsVMdhuiBxr2nQIU1W1ATrM4pn8QMxsI
         4265v1otk3skhCrMt87wiReK3qedTaknpqlfknusEFYz5nxRreUfQ4G4SwSBPGwbbuz/
         hlJg==
X-Gm-Message-State: AC+VfDwWuNUvmBjSyliR6ELuMe1zqkyxlGBK4FxMgPCgvh4DDXgc9WPM
        VLY8spZn0dydJ4Hhh/1F15pNew==
X-Google-Smtp-Source: ACHHUZ4AK/lYHw0bDyLVKmEksYxVFlrDP4tGf35FRUzn6cSvs6hJCxMo87mkPkKs2nriI5iLhLUP+g==
X-Received: by 2002:a81:4e04:0:b0:568:ea0e:ae75 with SMTP id c4-20020a814e04000000b00568ea0eae75mr1286809ywb.45.1686274518944;
        Thu, 08 Jun 2023 18:35:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s4-20020a81bf44000000b0054601ee157fsm283836ywk.114.2023.06.08.18.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:35:18 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:35:14 -0700 (PDT)
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
Subject: [PATCH v2 21/32] mm/madvise: clean up force_shm_swapin_readahead()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <67e18875-ffb3-ec27-346-f350e07bed87@google.com>
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

