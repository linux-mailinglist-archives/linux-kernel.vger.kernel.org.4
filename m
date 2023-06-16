Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F5732862
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbjFPHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbjFPHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:06:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847DA35A6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686899198; x=1718435198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aOdlEaVHTONo9Kej4YBWg+d/l94TirHxQkRvgXaE8BA=;
  b=bZr5+nVhI6r/D2QS8XHygEa1iwZ3aN9G9Eq2F46U9Ymbt8GzMwVzQ7Cz
   UKqsm1tNR6YyaZ9z2sZoUNzXWkzWxcOcjjQE7w0O0tf2476y3BURQspKB
   MHdt8kHZVna05dm/lYm+c5vri9Qk4Iwh9eFb2LmjhsB5wNKBRY331Zmv5
   E99p32n3cMXcGroS7hTonDr+h1bqBBQtjO8hrewdhEwatcPIZcB6Rw/lA
   lzmyyAu5giGJ/H3EgEZP47oAuFeiMfZhisrMXvLygoXtIViylT/2zl4TZ
   DxDaVKNEEGspQ2lDts6w3chIHb7aygqNgFiA/WN7RRC5zLVrczmNIb5Po
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361668859"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="361668859"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782783995"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="782783995"
Received: from cpeng15-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.216])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:06:16 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [RFC 3/4] acpi, hmat: calculate abstract distance with HMAT
Date:   Fri, 16 Jun 2023 15:05:37 +0800
Message-Id: <20230616070538.190042-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616070538.190042-1-ying.huang@intel.com>
References: <20230616070538.190042-1-ying.huang@intel.com>
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

A memory tiering abstract distance calculation algorithm based on ACPI
HMAT is implemented.  The basic idea is as follows.

The performance attributes of system default DRAM nodes are recorded
as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
Then, the ratio of the abstract distance of a memory node (target) to
MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
attributes of the node to that of the default DRAM nodes.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c     | 124 ++++++++++++++++++++++++++++++++++-
 include/linux/memory-tiers.h |   2 +
 mm/memory-tiers.c            |   2 +-
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2dee0098f1a9..21e4deb581ad 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -24,6 +24,7 @@
 #include <linux/node.h>
 #include <linux/sysfs.h>
 #include <linux/dax.h>
+#include <linux/memory-tiers.h>
 
 static u8 hmat_revision;
 static int hmat_disable __initdata;
@@ -759,6 +760,123 @@ static int hmat_callback(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
+static int hmat_adistance_disabled;
+static struct node_hmem_attrs default_dram_attrs;
+
+static void dump_hmem_attrs(struct node_hmem_attrs *attrs)
+{
+	pr_cont("read_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
+		attrs->read_latency, attrs->write_latency,
+		attrs->read_bandwidth, attrs->write_bandwidth);
+}
+
+static void disable_hmat_adistance_algorithm(void)
+{
+	hmat_adistance_disabled = true;
+}
+
+static int hmat_init_default_dram_attrs(void)
+{
+	struct memory_target *target;
+	struct node_hmem_attrs *attrs;
+	int nid, pxm;
+	int nid_dram = NUMA_NO_NODE;
+
+	if (default_dram_attrs.read_latency +
+	    default_dram_attrs.write_latency != 0)
+		return 0;
+
+	if (!default_dram_type)
+		return -EIO;
+
+	for_each_node_mask(nid, default_dram_type->nodes) {
+		pxm = node_to_pxm(nid);
+		target = find_mem_target(pxm);
+		if (!target)
+			continue;
+		attrs = &target->hmem_attrs[1];
+		if (nid_dram == NUMA_NO_NODE) {
+			if (attrs->read_latency + attrs->write_latency == 0 ||
+			    attrs->read_bandwidth + attrs->write_bandwidth == 0) {
+				pr_info("hmat: invalid hmem attrs for default DRAM node: %d,\n",
+					nid);
+				pr_info("  ");
+				dump_hmem_attrs(attrs);
+				pr_info("  disable hmat based abstract distance algorithm.\n");
+				disable_hmat_adistance_algorithm();
+				return -EIO;
+			}
+			nid_dram = nid;
+			default_dram_attrs = *attrs;
+			continue;
+		}
+		if (abs(attrs->read_latency - default_dram_attrs.read_latency) * 10 >
+		    default_dram_attrs.read_latency ||
+		    abs(attrs->write_latency - default_dram_attrs.write_latency) * 10 >
+		    default_dram_attrs.write_latency ||
+		    abs(attrs->read_bandwidth - default_dram_attrs.read_bandwidth) * 10 >
+		    default_dram_attrs.read_bandwidth) {
+			pr_info("hmat: hmem attrs for DRAM nodes mismatch.\n");
+			pr_info("  node %d:", nid_dram);
+			dump_hmem_attrs(&default_dram_attrs);
+			pr_info("  node %d:", nid);
+			dump_hmem_attrs(attrs);
+			pr_info("  disable hmat based abstract distance algorithm.\n");
+			disable_hmat_adistance_algorithm();
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int hmat_calculate_adistance(struct notifier_block *self,
+				    unsigned long nid, void *data)
+{
+	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
+	struct memory_target *target;
+	struct node_hmem_attrs *attrs;
+	int *adist = data;
+	int pxm;
+
+	if (hmat_adistance_disabled)
+		return NOTIFY_OK;
+
+	pxm = node_to_pxm(nid);
+	target = find_mem_target(pxm);
+	if (!target)
+		return NOTIFY_OK;
+
+	if (hmat_init_default_dram_attrs())
+		return NOTIFY_OK;
+
+	mutex_lock(&target_lock);
+	hmat_update_target_attrs(target, p_nodes, 1);
+	mutex_unlock(&target_lock);
+
+	attrs = &target->hmem_attrs[1];
+
+	if (attrs->read_latency + attrs->write_latency == 0 ||
+	    attrs->read_bandwidth + attrs->write_bandwidth == 0)
+		return NOTIFY_OK;
+
+	*adist = MEMTIER_ADISTANCE_DRAM *
+		(attrs->read_latency + attrs->write_latency) /
+		(default_dram_attrs.read_latency +
+		 default_dram_attrs.write_latency) *
+		(default_dram_attrs.read_bandwidth +
+		 default_dram_attrs.write_bandwidth) /
+		(attrs->read_bandwidth + attrs->write_bandwidth);
+
+	return NOTIFY_STOP;
+}
+
+static __meminitdata struct notifier_block hmat_adist_nb =
+{
+	.notifier_call = hmat_calculate_adistance,
+	.priority = 100,
+};
+
 static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
@@ -801,6 +919,7 @@ static __init int hmat_init(void)
 	struct acpi_table_header *tbl;
 	enum acpi_hmat_type i;
 	acpi_status status;
+	int usage;
 
 	if (srat_disabled() || hmat_disable)
 		return 0;
@@ -841,8 +960,11 @@ static __init int hmat_init(void)
 	hmat_register_targets();
 
 	/* Keep the table and structures if the notifier may use them */
-	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
+	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
+	usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
+	if (usage)
 		return 0;
+
 out_put:
 	hmat_free_structures();
 	acpi_put_table(tbl);
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index c6429e624244..9377239c8d34 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -33,6 +33,7 @@ struct memory_dev_type {
 
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
+extern struct memory_dev_type *default_dram_type;
 struct memory_dev_type *alloc_memory_type(int adistance);
 void destroy_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
@@ -64,6 +65,7 @@ static inline bool node_is_toptier(int node)
 #else
 
 #define numa_demotion_enabled	false
+#define default_dram_type	NULL
 /*
  * CONFIG_NUMA implementation returns non NULL error.
  */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fb5398e710cc..3aabc7240402 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -37,7 +37,7 @@ struct node_memory_type_map {
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
-static struct memory_dev_type *default_dram_type;
+struct memory_dev_type *default_dram_type;
 
 static struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
-- 
2.39.2

