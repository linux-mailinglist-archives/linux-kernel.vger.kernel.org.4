Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD161451D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKAHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:36:48 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B9387
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 00:36:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VTejVpy_1667288190;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VTejVpy_1667288190)
          by smtp.aliyun-inc.com;
          Tue, 01 Nov 2022 15:36:44 +0800
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
Subject: [PATCH] sched: Clear ttwu_pending after enqueue_task
Date:   Tue,  1 Nov 2022 15:36:30 +0800
Message-Id: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87c9cdf37a26..b07de1753be5 100644
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
 
@@ -3760,6 +3753,7 @@ void sched_ttwu_pending(void *arg)
 	}
 
 	rq_unlock_irqrestore(rq, &rf);
+	WRITE_ONCE(rq->ttwu_pending, 0);
 }
 
 void send_call_function_single_ipi(int cpu)
-- 
2.27.0

