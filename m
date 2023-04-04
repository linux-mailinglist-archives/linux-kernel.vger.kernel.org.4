Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EB6D5FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjDDMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjDDMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:01:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4035435B5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:01:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id le6so31014756plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680609698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qUt+bgMbpOhTRgQhL+AHDV3zlnHqzmbomM5Wqo2t8M=;
        b=gGkyBqM897kTx3mCEJLjxur+giZZePN0hsSQZRggvEHfuxcLZ/xAHZn7d/zocZ+B/t
         1cIzL09rih7OgQJFA0TJpSLo18rTYMeEnbExDfttmiQbIW+B8qdcJ1V6KdSL3C2CVoIk
         uhn8K/3B8O1z7wv+u/gk9GUet3CqJe2QvDgOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qUt+bgMbpOhTRgQhL+AHDV3zlnHqzmbomM5Wqo2t8M=;
        b=LafoohDVQcxP7rs9TkF8HOCOp94SQVin3vg/ntn4KKIC/o+NhVb1q2aqn8r1S3VlWO
         9jqMyPJ2FNfgVRIDywshE4DgCkltxlp/H7J6QYrXxUqS9N5mccaFXuiFQPWgp5l2SPMe
         vA+kXgaZBnxvab8IgP2ynzhjgpxGXlH5weh33MgIHRygWaZZyP/h0KxeRCaJsF1VGsdn
         3GWqZPv5J/uNBuEw1ps6zvh57/ZfH//2lBX8hM32c03NWDNanDv/oFnQx6qdZaRdo/Y5
         bVoDsFfh4Sd10RwGkjW6BHrTNjQ/tBjO+tbzgF4q5yAfIlOelOqvRWA7s01O0xwQgINw
         8AQw==
X-Gm-Message-State: AAQBX9diAY+Mw2u3HXjRcrxipi1R5SHcGv9jpBaaT8Zqs4nPCM3kko+X
        WGFcvxhubKXEpf1JO6hdivf3rA==
X-Google-Smtp-Source: AKy350YJmn368SsJA0s1UjNOINFx3s/OTYEKafflR1j6AXeAzEBTEXX+E3A7d0NoY4XJPEiZqkDcUw==
X-Received: by 2002:a17:90b:1a86:b0:23f:7c82:2463 with SMTP id ng6-20020a17090b1a8600b0023f7c822463mr2874580pjb.9.1680609698541;
        Tue, 04 Apr 2023 05:01:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:959b:21ea:166b:c273])
        by smtp.gmail.com with UTF8SMTPSA id q3-20020a17090a938300b0023b15e61f07sm7879485pjo.12.2023.04.04.05.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:01:38 -0700 (PDT)
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
Subject: [PATCH v6 3/4] mm/khugepaged: skip shmem with userfaultfd
Date:   Tue,  4 Apr 2023 21:01:16 +0900
Message-Id: <20230404120117.2562166-4-stevensd@google.com>
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

Make sure that collapse_file respects any userfaultfds registered with
MODE_MISSING. If userspace has any such userfaultfds registered, then
for any page which it knows to be missing, it may expect a
UFFD_EVENT_PAGEFAULT. This means collapse_file needs to be careful when
collapsing a shmem range would result in replacing an empty page with a
THP, to avoid breaking userfaultfd.

Synchronization when checking for userfaultfds in collapse_file is
tricky because the mmap locks can't be used to prevent races with the
registration of new userfaultfds. Instead, we provide synchronization by
ensuring that userspace cannot observe the fact that pages are missing
before we check for userfaultfds. Although this allows registration of a
userfaultfd to race with collapse_file, it ensures that userspace cannot
observe any pages transition from missing to present after such a race
occurs. This makes such a race indistinguishable to the collapse
occurring immediately before the userfaultfd registration.

The first step to provide this synchronization is to stop filling gaps
during the loop iterating over the target range, since the page cache
lock can be dropped during that loop. The second step is to fill the
gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
time, to avoid races with accesses to the page cache that only take the
RCU read lock.

The fact that we don't fill holes during the initial iteration means
that collapse_file now has to handle faults occurring during the
collapse. This is done by re-validating the number of missing pages
after acquiring the page cache lock for the final time.

This fix is targeted at khugepaged, but the change also applies to
MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
return EBUSY if there are any missing pages (instead of succeeding on
shmem and returning EINVAL on anonymous memory). There is also now a
window during MADV_COLLAPSE where a fault on a missing page will cause
the syscall to fail with EAGAIN.

The fact that intermediate page cache state can no longer be observed
before the rollback of a failed collapse is also technically a
userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
is exceedingly unlikely that anything relies on being able to observe
that transient state.

Signed-off-by: David Stevens <stevensd@chromium.org>
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/trace/events/huge_memory.h |   3 +-
 mm/khugepaged.c                    | 109 +++++++++++++++++++++--------
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index eca4c6f3625e..877cbf9fd2ec 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -38,7 +38,8 @@
 	EM( SCAN_TRUNCATED,		"truncated")			\
 	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
 	EM( SCAN_STORE_FAILED,		"store_failed")			\
-	EMe(SCAN_COPY_MC,		"copy_poisoned_page")
+	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
+	EMe(SCAN_PAGE_FILLED,		"page_filled")			\
 
 #undef EM
 #undef EMe
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 90828272a065..7679551e9540 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -57,6 +57,7 @@ enum scan_result {
 	SCAN_PAGE_HAS_PRIVATE,
 	SCAN_COPY_MC,
 	SCAN_STORE_FAILED,
+	SCAN_PAGE_FILLED,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1856,8 +1857,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
  *  - allocate and lock a new huge page;
  *  - scan page cache replacing old pages with the new one
  *    + swap/gup in pages if necessary;
- *    + fill in gaps;
  *    + keep old pages around in case rollback is required;
+ *  - finalize updates to the page cache;
  *  - if replacing succeeds:
  *    + copy data over;
  *    + free old pages;
@@ -1935,22 +1936,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 						result = SCAN_TRUNCATED;
 						goto xa_locked;
 					}
-					xas_set(&xas, index);
+					xas_set(&xas, index + 1);
 				}
 				if (!shmem_charge(mapping->host, 1)) {
 					result = SCAN_FAIL;
 					goto xa_locked;
 				}
-				xas_store(&xas, hpage);
-				if (xas_error(&xas)) {
-					/* revert shmem_charge performed
-					 * in the previous condition
-					 */
-					mapping->nrpages--;
-					shmem_uncharge(mapping->host, 1);
-					result = SCAN_STORE_FAILED;
-					goto xa_locked;
-				}
 				nr_none++;
 				continue;
 			}
@@ -2161,22 +2152,66 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		index++;
 	}
 
-	/*
-	 * Copying old pages to huge one has succeeded, now we
-	 * need to free the old pages.
-	 */
-	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
-		list_del(&page->lru);
-		page->mapping = NULL;
-		page_ref_unfreeze(page, 1);
-		ClearPageActive(page);
-		ClearPageUnevictable(page);
-		unlock_page(page);
-		put_page(page);
+	if (nr_none) {
+		struct vm_area_struct *vma;
+		int nr_none_check = 0;
+
+		i_mmap_lock_read(mapping);
+		xas_lock_irq(&xas);
+
+		xas_set(&xas, start);
+		for (index = start; index < end; index++) {
+			if (!xas_next(&xas)) {
+				xas_store(&xas, XA_RETRY_ENTRY);
+				if (xas_error(&xas)) {
+					result = SCAN_STORE_FAILED;
+					goto immap_locked;
+				}
+				nr_none_check++;
+			}
+		}
+
+		if (nr_none != nr_none_check) {
+			result = SCAN_PAGE_FILLED;
+			goto immap_locked;
+		}
+
+		/*
+		 * If userspace observed a missing page in a VMA with a MODE_MISSING
+		 * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for that
+		 * page. If so, we need to roll back to avoid suppressing such an
+		 * event. Since wp/minor userfaultfds don't give userspace any
+		 * guarantees that the kernel doesn't fill a missing page with a zero
+		 * page, so they don't matter here.
+		 *
+		 * Any userfaultfds registered after this point will not be able to
+		 * observe any missing pages due to the previously inserted retry
+		 * entries.
+		 */
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, end) {
+			if (userfaultfd_missing(vma)) {
+				result = SCAN_EXCEED_NONE_PTE;
+				goto immap_locked;
+			}
+		}
+
+immap_locked:
+		i_mmap_unlock_read(mapping);
+		if (result != SCAN_SUCCEED) {
+			xas_set(&xas, start);
+			for (index = start; index < end; index++) {
+				if (xas_next(&xas) == XA_RETRY_ENTRY)
+					xas_store(&xas, NULL);
+			}
+
+			xas_unlock_irq(&xas);
+			goto rollback;
+		}
+	} else {
+		xas_lock_irq(&xas);
 	}
 
 	nr = thp_nr_pages(hpage);
-	xas_lock_irq(&xas);
 	if (is_shmem)
 		__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
 	else
@@ -2206,6 +2241,20 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	result = retract_page_tables(mapping, start, mm, addr, hpage,
 				     cc);
 	unlock_page(hpage);
+
+	/*
+	 * The collapse has succeeded, so free the old pages.
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
+
 	goto out;
 
 rollback:
@@ -2217,15 +2266,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	}
 
 	xas_set(&xas, start);
-	xas_for_each(&xas, page, end - 1) {
+	end = index;
+	for (index = start; index < end; index++) {
+		xas_next(&xas);
 		page = list_first_entry_or_null(&pagelist,
 				struct page, lru);
 		if (!page || xas.xa_index < page->index) {
-			if (!nr_none)
-				break;
 			nr_none--;
-			/* Put holes back where they were */
-			xas_store(&xas, NULL);
 			continue;
 		}
 
@@ -2749,12 +2796,14 @@ static int madvise_collapse_errno(enum scan_result r)
 	case SCAN_ALLOC_HUGE_PAGE_FAIL:
 		return -ENOMEM;
 	case SCAN_CGROUP_CHARGE_FAIL:
+	case SCAN_EXCEED_NONE_PTE:
 		return -EBUSY;
 	/* Resource temporary unavailable - trying again might succeed */
 	case SCAN_PAGE_COUNT:
 	case SCAN_PAGE_LOCK:
 	case SCAN_PAGE_LRU:
 	case SCAN_DEL_PAGE_LRU:
+	case SCAN_PAGE_FILLED:
 		return -EAGAIN;
 	/*
 	 * Other: Trying again likely not to succeed / error intrinsic to
-- 
2.40.0.348.gf938b09366-goog

