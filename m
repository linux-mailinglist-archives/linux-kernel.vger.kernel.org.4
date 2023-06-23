Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C163473BCD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjFWQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFWQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:40:28 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF559271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:23 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so549769a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687538423; x=1690130423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgkvS77jKBasQJ+d6+AqQuQkcASYxscDuOzFX9WAgds=;
        b=5jLczQMp0KSTUIagObRwmH0mr7CUCxFkzN7ENpojhmLHZ5GyofnMb+Nwwg0KbCrGdj
         3WAW+iB30hh1CIP2jXtjzzqMP6aQHq0SumA8ktu4p1yPKHIcW5cNVVYSJhPCOejXnvPu
         nKl3TIA+Sl6yCFYzA+PCG++nBBaxmuxCyqVDC21b2OKlQOdzRKNglDYsR9F3RTTJRMYl
         AAMVjrlGjICuPd2odT2iHSoPtCqMZtxg6+MlTsPgioLvqTryZxWthG+Vh2bh22MjQDaQ
         9B3I8J2H+/UZPeZ9NSrWwZ6tFvGN95BBwimNdsppJUqYqfC4usU/76Fm0JacOMdSXTse
         zXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538423; x=1690130423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgkvS77jKBasQJ+d6+AqQuQkcASYxscDuOzFX9WAgds=;
        b=bbmQA4hbEWOdzHKmRJuLjNnmXN6BVrOGgZuHl3zpy6po5SfZKydHVurMsjF8oRMizW
         6pdL00kUMtbvgRb5b/gBk1m58osQ/l+8T+EJP+Vh25GqafjnHswtaK2Jp7WV42pUASHU
         fn6iwOsel3hv193+zL8F6wiXceQxrAH9FB84cKODnnqkrpX4w2tHlHi6iwE6G0VJ17+t
         sy4k1EXgZVKtEb41hMbJC63B6mEKzASVo1/trxFRByHewvxntL7iNLlH1ru63NNlAuNW
         SOqE6rDlyMC7JeSoD8fKWNpL0mKH39woFYS45azydADvtZ/OJv89/9tNFqw4QvdAeotV
         V7Kg==
X-Gm-Message-State: AC+VfDz57/pOeeiZY0tKCGipU0DOa64ay0+WTpaq0eVv1pOZpGyXIk2f
        Kc8bGm9dGO7K3ByEEn0pEcXRo4RIRlKbhw==
X-Google-Smtp-Source: ACHHUZ7SVzvvZkW36k+iXmGUMtIymkIH4w+s1GAMmdhSj7Lx2MUYP2jnFMjcbaXPnGb5kaXvodFcOEtl1lhEHg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:fc01:0:b0:557:2a54:cf08 with SMTP id
 j1-20020a63fc01000000b005572a54cf08mr1060696pgi.6.1687538423324; Fri, 23 Jun
 2023 09:40:23 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:40:14 +0000
In-Reply-To: <20230623164015.3431990-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623164015.3431990-4-jiaqiyan@google.com>
Subject: [PATCH v2 3/4] hugetlbfs: improve read HWPOISON hugepage
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com,
        jthoughton@google.com, Jiaqi Yan <jiaqiyan@google.com>
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
 fs/hugetlbfs/inode.c | 58 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 90361a922cec..86879ca3ff1e 100644
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
2.41.0.162.gfafddb0af9-goog

