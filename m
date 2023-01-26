Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869EE67D488
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjAZSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAZSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:42:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146D66FA7;
        Thu, 26 Jan 2023 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674758553; x=1706294553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeIpfTz2aSbcARPCLzsdspXDjxwH3ccCC0KuAuykCuc=;
  b=eCCLJiCgqm786FogTNHEUkFFYkB++e2SDf3305B2ADLJ9sjVQ3LP4KOT
   WZRDPcIsSTfHo56h5CDghJMsgNrlSHzBlT0xNwaECeXpDdlD9lUNygmQn
   /G/zBpP+xHmhGVBGGXTtlf0hfVdFt9MAAInJmwETmGQMcCHRMgduF9tFr
   XefsX+QEhrCtqYXK6IJtYM9UpbWRid3ZBBPEPBEV8lpLQv6h3t9dVmsdZ
   7ia/0r9MvuxZDeVBCpRtipZvcGzPsx9p7vLLeoU8Ap+MBwV9bk1CDgasr
   3RitSoVFXPbzdVlv91uSzTYAosly/8TrCsvvPAiYicUxVIgEaWwHi1c9D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354203381"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354203381"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="991745458"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="991745458"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
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
Subject: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled and initialize.
Date:   Thu, 26 Jan 2023 10:41:57 -0800
Message-Id: <20230126184157.27626-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126184157.27626-1-tony.luck@intel.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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

Handle this by initializing a per-cpu RMID offset value. Use this
to calculate the value to write to the RMID field of the IA32_PQR_ASSOC
MSR during context switch, and also to the IA32_QM_EVTSEL MSR when
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
 arch/x86/include/asm/resctrl.h        |  4 ++-
 arch/x86/kernel/cpu/resctrl/core.c    | 43 +++++++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c |  2 +-
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 52788f79786f..59b8afd8c53c 100644
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
@@ -69,7 +71,7 @@ static void __resctrl_sched_in(void)
 	if (static_branch_likely(&rdt_mon_enable_key)) {
 		tmp = READ_ONCE(current->rmid);
 		if (tmp)
-			rmid = tmp;
+			rmid = tmp + this_cpu_read(rmid_offset);
 	}
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 53b2ab37af2f..0ff739375e3b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"resctrl: " fmt
 
+#include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/cacheinfo.h>
@@ -484,6 +485,13 @@ static int get_domain_id(int cpu, enum resctrl_scope scope)
 	return get_cpu_cacheinfo_id(cpu, scope);
 }
 
+DEFINE_PER_CPU(int, rmid_offset);
+
+static void set_per_cpu_rmid_offset(int cpu, struct rdt_resource *r)
+{
+	this_cpu_write(rmid_offset, (cpu_to_node(cpu) % snc_ways) * r->num_rmid);
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -515,6 +523,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		cpumask_set_cpu(cpu, &d->cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
 			rdt_domain_reconfigure_cdp(r);
+		if (r->mon_capable)
+			set_per_cpu_rmid_offset(cpu, r);
 		return;
 	}
 
@@ -533,9 +543,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
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
 
 	list_add_tail(&d->list, add_pos);
@@ -845,11 +858,35 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+static __init int find_snc_ways(void)
+{
+	unsigned long *node_caches;
+	int cpu, node, ret;
+
+	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
+	if (!node_caches)
+		return 1;
+
+	cpus_read_lock();
+	for_each_node(node) {
+		cpu = cpumask_first(cpumask_of_node(node));
+		set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
+	}
+	cpus_read_unlock();
+
+	ret = nr_node_ids / bitmap_weight(node_caches, nr_node_ids);
+	kfree(node_caches);
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
index 3fc63aa68130..bd5ec348d925 100644
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
2.39.1

