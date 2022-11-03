Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A9F617F41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKCOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKCOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:18:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132C167DA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:17:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-373569200ceso19943917b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RezeGMoMXYclRMnnu7CjTCPMmgzmb40YDKkkkpJp18w=;
        b=pVPNV4Ctmyyhgsvwm97Up1qLrqeSZ+mYIWaBuK4dgmYkflRuQr2mIYsyVJUd0sK4rd
         n0hgPSr0B20a1/fJ3DWPkDefI4dTEehS309UZJbgPpp2V3w/kNABAWx/VFfWqQZ9WrKd
         71v4AmWaeMlR3PeM5xUEZicuyUHnK+f5o08oPby3BoOyZmlTF3wEQzGmVdz0zInz2Y34
         WXZGyWTRjiHV59jU0rsSbJ5VwB91NXYz3Qn9fdSFsygq733dgU4X6cVi6KvU+NLwvVJt
         1CSGL5yDoGHTREq5L70Sj9o2axWoeTVlrAohTB3GtOU1/uCJtN510/YG5B+cPYsMT4wa
         H70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RezeGMoMXYclRMnnu7CjTCPMmgzmb40YDKkkkpJp18w=;
        b=pAYjl1AlNgf9BFcVKe3JyaFHNbTK1K1TwOnKhMns5wRsNb2WKdUEZet89FonckaHbH
         YFCCKMGnsWfV46gBtPQYqK2GkUnVM++GHerOCY2SmJmnnWyLpirdPTipdBbUWBSPlEbC
         GA7ou2bOvir0F2nO/vNg0oRLVks6hfjtkRUxwChYES7765wLP91j0egUtzo90BqRlylE
         BiI6Xs5+s74jYmXpomNKbfOBazlIStxHNHFgEVxWRBRVCEYU5pv2mev+NhdM11/fTidw
         yGNaMmcpU4OAKb/15B3HX1grolQddLyB2688rUTx3VUKulzwvmNt72lfiO8Wpcx/tBb4
         EgYw==
X-Gm-Message-State: ANoB5pmYPgIOKE1zwIHLWNB+43EjWfGumLo7i656XL8upS1Cbh3ZLb/8
        0sLUXSD7THWn4kKBF0czJSBiGZTaEJSGfbOTwg==
X-Google-Smtp-Source: AA0mqf4Sm2+avIGTMO5bUNBD87/oDu4viN4cLu79ht3fNj73E14u68zjiDh6I/o+UAJRWcdJLUR1r3m/QLE4KL7vgg==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:5fe6:648d:f013:835f])
 (user=peternewman job=sendgmr) by 2002:a25:6d4:0:b0:6d2:9108:34c with SMTP id
 203-20020a2506d4000000b006d29108034cmr197529ybg.151.1667485041857; Thu, 03
 Nov 2022 07:17:21 -0700 (PDT)
Date:   Thu,  3 Nov 2022 15:16:41 +0100
In-Reply-To: <20221103141641.3055981-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221103141641.3055981-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103141641.3055981-2-peternewman@google.com>
Subject: [PATCH 1/1] x86/resctrl: serialize task CLOSID update with task_call_func()
From:   Peter Newman <peternewman@google.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, jannh@google.com, eranian@google.com,
        kpsingh@google.com, derkling@google.com, james.morse@arm.com,
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

When determining whether tasks need to be interrupted due to a
closid/rmid change, it is possible for the task in question to migrate
or wake up concurrently without observing the updated closid/rmid
values.

This is because stores updating the closid and rmid in the task
structure could reorder with the loads in task_curr() and task_cpu().
Similar reordering also impacts resctrl_sched_in(), where reading the
updated values could reorder with prior stores to t->cpu or rq->curr.

Instead, use task_call_func() to serialize updates to the closid and
rmid fields in the task_struct with context switch. This also removes
the need for READ_ONCE()/WRITE_ONCE when accessing the fields.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/include/asm/resctrl.h         | 11 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 83 +++++++++++++++-----------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index d24b04ebf950..b712106e8f81 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -56,22 +56,19 @@ static void __resctrl_sched_in(void)
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
 	u32 rmid = state->default_rmid;
-	u32 tmp;
 
 	/*
 	 * If this task has a closid/rmid assigned, use it.
 	 * Else use the closid/rmid assigned to this cpu.
 	 */
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		tmp = READ_ONCE(current->closid);
-		if (tmp)
-			closid = tmp;
+		if (current->closid)
+			closid = current->closid;
 	}
 
 	if (static_branch_likely(&rdt_mon_enable_key)) {
-		tmp = READ_ONCE(current->rmid);
-		if (tmp)
-			rmid = tmp;
+		if (current->rmid)
+			rmid = current->rmid;
 	}
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..97cfa841f296 100644
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
@@ -2398,8 +2411,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			WRITE_ONCE(t->closid, to->closid);
-			WRITE_ONCE(t->rmid, to->mon.rmid);
 
 			/*
 			 * If the task is on a CPU, set the CPU in the mask.
@@ -2408,7 +2419,7 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 			 * In such a case the function call is pointless, but
 			 * there is no other side effect.
 			 */
-			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
+			if (update_task_closid_rmid(t, to) && mask)
 				cpumask_set_cpu(task_cpu(t), mask);
 		}
 	}
-- 
2.38.1.273.g43a17bfeac-goog

