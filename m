Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1109766A16C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjAMSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAMSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9E7A197
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:56:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80742106F;
        Fri, 13 Jan 2023 09:56:44 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E97DF3F67D;
        Fri, 13 Jan 2023 09:55:59 -0800 (PST)
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
Subject: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
Date:   Fri, 13 Jan 2023 17:54:48 +0000
Message-Id: <20230113175459.14825-8-james.morse@arm.com>
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

When switching tasks, the CLOSID and RMID that the new task should
use are stored in struct task_struct. For x86 the CLOSID known by resctrl,
the value in task_struct, and the value written to the CPU register are
all the same thing.

MPAM's CPU interface has two different PARTID's one for data accesses
the other for instruction fetch. Storing resctrl's CLOSID value in
struct task_struct implies the arch code knows whether resctrl is using
CDP.

Move the matching and setting of the struct task_struct properties
to use helpers. This allows arm64 to store the hardware format of
the register, instead of having to convert it each time.

__rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
values aren't seen as another CPU may schedule the task being moved
while the value is being changed. MPAM has an additional corner-case
here as the PMG bits extend the PARTID space. If the scheduler sees a
new-CLOSID but old-RMID, the task will dirty an RMID that the limbo code
is not watching causing an inaccurate count. x86's RMID are independent
values, so the limbo code will still be watching the old-RMID in this
circumstance.
To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
Both values must be provided together.

Because MPAM's RMID values are not unique, the CLOSID must be provided
when matching the RMID.

CC: Valentin Schneider <vschneid@redhat.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 18 ++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 57 +++++++++++++++-----------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 44d568f3577c..d589a82995ac 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -95,6 +95,24 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
+static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
+						u32 closid, u32 rmid)
+{
+	WRITE_ONCE(tsk->closid, closid);
+	WRITE_ONCE(tsk->rmid, rmid);
+}
+
+static inline bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
+{
+	return READ_ONCE(tsk->closid) == closid;
+}
+
+static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
+					   u32 rmid)
+{
+	return READ_ONCE(tsk->rmid) == rmid;
+}
+
 static inline void resctrl_sched_in(void)
 {
 	if (static_branch_likely(&rdt_enable_key))
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e1f879e13823..ced7400decae 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -84,7 +84,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
  *
  * Using a global CLOSID across all resources has some advantages and
  * some drawbacks:
- * + We can simply set "current->closid" to assign a task to a resource
+ * + We can simply set current's closid to assign a task to a resource
  *   group.
  * + Context switch code can avoid extra memory references deciding which
  *   CLOSID to load into the PQR_ASSOC MSR
@@ -549,14 +549,26 @@ static void update_task_closid_rmid(struct task_struct *t)
 		_update_task_closid_rmid(t);
 }
 
+static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
+{
+	u32 closid, rmid = rdtgrp->mon.rmid;
+
+	if (rdtgrp->type == RDTCTRL_GROUP)
+		closid = rdtgrp->closid;
+	else if (rdtgrp->type == RDTMON_GROUP)
+		closid = rdtgrp->mon.parent->closid;
+	else
+		return false;
+
+	return resctrl_arch_match_closid(tsk, closid) &&
+	       resctrl_arch_match_rmid(tsk, closid, rmid);
+}
+
 static int __rdtgroup_move_task(struct task_struct *tsk,
 				struct rdtgroup *rdtgrp)
 {
 	/* If the task is already in rdtgrp, no need to move the task. */
-	if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
-	     tsk->rmid == rdtgrp->mon.rmid) ||
-	    (rdtgrp->type == RDTMON_GROUP && tsk->rmid == rdtgrp->mon.rmid &&
-	     tsk->closid == rdtgrp->mon.parent->closid))
+	if (task_in_rdtgroup(tsk, rdtgrp))
 		return 0;
 
 	/*
@@ -567,19 +579,14 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * For monitor groups, can move the tasks only from
 	 * their parent CTRL group.
 	 */
-
-	if (rdtgrp->type == RDTCTRL_GROUP) {
-		WRITE_ONCE(tsk->closid, rdtgrp->closid);
-		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
-	} else if (rdtgrp->type == RDTMON_GROUP) {
-		if (rdtgrp->mon.parent->closid == tsk->closid) {
-			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
-		} else {
-			rdt_last_cmd_puts("Can't move task to different control group\n");
-			return -EINVAL;
-		}
+	if (rdtgrp->type == RDTMON_GROUP &&
+	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
+		rdt_last_cmd_puts("Can't move task to different control group\n");
+		return -EINVAL;
 	}
 
+	resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid, rdtgrp->mon.rmid);
+
 	/*
 	 * Ensure the task's closid and rmid are written before determining if
 	 * the task is current that will decide if it will be interrupted.
@@ -599,14 +606,15 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_alloc_capable &&
-	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
+		resctrl_arch_match_closid(t, r->closid));
 }
 
 static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_mon_capable &&
-	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
+		resctrl_arch_match_rmid(t, r->mon.parent->closid,
+					r->mon.rmid));
 }
 
 /**
@@ -802,7 +810,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		    rdtg->mode != RDT_MODE_EXCLUSIVE)
 			continue;
 
-		if (rdtg->closid != tsk->closid)
+		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
 			continue;
 
 		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
@@ -810,7 +818,8 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		seq_puts(s, "mon:");
 		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
 				    mon.crdtgrp_list) {
-			if (tsk->rmid != crg->mon.rmid)
+			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
+						     crg->mon.rmid))
 				continue;
 			seq_printf(s, "%s", crg->kn->name);
 			break;
@@ -2401,8 +2410,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			WRITE_ONCE(t->closid, to->closid);
-			WRITE_ONCE(t->rmid, to->mon.rmid);
+			resctrl_arch_set_closid_rmid(t, to->closid,
+						     to->mon.rmid);
 
 			/*
 			 * If the task is on a CPU, set the CPU in the mask.
-- 
2.30.2

