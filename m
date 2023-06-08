Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86072846A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjFHP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjFHP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7241FCC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A6F64EC9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D80C433EF;
        Thu,  8 Jun 2023 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239935;
        bh=2tNnPtbaFRlQ2fLFW3vNKTom3zxVIALb9HVMI/WWhdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOowqkDDJ/O5Z3W4oTS0J7oZ4mPLZ0jn1TnJD1ebMQORivzxyacnpRd15Eo/zRkxp
         VrTBMYt2qIXrXivofWrbo9sV6PKmhlcb1scMODoNpkNjSsjpCQRr38jzamDAOf7jFF
         BPyTKpNerPo+wP818IYURc3ioZBoHr3c11LKN9RgcFUzpfxsU1OspDCgnwC6Trxg4l
         PW6WlI9Hvd5Ta309PGOpK8Rd8FU4UoZfMEUuHfdxKMT2uS4EFsW1ITywowFLJmeFhD
         9vQkQHWnxsBxgnzeQyap/8DzEir824IHm+EtsD6NYKs4snPFu0f3ZHtHrJMI56nSUj
         SNYgvOOnlAxgQ==
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
Subject: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
Date:   Thu,  8 Jun 2023 17:58:18 +0200
Message-Id: <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

Starting deadline server for lower priority classes right away when
first task is enqueued might break guarantees, as tasks belonging to
intermediate priority classes could be uselessly preempted. E.g., a well
behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
there are still CPU cycles available for NORMAL tasks to run, as they'll
be running inside the fair deadline server for some period of time.

To prevent this issue, implement a starvation monitor mechanism that
starts the deadline server only if a (fair in this case) task hasn't
been scheduled for some interval of time after it has been enqueued.
Use pick/put functions to manage starvation monitor status.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/fair.c  | 57 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  4 ++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f493f05c1f84..75eadd85e2b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6315,6 +6315,53 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+
+static void fair_server_watchdog(struct timer_list *list)
+{
+	struct rq *rq = container_of(list, struct rq, fair_server_wd);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	rq->fair_server_wd_running = 0;
+
+	if (!rq->cfs.h_nr_running)
+		goto out;
+
+	update_rq_clock(rq);
+	dl_server_start(&rq->fair_server);
+	rq->fair_server_active = 1;
+	resched_curr(rq);
+
+out:
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void fair_server_watchdog_start(struct rq *rq)
+{
+	if (rq->fair_server_wd_running || rq->fair_server_active)
+		return;
+
+	timer_setup(&rq->fair_server_wd, fair_server_watchdog, 0);
+	rq->fair_server_wd.expires = jiffies + FAIR_SERVER_WATCHDOG_INTERVAL;
+	add_timer_on(&rq->fair_server_wd, cpu_of(rq));
+	rq->fair_server_active = 0;
+	rq->fair_server_wd_running = 1;
+}
+
+static inline void fair_server_watchdog_stop(struct rq *rq, bool stop_server)
+{
+	if (!rq->fair_server_wd_running && !stop_server)
+		return;
+
+	del_timer(&rq->fair_server_wd);
+	rq->fair_server_wd_running = 0;
+
+	if (stop_server && rq->fair_server_active) {
+		dl_server_stop(&rq->fair_server);
+		rq->fair_server_active = 0;
+	}
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6337,7 +6384,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	util_est_enqueue(&rq->cfs, p);
 
 	if (!rq->cfs.h_nr_running)
-		dl_server_start(&rq->fair_server);
+		fair_server_watchdog_start(rq);
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -6484,7 +6531,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	if (!rq->cfs.h_nr_running)
-		dl_server_stop(&rq->fair_server);
+		fair_server_watchdog_stop(rq, true);
 
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
@@ -8193,6 +8240,7 @@ done: __maybe_unused;
 		hrtick_start_fair(rq, p);
 
 	update_misfit_status(p, rq);
+	fair_server_watchdog_stop(rq, false);
 
 	return p;
 
@@ -8248,6 +8296,8 @@ void fair_server_init(struct rq *rq)
 	dl_se->dl_period = 20 * TICK_NSEC;
 
 	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+
+	rq->fair_server_wd_running = 0;
 }
 
 /*
@@ -8262,6 +8312,9 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
 	}
+
+	if (rq->cfs.h_nr_running)
+		fair_server_watchdog_start(rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d4a7c0823c53..cab5d2b1e71f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -353,6 +353,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+#define FAIR_SERVER_WATCHDOG_INTERVAL (HZ >> 1)
 extern void fair_server_init(struct rq *);
 
 #ifdef CONFIG_CGROUP_SCHED
@@ -1018,6 +1019,9 @@ struct rq {
 	struct dl_rq		dl;
 
 	struct sched_dl_entity	fair_server;
+	int			fair_server_active;
+	struct timer_list	fair_server_wd;
+	int			fair_server_wd_running;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.40.1

