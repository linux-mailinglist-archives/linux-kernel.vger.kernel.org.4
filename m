Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98374B7C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjGGUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjGGUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:19:19 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB10FE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:19:15 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666eb721e75so2860686b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688761154; x=1691353154;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5cuWPEEHk0qemKXdohzw8tGEj12XWM9UTKttPYReOKw=;
        b=PaHzD33A8GbxvtEGuq9tWAYnBOW1xlL2mqiPI2ahcXOm9fn/nE59FBtXB4ixnXnOyi
         xeKzyZtFH98ipx/zrWpe9QI5rvEzBaA9YyLIHiy1e6jZo5fx/949E8OXquAa8EnMbarA
         rphXYw+5/NRi1dLVvfbKVoIKQ9IUV4Ori5NuSONz5JWNTPWJV85MBD85a1Lru3KvKb8b
         7VsjE9t8VWk/2KbXcHk7dUh6beDQU4dJeNJoMf1RNzK4VwTrjJhDSKBpLkYv8PX9CQRU
         RTB5aIUDCq6Be1gUe1Ii0aSlYbWQTU3c6+LAunFTzBAYzquOxCH/Sg6uVeHz6ABG5uE6
         M55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761154; x=1691353154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cuWPEEHk0qemKXdohzw8tGEj12XWM9UTKttPYReOKw=;
        b=IiTfqpLTs54h64eMIrPrqZU3Dah85Rq7geT+PbbqX70ZjyYBOAdo8LKHzjQr2DUC4D
         t0YLuNbMCCaSXLb/zqwlwdCWy9NKdl6CCap3hN+OTPO2Elt77gWfIsar/AJ7+s2JYWtD
         sZCIZXO5ncs6VTsxps6TSsp3U9TOJZOmci9TkatrW2Xp3inczVcZx6tQsKJwQjpMJUtB
         JB5PMdshE43T2OxN8CdrRH2KOPbZiKY3Qgq6hS9YOXdnASfgvxgxOFQBZufwCqPv1xkc
         JfR0x4jM+uVQQuDPp4lIqVw9qcf4V2iSuHWz2W2xcMfZhr1kt6foP7NOJUtmiK7YSfWW
         uRww==
X-Gm-Message-State: ABy/qLYXqhiZw63iMx/2EA6+d105vDGJ7C8uD7u0N5wKxEnTTiN13wo1
        lO2pSM1T+aWPwXtAbpbbZuRUGHw75pbjfg==
X-Google-Smtp-Source: APBJJlELEHiYxWCanU50B0NWcctTGr6R0VtA3e+AA6Y9l8crmkhCRoeflyMRWIMkxMRvVNTQwRWTUXdFG3wmTw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6a00:3923:b0:674:a3be:2773 with SMTP
 id fh35-20020a056a00392300b00674a3be2773mr8362712pfb.5.1688761154687; Fri, 07
 Jul 2023 13:19:14 -0700 (PDT)
Date:   Fri,  7 Jul 2023 20:19:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707201904.953262-1-jiaqiyan@google.com>
Subject: [PATCH v3 0/4] Improve hugetlbfs read on HWPOISON hugepages
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

Today when hardware memory is corrupted in a hugetlb hugepage,
kernel leaves the hugepage in pagecache [1]; otherwise future mmap or
read will suject to silent data corruption. This is implemented by
returning -EIO from hugetlb_read_iter immediately if the hugepage has
HWPOISON flag set.

Since memory_failure already tracks the raw HWPOISON subpages in a
hugepage, a natural improvement is possible: if userspace only asks for
healthy subpages in the pagecache, kernel can return these data.

This patchset implements this improvement. It consist of three parts.
The 1st commit exports the functionality to tell if a subpage inside a
hugetlb hugepage is a raw HWPOISON page. The 2nd commit teaches
hugetlbfs_read_iter to return as many healthy bytes as possible.
The 3rd commit properly tests this new feature.

[1] commit 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")

Changelog

v2 => v3
* Updates commit messages for future reader to know background and
  code details
* v3 is based on commit 5bb367dca2b9 ("Merge branch 'master' into
  mm-stable")

v1 => v2
* __folio_free_raw_hwp deletes all entries in raw_hwp_list before it
  traverses and frees raw_hwp_page.
* find_raw_hwp_page => __is_raw_hwp_subpage and __is_raw_hwp_subpage
  only returns bool instead of a raw_hwp_page entry.
* is_raw_hwp_subpage holds hugetlb_lock while checking
  __is_raw_hwp_subpage.
* No need to do folio_lock in adjust_range_hwpoison.
* v2 is based on commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM
  GUP-fast writing to file-backed mappings")

Jiaqi Yan (4):
  mm/hwpoison: delete all entries before traversal in
    __folio_free_raw_hwp
  mm/hwpoison: check if a subpage of a hugetlb folio is raw HWPOISON
  hugetlbfs: improve read HWPOISON hugepage
  selftests/mm: add tests for HWPOISON hugetlbfs read

 fs/hugetlbfs/inode.c                          |  58 +++-
 include/linux/hugetlb.h                       |  19 ++
 include/linux/mm.h                            |   7 +
 mm/hugetlb.c                                  |  10 +
 mm/memory-failure.c                           |  42 ++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
 8 files changed, 439 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

-- 
2.41.0.255.g8b1d071c50-goog

