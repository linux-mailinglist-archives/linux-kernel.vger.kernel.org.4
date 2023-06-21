Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896D738D61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFURlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjFURko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:40:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F721726;
        Wed, 21 Jun 2023 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369242; x=1718905242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNQfa0kAalxyBUqvdx04Xx6SluFbWdsz/OUOjhADRuc=;
  b=d3uYfDYtcUlYP8cCTHfTTuE+t66SPxJ91x8n8xzYrgyrTjV+1Nuc8CUa
   LijvPyZ7rUmd9SXBW+0sEy76nXZHhurIuCFb6keJ7+BApe77tSdR4g2Tj
   6uvwzJNHGDpG8qV+aB9ZwykQOzhvP3ajghzQgOP+tksYa2RowA296PZUn
   B4sM7GTBTgmM/OqsK1qzMI1QgLWIN1LG3/GmadFz0UsxPucLk8sJHAejc
   OewvkD/iT34CXJT0wqS6PkZmcbDSJDb+amkhCj08QxYC+v8JwUnCbLZKd
   3hPFGIduQlBKO4nhhNirWHG1MRwO2IPTp27N/F7tKZ8mKtDoeav8C/Y5c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359120563"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359120563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="779921584"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="779921584"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:17 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled and initialize.
Date:   Wed, 21 Jun 2023 10:40:06 -0700
Message-Id: <20230621174006.42533-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621174006.42533-1-tony.luck@intel.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
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

There isn't a simple hardware enumeration to indicate to software that
a system is running with Sub-NUMA Cluster enabled.

Compare the number of NUMA nodes with the number of L3 caches to calculate
the number of Sub-NUMA nodes per L3 cache.

When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters
are distributed equally between the SNC nodes within each socket.

E.g. if there are 400 RMID counters, and the system is configured with
two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
0 on the socket, and RMID counter 200..399 on SNC node 1.

A model specific MSR (0xca0) can change the configuration of the RMIDs
when SNC mode is enabled.

The MSR controls the interpretation of the RMID field in the
IA32_PQR_ASSOC MSR so that the appropriate hardware counters
within the SNC node are updated.

Also initialize a per-cpu RMID offset value. Use this
to calculate the value to write to the IA32_QM_EVTSEL MSR when
reading RMID event values.

N.B. this works well for well-behaved NUMA applications that access
memory predominantly from the local memory node. For applications that
access memory across multiple nodes it may be necessary for the user
to read counters for all SNC nodes on a socket and add the values to
get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
all that different from applications that span across multiple sockets
in a legacy system.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/resctrl.h        |  2 +
 arch/x86/kernel/cpu/resctrl/core.c    | 99 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c |  2 +-
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 255a78d9d906..f95e69bacc65 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -35,6 +35,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
+DECLARE_PER_CPU(int, rmid_offset);
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index af3be3c2db96..869cfb46e8e4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -16,11 +16,14 @@
 
 #define pr_fmt(fmt)	"resctrl: " fmt
 
+#include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
+#include <linux/mod_devicetable.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/resctrl.h>
 #include "internal.h"
@@ -524,6 +527,39 @@ static int get_domain_id(int cpu, enum resctrl_scope scope)
 	}
 }
 
+DEFINE_PER_CPU(int, rmid_offset);
+
+static void set_per_cpu_rmid_offset(int cpu, struct rdt_resource *r)
+{
+	this_cpu_write(rmid_offset, (cpu_to_node(cpu) % snc_ways) * r->num_rmid);
+}
+
+/*
+ * This MSR provides for configuration of RMIDs on Sub-NUMA Cluster
+ * systems.
+ * Bit0 = 1 (default) For legacy configuration
+ * Bit0 = 0 RMIDs are divided evenly between SNC nodes.
+ */
+#define MSR_RMID_SNC_CONFIG   0xCA0
+
+static void snc_add_pkg(void)
+{
+	u64	msrval;
+
+	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
+	msrval |= BIT_ULL(0);
+	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
+}
+
+static void snc_remove_pkg(void)
+{
+	u64	msrval;
+
+	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
+	msrval &= ~BIT_ULL(0);
+	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -555,6 +591,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		cpumask_set_cpu(cpu, &d->cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
 			rdt_domain_reconfigure_cdp(r);
+		if (r->mon_capable)
+			set_per_cpu_rmid_offset(cpu, r);
 		return;
 	}
 
@@ -573,11 +611,17 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
-		domain_free(hw_dom);
-		return;
+	if (r->mon_capable) {
+		if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+			domain_free(hw_dom);
+			return;
+		}
+		set_per_cpu_rmid_offset(cpu, r);
 	}
 
+	if (r->pkg_actions)
+		snc_add_pkg();
+
 	list_add_tail(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
@@ -613,6 +657,9 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			d->plr->d = NULL;
 		domain_free(hw_dom);
 
+		if (r->pkg_actions)
+			snc_remove_pkg();
+
 		return;
 	}
 
@@ -899,11 +946,57 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
+	{}
+};
+
+/*
+ * There isn't a simple enumeration bit to show whether SNC mode
+ * is enabled. Look at the ratio of number of NUMA nodes to the
+ * number of distinct L3 caches. Take care to skip memory-only nodes.
+ */
+static __init int find_snc_ways(void)
+{
+	unsigned long *node_caches;
+	int mem_only_nodes = 0;
+	int cpu, node, ret;
+
+	if (!x86_match_cpu(snc_cpu_ids))
+		return 1;
+
+	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
+	if (!node_caches)
+		return 1;
+
+	cpus_read_lock();
+	for_each_node(node) {
+		cpu = cpumask_first(cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
+		else
+			mem_only_nodes++;
+	}
+	cpus_read_unlock();
+
+	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
+	kfree(node_caches);
+
+	if (ret > 1)
+		rdt_resources_all[RDT_RESOURCE_PKG].r_resctrl.pkg_actions = true;
+
+	return ret;
+}
+
 static __init void rdt_init_res_defs_intel(void)
 {
 	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 
+	snc_ways = find_snc_ways();
+
 	for_each_rdt_resource(r) {
 		hw_res = resctrl_to_arch_res(r);
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index da3f36212898..74db99d299e1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -160,7 +160,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + this_cpu_read(rmid_offset));
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
-- 
2.40.1

