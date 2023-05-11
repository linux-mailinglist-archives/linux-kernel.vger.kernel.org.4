Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6196FEC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjEKG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbjEKG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC66595
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788225; x=1715324225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dB/KO3YPw8DRc4O11uwMQV7MwlURu0L5mJt/bhxjSuQ=;
  b=AmANfcgzBBe4GEZaJLt5E+23Cz2QzU09+H4CmZCbaO4U5e34bli3fgrZ
   6e5IiqGdGVCiJxXNVZazZqmV6fFEe5rHjSfgMuEMbzSBYdqgcr3cSfM3r
   d6vCd0RcKPcuwblAhwDFvcOZmUOAPaOpYcBCsWdAc8moGNbpPTuudDWX9
   oTsx0ItvXUb9gEIyOmrGOAv7UqYcwRWO7hRuIg8AFJbdzAaILmTks9HpG
   B2nmtcKb0m4GQIR2tJys7SjxjyKo4lJz6hGsc2xK8RjKOAVS5d0+psQC0
   yfIXSPWJJoSgGDuPPDRDOAcYAODxdHEksFhMcKz3yWoEJ0bnbwpLNiRHo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744549"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744549"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855356"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855356"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:50 -0700
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
Subject: [RFC 6/6] mm: prefer different zone list on different logical CPU
Date:   Thu, 11 May 2023 14:56:07 +0800
Message-Id: <20230511065607.37407-7-ying.huang@intel.com>
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

Originally, there are only one fallback and one no-fallback zone list
for each NUMA node (pglist_data->node_zonelists).  That is, all
logical CPUs of a NUMA node will use one zone list during the page
allocation.  This isn't a problem before, because there's at most one
instance for each zone type.

Now, we may create multiple zone instances for one zone type.  This
makes it possible for the different logical CPUs to prefer different
zone instance of one zone type to improve the zone lock scalability.
So, in this patch, multiple fallback and multiple no-fallback zone
lists can be created for each NUMA node based on the max zone
instances number for one zone type of the NUMA node.  Then different
logical CPUs will prefer different zone list based on logical CPU
number.

Combined with the previous patches in the series, this can improve the
scalability of zone lock contention effectively in the kbuild test
case.  Details can be found in the description of the previous patch
of the series.

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
 include/linux/gfp.h    |  6 ++-
 include/linux/mmzone.h |  5 ++-
 mm/mempolicy.c         |  6 ++-
 mm/mm_init.c           |  2 +-
 mm/page_alloc.c        | 93 ++++++++++++++++++++++++++++--------------
 5 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 60b5f43792ec..12903098122f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -164,7 +164,11 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
-	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
+	pg_data_t *pgdat = NODE_DATA(nid);
+	int li;
+
+	li = raw_smp_processor_id() % pgdat->max_nr_zones_per_type;
+	return pgdat->node_zonelists[li] + gfp_zonelist(flags);
 }
 
 #ifndef HAVE_ARCH_FREE_PAGE
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1a9b47bfc71d..11481f921697 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1240,10 +1240,11 @@ typedef struct pglist_data {
 	 * Generally the first zones will be references to this node's
 	 * node_zones.
 	 */
-	struct zonelist node_zonelists[MAX_ZONELISTS];
+	struct zonelist node_zonelists[MAX_NR_ZONES_PER_TYPE][MAX_ZONELISTS];
 
 	int nr_zones; /* number of populated zones in this node */
 	int nr_zone_types;
+	int max_nr_zones_per_type;
 #ifdef CONFIG_FLATMEM	/* means !SPARSEMEM */
 	struct page *node_mem_map;
 #ifdef CONFIG_PAGE_EXTENSION
@@ -1699,7 +1700,7 @@ static inline bool movable_only_nodes(nodemask_t *nodes)
 	 * at least one zone that can satisfy kernel allocations.
 	 */
 	nid = first_node(*nodes);
-	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
+	zonelist = &NODE_DATA(nid)->node_zonelists[0][ZONELIST_FALLBACK];
 	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
 	return (!z->zone) ? true : false;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0e0ce31a623c..35d3793e6a19 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1924,7 +1924,11 @@ unsigned int mempolicy_slab_node(void)
 		 */
 		struct zonelist *zonelist;
 		enum zone_type highest_zone_type = gfp_zone(GFP_KERNEL);
-		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
+		pg_data_t *pgdat = NODE_DATA(node);
+		int li;
+
+		li = raw_smp_processor_id() % pgdat->max_nr_zones_per_type;
+		zonelist = &pgdat->node_zonelists[li][ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zone_type,
 							&policy->nodes);
 		return z->zone ? zone_to_nid(z->zone) : node;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c1883362e71d..b950bdfc43f3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -40,7 +40,7 @@ void __init mminit_verify_zonelist(void)
 			/* Identify the zone and nodelist */
 			zoneid = i % MAX_NR_ZONES;
 			listid = i / MAX_NR_ZONES;
-			zonelist = &pgdat->node_zonelists[listid];
+			zonelist = &pgdat->node_zonelists[0][listid];
 			zone = &pgdat->node_zones[zoneid];
 			if (!populated_zone(zone))
 				continue;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d60fedc6961b..b03ea2f23d93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6351,20 +6351,25 @@ static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
  *
  * Add all populated zones of a node to the zonelist.
  */
-static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
+static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs,
+			       int zidx_in_type)
 {
+	struct zone_type_struct *zts;
 	struct zone *zone;
-	int zid = MAX_NR_ZONES;
-	int nr_zones = 0;
+	int zt, i, nr, nr_zones = 0;
 
-	do {
-		zid--;
-		zone = pgdat->node_zones + zid;
-		if (populated_zone(zone)) {
+	for (zt = MAX_NR_ZONE_TYPES - 1; zt >= 0; zt--) {
+		zts = pgdat->node_zone_types + zt;
+		if (!zts->present_pages)
+			continue;
+		nr = zts->last_zone_idx - zts->start_zone_idx + 1;
+		for (i = 0; i < nr; i++) {
+			zone = pgdat->node_zones + zts->start_zone_idx;
+			zone += (zidx_in_type + i) % nr;
 			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
 			check_highest_zone(zone_type_num(zone));
 		}
-	} while (zid);
+	}
 
 	return nr_zones;
 }
@@ -6462,27 +6467,48 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 }
 
 
+static void __build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
+					    unsigned nr_nodes, int zidx_in_type)
+{
+	struct zoneref *zonerefs;
+	int i;
+
+	zonerefs = pgdat->node_zonelists[zidx_in_type][ZONELIST_FALLBACK]._zonerefs;
+
+	for (i = 0; i < nr_nodes; i++) {
+		int nr_zones;
+
+		pg_data_t *node = NODE_DATA(node_order[i]);
+
+		nr_zones = build_zonerefs_node(node, zonerefs, zidx_in_type);
+		zonerefs += nr_zones;
+	}
+	zonerefs->zone = NULL;
+	zonerefs->zone_type = 0;
+}
+
 /*
  * Build zonelists ordered by node and zones within node.
  * This results in maximum locality--normal zone overflows into local
  * DMA zone, if any--but risks exhausting DMA zone.
  */
 static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
-		unsigned nr_nodes)
+					    unsigned nr_nodes)
 {
-	struct zoneref *zonerefs;
 	int i;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
+	for (i = 0; i < pgdat->max_nr_zones_per_type; i++)
+		__build_zonelists_in_node_order(pgdat, node_order, nr_nodes, i);
+}
 
-	for (i = 0; i < nr_nodes; i++) {
-		int nr_zones;
+static void __build_thisnode_zonelists(pg_data_t *pgdat, int zidx_in_type)
+{
+	struct zoneref *zonerefs;
+	int nr_zones;
 
-		pg_data_t *node = NODE_DATA(node_order[i]);
-
-		nr_zones = build_zonerefs_node(node, zonerefs);
-		zonerefs += nr_zones;
-	}
+	zonerefs = pgdat->node_zonelists[zidx_in_type][ZONELIST_NOFALLBACK]._zonerefs;
+	nr_zones = build_zonerefs_node(pgdat, zonerefs, zidx_in_type);
+	zonerefs += nr_zones;
 	zonerefs->zone = NULL;
 	zonerefs->zone_type = 0;
 }
@@ -6492,14 +6518,10 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
  */
 static void build_thisnode_zonelists(pg_data_t *pgdat)
 {
-	struct zoneref *zonerefs;
-	int nr_zones;
+	int i;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
-	zonerefs->zone = NULL;
-	zonerefs->zone_type = 0;
+	for (i = 0; i < pgdat->max_nr_zones_per_type; i++)
+		__build_thisnode_zonelists(pgdat, i);
 }
 
 /*
@@ -6565,7 +6587,7 @@ static void setup_min_unmapped_ratio(void);
 static void setup_min_slab_ratio(void);
 #else	/* CONFIG_NUMA */
 
-static void build_zonelists(pg_data_t *pgdat)
+static void __build_zonelists(pg_data_t *pgdat, int zidx_in_type)
 {
 	int node, local_node;
 	struct zoneref *zonerefs;
@@ -6573,8 +6595,8 @@ static void build_zonelists(pg_data_t *pgdat)
 
 	local_node = pgdat->node_id;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
+	zonerefs = pgdat->node_zonelists[zidx_in_type][ZONELIST_FALLBACK]._zonerefs;
+	nr_zones = build_zonerefs_node(pgdat, zonerefs, zidx_in_type);
 	zonerefs += nr_zones;
 
 	/*
@@ -6588,13 +6610,13 @@ static void build_zonelists(pg_data_t *pgdat)
 	for (node = local_node + 1; node < MAX_NUMNODES; node++) {
 		if (!node_online(node))
 			continue;
-		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs);
+		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs, zidx_in_type);
 		zonerefs += nr_zones;
 	}
 	for (node = 0; node < local_node; node++) {
 		if (!node_online(node))
 			continue;
-		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs);
+		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs, zidx_in_type);
 		zonerefs += nr_zones;
 	}
 
@@ -6602,6 +6624,14 @@ static void build_zonelists(pg_data_t *pgdat)
 	zonerefs->zone_type = 0;
 }
 
+static void build_zonelists(pg_data_t *pgdat)
+{
+	int i;
+
+	for (i = 0; i < pgdat->max_nr_zones_per_type; i++)
+		__build_zonelists(pgdat, i);
+}
+
 #endif	/* CONFIG_NUMA */
 
 /*
@@ -7899,6 +7929,7 @@ static void __init zones_init(struct pglist_data *pgdat)
 	int split_nr;
 
 	BUILD_BUG_ON(MAX_NR_ZONES_PER_TYPE > __MAX_NR_SPLIT_ZONES + 1);
+	pgdat->max_nr_zones_per_type = 1;
 	for (zt = 0; zt < MAX_NR_ZONE_TYPES; zt++) {
 		zts = pgdat->node_zone_types + zt;
 
@@ -7925,6 +7956,8 @@ static void __init zones_init(struct pglist_data *pgdat)
 				start_pfn = end_pfn;
 				zone++;
 			}
+			if (i > pgdat->max_nr_zones_per_type)
+				pgdat->max_nr_zones_per_type = i;
 		} else {
 			zone->type = zt;
 			zone->zone_start_pfn = zts->zts_start_pfn;
-- 
2.39.2

