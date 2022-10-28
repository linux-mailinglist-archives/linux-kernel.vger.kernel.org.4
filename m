Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95BD611B17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJ1Tpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1Tpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:45:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C30A228CEE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:45:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so5264495ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x83vM/1j1KAVL8seimXaR8pRW4aBzKsyPqEoBW3eXjY=;
        b=M2FwwLC7ikmViE7RZ4zAzoGZTjYWarCyK6kiut3nBrSNZukMOpH+XuN6dct9Zoadpy
         pgDi0YiB4k4ol3NgvHltCinVl2FxZlAaTyd5AoTv/BdnKeL62J5qQdEFcoIWTuBDhaMs
         LPIF7Uf157cAa0zUPG7WPUuVk60fYesbCmjawSnkRAQuA3DShJS8jqOL+O/OP8wSobJi
         G1l9buIeMOrUTx8pO4nk1/Js12N8Mru9VcLF7iqW2zXBCiLpeh11ZkyVvhYzjJQY1i89
         excROGdrPhfT15daFapMqZzU06MBUim/aG7kTEdag2DVMJC4AaN1ROniD9IGvkaOYRKs
         A2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x83vM/1j1KAVL8seimXaR8pRW4aBzKsyPqEoBW3eXjY=;
        b=qgeRoe6VibBxnsACoyG1LghevGqq4Fr5Gfwg8FdwBr1mha5zVoOiz1vEvyK0clVgxT
         AOeqrLc4qv6Pl/OXiEpyNdN/2+ZSus4NWj4xFhKteGjS5Hl2cSpYwFq6ruUvgK4ytun4
         g01qG3+Ef4RfKj081KcZ4+z8H4Q2mLTb4FAl0mvvAsI/R7y1q00fMflYdd95vy+Gkba3
         G5O3S9A9W+/4/yMSVHMXQMYVZW/g4wsOnuv4GCRqDzWm8RUsU/C98RhQemXiMnxTfe2Q
         Hu27oB/rc7VwpJ5i90nZEGeDG7+MYq2+n0X0VhQ6RwFFbKVW4E9HmjHcKaYMyERcx5Vy
         ng5g==
X-Gm-Message-State: ACrzQf2Qr8eu+QwloZsNH86aT6txUu4SjVv26Y6BCYV261gpT3+vbr8q
        vRwST2FIxRF291As9inNwyLZxuAd5BQ=
X-Google-Smtp-Source: AMsMyM7K3LvwsmHWlGntmNt0o09U7TOAhtJEQKwcWtwMPTYLpvMLDa2c98xWxYFjhz1gc1s9ZgSlGZmOSyU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c5b4:420e:278f:efc5])
 (user=surenb job=sendgmr) by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id
 n9-20020a819c49000000b0034a00de97b8mr1071313ywa.384.1666986345538; Fri, 28
 Oct 2022 12:45:45 -0700 (PDT)
Date:   Fri, 28 Oct 2022 12:45:41 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221028194541.813985-1-surenb@google.com>
Subject: [PATCH v6 1/1] psi: stop relying on timer_pending for poll_work rescheduling
From:   Suren Baghdasaryan <surenb@google.com>
To:     peterz@infradead.org
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, show-hong.chen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Psi polling mechanism is trying to minimize the number of wakeups to
run psi_poll_work and is currently relying on timer_pending() to detect
when this work is already scheduled. This provides a window of opportunity
for psi_group_change to schedule an immediate psi_poll_work after
poll_timer_fn got called but before psi_poll_work could reschedule itself.
Below is the depiction of this entire window:

poll_timer_fn
  wake_up_interruptible(&group->poll_wait);

psi_poll_worker
  wait_event_interruptible(group->poll_wait, ...)
  psi_poll_work
    psi_schedule_poll_work
      if (timer_pending(&group->poll_timer)) return;
      ...
      mod_timer(&group->poll_timer, jiffies + delay);

Prior to 461daba06bdc we used to rely on poll_scheduled atomic which was
reset and set back inside psi_poll_work and therefore this race window
was much smaller.
The larger window causes increased number of wakeups and our partners
report visible power regression of ~10mA after applying 461daba06bdc.
Bring back the poll_scheduled atomic and make this race window even
narrower by resetting poll_scheduled only when we reach polling expiration
time. This does not completely eliminate the possibility of extra wakeups
caused by a race with psi_group_change however it will limit it to the
worst case scenario of one extra wakeup per every tracking window (0.5s
in the worst case).
This patch also ensures correct ordering between clearing poll_scheduled
flag and obtaining changed_states using memory barrier. Correct ordering
between updating changed_states and setting poll_scheduled is ensured by
atomic_xchg operation.
By tracing the number of immediate rescheduling attempts performed by
psi_group_change and the number of these attempts being blocked due to
psi monitor being already active, we can assess the effects of this change:

Before the patch:
                                           Run#1    Run#2      Run#3
Immediate reschedules attempted:           684365   1385156    1261240
Immediate reschedules blocked:             682846   1381654    1258682
Immediate reschedules (delta):             1519     3502       2558
Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%

After the patch:
                                           Run#1    Run#2      Run#3
Immediate reschedules attempted:           882244   770298    426218
Immediate reschedules blocked:             881996   769796    426074
Immediate reschedules (delta):             248      502       144
Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%

The number of non-blocked immediate reschedules dropped from 0.22-0.25%
to 0.03-0.07%. The drop is attributed to the decrease in the race window
size and the fact that we allow this race only when psi monitors reach
polling window expiration time.

Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
Reported-by: Kathleen Chang <yt.chang@mediatek.com>
Reported-by: Wenju Xu <wenju.xu@mediatek.com>
Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: SH Chen <show-hong.chen@mediatek.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
Changes since v5 posted at
https://lore.kernel.org/all/20221026233839.1934419-1-surenb@google.com/
- Fixed spelling in the comments, per Chengming Zhou

 include/linux/psi_types.h |  1 +
 kernel/sched/psi.c        | 62 ++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 6e4372735068..14a1ebb74e11 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -177,6 +177,7 @@ struct psi_group {
 	struct timer_list poll_timer;
 	wait_queue_head_t poll_wait;
 	atomic_t poll_wakeup;
+	atomic_t poll_scheduled;
 
 	/* Protects data used by the monitor */
 	struct mutex trigger_lock;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index dbaeac915895..94c4c5143f23 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -189,6 +189,7 @@ static void group_init(struct psi_group *group)
 	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
+	atomic_set(&group->poll_scheduled, 0);
 	mutex_init(&group->trigger_lock);
 	INIT_LIST_HEAD(&group->triggers);
 	group->poll_min_period = U32_MAX;
@@ -580,18 +581,17 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	return now + group->poll_min_period;
 }
 
-/* Schedule polling if it's not already scheduled. */
-static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
+/* Schedule polling if it's not already scheduled or forced. */
+static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
+				   bool force)
 {
 	struct task_struct *task;
 
 	/*
-	 * Do not reschedule if already scheduled.
-	 * Possible race with a timer scheduled after this check but before
-	 * mod_timer below can be tolerated because group->polling_next_update
-	 * will keep updates on schedule.
+	 * atomic_xchg should be called even when !force to provide a
+	 * full memory barrier (see the comment inside psi_poll_work).
 	 */
-	if (timer_pending(&group->poll_timer))
+	if (atomic_xchg(&group->poll_scheduled, 1) && !force)
 		return;
 
 	rcu_read_lock();
@@ -603,12 +603,15 @@ static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
 	 */
 	if (likely(task))
 		mod_timer(&group->poll_timer, jiffies + delay);
+	else
+		atomic_set(&group->poll_scheduled, 0);
 
 	rcu_read_unlock();
 }
 
 static void psi_poll_work(struct psi_group *group)
 {
+	bool force_reschedule = false;
 	u32 changed_states;
 	u64 now;
 
@@ -616,6 +619,43 @@ static void psi_poll_work(struct psi_group *group)
 
 	now = sched_clock();
 
+	if (now > group->polling_until) {
+		/*
+		 * We are either about to start or might stop polling if no
+		 * state change was recorded. Resetting poll_scheduled leaves
+		 * a small window for psi_group_change to sneak in and schedule
+		 * an immediate poll_work before we get to rescheduling. One
+		 * potential extra wakeup at the end of the polling window
+		 * should be negligible and polling_next_update still keeps
+		 * updates correctly on schedule.
+		 */
+		atomic_set(&group->poll_scheduled, 0);
+		/*
+		 * A task change can race with the poll worker that is supposed to
+		 * report on it. To avoid missing events, ensure ordering between
+		 * poll_scheduled and the task state accesses, such that if the poll
+		 * worker misses the state update, the task change is guaranteed to
+		 * reschedule the poll worker:
+		 *
+		 * poll worker:
+		 *   atomic_set(poll_scheduled, 0)
+		 *   smp_mb()
+		 *   LOAD states
+		 *
+		 * task change:
+		 *   STORE states
+		 *   if atomic_xchg(poll_scheduled, 1) == 0:
+		 *     schedule poll worker
+		 *
+		 * The atomic_xchg() implies a full barrier.
+		 */
+		smp_mb();
+	} else {
+		/* Polling window is not over, keep rescheduling */
+		force_reschedule = true;
+	}
+
+
 	collect_percpu_times(group, PSI_POLL, &changed_states);
 
 	if (changed_states & group->poll_states) {
@@ -641,7 +681,8 @@ static void psi_poll_work(struct psi_group *group)
 		group->polling_next_update = update_triggers(group, now);
 
 	psi_schedule_poll_work(group,
-		nsecs_to_jiffies(group->polling_next_update - now) + 1);
+		nsecs_to_jiffies(group->polling_next_update - now) + 1,
+		force_reschedule);
 
 out:
 	mutex_unlock(&group->trigger_lock);
@@ -802,7 +843,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	write_seqcount_end(&groupc->seq);
 
 	if (state_mask & group->poll_states)
-		psi_schedule_poll_work(group, 1);
+		psi_schedule_poll_work(group, 1, false);
 
 	if (wake_clock && !delayed_work_pending(&group->avgs_work))
 		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
@@ -956,7 +997,7 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 		write_seqcount_end(&groupc->seq);
 
 		if (group->poll_states & (1 << PSI_IRQ_FULL))
-			psi_schedule_poll_work(group, 1);
+			psi_schedule_poll_work(group, 1, false);
 	} while ((group = group->parent));
 }
 #endif
@@ -1342,6 +1383,7 @@ void psi_trigger_destroy(struct psi_trigger *t)
 		 * can no longer be found through group->poll_task.
 		 */
 		kthread_stop(task_to_destroy);
+		atomic_set(&group->poll_scheduled, 0);
 	}
 	kfree(t);
 }
-- 
2.38.1.273.g43a17bfeac-goog

