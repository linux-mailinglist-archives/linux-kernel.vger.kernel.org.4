Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3C72F39B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjFNEgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbjFNEfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:35:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197B1BD2;
        Tue, 13 Jun 2023 21:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686717353; x=1718253353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKNOPiRlbFCjVKO/lr2yXKjZVNi5xSBLYkk5nEvGDe4=;
  b=AHuIaucrSZtTV2Ii6ttEOD80ZL/oIzhlW0/BqF6GDhK/Po50YHi9ruUn
   j4gt+rC7ypBR2ftwoHawG7Se9eFbg8+LvisDrZY1CtMPqqEAaHogh8udW
   BM+TP80RuigkSy0SF1o4BiixyC542MD4hCedmoTEJ1MPvRG1Y1zoIXbDq
   lhAqFW75GH8BX7ScwPmLAvXSOA2fIa9H8FYoLac/3HbrcYCpo72v1Zr+1
   fSEtUIe/E0jMVhvJ35VtxskH5ibzTWCJ1p7ZMyze84IzONwF4iIVZ8Gm/
   iDFkYmA1UUp9D+C3WuO4YmcFdzvv1VtCcWdPSluGHvt+re1/1ApDw6wll
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360998741"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="360998741"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662251417"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="662251417"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.233.239])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:28 -0700
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
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
Subject: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Date:   Tue, 13 Jun 2023 21:35:24 -0700
Message-Id: <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686712819.git.alison.schofield@intel.com>
References: <cover.1686712819.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

numa_fill_memblks() fills in the gaps in numa_meminfo memblks
over an HPA address range.

The ACPI driver will use numa_fill_memblks() to implement a new Linux
policy that prescribes extending proximity domains in a portion of a
CFMWS window to the entire window.

Dan Williams offered this explanation of the policy:
A CFWMS is an ACPI data structure that indicates *potential* locations
where CXL memory can be placed. It is the playground where the CXL
driver has free reign to establish regions. That space can be populated
by BIOS created regions, or driver created regions, after hotplug or
other reconfiguration.

When BIOS creates a region in a CXL Window it additionally describes
that subset of the Window range in the other typical ACPI tables SRAT,
SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
future. I.e. there is nothing stopping higher or lower performance
devices being placed in the same Window. Compare that to ACPI memory
hotplug that just onlines additional capacity in the proximity domain
with little freedom for dynamic performance differentiation.

That leaves the OS with a choice, should unpopulated window capacity
match the proximity domain of an existing region, or should it allocate
a new one? This patch takes the simple position of minimizing proximity
domain proliferation by reusing any proximity domain intersection for
the entire Window. If the Window has no intersections then allocate a
new proximity domain. Note that SRAT, SLIT and HMAT information can be
enumerated dynamically in a standard way from device provided data.
Think of CXL as the end of ACPI needing to describe memory attributes,
CXL offers a standard discovery model for performance attributes, but
Linux still needs to interoperate with the old regime.

Reported-by: Derick Marks <derick.w.marks@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Derick Marks <derick.w.marks@intel.com>
---
 arch/x86/include/asm/sparsemem.h |  2 +
 arch/x86/mm/numa.c               | 87 ++++++++++++++++++++++++++++++++
 include/linux/numa.h             |  7 +++
 3 files changed, 96 insertions(+)

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
index 2aadb2019b4f..fa82141d1a04 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -11,6 +11,7 @@
 #include <linux/nodemask.h>
 #include <linux/sched.h>
 #include <linux/topology.h>
+#include <linux/sort.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -961,4 +962,90 @@ int memory_add_physaddr_to_nid(u64 start)
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
+	/* Caller handles duplicate start addresses */
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
+ * Find and extend numa_meminfo memblks to cover the @start-@end
+ * HPA address range, such that the first memblk includes @start,
+ * the last memblk includes @end, and any gaps in between are
+ * filled.
+ *
+ * RETURNS:
+ * 0		  : Success
+ * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
+ */
+
+int __init numa_fill_memblks(u64 start, u64 end)
+{
+	struct numa_memblk **blk = &numa_memblk_list[0];
+	struct numa_meminfo *mi = &numa_meminfo;
+	int count = 0;
+	u64 prev_end;
+
+	/*
+	 * Create a list of pointers to numa_meminfo memblks that
+	 * overlap start, end. Exclude (start == bi->end) since
+	 * end addresses in both a CFMWS range and a memblk range
+	 * are exclusive.
+	 *
+	 * This list of pointers is used to make in-place changes
+	 * that fill out the numa_meminfo memblks.
+	 */
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (start < bi->end && end >= bi->start) {
+			blk[count] = &mi->blk[i];
+			count++;
+		}
+	}
+	if (!count)
+		return NUMA_NO_MEMBLK;
+
+	/* Sort the list of pointers in memblk->start order */
+	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
+
+	/* Make sure the first/last memblks include start/end */
+	blk[0]->start = min(blk[0]->start, start);
+	blk[count - 1]->end = max(blk[count - 1]->end, end);
+
+	/*
+	 * Fill any gaps by tracking the previous memblks end address,
+	 * prev_end, and backfilling to it if needed. Avoid filling
+	 * overlapping memblks by making prev_end monotonically non-
+	 * decreasing.
+	 */
+	prev_end = blk[0]->end;
+	for (int i = 1; i < count; i++) {
+		struct numa_memblk *curr = blk[i];
+
+		if (prev_end >= curr->start) {
+			if (prev_end < curr->end)
+				prev_end = curr->end;
+		} else {
+			curr->start = prev_end;
+			prev_end = curr->end;
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

