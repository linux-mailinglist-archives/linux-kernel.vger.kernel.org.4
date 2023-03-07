Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0566AD6B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCGFU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCGFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:20:54 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74453D81
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:20:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p6so6967879pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678166453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ8JLh1t+SQa8MFtRCjvqWkhYIqZz1dASMHutsA+ZIA=;
        b=CMO72NJkW0Gjo9VKTtSKmbPwn1x80TIoUa7QDwO/WtPJ3SB4S9uE4uELHTnI6cLvRr
         3/+EAcw807ziz5ELFf3PmVbEwRg4I0QT0bKP84kgt9Zew2qiUWL34pwhrz3umv9if16g
         EGPNFHXrFVzRkYWfFwOHqdM1K875EV6Hcx8KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678166453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ8JLh1t+SQa8MFtRCjvqWkhYIqZz1dASMHutsA+ZIA=;
        b=tZOOYQSK77+6rlEO5fKx4MEjwGmQe7T5W983TDJ8gGMKEmR99h70EGCBlGlRnUZUFH
         pazoRBtslr6HRpWfPJ8bqvuKuuGUYwS02ddbw03XFD8q2rTzxWApZ54Ie1pPbbKHYx6z
         pP+uBOZ/t8D+sUHsJyIb3hBGUIi89gv/6IjzjzUkasBTsSBVP9Yat1oIshSt+0DCgB2G
         tc4/uroYjC5LgyInBFwCNXAEQWrwA9SZAXU2Q90L+goeGlXynM70QxiUAyokLj2djdfn
         WPPFPTeMdx9mb3/o4MDFoI0y2c0VAKsYcgKOgzKIK3iBY39c92c2vSJvORXJhwtSCenG
         3WLA==
X-Gm-Message-State: AO0yUKUyP6WRR24nGggUXl+PkaRbtJODp9XChoZE+R/+aNHmYefjx3ie
        95zCOPwUv0ZDcucjfS1UmoOobQ==
X-Google-Smtp-Source: AK7set/WWK3FBlMA7qczOE6tpe9xjw7BHBGdOTgOWHL2+jS1vRIuoH1POzid1TxtaatIr6JYfANBWQ==
X-Received: by 2002:a62:1ad4:0:b0:5a8:d407:60f9 with SMTP id a203-20020a621ad4000000b005a8d40760f9mr10448268pfa.29.1678166453057;
        Mon, 06 Mar 2023 21:20:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f73:9034:ce28:4421])
        by smtp.gmail.com with UTF8SMTPSA id a4-20020aa78644000000b005a8ba70315bsm7096096pfo.6.2023.03.06.21.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:20:52 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 1/3] mm/khugepaged: refactor collapse_file control flow
Date:   Tue,  7 Mar 2023 14:20:34 +0900
Message-Id: <20230307052036.1520708-2-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230307052036.1520708-1-stevensd@google.com>
References: <20230307052036.1520708-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
---
 mm/khugepaged.c | 219 ++++++++++++++++++++++++------------------------
 1 file changed, 108 insertions(+), 111 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3ea2aa55c2c5..b954e3c685e7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1907,6 +1907,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -1919,16 +1925,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2145,129 +2145,126 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
 	}
 
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
+	}
 
-		xas_lock_irq(&xas);
-		if (is_shmem)
-			__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
-		else
-			__mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
+	xas_lock_irq(&xas);
+	if (is_shmem)
+		__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
+	else
+		__mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
 
-		if (nr_none) {
-			__mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
-			/* nr_none is always 0 for non-shmem. */
-			__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
-		}
-		/* Join all the small entries into a single multi-index entry. */
-		xas_set_order(&xas, start, HPAGE_PMD_ORDER);
-		xas_store(&xas, hpage);
-		xas_unlock_irq(&xas);
+	if (nr_none) {
+		__mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
+		/* nr_none is always 0 for non-shmem. */
+		__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
+	}
+	/* Join all the small entries into a single multi-index entry. */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, hpage);
+	xas_unlock_irq(&xas);
 
-		folio = page_folio(hpage);
-		folio_mark_uptodate(folio);
-		folio_ref_add(folio, HPAGE_PMD_NR - 1);
+	folio = page_folio(hpage);
+	folio_mark_uptodate(folio);
+	folio_ref_add(folio, HPAGE_PMD_NR - 1);
 
-		if (is_shmem)
-			folio_mark_dirty(folio);
-		folio_add_lru(folio);
+	if (is_shmem)
+		folio_mark_dirty(folio);
+	folio_add_lru(folio);
 
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
+
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
+	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
+	 * This undo is not needed unless failure is due to SCAN_COPY_MC.
+	 */
+	if (!is_shmem && result == SCAN_COPY_MC)
+		filemap_nr_thps_dec(mapping);
 
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
-		/*
-		 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
-		 * This undo is not needed unless failure is due to SCAN_COPY_MC.
-		 */
-		if (!is_shmem && result == SCAN_COPY_MC)
-			filemap_nr_thps_dec(mapping);
+	xas_unlock_irq(&xas);
 
-		xas_unlock_irq(&xas);
+	hpage->mapping = NULL;
 
-		hpage->mapping = NULL;
-	}
+	unlock_page(hpage);
+	put_page(hpage);
 
-	if (hpage)
-		unlock_page(hpage);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	if (hpage)
-		put_page(hpage);
-
 	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
 	return result;
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

