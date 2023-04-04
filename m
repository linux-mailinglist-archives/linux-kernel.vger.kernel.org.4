Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A56D5FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjDDMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjDDMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:01:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05B3C03
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:01:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso33699775pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680609704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyhfi+1sWMxl+7ZSluYYXlOU9BFaVL7c1FFz74Xev1Y=;
        b=cpPgK8/nWgVUBBTA+Q+NHmPq/3BrBdxiVC2lvjhc5fGgylaFPc5/panj0rvENCI0Sh
         GGcuIYS+4UxwSAR2K0MukNoiOP1u4VJYUoTPIALoJ1eIGK9MyEaSkPQDH/xxCeN3oa1F
         cQPVr2GzWPoKMusf6zXvu113yINmDfSEd8s4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vyhfi+1sWMxl+7ZSluYYXlOU9BFaVL7c1FFz74Xev1Y=;
        b=5hjl6fHLeZ46hwY9p3kK7TksTK8AoGA2wWFnPAi8puQgG/X54asvVUyV4RqFgt3b2C
         FohFu0RyG8keWUXEDar85QoYhF0NTzwmj8hfgU7MySxyf1fbMs4HF3ti9FOWkhFjL+ak
         HV294Ltph7ZYo2AR1gec9IEaTYlYv653P7QbtEt6gKBPtZyVXECfu741f2lwl0+JKzYG
         mYUuZLgw8J5GjZaOEYQn9lNNUWxOQRc5Y7d3eu8Rqv25F267b2WLKsxwPIbquwR0EVA0
         ygDsE1KX8MnZhGpnj8gR40YJysogLKxKNQMskDXwVCQHnEk0SCLo1KKebEWP7LfY2bXD
         /IFA==
X-Gm-Message-State: AAQBX9cJz77X7NZhPRpwsAtrPx42cDJytwoQiTCbLrYjIswjiXZ0CgW9
        ehmBDkwXyVPhl+xRfj3P7c57Aw==
X-Google-Smtp-Source: AKy350ZGp0by7zBEDeJP7f167x6LyxoDREyVG0zApneHT5l/sdT8Kwof8HJrTkmCawNC1ggmn03V2g==
X-Received: by 2002:a17:90b:3b8a:b0:237:161d:f5ac with SMTP id pc10-20020a17090b3b8a00b00237161df5acmr2422009pjb.36.1680609703010;
        Tue, 04 Apr 2023 05:01:43 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:959b:21ea:166b:c273])
        by smtp.gmail.com with UTF8SMTPSA id e5-20020a170902744500b0019ee045a2b3sm8193256plt.308.2023.04.04.05.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:01:42 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 4/4] mm/khugepaged: maintain page cache uptodate flag
Date:   Tue,  4 Apr 2023 21:01:17 +0900
Message-Id: <20230404120117.2562166-5-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230404120117.2562166-1-stevensd@google.com>
References: <20230404120117.2562166-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Make sure that collapse_file doesn't interfere with checking the
uptodate flag in the page cache by only inserting hpage into the page
cache after it has been updated and marked uptodate. This is achieved by
simply not replacing present pages with hpage when iterating over the
target range.

The present pages are already locked, so replacing them with the locked
hpage before the collapse is finalized is unnecessary. However, it is
necessary to stop freezing the present pages after validating them,
since leaving long-term frozen pages in the page cache can lead to
deadlocks. Simply checking the reference count is sufficient to ensure
that there are no long-term references hanging around that would the
collapse would break. Similar to hpage, there is no reason that the
present pages actually need to be frozen in addition to being locked.

This fixes a race where folio_seek_hole_data would mistake hpage for
an fallocated but unwritten page. This race is visible to userspace via
data temporarily disappearing from SEEK_DATA/SEEK_HOLE. This also fixes
a similar race where pages could temporarily disappear from mincore.

Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 mm/khugepaged.c | 79 ++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 50 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7679551e9540..a19aa140fd52 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1855,17 +1855,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
  *
  * Basic scheme is simple, details are more complex:
  *  - allocate and lock a new huge page;
- *  - scan page cache replacing old pages with the new one
+ *  - scan page cache, locking old pages
  *    + swap/gup in pages if necessary;
- *    + keep old pages around in case rollback is required;
+ *  - copy data to new page
+ *  - handle shmem holes
+ *    + re-validate that holes weren't filled by someone else
+ *    + check for userfaultfd
  *  - finalize updates to the page cache;
  *  - if replacing succeeds:
- *    + copy data over;
- *    + free old pages;
  *    + unlock huge page;
+ *    + free old pages;
  *  - if replacing failed;
- *    + put all pages back and unfreeze them;
- *    + restore gaps in the page cache;
+ *    + unlock old pages
  *    + unlock and free huge page;
  */
 static int collapse_file(struct mm_struct *mm, unsigned long addr,
@@ -1913,12 +1914,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	} while (1);
 
-	/*
-	 * At this point the hpage is locked and not up-to-date.
-	 * It's safe to insert it into the page cache, because nobody would
-	 * be able to map it or use it in another way until we unlock it.
-	 */
-
 	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
 		page = xas_next(&xas);
@@ -2076,12 +2071,16 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
 
 		/*
-		 * The page is expected to have page_count() == 3:
+		 * We control three references to the page:
 		 *  - we hold a pin on it;
 		 *  - one reference from page cache;
 		 *  - one from isolate_lru_page;
+		 * If those are the only references, then any new usage of the
+		 * page will have to fetch it from the page cache. That requires
+		 * locking the page to handle truncate, so any new usage will be
+		 * blocked until we unlock page after collapse/during rollback.
 		 */
-		if (!page_ref_freeze(page, 3)) {
+		if (page_count(page) != 3) {
 			result = SCAN_PAGE_COUNT;
 			xas_unlock_irq(&xas);
 			putback_lru_page(page);
@@ -2089,13 +2088,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		/*
-		 * Add the page to the list to be able to undo the collapse if
-		 * something go wrong.
+		 * Accumulate the pages that are being collapsed.
 		 */
 		list_add_tail(&page->lru, &pagelist);
-
-		/* Finally, replace with the new page. */
-		xas_store(&xas, hpage);
 		continue;
 out_unlock:
 		unlock_page(page);
@@ -2132,8 +2127,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		goto rollback;
 
 	/*
-	 * Replacing old pages with new one has succeeded, now we
-	 * attempt to copy the contents.
+	 * The old pages are locked, so they won't change anymore.
 	 */
 	index = start;
 	list_for_each_entry(page, &pagelist, lru) {
@@ -2222,11 +2216,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		/* nr_none is always 0 for non-shmem. */
 		__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
 	}
-	/* Join all the small entries into a single multi-index entry. */
-	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
-	xas_store(&xas, hpage);
-	xas_unlock_irq(&xas);
 
+	/*
+	 * Mark hpage as uptodate before inserting it into the page cache so
+	 * that it isn't mistaken for an fallocated but unwritten page.
+	 */
 	folio = page_folio(hpage);
 	folio_mark_uptodate(folio);
 	folio_ref_add(folio, HPAGE_PMD_NR - 1);
@@ -2235,6 +2229,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		folio_mark_dirty(folio);
 	folio_add_lru(folio);
 
+	/* Join all the small entries into a single multi-index entry. */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, hpage);
+	xas_unlock_irq(&xas);
+
 	/*
 	 * Remove pte page tables, so we can re-fault the page as huge.
 	 */
@@ -2248,47 +2247,29 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
 		list_del(&page->lru);
 		page->mapping = NULL;
-		page_ref_unfreeze(page, 1);
 		ClearPageActive(page);
 		ClearPageUnevictable(page);
 		unlock_page(page);
-		put_page(page);
+		folio_put_refs(page_folio(page), 3);
 	}
 
 	goto out;
 
 rollback:
 	/* Something went wrong: roll back page cache changes */
-	xas_lock_irq(&xas);
 	if (nr_none) {
+		xas_lock_irq(&xas);
 		mapping->nrpages -= nr_none;
 		shmem_uncharge(mapping->host, nr_none);
+		xas_unlock_irq(&xas);
 	}
 
-	xas_set(&xas, start);
-	end = index;
-	for (index = start; index < end; index++) {
-		xas_next(&xas);
-		page = list_first_entry_or_null(&pagelist,
-				struct page, lru);
-		if (!page || xas.xa_index < page->index) {
-			nr_none--;
-			continue;
-		}
-
-		VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
-
-		/* Unfreeze the page. */
+	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
 		list_del(&page->lru);
-		page_ref_unfreeze(page, 2);
-		xas_store(&xas, page);
-		xas_pause(&xas);
-		xas_unlock_irq(&xas);
 		unlock_page(page);
 		putback_lru_page(page);
-		xas_lock_irq(&xas);
+		put_page(page);
 	}
-	VM_BUG_ON(nr_none);
 	/*
 	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM
 	 * file only. This undo is not needed unless failure is
@@ -2303,8 +2284,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		smp_mb();
 	}
 
-	xas_unlock_irq(&xas);
-
 	hpage->mapping = NULL;
 
 	unlock_page(hpage);
-- 
2.40.0.348.gf938b09366-goog

