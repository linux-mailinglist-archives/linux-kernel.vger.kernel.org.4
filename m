Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942525B9D01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIOOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIOOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E54F48EA1;
        Thu, 15 Sep 2022 07:24:13 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxX3cGsrVyOW/1rWmKgYJXocUH3gnkow7vQn/CG2xtk=;
        b=bmlBofHdHvbw6jKwijiiZPx5KK1no80RzsXWUZR1yS+vbVXA6bj8lxLcugZX+VZ1DM62zk
        Eb4JO2Cq8zkD7B0Bwnbo6MFjJfUfEDLxQHYWyd0o3YJMNwEydVMJTuoWGqhLUopx/MWXZ1
        q/vwnMMDxMsD4XsTOTu8CNze4CZRkaHEUW+KL8v/sAdxxZScUef5IlZmS0oVBq/CCkxaGn
        HEgNFHo70vELpeWtCGtbsGid07Autsv14mTHyUlttVQGRnzVhbJ5HBe3Hg8BFCECKVC6Fl
        wSoQBdUHaqYAgEWdisFoMZ5rfbKmJGxVvcKVlYMbMv+rbdInpdNQlxCxTRRzUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxX3cGsrVyOW/1rWmKgYJXocUH3gnkow7vQn/CG2xtk=;
        b=vU15/E1oeERTjs/5m3KihPPxCd4mC6RUFB5wOiORW3/HyBg4bdNl7gxgJEA+lzrE0r1okL
        HYqOAAh/fWwbDbCQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup loop_max and loop_break
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825122726.20819-3-vincent.guittot@linaro.org>
References: <20220825122726.20819-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <166325185114.401.7862558836840812291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c59862f8265f8060b6650ee1dc12159fe5c89779
Gitweb:        https://git.kernel.org/tip/c59862f8265f8060b6650ee1dc12159fe5c89779
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 25 Aug 2022 14:27:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:13:51 +02:00

sched/fair: Cleanup loop_max and loop_break

sched_nr_migrate_break is set to a fix value and never changes so we can
replace it by a define SCHED_NR_MIGRATE_BREAK.

Also, we adjust SCHED_NR_MIGRATE_BREAK to be aligned with the init value
of sysctl_sched_nr_migrate which can be init to different values.

Then, use SCHED_NR_MIGRATE_BREAK to init sysctl_sched_nr_migrate.

The behavior stays unchanged unless you modify sysctl_sched_nr_migrate
trough debugfs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220825122726.20819-3-vincent.guittot@linaro.org
---
 kernel/sched/core.c  |  6 +-----
 kernel/sched/fair.c  | 11 ++++-------
 kernel/sched/sched.h |  6 ++++++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b85d1b..4fa4a3d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -142,11 +142,7 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
-#ifdef CONFIG_PREEMPT_RT
-const_debug unsigned int sysctl_sched_nr_migrate = 8;
-#else
-const_debug unsigned int sysctl_sched_nr_migrate = 32;
-#endif
+const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dae3bfa..7b3a58f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8009,8 +8009,6 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 	return NULL;
 }
 
-static const unsigned int sched_nr_migrate_break = 32;
-
 /*
  * detach_tasks() -- tries to detach up to imbalance load/util/tasks from
  * busiest_rq, as part of a balancing operation within domain "sd".
@@ -8059,7 +8057,7 @@ static int detach_tasks(struct lb_env *env)
 
 		/* take a breather every nr_migrate tasks */
 		if (env->loop > env->loop_break) {
-			env->loop_break += sched_nr_migrate_break;
+			env->loop_break += SCHED_NR_MIGRATE_BREAK;
 			env->flags |= LBF_NEED_BREAK;
 			break;
 		}
@@ -10100,14 +10098,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	struct rq *busiest;
 	struct rq_flags rf;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
-
 	struct lb_env env = {
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
 		.dst_grpmask    = sched_group_span(sd->groups),
 		.idle		= idle,
-		.loop_break	= sched_nr_migrate_break,
+		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -10216,7 +10213,7 @@ more_balance:
 			env.dst_cpu	 = env.new_dst_cpu;
 			env.flags	&= ~LBF_DST_PINNED;
 			env.loop	 = 0;
-			env.loop_break	 = sched_nr_migrate_break;
+			env.loop_break	 = SCHED_NR_MIGRATE_BREAK;
 
 			/*
 			 * Go back to "more_balance" rather than "redo" since we
@@ -10248,7 +10245,7 @@ more_balance:
 			 */
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
-				env.loop_break = sched_nr_migrate_break;
+				env.loop_break = SCHED_NR_MIGRATE_BREAK;
 				goto redo;
 			}
 			goto out_all_pinned;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91b2c7e..1fc198b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2423,6 +2423,12 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
+#ifdef CONFIG_PREEMPT_RT
+#define SCHED_NR_MIGRATE_BREAK 8
+#else
+#define SCHED_NR_MIGRATE_BREAK 32
+#endif
+
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
