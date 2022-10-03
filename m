Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C15F340E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJCRBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJCRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:00:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C027232;
        Mon,  3 Oct 2022 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=64kmJcmlBNcd7ZVRV9QGbQ+ehy4GBcry+YjVTQEY9ZY=; b=rv8+76aX7O4tLP53vdvVbSgLsh
        Ps1cX0t9eK2DvO6xyMeO6QUPo3HVV0n1wVOWpJon/jezexdruEWrCEkTScFzJTqT6uvxo2apBU7dP
        4DSkdQ69bxyqOZSM2CSXnl6CbtKLIe0RnVr5eWy2E4qbJNW7J2p9NOzdf0YTvZaUzMeVoE5PMrAyo
        Szs8qpwYp5Rk15Xu10RiQJyp6utdfD26w55CoyFejNvE2i+8LSNv0qLuSxRVsmRDOYhgiAkcZxaGm
        dWCHMkYop+s4O3DKxueYveZFwZUbfl0qqmuI5HAEjHQjcqZjdGOHTCCSuHan2jN+cztvSs66tDGRB
        xr0ZMb0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofOnz-00GXjv-86; Mon, 03 Oct 2022 17:00:35 +0000
Date:   Mon, 3 Oct 2022 18:00:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzsVM8eToHUeTP75@casper.infradead.org>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <YzkmErHFyYW3awRn@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzkmErHFyYW3awRn@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 02:48:02PM +0900, Hyeonggon Yoo wrote:
> Just one more thing, rcu_leak_callback too. RCU seem to use it
> internally to catch double call_rcu().
> 
> And some suggestions:
> - what about adding runtime WARN() on slab init code to catch
>   unexpected arch/toolchain issues?
> - instead of 4, we may use macro definition? like (PAGE_MAPPING_FLAGS + 1)?

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

diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..a65598308c83 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -59,6 +59,7 @@
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
+	struct folio *folio = page_folio(page);
 	const struct movable_operations *mops;
 
 	/*
@@ -70,16 +71,23 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
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
+	if (unlikely(folio_test_slab(folio)))
+		goto out_put;
+
 	/*
 	 * As movable pages are not isolated from LRU lists, concurrent
 	 * compaction threads can race against page migration functions
@@ -91,8 +99,8 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * lets be sure we have the page lock
 	 * before proceeding with the movable page isolation steps.
 	 */
-	if (unlikely(!trylock_page(page)))
-		goto out_putpage;
+	if (unlikely(!folio_trylock(folio)))
+		goto out_put;
 
 	if (!PageMovable(page) || PageIsolated(page))
 		goto out_no_isolated;
@@ -106,14 +114,14 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
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
