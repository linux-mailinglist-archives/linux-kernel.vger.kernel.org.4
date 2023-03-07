Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D601A6AD6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCGFVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCGFVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:21:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96157084
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:20:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kb15so12137929pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678166458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjnWe8/2NQ2Rb5ldPsFVe45g3piuxL8Z1VW03Vfk8mw=;
        b=kBImBfHto06kX3ajX3HrtcGpZ7bMp4syG8e7s8aLfxkmY6tZ6j07eeRjASTNxfhmYd
         5CAlb6Bf9CgkXOLw28wBiNF/uvdTiwsdCe3DejJlellQEjmK1gXdf4EBh+7zGW5odEZf
         Wyo/lri1y95D4ABIhnanN+wvOuBP8knvIntKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678166458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjnWe8/2NQ2Rb5ldPsFVe45g3piuxL8Z1VW03Vfk8mw=;
        b=AgwFbVSd22MGyBoNzRvh9mZIIDBZwN5h/UgIYyEj9iQIy/pKQzuBOTAD2Dhm+FmuDe
         awL5XAMxgCONthxScWcSDlqA/7t5Bvct5O9RxEQfT9XcBKjvl/FSbr4IDQQJgheqsGGs
         DlefViwt510sUQV+jy+3Y7xM6oJoERCLkOqsOWVocze7aMzId5+4npzaeca9KlHuBSSZ
         J6ICfvRvlWbToe0irwApMjaIdhCMWwd1I1ADz6IAo+Ce/H6B1PZRVf5pByOgw4hRPDQS
         tmCCiLFH9CRQef89ACr/h3jqUoQtRWu8NtheR8QxLkpTK0B0bYw1IXymotyk1G3LAVRb
         WBQw==
X-Gm-Message-State: AO0yUKWXzHfnJ+dp1poB8cblawm1bIlB0cDngIkP0UBuLwDvJTjAPO1r
        oLliPH3Pf+JVUu9TGWnPVTexDQ==
X-Google-Smtp-Source: AK7set/sEHWb6Xu3exvXoB/mmv+4TeohXcOBTwkbILkcrj+AmDUd121Z7n91XJwSf4KotxpzMT99NQ==
X-Received: by 2002:a05:6a20:3558:b0:bd:17a4:c35f with SMTP id f24-20020a056a20355800b000bd17a4c35fmr11288488pze.23.1678166458635;
        Mon, 06 Mar 2023 21:20:58 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f73:9034:ce28:4421])
        by smtp.gmail.com with UTF8SMTPSA id n13-20020aa7904d000000b0058b927b9653sm7293130pfo.92.2023.03.06.21.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:20:58 -0800 (PST)
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
Subject: [PATCH v5 2/3] mm/khugepaged: skip shmem with userfaultfd
Date:   Tue,  7 Mar 2023 14:20:35 +0900
Message-Id: <20230307052036.1520708-3-stevensd@google.com>
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
 include/trace/events/huge_memory.h |  3 +-
 mm/khugepaged.c                    | 92 +++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 46cce509957b..7ee85fff89a3 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -37,7 +37,8 @@
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
 	EM( SCAN_TRUNCATED,		"truncated")			\
 	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
-	EMe(SCAN_COPY_MC,		"copy_poisoned_page")		\
+	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
+	EMe(SCAN_PAGE_FILLED,		"page_filled")			\
 
 #undef EM
 #undef EMe
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b954e3c685e7..51ae399f2035 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -57,6 +57,7 @@ enum scan_result {
 	SCAN_TRUNCATED,
 	SCAN_PAGE_HAS_PRIVATE,
 	SCAN_COPY_MC,
+	SCAN_PAGE_FILLED,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1873,8 +1874,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
  *  - allocate and lock a new huge page;
  *  - scan page cache replacing old pages with the new one
  *    + swap/gup in pages if necessary;
- *    + fill in gaps;
  *    + keep old pages around in case rollback is required;
+ *  - finalize updates to the page cache;
  *  - if replacing succeeds:
  *    + copy data over;
  *    + free old pages;
@@ -1952,13 +1953,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
 				nr_none++;
 				continue;
 			}
@@ -2169,21 +2169,57 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
+		 * If userspace observed a missing page in a VMA with an armed
+		 * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
+		 * that page, so we need to roll back to avoid suppressing such
+		 * an event. Any userfaultfds armed after this point will not be
+		 * able to observe any missing pages due to the previously
+		 * inserted retry entries.
+		 */
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
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
 
-	xas_lock_irq(&xas);
 	if (is_shmem)
 		__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
 	else
@@ -2213,6 +2249,20 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2224,15 +2274,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
 
@@ -2750,12 +2798,14 @@ static int madvise_collapse_errno(enum scan_result r)
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
2.40.0.rc0.216.gc4246ad0f0-goog

