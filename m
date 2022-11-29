Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE04963BEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiK2LLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiK2LLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:11:17 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3C25D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:11:15 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so10005807wmp.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJmy483wHd30jX7z0XJjlHf6mlOL34e660IEJzcRK0c=;
        b=U9valu+7yplhsb5N409ZkqkU9eYZptS5QMZfhsrdvqRgGOsc3UIe919Fmwn5MGUtCy
         n9M6de64kxbi0VJlIgEH6iIa1/UYGSVpkqQq5kudBj5Rt7KIe7iBsYK86Dik16SKoThR
         IVNKBtPlCbp1hR2x/Kreqywk8ZHwkMGyAI+xRGX2Y2e6aLSsHVU1xCYfXRY/pKc2HCD7
         6Uxv6MvlbNB6V30HUEEmqX00vbsrtRr4E+OyNxVyJGDtMhzsQQ5wstJpmY1N3Cf2uhgj
         fCyfYaLnWmZhdN3kcOwD0zXYQdc3/QxFXLQE87OnAHSHGXwpEJKiBKTc6FV+G6rItV7D
         PozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJmy483wHd30jX7z0XJjlHf6mlOL34e660IEJzcRK0c=;
        b=jbVCbkHr/K/q8B6n1McK3x+zhvDlJSoGbYU3rsYqj+B8bpW+oRGdN1ieZuQhRXRSpC
         suvO1XHTrOgSQ7JsuIoBgZ5tDqTib7bGWJnsBGTTak56hgyKzgR2R41/UCILh8kPLMd7
         ZPsrNv1M1Rx2Zsy1ogvcx9lMXhLPX2p3iRa0VYPPBCpkGqr57S2UaBGsxHE+kFy6rgPO
         spIIXIGAPUR18HGuGZBNEO0QPvWhykFt7uEi3i+8z99ENfSzqcYxuwvZh09dsEy/SAmk
         oSLstoMki3QPheNswVDHhL0HKwMgbOHxlZn/H7HqnzAKeO6fydpsFfQqzGK4w/+Xvjbi
         0Apg==
X-Gm-Message-State: ANoB5pkkdbBR+5Z5eAMzqabf9vXqkxxSp7bJAIOifGhNqCp1MEhKrJUN
        Vtvl5+0Jed4V6udm1RPoVkTLxhlokCG9k+nWaA==
X-Google-Smtp-Source: AA0mqf7eVvlJX1XaKs0HbL+JRPRlmIpYqq7hlX0ciip0Rt2iXUDIF+qLCjTJqfkIyl/F9CCrvznlWfPF9VJSDTLsbA==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e398:2261:c909:b359])
 (user=peternewman job=sendgmr) by 2002:a05:6000:1c4:b0:241:792f:a914 with
 SMTP id t4-20020a05600001c400b00241792fa914mr27031028wrx.117.1669720274493;
 Tue, 29 Nov 2022 03:11:14 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:10:55 +0100
In-Reply-To: <20221129111055.953833-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221129111055.953833-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129111055.953833-3-peternewman@google.com>
Subject: [PATCH v4 2/2] x86/resctrl: IPI all online CPUs for group updates
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        hpa@zytor.com, james.morse@arm.com, jannh@google.com,
        kpsingh@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing a CTRL_MON or MON group directory moves all tasks to the parent
group. The rmdir implementation therefore interrupts any running
tasks which were in the deleted group to update their CLOSID/RMID to
those of the parent.

The rmdir operation iterates over all tasks in the deleted group while
read-locking the tasklist_lock to ensure that no newly-created child
tasks remain in the deleted group. Calling task_call_func() to perform
the updates on every task in the deleted group, similar to the recent
fix in __rdtgroup_move_task(), would result in a much longer
tasklist_lock critical section.

To avoid this, stop attempting to construct a precise mask of CPUs
hosting the moved tasks in rdt_move_group_tasks(). Its callers instead
perform the PQR_ASSOC MSR update on all online CPUs to ensure all
affected tasks are notified.

To measure the impact of the rdt_move_group_tasks() implementation
options, the following command was run in an rdtgroup to produce a
1600-task workload:

 # mkdir /sys/fs/resctrl/test
 # echo $$ > /sys/fs/resctrl/test/tasks
 # perf bench sched messaging -g 40 -l 100000

Results collected using:

 # perf stat rmdir /sys/fs/resctrl/test

CPU: Intel(R) Xeon(R) Platinum P-8136 CPU @ 2.00GHz (112 threads)

Calling task_call_func() on all tasks in the deleted group increased
task-clock time from 1.54 to 2.35 ms, while the IPI broadcast reduced
the time to 1.31 ms.

Restructuring resctrl groups is assumed to be a rare act of system-level
reconfiguration by the user, so the impact of additional IPIs resulting
from this change to a CPU-isolated workload is not a concern.

Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 +++++++-------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 59b7ffcd53bb..4a3c0b315484 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2401,12 +2401,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
  *
- * If @mask is not NULL the cpus on which moved tasks are running are set
- * in that mask so the update smp function call is restricted to affected
- * cpus.
+ * Following this operation, the caller should update PQR_ASSOC MSR and per-CPU
+ * storage on all online CPUs.
  */
-static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
-				 struct cpumask *mask)
+static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to)
 {
 	struct task_struct *p, *t;
 
@@ -2416,16 +2414,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 		    is_rmid_match(t, from)) {
 			WRITE_ONCE(t->closid, to->closid);
 			WRITE_ONCE(t->rmid, to->mon.rmid);
-
-			/*
-			 * If the task is on a CPU, set the CPU in the mask.
-			 * The detection is inaccurate as tasks might move or
-			 * schedule before the smp function call takes place.
-			 * In such a case the function call is pointless, but
-			 * there is no other side effect.
-			 */
-			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
-				cpumask_set_cpu(task_cpu(t), mask);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -2456,7 +2444,7 @@ static void rmdir_all_sub(void)
 	struct rdtgroup *rdtgrp, *tmp;
 
 	/* Move all tasks to the default resource group */
-	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
+	rdt_move_group_tasks(NULL, &rdtgroup_default);
 
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
@@ -3115,23 +3103,19 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	return -EPERM;
 }
 
-static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
+static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
 	int cpu;
 
 	/* Give any tasks back to the parent group */
-	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
+	rdt_move_group_tasks(rdtgrp, prdtgrp);
 
 	/* Update per cpu rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
 		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
-	/*
-	 * Update the MSR on moved CPUs and CPUs which have moved
-	 * task running on them.
-	 */
-	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
-	update_closid_rmid(tmpmask, NULL);
+
+	update_closid_rmid(cpu_online_mask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
 	free_rmid(rdtgrp->mon.rmid);
@@ -3156,12 +3140,12 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
-static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
+static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp)
 {
 	int cpu;
 
 	/* Give any tasks back to the default group */
-	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
+	rdt_move_group_tasks(rdtgrp, &rdtgroup_default);
 
 	/* Give any CPUs back to the default group */
 	cpumask_or(&rdtgroup_default.cpu_mask,
@@ -3173,12 +3157,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
 	}
 
-	/*
-	 * Update the MSR on moved CPUs and CPUs which have moved
-	 * task running on them.
-	 */
-	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
-	update_closid_rmid(tmpmask, NULL);
+	update_closid_rmid(cpu_online_mask, NULL);
 
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
@@ -3197,12 +3176,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent_kn = kn->parent;
 	struct rdtgroup *rdtgrp;
-	cpumask_var_t tmpmask;
 	int ret = 0;
 
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
-		return -ENOMEM;
-
 	rdtgrp = rdtgroup_kn_lock_live(kn);
 	if (!rdtgrp) {
 		ret = -EPERM;
@@ -3222,18 +3197,17 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			ret = rdtgroup_ctrl_remove(rdtgrp);
 		} else {
-			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
+			ret = rdtgroup_rmdir_ctrl(rdtgrp);
 		}
 	} else if (rdtgrp->type == RDTMON_GROUP &&
 		 is_mon_groups(parent_kn, kn->name)) {
-		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
+		ret = rdtgroup_rmdir_mon(rdtgrp);
 	} else {
 		ret = -EPERM;
 	}
 
 out:
 	rdtgroup_kn_unlock(kn);
-	free_cpumask_var(tmpmask);
 	return ret;
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

