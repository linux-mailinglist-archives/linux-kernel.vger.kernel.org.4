Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0086605CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbjAFRk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjAFRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:40:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4C7DE35
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:40:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 440E2CE1D8D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27124C433F0;
        Fri,  6 Jan 2023 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026842;
        bh=cHvb4Vehgiz+i9jP3UmTQ1hcTa3cMG0+RNH66KZZupg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlP6RQhZERq4T5nw+s83wXPjEzQ1POOMyZB06pm0+LABO/jSGs600mUTQCYSN4fFz
         Dko/3tAdYvbpVuT5SpObb3AnmEdrUu0BUUDNhQC11D6+E1t2AJ7d4kj7PtwwbTWFW/
         lwDnadWc6GT+89qA4JPg3Nm1BBOuY0MBIi1kdz1+LMODHH7pcDIZndVDLIVXMGB2cR
         qMRUsLddFzA8wCI1cxGJ7OPW0tdUXmV/n8OOIv4O6Y+vzlklCKglnb7CoyGHl5pTpy
         0YFgFw3Qzb8YrEzAdzKQx15I0BVqJil4JIlLZpqs/YE4616rzUmhr2qF4jBO0ti+0p
         a5k51guE738/g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: use folio_headpage() instead of folio_page()
Date:   Fri,  6 Jan 2023 17:40:27 +0000
Message-Id: <20230106174028.151384-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106174028.151384-1-sj@kernel.org>
References: <20230106174028.151384-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several code in mm is using 'folio_page(folio, 0)' for getting the head
pages of folios.  It's not the standard idiom and inefficient.  Replace
the calls to 'folio_headpage()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/shmem.c       | 4 ++--
 mm/slab.c        | 6 +++---
 mm/slab_common.c | 4 ++--
 mm/slub.c        | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index bc5c156ef470..8ae73973a7fc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3211,7 +3211,7 @@ static const char *shmem_get_link(struct dentry *dentry,
 		folio = filemap_get_folio(inode->i_mapping, 0);
 		if (!folio)
 			return ERR_PTR(-ECHILD);
-		if (PageHWPoison(folio_page(folio, 0)) ||
+		if (PageHWPoison(folio_headpage(folio)) ||
 		    !folio_test_uptodate(folio)) {
 			folio_put(folio);
 			return ERR_PTR(-ECHILD);
@@ -3222,7 +3222,7 @@ static const char *shmem_get_link(struct dentry *dentry,
 			return ERR_PTR(error);
 		if (!folio)
 			return ERR_PTR(-ECHILD);
-		if (PageHWPoison(folio_page(folio, 0))) {
+		if (PageHWPoison(folio_headpage(folio))) {
 			folio_unlock(folio);
 			folio_put(folio);
 			return ERR_PTR(-ECHILD);
diff --git a/mm/slab.c b/mm/slab.c
index 7a269db050ee..a6f8f95678c9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1373,7 +1373,7 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 	/* Make the flag visible before any changes to folio->mapping */
 	smp_wmb();
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
-	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
+	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_headpage(folio)))
 		slab_set_pfmemalloc(slab);
 
 	return slab;
@@ -1389,7 +1389,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 
 	BUG_ON(!folio_test_slab(folio));
 	__slab_clear_pfmemalloc(slab);
-	page_mapcount_reset(folio_page(folio, 0));
+	page_mapcount_reset(folio_headpage(folio));
 	folio->mapping = NULL;
 	/* Make the mapping reset visible before clearing the flag */
 	smp_wmb();
@@ -1398,7 +1398,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += 1 << order;
 	unaccount_slab(slab, order, cachep);
-	__free_pages(folio_page(folio, 0), order);
+	__free_pages(folio_headpage(folio), order);
 }
 
 static void kmem_rcu_free(struct rcu_head *head)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bf4e777cfe90..34a0b9988d12 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -939,9 +939,9 @@ void free_large_kmalloc(struct folio *folio, void *object)
 	kasan_kfree_large(object);
 	kmsan_kfree_large(object);
 
-	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
+	mod_lruvec_page_state(folio_headpage(folio), NR_SLAB_UNRECLAIMABLE_B,
 			      -(PAGE_SIZE << order));
-	__free_pages(folio_page(folio, 0), order);
+	__free_pages(folio_headpage(folio), order);
 }
 
 static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
diff --git a/mm/slub.c b/mm/slub.c
index 13459c69095a..1f0cbb4c2288 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1859,7 +1859,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	__folio_set_slab(folio);
 	/* Make the flag visible before any changes to folio->mapping */
 	smp_wmb();
-	if (page_is_pfmemalloc(folio_page(folio, 0)))
+	if (page_is_pfmemalloc(folio_headpage(folio)))
 		slab_set_pfmemalloc(slab);
 
 	return slab;
@@ -2066,7 +2066,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += pages;
 	unaccount_slab(slab, order, s);
-	__free_pages(folio_page(folio, 0), order);
+	__free_pages(folio_headpage(folio), order);
 }
 
 static void rcu_free_slab(struct rcu_head *h)
-- 
2.25.1

