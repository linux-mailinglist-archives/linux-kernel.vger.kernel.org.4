Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F227021F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjEOC5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbjEOC5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:57:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFE1BDC
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f39600f9b8so36596321cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684119446; x=1686711446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYx9ZmJ7bNV74WidQqwK64WAaE80NU2WT/I++6rAvxs=;
        b=n1vpYK+cgXgjA68bQ/KU4JGuzeXQLZwGw3KHh2bJL+E2dpDxUFXH1YIfVwZgH9Gt1w
         r4cLMwKyYEc4aMKTepZNSIuz+E32w5uZXpqf5182aPaav5tmOIOT9wWfbtSudeitcSjZ
         CaeeFpyk9J3cgMsVtUFr8ijEW5qg0BIU/Xd+CQaSSwpl3tWgJuJ9NSH18o67DwT+DSxx
         UtBYqzXhMP4D9kWf+4KWPw2Th28c+jwj4l8bbgDfrahZ8l8QyPfqalbMFoP9w1LsOkyo
         OtyiU7gpIbhU2KoYe86ekCpQmZWl/Z5ZJKB2cXn2KZ0EKkL4rgZF1zdS1wgmpuLHcs51
         qQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684119446; x=1686711446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYx9ZmJ7bNV74WidQqwK64WAaE80NU2WT/I++6rAvxs=;
        b=M2QIGFBiZFTfi0ZJxjDBR0v/5Fn/9HHqcfsMhC3aUyUgeiTaJACSB8gfTxIBohLjGV
         lmi96fUso81ZLEFd9IXt8ghhC/AP6KwmixLXe2JLiTbpc7+SQ7EJ8PVZuibwP7BPira+
         dZj7Q2MghOtlGJBaZCrIHbQcvIdmCO1lhDYIc772lYp2XfZb9bbTpStnN4TOEw+NoyVo
         0stRTSlOJmdE5A/eVdVrFazrQI+CeONzMQl1QtEUguFV+mYjFsTEOeIeLPxmdZoDPFWo
         cWlC2jgKqFaXIdZ2qMKJlaXEEY46xDlrJhFCrx6xuOqINkmxx7Kf338p3QuyyZhCj058
         qpOQ==
X-Gm-Message-State: AC+VfDw/gfgQDIwpWh6PQEaZWaSHyVQh6ra5F8DfNjXWMwGCnL67Nv1O
        FF0VS7kye13EWOff46WROZi40Q==
X-Google-Smtp-Source: ACHHUZ72LF1HMFUzTDTTT4n2nNuI8kWCMk/iV96QsJ62QM+hVKoHCgH3GtzZcHjRQLFd0Itp6dMyyQ==
X-Received: by 2002:a05:622a:1a19:b0:3b9:b6e3:c78e with SMTP id f25-20020a05622a1a1900b003b9b6e3c78emr53318179qtb.8.1684119445954;
        Sun, 14 May 2023 19:57:25 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a134300b007339c5114a9sm2308994qkl.103.2023.05.14.19.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 19:57:25 -0700 (PDT)
From:   Vineeth Pillai <vineeth@bitbyteword.org>
To:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 3/5] sched/deadline: Remove unused variable extra_bw
Date:   Sun, 14 May 2023 22:57:14 -0400
Message-Id: <20230515025716.316888-4-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515025716.316888-1-vineeth@bitbyteword.org>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we do not use extra_bw for GRUB, remove its usage.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/sched/deadline.c | 53 ++++++++++++-----------------------------
 kernel/sched/sched.h    |  1 -
 2 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 85902c4c484b..67c1138df43a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -163,20 +163,6 @@ static inline bool dl_bw_visited(int cpu, u64 gen)
 	return false;
 }
 
-static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
-{
-	struct root_domain *rd = container_of(dl_b, struct root_domain, dl_bw);
-	int i;
-
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
-			 "sched RCU must be held");
-	for_each_cpu_and(i, rd->span, cpu_active_mask) {
-		struct rq *rq = cpu_rq(i);
-
-		rq->dl.extra_bw += bw;
-	}
-}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -198,27 +184,18 @@ static inline bool dl_bw_visited(int cpu, u64 gen)
 	return false;
 }
 
-static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
-{
-	struct dl_rq *dl = container_of(dl_b, struct dl_rq, dl_bw);
-
-	dl->extra_bw += bw;
-}
 #endif
 
 static inline
-void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
+void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw)
 {
 	dl_b->total_bw -= tsk_bw;
-	__dl_update(dl_b, (s32)tsk_bw / cpus);
 }
 
 static inline
-void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
+void __dl_add(struct dl_bw *dl_b, u64 tsk_bw)
 {
 	dl_b->total_bw += tsk_bw;
-	__dl_update(dl_b, -((s32)tsk_bw / cpus));
 }
 
 static inline bool
@@ -430,7 +407,7 @@ static void task_non_contending(struct task_struct *p)
 			if (READ_ONCE(p->__state) == TASK_DEAD)
 				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+			__dl_sub(dl_b, p->dl.dl_bw);
 			raw_spin_unlock(&dl_b->lock);
 			__dl_clear_params(p);
 		}
@@ -721,12 +698,12 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	 */
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
-	__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	__dl_sub(dl_b, p->dl.dl_bw);
 	raw_spin_unlock(&dl_b->lock);
 
 	dl_b = &later_rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
-	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
+	__dl_add(dl_b, p->dl.dl_bw);
 	raw_spin_unlock(&dl_b->lock);
 
 	set_task_cpu(p, later_rq->cpu);
@@ -1425,7 +1402,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		}
 
 		raw_spin_lock(&dl_b->lock);
-		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+		__dl_sub(dl_b, p->dl.dl_bw);
 		raw_spin_unlock(&dl_b->lock);
 		__dl_clear_params(p);
 
@@ -2506,7 +2483,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		 * until we complete the update.
 		 */
 		raw_spin_lock(&src_dl_b->lock);
-		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+		__dl_sub(src_dl_b, p->dl.dl_bw);
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
@@ -2560,7 +2537,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
 
-	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	__dl_add(dl_b, p->dl.dl_bw);
 
 	raw_spin_unlock(&dl_b->lock);
 
@@ -2779,9 +2756,9 @@ int sched_dl_global_validate(void)
 static void init_dl_rq_bw(struct dl_rq *dl_rq)
 {
 	if (global_rt_runtime() == RUNTIME_INF)
-		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
+		dl_rq->max_bw = 1 << BW_SHIFT;
 	else
-		dl_rq->max_bw = dl_rq->extra_bw = to_ratio(global_rt_period(),
+		dl_rq->max_bw = to_ratio(global_rt_period(),
 						    global_rt_runtime());
 }
 
@@ -2852,8 +2829,8 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	if (dl_policy(policy) && !task_has_dl_policy(p) &&
 	    !__dl_overflow(dl_b, cap, 0, new_bw)) {
 		if (hrtimer_active(&p->dl.inactive_timer))
-			__dl_sub(dl_b, p->dl.dl_bw, cpus);
-		__dl_add(dl_b, new_bw, cpus);
+			__dl_sub(dl_b, p->dl.dl_bw);
+		__dl_add(dl_b, new_bw);
 		err = 0;
 	} else if (dl_policy(policy) && task_has_dl_policy(p) &&
 		   !__dl_overflow(dl_b, cap, p->dl.dl_bw, new_bw)) {
@@ -2864,8 +2841,8 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 		 * But this would require to set the task's "inactive
 		 * timer" when the task is not inactive.
 		 */
-		__dl_sub(dl_b, p->dl.dl_bw, cpus);
-		__dl_add(dl_b, new_bw, cpus);
+		__dl_sub(dl_b, p->dl.dl_bw);
+		__dl_add(dl_b, new_bw);
 		dl_change_utilization(p, new_bw);
 		err = 0;
 	} else if (!dl_policy(policy) && task_has_dl_policy(p)) {
@@ -3044,7 +3021,7 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
 		 * We will free resources in the source root_domain
 		 * later on (see set_cpus_allowed_dl()).
 		 */
-		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+		__dl_add(dl_b, p->dl.dl_bw);
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1bc7ae9ad349..33db99756624 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -751,7 +751,6 @@ struct dl_rq {
 	 * runqueue (inactive utilization = this_bw - running_bw).
 	 */
 	u64			this_bw;
-	u64			extra_bw;
 
 	/*
 	 * Maximum available bandwidth for deadline tasks of this rq. This is
-- 
2.40.1

