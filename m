Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB966366F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjAJAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjAJAvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:51:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57C13CD2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43E83B810A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7739BC433F1;
        Tue, 10 Jan 2023 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673311890;
        bh=ZkD0zLt3wxTu9MwbivHD8pT3t6f3+LNZvwgPZbqLBYM=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9RgmVvdGN+ViiTiOtKeeaNygTZ+LsDQPcm0/ew54Q3xDbePInVwH59ia8m889q6n
         9/UPQNU975cWluN5bdR9uNEWP7baKHQNRYeK8Kt7jlG3IjARfpyIjJ/FRooPCZIt02
         D5gokeG4Ev8T0ci/eeY+c/TQwmjk+orVMU9RK/aCwxOjtseDdlxsFnwuy8ObDDLhnh
         KJXQQGLTSlJrp+Z4eYiOjcFoSNDAHEVC6tZx7Y4uTXkISY7G5S5JP6BQ4kkkzABZ2N
         68mF0HJgCtL2g5gohnewrmfJyjJOkdZLmu1Bn3cwj9hjx+W2wK0EdvSTRH659OLx+j
         MYr582FjKWzbA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/sl{a,u}b: fix wrong usages of folio_page() for getting head pages
Date:   Tue, 10 Jan 2023 00:51:24 +0000
Message-Id: <20230110005124.1609-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

The standard idiom for getting head page of a given folio is
'&folio->page', but some are wrongly using 'folio_page(folio, 0)' for
the purpose.  Fix those to use the idiom.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/slab.c | 4 ++--
 mm/slub.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index b77be9c6d6b1..a5398676dc60 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1389,7 +1389,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 
 	BUG_ON(!folio_test_slab(folio));
 	__slab_clear_pfmemalloc(slab);
-	page_mapcount_reset(folio_page(folio, 0));
+	page_mapcount_reset(&folio->page);
 	folio->mapping = NULL;
 	/* Make the mapping reset visible before clearing the flag */
 	smp_wmb();
@@ -1398,7 +1398,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += 1 << order;
 	unaccount_slab(slab, order, cachep);
-	__free_pages(folio_page(folio, 0), order);
+	__free_pages(&folio->page, order);
 }
 
 static void kmem_rcu_free(struct rcu_head *head)
diff --git a/mm/slub.c b/mm/slub.c
index 67020074ecb4..d5f20c062004 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2066,7 +2066,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += pages;
 	unaccount_slab(slab, order, s);
-	__free_pages(folio_page(folio, 0), order);
+	__free_pages(&folio->page, order);
 }
 
 static void rcu_free_slab(struct rcu_head *h)
-- 
2.25.1

