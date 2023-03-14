Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E076B95F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCNNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCNNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:19:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D3F25E29
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:16:21 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PbYpm2ms7z17L6S;
        Tue, 14 Mar 2023 21:12:32 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 21:15:27 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 0/3] userfaultfd: convert userfaultfd functions to use folios
Date:   Tue, 14 Mar 2023 13:13:47 +0000
Message-ID: <20230314131350.924377-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

This patch series converts several userfaultfd functions to use folios.
And this series pass the userfaultfd selftests and the LTP userfaultfd
test cases.

Change log:

v1->v2:
In patch 2:
- Rename copy_large_folio_from_user() to copy_folio_from_user().
- Delete the inner_folio.
- kmap() and kmap_atomic() are converted to kmap_local_page(). Use
  pagefault_disable() to ensure that a deadlock will not occur.
- flush_dcache_folio() is placed outside the loop.

ZhangPeng (3):
  userfaultfd: convert mcopy_atomic_pte() to use a folio
  userfaultfd: convert __mcopy_atomic_hugetlb() to use a folio
  userfaultfd: convert __mcopy_atomic() to use a folio

 include/linux/hugetlb.h  |  4 +--
 include/linux/mm.h       |  3 +-
 include/linux/shmem_fs.h |  2 +-
 mm/hugetlb.c             | 25 +++++++-------
 mm/memory.c              | 27 +++++++--------
 mm/shmem.c               | 17 +++++----
 mm/userfaultfd.c         | 74 +++++++++++++++++++---------------------
 7 files changed, 72 insertions(+), 80 deletions(-)

-- 
2.25.1

