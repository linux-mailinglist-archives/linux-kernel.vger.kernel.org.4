Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213AF6243A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiKJNzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKJNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:54:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D2178A4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:54:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 205-20020a2503d6000000b006d2132f6f85so1790302ybd.16
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iP/1UvGbOqvBxyhprAbfpVPRfGEm8sUWqwa2dVvhtsk=;
        b=SOA7Hqjdg10bcMaZst8w3cmFHnzMVziQYPuXnkrR3jAXsTQhiYWRoBufPLcUb/t+Hq
         7jFQNg01qlyqBKJBN3J264imDsn3khKzwxyzwLoySLBp+Khzh+TLVpkSjLjveSAxv+aj
         19QU9I5z7LAHZfoAIi3aFhYG465c5E9eT4wKpdCgw25mP/59htEwIq0ydF0GzQyTvTEq
         0wF1oCzqOSKI9TQx0H8R9NV3hsdivTqM0hfa499ezVF0/5a6mVaV1khbeXYisW5UgmpH
         MJrwqRN/aZC2pLjGTonkxx5IiwQ0rL51T8p7CQmTUjlz+5jlDFnswXN4mZhnA6KD3PCJ
         xwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iP/1UvGbOqvBxyhprAbfpVPRfGEm8sUWqwa2dVvhtsk=;
        b=RF2dbkqCN5azSQEIwqdi9g1KRG5XCCUBKnR1qJ8SLm6F3vOFzv7IlXO6zzOwjD/prU
         IiXGupOJwQgyULRQa/qzERQcErcvfCalCpkzdqn8xRGUcuK+lsyuEaZN3xUT+YBBsx0x
         y8FBMhUdyHR11+hYh6uSOo1+x4cXKG5CM82hqk4Gy+iwhRXHwJj8iXyic/mzhOUomOq9
         sf93J+ByCUGpZwAGlUzO9ogRUXsCOj58tlc7OABjl8JXFw9qiN4BE4fkxk0PucI0wlPv
         NnRuizjWrEtYmTOL+OHAe7qKVaAwCVe1L78jsdkLDsg3v47xXZiXPsDz9WM0w7G6lFva
         EAOA==
X-Gm-Message-State: ACrzQf2g0TjVjPgH3cnJtcy5gzrbxmd0gEfvCIQZPkjgoya52XkDOAOj
        jdY5Wfi7Wb8I0yAt6L8IBUyAEvVulkl5N1PGrw==
X-Google-Smtp-Source: AMsMyM53YBuuCnfnDeMEPhL+BGToNjml1Rx09Brbe5ODzJhqi2+7/jtm28XmhIrJEmeZHEqWFywVPik9H7sKXubuIA==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:f007:de:9ed3:3a96])
 (user=peternewman job=sendgmr) by 2002:a81:3984:0:b0:370:7d9b:7a6d with SMTP
 id g126-20020a813984000000b003707d9b7a6dmr47885213ywa.274.1668088494911; Thu,
 10 Nov 2022 05:54:54 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:53:45 +0100
In-Reply-To: <20221110135346.2209839-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221110135346.2209839-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110135346.2209839-2-peternewman@google.com>
Subject: [PATCH v2 1/1] x86/resctrl: fix task closid/rmid update race
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

When determining whether running tasks need to be interrupted due to a
closid/rmid change, it was possible for the task in question to migrate
or wake up concurrently without observing the updated values.

This was because stores updating the closid and rmid in the task
structure could reorder with the loads in task_curr() and task_cpu().
Similar reordering also impacted resctrl_sched_in(), where reading the
updated values could reorder with prior stores to t->on_cpu.

Instead, when moving a single task, use task_call_func() to serialize
updates to the closid and rmid fields in the task_struct with context
switch.

When deleting a group, just update the MSRs on all CPUs rather than
calling task_call_func() on every task in a potentially long list while
read-locking the tasklist_lock.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 134 ++++++++++++-------------
 1 file changed, 62 insertions(+), 72 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..d645f9a6c22e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -538,12 +538,38 @@ static void _update_task_closid_rmid(void *task)
 		resctrl_sched_in();
 }
 
-static void update_task_closid_rmid(struct task_struct *t)
+static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
 {
-	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
-		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
-	else
-		_update_task_closid_rmid(t);
+	struct rdtgroup *rdtgrp = arg;
+
+	/*
+	 * We assume task_call_func() has provided the necessary serialization
+	 * with resctrl_sched_in().
+	 */
+	if (rdtgrp->type == RDTCTRL_GROUP) {
+		t->closid = rdtgrp->closid;
+		t->rmid = rdtgrp->mon.rmid;
+	} else if (rdtgrp->type == RDTMON_GROUP) {
+		t->rmid = rdtgrp->mon.rmid;
+	}
+
+	/*
+	 * If the task is current on a CPU, the PQR_ASSOC MSR needs to be
+	 * updated to make the resource group go into effect. If the task is not
+	 * current, the MSR will be updated when the task is scheduled in.
+	 */
+	return task_curr(t);
+}
+
+static bool update_task_closid_rmid(struct task_struct *t,
+				    struct rdtgroup *rdtgrp)
+{
+	/*
+	 * Serialize the closid and rmid update with context switch. If this
+	 * function indicates that the task was running, then it needs to be
+	 * interrupted to install the new closid and rmid.
+	 */
+	return task_call_func(t, update_locked_task_closid_rmid, rdtgrp);
 }
 
 static int __rdtgroup_move_task(struct task_struct *tsk,
@@ -557,39 +583,26 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 		return 0;
 
 	/*
-	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
-	 * updated by them.
-	 *
-	 * For ctrl_mon groups, move both closid and rmid.
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
+	    rdtgrp->mon.parent->closid != tsk->closid) {
+		rdt_last_cmd_puts("Can't move task to different control group\n");
+		return -EINVAL;
 	}
 
-	/*
-	 * Ensure the task's closid and rmid are written before determining if
-	 * the task is current that will decide if it will be interrupted.
-	 */
-	barrier();
-
-	/*
-	 * By now, the task's closid and rmid are set. If the task is current
-	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
-	 * group go into effect. If the task is not current, the MSR will be
-	 * updated when the task is scheduled in.
-	 */
-	update_task_closid_rmid(tsk);
+	if (update_task_closid_rmid(tsk, rdtgrp) && IS_ENABLED(CONFIG_SMP))
+		/*
+		 * If the task has migrated away from the CPU indicated by
+		 * task_cpu() below, then it has already switched in on the
+		 * new CPU using the updated closid and rmid and the call below
+		 * unnecessary, but harmless.
+		 */
+		smp_call_function_single(task_cpu(tsk),
+					 _update_task_closid_rmid, tsk, 1);
+	else
+		_update_task_closid_rmid(tsk);
 
 	return 0;
 }
@@ -2385,12 +2398,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
  *
- * If @mask is not NULL the cpus on which moved tasks are running are set
- * in that mask so the update smp function call is restricted to affected
- * cpus.
+ * Following this operation, the caller is required to update the MSRs on all
+ * CPUs. The cost of constructing the precise mask of CPUs impacted by this
+ * operation will likely be high, during which we'll be blocking writes to the
+ * tasklist, and in non-trivial cases, the resulting mask would contain most of
+ * the CPUs anyways.
  */
-static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
-				 struct cpumask *mask)
+static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to)
 {
 	struct task_struct *p, *t;
 
@@ -2400,16 +2414,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
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
@@ -2440,7 +2444,7 @@ static void rmdir_all_sub(void)
 	struct rdtgroup *rdtgrp, *tmp;
 
 	/* Move all tasks to the default resource group */
-	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
+	rdt_move_group_tasks(NULL, &rdtgroup_default);
 
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
@@ -3099,23 +3103,19 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
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
@@ -3140,12 +3140,12 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
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
@@ -3157,12 +3157,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
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
@@ -3181,12 +3176,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
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
@@ -3206,18 +3197,17 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
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
2.38.1.431.g37b22c650d-goog

