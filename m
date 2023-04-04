Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288F6D5FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjDDMBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjDDMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:01:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA130DB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:01:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u10so31030247plz.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680609694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOz9ZvZBBEKBeMMkHNXogZGyfPp/Ut91O6nybFFIxig=;
        b=LpKJkwC/Xvom7WI58Uh3lqj2ua0zYirTPTwcp394etxw0rK3IwhkM96vdC6V3HusTq
         goPgMnjzSxw+XBSabm8XtESIEkMpOPmHzi9fwkbw9wzsV9CXLyzpw728M3cSAQEtzgO4
         cG2js/CXkOtBJhMLfCxTPgx3KpeWs3kP21T+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOz9ZvZBBEKBeMMkHNXogZGyfPp/Ut91O6nybFFIxig=;
        b=ZlZV6ezLBA86pNN2Ofae+VxGBKKK3TtnR43ADCKqp/fqWuIwPTmFvY8qhBgYG/7uoA
         ywT9lMQ0VAutcLBflRUtwP03AUl9xD0iXvCX94FD92m0Px0WnX078gy1U95EqX1+UEk7
         zgApDwMhsElGEuEM6CtV2oKPh9q47bqHaomhIZv8WmRRBKF4EvPMxP0DRAKHXm8FBIt4
         lyP0Y7z6W+SdXUvgp14QoUrMvJBGV2Ezbd6pRIOJwvNHkBflYEfNJgLs605qXKzkQ0+f
         7KkgoL5pgJhByy22ZyiQMjGxU8KX82NE6RzDUOoY6jiP9cIs5++F9/MNFrc5zgqtFvDt
         1Wiw==
X-Gm-Message-State: AAQBX9fZdCneuJy0buQHuKkLvoibKiRWclZA8zcbK4fqvG3EhJPonYkl
        Zw1RSTmS09WbjqiN/gkTn8USZg==
X-Google-Smtp-Source: AKy350YMLghR1MHGUC8Rhnn9F5I2hBH6L2PbmBMQmf2fM+UAqA1gmblC6yVFeYDBpiXa/jdBNsdClg==
X-Received: by 2002:a17:90b:1b06:b0:234:ba34:71bf with SMTP id nu6-20020a17090b1b0600b00234ba3471bfmr2848124pjb.1.1680609694233;
        Tue, 04 Apr 2023 05:01:34 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:959b:21ea:166b:c273])
        by smtp.gmail.com with UTF8SMTPSA id s17-20020a63d051000000b0051322a5aa64sm7658703pgi.3.2023.04.04.05.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:01:33 -0700 (PDT)
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
Subject: [PATCH v6 2/4] mm/khugepaged: refactor collapse_file control flow
Date:   Tue,  4 Apr 2023 21:01:15 +0900
Message-Id: <20230404120117.2562166-3-stevensd@google.com>
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

Add a rollback label to deal with failure, instead of continuously
checking for RESULT_SUCCESS, to make it easier to add more failure
cases. The refactoring also allows the collapse_file tracepoint to
include hpage on success (instead of NULL).

Signed-off-by: David Stevens <stevensd@chromium.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 230 ++++++++++++++++++++++++------------------------
 1 file changed, 113 insertions(+), 117 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 90577247cfaf..90828272a065 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1890,6 +1890,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (result != SCAN_SUCCEED)
 		goto out;
 
+	__SetPageLocked(hpage);
+	if (is_shmem)
+		__SetPageSwapBacked(hpage);
+	hpage->index = start;
+	hpage->mapping = mapping;
+
 	/*
 	 * Ensure we have slots for all the pages in the range.  This is
 	 * almost certainly a no-op because most of the pages must be present
@@ -1902,16 +1908,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		xas_unlock_irq(&xas);
 		if (!xas_nomem(&xas, GFP_KERNEL)) {
 			result = SCAN_FAIL;
-			goto out;
+			goto rollback;
 		}
 	} while (1);
 
-	__SetPageLocked(hpage);
-	if (is_shmem)
-		__SetPageSwapBacked(hpage);
-	hpage->index = start;
-	hpage->mapping = mapping;
-
 	/*
 	 * At this point the hpage is locked and not up-to-date.
 	 * It's safe to insert it into the page cache, because nobody would
@@ -2137,137 +2137,133 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	 */
 	try_to_unmap_flush();
 
-	if (result == SCAN_SUCCEED) {
-		/*
-		 * Replacing old pages with new one has succeeded, now we
-		 * attempt to copy the contents.
-		 */
-		index = start;
-		list_for_each_entry(page, &pagelist, lru) {
-			while (index < page->index) {
-				clear_highpage(hpage + (index % HPAGE_PMD_NR));
-				index++;
-			}
-			if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR),
-					     page) > 0) {
-				result = SCAN_COPY_MC;
-				break;
-			}
-			index++;
-		}
-		while (result == SCAN_SUCCEED && index < end) {
+	if (result != SCAN_SUCCEED)
+		goto rollback;
+
+	/*
+	 * Replacing old pages with new one has succeeded, now we
+	 * attempt to copy the contents.
+	 */
+	index = start;
+	list_for_each_entry(page, &pagelist, lru) {
+		while (index < page->index) {
 			clear_highpage(hpage + (index % HPAGE_PMD_NR));
 			index++;
 		}
+		if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR), page) > 0) {
+			result = SCAN_COPY_MC;
+			goto rollback;
+		}
+		index++;
+	}
+	while (index < end) {
+		clear_highpage(hpage + (index % HPAGE_PMD_NR));
+		index++;
+	}
+
+	/*
+	 * Copying old pages to huge one has succeeded, now we
+	 * need to free the old pages.
+	 */
+	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
+		list_del(&page->lru);
+		page->mapping = NULL;
+		page_ref_unfreeze(page, 1);
+		ClearPageActive(page);
+		ClearPageUnevictable(page);
+		unlock_page(page);
+		put_page(page);
 	}
 
 	nr = thp_nr_pages(hpage);
-	if (result == SCAN_SUCCEED) {
-		/*
-		 * Copying old pages to huge one has succeeded, now we
-		 * need to free the old pages.
-		 */
-		list_for_each_entry_safe(page, tmp, &pagelist, lru) {
-			list_del(&page->lru);
-			page->mapping = NULL;
-			page_ref_unfreeze(page, 1);
-			ClearPageActive(page);
-			ClearPageUnevictable(page);
-			unlock_page(page);
-			put_page(page);
-		}
+	xas_lock_irq(&xas);
+	if (is_shmem)
+		__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
+	else
+		__mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
 
-		xas_lock_irq(&xas);
-		if (is_shmem)
-			__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
-		else
-			__mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
+	if (nr_none) {
+		__mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
+		/* nr_none is always 0 for non-shmem. */
+		__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
+	}
+	/* Join all the small entries into a single multi-index entry. */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, hpage);
+	xas_unlock_irq(&xas);
 
-		if (nr_none) {
-			__mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
-			/* nr_none is always 0 for non-shmem. */
-			__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
-		}
-		/* Join all the small entries into a single multi-index entry. */
-		xas_set_order(&xas, start, HPAGE_PMD_ORDER);
-		xas_store(&xas, hpage);
-		xas_unlock_irq(&xas);
+	folio = page_folio(hpage);
+	folio_mark_uptodate(folio);
+	folio_ref_add(folio, HPAGE_PMD_NR - 1);
 
-		folio = page_folio(hpage);
-		folio_mark_uptodate(folio);
-		folio_ref_add(folio, HPAGE_PMD_NR - 1);
+	if (is_shmem)
+		folio_mark_dirty(folio);
+	folio_add_lru(folio);
 
-		if (is_shmem)
-			folio_mark_dirty(folio);
-		folio_add_lru(folio);
+	/*
+	 * Remove pte page tables, so we can re-fault the page as huge.
+	 */
+	result = retract_page_tables(mapping, start, mm, addr, hpage,
+				     cc);
+	unlock_page(hpage);
+	goto out;
+
+rollback:
+	/* Something went wrong: roll back page cache changes */
+	xas_lock_irq(&xas);
+	if (nr_none) {
+		mapping->nrpages -= nr_none;
+		shmem_uncharge(mapping->host, nr_none);
+	}
 
-		/*
-		 * Remove pte page tables, so we can re-fault the page as huge.
-		 */
-		result = retract_page_tables(mapping, start, mm, addr, hpage,
-					     cc);
-		unlock_page(hpage);
-		hpage = NULL;
-	} else {
-		/* Something went wrong: roll back page cache changes */
-		xas_lock_irq(&xas);
-		if (nr_none) {
-			mapping->nrpages -= nr_none;
-			shmem_uncharge(mapping->host, nr_none);
+	xas_set(&xas, start);
+	xas_for_each(&xas, page, end - 1) {
+		page = list_first_entry_or_null(&pagelist,
+				struct page, lru);
+		if (!page || xas.xa_index < page->index) {
+			if (!nr_none)
+				break;
+			nr_none--;
+			/* Put holes back where they were */
+			xas_store(&xas, NULL);
+			continue;
 		}
 
-		xas_set(&xas, start);
-		xas_for_each(&xas, page, end - 1) {
-			page = list_first_entry_or_null(&pagelist,
-					struct page, lru);
-			if (!page || xas.xa_index < page->index) {
-				if (!nr_none)
-					break;
-				nr_none--;
-				/* Put holes back where they were */
-				xas_store(&xas, NULL);
-				continue;
-			}
+		VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
 
-			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
-
-			/* Unfreeze the page. */
-			list_del(&page->lru);
-			page_ref_unfreeze(page, 2);
-			xas_store(&xas, page);
-			xas_pause(&xas);
-			xas_unlock_irq(&xas);
-			unlock_page(page);
-			putback_lru_page(page);
-			xas_lock_irq(&xas);
-		}
-		VM_BUG_ON(nr_none);
+		/* Unfreeze the page. */
+		list_del(&page->lru);
+		page_ref_unfreeze(page, 2);
+		xas_store(&xas, page);
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		unlock_page(page);
+		putback_lru_page(page);
+		xas_lock_irq(&xas);
+	}
+	VM_BUG_ON(nr_none);
+	/*
+	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM
+	 * file only. This undo is not needed unless failure is
+	 * due to SCAN_COPY_MC.
+	 */
+	if (!is_shmem && result == SCAN_COPY_MC) {
+		filemap_nr_thps_dec(mapping);
 		/*
-		 * Undo the updates of filemap_nr_thps_inc for non-SHMEM
-		 * file only. This undo is not needed unless failure is
-		 * due to SCAN_COPY_MC.
+		 * Paired with smp_mb() in do_dentry_open() to
+		 * ensure the update to nr_thps is visible.
 		 */
-		if (!is_shmem && result == SCAN_COPY_MC) {
-			filemap_nr_thps_dec(mapping);
-			/*
-			 * Paired with smp_mb() in do_dentry_open() to
-			 * ensure the update to nr_thps is visible.
-			 */
-			smp_mb();
-		}
+		smp_mb();
+	}
 
-		xas_unlock_irq(&xas);
+	xas_unlock_irq(&xas);
 
-		hpage->mapping = NULL;
-	}
+	hpage->mapping = NULL;
 
-	if (hpage)
-		unlock_page(hpage);
+	unlock_page(hpage);
+	put_page(hpage);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	if (hpage)
-		put_page(hpage);
-
 	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
 	return result;
 }
-- 
2.40.0.348.gf938b09366-goog

