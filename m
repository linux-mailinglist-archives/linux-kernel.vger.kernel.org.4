Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D2F6AD6BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCGFV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCGFVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:21:13 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212662318
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:21:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id fa28so7298030pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678166464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFAeWPY2kcSCdT3O6CTUVlduCnpUJhZej+FbmoWYNkg=;
        b=Q9sGR9JplEaeNqsSC0pRNCxNi/C7wmGhoCkA56L/loqSr4HfTSKbd24kgSyhErzSqH
         0I6wjvacPrWo2mFsQrRLwwJXlg3UaeAhxOZ0HtAJPSslGOMFmzE06GPMU9FLNZYobvT/
         3o1S3aGwC8Ks5mnW1V4r0yFDwjDaYhzpIxfho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678166464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFAeWPY2kcSCdT3O6CTUVlduCnpUJhZej+FbmoWYNkg=;
        b=fQpuaLLZp5uFy/G1KFCXyF+9k/Libhtx7fTkFudRveCKob2qEpITpCrUgEjjL1RH4P
         s71xOT2B5I+XIBTSwn8OZFGOsDX4j+fx4i17gMDR5d/s7gO8yirPBe9t1wqY9mWBAmYY
         T2niQjAD50ev+nftsBNiMOUXj1yczVVosEFhwUi6U5W1LkT3vOcbfF3TbFSbGYMMMEQW
         V5konlkTnq7WwPb0bK9U/JP3Ovdq2neYXyTgKuf0PsleNL7DYdnT0OiR3dj7679eZKLJ
         aw9UH2lImX+2GcdkeAlOk0P/xZTdctuGrZH043PZSPyh7oIZIf1k2pRrv5INq+0M1t5Y
         jMhw==
X-Gm-Message-State: AO0yUKUTDfnFNvXqod1vxPycCsanxVDzXz7KkuvQux8PWkLdj9WOwHpa
        7M0WACEfzStgpe2WBJnte9OosQ==
X-Google-Smtp-Source: AK7set9Qm/5FdMeOBnVeJtsCUuwHXzpeDkbq4jDrAQajKNW8Ze2GzSb1kc4cMCotGeX1k2yhybBoAw==
X-Received: by 2002:a62:6542:0:b0:5a8:ad9d:83f with SMTP id z63-20020a626542000000b005a8ad9d083fmr10412674pfb.24.1678166464453;
        Mon, 06 Mar 2023 21:21:04 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f73:9034:ce28:4421])
        by smtp.gmail.com with UTF8SMTPSA id c26-20020aa78c1a000000b005a8f1187112sm7117378pfd.58.2023.03.06.21.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:21:04 -0800 (PST)
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
Subject: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Date:   Tue,  7 Mar 2023 14:20:36 +0900
Message-Id: <20230307052036.1520708-4-stevensd@google.com>
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

Make sure that collapse_file doesn't interfere with checking the
uptodate flag in the page cache by only inserting hpage into the page
cache after it has been updated and marked uptodate. This is achieved by
simply not replacing present pages with hpage when iterating over the
target range. The present pages are already locked, so replacing the
with the locked hpage before the collapse is finalized is unnecessary.

This fixes a race where folio_seek_hole_data would mistake hpage for
an fallocated but unwritten page. This race is visible to userspace via
data temporarily disappearing from SEEK_DATA/SEEK_HOLE.

Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: David Stevens <stevensd@chromium.org>
Acked-by: Peter Xu <peterx@redhat.com>
---
 mm/khugepaged.c | 50 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 51ae399f2035..bdde0a02811b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1930,12 +1930,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2104,13 +2098,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2149,8 +2139,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		goto rollback;
 
 	/*
-	 * Replacing old pages with new one has succeeded, now we
-	 * attempt to copy the contents.
+	 * The old pages are locked, so they won't change anymore.
 	 */
 	index = start;
 	list_for_each_entry(page, &pagelist, lru) {
@@ -2230,11 +2219,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2243,6 +2232,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2267,36 +2261,18 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 rollback:
 	/* Something went wrong: roll back page cache changes */
-	xas_lock_irq(&xas);
 	if (nr_none) {
 		mapping->nrpages -= nr_none;
 		shmem_uncharge(mapping->host, nr_none);
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
+	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
 		/* Unfreeze the page. */
 		list_del(&page->lru);
 		page_ref_unfreeze(page, 2);
-		xas_store(&xas, page);
-		xas_pause(&xas);
-		xas_unlock_irq(&xas);
 		unlock_page(page);
 		putback_lru_page(page);
-		xas_lock_irq(&xas);
 	}
-	VM_BUG_ON(nr_none);
 	/*
 	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
 	 * This undo is not needed unless failure is due to SCAN_COPY_MC.
@@ -2304,8 +2280,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (!is_shmem && result == SCAN_COPY_MC)
 		filemap_nr_thps_dec(mapping);
 
-	xas_unlock_irq(&xas);
-
 	hpage->mapping = NULL;
 
 	unlock_page(hpage);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

