Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC167AF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjAYKOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjAYKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:14:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2D4588B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5073cf66299so3177157b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcXbKXfFCZQ65tuD3mFQUJWR038yCPdErih0bDBe5/g=;
        b=JVs98/QdBEeM/4DZBc3DtaO3NheWS9ikg5NYi6FuMMM25iHCQ/O3qX3Pj3Pr/HmMoa
         kpCAQ6S0I1TT6pupwtJMbSUncFNMTaS+Y5gj4BuPperHK7F54pJOBj5jqp3Rb2W/ETrC
         qPN5TcgtzSb6Eioi9yaWXASW2bt5mP9WTz1xrvkMwccT9fmSB9TN/ElOZQDzbaUDjmEu
         aMkN91fpLlf3O6wWlZMsPv14voNumw5cA0skKP7rPC12oaTVg1Jf74AqaIpRbolpUv4A
         +HKSyyhyxXLP3TovBq0eu1jtaTgQpBU2mGb5q2jFaHWfP8b0wl1GybzRYi/8+vnxkPwd
         qsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcXbKXfFCZQ65tuD3mFQUJWR038yCPdErih0bDBe5/g=;
        b=g8nrIAk+FNbewBtfdt7dC0QNIUROVJYio60cwwklaKdtzeSusqCGjQopkgMcEvhD4t
         T2YNT5ss3il8NxjESJZ58yoTaoSLeFI+KqyXtvze1+28hxT2421OjeSrcHuq3uFtiAq9
         LYQy2rugZGzKXivjOMc2BRdIFC/g1L+r93g03KIEX2f8P7C3dtTL0ZbZ/npvZU7OpLrG
         fpGNf4PiLOTEF7SWOKIB3hIpGJt3z/zIoszuu5y+o+iEIDsHAB6kXt/HpZjHc/Tu3Kma
         Vit0KI8XvjTRA+87TQ/qQ872pBiRb8jf9+xuSU9OpdTiCmlhh0VjV+O1VjRo4Dmy99Iu
         ztaQ==
X-Gm-Message-State: AFqh2kqOWUOnZVi9uM8v6nNT3xiPrQ14+oEaZ2yyKkJVeiYl8zRTjT/g
        4rR9+QytKAdoh6MIc9ekQSFIiiLh625/cMvnWg==
X-Google-Smtp-Source: AMrXdXvxbk/q02OwWMKjU/sgeSSCMcMKzCLRXR6TpBECgKrEfw3hA+c5UScAEsOP15DQOTFIAsQS75Tb1Fl66+xujw==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e533:80e6:38fe:22c])
 (user=peternewman job=sendgmr) by 2002:a81:1951:0:b0:4fe:8186:e5fa with SMTP
 id 78-20020a811951000000b004fe8186e5famr2299814ywz.140.1674641629953; Wed, 25
 Jan 2023 02:13:49 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:13:33 +0100
In-Reply-To: <20230125101334.1069060-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230125101334.1069060-1-peternewman@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125101334.1069060-3-peternewman@google.com>
Subject: [PATCH v3 2/3] x86/resctrl: Factor work to update task CLOSID/RMID
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tony.luck@intel.com,
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

Functions that update a task's CLOSID or RMID must determine whether the
task is concurrently running to determine whether the task needs to be
interrupted.

Negotiating the race conditions involved is nuanced, so spare new types
of task group-moving functionality from needing to understand the fine
details.

Factor the task_struct::{closid,rmid} update along with the synchronized
concurrently-running-task check from rdt_move_group_tasks() into a new
rdt_move_one_task() helper. Use this helper in __rdtgroup_move_task() as
well.

This should not result in any functional change.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 60 +++++++++++++-------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c3fb525d52e9..b2081bc1bbfd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -528,6 +528,31 @@ static void rdtgroup_remove(struct rdtgroup *rdtgrp)
 	kfree(rdtgrp);
 }
 
+static void rdt_move_one_task(struct task_struct *t, u32 closid, u32 rmid,
+			      cpumask_var_t mask)
+{
+	WRITE_ONCE(t->closid, closid);
+	WRITE_ONCE(t->rmid, rmid);
+
+	/*
+	 * Order the closid/rmid stores above before the loads
+	 * in task_curr(). This pairs with the full barrier
+	 * between the rq->curr update and resctrl_sched_in()
+	 * during context switch.
+	 */
+	smp_mb();
+
+	/*
+	 * If the task is on a CPU, set the CPU in the mask.
+	 * The detection is inaccurate as tasks might move or
+	 * schedule before the smp function call takes place.
+	 * In such a case the function call is pointless, but
+	 * there is no other side effect.
+	 */
+	if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
+		cpumask_set_cpu(task_cpu(t), mask);
+}
+
 static void _update_task_closid_rmid(void *task)
 {
 	/*
@@ -566,25 +591,17 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 */
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
-		WRITE_ONCE(tsk->closid, rdtgrp->closid);
-		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
+		rdt_move_one_task(tsk, rdtgrp->closid, rdtgrp->mon.rmid, NULL);
 	} else if (rdtgrp->type == RDTMON_GROUP) {
 		if (rdtgrp->mon.parent->closid == tsk->closid) {
-			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
+			rdt_move_one_task(tsk, tsk->closid, rdtgrp->mon.rmid,
+					  NULL);
 		} else {
 			rdt_last_cmd_puts("Can't move task to different control group\n");
 			return -EINVAL;
 		}
 	}
 
-	/*
-	 * Ensure the task's closid and rmid are written before determining if
-	 * the task is current that will decide if it will be interrupted.
-	 * This pairs with the full barrier between the rq->curr update and
-	 * resctrl_sched_in() during context switch.
-	 */
-	smp_mb();
-
 	/*
 	 * By now, the task's closid and rmid are set. If the task is current
 	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
@@ -2409,26 +2426,7 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			WRITE_ONCE(t->closid, to->closid);
-			WRITE_ONCE(t->rmid, to->mon.rmid);
-
-			/*
-			 * Order the closid/rmid stores above before the loads
-			 * in task_curr(). This pairs with the full barrier
-			 * between the rq->curr update and resctrl_sched_in()
-			 * during context switch.
-			 */
-			smp_mb();
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
+			rdt_move_one_task(t, to->closid, to->mon.rmid, mask);
 		}
 	}
 	read_unlock(&tasklist_lock);
-- 
2.39.1.405.gd4c25cc71f-goog

