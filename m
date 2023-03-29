Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82A6CECFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjC2Pdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjC2Pdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBEF468B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:33:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so64912718edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e39gTwxGluXQJRtHutgVo/eHgQ2HpZYFqbaudGJzbN8=;
        b=KEppAoL3AuWJApMyDpfhQTNLKzjfSI+nlQqU/CDPc8HgdmmLmCdJWnzSUqcxN+FEtt
         QQtxEyoT3QeDuYngnNevJmUCujVaN2mWIMe0ZNtl0zvhOLsR4Hqxyra5BExw6czG/cUR
         6KIqddo1kXOqDDgt9b11fapupIzPUZhMEyyp557JumWDuobhQRJd4wCkSEV/ldtMEiXE
         P6JoE5JQrM756bWKa4RtWPaI7bXVTpus070scWjbbE3KD8c/A4k220y5wMbzJx/L1GlJ
         l4Zv1v2VDiwpAKcxcPxQgq9fHBQxrHbMN+5iL+e5Z9zunCOPZyKlNvPtCnHXo7Tkk/JM
         txCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e39gTwxGluXQJRtHutgVo/eHgQ2HpZYFqbaudGJzbN8=;
        b=QcEAb253jko6RZxHjbg7cxENDSNz4XXp29JRHSYvzvLGIRpU7IOZsuHYr8Hc4oAflW
         Mxy8azldjgTAmiSQ9CbtKEL0QuSm66CRx20pqbgaVy9gtSrVWARxE0tAMxOZ8c+sxDEt
         j0SxU3smtnHuvR0tbgKcvXf2y1WFkdm4Y84ux/gIi7QxAaQjAPaGfNBXWztpw6XDXQPQ
         0tQzsS+fhRxR7lDUrQHi5eP/f70Uw1HXq0SE1bYBO2IyED7OAlu9eq8VVYXozuCleutT
         bj2gyAKxWG3evAr/GWbX9pHZA6EIFN/fhgH2/qcHwS44SE8dxVE0auWWbonV51+MVisC
         T1yQ==
X-Gm-Message-State: AAQBX9ethcqucvsVHyEjX49TBWHQrPZAHVgNxqPIcwrlhN/odbFyAiQp
        9ae6O20HRnHLJy4Rd0XE56Bfi0/HKJ6I49B6
X-Google-Smtp-Source: AKy350aVB+eUqRxIHTg3yiSdLtih0bpgv+U2oEBbw4MTjbqe3TRcQeSrxOevurG1ItH1NbOemx8ydw==
X-Received: by 2002:a17:906:1645:b0:88d:f759:15ae with SMTP id n5-20020a170906164500b0088df75915aemr21367291ejd.42.1680104012386;
        Wed, 29 Mar 2023 08:33:32 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090670ca00b0093b8c0952e4sm10193735ejk.219.2023.03.29.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:33:32 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v4 1/4] sched/psi: rearrange polling code in preparation
Date:   Wed, 29 Mar 2023 17:33:24 +0200
Message-Id: <20230329153327.140215-2-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a few functions up in the file to avoid forward declaration needed
in the patch implementing unprivileged PSI triggers.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 kernel/sched/psi.c | 196 ++++++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 02e011cabe91..fe9269f1d2a4 100644
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
-- 
2.34.1

