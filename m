Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6663BEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiK2LLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiK2LLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:11:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FA10B64
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:11:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so13064033ybf.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGkUDP29a4yBSoWuYgHMkH94AykgrslaPfp+GvPTOqc=;
        b=Ub3H3IpKDBQJkHIiWOO0oyGDX+cqdRog00hqEGvkod9f856fH7xjr+j5QUH5e74qYC
         AhSAlnLtUAA2RarZ2+vyhFqrtn4wywNzudg5dX47CzSzMp3s/vyMSHxn7IiR3IrS+5kV
         +EqcmNtB9J+B9uLZRr5f6UU/waAGzQra9MeZEocLmvAn7R9emgB2bNuC7hT3cXcjm/Tb
         9aBhEstoB7keQQrVBbGWp88WHXKyDki/PhaEGzno6dJ0Cbo1iyEt8OgbHwgE3S2iQFP8
         0a6wcmxbBbfYQTVgBrwIknFN22kMKCGS3ELr9jDS8rdwM0jLnG3iFTIU8JR+TTj51sl9
         cqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGkUDP29a4yBSoWuYgHMkH94AykgrslaPfp+GvPTOqc=;
        b=41iuPBbMqXcNF6DsnhKQSRuTC1odRRsfV5IbkelW21EXGOkqqnpOuQCJYtKhBIW+8X
         O9jHKUZi+rCpIerjWLNHTqJAFbOh5MjvrfOy8NS2a2ixKUQsmhmqrfdJosl92iFhG+c/
         4rQ3NZ7gu8apyjA3Srr86SOqXcsziPyWXa2FtXZurtkC97mIdOOeAaUO9n0g8cqJ3DPJ
         wgQstbvyIcedMq3qHSPJaZQOzUXkoaVb5cBshBOSjXJXiycgwv+fByi8NTQjRy5MJA7E
         oml/60m246UEP1rkhDdH0TLWsbdQgN2+LKEsI2Jm3yngU8P3KiFGePd1QzIB6WBmFvDc
         oG9g==
X-Gm-Message-State: ANoB5pml3m6nr3DAOikah8GcW77IBaiizy8TfclHBXwVp9vWMbLE/Io7
        gpKr8R46Vsl9F6b/LOCeAC2wIglr6275n9BNMg==
X-Google-Smtp-Source: AA0mqf6WvtwLJ16U0bJUzIbVMITdvidXn3Elwjfvzuml5qv13d57eLuJcjx5GfrpC7NxYwS4xXgp1H3Gb73baaYCfA==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e398:2261:c909:b359])
 (user=peternewman job=sendgmr) by 2002:a0d:f545:0:b0:377:5ad7:1c9a with SMTP
 id e66-20020a0df545000000b003775ad71c9amr6149710ywf.306.1669720269444; Tue,
 29 Nov 2022 03:11:09 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:10:54 +0100
In-Reply-To: <20221129111055.953833-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221129111055.953833-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129111055.953833-2-peternewman@google.com>
Subject: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with task_call_func()
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

When the user moves a running task to a new rdtgroup using the tasks
file interface, the resulting change in CLOSID/RMID must be immediately
propagated to the PQR_ASSOC MSR on the task's CPU.

It is possible for a task to wake up or migrate while it is being moved
to a new group. If __rdtgroup_move_task() fails to observe that a task
has begun running or misses that it migrated to a new CPU, the task will
continue to use the old CLOSID or RMID until it switches in again.

__rdtgroup_move_task() assumes that if the task migrates off of its CPU
before it can IPI the task, then the task has already observed the
updated CLOSID/RMID. Because this is done locklessly and an x86 CPU can
delay stores until after loads, the following incorrect scenarios are
possible:

 1. __rdtgroup_move_task() stores the new closid and rmid in
    the task structure after it loads task_curr() and task_cpu().
 2. resctrl_sched_in() loads t->{closid,rmid} before the calling context
    switch stores new task_curr() and task_cpu() values.

Use task_call_func() in __rdtgroup_move_task() to serialize updates to
the closid and rmid fields in the task_struct with context switch.

Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++----------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..59b7ffcd53bb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -528,6 +528,31 @@ static void rdtgroup_remove(struct rdtgroup *rdtgrp)
 	kfree(rdtgrp);
 }
 
+static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
+{
+	struct rdtgroup *rdtgrp = arg;
+
+	/*
+	 * Although task_call_func() serializes the writes below with the paired
+	 * reads in resctrl_sched_in(), resctrl_sched_in() still needs
+	 * READ_ONCE() due to rdt_move_group_tasks(), so use WRITE_ONCE() here
+	 * to conform.
+	 */
+	if (rdtgrp->type == RDTCTRL_GROUP) {
+		WRITE_ONCE(t->closid, rdtgrp->closid);
+		WRITE_ONCE(t->rmid, rdtgrp->mon.rmid);
+	} else if (rdtgrp->type == RDTMON_GROUP) {
+		WRITE_ONCE(t->rmid, rdtgrp->mon.rmid);
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
 static void _update_task_closid_rmid(void *task)
 {
 	/*
@@ -538,10 +563,24 @@ static void _update_task_closid_rmid(void *task)
 		resctrl_sched_in();
 }
 
-static void update_task_closid_rmid(struct task_struct *t)
+static void update_task_closid_rmid(struct task_struct *t,
+				    struct rdtgroup *rdtgrp)
 {
-	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
-		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
+	/*
+	 * Serialize the closid and rmid update with context switch. If
+	 * task_call_func() indicates that the task was running during
+	 * update_locked_task_closid_rmid(), then interrupt it.
+	 */
+	if (task_call_func(t, update_locked_task_closid_rmid, rdtgrp) &&
+	    IS_ENABLED(CONFIG_SMP))
+		/*
+		 * If the task has migrated away from the CPU indicated by
+		 * task_cpu() below, then it has already switched in on the
+		 * new CPU using the updated closid and rmid and the call below
+		 * is unnecessary, but harmless.
+		 */
+		smp_call_function_single(task_cpu(t),
+					 _update_task_closid_rmid, t, 1);
 	else
 		_update_task_closid_rmid(t);
 }
@@ -557,39 +596,16 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
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
+	update_task_closid_rmid(tsk, rdtgrp);
 
 	return 0;
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

