Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6D74B7C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGGUTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjGGUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:19:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F22105
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:19:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-263047f46f4so3725753a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688761159; x=1691353159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+DZafON7JsoL7Ay0CKBI9HDnuWj0nfz7I/atmY5O6E=;
        b=TldvMxXOlAitzanCYBdJPKTFsceaBUtZtfHE+NCMC7uRLSuEMdNFphYxZysQPlOWyt
         6IIkCSmbZ0QhAj6BdA2S0ZbkwbhR7x3BX+nwYBGgaOxeyqB+HsmP8eFpNEMX/EjaKoHw
         Osqpj/mJ1MqPaQbsakEeDVTjMuhGWE9GnXwVc8F/i6rZzYOS2/oL2zNYYKzVVfG8aSiy
         zLaZC2KHe+RKfCbvOVNYPOcE1YOJUR4cbXfL9Nm1YDmuYA43h0rfivcjthaU3URwFYSK
         96WU5M8uzwqIi+5+ywPkqjzgjsM0fGa0w0GzRv5r4kHftPEO8J5DvOvCOoUqVSHiN5aw
         6/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761159; x=1691353159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+DZafON7JsoL7Ay0CKBI9HDnuWj0nfz7I/atmY5O6E=;
        b=ItyuyXKON4UB+2+GHoelozx7BZmZJXPjydnVs3IQR+DMuO+tGfVICWK24nJDRKZDCe
         RIied27OUsPgmFI0KNyyYmPd6AWEeuC5QhffUteYpC7jIqzIJO9ifCihyXDM1d6lJqrc
         Igwjro/ULtmnRwoxyULx+BHE10YGdfG71DVpsmkPhMfLwMLOkPQGrKLYrZr/SOudAqax
         4Tnb1QRElHxl4uku9UX+lvdBOyybYm+dqUhkYWcckGqh5KShjifrX31v8djdYBIuh26E
         0VQhtEypjO+DMBg3lGbBnb4MDhn2IXlQucvUR0RhJRPdOZXaULGdjegzrZ9mtPOiJENt
         dO+A==
X-Gm-Message-State: ABy/qLZJBYizQ5/7tunZH7JSUm2Y0KTyaStCmsazBMwE/eD+og+34WlF
        kOwyR3Vk/v3+Q3fczTeSCUjZGgHKFSa9kg==
X-Google-Smtp-Source: APBJJlFlQ7RKBImKNNS3u3h3d6OO1HQ+Hd+V+iBkTossPJ4vugefj5v7Rlyl3uxPne+VgqOiM11xG9BXaRtiDQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:90a:ce18:b0:263:49d3:8024 with SMTP
 id f24-20020a17090ace1800b0026349d38024mr4778324pju.1.1688761159291; Fri, 07
 Jul 2023 13:19:19 -0700 (PDT)
Date:   Fri,  7 Jul 2023 20:19:03 +0000
In-Reply-To: <20230707201904.953262-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707201904.953262-4-jiaqiyan@google.com>
Subject: [PATCH v3 3/4] hugetlbfs: improve read HWPOISON hugepage
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a hugepage contains HWPOISON pages, read() fails to read any byte
of the hugepage and returns -EIO, although many bytes in the HWPOISON
hugepage are readable.

Improve this by allowing hugetlbfs_read_iter returns as many bytes as
possible. For a requested range [offset, offset + len) that contains
HWPOISON page, return [offset, first HWPOISON page addr); the next read
attempt will fail and return -EIO.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 fs/hugetlbfs/inode.c | 58 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..c2b807d37f85 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -282,6 +282,42 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 }
 #endif
 
+/*
+ * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
+ * Returns the maximum number of bytes one can read without touching the 1st raw
+ * HWPOISON subpage.
+ *
+ * The implementation borrows the iteration logic from copy_page_to_iter*.
+ */
+static size_t adjust_range_hwpoison(struct page *page, size_t offset, size_t bytes)
+{
+	size_t n = 0;
+	size_t res = 0;
+	struct folio *folio = page_folio(page);
+
+	/* First subpage to start the loop. */
+	page += offset / PAGE_SIZE;
+	offset %= PAGE_SIZE;
+	while (1) {
+		if (is_raw_hwp_subpage(folio, page))
+			break;
+
+		/* Safe to read n bytes without touching HWPOISON subpage. */
+		n = min(bytes, (size_t)PAGE_SIZE - offset);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+
+	return res;
+}
+
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
  * data. This provides functionality similar to filemap_read().
@@ -300,7 +336,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	while (iov_iter_count(to)) {
 		struct page *page;
-		size_t nr, copied;
+		size_t nr, copied, want;
 
 		/* nr is the maximum number of bytes to copy from this page */
 		nr = huge_page_size(h);
@@ -328,16 +364,26 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		} else {
 			unlock_page(page);
 
-			if (PageHWPoison(page)) {
-				put_page(page);
-				retval = -EIO;
-				break;
+			if (!PageHWPoison(page))
+				want = nr;
+			else {
+				/*
+				 * Adjust how many bytes safe to read without
+				 * touching the 1st raw HWPOISON subpage after
+				 * offset.
+				 */
+				want = adjust_range_hwpoison(page, offset, nr);
+				if (want == 0) {
+					put_page(page);
+					retval = -EIO;
+					break;
+				}
 			}
 
 			/*
 			 * We have the page, copy it to user space buffer.
 			 */
-			copied = copy_page_to_iter(page, offset, nr, to);
+			copied = copy_page_to_iter(page, offset, want, to);
 			put_page(page);
 		}
 		offset += copied;
-- 
2.41.0.255.g8b1d071c50-goog

