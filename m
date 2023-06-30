Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D467434B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3GIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjF3GIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:08:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D382681
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:08:46 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QslDg1z02zqVB2;
        Fri, 30 Jun 2023 14:05:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 14:08:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/2] mm: make show_free_areas() static
Date:   Fri, 30 Jun 2023 14:22:53 +0800
Message-ID: <20230630062253.189440-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630062253.189440-1-wangkefeng.wang@huawei.com>
References: <20230630062253.189440-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of show_free_areas() pass 0 and NULL, so we can directly
use show_mem() instead of show_free_areas(0, NULL), which could make
show_free_areas() a static function.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: update commit log and fix a missing show_free_areas() conversion

 arch/sparc/kernel/setup_32.c |  2 +-
 include/linux/mm.h           | 12 ------------
 mm/internal.h                |  6 ++++++
 mm/nommu.c                   |  8 ++++----
 mm/show_mem.c                |  4 ++--
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 1adf5c1c16b8..34ef7febf0d5 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -83,7 +83,7 @@ static void prom_sync_me(void)
 			     "nop\n\t" : : "r" (&trapbase));
 
 	prom_printf("PROM SYNC COMMAND...\n");
-	show_free_areas(0, NULL);
+	show_mem();
 	if (!is_idle_task(current)) {
 		local_irq_enable();
 		ksys_sync();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ddb140e14f3a..0a1314a3ffae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2218,18 +2218,6 @@ extern void pagefault_out_of_memory(void);
 #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
 #define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
 
-/*
- * Flags passed to show_mem() and show_free_areas() to suppress output in
- * various contexts.
- */
-#define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
-
-extern void __show_free_areas(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
-static void __maybe_unused show_free_areas(unsigned int flags, nodemask_t *nodemask)
-{
-	__show_free_areas(flags, nodemask, MAX_NR_ZONES - 1);
-}
-
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
diff --git a/mm/internal.h b/mm/internal.h
index a7d9e980429a..721ed07d7fd6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -61,6 +61,12 @@ void page_writeback_init(void);
 #define COMPOUND_MAPPED		0x800000
 #define FOLIO_PAGES_MAPPED	(COMPOUND_MAPPED - 1)
 
+/*
+ * Flags passed to __show_mem() and show_free_areas() to suppress output in
+ * various contexts.
+ */
+#define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
+
 /*
  * How many individual pages have an elevated _mapcount.  Excludes
  * the folio's entire_mapcount.
diff --git a/mm/nommu.c b/mm/nommu.c
index f670d9979a26..bff51d8ec66e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -990,7 +990,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 enomem:
 	pr_err("Allocation of length %lu from process %d (%s) failed\n",
 	       len, current->pid, current->comm);
-	show_free_areas(0, NULL);
+	show_mem();
 	return -ENOMEM;
 }
 
@@ -1223,20 +1223,20 @@ unsigned long do_mmap(struct file *file,
 	kmem_cache_free(vm_region_jar, region);
 	pr_warn("Allocation of vma for %lu byte allocation from process %d failed\n",
 			len, current->pid);
-	show_free_areas(0, NULL);
+	show_mem();
 	return -ENOMEM;
 
 error_getting_region:
 	pr_warn("Allocation of vm region for %lu byte allocation from process %d failed\n",
 			len, current->pid);
-	show_free_areas(0, NULL);
+	show_mem();
 	return -ENOMEM;
 
 error_vma_iter_prealloc:
 	kmem_cache_free(vm_region_jar, region);
 	vm_area_free(vma);
 	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
-	show_free_areas(0, NULL);
+	show_mem();
 	return -ENOMEM;
 
 }
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 01f8e9905817..09c7d036d49e 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -186,7 +186,7 @@ static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
  * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
  *   cpuset.
  */
-void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 {
 	unsigned long free_pcp = 0;
 	int cpu, nid;
@@ -406,7 +406,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	struct zone *zone;
 
 	printk("Mem-Info:\n");
-	__show_free_areas(filter, nodemask, max_zone_idx);
+	show_free_areas(filter, nodemask, max_zone_idx);
 
 	for_each_populated_zone(zone) {
 
-- 
2.41.0

