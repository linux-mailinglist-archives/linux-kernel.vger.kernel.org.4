Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6072846B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbjFHP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbjFHP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F211A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37B8764EC6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC5C433D2;
        Thu,  8 Jun 2023 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239931;
        bh=WAjW/aFhAStD3otQ1mS7pNSbSHMBmtJIFN275Bic5kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+O9GR1cnStXZVNONXFwv51PLpkZMfpBoC2XCXzOv8Nz3FT8NXr3VOi4mbUMpaPRD
         OWwS8wLjRSZT5ZpdeuoU/hd8jjATLEQXPVBVpSwxdYaAT3ViTTuLDQc5+PO8vYSVd+
         n8VTlKuphSndp5t/abhf4nsJZMmKRQl/YB3aaVpMATWzYiJGTONIMDQAZoakCQtpiU
         Trw2MxQNJ2BXHUiVzApTftjAUX3bFFXpwQlp9iNAo5RwTNUHcLjd7XhqRegSrbpFGz
         vHGAxo8aHBefnSbQ/fr7liQTLde5MzJLXqmiU5X1L1VYrpYzjczFhmsHwt7oyaGjLg
         KugfnIT/Hsvog==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [RFC PATCH V3 5/6] sched/fair: Add trivial fair server
Date:   Thu,  8 Jun 2023 17:58:17 +0200
Message-Id: <8db5a49ea92ad8b875d331d6136721645a382fe8.1686239016.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Use deadline servers to service fair tasks.

This patch adds a fair_server deadline entity which acts as a container
for fair entities and can be used to fix starvation when higher priority
(wrt fair) tasks are monopolizing CPU(s).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 29 +++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b88b822ec89..7506dde9849d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10058,6 +10058,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c58d8e55b69..f493f05c1f84 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6336,6 +6336,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6480,6 +6483,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8221,6 +8227,29 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 	return pick_next_task_fair(rq, NULL, NULL);
 }
 
+static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->cfs.nr_running;
+}
+
+static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+{
+	return pick_next_task_fair(dl_se->rq, NULL, NULL);
+}
+
+void fair_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->fair_server;
+
+	init_dl_entity(dl_se);
+
+	dl_se->dl_runtime = TICK_NSEC;
+	dl_se->dl_deadline = 20 * TICK_NSEC;
+	dl_se->dl_period = 20 * TICK_NSEC;
+
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 390c99e2f8a8..d4a7c0823c53 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -353,6 +353,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
@@ -1015,6 +1017,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
-- 
2.40.1

