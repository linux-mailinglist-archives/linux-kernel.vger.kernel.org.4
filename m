Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5724B60AFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiJXP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiJXP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:57:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6E10A7C4;
        Mon, 24 Oct 2022 07:52:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63C6A1FD90;
        Mon, 24 Oct 2022 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666622105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKoCEs/NIMmGGz78D37Uv7FlzJbEvAQk5mmtuntqJt4=;
        b=xrF4sqVk9o0y0leQUQeC7Sp8ASA+Wrpntl4WhjkbAxFq0t3SRQLnPtQhXHTPYoS0Ko056w
        ToV7F578JrC5YLBThZtkpJPLueAc92Aa9vzeMTUIk+rkiwDNhhkPuhOak2XFdE6pORVO5x
        W9pIcyhIt+Om5iFlxxO6AuKQzspOk5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666622105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKoCEs/NIMmGGz78D37Uv7FlzJbEvAQk5mmtuntqJt4=;
        b=lm/QxcHo3XUogiDvNsoobHk0W8FhF9IwtSs5E6mtaQexp0Ga+vlI1JMeamAzfcOjAnHBas
        ytEOt6kQdGMmLvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 428D913A79;
        Mon, 24 Oct 2022 14:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fJWMD5miVmOLJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Oct 2022 14:35:05 +0000
Message-ID: <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
Date:   Mon, 24 Oct 2022 16:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YzsVM8eToHUeTP75@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 19:00, Matthew Wilcox wrote:
> On Sun, Oct 02, 2022 at 02:48:02PM +0900, Hyeonggon Yoo wrote:
>> Just one more thing, rcu_leak_callback too. RCU seem to use it
>> internally to catch double call_rcu().
>> 
>> And some suggestions:
>> - what about adding runtime WARN() on slab init code to catch
>>   unexpected arch/toolchain issues?
>> - instead of 4, we may use macro definition? like (PAGE_MAPPING_FLAGS + 1)?
> 
> I think the real problem here is that isolate_movable_page() is
> insufficiently paranoid.  Looking at the gyrations that GUP and the
> page cache do to convince themselves that the page they got really is
> the page they wanted, there are a few missing pieces (eg checking that
> you actually got a refcount on _this_ page and not some random other
> page you were temporarily part of a compound page with).
> 
> This patch does three things:
> 
>  - Turns one of the comments into English.  There are some others
>    which I'm still scratching my head over.
>  - Uses a folio to help distinguish which operations are being done
>    to the head vs the specific page (this is somewhat an abuse of the
>    folio concept, but it's acceptable)
>  - Add the aforementioned check that we're actually operating on the
>    page that we think we want to be.
>  - Add a check that the folio isn't secretly a slab.
> 
> We could put the slab check in PageMapping and call it after taking
> the folio lock, but that seems pointless.  It's the acquisition of
> the refcount which stabilises the slab flag, not holding the lock.
> 

I would like to have a working safe version in -next, even if we are able
simplify it later thanks to frozen refcounts. I've made a formal patch of
yours, but I'm still convinced the slab check needs to be more paranoid so
it can't observe a false positive __folio_test_movable() while missing the
folio_test_slab(), hence I added the barriers as in my previous attempt [1].
Does that work for you and can I add your S-o-b?

[1] https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/

----8<----
From 1d481f279f07d332ea381dfd6247a292ad403ed6 Mon Sep 17 00:00:00 2001
From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 24 Oct 2022 16:11:27 +0200
Subject: [PATCH] mm/migrate: make isolate_movable_page() skip slab pages

In the next commit we want to rearrange struct slab fields to allow a
larger rcu_head. Afterwards, the page->mapping field will overlap
with SLUB's "struct list_head slab_list", where the value of prev
pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
Unfortunately the bit 1 being set can confuse PageMovable() to be a
false positive and cause a GPF as reported by lkp [1].

I think the real problem here is that isolate_movable_page() is
insufficiently paranoid.  Looking at the gyrations that GUP and the
page cache do to convince themselves that the page they got really is
the page they wanted, there are a few missing pieces (eg checking that
you actually got a refcount on _this_ page and not some random other
page you were temporarily part of a compound page with).

This patch does three things:

 - Turns one of the comments into English.  There are some others
   which I'm still scratching my head over.
 - Uses a folio to help distinguish which operations are being done
   to the head vs the specific page (this is somewhat an abuse of the
   folio concept, but it's acceptable)
 - Add the aforementioned check that we're actually operating on the
   page that we think we want to be.
 - Add a check that the folio isn't secretly a slab.

We could put the slab check in PageMapping and call it after taking
the folio lock, but that seems pointless.  It's the acquisition of
the refcount which stabilises the slab flag, not holding the lock.

[ vbabka@suse.cz: add memory barriers to SLAB and SLUB's page allocation
  and freeing, and their counterparts to isolate_movable_page(), to make
  the checks for folio_test_slab() and __folio_test_movable() SMP safe ]

[1] https://lore.kernel.org/all/208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/migrate.c | 38 ++++++++++++++++++++++++++------------
 mm/slab.c    |  6 +++++-
 mm/slub.c    |  6 +++++-
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1379e1912772..ad79e7c23db5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -60,6 +60,7 @@
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
+	struct folio *folio = page_folio(page);
 	const struct movable_operations *mops;
 
 	/*
@@ -71,16 +72,29 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * the put_page() at the end of this block will take care of
 	 * release this page, thus avoiding a nasty leakage.
 	 */
-	if (unlikely(!get_page_unless_zero(page)))
+	if (unlikely(!folio_try_get(folio)))
 		goto out;
 
+	/* Recheck the page is still part of the folio we just got */
+	if (unlikely(page_folio(page) != folio))
+		goto out_put;
+
+	if (unlikely(folio_test_slab(folio)))
+		goto out_put;
+	/* Pairs with smp_wmb() in slab freeing, e.g. SLUB's __free_slab() */
+	smp_rmb();
 	/*
-	 * Check PageMovable before holding a PG_lock because page's owner
-	 * assumes anybody doesn't touch PG_lock of newly allocated page
-	 * so unconditionally grabbing the lock ruins page's owner side.
+	 * Check movable flag before taking the folio lock because
+	 * we use non-atomic bitops on newly allocated page flags so
+	 * unconditionally grabbing the lock ruins page's owner side.
 	 */
-	if (unlikely(!__PageMovable(page)))
-		goto out_putpage;
+	if (unlikely(!__folio_test_movable(folio)))
+		goto out_put;
+	/* Pairs with smp_wmb() in slab allocation, e.g. SLUB's alloc_slab_page() */
+	smp_rmb();
+	if (unlikely(folio_test_slab(folio)))
+		goto out_put;
+
 	/*
 	 * As movable pages are not isolated from LRU lists, concurrent
 	 * compaction threads can race against page migration functions
@@ -92,8 +106,8 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * lets be sure we have the page lock
 	 * before proceeding with the movable page isolation steps.
 	 */
-	if (unlikely(!trylock_page(page)))
-		goto out_putpage;
+	if (unlikely(!folio_trylock(folio)))
+		goto out_put;
 
 	if (!PageMovable(page) || PageIsolated(page))
 		goto out_no_isolated;
@@ -107,14 +121,14 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	/* Driver shouldn't use PG_isolated bit of page->flags */
 	WARN_ON_ONCE(PageIsolated(page));
 	SetPageIsolated(page);
-	unlock_page(page);
+	folio_unlock(folio);
 
 	return 0;
 
 out_no_isolated:
-	unlock_page(page);
-out_putpage:
-	put_page(page);
+	folio_unlock(folio);
+out_put:
+	folio_put(folio);
 out:
 	return -EBUSY;
 }
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
index 157527d7101b..6dc17cb915c5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1800,6 +1800,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 
 	slab = folio_slab(folio);
 	__folio_set_slab(folio);
+	/* Make the flag visible before any changes to folio->mapping */
+	smp_wmb();
 	if (page_is_pfmemalloc(folio_page(folio, 0)))
 		slab_set_pfmemalloc(slab);
 
@@ -2008,8 +2010,10 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	}
 
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


