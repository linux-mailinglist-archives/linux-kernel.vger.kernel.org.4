Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A411E60820D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJUX2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJUX2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:28:09 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7605E2A3882
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:28:08 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1om1Qr-0000ST-2D;
        Fri, 21 Oct 2022 19:28:05 -0400
Date:   Fri, 21 Oct 2022 19:28:05 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-team@meta.com, stable@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm,madvise,hugetlb: fix unexpected data loss with 
 MADV_DONTNEED on hugetlbfs
Message-ID: <20221021192805.366ad573@imladris.surriel.com>
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

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@kernel.org
Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")
---
v2: split out the most urgent fix for stable backports

 mm/madvise.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..c7105ec6d08c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -813,7 +813,14 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 	if (start & ~huge_page_mask(hstate_vma(vma)))
 		return false;
 
-	*end = ALIGN(*end, huge_page_size(hstate_vma(vma)));
+	/*
+	 * Madvise callers expect the length to be rounded up to PAGE_SIZE
+	 * boundaries, and may be unaware that this VMA uses huge pages.
+	 * Avoid unexpected data loss by rounding down the number of
+	 * huge pages freed.
+	 */
+	*end = ALIGN_DOWN(*end, huge_page_size(hstate_vma(vma)));
+
 	return true;
 }
 
@@ -828,6 +835,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!madvise_dontneed_free_valid_vma(vma, start, &end, behavior))
 		return -EINVAL;
 
+	if (start == end)
+		return 0;
+
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
 
-- 
2.37.2


