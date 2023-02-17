Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3769A978
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBQK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQK4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:56:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63785383B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:56:21 -0800 (PST)
Received: from localhost.localdomain (unknown [119.155.16.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA112660212C;
        Fri, 17 Feb 2023 10:56:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676631379;
        bh=0cm+6yx0egHzCd1QYH/vCS5/vaBg8Fj6bVNYndgzW+0=;
        h=From:To:Cc:Subject:Date:From;
        b=Q0llhFTdI6/tcyIlD65gdzZxHM/rtq/TPPB4qZdjwFH0fWwTldJHYaRV93E4zP1+F
         E9bqb5P7I7VqBHbCYnjb3j4536wu1MaltQGuS7f8QWmr1iCw/3lr8jYEj4+OFRBBDG
         /rWPZCUFnBxIoFXTb+1qdlQGfqKLf12c/4p1kdGIQ4/WunzsoJDzlkPGBj6wHyzB5X
         PgWEbS/PXtaViLq6msS+F9a27gclSWwZHskdeZ0PfW3GSZ8l34pdfZZCEqLrXqRGGO
         GufqWl8APPHtTAUOK+EQ43ecAd82DvjV0fgqRmye0kMuXEaLpsxJnY7BQiKt4VJYsv
         +f/42e54O1HeA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     peterx@redhat.com, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] mm/userfaultfd: Support WP on multiple VMAs
Date:   Fri, 17 Feb 2023 15:55:58 +0500
Message-Id: <20230217105558.832710-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mwriteprotect_range() errors out if [start, end) doesn't fall in one
VMA. We are facing a use case where multiple VMAs are present in one
range of interest. For example, the following pseudocode reproduces the
error which we are trying to fix:
- Allocate memory of size 16 pages with PROT_NONE with mmap
- Register userfaultfd
- Change protection of the first half (1 to 8 pages) of memory to
  PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
- Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
  out.

This is a simple use case where user may or may not know if the memory
area has been divided into multiple VMAs.

We need an implementation which doesn't disrupt the already present
users. So keeping things simple, stop going over all the VMAs if any one
of the VMA hasn't been registered in WP mode. While at it, remove the
un-needed error check as well.

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reported-by: Paul Gofman <pgofman@codeweavers.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v4:
- Merge two separate patches and convert VM_WARN_ON() to
  VM_WARN_ON_ONCE()
- Update commit description and add tags

Changes since v3:
- Rebase on top of next-20230616

Changes since v2:
- Correct the return error code and cleanup a bit

Changes since v1:
- Correct the start and ending values passed to uffd_wp_range()
---
 mm/userfaultfd.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d916ff66..9057648248e7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -717,6 +717,8 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	struct mmu_gather tlb;
 	long ret;
 
+	VM_WARN_ON_ONCE(start < dst_vma->vm_start || start + len > dst_vma->vm_end,
+			"The address range exceeds VMA boundary.\n");
 	if (enable_wp)
 		mm_cp_flags = MM_CP_UFFD_WP;
 	else
@@ -741,9 +743,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp,
 			atomic_t *mmap_changing)
 {
+	unsigned long end = start + len;
+	unsigned long _start, _end;
 	struct vm_area_struct *dst_vma;
 	unsigned long page_mask;
 	long err;
+	VMA_ITERATOR(vmi, dst_mm, start);
 
 	/*
 	 * Sanitize the command parameters:
@@ -766,28 +771,30 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 		goto out_unlock;
 
 	err = -ENOENT;
-	dst_vma = find_dst_vma(dst_mm, start, len);
+	for_each_vma_range(vmi, dst_vma, end) {
 
-	if (!dst_vma)
-		goto out_unlock;
-	if (!userfaultfd_wp(dst_vma))
-		goto out_unlock;
-	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
-		goto out_unlock;
+		if (!userfaultfd_wp(dst_vma)) {
+			err = -ENOENT;
+			break;
+		}
 
-	if (is_vm_hugetlb_page(dst_vma)) {
-		err = -EINVAL;
-		page_mask = vma_kernel_pagesize(dst_vma) - 1;
-		if ((start & page_mask) || (len & page_mask))
-			goto out_unlock;
-	}
+		if (is_vm_hugetlb_page(dst_vma)) {
+			err = -EINVAL;
+			page_mask = vma_kernel_pagesize(dst_vma) - 1;
+			if ((start & page_mask) || (len & page_mask))
+				break;
+		}
 
-	err = uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
+		_start = max(dst_vma->vm_start, start);
+		_end = min(dst_vma->vm_end, end);
 
-	/* Return 0 on success, <0 on failures */
-	if (err > 0)
-		err = 0;
+		err = uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
 
+		/* Return 0 on success, <0 on failures */
+		if (err < 0)
+			break;
+		err = 0;
+	}
 out_unlock:
 	mmap_read_unlock(dst_mm);
 	return err;
-- 
2.39.1

