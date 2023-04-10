Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0576DC752
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDJNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDJNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:39:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F25585
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:39:45 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pw9364LnPzSrKD;
        Mon, 10 Apr 2023 21:35:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 21:39:39 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <sidhartha.kumar@oracle.com>,
        <vishal.moola@gmail.com>
CC:     <muchun.song@linux.dev>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v6 0/6] userfaultfd: convert userfaultfd functions to use folios
Date:   Mon, 10 Apr 2023 21:39:26 +0800
Message-ID: <20230410133932.32288-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

This patch series converts several userfaultfd functions to use folios.

Change log:

v5->v6:
- Remove VM_BUG_ON_FOLIO from mfill_atomic_pte_copy() per Mike Kravetz.
  (patch 1)
- Keep flush_dcache_page() in copy_folio_from_user() to not change the
  behavior of the function, suggested by Vishal Moola. (patch 3)
- Rename copy_user_folio() to copy_user_large_folio(), suggested by Mike
  Kravetz. (patch 5)
- Add RB from Mike Kravetz. (patch 1-4,6)

v4->v5:
- Update commit description and change page_kaddr to kaddr, suggested by
  Matthew Wilcox. (patch 1,6)
- Remove pages_per_huge_page from copy_user_folio(), suggested by
  Matthew Wilcox. (patch 5)
- Add RB from Sidhartha Kumar. (patch 1,3,4)

v3->v4:
- Rebase onto mm-unstable per Andrew Morton. Update commit description
  because some function names are changed. (patch 1,4,6)

v2->v3:
- Split patch 2 into three patches, suggested by Mike Kravetz. (patch
  2-4)
- Add a new patch to convert copy_user_huge_page to copy_user_folio,
  suggested by Mike Kravetz. (patch 5)
- Fix two uninitialized bugs, thanks to Dan Carpenter. (patch 6)
- Do some indenting cleanups.

v1->v2:
Modified patch 2, suggested by Matthew Wilcox:
- Rename copy_large_folio_from_user() to copy_folio_from_user().
- Delete the inner_folio.
- kmap() and kmap_atomic() are converted to kmap_local_page(). Use
  pagefault_disable() to ensure that a deadlock will not occur.
- flush_dcache_folio() is placed outside the loop.

ZhangPeng (6):
  userfaultfd: convert mfill_atomic_pte_copy() to use a folio
  userfaultfd: use kmap_local_page() in copy_huge_page_from_user()
  userfaultfd: convert copy_huge_page_from_user() to
    copy_folio_from_user()
  userfaultfd: convert mfill_atomic_hugetlb() to use a folio
  mm: convert copy_user_huge_page() to copy_user_large_folio()
  userfaultfd: convert mfill_atomic() to use a folio

 include/linux/hugetlb.h  |  4 +-
 include/linux/mm.h       | 14 +++----
 include/linux/shmem_fs.h |  4 +-
 mm/hugetlb.c             | 40 +++++++++---------
 mm/memory.c              | 61 +++++++++++++---------------
 mm/shmem.c               | 16 ++++----
 mm/userfaultfd.c         | 88 ++++++++++++++++++++--------------------
 7 files changed, 109 insertions(+), 118 deletions(-)

-- 
2.25.1

