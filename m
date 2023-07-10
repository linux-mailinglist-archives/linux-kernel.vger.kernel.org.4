Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3F74CDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGJGya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGJGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:54:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7EE129
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688972061; x=1720508061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqtL2s8WqXvRLMZvsfWXtVAKECayu9UX3tE/H+XNNpY=;
  b=Wc8rX1WWeDVfdlXbCSVhVW43wQ0CcwXd6ICEcRWurIXeyRL7+23k+pwz
   24AtFKQAG7NQUXedoD94gMX7EDRpK3NO9xjlyEntCIWalPaahsrmsP3ge
   LXKnixwxX2wiTsnqKPLbp4SrWbrYUBa3rzpD7e9LjKNIYKCOwoDro3quT
   azXjtHFcT7tZsW5MxsUtO7Tgzi4OSpO6kWeA2JE8AhXmRcxaYrvMIrP50
   87lJgcGA0Z2rltlNnQ6Pc3FoLjJpsW4NOKasBlXtiySv0/D5j+Y7PES3A
   Sgm5UocHfy9Vd1HgJrsGgXry6gDgjPysv6YjWtj7OjW1N3ylycFg9AoIf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427961518"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427961518"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750240562"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="750240562"
Received: from zhanggua-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:54:18 -0700
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
Subject: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
Date:   Mon, 10 Jul 2023 14:53:25 +0800
Message-Id: <20230710065325.290366-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710065325.290366-1-ying.huang@intel.com>
References: <20230710065325.290366-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

To auto-tune PCP high for each CPU automatically, an
allocation/freeing depth based PCP high auto-tuning algorithm is
implemented in this patch.

The basic idea behind the algorithm is to detect the repetitive
allocation and freeing pattern with short enough period (about 1
second).  The period needs to be short to respond to allocation and
freeing pattern changes quickly and control the memory wasted by
unnecessary caching.

To detect the repetitive allocation and freeing pattern, the
alloc/free depth is calculated for each tuning period (1 second) on
each CPU.  To calculate the alloc/free depth, we track the alloc
count.  Which increases for page allocation from PCP and decreases for
page freeing to PCP.  The alloc depth is the maximum alloc count
difference between the later large value and former small value.
While, the free depth is the maximum alloc count difference between
the former large value and the later small value.

Then, the average alloc/free depth in multiple tuning periods is
calculated, with the old alloc/free depth decay in the average
gradually.

Finally, the PCP high is set to be the smaller value of average alloc
depth and average free depth, after clamped between the default and
the max PCP high.  In this way, pure allocation or freeing will not
enlarge the PCP high because PCP doesn't help.

We have tested the algorithm with several workloads on Intel's
2-socket server machines.

Will-it-scale/page_fault1
=========================

On one socket of the system with 56 cores, 56 workload processes are
run to stress the kernel memory allocator.  Each workload process is
put in a different memcg to eliminate the LRU lock contention.

                                       base     optimized
                                       ----     -----​----
Thoughput (GB/s)                       34.3          75.0
native_queued_spin_lock_slowpath%      60.9           0.2

This is a simple workload that each process allocates 128MB pages then
frees them repetitively.  So, it's quite easy to detect its allocation
and freeing pattern and adjust PCP high accordingly.  The optimized
kernel almost eliminates the lock contention cycles% (from 60.9% to
0.2%).  And its benchmark score increases 118.7%.

Kbuild
======

"make -j 224" is used to build the kernel in parallel on the 2-socket
server system with 224 logical CPUs.

                                       base     optimized
                                       ----     -----​----
Build time (s)                       162.67        162.67​
native_queued_spin_lock_slowpath%     17.00         12.28​
rmqueue%                              11.53          8.33​
Free_unref_page_list%                  3.85          0.54​
folio_lruvec_lock_irqsave%             1.21          1.96​

The optimized kernel reduces cycles of the page allocation/freeing
functions from ~15.38% to ~8.87% via enlarging the PCP high when
necessary.  The system overhead lock contention cycles% decreases
too.  But the benchmark score hasn't visible change.  There should be
other bottlenecks.

We also captured /proc/meminfo during test.  After a short
while (about 10s) from the beginning of the test, the
Memused (MemTotal - MemFree) of the optimized kernel is higher than
that of the base kernel for the increased PCP high.  But in the second
half of the test, the Memused of the optimized kernel decreases to the
same level of that of the base kernel.  That is, PCP high is decreased
effectively for the decreased page allocation requirements.

Netperf/SCTP_STREAM_MANY

On another 2-socket server with 128 logical CPUs.  64 processes of
netperf are run with the netserver runs on the same machine (that is,
loopback network is used).

                                      base      optimized
                                      ----      -----​----
Throughput (MB/s)​	              7136           8489       +19.0%
vmstat.cpu.id%​		                73.05          63.73     -9.3
vmstat.procs.r​		                34.1           45.6     +33.5%
meminfo.Memused​		   5479861        8492875       +55.0%
perf-stat.ps.cpu-cycles​	  1.04e+11       1.38e+11       +32.3%
perf-stat.ps.instructions​	  0.96e+11       1.14e+11       +17.8%
perf-profile.free_unref_page%            2.46           1.65     -0.8
latency.99%.__alloc_pages​	         4.28           2.21    -48.4%
latency.99%.__free_unref_page            4.11           0.87    -78.8%​

From the test results, the throughput of benchmark increases 19.0%.
That comes from the increased CPU cycles and instructions per
second (perf-stat.ps.cpu-cycles and perf-stat.ps.instructions), that
is, reduced CPU idle.  And, perf-profile shows that page allocator
cycles% isn't high.  So, the reduced CPU idle may comes from the page
allocation/freeing latency reduction, which influence the network
behavior.

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
 include/linux/mmzone.h |  8 +++++++
 mm/page_alloc.c        | 50 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7e2c1864a9ea..cd9b497cd596 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -670,6 +670,14 @@ struct per_cpu_pages {
 #ifdef CONFIG_NUMA
 	short expire;		/* When 0, remote pagesets are drained */
 #endif
+	int alloc_count;	/* alloc/free count from tune period start */
+	int alloc_high;		/* max alloc count from tune period start */
+	int alloc_low;		/* min alloc count from tune period start */
+	int alloc_depth;	/* alloc depth from tune period start */
+	int free_depth;		/* free depth from tune period start */
+	int avg_alloc_depth;	/* average alloc depth */
+	int avg_free_depth;	/* average free depth */
+	unsigned long tune_start; /* tune period start timestamp */
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
 	struct list_head lists[NR_PCP_LISTS];
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd83c19f25c6..4d627d96e41a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2616,9 +2616,38 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
+#define	PCP_AUTO_TUNE_PERIOD	HZ
+
 static void tune_pcp_high(struct per_cpu_pages *pcp, int high_def)
 {
-	pcp->high = high_def;
+	unsigned long now = jiffies;
+	int high_max, high;
+
+	if (likely(now - pcp->tune_start <= PCP_AUTO_TUNE_PERIOD))
+		return;
+
+	/* No alloc/free in last 2 tune period, reset */
+	if (now - pcp->tune_start > 2 * PCP_AUTO_TUNE_PERIOD) {
+		pcp->tune_start = now;
+		pcp->alloc_high = pcp->alloc_low = pcp->alloc_count = 0;
+		pcp->alloc_depth = pcp->free_depth = 0;
+		pcp->avg_alloc_depth = pcp->avg_free_depth = 0;
+		pcp->high = high_def;
+		return;
+	}
+
+	/* End of tune period, try to tune PCP high automatically */
+	pcp->tune_start = now;
+	/* The old alloc/free depth decay with time */
+	pcp->avg_alloc_depth = (pcp->avg_alloc_depth + pcp->alloc_depth) / 2;
+	pcp->avg_free_depth = (pcp->avg_free_depth + pcp->free_depth) / 2;
+	/* Reset for next tune period */
+	pcp->alloc_high = pcp->alloc_low = pcp->alloc_count = 0;
+	pcp->alloc_depth = pcp->free_depth = 0;
+	/* Pure alloc/free will not increase PCP high */
+	high = min(pcp->avg_alloc_depth, pcp->avg_free_depth);
+	high_max = READ_ONCE(pcp->high_max);
+	pcp->high = clamp(high, high_def, high_max);
 }
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
@@ -2630,7 +2659,19 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	bool free_high;
 
 	high_def = READ_ONCE(pcp->high_def);
-	tune_pcp_high(pcp, high_def);
+	/* PCP is disabled or boot pageset */
+	if (unlikely(!high_def)) {
+		pcp->high = high_def;
+		pcp->tune_start = 0;
+	} else {
+		/* free count as negative allocation */
+		pcp->alloc_count -= (1 << order);
+		pcp->alloc_low = min(pcp->alloc_low, pcp->alloc_count);
+		/* max free depth from the start of current tune period */
+		pcp->free_depth = max(pcp->free_depth,
+				      pcp->alloc_high - pcp->alloc_count);
+		tune_pcp_high(pcp, high_def);
+	}
 
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
@@ -2998,6 +3039,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 		return NULL;
 	}
 
+	pcp->alloc_count += (1 << order);
+	pcp->alloc_high = max(pcp->alloc_high, pcp->alloc_count);
+	/* max alloc depth from the start of current tune period */
+	pcp->alloc_depth = max(pcp->alloc_depth, pcp->alloc_count - pcp->alloc_low);
+
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
 	 * See nr_pcp_free() where free_factor is increased for subsequent
-- 
2.39.2

