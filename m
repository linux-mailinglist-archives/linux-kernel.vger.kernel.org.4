Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD775B3A42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiIIOBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiIIOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E607696A;
        Fri,  9 Sep 2022 07:00:21 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZiCFPj/s8c2noQK7Uibq8m0gp+0ROK/FKslf4sXX7M=;
        b=pYK/skg7xqhpd6NAn/ORFPlbZpJHZWFSGwXk64SO0ISMRctUhqBefBrJXqpq6PnqfTJL5M
        2OX+7x6KgRugqlCOWOJmmRN0SQ4nJAYqBpYa2oHPXiIQqVad5Xhsg+acqPnEA1rusfvTzH
        e9evNa7LQtZuNws0lMfnInXOxQtz8HdYoDpVZuEca5N3GflcfabCrTspBkRdn3ObgINE+l
        hseF4UaoMl5JGhaP4MRcfwjtecJjHfLn+m3ooUs6jA/YqWwIIXKma7J2eClhfIVqn/QaOm
        Qq9umXwYoTUrkMANsH2THOQXapIm89Xqmy+aXGHvajnmCEiS9RW8MkpnpYw6Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZiCFPj/s8c2noQK7Uibq8m0gp+0ROK/FKslf4sXX7M=;
        b=S5zC6Cv8a8OlXIYkumh1tD7BjLoOAf4G++QQVc8wl/3B4KxJUd87xn/9carqwzb+tCQAQo
        Awlw3SDhgGXuG0Cw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Fix periodic aggregation shut off
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-2-zhouchengming@bytedance.com>
References: <20220825164111.29534-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201939.401.5670565753865792420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     c530a3c716b963625e43aa915e0de6b4d1ce8ad9
Gitweb:        https://git.kernel.org/tip/c530a3c716b963625e43aa915e0de6b4d1ce8ad9
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 26 Aug 2022 00:41:02 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:30 +02:00

sched/psi: Fix periodic aggregation shut off

We don't want to wake periodic aggregation work back up if the
task change is the aggregation worker itself going to sleep, or
we'll ping-pong forever.

Previously, we would use psi_task_change() in psi_dequeue() when
task going to sleep, so this check was put in psi_task_change().

But commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
defer task sleep handling to psi_task_switch(), won't go through
psi_task_change() anymore.

So this patch move this check to psi_task_switch().

Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220825164111.29534-2-zhouchengming@bytedance.com
---
 kernel/sched/psi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ecb4b4f..39463dc 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -796,7 +796,6 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	bool wake_clock = true;
 	void *iter = NULL;
 	u64 now;
 
@@ -806,19 +805,9 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	psi_flags_change(task, clear, set);
 
 	now = cpu_clock(cpu);
-	/*
-	 * Periodic aggregation shuts off if there is a period of no
-	 * task changes, so we wake it back up if necessary. However,
-	 * don't do this if the task change is the aggregation worker
-	 * itself going to sleep, or we'll ping-pong forever.
-	 */
-	if (unlikely((clear & TSK_RUNNING) &&
-		     (task->flags & PF_WQ_WORKER) &&
-		     wq_worker_last_func(task) == psi_avgs_work))
-		wake_clock = false;
 
 	while ((group = iterate_groups(task, &iter)))
-		psi_group_change(group, cpu, clear, set, now, wake_clock);
+		psi_group_change(group, cpu, clear, set, now, true);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
@@ -854,6 +843,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 	if (prev->pid) {
 		int clear = TSK_ONCPU, set = 0;
+		bool wake_clock = true;
 
 		/*
 		 * When we're going to sleep, psi_dequeue() lets us
@@ -867,13 +857,23 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				clear |= TSK_MEMSTALL_RUNNING;
 			if (prev->in_iowait)
 				set |= TSK_IOWAIT;
+
+			/*
+			 * Periodic aggregation shuts off if there is a period of no
+			 * task changes, so we wake it back up if necessary. However,
+			 * don't do this if the task change is the aggregation worker
+			 * itself going to sleep, or we'll ping-pong forever.
+			 */
+			if (unlikely((prev->flags & PF_WQ_WORKER) &&
+				     wq_worker_last_func(prev) == psi_avgs_work))
+				wake_clock = false;
 		}
 
 		psi_flags_change(prev, clear, set);
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, clear, set, now, true);
+			psi_group_change(group, cpu, clear, set, now, wake_clock);
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
@@ -882,7 +882,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if (sleep) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
-				psi_group_change(group, cpu, clear, set, now, true);
+				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
 }
