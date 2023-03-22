Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2F6C4641
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCVJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:23:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B05DEDE;
        Wed, 22 Mar 2023 02:22:27 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zz9ppyfae31Jdq8hRGy2CPEZ9oMRwUzniy9rsq8qKRs=;
        b=S5+uMMMrPI+L/wq9RR4FzUpMS4FUAFN5FA3vkbeqe70Cwv61zRsjzu771AUEOD/cQqeTm6
        wFyVY9U92PttN37opCb/zwHLBGuBiwJ9n2fopNYk0ik4WzK3bJC4o4l0YhiGXGq7uRrq2R
        oTQBxzwEFRh/aQAbeIWwrlMsJh9UkOoM2Ce9R0VQVqe2n99vxbNinuGgai5Vj6H3Y2no17
        afSFFgqcIgT5cJY6JHU4VDl6mmdf1SPByyyUERZy58DPp7Ft1D6RYUMogx/LCG+krM9ldd
        1OBnYkQ6KtWoAAyyllYjJSaemorhaunIj3caVV+8jurCex3KXXMopoE5Brm4ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zz9ppyfae31Jdq8hRGy2CPEZ9oMRwUzniy9rsq8qKRs=;
        b=vykCPShvKvzArN6yIuspDgMWIMOVm7sGHKrhRWINJYH5ksxfzZSyPKwouYezV5kjziJK2A
        CRRrvll4f+0MHzAQ==
From:   "tip-bot2 for wuchi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Reduce cost of sched_move_task when
 config autogroup
Cc:     wuchi <wuchi.zero@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230321064459.39421-1-wuchi.zero@gmail.com>
References: <20230321064459.39421-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Message-ID: <167947694474.5837.2005982261299761912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eff6c8ce8d4d7faef75f66614dd20bb50595d261
Gitweb:        https://git.kernel.org/tip/eff6c8ce8d4d7faef75f66614dd20bb50595d261
Author:        wuchi <wuchi.zero@gmail.com>
AuthorDate:    Tue, 21 Mar 2023 14:44:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 10:10:58 +01:00

sched/core: Reduce cost of sched_move_task when config autogroup

Some sched_move_task calls are useless because that
task_struct->sched_task_group maybe not changed (equals task_group
of cpu_cgroup) when system enable autogroup. So do some checks in
sched_move_task.

sched_move_task eg:
task A belongs to cpu_cgroup0 and autogroup0, it will always belong
to cpu_cgroup0 when do_exit. So there is no need to do {de|en}queue.
The call graph is as follow.

  do_exit
    sched_autogroup_exit_task
      sched_move_task
	dequeue_task
	  sched_change_group
	    A.sched_task_group = sched_get_task_group (=cpu_cgroup0)
	enqueue_task

Performance results:
===========================
1. env
        cpu: bogomips=4600.00
     kernel: 6.3.0-rc3
 cpu_cgroup: 6:cpu,cpuacct:/user.slice

2. cmds
do_exit script:

  for i in {0..10000}; do
      sleep 0 &
      done
  wait

Run the above script, then use the following bpftrace cmd to get
the cost of sched_move_task:

  bpftrace -e 'k:sched_move_task { @ts[tid] = nsecs; }
	       kr:sched_move_task /@ts[tid]/
		  { @ns += nsecs - @ts[tid]; delete(@ts[tid]); }'

3. cost time(ns):
  without patch: 43528033
  with    patch: 18541416
           diff:-24986617  -57.4%

As the result show, the patch will save 57.4% in the scenario.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230321064459.39421-1-wuchi.zero@gmail.com
---
 kernel/sched/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9140a33..5ddd961 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10351,7 +10351,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk)
+static struct task_group *sched_get_task_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10363,7 +10363,13 @@ static void sched_change_group(struct task_struct *tsk)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
-	tsk->sched_task_group = tg;
+
+	return tg;
+}
+
+static void sched_change_group(struct task_struct *tsk, struct task_group *group)
+{
+	tsk->sched_task_group = group;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
@@ -10384,10 +10390,19 @@ void sched_move_task(struct task_struct *tsk)
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	struct task_group *group;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
+	/*
+	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
+	 * group changes.
+	 */
+	group = sched_get_task_group(tsk);
+	if (group == tsk->sched_task_group)
+		goto unlock;
+
 	update_rq_clock(rq);
 
 	running = task_current(rq, tsk);
@@ -10398,7 +10413,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk);
+	sched_change_group(tsk, group);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10412,6 +10427,7 @@ void sched_move_task(struct task_struct *tsk)
 		resched_curr(rq);
 	}
 
+unlock:
 	task_rq_unlock(rq, tsk, &rf);
 }
 
