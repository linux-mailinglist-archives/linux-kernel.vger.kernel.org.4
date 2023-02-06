Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6E68BB83
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBFL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBFL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:29:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE7D3C03
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:29:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z1so11754418plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utDdyziP9bO+Fsgkcg9MC2JxaG0rPj2uHxgkJ2l7vzk=;
        b=O3iioc3IhBlAy1vP2an/YjZGVokv+0MZ7p6GDuiMlVKbiup1dzs1mB84FFkifLx1im
         IPgrQeDcAEouNtZZQRBPUr12fimPDJh6s3e9uODb3QlRiBgXZ8tdydrvU8CKuIMVXb73
         IuVVUW7LfIeY3CSpm3noFrqMkB/OEcdsGGJoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utDdyziP9bO+Fsgkcg9MC2JxaG0rPj2uHxgkJ2l7vzk=;
        b=N3gdjXENUl+oDdEdcBFHkpDA3Ugm91VnChin348UTlJ/gaFYfmyA08Qn33s1BIPzpa
         kLVgTKBSb6D3sUz65nJN7XLoCKFp70XV8gkAbGrD4xx9eHxawHEflNTFzKwWKkJ285c9
         MX8dvJ/E85HzJvmbdvp2cBWiISCzEcnymwYpVtIS/xOvv3r1omCix9dBQ1LO7rtefQBB
         HwNEOb/5qXEcS3B9rBfPjh0p5rjsVgIEEN7tApfPEWAx+G/Z9Bks6p9UBmDyogaxJnyd
         LRFPcadXxlJyMPcXB0Pl6vmVjxfZJZOKqRGPcO73rkK7MtJaNh94x1khyZFr/wKufTvT
         WrXw==
X-Gm-Message-State: AO0yUKXmo9w3Gry/GTHSNh8qAPzB/TL3JnzBN29eutWaCfCUG0b3OTlZ
        +bEAVzZyw9ZtsXmyF43QFGluJw==
X-Google-Smtp-Source: AK7set+PR0nogH0woEYsRyv10vuAB0a7gtb6hm6l7ukP1ANqZmj1N3Mjto6chdUMSCJfFdaUJkTjog==
X-Received: by 2002:a17:902:cec1:b0:196:88e0:ea1a with SMTP id d1-20020a170902cec100b0019688e0ea1amr24354810plg.47.1675682988267;
        Mon, 06 Feb 2023 03:29:48 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4a83:fb85:9f41:4c0c])
        by smtp.gmail.com with UTF8SMTPSA id u2-20020a170902a60200b001962858f990sm6675831plq.164.2023.02.06.03.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 03:29:47 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Date:   Mon,  6 Feb 2023 20:28:56 +0900
Message-Id: <20230206112856.1802547-1-stevensd@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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

Collapsing memory will result in any empty pages in the target range
being filled by the new THP. If userspace has a userfaultfd registered
with MODE_MISSING, for any page which it knows to be missing after
registering the userfaultfd, it may expect a UFFD_EVENT_PAGEFAULT.
Taking these two facts together, khugepaged needs to take care when
collapsing pages in shmem to make sure it doesn't break the userfaultfd
API.

This change first makes sure that the intermediate page cache state
during collapse is not visible by moving when gaps are filled to after
the page cache lock is acquired for the final time. This is necessary
because the synchronization provided by locking hpage is insufficient
for functions which operate on the page cache without actually locking
individual pages to examine their content (e.g. shmem_mfill_atomic_pte).

This refactoring allows us to iterate over i_mmap to check for any VMAs
with userfaultfds and then finalize the collapse if no such VMAs exist,
all while holding the page cache lock. Since no mm locks are held, it is
necessary to add smb_rmb/smb_wmb to ensure that userfaultfd updates to
vm_flags are visible to khugepaged. However, no further locking of
userfaultfd state is necessary. Although new userfaultfds can be
registered concurrently with finalizing the collapse, any missing pages
that are being replaced can no longer be observed by userspace, so there
is no data race.

This fix is targeted at khugepaged, but the change also applies to
MADV_COLLAPSE. The fact that the intermediate page cache state before
the rollback of a failed collapse can no longer be observed is
technically a userspace-visible change (via at least SEEK_DATA and
SEEK_END), but it is exceedingly unlikely that anything relies on being
able to observe that transient state.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 fs/userfaultfd.c |  2 ++
 mm/khugepaged.c  | 67 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cc694846617a..6ddfcff11920 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -114,6 +114,8 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
 	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
 
 	vma->vm_flags = flags;
+	/* Pairs with smp_rmb() in khugepaged's collapse_file() */
+	smp_wmb();
 	/*
 	 * For shared mappings, we want to enable writenotify while
 	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 79be13133322..97435c226b18 100644
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
@@ -1747,6 +1748,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
+	bool i_mmap_locked = false;
 	int nr = 0;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
@@ -1780,8 +1782,14 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	/*
 	 * At this point the hpage is locked and not up-to-date.
-	 * It's safe to insert it into the page cache, because nobody would
-	 * be able to map it or use it in another way until we unlock it.
+	 *
+	 * While iterating, we may drop the page cache lock multiple times. It
+	 * is safe to replace pages in the page cache with hpage while doing so
+	 * because nobody is able to map or otherwise access the content of
+	 * hpage until we unlock it. However, we cannot insert hpage into empty
+	 * indicies until we know we won't have to drop the page cache lock
+	 * again, as doing so would let things which only check the presence
+	 * of pages in the page cache see a state that may yet be rolled back.
 	 */
 
 	xas_set(&xas, start);
@@ -1802,13 +1810,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -1967,6 +1974,46 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
+		i_mmap_locked = true;
+		xas_lock_irq(&xas);
+
+		xas_set(&xas, start);
+		for (index = start; index < end; index++) {
+			if (!xas_next(&xas))
+				nr_none_check++;
+		}
+
+		if (nr_none != nr_none_check) {
+			result = SCAN_PAGE_FILLED;
+			goto xa_locked;
+		}
+
+		/*
+		 * If userspace observed a missing page in a VMA with an armed
+		 * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
+		 * that page, so we need to roll back to avoid suppressing such
+		 * an event. Any userfaultfds armed after this point will not be
+		 * able to observe any missing pages, since the page cache is
+		 * locked until after the collapse is completed.
+		 *
+		 * Pairs with smp_wmb() in userfaultfd_set_vm_flags().
+		 */
+		smp_rmb();
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
+			if (userfaultfd_missing(vma)) {
+				result = SCAN_EXCEED_NONE_PTE;
+				goto xa_locked;
+			}
+		}
+	}
+
 	nr = thp_nr_pages(hpage);
 
 	if (is_shmem)
@@ -2000,6 +2047,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	xas_store(&xas, hpage);
 xa_locked:
 	xas_unlock_irq(&xas);
+	if (i_mmap_locked)
+		i_mmap_unlock_read(mapping);
 xa_unlocked:
 
 	/*
@@ -2065,15 +2114,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
 
-- 
2.39.1.519.gcb327c4b5f-goog

