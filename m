Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D888B701829
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEMQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEMQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:16:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1851736
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=g6zgohTV8rNy+mjKshDHrwwHx/CwgsLh/xAFxsbESeo=; b=d6VNKZ9ApqzEBobr7ucnBzm5rY
        Bnxq99HNbc2xPMyw4ogJq4QfgKE9/2CjwcytMBPtpC1rnHfzivNM3O+YE1sWQan2bCHalIKX5x2U9
        YPuQ8er2r4jWCOw5Zx73V7JnnYi+TeooIUFZV0APlaC5X/OufICFBCX+EYMwenRFYAXLtzhYA+zFs
        mheTWwpBBZM0Nmw+r5NwHYOKMDFV7OIDAdXcMrS0V8wvqTb/iCVrspv6on/KO6M8twaeYSahcsvGG
        saVA4cP4Tq7hnSUTxqZBkzkux+raHkJx5JD+DSGpNNGyeLzR0Ik1qTnvUIyc6/6ROlB6QgAJJJIjV
        4iZt6Aig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxrug-001z2s-Vk; Sat, 13 May 2023 16:16:07 +0000
Date:   Sat, 13 May 2023 17:16:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        linux-mm@kvack.org
Subject: Futexes & Folios
Message-ID: <ZF+3xpmouwur4sVE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch which converts the futex code from using pages to using
folios.  I do have some questions.

 - I assume we really do want to base the key on the page offset of the
   futex in the file.  That is, it's not good enough to base the key
   on the folio's index because the folio can be split after setting up
   the key, and if it is we'd then fail to find the futex later.
 - In hugetlbfs, it doesn't matter whether the pgoff is based on base
   pages or huge page size -- as long as it's consistent between
   invocations, everything will work

(I have ideas about a get_user_folio() but those are not represented in
this patch)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 514e4582b863..adf7e2c1c8f4 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -222,7 +222,8 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
-	struct page *page, *tail;
+	struct page *page;
+	struct folio *folio;
 	struct address_space *mapping;
 	int err, ro = 0;
 
@@ -273,54 +274,52 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		err = 0;
 
 	/*
-	 * The treatment of mapping from this point on is critical. The page
-	 * lock protects many things but in this context the page lock
+	 * The treatment of mapping from this point on is critical. The folio
+	 * lock protects many things but in this context the folio lock
 	 * stabilizes mapping, prevents inode freeing in the shared
 	 * file-backed region case and guards against movement to swap cache.
 	 *
-	 * Strictly speaking the page lock is not needed in all cases being
-	 * considered here and page lock forces unnecessarily serialization
+	 * Strictly speaking the folio lock is not needed in all cases being
+	 * considered here and folio lock forces unnecessarily serialization.
 	 * From this point on, mapping will be re-verified if necessary and
-	 * page lock will be acquired only if it is unavoidable
+	 * folio lock will be acquired only if it is unavoidable
 	 *
-	 * Mapping checks require the head page for any compound page so the
-	 * head page and mapping is looked up now. For anonymous pages, it
-	 * does not matter if the page splits in the future as the key is
-	 * based on the address. For filesystem-backed pages, the tail is
-	 * required as the index of the page determines the key. For
-	 * base pages, there is no tail page and tail == page.
+	 * Mapping checks require the folio so it is looked up now. For
+	 * anonymous pages, it does not matter if the folio is split
+	 * in the future as the key is based on the address. For
+	 * filesystem-backed pages, the precise page is required as the
+	 * index of the page determines the key.
 	 */
-	tail = page;
-	page = compound_head(page);
-	mapping = READ_ONCE(page->mapping);
+	folio = page_folio(page);
+	mapping = READ_ONCE(folio->mapping);
 
 	/*
-	 * If page->mapping is NULL, then it cannot be a PageAnon
+	 * If folio->mapping is NULL, then it cannot be an anonymous
 	 * page; but it might be the ZERO_PAGE or in the gate area or
 	 * in a special mapping (all cases which we are happy to fail);
 	 * or it may have been a good file page when get_user_pages_fast
 	 * found it, but truncated or holepunched or subjected to
-	 * invalidate_complete_page2 before we got the page lock (also
+	 * invalidate_complete_page2 before we got the folio lock (also
 	 * cases which we are happy to fail).  And we hold a reference,
 	 * so refcount care in invalidate_inode_page's remove_mapping
 	 * prevents drop_caches from setting mapping to NULL beneath us.
 	 *
 	 * The case we do have to guard against is when memory pressure made
 	 * shmem_writepage move it from filecache to swapcache beneath us:
-	 * an unlikely race, but we do need to retry for page->mapping.
+	 * an unlikely race, but we do need to retry for folio->mapping.
 	 */
 	if (unlikely(!mapping)) {
 		int shmem_swizzled;
 
 		/*
-		 * Page lock is required to identify which special case above
-		 * applies. If this is really a shmem page then the page lock
+		 * Folio lock is required to identify which special case above
+		 * applies. If this is really a shmem page then the folio lock
 		 * will prevent unexpected transitions.
 		 */
-		lock_page(page);
-		shmem_swizzled = PageSwapCache(page) || page->mapping;
-		unlock_page(page);
-		put_page(page);
+		folio_lock(folio);
+		shmem_swizzled = folio_test_swapcache(folio) || folio->mapping;
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (shmem_swizzled)
 			goto again;
@@ -331,14 +330,14 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	/*
 	 * Private mappings are handled in a simple way.
 	 *
-	 * If the futex key is stored on an anonymous page, then the associated
+	 * If the futex key is stored in anonymous memory, then the associated
 	 * object is the mm which is implicitly pinned by the calling process.
 	 *
 	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
 	 * it's a read-only handle, it's expected that futexes attach to
 	 * the object not the particular process.
 	 */
-	if (PageAnon(page)) {
+	if (folio_test_anon(folio)) {
 		/*
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
@@ -357,10 +356,10 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 
 		/*
 		 * The associated futex object in this case is the inode and
-		 * the page->mapping must be traversed. Ordinarily this should
-		 * be stabilised under page lock but it's not strictly
+		 * the folio->mapping must be traversed. Ordinarily this should
+		 * be stabilised under folio lock but it's not strictly
 		 * necessary in this case as we just want to pin the inode, not
-		 * update the radix tree or anything like that.
+		 * update i_pages or anything like that.
 		 *
 		 * The RCU read lock is taken as the inode is finally freed
 		 * under RCU. If the mapping still matches expectations then the
@@ -368,9 +367,9 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		 */
 		rcu_read_lock();
 
-		if (READ_ONCE(page->mapping) != mapping) {
+		if (READ_ONCE(folio->mapping) != mapping) {
 			rcu_read_unlock();
-			put_page(page);
+			folio_put(folio);
 
 			goto again;
 		}
@@ -378,19 +377,19 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		inode = READ_ONCE(mapping->host);
 		if (!inode) {
 			rcu_read_unlock();
-			put_page(page);
+			folio_put(folio);
 
 			goto again;
 		}
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
 		key->shared.i_seq = get_inode_sequence_number(inode);
-		key->shared.pgoff = page_to_pgoff(tail);
+		key->shared.pgoff = folio->index + folio_page_idx(folio, page);
 		rcu_read_unlock();
 	}
 
 out:
-	put_page(page);
+	folio_put(folio);
 	return err;
 }
 

