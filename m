Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B126B92B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCNMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:08:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E1D19F13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o1Mn/N1ayy4kj8PawONyZbvWvYwTCPVjQOan6MFzjfg=; b=ClFn0ghaY0r2VHYMRhfCG+S12I
        /FtGN9pbgksF/MAsVIMm5wRQOaXEE3eY1zG5NvBhbjwvBhWtguLCu61S6/wckRvWh+/DJssU9GnTU
        CIT90RNQr640R9gMeWpoxgbC5ZKLDxtMMaLTwCJ8psudDugKKEvU2c4sIF2FFtrjqkrePbekl/a6U
        +kBltUx41DKHk24m3LbWHz06HHeoMww0BjWzinIdLb9t5nl6aZoBw1hF6Basz1L1zzFbz8HMKRAGP
        q1LXeTxuiC67sMrMKX8L3KXvqmYiabZm6xD0llkfHsIFuDXKOfa5v500kOcPXnJAPrQGHGjbeLGpZ
        o4Yi1iGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc3RA-001mAu-2v;
        Tue, 14 Mar 2023 12:07:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BD5E30030F;
        Tue, 14 Mar 2023 13:07:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6EE7202F7F8A; Tue, 14 Mar 2023 13:07:26 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:07:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book>
 <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
 <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 08:41:30AM +0100, Vincent Guittot wrote:

> I'm going to use something a bit different from your proposal below by
> merging initial and flag
> static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity
> *se, int flags)
> 
> with flags:
> 0 for initial placement
> ENQUEUE_WAKEUP for wakeup
> ENQUEUE_MIGRATED for migrated task

So when a task is not running for a long time (our case at hand), then
there's two cases:

 - it wakes up locally and place_entity() gets to reset vruntime;
 - it wakes up remotely and migrate_task_rq_fair() can reset vruntime.

So if we can rely on ENQUEUE_MIGRATED to differentiate between these
cases, when wouldn't something like this work?

---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f855b96..a0d00b6a8bc6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4648,11 +4648,31 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }
 
+static bool reset_vruntime(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	const s64 limit = 60LL * NSEC_PER_SEC;
+	s64 sleep_time;
+
+	/*
+	 * Pull vruntime of the entity being placed to the base level of
+	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
+	 * slept for a long time, don't even try to compare its vruntime with
+	 * the base as it may be too far off and the comparison may get
+	 * inversed due to s64 overflow.
+	 */
+	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
+	if (unlikely(sleep_time > limit)) {
+		se->vruntime = cfs_rq->min_vruntime - calc_delta_fair(limit, se);
+		return true;
+	}
+
+	return false;
+}
+
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
-	u64 sleep_time;
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -4682,18 +4702,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		vruntime -= thresh;
 	}
 
-	/*
-	 * Pull vruntime of the entity being placed to the base level of
-	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
-	 * slept for a long time, don't even try to compare its vruntime with
-	 * the base as it may be too far off and the comparison may get
-	 * inversed due to s64 overflow.
-	 */
-	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
-	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
-		se->vruntime = vruntime;
-	else
-		se->vruntime = max_vruntime(se->vruntime, vruntime);
+	/* ensure we don't gain time by being placed backwards */
+	se->vruntime = max_vruntime(se->vruntime, vruntime);
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -4768,8 +4778,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_cfs_group(se);
 	account_entity_enqueue(cfs_rq, se);
 
-	if (flags & ENQUEUE_WAKEUP)
+	if (flags & ENQUEUE_WAKEUP) {
+		if (!(flags & ENQUEUE_MIGRATED))
+			reset_vruntime(cfs_rq, se);
 		place_entity(cfs_rq, se, 0);
+	}
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
@@ -7625,6 +7638,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
 	struct sched_entity *se = &p->se;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
@@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * min_vruntime -- the latter is done by enqueue_entity() when placing
 	 * the task on the new runqueue.
 	 */
-	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
+	if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
-	}
 
 	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
