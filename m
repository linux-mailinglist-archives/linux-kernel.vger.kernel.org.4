Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D974CDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGJGyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGJGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:54:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC89DF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688972058; x=1720508058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GlsxORxC3PtLa2ddHZKW9QHSn6KCfv0VDJ0uOh64sas=;
  b=k1lMRXytJ+xpj0pA980F3VGU4i3Lp8cNYKt1J281cXh2zmFH8OhheaLr
   XWYafaSe+EV6e8K6NaPfvAhakYejYElKRFWtuftSyS9RCHLyUVOr3BccE
   VHXq5t/gHc1SahKxrsnEjLCSRMruXb4avwsJ47S10yHw2MmdnY7RJBsxr
   LP0lIPPprLrhyRBg2oB/FIalOXHJLgx0jKmb8FFMq/WhZQ2AoX4YpShna
   dh5iT0jxHOpdRhxRk45drXfWWJx3R+On50HzXaFEAnWWl8sLIdPoHdRAQ
   PRyxiS1/c7sRhWXcEDBYxaSSM7cvfNyUBQ7Z3UD8u8a79U65hyd6oUGSS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427961500"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427961500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750240550"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="750240550"
Received: from zhanggua-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:54:14 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 1/2] mm: add framework for PCP high auto-tuning
Date:   Mon, 10 Jul 2023 14:53:24 +0800
Message-Id: <20230710065325.290366-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710065325.290366-1-ying.huang@intel.com>
References: <20230710065325.290366-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocation performance requirements of different workloads
are usually different.  So, we often need to tune PCP (per-CPU
pageset) high to optimize the workload page allocation performance.
Now, we have a system wide sysctl knob (percpu_pagelist_high_fraction)
to tune PCP high by hand.  But, it's hard to find out the best value
by hand.  And one global configuration may not work best for the
different workloads that run on the same system.  One solution to
these issues is to tune PCP high of each CPU automatically.

This patch adds the framework for PCP high auto-tuning.  With it,
pcp->high will be changed automatically by tuning algorithm at
runtime.  Its default value (pcp->high_def) is the original PCP high
value calculated based on low watermark pages or
percpu_pagelist_high_fraction sysctl knob.  To avoid putting too many
pages in PCP, the original limit of percpu_pagelist_high_fraction
sysctl knob, MIN_PERCPU_PAGELIST_HIGH_FRACTION, is used to calculate
the max PCP high value (pcp->high_max).

This patch only adds the framework, so pcp->high will be set to
pcp->high_def always.  We will add actual auto-tuning algorithm in the
next patch in the series.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mmzone.h |  5 ++-
 mm/page_alloc.c        | 79 +++++++++++++++++++++++++++---------------
 2 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..7e2c1864a9ea 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -663,6 +663,8 @@ struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
+	int high_def;		/* default high watermark */
+	int high_max;		/* max high watermark */
 	int batch;		/* chunk size for buddy add/remove */
 	short free_factor;	/* batch scaling factor during free */
 #ifdef CONFIG_NUMA
@@ -820,7 +822,8 @@ struct zone {
 	 * the high and batch values are copied to individual pagesets for
 	 * faster access
 	 */
-	int pageset_high;
+	int pageset_high_def;
+	int pageset_high_max;
 	int pageset_batch;
 
 #ifndef CONFIG_SPARSEMEM
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..dd83c19f25c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2601,7 +2601,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch,
 static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		       bool free_high)
 {
-	int high = READ_ONCE(pcp->high);
+	int high = pcp->high;
 
 	if (unlikely(!high || free_high))
 		return 0;
@@ -2616,14 +2616,22 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
+static void tune_pcp_high(struct per_cpu_pages *pcp, int high_def)
+{
+	pcp->high = high_def;
+}
+
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
 				   unsigned int order)
 {
-	int high;
+	int high, high_def;
 	int pindex;
 	bool free_high;
 
+	high_def = READ_ONCE(pcp->high_def);
+	tune_pcp_high(pcp, high_def);
+
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
@@ -5976,14 +5984,15 @@ static int zone_batchsize(struct zone *zone)
 #endif
 }
 
-static int zone_highsize(struct zone *zone, int batch, int cpu_online)
+static int zone_highsize(struct zone *zone, int batch, int cpu_online,
+			 int high_fraction)
 {
 #ifdef CONFIG_MMU
 	int high;
 	int nr_split_cpus;
 	unsigned long total_pages;
 
-	if (!percpu_pagelist_high_fraction) {
+	if (!high_fraction) {
 		/*
 		 * By default, the high value of the pcp is based on the zone
 		 * low watermark so that if they are full then background
@@ -5996,15 +6005,15 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 		 * value is based on a fraction of the managed pages in the
 		 * zone.
 		 */
-		total_pages = zone_managed_pages(zone) / percpu_pagelist_high_fraction;
+		total_pages = zone_managed_pages(zone) / high_fraction;
 	}
 
 	/*
 	 * Split the high value across all online CPUs local to the zone. Note
 	 * that early in boot that CPUs may not be online yet and that during
 	 * CPU hotplug that the cpumask is not yet updated when a CPU is being
-	 * onlined. For memory nodes that have no CPUs, split pcp->high across
-	 * all online CPUs to mitigate the risk that reclaim is triggered
+	 * onlined. For memory nodes that have no CPUs, split the high value
+	 * across all online CPUs to mitigate the risk that reclaim is triggered
 	 * prematurely due to pages stored on pcp lists.
 	 */
 	nr_split_cpus = cpumask_weight(cpumask_of_node(zone_to_nid(zone))) + cpu_online;
@@ -6032,19 +6041,21 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
  * However, guaranteeing these relations at all times would require e.g. write
  * barriers here but also careful usage of read barriers at the read side, and
  * thus be prone to error and bad for performance. Thus the update only prevents
- * store tearing. Any new users of pcp->batch and pcp->high should ensure they
- * can cope with those fields changing asynchronously, and fully trust only the
- * pcp->count field on the local CPU with interrupts disabled.
+ * store tearing. Any new users of pcp->batch, pcp->high_def and pcp->high_max
+ * should ensure they can cope with those fields changing asynchronously, and
+ * fully trust only the pcp->count field on the local CPU with interrupts
+ * disabled.
  *
  * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
  * outside of boot time (or some other assurance that no concurrent updaters
  * exist).
  */
-static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
-		unsigned long batch)
+static void pageset_update(struct per_cpu_pages *pcp, unsigned long high_def,
+			   unsigned long high_max, unsigned long batch)
 {
 	WRITE_ONCE(pcp->batch, batch);
-	WRITE_ONCE(pcp->high, high);
+	WRITE_ONCE(pcp->high_def, high_def);
+	WRITE_ONCE(pcp->high_max, high_max);
 }
 
 static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats)
@@ -6064,20 +6075,21 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	 * need to be as careful as pageset_update() as nobody can access the
 	 * pageset yet.
 	 */
-	pcp->high = BOOT_PAGESET_HIGH;
+	pcp->high_def = BOOT_PAGESET_HIGH;
+	pcp->high_max = BOOT_PAGESET_HIGH;
 	pcp->batch = BOOT_PAGESET_BATCH;
 	pcp->free_factor = 0;
 }
 
-static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
-		unsigned long batch)
+static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high_def,
+					      unsigned long high_max, unsigned long batch)
 {
 	struct per_cpu_pages *pcp;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-		pageset_update(pcp, high, batch);
+		pageset_update(pcp, high_def, high_max, batch);
 	}
 }
 
@@ -6087,19 +6099,26 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
  */
 static void zone_set_pageset_high_and_batch(struct zone *zone, int cpu_online)
 {
-	int new_high, new_batch;
+	int new_high_def, new_high_max, new_batch;
 
 	new_batch = max(1, zone_batchsize(zone));
-	new_high = zone_highsize(zone, new_batch, cpu_online);
+	new_high_def = zone_highsize(zone, new_batch, cpu_online,
+				     percpu_pagelist_high_fraction);
+	new_high_max = zone_highsize(zone, new_batch, cpu_online,
+				     MIN_PERCPU_PAGELIST_HIGH_FRACTION);
+	new_high_def = min(new_high_def, new_high_max);
 
-	if (zone->pageset_high == new_high &&
+	if (zone->pageset_high_def == new_high_def &&
+	    zone->pageset_high_max == new_high_max &&
 	    zone->pageset_batch == new_batch)
 		return;
 
-	zone->pageset_high = new_high;
+	zone->pageset_high_def = new_high_def;
+	zone->pageset_high_max = new_high_max;
 	zone->pageset_batch = new_batch;
 
-	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
+	__zone_set_pageset_high_and_batch(zone, new_high_def, new_high_max,
+					  new_batch);
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
@@ -6175,7 +6194,8 @@ __meminit void zone_pcp_init(struct zone *zone)
 	 */
 	zone->per_cpu_pageset = &boot_pageset;
 	zone->per_cpu_zonestats = &boot_zonestats;
-	zone->pageset_high = BOOT_PAGESET_HIGH;
+	zone->pageset_high_def = BOOT_PAGESET_HIGH;
+	zone->pageset_high_max = BOOT_PAGESET_HIGH;
 	zone->pageset_batch = BOOT_PAGESET_BATCH;
 
 	if (populated_zone(zone))
@@ -6619,9 +6639,11 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 }
 
 /*
- * percpu_pagelist_high_fraction - changes the pcp->high for each zone on each
- * cpu. It is the fraction of total pages in each zone that a hot per cpu
- * pagelist can have before it gets flushed back to buddy allocator.
+ * percpu_pagelist_high_fraction - changes the pcp->high_def for each zone on
+ * each cpu. It is the fraction of total pages in each zone that a hot per cpu
+ * pagelist can have before it gets flushed back to buddy allocator.  This
+ * only set the default value, the actual value may be tuned automatically at
+ * runtime.
  */
 int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
 		int write, void *buffer, size_t *length, loff_t *ppos)
@@ -7008,13 +7030,14 @@ EXPORT_SYMBOL(free_contig_range);
 void zone_pcp_disable(struct zone *zone)
 {
 	mutex_lock(&pcp_batch_high_lock);
-	__zone_set_pageset_high_and_batch(zone, 0, 1);
+	__zone_set_pageset_high_and_batch(zone, 0, 0, 1);
 	__drain_all_pages(zone, true);
 }
 
 void zone_pcp_enable(struct zone *zone)
 {
-	__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+	__zone_set_pageset_high_and_batch(zone, zone->pageset_high_def,
+		zone->pageset_high_max, zone->pageset_batch);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-- 
2.39.2

