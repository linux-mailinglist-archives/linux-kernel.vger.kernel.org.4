Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AFD69A78D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBQIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBQIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:55:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA74160A50
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j5so576808pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjMpoZ8bcgvH2E9XkmftEhbBkctgLmEbKJ6cV9dN/tw=;
        b=GZkmRSsdPBfla5qFntrp2Pw4Fv/pqdobPbGt2YMGNVPFzOczxMqoeQwL/ECUItTSwC
         Z2EdXnqyL4OaBFASsYyJs5KeDsJjdMoRycYji3+G03xuy31DgKDrPMgW5P/kcBQAMSNx
         pvFaDbymNIwo9wkkmZsc85H5601aY8DC4tZos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjMpoZ8bcgvH2E9XkmftEhbBkctgLmEbKJ6cV9dN/tw=;
        b=dfA60EK0l7mBvTxwrpYaRwGAh5oYWtVyRkffIm2wzErJiaDlj2JFVvFRVpfskAxr49
         vA6HBLot40ha3vrS8RIyfLUTfntKTBaX0V/jt8BP6mq7emPXvdZBVcca8vEq5o0X26ZX
         b9mfpTrzxC1//O7Plf6v89qDu+8YVqi2YEEYmUrgRmc01FN6KVrmN7QMRF5dCsz0IPGr
         ryjowubkllfx5srK/ra3yYMXkWcxMvdIRl1oOxbTp4bc6qZj2plr8sh0Fbz4+NISkHu+
         prq9KPNpApHM2BzKuYZPIx+TxDwQmAWYsuf0Ha/LH+Xy/W8ivYlBFcyQl2RNK9HAsBH8
         6Syw==
X-Gm-Message-State: AO0yUKU0dSpGTE1GIyRcr134tem1AUYArMldmp4r/O2Qd6En/N2EEHwk
        acBNGbWhYyhWcZA9EV0ywBJ24g==
X-Google-Smtp-Source: AK7set+gdOoMg/f/eZ6vrpn2+McA1nHrAJV9kACCzgvxBVBKR4TgUlsSlLQeog5O33xrEkX2ULDZpg==
X-Received: by 2002:a05:6a20:7b11:b0:c7:32b8:d6b9 with SMTP id s17-20020a056a207b1100b000c732b8d6b9mr3982808pzh.13.1676624115269;
        Fri, 17 Feb 2023 00:55:15 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b7bc:8cb9:1364:30fb])
        by smtp.gmail.com with UTF8SMTPSA id j12-20020a62b60c000000b0059072daa002sm2550076pff.192.2023.02.17.00.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:55:14 -0800 (PST)
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
Subject: [PATCH v4 3/3] mm/khugepaged: maintain page cache uptodate flag
Date:   Fri, 17 Feb 2023 17:54:39 +0900
Message-Id: <20230217085439.2826375-4-stevensd@google.com>
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

Make sure that collapse_file doesn't interfere with checking the
uptodate flag in the page cache by only inserting hpage into the page
cache after it has been updated and marked uptodate. This is achieved by
simply not replacing present pages with hpage when iterating over them
target range. The present pages are already locked, so replacing the
with the locked hpage before the collapse is finalized is unnecessary.

This fixes a race where folio_seek_hole_data would mistake hpage for
an fallocated but unwritten page. This race is visible to userspace via
data temporarily disappearing from SEEK_DATA/SEEK_HOLE.

Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 mm/khugepaged.c | 50 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1c37f9151345..e08cf7c5ebdf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1908,12 +1908,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2082,13 +2076,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2127,8 +2117,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		goto rollback;
 
 	/*
-	 * Replacing old pages with new one has succeeded, now we
-	 * attempt to copy the contents.
+	 * The old pages are locked, so they won't change anymore.
 	 */
 	index = start;
 	list_for_each_entry(page, &pagelist, lru) {
@@ -2209,11 +2198,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2222,6 +2211,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2246,36 +2240,18 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
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
@@ -2283,8 +2259,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (!is_shmem && result == SCAN_COPY_MC)
 		filemap_nr_thps_dec(mapping);
 
-	xas_unlock_irq(&xas);
-
 	hpage->mapping = NULL;
 
 	unlock_page(hpage);
-- 
2.39.2.637.g21b0678d19-goog

