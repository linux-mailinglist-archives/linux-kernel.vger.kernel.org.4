Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC66D93A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjDFKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjDFKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:05:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710844C25;
        Thu,  6 Apr 2023 03:05:20 -0700 (PDT)
Date:   Thu, 06 Apr 2023 10:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680775519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAUoQtoa+HaIHus6AHLAn7oXTqcHh2QU+4dRvxIhIOk=;
        b=QncabW+1AxVpWJg/ZR/v+gpB4zf7RN45wsm+NQ62b+IdwPJejWTTOGuAvFFYkP2DyQc8xE
        PAqpt9HXIxWG6M99E2LfZOtHQ4g+Il7dVqlf7YyU3s6JAWuC2+e6h4OQwoaDi/iN2Fivd7
        FN3tP0rqKGWaVnfxV+l2wIeg8kiIQ8QVHmFmvwW99VfrtchGie4K2yUSQQ//Xs32E41F2s
        gQZMyaWhi6uay+y42xyU7kTEmGs5/yf1kPqc3vo0Qmbxz/eTX5lYnCDrjW29gUFKvv25s8
        BntrHfx7HQQs7RGPuk2u4+h8G94viqMP2GZfaYaUqKay8g7ZTmjd8A3SVoQRJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680775519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAUoQtoa+HaIHus6AHLAn7oXTqcHh2QU+4dRvxIhIOk=;
        b=zUY1Z04WaaIj/UHV9oZVe5AEzVb/EGonyqLcNaucnFcyYe4FdEHmv1UuuHZ1ocEIOFHusw
        XwdDsfPecnIOkQDQ==
From:   "tip-bot2 for Domenico Cerasuolo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Rearrange polling code in preparation
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230330105418.77061-2-cerasuolodomenico@gmail.com>
References: <20230330105418.77061-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Message-ID: <168077551864.404.4343815726277512920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7fab21fa0d000a0ea32d73ce8eec68557c6c268b
Gitweb:        https://git.kernel.org/tip/7fab21fa0d000a0ea32d73ce8eec68557c6c268b
Author:        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
AuthorDate:    Thu, 30 Mar 2023 12:54:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Apr 2023 09:58:48 +02:00

sched/psi: Rearrange polling code in preparation

Move a few functions up in the file to avoid forward declaration needed
in the patch implementing unprivileged PSI triggers.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20230330105418.77061-2-cerasuolodomenico@gmail.com
---
 kernel/sched/psi.c | 196 ++++++++++++++++++++++----------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 02e011c..fe9269f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -384,92 +384,6 @@ static void collect_percpu_times(struct psi_group *group,
 		*pchanged_states = changed_states;
 }
 
-static u64 update_averages(struct psi_group *group, u64 now)
-{
-	unsigned long missed_periods = 0;
-	u64 expires, period;
-	u64 avg_next_update;
-	int s;
-
-	/* avgX= */
-	expires = group->avg_next_update;
-	if (now - expires >= psi_period)
-		missed_periods = div_u64(now - expires, psi_period);
-
-	/*
-	 * The periodic clock tick can get delayed for various
-	 * reasons, especially on loaded systems. To avoid clock
-	 * drift, we schedule the clock in fixed psi_period intervals.
-	 * But the deltas we sample out of the per-cpu buckets above
-	 * are based on the actual time elapsing between clock ticks.
-	 */
-	avg_next_update = expires + ((1 + missed_periods) * psi_period);
-	period = now - (group->avg_last_update + (missed_periods * psi_period));
-	group->avg_last_update = now;
-
-	for (s = 0; s < NR_PSI_STATES - 1; s++) {
-		u32 sample;
-
-		sample = group->total[PSI_AVGS][s] - group->avg_total[s];
-		/*
-		 * Due to the lockless sampling of the time buckets,
-		 * recorded time deltas can slip into the next period,
-		 * which under full pressure can result in samples in
-		 * excess of the period length.
-		 *
-		 * We don't want to report non-sensical pressures in
-		 * excess of 100%, nor do we want to drop such events
-		 * on the floor. Instead we punt any overage into the
-		 * future until pressure subsides. By doing this we
-		 * don't underreport the occurring pressure curve, we
-		 * just report it delayed by one period length.
-		 *
-		 * The error isn't cumulative. As soon as another
-		 * delta slips from a period P to P+1, by definition
-		 * it frees up its time T in P.
-		 */
-		if (sample > period)
-			sample = period;
-		group->avg_total[s] += sample;
-		calc_avgs(group->avg[s], missed_periods, sample, period);
-	}
-
-	return avg_next_update;
-}
-
-static void psi_avgs_work(struct work_struct *work)
-{
-	struct delayed_work *dwork;
-	struct psi_group *group;
-	u32 changed_states;
-	u64 now;
-
-	dwork = to_delayed_work(work);
-	group = container_of(dwork, struct psi_group, avgs_work);
-
-	mutex_lock(&group->avgs_lock);
-
-	now = sched_clock();
-
-	collect_percpu_times(group, PSI_AVGS, &changed_states);
-	/*
-	 * If there is task activity, periodically fold the per-cpu
-	 * times and feed samples into the running averages. If things
-	 * are idle and there is no data to process, stop the clock.
-	 * Once restarted, we'll catch up the running averages in one
-	 * go - see calc_avgs() and missed_periods.
-	 */
-	if (now >= group->avg_next_update)
-		group->avg_next_update = update_averages(group, now);
-
-	if (changed_states & PSI_STATE_RESCHEDULE) {
-		schedule_delayed_work(dwork, nsecs_to_jiffies(
-				group->avg_next_update - now) + 1);
-	}
-
-	mutex_unlock(&group->avgs_lock);
-}
-
 /* Trigger tracking window manipulations */
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
@@ -516,18 +430,6 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static void init_triggers(struct psi_group *group, u64 now)
-{
-	struct psi_trigger *t;
-
-	list_for_each_entry(t, &group->triggers, node)
-		window_reset(&t->win, now,
-				group->total[PSI_POLL][t->state], 0);
-	memcpy(group->polling_total, group->total[PSI_POLL],
-		   sizeof(group->polling_total));
-	group->polling_next_update = now + group->poll_min_period;
-}
-
 static u64 update_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
@@ -590,6 +492,104 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	return now + group->poll_min_period;
 }
 
+static u64 update_averages(struct psi_group *group, u64 now)
+{
+	unsigned long missed_periods = 0;
+	u64 expires, period;
+	u64 avg_next_update;
+	int s;
+
+	/* avgX= */
+	expires = group->avg_next_update;
+	if (now - expires >= psi_period)
+		missed_periods = div_u64(now - expires, psi_period);
+
+	/*
+	 * The periodic clock tick can get delayed for various
+	 * reasons, especially on loaded systems. To avoid clock
+	 * drift, we schedule the clock in fixed psi_period intervals.
+	 * But the deltas we sample out of the per-cpu buckets above
+	 * are based on the actual time elapsing between clock ticks.
+	 */
+	avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	period = now - (group->avg_last_update + (missed_periods * psi_period));
+	group->avg_last_update = now;
+
+	for (s = 0; s < NR_PSI_STATES - 1; s++) {
+		u32 sample;
+
+		sample = group->total[PSI_AVGS][s] - group->avg_total[s];
+		/*
+		 * Due to the lockless sampling of the time buckets,
+		 * recorded time deltas can slip into the next period,
+		 * which under full pressure can result in samples in
+		 * excess of the period length.
+		 *
+		 * We don't want to report non-sensical pressures in
+		 * excess of 100%, nor do we want to drop such events
+		 * on the floor. Instead we punt any overage into the
+		 * future until pressure subsides. By doing this we
+		 * don't underreport the occurring pressure curve, we
+		 * just report it delayed by one period length.
+		 *
+		 * The error isn't cumulative. As soon as another
+		 * delta slips from a period P to P+1, by definition
+		 * it frees up its time T in P.
+		 */
+		if (sample > period)
+			sample = period;
+		group->avg_total[s] += sample;
+		calc_avgs(group->avg[s], missed_periods, sample, period);
+	}
+
+	return avg_next_update;
+}
+
+static void psi_avgs_work(struct work_struct *work)
+{
+	struct delayed_work *dwork;
+	struct psi_group *group;
+	u32 changed_states;
+	u64 now;
+
+	dwork = to_delayed_work(work);
+	group = container_of(dwork, struct psi_group, avgs_work);
+
+	mutex_lock(&group->avgs_lock);
+
+	now = sched_clock();
+
+	collect_percpu_times(group, PSI_AVGS, &changed_states);
+	/*
+	 * If there is task activity, periodically fold the per-cpu
+	 * times and feed samples into the running averages. If things
+	 * are idle and there is no data to process, stop the clock.
+	 * Once restarted, we'll catch up the running averages in one
+	 * go - see calc_avgs() and missed_periods.
+	 */
+	if (now >= group->avg_next_update)
+		group->avg_next_update = update_averages(group, now);
+
+	if (changed_states & PSI_STATE_RESCHEDULE) {
+		schedule_delayed_work(dwork, nsecs_to_jiffies(
+				group->avg_next_update - now) + 1);
+	}
+
+	mutex_unlock(&group->avgs_lock);
+}
+
+static void init_triggers(struct psi_group *group, u64 now)
+{
+	struct psi_trigger *t;
+
+	list_for_each_entry(t, &group->triggers, node)
+		window_reset(&t->win, now,
+				group->total[PSI_POLL][t->state], 0);
+	memcpy(group->polling_total, group->total[PSI_POLL],
+		   sizeof(group->polling_total));
+	group->polling_next_update = now + group->poll_min_period;
+}
+
 /* Schedule polling if it's not already scheduled or forced. */
 static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
 				   bool force)
