Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F05629BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKOOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiKOOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:20:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701A2C113
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:20:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b006ccc0e91098so13409047ybp.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yC9Ke3YGhX736WSPCk63GWbYIsXz888Bf6IAXPawHLU=;
        b=XOywDPnEa+UXWJS5Ikk9CGHcb2va06XNmGpLjcPQJUxyn7Qz4yzMBoxicvWD9EK2ED
         9JcOlqJa1G7bfDnXen68Z1HOoFP1qSUi15nth8oQHNj+hhJ9b+dXJUltgvVMDxPZ2ArL
         FTBqhvQy+guB6FCMif/p32wWexaCpW+8z1J9CWHGM9fM41KVoINCPTGY878UogXFGPfM
         hffM5LNUpDi+m79/rCBz4JbepV6pNw7gsiXSxCmzn04fvPhYAmsKQY7AQukIu2UlMpca
         L8i18ex6Xb4U0XOvN7pMNORw7D5En24aHo8QFgD8wO4sGylA1RIqu1im2zt6+8rtISua
         SqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC9Ke3YGhX736WSPCk63GWbYIsXz888Bf6IAXPawHLU=;
        b=qQyRk+kDpJWiN59UtqBctewhDfjEEHboDtU8JSRWd7eLcMsk4TLoRBem1K9TOEygUG
         dikws5VJPTVgStPPVE/0453MP6lgbFhfM3wucrjgNYbbDPriSTD+yJ4+VR08y/XUl0UM
         O9C3ziFTwP0shnpFMdrOZjhtgA049qCOjYgCLuuWQtE8Ywvd6VA98vFmr1Oq8zW1M12q
         FFw8JmK/a6SvTlb4WssSuxjjxNntUywWHqegL4Uy2H1ilBN6WWVDLGq2RBdXitRW5Ao2
         ikkNOrsMsJDzDxTfaCxKQ0BrDcsJfKdCwJKo7dXwQQo3fhx1kIXuyJSbbjmUKASUL2hH
         /uxQ==
X-Gm-Message-State: ANoB5pm442M3NxMqkgZHMyLyoxvK2mopyGmpTy6aip69xCfjo59ZFI4Z
        ypZg7ZoqlkpDzKzIfEu05g/p7AgTDxSbYnBP7g==
X-Google-Smtp-Source: AA0mqf6XW6FgNwyKHwsvDdIMSzsNYo1j8kQNdQFugt/4D4kvvjHjoDnpJxWVlYnQiU7iVUnjcAPT9zfdYR1zDbKcTg==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:fe62:9ede:ae13:6fda])
 (user=peternewman job=sendgmr) by 2002:a0d:e5c5:0:b0:36e:ea2:8b56 with SMTP
 id o188-20020a0de5c5000000b0036e0ea28b56mr17469609ywe.54.1668522046390; Tue,
 15 Nov 2022 06:20:46 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:19:53 +0100
In-Reply-To: <20221115141953.816851-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221115141953.816851-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115141953.816851-3-peternewman@google.com>
Subject: [PATCH v3 2/2] x86/resctrl: update task closid/rmid with task_call_func()
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

In particular, __rdtgroup_move_task() assumed that a CPU migrating
implied that it observed the updated closid/rmid. This assumption is
broken by the following reorderings, both of which are allowed on x86:

 1. In __rdtgroup_move_task(), stores updating the closid and rmid in
    the task structure could reorder with the loads in task_curr() and
    task_cpu().
 2. In resctrl_sched_in(), the earlier stores to the fields read by
    task_curr() could be delayed until after the loads from
    t->{closid,rmid}.

Preventing this reordering with barriers would have required an smp_mb()
in all context switches whenever resctrlfs is mounted.  Instead, when
moving a single task, use task_call_func() to serialize updates to the
closid and rmid fields in the task_struct with context switch.

Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 +++++++++++++++-----------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 049971efea2f..511b7cea143f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -538,10 +538,47 @@ static void _update_task_closid_rmid(void *task)
 		resctrl_sched_in();
 }
 
-static void update_task_closid_rmid(struct task_struct *t)
+static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
 {
-	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
-		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
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
+static void update_task_closid_rmid(struct task_struct *t,
+				    struct rdtgroup *rdtgrp)
+{
+	/*
+	 * Serialize the closid and rmid update with context switch. If this
+	 * function indicates that the task was running, then it needs to be
+	 * interrupted to install the new closid and rmid.
+	 */
+	if (task_call_func(t, update_locked_task_closid_rmid, rdtgrp) &&
+	    IS_ENABLED(CONFIG_SMP))
+		/*
+		 * If the task has migrated away from the CPU indicated by
+		 * task_cpu() below, then it has already switched in on the
+		 * new CPU using the updated closid and rmid and the call below
+		 * unnecessary, but harmless.
+		 */
+		smp_call_function_single(task_cpu(t),
+					 _update_task_closid_rmid, t, 1);
 	else
 		_update_task_closid_rmid(t);
 }
@@ -557,39 +594,16 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
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
2.38.1.493.g58b659f92b-goog

