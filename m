Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D753268C65C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBFTCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:02:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92822005
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oaeAqB8bAOsBTw4haHM9OiDiD9bOnihJ7tlzKd8np0k=; b=qu2dKo+WuYPM/VeCSrvfqsGk2G
        L7iUFottcUkJkEPlds5LQxVic7gyxsaqcBdQX8io+a9cylFcsAawCeqTv8HnffTZK0yS76Fqnha47
        Myh9E6FxPxlbBMotZmRoy2Z10URkmSQ67riBYuHogySAOCusWfUlnZhB4gbb0IhPk1CTJq1OknU7B
        XVJ1XZWx1Dg54+DwgKi12VV8oRE/LybiuH8ZL/DV+/MmwzkHxFCs6ovzNIYOw7bFi2tMxNINdjzXc
        eCfPysCANlkkRVcCmplgpYPRweIAhCF+VtiFRUiXj4gLSRV3UeqET4KSoVcFbh3xGfg4zAQjYBCl9
        IY29578g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP6kF-00H0bj-Pw; Mon, 06 Feb 2023 19:01:39 +0000
Date:   Mon, 6 Feb 2023 19:01:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+FOk+ty7OKmkwLL@casper.infradead.org>
References: <20230206112856.1802547-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206112856.1802547-1-stevensd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> This change first makes sure that the intermediate page cache state
> during collapse is not visible by moving when gaps are filled to after
> the page cache lock is acquired for the final time. This is necessary
> because the synchronization provided by locking hpage is insufficient
> for functions which operate on the page cache without actually locking
> individual pages to examine their content (e.g. shmem_mfill_atomic_pte).

I've been a little scared of touching khugepaged because, well, look at
that function.  But if we are going to touch it, how about this patch
first?  It does _part_ of what you need by not filling in the holes,
but obviously not the part that looks at uffd.  

It leaves the old pages in-place and frozen.  I think this should be
safe, but I haven't booted it (not entirely sure what test I'd run
to prove that it's not broken)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eb38bd1b1b2f..cfd33dff7253 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1845,15 +1845,14 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
  *  - allocate and lock a new huge page;
  *  - scan page cache replacing old pages with the new one
  *    + swap/gup in pages if necessary;
- *    + fill in gaps;
+ *    + freeze the old pages
  *    + keep old pages around in case rollback is required;
  *  - if replacing succeeds:
  *    + copy data over;
  *    + free old pages;
  *    + unlock huge page;
  *  - if replacing failed;
- *    + put all pages back and unfreeze them;
- *    + restore gaps in the page cache;
+ *    + unfreeze old pages;
  *    + unlock and free huge page;
  */
 static int collapse_file(struct mm_struct *mm, unsigned long addr,
@@ -1930,7 +1929,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					result = SCAN_FAIL;
 					goto xa_locked;
 				}
-				xas_store(&xas, hpage);
 				nr_none++;
 				continue;
 			}
@@ -2081,8 +2079,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 */
 		list_add_tail(&page->lru, &pagelist);
 
-		/* Finally, replace with the new page. */
-		xas_store(&xas, hpage);
 		continue;
 out_unlock:
 		unlock_page(page);
@@ -2195,32 +2191,17 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			shmem_uncharge(mapping->host, nr_none);
 		}
 
-		xas_set(&xas, start);
-		xas_for_each(&xas, page, end - 1) {
+		list_for_each_entry_safe(page, tmp, &pagelist, lru) {
+			list_del(&page->lru);
 			page = list_first_entry_or_null(&pagelist,
 					struct page, lru);
-			if (!page || xas.xa_index < page->index) {
-				if (!nr_none)
-					break;
-				nr_none--;
-				/* Put holes back where they were */
-				xas_store(&xas, NULL);
-				continue;
-			}
-
-			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
 
 			/* Unfreeze the page. */
 			list_del(&page->lru);
 			page_ref_unfreeze(page, 2);
-			xas_store(&xas, page);
-			xas_pause(&xas);
-			xas_unlock_irq(&xas);
 			unlock_page(page);
 			putback_lru_page(page);
-			xas_lock_irq(&xas);
 		}
-		VM_BUG_ON(nr_none);
 		/*
 		 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
 		 * This undo is not needed unless failure is due to SCAN_COPY_MC.
