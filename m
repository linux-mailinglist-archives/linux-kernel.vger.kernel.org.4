Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B46695B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjBNH5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjBNH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:57:26 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33315206A5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:57:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 78so9711516pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0Z3rzguH4ZoJOngNzhmwoM/o5xYQMHZRaqzjDLV+ZY=;
        b=TT5qGbRp+TwoKbeoF8RFdMUbptoh0Tt+uCr8QbFYXP+VDWlmHqE0TWskWe7Gg86ZOl
         w2szTKW6pZULps5U/lb0RAWobrUA+dl61/EqpGukGnH6udCW7LU+n688a001VOF6WnRG
         l8Xj5sx1HKNNl4w4OHepXx71PY3MkIN5u7aYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0Z3rzguH4ZoJOngNzhmwoM/o5xYQMHZRaqzjDLV+ZY=;
        b=vP/7ga9KyA26PeDuIZAjHZHBrTIQ1VBzJtFYaFSDQyjBnRYPn4jYJ3kxNUDPcBYXdh
         E+1rkIoSOn/na1GO7aDJBQRYskQKIPOqi8kcFdoH4a5pmhQyt8UGZ/vDXwmE6WFCWX1z
         DtrSNt6CEtV7zvqprRJVkc2gRUSuxIt3Xvaa0W5JOcRstnmcdVuU+G/4XJVDBqvflR4W
         eLt2sKYNXKcma7BBAb+74apgqNoRnkHlZssmM9VQX4gF1+52QkHi16DRD+TOELW4lWhg
         UIq+5A9UIIu7V7L5OtKSBK0LVUHsfl3B4z3gQmOw1zIcni/VF8l8mz7aqe/2Z4AGqttS
         +ciA==
X-Gm-Message-State: AO0yUKWfSDO7TLAYjlr2oOW989uciYa4E658DbPiqT0TQvJYKfl/ls8U
        xuyM2eWrwfSpjDyFqyXkfm26hA==
X-Google-Smtp-Source: AK7set8t1j4eGyz7sD1P5cj3c4rXd6726tRljRGwe6ONwfw0yR6YYRfJIu4Pb2DYlGLxA9+9Gn6mkg==
X-Received: by 2002:aa7:95a9:0:b0:5a8:bd6e:90fb with SMTP id a9-20020aa795a9000000b005a8bd6e90fbmr1427099pfk.19.1676361443593;
        Mon, 13 Feb 2023 23:57:23 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:45f7:92a0:f546:300f])
        by smtp.gmail.com with UTF8SMTPSA id d19-20020aa78153000000b00593fa670c88sm9134529pfn.57.2023.02.13.23.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:57:22 -0800 (PST)
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
Subject: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
Date:   Tue, 14 Feb 2023 16:57:10 +0900
Message-Id: <20230214075710.2401855-2-stevensd@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230214075710.2401855-1-stevensd@google.com>
References: <20230214075710.2401855-1-stevensd@google.com>
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

Make sure that collapse_file respects any userfaultfds registered with
MODE_MISSING. If userspace has any such userfaultfds registered, then
for any page which it knows to be missing, it may expect a
UFFD_EVENT_PAGEFAULT. This means collapse_file needs to take care when
collapsing a shmem range would result in replacing an empty page with a
THP, so that it doesn't break userfaultfd.

Synchronization when checking for userfaultfds in collapse_file is
tricky because the mmap locks can't be used to prevent races with the
registration of new userfaultfds. Instead, we provide synchronization by
ensuring that userspace cannot observe the fact that pages are missing
before we check for userfaultfds. Although this allows registration of a
userfaultfd to race with collapse_file, it ensures that userspace cannot
observe any pages transition from missing to present after such a race.
This makes such a race indistinguishable to the collapse occurring
immediately before the userfaultfd registration.

The first step to provide this synchronization is to stop filling gaps
during the loop iterating over the target range, since the page cache
lock can be dropped during that loop. The second step is to fill the
gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
time, to avoid races with accesses to the page cache that only take the
RCU read lock.

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
---
 mm/khugepaged.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b648f1053d95..8c2e2349e883 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -55,6 +55,7 @@ enum scan_result {
 	SCAN_CGROUP_CHARGE_FAIL,
 	SCAN_TRUNCATED,
 	SCAN_PAGE_HAS_PRIVATE,
+	SCAN_PAGE_FILLED,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1725,8 +1726,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
  *  - allocate and lock a new huge page;
  *  - scan page cache replacing old pages with the new one
  *    + swap/gup in pages if necessary;
- *    + fill in gaps;
  *    + keep old pages around in case rollback is required;
+ *  - finalize updates to the page cache;
  *  - if replacing succeeds:
  *    + copy data over;
  *    + free old pages;
@@ -1805,13 +1806,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -1970,6 +1970,56 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		put_page(page);
 		goto xa_unlocked;
 	}
+
+	if (nr_none) {
+		struct vm_area_struct *vma;
+		int nr_none_check = 0;
+
+		xas_unlock_irq(&xas);
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
+			goto xa_locked;
+		}
+	}
+
 	nr = thp_nr_pages(hpage);
 
 	if (is_shmem)
@@ -2068,15 +2118,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		xas_set(&xas, start);
-		xas_for_each(&xas, page, end - 1) {
+		end = index;
+		for (index = start; index < end; index++) {
+			xas_next(&xas);
 			page = list_first_entry_or_null(&pagelist,
 					struct page, lru);
 			if (!page || xas.xa_index < page->index) {
-				if (!nr_none)
-					break;
 				nr_none--;
-				/* Put holes back where they were */
-				xas_store(&xas, NULL);
 				continue;
 			}
 
@@ -2592,11 +2640,13 @@ static int madvise_collapse_errno(enum scan_result r)
 	case SCAN_ALLOC_HUGE_PAGE_FAIL:
 		return -ENOMEM;
 	case SCAN_CGROUP_CHARGE_FAIL:
+	case SCAN_EXCEED_NONE_PTE:
 		return -EBUSY;
 	/* Resource temporary unavailable - trying again might succeed */
 	case SCAN_PAGE_LOCK:
 	case SCAN_PAGE_LRU:
 	case SCAN_DEL_PAGE_LRU:
+	case SCAN_PAGE_FILLED:
 		return -EAGAIN;
 	/*
 	 * Other: Trying again likely not to succeed / error intrinsic to
-- 
2.39.1.581.gbfd45094c4-goog

