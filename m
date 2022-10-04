Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0A5F49C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJDTeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJDTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D6696D2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664912045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQaRIORouh5PGNwxNNc/P0MIv99YHmLbB7VcHRYE5ek=;
        b=OxrcXGetBNdgeTOTH04zuVLjO4N0V+VkOkdEr4O2NjshrpOcMHu7kz5lqMxcCZI7dSqdsM
        KSyp7HPvdxNNz9dXKh7DTdlzv71lbq5tfFC15+uebS5OoutWT71oXqD3R181nqUKtgL5Eq
        c3/8E6Y5WKvdg1FJT67YhSc/QpOe30A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-Rz82OGQgPQCGMUyLEw9Kmw-1; Tue, 04 Oct 2022 15:34:04 -0400
X-MC-Unique: Rz82OGQgPQCGMUyLEw9Kmw-1
Received: by mail-qk1-f197.google.com with SMTP id br14-20020a05620a460e00b006cec4af5a2fso12391192qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NQaRIORouh5PGNwxNNc/P0MIv99YHmLbB7VcHRYE5ek=;
        b=tGdVKFL4nPtLiegLqud8arGKzcHQnCCVyTmuJ3GvWu41m/8EEUBVWTLDjtHlrNBY7g
         CshPmu5JBzfGG2pC3LQMb29qiMrs1hJWdDqpIP8r0ls9Nsj7Irm2XBaU1fTbKOcuMhpj
         OwRsuQ3HPkKpnkVcHBsjJSA6D7s6fIU6vRPT6jl4w64NaMTQzyUyvlppUSV0yyRee9pI
         dsTrc2UDAFWU3JwOi4h2MOILf3y3qHkHj+1aakYaCBt0jSRowEWesBh8CI4uKg07R1GU
         aLOvbRDh5a2bGCqZIN/fktolWUg8a8sm40tJjR9kJmiU+4aB78i87ssnvxeMiAg6KAWj
         AsIw==
X-Gm-Message-State: ACrzQf1XqKVSgMf6F1E9bpCdc7I8H/QmLE755ouQ9VpFBKSG101CrYYx
        Ux+Dh1lACB1dyzMsap2YpfFL5zANGGRHrmVXB/IAmQxknBxfii4zPq+qZD9IoMJ6rFcqd+KEeiy
        9P1rlg0+eVjeF7Kb6ltDLsdPo
X-Received: by 2002:ad4:5be1:0:b0:496:a686:2bec with SMTP id k1-20020ad45be1000000b00496a6862becmr21051713qvc.85.1664912043915;
        Tue, 04 Oct 2022 12:34:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5tzG6ZNsh+aR3v41H1W2JmcaMFErSNKPMzqwMZhRmPNkNIpkN7hRNRj2Y0ZR1OtrRNmgqlGQ==
X-Received: by 2002:ad4:5be1:0:b0:496:a686:2bec with SMTP id k1-20020ad45be1000000b00496a6862becmr21051683qvc.85.1664912043713;
        Tue, 04 Oct 2022 12:34:03 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id z5-20020a05622a028500b00342fb07944fsm13299811qtw.82.2022.10.04.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:34:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 1/3] mm/hugetlb: Fix race condition of uffd missing/minor handling
Date:   Tue,  4 Oct 2022 15:33:58 -0400
Message-Id: <20221004193400.110155-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004193400.110155-1-peterx@redhat.com>
References: <20221004193400.110155-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6022dea6a634..1f059acc38f3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5524,6 +5524,23 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	return handle_userfault(&vmf, reason);
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
@@ -5564,10 +5581,33 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (idx >= size)
 			goto out;
 		/* Check for page in userfault range */
-		if (userfaultfd_missing(vma))
-			return hugetlb_handle_userfault(vma, mapping, idx,
-						       flags, haddr, address,
-						       VM_UFFD_MISSING);
+		if (userfaultfd_missing(vma)) {
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
+			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+				ret = 0;
+				goto out;
+			}
+
+			return hugetlb_handle_userfault(vma, mapping, idx, flags,
+							haddr, address,
+							VM_UFFD_MISSING);
+		}
 
 		page = alloc_huge_page(vma, haddr, 0);
 		if (IS_ERR(page)) {
@@ -5633,9 +5673,14 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (userfaultfd_minor(vma)) {
 			unlock_page(page);
 			put_page(page);
-			return hugetlb_handle_userfault(vma, mapping, idx,
-						       flags, haddr, address,
-						       VM_UFFD_MINOR);
+			/* See comment in userfaultfd_missing() block above */
+			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+				ret = 0;
+				goto out;
+			}
+			return hugetlb_handle_userfault(vma, mapping, idx, flags,
+							haddr, address,
+							VM_UFFD_MINOR);
 		}
 	}
 
-- 
2.37.3

