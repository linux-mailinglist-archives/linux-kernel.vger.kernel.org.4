Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5670629BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKOOUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKOOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:20:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8076302
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:20:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso13510271ybq.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Rh/h+6ZlGogt/ZH/3bghOOublc3eLBTZ62pXvqBB0=;
        b=Le4fVp49o0yfNlNz3lamiy4HVGXzuJy2v+4u3zckXkIED6ol/l6y1jHC4u8URf3S4J
         A9Q+huxLdU2lF0Jx5w1wIeYtPBpptsjYEWA+4ppCbLVP/AavZDXVK+3dF6CK/T8pmqIL
         mT9tD6fqOpkYSk0/B7EJ+ELjTwnNyNOZnpDSQNOOhuxyCM7Erk74AQRZzMuAPc9TNaA/
         u8FO9nAQC/gdhUb7I9vZTCQb/I+YKWwbydiz/d2HelSxGm8Z8YYdNg3oLjPj+JThKQNv
         QtTIEi2GjkY2z4I6Blrw+OjeDohQkP9+JyMZEu8U1C+4CU96q/npcMzSbo8UF3Ms8OOd
         mwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Rh/h+6ZlGogt/ZH/3bghOOublc3eLBTZ62pXvqBB0=;
        b=qqRhFHBq84M5qMSBb6x04a5LILllm42lFlbJLf2qiy8xaftsR6ltbcK5DHDfVKFYeT
         14hymGxggaq8FbahXb2vNAGr3p+mAYYb0kb9hwEAZ6oRCAfoMYVG5hrQsvWzEQ/+5fCe
         QxmJeolJfDrUoYWQfpyqGlYvcT13g07eOjWdEInG93tWxZ9UQqpjpFeYTak3tEz6bF/b
         zKrWK16I0c2XdwXcdYibMQL/9NtsAQptG2B/Iqjwfse3io2LdDDIxPlZj3l8uxKQZQBg
         zzK/jSSl0H0EbSP0V/+omgG13ZdEJLXH6FwK2FMH3KEDJD0rP3gQ+6n9UsZ2nAU+deGi
         6VAw==
X-Gm-Message-State: ANoB5pmjLZxEjZ6ygaO5dAPOU54maJKQF94jN7kotUgHCtEhNWidf/AB
        R5Eq41UOieMKmGnAYKkI/jl2kzWooktFY+/sYw==
X-Google-Smtp-Source: AA0mqf6yqzAhYPY8h9XKWJy/KMPKONh+CM/C0jHNdmmlRWsk/D+/TB4aivrx6pejoMYtJCnNPsjtbbd4odc3kLD6Cg==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:fe62:9ede:ae13:6fda])
 (user=peternewman job=sendgmr) by 2002:a25:d6:0:b0:6ca:1be0:9e4c with SMTP id
 205-20020a2500d6000000b006ca1be09e4cmr15819340yba.567.1668522038137; Tue, 15
 Nov 2022 06:20:38 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:19:52 +0100
In-Reply-To: <20221115141953.816851-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221115141953.816851-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115141953.816851-2-peternewman@google.com>
Subject: [PATCH v3 1/2] x86/resctrl: IPI all CPUs for group updates
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

To rule out needing to update a CPU when deleting an rdtgroup, we must
search the entire tasklist for group members which could be running on
that CPU. This needs to be done while blocking updates to the tasklist
to avoid leaving newly-created child tasks assigned to the old
CLOSID/RMID.

The cost of reliably propagating a CLOSID or RMID update to a single
task is higher than originally thought. The present understanding is
that we must obtain the task_rq_lock() on each task to ensure that it
observes CLOSID/RMID updates in the case that it migrates away from its
current CPU before the update IPI reaches it.

For now, just notify all the CPUs after updating the closid/rmid fields
in impacted tasks task_structs rather than paying the cost of obtaining
a more precise cpu mask.

Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 +++++++-------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..049971efea2f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2385,12 +2385,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
  *
- * If @mask is not NULL the cpus on which moved tasks are running are set
- * in that mask so the update smp function call is restricted to affected
- * cpus.
+ * Following this operation, the caller is required to update the MSRs on all
+ * CPUs.
  */
-static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
-				 struct cpumask *mask)
+static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to)
 {
 	struct task_struct *p, *t;
 
@@ -2400,16 +2398,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
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
@@ -2440,7 +2428,7 @@ static void rmdir_all_sub(void)
 	struct rdtgroup *rdtgrp, *tmp;
 
 	/* Move all tasks to the default resource group */
-	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
+	rdt_move_group_tasks(NULL, &rdtgroup_default);
 
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
@@ -3099,23 +3087,19 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
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
@@ -3140,12 +3124,12 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
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
@@ -3157,12 +3141,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
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
@@ -3181,12 +3160,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
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
@@ -3206,18 +3181,17 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
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
2.38.1.493.g58b659f92b-goog

