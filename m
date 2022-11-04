Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E97618E52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKDCgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKDCgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:36:14 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B51E15
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:36:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VTv.72n_1667529361;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VTv.72n_1667529361)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 10:36:09 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched: Clear ttwu_pending after enqueue_task
Date:   Fri,  4 Nov 2022 10:36:01 +0800
Message-Id: <20221104023601.12844-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a long tail latency in schbench whem m*t is close to nr_cpus.
(e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)

This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
too early, and idle_cpu() will return true until the wakee task enqueued.
This will mislead the waker when selecting idle cpu, and wake multiple
worker threads on the same wakee cpu. This situation is enlarged by
commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
wakelist if wakee cpu is idle") because it tends to use wakelist.

Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
(Intel(R) Xeon(R) Platinum 8369B).

Latency percentiles (usec):
                base      base+revert_f3dd3f674555   base+this_patch
50.0000th:         9                            13                 9
75.0000th:        12                            19                12
90.0000th:        15                            22                15
95.0000th:        18                            24                17
*99.0000th:       27                            31                24
99.5000th:      3364                            33                27
99.9000th:     12560                            36                30

We also tested on unixbench and hackbench, and saw no performance
change.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
v2:
Update commit log about other benchmarks.
Add comment in code.
Move the code before rq_unlock. This can make ttwu_pending updated a bit
earlier than v1 so that it can reflect the real condition more timely,
maybe.

v1: https://lore.kernel.org/all/20221101073630.2797-1-dtcccc@linux.alibaba.com/
---
 kernel/sched/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87c9cdf37a26..7a04b5565389 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3739,13 +3739,6 @@ void sched_ttwu_pending(void *arg)
 	if (!llist)
 		return;
 
-	/*
-	 * rq::ttwu_pending racy indication of out-standing wakeups.
-	 * Races such that false-negatives are possible, since they
-	 * are shorter lived that false-positives would be.
-	 */
-	WRITE_ONCE(rq->ttwu_pending, 0);
-
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
@@ -3759,6 +3752,17 @@ void sched_ttwu_pending(void *arg)
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
 	}
 
+	/*
+	 * Must be after enqueueing at least once task such that
+	 * idle_cpu() does not observe a false-negative -- if it does,
+	 * it is possible for select_idle_siblings() to stack a number
+	 * of tasks on this CPU during that window.
+	 *
+	 * It is ok to clear ttwu_pending when another task pending.
+	 * We will receive IPI after local irq enabled and then enqueue it.
+	 * Since now nr_running > 0, idle_cpu() will always get correct result.
+	 */
+	WRITE_ONCE(rq->ttwu_pending, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.27.0

