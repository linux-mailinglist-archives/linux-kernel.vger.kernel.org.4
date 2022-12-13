Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963FD64B211
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiLMJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiLMJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE6FAD1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:11:20 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWXlH1vCJzRph1;
        Tue, 13 Dec 2022 17:10:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 0/8] mm: converted page idle and damon to use folios
Date:   Tue, 13 Dec 2022 17:27:27 +0800
Message-ID: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pfn_to_online_folio() to convert page idle and damon feature
to use folios.

For page idle feature, should we rename file name and Kconfig to folio
too, options?

Note: this is based on next-2022113, and some context depends on
patchset[1], please help us to review, thanks.

[1] https://lore.kernel.org/linux-mm/20221207230152.22938-1-vishal.moola@gmail.com/

Kefeng Wang (8):
  mm: memory_hotplug: add pfn_to_online_folio()
  mm: page_idle: Convert page idle to use folios
  mm: huge_memory: convert split_huge_pages_all() to use folios
  mm: damon: add temporary damon_get_folio()
  mm: damon: convert damon_ptep/pmdp_mkold() to use folios
  mm: damon: paddr: convert damon_pa_*() to use folios
  mm: damon: vaddr: convert damon_young_pmd_entry() to use folio
  mm: damon: remove unneed damon_get_page()

 include/linux/memory_hotplug.h |  7 +++
 mm/damon/ops-common.c          | 38 +++++++-------
 mm/damon/ops-common.h          |  3 +-
 mm/damon/paddr.c               | 44 +++++++---------
 mm/damon/vaddr.c               | 20 ++++----
 mm/huge_memory.c               | 22 ++++----
 mm/page_idle.c                 | 91 ++++++++++++++++------------------
 7 files changed, 112 insertions(+), 113 deletions(-)

-- 
2.35.3

