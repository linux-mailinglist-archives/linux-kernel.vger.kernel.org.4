Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788D6FEC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjEKG5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbjEKG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E174559E8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788224; x=1715324224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tCFV/T4kHcLFOaALLGy5Fe3D7GBcreIfwrmEbLI1Ro=;
  b=bWd4Np9Y7KSaMmnDn+SpzQZIkkKh0ZssV8TL1CZL9He+He7TfYCDUSVT
   lR8vsrnRCna6FdXKXbagVm3b/dGGXgeQLvctYI/xNUQ5dLhliJBMEo3Hc
   xmjnrHB5Y1yiLtUKYh01ZFGI1fHLOrG8tWSSFCcuoR+wGy0n28bucMVQT
   14+gU1hgCFB5HU42uLzMrVW/7cGyAAOxE/zgPxEo8oBO71uGmo89SyAkm
   2Sng2wDKYahrK9DH04Jc10PGhIP1yShegWBUDT1ywfmVWOL6B3c8x29vA
   7C1OGleUcD0I9fBOR+jQvbDoIrsp7qVoq2BUmklZNoDsEDvaPUOMvPOT7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744537"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744537"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855340"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855340"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:46 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 5/6] mm: create multiple zone instances for one zone type based on memory size
Date:   Thu, 11 May 2023 14:56:06 +0800
Message-Id: <20230511065607.37407-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511065607.37407-1-ying.huang@intel.com>
References: <20230511065607.37407-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More and more cores are put in one physical CPU (usually one NUMA node
too).  In 2023, one high-end server CPU has 56, 64, or more cores.
Even more cores per physical CPU are planned for future CPUs.  While
all cores in one physical CPU will contend for the page allocation on
one zone in most cases.  This causes heavy zone lock contention in
some workloads.  And the situation will become worse and worse in the
future.

For example, on an 2-socket Intel server machine with 224 logical
CPUs, if the kernel is built with `make -j224`, the zone lock
contention cycles% can reach up to about 12.7%.

To improve the scalability of the zone lock contention, in this patch,
we will create one zone instance for each about 256 GB memory of a
zone type generally.  In next patch of the series, different logical
CPUs will prefer different zone instances based on the logical CPU No.
So the total number of logical CPUs contend on one zone will be
reduced.  Thus the scalability is improved.

Combined with the next patch in the series ("mm: prefer different zone
list on different logical CPU"), the zone lock contention cycles%
reduces to less than 1.6% in the above kbuild test case when 4 zone
instances are created for ZONE_NORMAL.

Also tested with the will-it-scale/page_fault1 with 16 processes.
With the optimization, the benchmark score increases up to 18.2% and
the zone lock contention reduces from 13.01% to 0.56%.

To create multiple zone instances for a zone type, another choice is
to create zone instances based on the total number of logical CPUs.
We choose to use memory size because it is easier to be implemented.
In most cases, the more the cores, the larger the memory size is.
And, on system with larger memory size, the performance requirement of
the page allocator is usually higher.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mmzone.h            |  13 +++-
 include/linux/page-flags-layout.h |   2 +
 mm/page_alloc.c                   | 104 ++++++++++++++++++++++++++----
 3 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 18d64cf1263c..1a9b47bfc71d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -800,7 +800,12 @@ enum zone_type {
 
 };
 
-#define __MAX_NR_ZONES	__MAX_NR_ZONE_TYPES
+#ifdef CONFIG_64BIT
+#define __MAX_NR_SPLIT_ZONES	4
+#else
+#define __MAX_NR_SPLIT_ZONES	0
+#endif
+#define __MAX_NR_ZONES		(__MAX_NR_ZONE_TYPES + __MAX_NR_SPLIT_ZONES)
 
 #ifndef __GENERATING_BOUNDS_H
 
@@ -1106,6 +1111,12 @@ static inline bool zone_intersects(struct zone *zone,
 	return true;
 }
 
+#ifdef CONFIG_64BIT
+#define MAX_NR_ZONES_PER_TYPE	4
+#else
+#define MAX_NR_ZONES_PER_TYPE	1
+#endif
+
 struct zone_type_struct {
 	int			start_zone_idx;
 	int			last_zone_idx;
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index fcf194125768..a1f307720bea 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -32,6 +32,8 @@
 #define ZONES_SHIFT 2
 #elif MAX_NR_ZONES <= 8
 #define ZONES_SHIFT 3
+#elif MAX_NR_ZONES <= 16
+#define ZONES_SHIFT 4
 #else
 #error ZONES_SHIFT "Too many zones configured"
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 11e7e182bf5c..d60fedc6961b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7836,24 +7836,106 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 }
 #endif
 
+static void __init setup_zone_size(struct pglist_data *pgdat, struct zone *zone,
+				   enum zone_type zt, unsigned long start_pfn,
+				   unsigned long end_pfn)
+{
+	unsigned long spanned, absent;
+	unsigned long zstart_pfn, zend_pfn;
+
+	spanned = zone_spanned_pages_in_node(pgdat->node_id, zt,
+					     start_pfn,
+					     end_pfn,
+					     &zstart_pfn,
+					     &zend_pfn);
+	absent = zone_absent_pages_in_node(pgdat->node_id, zt,
+					   start_pfn,
+					   end_pfn);
+	zone->zone_start_pfn = zstart_pfn;
+	zone->spanned_pages = spanned;
+	zone->present_pages = spanned - absent;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	zone->present_early_pages = zone->present_pages;
+#endif
+}
+
+#define	SPLIT_ZONE_ALIGN_PAGES		((1UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
+
+#ifdef CONFIG_64BIT
+/* 254GB instead of 256GB to deal with ZONE_DMA32 and small memory holes */
+#define SPLIT_ZONE_PAGES		((254UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
+
+static int split_zone_type_number(struct pglist_data *pgdat,
+				  struct zone_type_struct *zts,
+				  struct zone *zone)
+{
+	int nr, remaining;
+
+	if (zts->present_pages < SPLIT_ZONE_PAGES * 2)
+		return 1;
+
+	/* Remaining number of zones can be used for the zone type */
+	remaining = 1 + (MAX_NR_ZONES - MAX_NR_ZONE_TYPES) -
+		((zone - pgdat->node_zones) - (zts - pgdat->node_zone_types));
+	nr = zts->present_pages / SPLIT_ZONE_PAGES;
+	nr = min3(nr, remaining, MAX_NR_ZONES_PER_TYPE);
+
+	return nr;
+}
+#else
+static int split_zone_type_number(struct pglist_data *pgdat,
+				  struct zone_type_struct *zts,
+				  struct zone *zone)
+{
+	return 1;
+}
+#endif
+
 static void __init zones_init(struct pglist_data *pgdat)
 {
-	enum zone_type j;
+	enum zone_type zt;
 	struct zone_type_struct *zts;
-	struct zone *zone;
+	struct zone *zone = pgdat->node_zones;
+	int split_nr;
 
-	for (j = 0; j < MAX_NR_ZONE_TYPES; j++) {
-		zts = pgdat->node_zone_types + j;
-		zone = pgdat->node_zones + j;
+	BUILD_BUG_ON(MAX_NR_ZONES_PER_TYPE > __MAX_NR_SPLIT_ZONES + 1);
+	for (zt = 0; zt < MAX_NR_ZONE_TYPES; zt++) {
+		zts = pgdat->node_zone_types + zt;
 
-		zts->start_zone_idx = zts->last_zone_idx = zone - pgdat->node_zones;
-		zone->type = j;
-		zone->zone_start_pfn = zts->zts_start_pfn;
-		zone->spanned_pages = zts->spanned_pages;
-		zone->present_pages = zts->present_pages;
+		zts->start_zone_idx = zone - pgdat->node_zones;
+		split_nr = split_zone_type_number(pgdat, zts, zone);
+		if (split_nr > 1) {
+			unsigned long split_span = zts->spanned_pages / split_nr;
+			unsigned long start_pfn = zts->zts_start_pfn;
+			unsigned long end_pfn;
+			unsigned long zts_end_pfn = zts->zts_start_pfn + zts->spanned_pages;
+			int i;
+
+			for (i = 0; i < split_nr && start_pfn < zts_end_pfn; i++) {
+				if (i == split_nr - 1) {
+					end_pfn = zts_end_pfn;
+				} else {
+					end_pfn = ALIGN(start_pfn + split_span,
+							SPLIT_ZONE_ALIGN_PAGES);
+					if (end_pfn > zts_end_pfn)
+						end_pfn = zts_end_pfn;
+				}
+				setup_zone_size(pgdat, zone, zt, start_pfn, end_pfn);
+				zone->type = zt;
+				start_pfn = end_pfn;
+				zone++;
+			}
+		} else {
+			zone->type = zt;
+			zone->zone_start_pfn = zts->zts_start_pfn;
+			zone->spanned_pages = zts->spanned_pages;
+			zone->present_pages = zts->present_pages;
 #if defined(CONFIG_MEMORY_HOTPLUG)
-		zone->present_early_pages = zts->present_early_pages;
+			zone->present_early_pages = zts->present_early_pages;
 #endif
+			zone++;
+		}
+		zts->last_zone_idx = (zone - pgdat->node_zones) - 1;
 	}
 }
 
-- 
2.39.2

