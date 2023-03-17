Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1AB6BEDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCQQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCQQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:08:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1F71166D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:08:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso5449792wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679069294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sWaO40mA8Cs2KLOS1krLxMqfPOnMw8rfqbGqqA13Uo=;
        b=VxEKnQXJGycJHNyUZih3Xhc0oCmuRV1nrt7Hi48V83PFMerUNoACBY4uo6rUxm/LSa
         LvJ8MhCqasrxljCyEe1WfCNChVbVZkfF0NeF/W2btn68txEfYT7zvGssvZgIWTqi9jyX
         HG7EdhPuJWBhdGr9PoZTVfq/4kLvyZG5Tp2ISs7M50BXiUtdmqwEXyEfKl8449qd6rOM
         /GDwV/nIrewOXeFCvWrY2SpR+tOIv7Splruni4lDMMVD8wRq9hrha7/qsQ2A3CZI7mcd
         C4bznwDBmsnXnTZACYr/ls1JxAJC3DMnOm0PY7/ggld9e4A+efIXv33N/YJWmSvby/39
         mgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sWaO40mA8Cs2KLOS1krLxMqfPOnMw8rfqbGqqA13Uo=;
        b=YUwzBXEX4oNtG+oDLAlUa9PS/TTE1kH7T4lKWwtwFmlHdvJ0H0YiczL1xN7b/nrBg8
         s42TcOjHahxoi80eWHgvG4dckhioEWq/j7l+ZHiJcDO1g+aBfspNcA6FvmeBv/8klSdM
         fOl1hHeO64Zg0I/Wc+yBrZ+b6wra2WUtsTrrTDE/hK3usP/qFGNK/uwbsXg13kuO3iVy
         hVmjm0mPrcJs8ye0ZtDs38YSKIziBFVyAJtJaR1xUScuesZ7zvJWBFc4SMX0lgxbua+w
         6iswdCDiNzMrWdtwhzzvyhJF23amRefMLRuR6Ezf87i+pgQa7yD44Az9yEWtQyl+VslR
         5JiA==
X-Gm-Message-State: AO0yUKXrY5jDqEkJuThOYdq46COhsk/hG6e8Fp13T4DhQJ2/nqArnxcf
        tmHQnWJMIQF+4V0fd841talm2Q==
X-Google-Smtp-Source: AK7set/V6I/mGUsTmjhQ+7F1mzwcUfs55PS/srOLyfZ/lwGaoQ7sUk8PVmErhP3iI2s+9yIMKWUPrw==
X-Received: by 2002:a05:600c:46d3:b0:3ed:2b27:5bcc with SMTP id q19-20020a05600c46d300b003ed2b275bccmr13284034wmo.38.1679069294482;
        Fri, 17 Mar 2023 09:08:14 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:2a8a:5c40:7eee:6bb5])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c2c4d00b003ed2a3eab71sm2370417wmg.31.2023.03.17.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:08:13 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Date:   Fri, 17 Mar 2023 17:08:10 +0100
Message-Id: <20230317160810.107988-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
fixes an overflowing bug, but ignore a case that se->exec_start is reset
after a migration.

For fixing this case, we delay the reset of se->exec_start after
placing the entity which se->exec_start to detect long sleeping task.

In order to take into account a possible divergence between the clock_task
of 2 rqs, we increase the threshold to around 104 days.


Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

My last proposal was not yet correct as the exec_start was not always
reset after migrating a task. I finally found this solution which keeps
the long sleep detection to one place as well as the reset of se->exec_start.

 kernel/sched/fair.c | 57 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f499e9a74b5..421173fde351 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4648,11 +4648,33 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }
 
+static inline bool entity_is_long_sleeper(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq;
+	u64 sleep_time;
+
+	if (se->exec_start == 0)
+		return false;
+
+	cfs_rq = cfs_rq_of(se);
+
+	sleep_time = rq_clock_task(rq_of(cfs_rq));
+
+	/* Happen while migrating because of clock task divergence */
+	if (sleep_time <= se->exec_start)
+		return false;
+
+	sleep_time -= se->exec_start;
+	if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
+		return true;
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
@@ -4684,13 +4706,24 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
 	/*
 	 * Pull vruntime of the entity being placed to the base level of
-	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
-	 * slept for a long time, don't even try to compare its vruntime with
-	 * the base as it may be too far off and the comparison may get
-	 * inversed due to s64 overflow.
-	 */
-	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
-	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+	 * cfs_rq, to prevent boosting it if placed backwards.
+	 * However, min_vruntime can advance much faster than real time, with
+	 * the extreme being when an entity with the minimal weight always runs
+	 * on the cfs_rq. If the waking entity slept for a long time, its
+	 * vruntime difference from min_vruntime may overflow s64 and their
+	 * comparison may get inversed, so ignore the entity's original
+	 * vruntime in that case.
+	 * The maximal vruntime speedup is given by the ratio of normal to
+	 * minimal weight: scale_load_down(NICE_0_LOAD) / MIN_SHARES.
+	 * When placing a migrated waking entity, its exec_start has been set
+	 * from a different rq. In order to take into account a possible
+	 * divergence between new and prev rq's clocks task because of irq and
+	 * stolen time, we take an additional margin.
+	 * So, cutting off on the sleep time of
+	 *     2^63 / scale_load_down(NICE_0_LOAD) ~ 104 days
+	 * should be safe.
+	 */
+	if (entity_is_long_sleeper(se))
 		se->vruntime = vruntime;
 	else
 		se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -4770,6 +4803,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (flags & ENQUEUE_WAKEUP)
 		place_entity(cfs_rq, se, 0);
+	/* Entity has migrated, no longer consider this task hot */
+	if (flags & ENQUEUE_MIGRATED)
+		se->exec_start = 0;
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
@@ -7665,9 +7701,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	/* Tell new CPU we are migrated */
 	se->avg.last_update_time = 0;
 
-	/* We have migrated, no longer consider this task hot */
-	se->exec_start = 0;
-
 	update_scan_period(p, new_cpu);
 }
 
@@ -8701,7 +8734,7 @@ static void attach_task(struct rq *rq, struct task_struct *p)
 	lockdep_assert_rq_held(rq);
 
 	WARN_ON_ONCE(task_rq(p) != rq);
-	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
 	check_preempt_curr(rq, p, 0);
 }
 
-- 
2.34.1

