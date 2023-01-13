Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBC66A16D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjAMSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjAMSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9FE10FD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:56:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF21176A;
        Fri, 13 Jan 2023 09:56:54 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 618CD3F67D;
        Fri, 13 Jan 2023 09:56:10 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: [PATCH v2 11/18] x86/resctrl: Make resctrl_mounted checks explicit
Date:   Fri, 13 Jan 2023 17:54:52 +0000
Message-Id: <20230113175459.14825-12-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230113175459.14825-1-james.morse@arm.com>
References: <20230113175459.14825-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rdt_enable_key is switched when resctrl is mounted, and used to
prevent a second mount of the filesystem. It also enables the
architecture's context switch code.

This requires another architecture to have the same set of static-keys,
as resctrl depends on them too.

Make the resctrl_mounted checks explicit: resctrl can keep track of
whether it has been mounted once. This doesn't need to be combined with
whether the arch code is context switching the CLOSID.
Tests against the rdt_mon_enable_key become a test that resctrl is
mounted and that monitoring is enabled.

This will allow the static-key changing to be moved behind resctrl_arch_
calls.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  |  5 +++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e85e454bec72..65d85e1ef75f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -95,6 +95,7 @@ extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
+extern bool resctrl_mounted;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 4e248f4a5f59..4ff258b49e9c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -795,7 +795,7 @@ void mbm_handle_overflow(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -823,8 +823,9 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		return;
+
 	cpu = cpumask_any(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
 	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ced7400decae..370da7077c67 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -42,6 +42,9 @@ LIST_HEAD(rdt_all_groups);
 /* list of entries for the schemata file */
 LIST_HEAD(resctrl_schema_all);
 
+/* the filesystem can only be mounted once */
+bool resctrl_mounted;
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -794,7 +797,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 	mutex_lock(&rdtgroup_mutex);
 
 	/* Return empty if resctrl has not been mounted. */
-	if (!static_branch_unlikely(&rdt_enable_key)) {
+	if (!resctrl_mounted) {
 		seq_puts(s, "res:\nmon:\n");
 		goto unlock;
 	}
@@ -2196,7 +2199,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	/*
 	 * resctrl file system can only be mounted once.
 	 */
-	if (static_branch_unlikely(&rdt_enable_key)) {
+	if (resctrl_mounted) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2244,8 +2247,10 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
 
-	if (rdt_alloc_capable || rdt_mon_capable)
+	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
+		resctrl_mounted = true;
+	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2512,6 +2517,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
+	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
 	cpus_read_unlock();
@@ -3336,7 +3342,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
 	if (is_mbm_enabled())
@@ -3413,8 +3419,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (is_llc_occupancy_enabled())
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
-	/* If resctrl is mounted, add per domain monitor data directories. */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
 	return 0;
-- 
2.30.2

