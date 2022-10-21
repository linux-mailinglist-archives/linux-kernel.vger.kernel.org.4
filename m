Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6F607F39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJUTp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiJUTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:45:53 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596512344C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:45:51 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1olxxi-0000eU-2z;
        Fri, 21 Oct 2022 15:45:46 -0400
Date:   Fri, 21 Oct 2022 15:45:46 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-team@meta.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm,madvise,hugetlb: fix unexpected data loss with 
 MADV_DONTNEED on hugetlbfs
Message-ID: <20221021154546.57df96db@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common use case for hugetlbfs is for the application to create
memory pools backed by huge pages, which then get handed over to
some malloc library (eg. jemalloc) for further management.

That malloc library may be doing MADV_DONTNEED calls on memory
that is no longer needed, expecting those calls to happen on
PAGE_SIZE boundaries.

However, currently the MADV_DONTNEED code rounds up any such
requests to HPAGE_PMD_SIZE boundaries. This leads to undesired
outcomes when jemalloc expects a 4kB MADV_DONTNEED, but 2MB of
memory get zeroed out, instead.

Use of pre-built shared libraries means that user code does not
always know the page size of every memory arena in use.

Avoid unexpected data loss with MADV_DONTNEED by rounding up
only to PAGE_SIZE (in do_madvise), and rounding down to huge
page granularity.

That way programs will only get as much memory zeroed out as
they requested.

While we're here, refactor madvise_dontneed_free_valid_vma
a little so mlocked hugetlb VMAs need MADV_DONTNEED_LOCKED.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")
---
 mm/madvise.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..a60e8e23c323 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -799,21 +799,29 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 					    unsigned long *end,
 					    int behavior)
 {
-	if (!is_vm_hugetlb_page(vma)) {
-		unsigned int forbidden = VM_PFNMAP;
+	unsigned int forbidden = VM_PFNMAP;
 
-		if (behavior != MADV_DONTNEED_LOCKED)
-			forbidden |= VM_LOCKED;
+	if (behavior != MADV_DONTNEED_LOCKED)
+		forbidden |= VM_LOCKED;
 
-		return !(vma->vm_flags & forbidden);
-	}
+	if (vma->vm_flags & forbidden)
+		return false;
+
+	if (!is_vm_hugetlb_page(vma))
+		return true;
 
 	if (behavior != MADV_DONTNEED && behavior != MADV_DONTNEED_LOCKED)
 		return false;
 	if (start & ~huge_page_mask(hstate_vma(vma)))
 		return false;
 
-	*end = ALIGN(*end, huge_page_size(hstate_vma(vma)));
+	/*
+	 * Madvise callers expect the length to be rounded up to the page
+	 * size, but they may not know the page size for this VMA is larger
+	 * than PAGE_SIZE! Round down huge pages to avoid unexpected data loss.
+	 */
+	*end = ALIGN_DOWN(*end, huge_page_size(hstate_vma(vma)));
+
 	return true;
 }
 
@@ -828,6 +836,10 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!madvise_dontneed_free_valid_vma(vma, start, &end, behavior))
 		return -EINVAL;
 
+	/* A small MADV_DONTNEED on a huge page gets rounded down to zero. */
+	if (start == end)
+		return 0;
+
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
 
-- 
2.37.2


