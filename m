Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE7613407
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJaKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJaKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:54:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900643B0;
        Mon, 31 Oct 2022 03:54:01 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667213640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RSPSY5wJRYnB3ugtXqJ84HMVoLdph8PuV40tRRxlbo=;
        b=fMvQllP91q/TwdfIVhimqRHoZSEmp9RDZ7QNp88cIjQbtCwQK1Gl4b7klRNh5I08GEQcZ9
        6uJB0sw4Gm5qHba7xjuQ+aKKrOiODTNbwf8Tvgbjn/v3AdrOQpYihG/ZZr4AuqHn34noj0
        Q117cRM30qEbz9OI10W/s1HHYVBqWb3SjlHIWWr+HYg6lQj08IX9yKCseDQG4RNx3uYo7f
        g7nfLsh9LS272Z5QW4gbIELxXgS5aXB7BjUU8nkegCgq01ehOqQBNEnafP5IEuq2Nqn6Sp
        Jy6szq3h8FlF56yOvsltqZw6sNwG3Bn3lE1iCE7PirdhF4q2QMm0JgJMpL6frg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667213640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RSPSY5wJRYnB3ugtXqJ84HMVoLdph8PuV40tRRxlbo=;
        b=J7X/aGi+zP81FK86oE0C17+uTxsYaekQTauECABdLd54f2lR4/hesXHoRhYoD+rUdvAZyg
        edU4ro+D5qhXEcDQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221014110551.22695-1-zhouchengming@bytedance.com>
References: <20221014110551.22695-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166721363899.7716.17032008194707353302.tip-bot2@tip-bot2>
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

Commit-ID:     2fcd7bbae90a6d844da8660a9d27079281dfbba2
Gitweb:        https://git.kernel.org/tip/2fcd7bbae90a6d844da8660a9d27079281dfbba2
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 14 Oct 2022 19:05:51 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 30 Oct 2022 10:12:14 +01:00

sched/psi: Fix avgs_work re-arm in psi_avgs_work()

Pavan reported a problem that PSI avgs_work idle shutoff is not
working at all. Because PSI_NONIDLE condition would be observed in
psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
only the kworker running avgs_work on the CPU.

Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
still will always re-arm the avgs_work, so shutoff is not working.

This patch changes to use PSI_STATE_RESCHEDULE to flag whether to
re-arm avgs_work in get_recent_times(). For the current CPU, we re-arm
avgs_work only when (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0),
for other CPUs we can just check PSI_NONIDLE delta. The new flag
is only used in psi_avgs_work(), so we check in get_recent_times()
that current_work() is avgs_work.

One potential problem is that the brief period of non-idle time
incurred between the aggregation run and the kworker's dequeue will
be stranded in the per-cpu buckets until avgs_work run next time.
The buckets can hold 4s worth of time, and future activity will wake
the avgs_work with a 2s delay, giving us 2s worth of data we can leave
behind when shut off the avgs_work. If the kworker run other works after
avgs_work shut off and doesn't have any scheduler activities for 2s,
this maybe a problem.

Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Link: https://lore.kernel.org/r/20221014110551.22695-1-zhouchengming@bytedance.com
---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 30 +++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 6e43727..3259818 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -72,6 +72,9 @@ enum psi_states {
 /* Use one bit in the state mask to track TSK_ONCPU */
 #define PSI_ONCPU	(1 << NR_PSI_STATES)
 
+/* Flag whether to re-arm avgs_work, see details in get_recent_times() */
+#define PSI_STATE_RESCHEDULE	(1 << (NR_PSI_STATES + 1))
+
 enum psi_aggregators {
 	PSI_AVGS = 0,
 	PSI_POLL,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7f40d87..a4348af 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	int current_cpu = raw_smp_processor_id();
+	unsigned int tasks[NR_PSI_TASK_COUNTS];
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
@@ -256,6 +258,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
+		if (cpu == current_cpu)
+			memcpy(tasks, groupc->tasks, sizeof(groupc->tasks));
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
@@ -280,6 +284,28 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		if (delta)
 			*pchanged_states |= (1 << s);
 	}
+
+	/*
+	 * When collect_percpu_times() from the avgs_work, we don't want to
+	 * re-arm avgs_work when all CPUs are IDLE. But the current CPU running
+	 * this avgs_work is never IDLE, cause avgs_work can't be shut off.
+	 * So for the current CPU, we need to re-arm avgs_work only when
+	 * (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0), for other CPUs
+	 * we can just check PSI_NONIDLE delta.
+	 */
+	if (current_work() == &group->avgs_work.work) {
+		bool reschedule;
+
+		if (cpu == current_cpu)
+			reschedule = tasks[NR_RUNNING] +
+				     tasks[NR_IOWAIT] +
+				     tasks[NR_MEMSTALL] > 1;
+		else
+			reschedule = *pchanged_states & (1 << PSI_NONIDLE);
+
+		if (reschedule)
+			*pchanged_states |= PSI_STATE_RESCHEDULE;
+	}
 }
 
 static void calc_avgs(unsigned long avg[3], int missed_periods,
@@ -415,7 +441,6 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
-	bool nonidle;
 	u64 now;
 
 	dwork = to_delayed_work(work);
@@ -426,7 +451,6 @@ static void psi_avgs_work(struct work_struct *work)
 	now = sched_clock();
 
 	collect_percpu_times(group, PSI_AVGS, &changed_states);
-	nonidle = changed_states & (1 << PSI_NONIDLE);
 	/*
 	 * If there is task activity, periodically fold the per-cpu
 	 * times and feed samples into the running averages. If things
@@ -437,7 +461,7 @@ static void psi_avgs_work(struct work_struct *work)
 	if (now >= group->avg_next_update)
 		group->avg_next_update = update_averages(group, now);
 
-	if (nonidle) {
+	if (changed_states & PSI_STATE_RESCHEDULE) {
 		schedule_delayed_work(dwork, nsecs_to_jiffies(
 				group->avg_next_update - now) + 1);
 	}
