Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9ED5F3AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJDAhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJDAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BAB29375
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664843831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agJ87AhkrOU4WXbJTuk9++7as6a20Yx3hvs9+IM86N0=;
        b=SrGvJFk+vjFwG2awE8MtQJx/VQtcFuuuBs3j2AWtvHtNbeQDzy7rwOOJyblCZiJ/BuKcxI
        tCVf6bqY9JfdMlyrdHSbTMdssEkSYH+iXqOXq1OGdNL7BGHtin3pg4Ngdveljfyg3J9yjn
        UmrctMPrFPfiTpC2kyGZ9+MD3nZFBgc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-nZLRO8YgMXiT6zauIFXD1Q-1; Mon, 03 Oct 2022 20:37:10 -0400
X-MC-Unique: nZLRO8YgMXiT6zauIFXD1Q-1
Received: by mail-qk1-f200.google.com with SMTP id u20-20020a05620a455400b006ce5151968dso10316859qkp.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=agJ87AhkrOU4WXbJTuk9++7as6a20Yx3hvs9+IM86N0=;
        b=J7hdCUyQy2ZLDB00EFwG3Dng+p6Iszklso0CwoZs8l4qC8qG/89r6lsk9KYYBu5mMQ
         dkCO+erEFQ9jN9wp+7Rpug5t9P4VEMHYkwh2xBMXDzxOz8MR8+ykOyDcbYc1Uj3Ovxvb
         fqbOhhBhrWvXo3Ovbgiy76kThqB+sQ4+Y/MeSDu3p3yuDzoRNfS+qjeXlHmogHnuMmWe
         zULl6h2inwfn2rYHPuHz0kA1MNZMcebCdIZKQPLYOc8/KzQM69Y816mZDBerbx7f4xSa
         DCeZnkH70M42BESSOtmyza0z2YugmqUtVO06fjpNK7lZQke7M35knGgXqmGZPdsv/JqM
         hMCA==
X-Gm-Message-State: ACrzQf33LIVVJJnK1H7VN61yjtJJpUYgTlh6l00NJheyhFilVDRSUZcX
        g4b2Aqm77jL8HnqCim8MfhCBXgWkYtTppwEEBfNpiqGNvFf0WdyuWwHJqQDPmip2fKY3BVwH9js
        2py7YF+caTNWQfBg0k1uhwMSfs1expbSWN3ORD6UM3gljWxcZmaTZMth72u1EkYW4q9mp3qWeUg
        ==
X-Received: by 2002:a05:620a:2809:b0:6bc:60fa:6b93 with SMTP id f9-20020a05620a280900b006bc60fa6b93mr15045490qkp.254.1664843829415;
        Mon, 03 Oct 2022 17:37:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM74Q1B/bbLHC2GBtqEZOKQ/JZbvCEg1IiGQX5mCpjocQh5bJvbd6ZJW2ioDiKMXCi//B1kRGA==
X-Received: by 2002:a05:620a:2809:b0:6bc:60fa:6b93 with SMTP id f9-20020a05620a280900b006bc60fa6b93mr15045473qkp.254.1664843829115;
        Mon, 03 Oct 2022 17:37:09 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u30-20020a37ab1e000000b006bb9125363fsm12228104qke.121.2022.10.03.17.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:37:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 1/3] mm/hugetlb: Fix race condition of uffd missing/minor handling
Date:   Mon,  3 Oct 2022 20:37:03 -0400
Message-Id: <20221004003705.497782-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004003705.497782-1-peterx@redhat.com>
References: <20221004003705.497782-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the recent rework patchset of hugetlb locking on pmd sharing,
kselftest for userfaultfd sometimes fails on hugetlb private tests with
unexpected write fault checks.

It turns out there's nothing wrong within the locking series regarding this
matter, but it could have changed the timing of threads so it can trigger
an old bug.

The real bug is when we call hugetlb_no_page() we're not with the pgtable
lock.  It means we're reading the pte values lockless.  It's perfectly fine
in most cases because before we do normal page allocations we'll take the
lock and check pte_same() again.  However before that, there are actually
two paths on userfaultfd missing/minor handling that may directly move on
with the fault process without checking the pte values.

It means for these two paths we may be generating an uffd message based on
an unstable pte, while an unstable pte can legally be anything as long as
the modifier holds the pgtable lock.

One example, which is also what happened in the failing kselftest and
caused the test failure, is that for private mappings wr-protection changes
can happen on one page.  While hugetlb_change_protection() generally
requires pte being cleared before being changed, then there can be a race
condition like:

        thread 1                              thread 2
        --------                              --------

      UFFDIO_WRITEPROTECT                     hugetlb_fault
        hugetlb_change_protection
          pgtable_lock()
          huge_ptep_modify_prot_start
                                              pte==NULL
                                              hugetlb_no_page
                                                generate uffd missing event
                                                even if page existed!!
          huge_ptep_modify_prot_commit
          pgtable_unlock()

Fix this by recheck the pte after pgtable lock for both userfaultfd missing
& minor fault paths.

This bug should have been around starting from uffd hugetlb introduced, so
attaching a Fixes to the commit.  Also attach another Fixes to the minor
support commit for easier tracking.

Note that userfaultfd is actually fine with false positives (e.g. caused by
pte changed), but not wrong logical events (e.g. caused by reading a pte
during changing).  The latter can confuse the userspace, so the strictness
is very much preferred.  E.g., MISSING event should never happen on the
page after UFFDIO_COPY has correctly installed the page and returned.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Fixes: 1a1aad8a9b7b ("userfaultfd: hugetlbfs: add userfaultfd hugetlb hook")
Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
Co-developed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9679fe519b90..fa3fcdb0c4b8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5521,6 +5521,23 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	return ret;
 }
 
+/*
+ * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
+ * false if pte changed or is changing.
+ */
+static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
+			       pte_t *ptep, pte_t old_pte)
+{
+	spinlock_t *ptl;
+	bool same;
+
+	ptl = huge_pte_lock(h, mm, ptep);
+	same = pte_same(huge_ptep_get(ptep), old_pte);
+	spin_unlock(ptl);
+
+	return same;
+}
+
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
@@ -5562,9 +5579,30 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
-			ret = hugetlb_handle_userfault(vma, mapping, idx,
-						       flags, haddr, address,
-						       VM_UFFD_MISSING);
+			/*
+			 * Since hugetlb_no_page() was examining pte
+			 * without pgtable lock, we need to re-test under
+			 * lock because the pte may not be stable and could
+			 * have changed from under us.  Try to detect
+			 * either changed or during-changing ptes and retry
+			 * properly when needed.
+			 *
+			 * Note that userfaultfd is actually fine with
+			 * false positives (e.g. caused by pte changed),
+			 * but not wrong logical events (e.g. caused by
+			 * reading a pte during changing).  The latter can
+			 * confuse the userspace, so the strictness is very
+			 * much preferred.  E.g., MISSING event should
+			 * never happen on the page after UFFDIO_COPY has
+			 * correctly installed the page and returned.
+			 */
+			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+				ret = hugetlb_handle_userfault(
+				    vma, mapping, idx, flags, haddr,
+				    address, VM_UFFD_MISSING);
+			else
+				/* Retry the fault */
+				ret = 0;
 			goto out;
 		}
 
@@ -5634,9 +5672,14 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (userfaultfd_minor(vma)) {
 			unlock_page(page);
 			put_page(page);
-			ret = hugetlb_handle_userfault(vma, mapping, idx,
-						       flags, haddr, address,
-						       VM_UFFD_MINOR);
+			/* See comment in userfaultfd_missing() block above */
+			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+				ret = hugetlb_handle_userfault(
+				    vma, mapping, idx, flags, haddr,
+				    address, VM_UFFD_MINOR);
+			else
+				/* Retry the fault */
+				ret = 0;
 			goto out;
 		}
 	}
-- 
2.37.3

