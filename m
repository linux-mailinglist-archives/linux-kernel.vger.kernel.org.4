Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943C6033B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJRUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJRUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:01:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22089D50A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:01:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc888dc62so149550597b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWINlDuaY2L8iLCd06Hh2mBWo/vkOwHDew9Pwd1Mff0=;
        b=X2mLtVikXakn4hxHFaq5nvCpGMMIKzqg3vy+vui5ke+ILw0deOuNgwKM1a/6a2ucxr
         GyieO1X4Q+l8LPgHbxJqxtzLU7CCTsM6/dZV01yipi3H88nNem4nHrCjA7LHUpqWFqDz
         q57Rdzz1h2zTCUkTdI0psI+kPDK9nMq9apT8gRuofGMLElnRw5FE1tLG+yehmAXGbwqh
         8W3RXe7c+5mFoVHOPi8KUjehorqwVUpCe1J7SBD8AJmpVZunyIjsMoyq497A8fbPX975
         1+SODuMBIi1s1C45CO8wwl+K1HYsDdGhXJA3ngFwLFXZxiqiZUqMaG/cljW4TUcnPrEp
         ugSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWINlDuaY2L8iLCd06Hh2mBWo/vkOwHDew9Pwd1Mff0=;
        b=mbCWUVcTflMe0XOiiriKB0Bd8XkqenERGzuY2GdX4/nwOT75UxeH68zTO/3IiFZd38
         RzeTi8pB9DIvtDw1ak0Un759zUMo0hJGVosin9uYlcGkYVt0Yb0V8MnP1RdJNY/lvWQ8
         ZgfZpULDDpORhFYNSBWec+7adoER7gj6QNFK+xaZ2VXMFWCFax7X+hieZpSU+bSpAE9g
         fuzNt/FYhL9DXGRXLg3SMTXomwqSwAeBcld3BsNiTPoojLBtfBCKBGN8zFXKZo6rDqhh
         +VDHpFJWV9pE0Tn1XDYW0U+r3ShGkRgUqt+ov7pUp7dfdEsrFuPj0EkLJpx9PhnG18n4
         DmRQ==
X-Gm-Message-State: ACrzQf2WBPgHQRG7bdeRnQBsOWr//ivR1WaIkO1H44BT7DitnDMvH+Kr
        qKVDxmiSmyPzLMDUgvzsF0K/c6/o8FEW8mGI
X-Google-Smtp-Source: AMsMyM6JNgKvtwBSVr1HSV1EZHxot8IHHFatQXp/SbInzL9njtXvXY9HUEar18bQ2lUU3mkPCCiAScNVf/8WgioJ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:d5c8:0:b0:356:6d6c:7b83 with SMTP
 id x191-20020a0dd5c8000000b003566d6c7b83mr3920713ywd.439.1666123294095; Tue,
 18 Oct 2022 13:01:34 -0700 (PDT)
Date:   Tue, 18 Oct 2022 20:01:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221018200125.848471-1-jthoughton@google.com>
Subject: [PATCH] hugetlbfs: don't delete error page from pagecache
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is very similar to the change that was made for shmem [1],
and it solves the same problem but for HugeTLBFS instead.

Currently, when poison is found in a HugeTLB page, the page is removed
from the page cache. That means that attempting to map or read that
hugepage in the future will result in a new hugepage being allocated
instead of notifying the user that the page was poisoned. As [1] states,
this is effectively memory corruption.

The fix is to leave the page in the page cache. If the user attempts to
use a poisoned HugeTLB page with a syscall, the syscall will fail with
EIO, the same error code that shmem uses. For attempts to map the page,
the thread will get a BUS_MCEERR_AR SIGBUS.

[1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/hugetlbfs/inode.c | 13 ++++++-------
 mm/hugetlb.c         |  4 ++++
 mm/memory-failure.c  |  5 ++++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index fef5165b73a5..7f836f8f9db1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -328,6 +328,12 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		} else {
 			unlock_page(page);
 
+			if (PageHWPoison(page)) {
+				put_page(page);
+				retval = -EIO;
+				break;
+			}
+
 			/*
 			 * We have the page, copy it to user space buffer.
 			 */
@@ -1111,13 +1117,6 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 static int hugetlbfs_error_remove_page(struct address_space *mapping,
 				struct page *page)
 {
-	struct inode *inode = mapping->host;
-	pgoff_t index = page->index;
-
-	hugetlb_delete_from_page_cache(page_folio(page));
-	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
-		hugetlb_fix_reserve_counts(inode);
-
 	return 0;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 97896165fd3f..5120a9ccbf5b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6101,6 +6101,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
+	ret = -EIO;
+	if (PageHWPoison(page))
+		goto out_release_unlock;
+
 	/*
 	 * We allow to overwrite a pte marker: consider when both MISSING|WP
 	 * registered, we firstly wr-protect a none pte which has no page cache
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 145bb561ddb3..bead6bccc7f2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1080,6 +1080,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 	int res;
 	struct page *hpage = compound_head(p);
 	struct address_space *mapping;
+	bool extra_pins = false;
 
 	if (!PageHuge(hpage))
 		return MF_DELAYED;
@@ -1087,6 +1088,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 	mapping = page_mapping(hpage);
 	if (mapping) {
 		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
+		/* The page is kept in page cache. */
+		extra_pins = true;
 		unlock_page(hpage);
 	} else {
 		unlock_page(hpage);
@@ -1104,7 +1107,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		}
 	}
 
-	if (has_extra_refcount(ps, p, false))
+	if (has_extra_refcount(ps, p, extra_pins))
 		res = MF_FAILED;
 
 	return res;
-- 
2.38.0.413.g74048e4d9e-goog

