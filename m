Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52658617BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKCLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKCLiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:38:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EAA11C3B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:38:24 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N31sC4BtVzJnL5;
        Thu,  3 Nov 2022 19:35:27 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:38:22 +0800
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 19:38:22 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <brauner@kernel.org>,
        <yusongping@huawei.com>, Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH v2 1/2] sched: Init new task's vruntime after select cpu
Date:   Thu, 3 Nov 2022 20:07:19 +0800
Message-ID: <20221103120720.39873-2-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103120720.39873-1-zhangqiao22@huawei.com>
References: <20221103120720.39873-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When create a new task, we initialize vruntime of the new task
at sched_cgroup_fork(). However, this action is executed too
early and may be incorrect, because it use current cpu to
init the vruntime, but the new task actually runs on the
cpu assigned at wake_up_new_task().

So the patch call task_fork() after select fork cpu and use
the ready cpu(the child will run on it) init the new task.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
v1->v2:
	make sched_task_fork static.

 kernel/sched/core.c | 7 ++++++-
 kernel/sched/fair.c | 7 +------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e4ce124ec701..21481bd22bdf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4627,9 +4627,13 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	 * so use __set_task_cpu().
 	 */
 	__set_task_cpu(p, smp_processor_id());
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+}
+
+static void sched_task_fork(struct task_struct *p)
+{
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
 
 void sched_post_fork(struct task_struct *p)
@@ -4682,6 +4686,7 @@ void wake_up_new_task(struct task_struct *p)
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
+	sched_task_fork(p);
 	post_init_entity_util_avg(p);
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..34845d425180 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11603,12 +11603,8 @@ static void task_fork_fair(struct task_struct *p)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se, *curr;
 	struct rq *rq = this_rq();
-	struct rq_flags rf;
 
-	rq_lock(rq, &rf);
-	update_rq_clock(rq);
-
-	cfs_rq = task_cfs_rq(current);
+	cfs_rq = task_cfs_rq(p);
 	curr = cfs_rq->curr;
 	if (curr) {
 		update_curr(cfs_rq);
@@ -11626,7 +11622,6 @@ static void task_fork_fair(struct task_struct *p)
 	}
 
 	se->vruntime -= cfs_rq->min_vruntime;
-	rq_unlock(rq, &rf);
 }
 
 /*
-- 
2.17.1

