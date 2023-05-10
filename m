Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84C6FD994
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbjEJIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbjEJIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:36:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC9A8A47
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:35:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439b410679so4420961b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683707714; x=1686299714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9KFKim9W01aJymh56M6VmTxV6CKXPMr8i9NknkamPs=;
        b=CRFPSzqnXZyTKeH0oGgPtDQU3S+snO8OdyPSf42zcLC3S6PMoI+NxYjj0usTBKikNq
         HbMBQldWEslhmFG+JQ4sRgnPmHhw7UtYThmRq9KIg3/ATPyBbZmFK0ubyZm4ug/Edvu/
         /IqU8DF80AtLE8P3cLspnu+Y4qJI8kgWeH4H6ibUEdpENEl2BpPDCSOvleSXmRUdWSCI
         up5Wbt8qlAa8maY2e18bocYXWRQLgyiQixqBnpmxR5HU8N6Ihxmizi7uBVNxPzbEIMrG
         28lwGPR45dRVrN5pl9Eso/7Z9Lb8rj/0JuXuhi6h6T0AcYuOn1mlmw7Mo+RW/jphFb3u
         i88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707714; x=1686299714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9KFKim9W01aJymh56M6VmTxV6CKXPMr8i9NknkamPs=;
        b=VYxqaWawXK9aAln8Gg611yetM/xT30n0fCI+Ols4U8hZnrb6TKQD8bZa4lMyI566AW
         SycUGYX2xIqJFxf4ZX8dZhyQBFwtwXox7Zmpo52DcYur7lR6H7tMDF2V5EpC9a2IDHWh
         vg1V8ORWhiQLS1d1ZjsFHyCNbj2HfMmUxDZoxOObv8kjGRdpWORn6zaHzcoaxDw1/i0G
         SKSPHjFqIyk7DdP5DyIltphBjyWL9X4rGNdEkjc81yMV4+RC+jtMzIJ7q8WOiY30KcXy
         xH5n/K7rBDf991jnpRK+E2ocVV/+5NXBJgiz0zpyOX/BoL7BeBYLqcm57ooPnDN9THVN
         1VvQ==
X-Gm-Message-State: AC+VfDz+lka3nlkQ5Ey30sSPUfptszu8yz9OC0fuc1RIzj11pth2phZk
        iyn4H2MNTxeaVwKt3TqnW77ecw==
X-Google-Smtp-Source: ACHHUZ5qDHzXMnufTfjs4kU7sjOy1RfmcCIp1QUSDU3GgU42SzeMg2VMDMy5num3nSRYputH9ZDmmA==
X-Received: by 2002:a05:6a21:380e:b0:f0:69db:ebea with SMTP id yi14-20020a056a21380e00b000f069dbebeamr14435119pzb.30.1683707714663;
        Wed, 10 May 2023 01:35:14 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a668200b002504a1a5d1asm7588359pjj.29.2023.05.10.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:35:14 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 2/2] sched/core: Avoid double calling update_rq_clock()
Date:   Wed, 10 May 2023 16:34:50 +0800
Message-Id: <20230510083450.62334-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230510083450.62334-1-jiahao.os@bytedance.com>
References: <20230510083450.62334-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some double rq clock update warnings are triggered.
------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 __balance_push_cpu_stop+0x146/0x180
 ? migration_cpu_stop+0x2a0/0x2a0
 cpu_stopper_thread+0xa3/0x140
 smpboot_thread_fn+0x14f/0x210
 ? sort_range+0x20/0x20
 kthread+0xe6/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 unthrottle_cfs_rq+0x4b/0x300
 __cfsb_csd_unthrottle+0xe0/0x100
 __flush_smp_call_function_queue+0xaf/0x1d0
 flush_smp_call_function_queue+0x49/0x90
 do_idle+0x17c/0x270
 cpu_startup_entry+0x19/0x20
 start_secondary+0xfa/0x120
 secondary_startup_64_no_verify+0xce/0xdb

------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 unthrottle_cfs_rq+0x4b/0x300
 rq_offline_fair+0x89/0x90
 set_rq_offline.part.118+0x28/0x60
 rq_attach_root+0xc4/0xd0
 cpu_attach_domain+0x3dc/0x7f0
 partition_sched_domains_locked+0x2a5/0x3c0
 rebuild_sched_domains_locked+0x477/0x830
 rebuild_sched_domains+0x1b/0x30
 cpuset_hotplug_workfn+0x2ca/0xc90
 ? balance_push+0x56/0xf0
 ? _raw_spin_unlock+0x15/0x30
 ? finish_task_switch+0x98/0x2f0
 ? __switch_to+0x291/0x410
 ? __schedule+0x65e/0x1310
 process_one_work+0x1bc/0x3d0
 worker_thread+0x4c/0x380
 ? preempt_count_add+0x92/0xa0
 ? rescuer_thread+0x310/0x310
 kthread+0xe6/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
the __migrate_task() function to avoid double updating the rq clock.
And in order to avoid missing rq clock update, add update_rq_clock()
call before migration_cpu_stop() calls __migrate_task().

For the unthrottle_cfs_rq() case, we use rq_clock_start_loop_update() to
prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq().

Note that the rq clock has been updated before the set_rq_offline()
function runs, so we don't need to call update_rq_clock() in
unthrottle_offline_cfs_rqs().

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c  |  7 ++++---
 kernel/sched/fair.c  | 16 ++++++++++++++++
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..2bcf6a8e71fc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2398,7 +2398,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
-	update_rq_clock(rq);
 	rq = move_queued_task(rq, rf, p, dest_cpu);
 
 	return rq;
@@ -2456,10 +2455,12 @@ static int migration_cpu_stop(void *data)
 				goto out;
 		}
 
-		if (task_on_rq_queued(p))
+		if (task_on_rq_queued(p)) {
+			update_rq_clock(rq);
 			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
-		else
+		} else {
 			p->wake_cpu = arg->dest_cpu;
+		}
 
 		/*
 		 * XXX __migrate_task() can fail, at which point we might end
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..9ec7bde620ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5575,6 +5575,13 @@ static void __cfsb_csd_unthrottle(void *arg)
 	struct rq_flags rf;
 
 	rq_lock(rq, &rf);
+	/*
+	 * Iterating over the list can trigger several call to
+	 * update_rq_clock() in unthrottle_cfs_rq().
+	 * Do it once and skip the potential next ones.
+	 */
+	update_rq_clock(rq);
+	rq_clock_start_loop_update(rq);
 
 	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
@@ -5595,6 +5602,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rcu_read_unlock();
 
+	rq_clock_stop_loop_update(rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -6114,6 +6122,12 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	struct task_group *tg;
 
 	lockdep_assert_rq_held(rq);
+	/*
+	 * The rq clock has already been updated before the
+	 * set_rq_offline() runs, so we should skip updating
+	 * the rq clock again in unthrottle_cfs_rq().
+	 */
+	rq_clock_start_loop_update(rq);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6137,6 +6151,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 	rcu_read_unlock();
+
+	rq_clock_stop_loop_update(rq);
 }
 
 #else /* CONFIG_CFS_BANDWIDTH */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..9c712f29e5a4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1536,6 +1536,27 @@ static inline void rq_clock_skip_update(struct rq *rq)
 	rq->clock_update_flags |= RQCF_REQ_SKIP;
 }
 
+/*
+ * During cpu offlining and rq wide unthrottling, we can trigger
+ * an update_rq_clock() for several cfs and rt runqueues (Typically
+ * when using list_for_each_entry_*)
+ * rq_clock_start_loop_update() can be called after updating the clock
+ * once and before iterating over the list to prevent multiple update.
+ * After the iterative traversal, we need to call rq_clock_stop_loop_update()
+ * to restore rq->clock_update_flags.
+ */
+static inline void rq_clock_start_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags |= RQCF_ACT_SKIP;
+}
+
+static inline void rq_clock_stop_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+}
+
 /*
  * See rt task throttling, which is the only time a skip
  * request is canceled.
-- 
2.37.0

