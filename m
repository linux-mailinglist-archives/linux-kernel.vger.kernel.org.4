Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18335BC3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiISH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISH6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:58:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF991EED8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:58:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWH4W1kxvz14Qdw;
        Mon, 19 Sep 2022 15:54:03 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 15:58:07 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 15:58:06 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/9] mm: Use hotplug_memory_notifier() instead of register_hotmemory_notifier()
Date:   Mon, 19 Sep 2022 16:31:43 +0800
Message-ID: <20220919083152.1824305-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Patch [1-6] replace register_hotmemory_notifier() with hotplug_memory_notifier()
for every caller.
Patch [7] remove unused register_hotmemory_notifier().
Patch [8] replace IPC_CALLBACK_PRI with MM_BATCH_CALLBACK_PRI.
Patch [9] collect all priority of hotplug memory callback into include/linux/memory.h
for easy reading.

Liu Shixin (9):
  cgroup/cpuset: use hotplug_memory_notifier() directly
  fs/proc/kcore.c: use hotplug_memory_notifier() directly
  mm/slub.c: use hotplug_memory_notifier() directly
  mm/mmap: use hotplug_memory_notifier() directly
  mm/mm_init.c: use hotplug_memory_notifier() directly
  ACPI: HMAT: use hotplug_memory_notifier() directly
  memory: remove unused register_hotmemory_notifier()
  memory: replace IPC_CALLBACK_PRI with MM_BATCH_CALLBACK_PRI
  memory: clean up hotplug memory callback priority

 drivers/acpi/numa/hmat.c     |  7 +------
 fs/proc/kcore.c              |  7 +------
 include/linux/memory-tiers.h |  1 -
 include/linux/memory.h       | 15 +++++++--------
 kernel/cgroup/cpuset.c       |  7 +------
 mm/kasan/shadow.c            |  2 +-
 mm/ksm.c                     |  2 +-
 mm/mm_init.c                 |  8 +-------
 mm/mmap.c                    |  6 +-----
 mm/page_ext.c                |  2 +-
 mm/slub.c                    |  7 +------
 11 files changed, 16 insertions(+), 48 deletions(-)

-- 
2.25.1

