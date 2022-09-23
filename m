Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB35E723E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiIWDAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIWDAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:00:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A68647CC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:00:11 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYcJG4sk1zpVcD;
        Fri, 23 Sep 2022 10:57:18 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 11:00:09 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 11:00:08 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 0/8] mm: Use hotplug_memory_notifier() instead of register_hotmemory_notifier()
Date:   Fri, 23 Sep 2022 11:33:39 +0800
Message-ID: <20220923033347.3935160-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch f02c69680088 introduced register_hotmemory_notifier() to avoid a
compile problem with gcc-4.4.4:

    When CONFIG_MEMORY_HOTPLUG=n, we don't want the memory-hotplug notifier
    handlers to be included in the .o files, for space reasons.
    
    The existing hotplug_memory_notifier() tries to handle this but testing
    with gcc-4.4.4 shows that it doesn't work - the hotplug functions are
    still present in the .o files.

Since patch 316346243be6 has already updated the minimum gcc version to 5.1.
The previous problem mentioned in patch f02c69680088 is not existed. So we
can now revert to use hotplug_memory_notifier() directly rather than
register_hotmemory_notifier().

In the last patch, we move all hotplug memory notifier priority to same
file for easy sorting.

Patch [1-6] replace register_hotmemory_notifier() with hotplug_memory_notifier()
for every caller.
Patch [7] remove unused register_hotmemory_notifier().
Patch [8] move all priority of hotplug memory callback into include/linux/memory.h
for easy sorting.

v3->v4: Add back the missed Reviewed-by from v2 according to David's reminder.
v2->v3: fold last two patches, change MM_BATCH_CALLBACK_PRI to
MM_COMPUTE_BATCH_PRI and rewrite the commit log.
v1->v2: fix compile error of patch [4,5].

Liu Shixin (8):
  cgroup/cpuset: use hotplug_memory_notifier() directly
  fs/proc/kcore.c: use hotplug_memory_notifier() directly
  mm/slub.c: use hotplug_memory_notifier() directly
  mm/mmap: use hotplug_memory_notifier() directly
  mm/mm_init.c: use hotplug_memory_notifier() directly
  ACPI: HMAT: use hotplug_memory_notifier() directly
  memory: remove unused register_hotmemory_notifier()
  memory: move hotplug memory notifier priority to same file for easy
    sorting

 drivers/acpi/numa/hmat.c     |  7 +------
 fs/proc/kcore.c              |  7 +------
 include/linux/memory-tiers.h |  1 -
 include/linux/memory.h       | 15 +++++++--------
 kernel/cgroup/cpuset.c       |  7 +------
 mm/kasan/shadow.c            |  2 +-
 mm/ksm.c                     |  2 +-
 mm/memory-tiers.c            |  2 +-
 mm/mm_init.c                 |  8 +-------
 mm/mmap.c                    |  6 +-----
 mm/page_ext.c                |  2 +-
 mm/slub.c                    |  7 +------
 12 files changed, 17 insertions(+), 49 deletions(-)

-- 
2.25.1

