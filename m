Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3073698F86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBPJRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBPJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:17:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36911C7E7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:17:18 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD7F1660219B;
        Thu, 16 Feb 2023 09:17:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676539037;
        bh=p4O0JNqalB3DAfjfajI/CREv4U82nvTHiokxTLoKpk8=;
        h=From:To:Cc:Subject:Date:From;
        b=XU1WgQCRSsJY1e29r6FI2zJEyv/jAz6OCElh7uJFm7MQQsehZiLzQxp4UOkuiD890
         t0/pMZ7ivUSue7NYar66RJl2AkCmiY1rfDSLlRR2WHg+lZRipo9nfTsQY6bjMZqDGM
         h92lTZ6S/8Cyk9YRp0P4d1HL0Jr50gxW6KRtYmIrtTCzJgnh6BbsuN7FqF4cb9m9kE
         bdV2t1q+2TErvBlTpjw72dJy2pHXHJkOS74depQNWhQtvjQIguNxgmsoYLSjy5+7jP
         r7WqQZbiKXbLrLnyRodnotGJCmUA68KBF348rmo5u8rktY+0/LYzVEzsCzSgzOJsug
         ajRGcznHfbDHg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     peterx@redhat.com, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm/userfaultfd: Support WP on multiple VMAs
Date:   Thu, 16 Feb 2023 14:16:55 +0500
Message-Id: <20230216091656.2045471-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Reported-by: Paul Gofman <pgofman@codeweavers.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v3:
- Rebase on top of next-20230616

Changes since v2:
- Correct the return error code and cleanup a bit

Changes since v1:
- Correct the start and ending values passed to uffd_wp_range()
---
 mm/userfaultfd.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d916ff66..77c5839e591c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -741,9 +741,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
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
@@ -766,28 +769,30 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
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

