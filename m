Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1E706DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEQQKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEQQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:10:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A110DE47
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso620177276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684339800; x=1686931800;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgBNWBxudxifYf13fc5/OPTdkwgzhiJTdekK9406sZk=;
        b=xZ7BRyrRuqfjm0Tqe9XVSbolDZPqt9jPwAQAa6wtxikuVD0C8co7/c5Y9GurownWnE
         Vwb4VYj9ILg7MQSLYToewHVogtaYlXawfGom6s6TFghwK2Ye8vxhnGTSlxBKK024PdCw
         pW53F9+8Kt5WjPNu6wSsWwfHYaB3WT4L8FO8HoI/+DAJRD4/h+kGo7aJ2B8cPrgAVTso
         VY6HB3lvP0aYcDOt4Ipv5b1aIuQNkVwZrP/ekM4nH8cRI6aHFqD4VhzC4kQPdgBkwQia
         nxZcw+Zr4vXrF1Sv1dvHUCuW6bvBBplwGKHfNZxImBEq5kNy1lfgsZLDDROAw0zUDdja
         XQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339800; x=1686931800;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgBNWBxudxifYf13fc5/OPTdkwgzhiJTdekK9406sZk=;
        b=CD2RdVhPscRypOwlPHd2Oyxd6hsfPPHoYDYTRPCLWNO0VULJ4riUNYOuJus4EkyU2K
         5vslqDASkutUm+Vc4djqPMHaMf3xPqWDBeBSOTTpwmMtv4iPeq2u5iJAg5/Tp1K5uBqW
         ysWmVWHKUmMVk3whSqnmIqyNYTPmQDgjGc5HYv+D1YVzDPmyhukgvkZbt76mMiBdXOwE
         r5smAH/gw2BtTcHqwpweePdpCyOGj1ZhB6d48pi7lUzwiNpnXl06PaSid6bTqJ0aBrP/
         ZEHfi/rhKcXai9OaCriULn88GQJKy48MBtTV/16Xy67GL7wIUuL1cVJQH0q88bVO4hUY
         cxZg==
X-Gm-Message-State: AC+VfDxPvxP2OMDtXnBcmeZuooC84NpoAficHUlhxfQecAQEZvG4GVfZ
        xFbcgTLsJ0yJA0J3TQwCr5mEUByFF0npGg==
X-Google-Smtp-Source: ACHHUZ6l+7V7zh/9o9ANvR18oYNtr6L0CFFmD7ZWpbPjx5EADmQYczbHcI+60Zrnel4Bh7QQTNeC5syqi7/Hcw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a5b:e86:0:b0:ba8:4489:74c0 with SMTP id
 z6-20020a5b0e86000000b00ba8448974c0mr2602322ybr.6.1684339799873; Wed, 17 May
 2023 09:09:59 -0700 (PDT)
Date:   Wed, 17 May 2023 16:09:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517160948.811355-1-jiaqiyan@google.com>
Subject: [PATCH v1 0/3] Improve hugetlbfs read on HWPOISON hugepages
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

Jiaqi Yan (3):
  mm/hwpoison: find subpage in hugetlb HWPOISON list
  hugetlbfs: improve read HWPOISON hugepage
  selftests/mm: add tests for HWPOISON hugetlbfs read

 fs/hugetlbfs/inode.c                          |  62 +++-
 include/linux/mm.h                            |  23 ++
 mm/memory-failure.c                           |  26 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
 6 files changed, 419 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

-- 
2.40.1.606.ga4b1b128d6-goog

