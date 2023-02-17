Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862769A78B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBQIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjBQIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:55:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C0604EC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k10so484994plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkfSvy10yTOVtyro8pzajTvlxPW2cal5F0m+TWnGBJI=;
        b=fuZjVDB1JJSt2E73C3UPMMNrppsEpGv5FH4b5JY96FTsYo6yYLlYHWoX5M+5+TVcju
         UiSDrXU1dRgGMw40ttJAWrzfgC36ElYDvtynjJ+3E1LwbkZImWo+MnMOMv1cgRmg8mVj
         gXE1H1KJTTn48o6NnpjjBktQ0/zwB/1MutaBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkfSvy10yTOVtyro8pzajTvlxPW2cal5F0m+TWnGBJI=;
        b=13W+796hWZyo07JOAVzQj6VSN74X4bKqIjm6r6M1D6BKOhldmmkwQZ3keSBOlAGlAv
         tnekb6JWkO0x+bvUpSfbKR7JS9NENjN7Jx/KpoGeYJkCB2Hy9XRbXl+pTJZss+f4yeie
         urTgyJgjk3qlf34ZAjI1sXLaHukz+UtdSoeYz84oD4N0SHTtbBc6DUFVulMUiSlMHExn
         2b9cqE01Pxipkd27mkyeSIRMIrbrdxmlWw9rMasiRmn3Q7AdiggurEXDt+Z33B3vm77j
         SDtQ0cZLsSZjnX/AcPVHDmaMRvNr+OkAy2E+s1Lv8h4eaLlmxPxmbT710u0/WDPem6Oy
         hxkg==
X-Gm-Message-State: AO0yUKXUhvEdE/DurWU6PnjbviaLCfJvBqmZ1hmmvGWvKOTgNJh0PxX7
        Rj//XuDtEW8bAotxNHOCR/OyFw==
X-Google-Smtp-Source: AK7set/iqmOUT7SHo7n0JV+juRYDXdzWb7GPiATpt58f1BhfCy/jRZIhTCV30jeU0FNmEkLWkdY9vQ==
X-Received: by 2002:a17:902:c40d:b0:199:49fc:610d with SMTP id k13-20020a170902c40d00b0019949fc610dmr858449plk.15.1676624105797;
        Fri, 17 Feb 2023 00:55:05 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b7bc:8cb9:1364:30fb])
        by smtp.gmail.com with UTF8SMTPSA id l13-20020a170902d34d00b00198dd432329sm2622132plk.51.2023.02.17.00.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:55:05 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 1/3] mm/khugepaged: refactor collapse_file control flow
Date:   Fri, 17 Feb 2023 17:54:37 +0900
Message-Id: <20230217085439.2826375-2-stevensd@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230217085439.2826375-1-stevensd@google.com>
References: <20230217085439.2826375-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 mm/khugepaged.c | 223 ++++++++++++++++++++++++------------------------
 1 file changed, 110 insertions(+), 113 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbc39896811..6a3d6d2e25e0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1885,6 +1885,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -1897,16 +1903,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2123,131 +2123,128 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
-			if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
-					 page) > 0) {
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
+		if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
+				 page) > 0) {
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
+
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
+	mem_cgroup_uncharge(page_folio(hpage));
+	put_page(hpage);
 
-	if (hpage)
-		unlock_page(hpage);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	if (hpage) {
-		mem_cgroup_uncharge(page_folio(hpage));
-		put_page(hpage);
-	}
-
 	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
 	return result;
 }
-- 
2.39.2.637.g21b0678d19-goog

