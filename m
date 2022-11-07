Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8661FACC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiKGRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKGRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:06:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834011EED6;
        Mon,  7 Nov 2022 09:05:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C8E11F86C;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667840757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWjycHIf1fSEY4m1EHn+sUN2YmLp5Vnftx1jsDrRGXI=;
        b=kxzFyQGhSBAuYX3n5vugY5Y1QRoh5BV3g26LWmvLqWvL+G4qKvJ3XBBofnMtINeFd2bF5H
        7CejRIjqnhbPP0kkN1YSvz+BK6moFCDtlwFGDOYIXsczJ84EiAhExjcYYzpXM9CKH8HdCN
        oBNV8Ic1D6HYqSCaWDTGvuJqUvcZoBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667840757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWjycHIf1fSEY4m1EHn+sUN2YmLp5Vnftx1jsDrRGXI=;
        b=yRTYUHecqIiNuULs8LuFdpJ7HeC/EhwT6lAYv0dSjjqOZpf7JTBj+IAUFnKwzGa15nNh8r
        caIfQ/3exJcVyGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71CBC13AC7;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJQxG/U6aWOYfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Nov 2022 17:05:57 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH v2 2/3] mm/migrate: make isolate_movable_page() skip slab pages
Date:   Mon,  7 Nov 2022 18:05:53 +0100
Message-Id: <20221107170554.7869-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107170554.7869-1-vbabka@suse.cz>
References: <20221107170554.7869-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we want to rearrange struct slab fields to allow a larger
rcu_head. Afterwards, the page->mapping field will overlap with SLUB's "struct
list_head slab_list", where the value of prev pointer can become LIST_POISON2,
which is 0x122 + POISON_POINTER_DELTA.  Unfortunately the bit 1 being set can
confuse PageMovable() to be a false positive and cause a GPF as reported by lkp
[1].

To fix this, make isolate_movable_page() skip pages with the PageSlab flag set.
This is a bit tricky as we need to add memory barriers to SLAB and SLUB's page
allocation and freeing, and their counterparts to isolate_movable_page().

Based on my RFC from [2]. Added a comment update from Matthew's variant in [3]
and, as done there, moved the PageSlab checks to happen before trying to take
the page lock.

[1] https://lore.kernel.org/all/208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com/
[2] https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
[3] https://lore.kernel.org/all/YzsVM8eToHUeTP75@casper.infradead.org/

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/migrate.c | 15 ++++++++++++---
 mm/slab.c    |  6 +++++-
 mm/slub.c    |  6 +++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1379e1912772..959c99cff814 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -74,13 +74,22 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	if (unlikely(!get_page_unless_zero(page)))
 		goto out;
 
+	if (unlikely(PageSlab(page)))
+		goto out_putpage;
+	/* Pairs with smp_wmb() in slab freeing, e.g. SLUB's __free_slab() */
+	smp_rmb();
 	/*
-	 * Check PageMovable before holding a PG_lock because page's owner
-	 * assumes anybody doesn't touch PG_lock of newly allocated page
-	 * so unconditionally grabbing the lock ruins page's owner side.
+	 * Check movable flag before taking the page lock because
+	 * we use non-atomic bitops on newly allocated page flags so
+	 * unconditionally grabbing the lock ruins page's owner side.
 	 */
 	if (unlikely(!__PageMovable(page)))
 		goto out_putpage;
+	/* Pairs with smp_wmb() in slab allocation, e.g. SLUB's alloc_slab_page() */
+	smp_rmb();
+	if (unlikely(PageSlab(page)))
+		goto out_putpage;
+
 	/*
 	 * As movable pages are not isolated from LRU lists, concurrent
 	 * compaction threads can race against page migration functions
diff --git a/mm/slab.c b/mm/slab.c
index 59c8e28f7b6a..219beb48588e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1370,6 +1370,8 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 
 	account_slab(slab, cachep->gfporder, cachep, flags);
 	__folio_set_slab(folio);
+	/* Make the flag visible before any changes to folio->mapping */
+	smp_wmb();
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
 		slab_set_pfmemalloc(slab);
@@ -1387,9 +1389,11 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
 
 	BUG_ON(!folio_test_slab(folio));
 	__slab_clear_pfmemalloc(slab);
-	__folio_clear_slab(folio);
 	page_mapcount_reset(folio_page(folio, 0));
 	folio->mapping = NULL;
+	/* Make the mapping reset visible before clearing the flag */
+	smp_wmb();
+	__folio_clear_slab(folio);
 
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += 1 << order;
diff --git a/mm/slub.c b/mm/slub.c
index 99ba865afc4a..5e6519d5169c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1800,6 +1800,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 
 	slab = folio_slab(folio);
 	__folio_set_slab(folio);
+	/* Make the flag visible before any changes to folio->mapping */
+	smp_wmb();
 	if (page_is_pfmemalloc(folio_page(folio, 0)))
 		slab_set_pfmemalloc(slab);
 
@@ -2000,8 +2002,10 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	int pages = 1 << order;
 
 	__slab_clear_pfmemalloc(slab);
-	__folio_clear_slab(folio);
 	folio->mapping = NULL;
+	/* Make the mapping reset visible before clearing the flag */
+	smp_wmb();
+	__folio_clear_slab(folio);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += pages;
 	unaccount_slab(slab, order, s);
-- 
2.38.0

