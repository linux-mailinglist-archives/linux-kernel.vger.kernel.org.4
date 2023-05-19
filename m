Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FC708C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjESAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjESAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:05:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55110C2;
        Thu, 18 May 2023 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454701; x=1715990701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BXhf4mDICnsf+kZJuoVdPXCcgcPvU9JnTs/nQQ3Cy5c=;
  b=i+rxIgSWoF2RRd+Gf31BLxR92AQIcLOAqwqyc1xvf36xtqLpZGCxjuG7
   x6N2gQ+j601OqAaWD8X3HO3Tn7uDwRmmYjZ0NIzzB4Q1Qu6GsLBQptSQm
   INExh0CtUocEyUDib6+G+JWeYpwwykM2LWH2ZeAMZVAYnu5HXfWbGeMJz
   F5YP2gslm4EgZeKkNWgmoAgZucT+G+6yeDQQnExNrr63L4Nh4XHl+NXA2
   43rxf/iuHuqgJgo49WOSiqnewIDymT6R/FbLZXVjyfJaloWUSJ2SDkOuY
   t6urtGvgeOVvu/ZocjVduisoSCCSyInQ3Xjwb4DaHV6tSlM7M1INlc3+8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355446207"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355446207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876634923"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="876634923"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.20.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:05:00 -0700
From:   alison.schofield@intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Date:   Thu, 18 May 2023 17:04:55 -0700
Message-Id: <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684448934.git.alison.schofield@intel.com>
References: <cover.1684448934.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

numa_fill_memblks() fills in the gaps in numa_meminfo memblks
over an HPA address range.

The initial use case is the ACPI driver that needs to extend
SRAT defined proximity domains to an entire CXL CFMWS Window[1].

The APCI driver expects to use numa_fill_memblks() while parsing
the CFMWS. Extending the memblks created during SRAT parsing, to
cover the entire CFMWS Window, is desirable because everything in
a CFMWS Window is expected to be of a similar performance class.

Requires CONFIG_NUMA_KEEP_MEMINFO.

[1] A CXL CFMWS Window represents a contiguous CXL memory resource,
aka an HPA range. The CFMWS (CXL Fixed Memory Window Structure) is
part of the ACPI CEDT (CXL Early Discovery Table).

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/include/asm/sparsemem.h |  2 +
 arch/x86/mm/numa.c               | 82 ++++++++++++++++++++++++++++++++
 include/linux/numa.h             |  7 +++
 3 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 64df897c0ee3..1be13b2dfe8b 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int numa_fill_memblks(u64 start, u64 end);
+#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..6c8f9cff71da 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -11,6 +11,7 @@
 #include <linux/nodemask.h>
 #include <linux/sched.h>
 #include <linux/topology.h>
+#include <linux/sort.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -961,4 +962,85 @@ int memory_add_physaddr_to_nid(u64 start)
 	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+static int __init cmp_memblk(const void *a, const void *b)
+{
+	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
+	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
+
+	if (ma->start != mb->start)
+		return (ma->start < mb->start) ? -1 : 1;
+
+	if (ma->end != mb->end)
+		return (ma->end < mb->end) ? -1 : 1;
+
+	return 0;
+}
+
+static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
+
+/**
+ * numa_fill_memblks - Fill gaps in numa_meminfo memblks
+ * @start: address to begin fill
+ * @end: address to end fill
+ *
+ * Find and extend numa_meminfo memblks to cover the @start/@end
+ * HPA address range, following these rules:
+ * 1. The first memblk must start at @start
+ * 2. The last memblk must end at @end
+ * 3. Fill the gaps between memblks by extending numa_memblk.end
+ * Result: All addresses in start/end range are included in
+ *	   numa_meminfo.
+ *
+ * RETURNS:
+ * 0		  : Success. numa_meminfo fully describes start/end
+ * NUMA_NO_MEMBLK : No memblk exists in start/end range
+ */
+
+int __init numa_fill_memblks(u64 start, u64 end)
+{
+	struct numa_meminfo *mi = &numa_meminfo;
+	struct numa_memblk **blk = &numa_memblk_list[0];
+	int count = 0;
+
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (start <= bi->start && end >= bi->end) {
+			blk[count] = &mi->blk[i];
+			count++;
+		}
+	}
+	if (!count)
+		return NUMA_NO_MEMBLK;
+
+	if (count == 1) {
+		blk[0]->start = start;
+		blk[0]->end = end;
+		return 0;
+	}
+
+	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
+	blk[0]->start = start;
+	blk[count - 1]->end = end;
+
+	for (int i = 0, j = 1; j < count; i++, j++) {
+		/* Overlaps OK. sort() put the lesser end first */
+		if (blk[i]->start == blk[j]->start)
+			continue;
+
+		/* No gap */
+		if (blk[i]->end == blk[j]->start)
+			continue;
+
+		/* Fill the gap */
+		if (blk[i]->end < blk[j]->start) {
+			blk[i]->end = blk[j]->start;
+			continue;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(numa_fill_memblks);
+
 #endif
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 59df211d051f..0f512c0aba54 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -12,6 +12,7 @@
 #define MAX_NUMNODES    (1 << NODES_SHIFT)
 
 #define	NUMA_NO_NODE	(-1)
+#define	NUMA_NO_MEMBLK	(-1)
 
 /* optionally keep NUMA memory info available post init */
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
@@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
 	return 0;
 }
 #endif
+#ifndef numa_fill_memblks
+static inline int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+#endif
 #else /* !CONFIG_NUMA */
 static inline int numa_map_to_online_node(int node)
 {
-- 
2.37.3

