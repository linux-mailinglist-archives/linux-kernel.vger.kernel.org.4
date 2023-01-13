Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4866A179
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAMSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjAMSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0DED5FCD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:56:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF76FFEC;
        Fri, 13 Jan 2023 09:57:10 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3473E3F67D;
        Fri, 13 Jan 2023 09:56:26 -0800 (PST)
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
Subject: [PATCH v2 17/18] x86/resctrl: Add cpu offline callback for resctrl work
Date:   Fri, 13 Jan 2023 17:54:58 +0000
Message-Id: <20230113175459.14825-18-james.morse@arm.com>
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

The resctrl architecture specific code may need to free a domain when
a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
The resctrl filesystem code needs to move the overflow and limbo work
to run on a different CPU, and clear this CPU from the cpu_mask of
control and monitor groups.

Currently this is all done in core.c and called from
resctrl_offline_cpu(), making the split between architecture and
filesystem code unclear.

Move the filesystem work into a filesystem helper called
resctrl_offline_cpu(), and rename the one in core.c
resctrl_arch_offline_cpu().

The rdtgroup_mutex is unlocked and locked again in the call in
preparation for changing the locking rules for the architecture
code.

resctrl_offline_cpu() is called before any of the resource/domains
are updated, and makes use of the exclude_cpu feature we previously
added.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 39 ++++----------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 ++++++++++++++++++++++++++
 include/linux/resctrl.h                |  1 +
 3 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a3c171bd2de0..7896fcf11df6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -553,20 +553,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		return;
 	}
-
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
-			cancel_delayed_work(&d->mbm_over);
-			/* exclude_cpu=-1 as we already cpumask_clear_cpu()d */
-			mbm_setup_overflow_handler(d, 0, -1);
-		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(r, d)) {
-			cancel_delayed_work(&d->cqm_limbo);
-			/* exclude_cpu=-1 as we already cpumask_clear_cpu()d */
-			cqm_setup_limbo_handler(d, 0, -1);
-		}
-	}
 }
 
 static void clear_closid_rmid(int cpu)
@@ -596,31 +582,15 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
 	return err;
 }
 
-static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+static int resctrl_arch_offline_cpu(unsigned int cpu)
 {
-	struct rdtgroup *cr;
-
-	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask)) {
-			break;
-		}
-	}
-}
-
-static int resctrl_offline_cpu(unsigned int cpu)
-{
-	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
+	resctrl_offline_cpu(cpu);
+
 	for_each_capable_rdt_resource(r)
 		domain_remove_cpu(cpu, r);
-	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
-			clear_childcpus(rdtgrp, cpu);
-			break;
-		}
-	}
 	clear_closid_rmid(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
@@ -920,7 +890,8 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_arch_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu,
+				  resctrl_arch_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2998d20691ea..aa75c42e0faa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3434,6 +3434,45 @@ int resctrl_online_cpu(unsigned int cpu)
 	return 0;
 }
 
+static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+{
+	struct rdtgroup *cr;
+
+	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
+			break;
+	}
+}
+
+void resctrl_offline_cpu(unsigned int cpu)
+{
+	struct rdt_domain *d;
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
+			clear_childcpus(rdtgrp, cpu);
+			break;
+		}
+	}
+
+	d = get_domain_from_cpu(cpu, l3);
+	if (d) {
+		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
+			cancel_delayed_work(&d->mbm_over);
+			mbm_setup_overflow_handler(d, 0, cpu);
+		}
+		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
+		    has_busy_rmid(l3, d)) {
+			cancel_delayed_work(&d->cqm_limbo);
+			cqm_setup_limbo_handler(d, 0, cpu);
+		}
+	}
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7b71c3558d83..0d21e7ba7c1d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -220,6 +220,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 int resctrl_online_cpu(unsigned int cpu);
+void resctrl_offline_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
-- 
2.30.2

