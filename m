Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA873BCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjFWQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFWQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:40:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC2273A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-553d27fe4baso690001a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687538419; x=1690130419;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=804BUznaRJxahSpZ+yggx/c4ITZ/f8vCCZVijpr48F0=;
        b=jZtiAGYTk81uuMQHYSplK6RArvXfVokurmnT+Vp8LofB/qX9ED8oW1HAtA5pXXksBb
         aIw+W3qBavUHtjsRfeRuaEtO1FRKQ78PAfLrP9rYwa4Op1nP7cp6WAn9O2HiKuFpgCky
         1o+u+u51Ew8k+opL+LDIxrXpaAKFUnJI2VL7KDJdHB0LTq5kg8q/OGU/WIIEFRyx2DN2
         UTCsrX1Bm7CGE0QSzXT6fyer9Jb+qNrn4lI17/UO9JQV/LQKUxWF4d64VlCQFjpRUlxJ
         7eVuBzL20yR2RMclW5Tll2LhJ6WjDVhlCmzC8e4XXRRxBnSoLvZmWLvxaGOs/jNqeRwU
         hD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538419; x=1690130419;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=804BUznaRJxahSpZ+yggx/c4ITZ/f8vCCZVijpr48F0=;
        b=eM7NTJjK5nbiKlThIvjST2GbeXfxzIkcSSb3ealdjDl1w9FKCblw5KmM+deKHa0b0h
         nv4sFSqgkUFqPHpO8iFiUDetUNTVdq4nFTIZrQnmYEewiED0hXzw6wwDUyT9qvi4vt7t
         6JN1dGD2FhEWklvq+ExZwYiAExZMuHB8MVhCmonkFG6Kpv15TnLZPVISKih1kh1zefm+
         aLToQqACYw/QRFyCLP7RfNb5qZpDWkZEPyRi5dRPszbraUXqcNIHU8NpWlO5k6NkGkgJ
         x6hWjf+HAL5o6ga/cDdwXj6btXdTHT1Lt3fzgoo29Y1fvFBKbTpIQlCPJzAPjxfwV38m
         tyjA==
X-Gm-Message-State: AC+VfDyX4vWopz1TjpZI/X4ZwLE/pRYb6hg5Bd0bKFG16RcGQOKuJm8u
        ZcKbLLqVMquwvwc+Ud22u1fjqP7qqxzTXA==
X-Google-Smtp-Source: ACHHUZ6hZpPhnIyx5Qe+Ysjsk1wI49515RocMiYK0cPkTeizIG7/lNuGAnyLD/Atj+FQ4LQuCVD7fiYmsBUw5Q==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:555d:0:b0:543:9759:1952 with SMTP id
 f29-20020a63555d000000b0054397591952mr2457037pgm.11.1687538419140; Fri, 23
 Jun 2023 09:40:19 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:40:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623164015.3431990-1-jiaqiyan@google.com>
Subject: [PATCH v2 0/4] Improve hugetlbfs read on HWPOISON hugepages
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

Today when hardware memory is corrupted in a hugetlb hugepage,
kernel leaves the hugepage in pagecache [1]; otherwise future mmap or
read will suject to silent data corruption. This is implemented by
returning -EIO from hugetlb_read_iter immediately if the hugepage has
HWPOISON flag set.

Since memory_failure already tracks the raw HWPOISON subpages in a
hugepage, a natural improvement is possible: if userspace only asks for
healthy subpages in the pagecache, kernel can return these data.

This patchset implements this improvement. The 1st commit fixes an issue
in __folio_free_raw_hwp. The 2nd commit exports the functionality to
tell if a subpage inside a hugetlb hugepage is a raw HWPOISON page.
The 3rd commit teaches hugetlbfs_read_iter to return as many healthy
bytes as possible. The last commit properly tests this new feature.

[1] commit 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")

Changelog

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
2.41.0.162.gfafddb0af9-goog

