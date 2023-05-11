Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5E6FEC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjEKG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjEKG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524345FC9
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788223; x=1715324223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VzbZ9JgdFg4GPHXsQHxo4mdERaeauHzWD3g7U/m1sqc=;
  b=gFRMT8eSC+vsxfaKlcyPhASeu5G/bA0Z7UHTern++QWZ2r9g76h2E+wr
   F/0hzPEEMNWkuO4phXiGddvHhLXJxTZwZh+ck2esLkCX5dhW5A3Lx3GRY
   nmdYAIYd7p8f+lzERspTu6XrSKDLhBHX9latQLSO3DnVUafTOR04+73vq
   yHKX0B3A6oFhRV9ofi0g+pw9gqdRMvsx7IE4HG38+/iV1zla9cdORlMgj
   tdUVLF1MImFMq18VQkSRdrPXnplvkPsPE9TiAxI30+zpjUkUlZp1ou3R8
   ajWUU57paGenWwD+WAEwqjeEQJ25YpYkRslmttbDAC2q5hm/xFWKNog5v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744505"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744505"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855286"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855286"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:40 -0700
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
Subject: [RFC 3/6] mm: support multiple zone instances per zone type in memory online
Date:   Thu, 11 May 2023 14:56:04 +0800
Message-Id: <20230511065607.37407-4-ying.huang@intel.com>
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

Because there will be multiple movable zone instances, when a memory
section is onlined to movable zones, a movable zone instance needs to
be chosen similar as that for kernel zones.

The online target zone instance is chosen based on the zone instance
range for both movable and kernel zones.

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
 mm/memory_hotplug.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 24df4acbeeae..4e7cad6d48dd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -842,11 +842,37 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
 
 		if (zone_intersects(zone, start_pfn, nr_pages))
 			return zone;
+		if (start_pfn < zone->zone_start_pfn)
+			return zone;
 	}
 
 	return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_NORMAL)];
 }
 
+/*
+ * Returns a default movable memory zone for the given pfn range.
+ */
+static struct zone *default_movable_zone_for_pfn(int nid, unsigned long start_pfn,
+		unsigned long nr_pages)
+{
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	struct zone *zone;
+	int zid;
+
+	for (zid = start_zone_idx(pgdat, ZONE_MOVABLE);
+	     zid < last_zone_idx(pgdat, ZONE_MOVABLE);
+	     zid++) {
+		zone = &pgdat->node_zones[zid];
+
+		if (zone_intersects(zone, start_pfn, nr_pages))
+			return zone;
+		if (start_pfn < zone->zone_start_pfn)
+			return zone;
+	}
+
+	return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
+}
+
 /*
  * Determine to which zone to online memory dynamically based on user
  * configuration and system stats. We care about the following ratio:
@@ -904,7 +930,6 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 {
 	unsigned long online_pages = 0, max_pages, end_pfn;
 	struct page *page;
-	pg_data_t *pgdat;
 
 	if (!auto_movable_ratio)
 		goto kernel_zone;
@@ -953,9 +978,8 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 	    !auto_movable_can_online_movable(nid, group, nr_pages))
 		goto kernel_zone;
 #endif /* CONFIG_NUMA */
-	pgdat = NODE_DATA(nid);
 
-	return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
+	return default_movable_zone_for_pfn(nid, pfn, nr_pages);
 kernel_zone:
 	return default_kernel_zone_for_pfn(nid, pfn, nr_pages);
 }
@@ -965,8 +989,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 {
 	struct zone *kernel_zone = default_kernel_zone_for_pfn(nid, start_pfn,
 			nr_pages);
-	pg_data_t *pgdat = NODE_DATA(nid);
-	struct zone *movable_zone = &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
+	struct zone *movable_zone = default_movable_zone_for_pfn(nid, start_pfn,
+			nr_pages);
 	bool in_kernel = zone_intersects(kernel_zone, start_pfn, nr_pages);
 	bool in_movable = zone_intersects(movable_zone, start_pfn, nr_pages);
 
@@ -989,13 +1013,11 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
 		struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages)
 {
-	pg_data_t *pgdat = NODE_DATA(nid);
-
 	if (online_type == MMOP_ONLINE_KERNEL)
 		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);
 
 	if (online_type == MMOP_ONLINE_MOVABLE)
-		return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
+		return default_movable_zone_for_pfn(nid, start_pfn, nr_pages);
 
 	if (online_policy == ONLINE_POLICY_AUTO_MOVABLE)
 		return auto_movable_zone_for_pfn(nid, group, start_pfn, nr_pages);
-- 
2.39.2

