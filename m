Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413EF5BC3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiISH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiISH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:58:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E701EED8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:58:12 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWH3t4XPfzMn4Q;
        Mon, 19 Sep 2022 15:53:30 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 15:58:10 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 15:58:10 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: [PATCH 9/9] memory: clean up hotplug memory callback priority
Date:   Mon, 19 Sep 2022 16:31:52 +0800
Message-ID: <20220919083152.1824305-10-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919083152.1824305-1-liushixin2@huawei.com>
References: <20220919083152.1824305-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priority of hotplug memory callback is defined in different file.
And there are some caller using number directly. Collect them together
into include/linux/memory.h for easy reading.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/acpi/numa/hmat.c     | 2 +-
 fs/proc/kcore.c              | 2 +-
 include/linux/memory-tiers.h | 1 -
 include/linux/memory.h       | 5 +++++
 kernel/cgroup/cpuset.c       | 2 +-
 mm/kasan/shadow.c            | 2 +-
 mm/ksm.c                     | 2 +-
 mm/mmap.c                    | 2 +-
 mm/page_ext.c                | 2 +-
 9 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 84dffb3dc30e..47c7fae8b6de 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -850,7 +850,7 @@ static __init int hmat_init(void)
 	hmat_register_targets();
 
 	/* Keep the table and structures if the notifier may use them */
-	if (!hotplug_memory_notifier(hmat_callback, 2))
+	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
 		return 0;
 out_put:
 	hmat_free_structures();
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 7692a360972d..98f3289556e4 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -689,7 +689,7 @@ static int __init proc_kcore_init(void)
 	add_modules_range();
 	/* Store direct-map area from physical memory map */
 	kcore_update_ram();
-	hotplug_memory_notifier(kcore_callback, 0);
+	hotplug_memory_notifier(kcore_callback, DEFAULT_CALLBACK_PRI);
 
 	return 0;
 }
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 965009aa01d7..fc9647b1b4f9 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -18,7 +18,6 @@
  * the same memory tier.
  */
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
-#define MEMTIER_HOTPLUG_PRIO	100
 
 struct memory_tier;
 struct memory_dev_type {
diff --git a/include/linux/memory.h b/include/linux/memory.h
index e5f71d3d9af8..e62d6d2b9c39 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -112,8 +112,13 @@ struct mem_section;
  * Priorities for the hotplug memory callback routines (stored in decreasing
  * order in the callback chain)
  */
+#define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
+#define HMAT_CALLBACK_PRI	2
 #define MM_BATCH_CALLBACK_PRI	10
+#define CPUSET_CALLBACK_PRI	10
+#define MEMTIER_HOTPLUG_PRIO	100
+#define KSM_CALLBACK_PRI	100
 
 #ifndef CONFIG_MEMORY_HOTPLUG
 static inline void memory_dev_init(void)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0c6db6a4f427..3ea2e836e93e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3647,7 +3647,7 @@ void __init cpuset_init_smp(void)
 	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
 	top_cpuset.effective_mems = node_states[N_MEMORY];
 
-	hotplug_memory_notifier(cpuset_track_online_nodes, 10);
+	hotplug_memory_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
 
 	cpuset_migrate_mm_wq = alloc_ordered_workqueue("cpuset_migrate_mm", 0);
 	BUG_ON(!cpuset_migrate_mm_wq);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 0e3648b603a6..2fba1f51f042 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -244,7 +244,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 
 static int __init kasan_memhotplug_init(void)
 {
-	hotplug_memory_notifier(kasan_mem_notifier, 0);
+	hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLBACK_PRI);
 
 	return 0;
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index c19fcca9bc03..7ba97f86d831 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3211,7 +3211,7 @@ static int __init ksm_init(void)
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 	/* There is no significance to this priority 100 */
-	hotplug_memory_notifier(ksm_memory_callback, 100);
+	hotplug_memory_notifier(ksm_memory_callback, KSM_CALLBACK_PRI);
 #endif
 	return 0;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 87ec40e00e2a..90e8718f0fe7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3747,7 +3747,7 @@ static int reserve_mem_notifier(struct notifier_block *nb,
 
 static int __meminit init_reserve_notifier(void)
 {
-	if (hotplug_memory_notifier(&reserve_mem_notifier, 0))
+	if (hotplug_memory_notifier(&reserve_mem_notifier, DEFAULT_CALLBACK_PRI))
 		pr_err("Failed registering memory add/remove notifier for admin reserve\n");
 
 	return 0;
diff --git a/mm/page_ext.c b/mm/page_ext.c
index affe80243b6d..b2ff5c9129f4 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -513,7 +513,7 @@ void __init page_ext_init(void)
 			cond_resched();
 		}
 	}
-	hotplug_memory_notifier(page_ext_callback, 0);
+	hotplug_memory_notifier(page_ext_callback, DEFAULT_CALLBACK_PRI);
 	pr_info("allocated %ld bytes of page_ext\n", total_usage);
 	invoke_init_callbacks();
 	return;
-- 
2.25.1

