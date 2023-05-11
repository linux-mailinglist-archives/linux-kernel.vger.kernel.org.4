Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28366FEC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjEKG5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjEKG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C746A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788224; x=1715324224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdrDQdJZ6+h4q+PuPHT7D4LwVdhv/LqAu3N0e9ln1IM=;
  b=kBN0cnE5ZTRuhXugNKq3Nlbk4iuDzajbkRtKii2t7TERV9qPMLtmziNu
   GAMD5x28rpO361VnnvFRTDoFTWvl+w5xD59AMM3T9vraYmD8yKxjTVz2w
   llNoa90Af/SN0JHpxO0OssX6eCm4yAxaXmaL/0QBjQydbjVnqzvDmHaCA
   MtplotJE5pf5bAjJ0Ug6NchFnwAXsI9l8zrQdo4QyfIUuUPya/YixGXlK
   5api8qc/U95HcY45v+5pVDJv3UUNpl6fpOsYKzyDrnZ/TPah5Tly/1cWH
   TEoNjLYCXI45w9lLVIqP3B58D+or84Zt/XTBU1ThorHC2Ktsl/lF65eP0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744522"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855310"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855310"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:43 -0700
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
Subject: [RFC 4/6] mm: avoid show invalid zone in /proc/zoneinfo
Date:   Thu, 11 May 2023 14:56:05 +0800
Message-Id: <20230511065607.37407-5-ying.huang@intel.com>
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

In the following patch of the series, one or multiple zone instances
may be created for one zone type.  So the total number of zone
instances of a node becomes dynamic based on system configurations.
So, the real zone instance number instead of static max zone number is
used to show zone information in /proc/zoneinfo.

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
 include/linux/mmzone.h | 5 +++++
 mm/vmstat.c            | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0c569c5fa0d1..18d64cf1263c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1809,6 +1809,11 @@ static inline int last_zone_idx(pg_data_t *pgdat, enum zone_type zt)
 	return pgdat->node_zone_types[zt].last_zone_idx;
 }
 
+static inline int last_zone_idx_pgdat(pg_data_t *pgdat)
+{
+	return last_zone_idx(pgdat, MAX_NR_ZONE_TYPES - 1);
+}
+
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..bade3f50d1f8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1441,8 +1441,9 @@ static void walk_zones_in_node(struct seq_file *m, pg_data_t *pgdat,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
+	int last_zone_idx = last_zone_idx_pgdat(pgdat);
 
-	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+	for (zone = node_zones; zone - node_zones <= last_zone_idx; ++zone) {
 		if (assert_populated && !populated_zone(zone))
 			continue;
 
-- 
2.39.2

