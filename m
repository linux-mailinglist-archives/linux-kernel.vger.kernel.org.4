Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E057706DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjEQQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjEQQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:10:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E9268C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed50a6so1875273276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684339803; x=1686931803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4afwjJMNRVLZWsRS4KvH1UWrNK7pSNXsAEU4xOupb6Y=;
        b=axQ41qX1bwiHJbGU6rrt3d0A/FAXog8UjScM7eAjhvO/VZz1uMpCiXfvNRTVLE3/8S
         OZBGnYY6NkXRzHCcXWb2deoRCp4d/IhzJGUh0wL1C9VUN2hWUXoDFRR7iXDO/6Wl+fp6
         uGwIan2D0pw5vLh98Q1bRnbHw7ENy/oETdEpQ8m8wE2UMa7QnS7eUD2E3CuA2ie5z6mc
         Q3h9U6cGrBmDrF/iHiQeKEXmB/AqVVSqZ2+ND4BoFj+Gq0VO1MO60ZY7L3bL5eaUrqOU
         INdMQsIXL5q34h0EXxp3baPOV9jVqICirZUX4wvP0xgrgao+63OSBIe1/yr8wrkYoNgo
         iHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339803; x=1686931803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4afwjJMNRVLZWsRS4KvH1UWrNK7pSNXsAEU4xOupb6Y=;
        b=gTU8lhy78Fxb6pl31YdIN0kAxN3qB2r4wsr63/5erKEpJdalBKbMYGmvkDnKWGLJPj
         Vaj4l6LS2nHS4Zz25tebrEchJZlJKKBSfZ30xYHmzIky/LUyWiGpJ8xC23xwCA8kzLvz
         TWeINWo5Gc8HLowS30nk2v/X9EJUsBpL+YHuswFLl5kswPObo+H+ROnlI+sntHo/GTNx
         V5IUNiwDmZewFNGKoLYFF+dBbf50utgjL8Y6EdDlStx3H2YpJxHsFWS9jLrVnvPFr/WL
         IihoIiCwBjKV0AOUpBxNWwLDgstCdbKK00zvSBLJiomA+BFkYjSAhDkMebgFhhHObL1W
         Rd4Q==
X-Gm-Message-State: AC+VfDwIILVy9u0wOG2FXGuGFL0HOWSPH/V5ctpz/Ga//6KQovxxt4iT
        ZIMydNVgToA+azzC5YB02Qw+8zGhT0+whw==
X-Google-Smtp-Source: ACHHUZ5jetsUCam+N66UMpWQp6kuy86/2g1XYzaVSDPJC584NE14V4DeuwZ0XEKGYqDKMI3zAZXmMykVQH43Wg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a25:ce12:0:b0:ba8:1fab:4f99 with SMTP id
 x18-20020a25ce12000000b00ba81fab4f99mr2620511ybe.9.1684339803118; Wed, 17 May
 2023 09:10:03 -0700 (PDT)
Date:   Wed, 17 May 2023 16:09:47 +0000
In-Reply-To: <20230517160948.811355-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517160948.811355-3-jiaqiyan@google.com>
Subject: [PATCH v1 2/3] hugetlbfs: improve read HWPOISON hugepage
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        naoya.horiguchi@nec.com, shy828301@gmail.com, linmiaohe@huawei.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
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

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 fs/hugetlbfs/inode.c | 62 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ecfdfb2529a3..1baa08ec679f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -282,6 +282,46 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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
+	folio_lock(folio);
+
+	/* First subpage to start the loop. */
+	page += offset / PAGE_SIZE;
+	offset %= PAGE_SIZE;
+	while (1) {
+		if (find_raw_hwp_page(folio, page) != NULL)
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
+	folio_unlock(folio);
+
+	return res;
+}
+
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
  * data. This provides functionality similar to filemap_read().
@@ -300,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	while (iov_iter_count(to)) {
 		struct page *page;
-		size_t nr, copied;
+		size_t nr, copied, want;
 
 		/* nr is the maximum number of bytes to copy from this page */
 		nr = huge_page_size(h);
@@ -328,16 +368,26 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
2.40.1.606.ga4b1b128d6-goog

