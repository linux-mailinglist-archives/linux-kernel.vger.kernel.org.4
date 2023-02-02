Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C468868E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjBBScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjBBScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:32:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2830D7E6DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675362553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/2CxDEOz/wKRg3fPVeBOZL5/A6pUQeGKLsIcyTY078w=;
        b=dzFb6Sz/l8Js9eL7OT71ft7tACdvNmXGCdEJAqhYqp+sR3+Xj3Dohrbv1yyNCjFQJ2YB3V
        c+dMUGkalots3EVw/RcnjbzYJcJSguCS4t7Gkk3HVD3n1yg9l+oTzpSz3WTc8yh529N0ZL
        JnONShKfl287lCbAXuULoZTjcTlgP0E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-yacWg-_YP2WGO1gFxz4KjA-1; Thu, 02 Feb 2023 13:29:10 -0500
X-MC-Unique: yacWg-_YP2WGO1gFxz4KjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3C4A3810B14;
        Thu,  2 Feb 2023 18:29:09 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.36.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B0DF140EBF6;
        Thu,  2 Feb 2023 18:29:08 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Eder Zulian <ezulian@redhat.com>
Subject: [RFC PATCH v1] sched/deadline: Add more reschedule cases to prio_changed_dl()
Date:   Thu,  2 Feb 2023 18:28:54 +0000
Message-Id: <20230202182854.3696665-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been tracking down an issue on a ~5.17ish kernel where:

  CPUx                           CPUy

  <DL task p0 owns an rtmutex M>
  <p0 depletes its runtime, gets throttled>
  <rq switches to the idle task>
				 <DL task p1 blocks on M, boost/replenish p0>
				 <No call to resched_curr() happens here>

  [idle task keeps running here until *something*
   accidentally sets TIF_NEED_RESCHED]

On that kernel, it is quite easy to trigger using rt-tests's deadline_test
[1] with the test running on isolated CPUs (this reduces the chance of
something unrelated setting TIF_NEED_RESCHED on the idle tasks, making the
issue even more obvious as the hung task detector chimes in).

I haven't been able to reproduce this using a mainline kernel, even if I
revert

  2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")

which gets rid of the lock involved in the above test, *but* I cannot
convince myself the issue isn't there from looking at the code.

Make prio_changed_dl() issue a reschedule if the current task isn't a
deadline one. While at it, ensure a reschedule is emitted when a
queued-but-not-current task gets boosted with an earlier deadline that
current's.

[1]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0d97d54276cc8..faa382ea084c1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2663,17 +2663,28 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 			    int oldprio)
 {
-	if (task_on_rq_queued(p) || task_current(rq, p)) {
-#ifdef CONFIG_SMP
-		/*
-		 * This might be too much, but unfortunately
-		 * we don't have the old deadline value, and
-		 * we can't argue if the task is increasing
-		 * or lowering its prio, so...
-		 */
-		if (!rq->dl.overloaded)
-			deadline_queue_pull_task(rq);
+	if (!task_on_rq_queued(p))
+		return;
+
+	/*
+	 * We don't know if p has a earlier or later deadline, so let's blindly
+	 * set a (maybe not needed) rescheduling point.
+	 */
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		resched_curr(rq);
+		return;
+	}
 
+	/*
+	 * This might be too much, but unfortunately
+	 * we don't have the old deadline value, and
+	 * we can't argue if the task is increasing
+	 * or lowering its prio, so...
+	 */
+	if (!rq->dl.overloaded)
+		deadline_queue_pull_task(rq);
+
+	if (task_current(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
@@ -2681,14 +2692,16 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		 */
 		if (dl_time_before(rq->dl.earliest_dl.curr, p->dl.deadline))
 			resched_curr(rq);
-#else
+	} else {
 		/*
-		 * Again, we don't know if p has a earlier
-		 * or later deadline, so let's blindly set a
-		 * (maybe not needed) rescheduling point.
+		 * Current may not be deadline in case p was throttled but we
+		 * have just replenished it (e.g. rt_mutex_setprio()).
+		 *
+		 * Otherwise, if p was given an earlier deadline, reschedule.
 		 */
-		resched_curr(rq);
-#endif /* CONFIG_SMP */
+		if (!dl_task(rq->curr) ||
+		    dl_time_before(p->dl.deadline, rq->curr->dl.deadline))
+			resched_curr(rq);
 	}
 }
 
-- 
2.31.1

