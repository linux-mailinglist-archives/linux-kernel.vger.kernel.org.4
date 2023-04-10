Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD56DC435
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDJINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDJIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:12:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA3423E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:12:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id kh6so2488483plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681114352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXKYnMeADE56pOVc+eJfLgMquSBzuNugVw1G2HDPE+s=;
        b=I/1CNnYMMN9R2hqhC4IEx8Yqt+kD07z082WbYCLvuGNbCZLF/1Bd/1K2XNU0bqhz23
         wHNaELyjq/LXrH87mUNqFmXGcefLjL31/2ic8Zyvndw7rupuX+AIZgO/ecFaeJw3KinG
         JA7od55nvgjh61ZGvolc2oCNPg16XpfoZuUhEDWQwNSUYcKShqGhhkk/9zyg2bh0Zsa3
         mRQThwXeP986g/heyop/7tq+zrek6OJjsxl5hR4gLLzywxc2Qc3I8/0IAaVWhUmesPb+
         Y5gavvny7WwD5B31pbeL95AGpM5lxcoW2jVWkU/YNEuThXnyqZHA0b9bwwnAUfbp3ICy
         tfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681114352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXKYnMeADE56pOVc+eJfLgMquSBzuNugVw1G2HDPE+s=;
        b=IgaUSYCFkI5H+wnV2hrF3m5U2eeIkljI0SdfH8ZX957l40OCYiqo1WE4tRdzAEX4dN
         Z6WVH8kg03SmCMaISr6w9Dy5H7FaLE45N2tF/sfr6RBC5SdgrNI9K7Kn9QjXDxdNtamy
         4G7WxGRCAwlvPdNFDZagIe7aNMTZvTJ7lRTaKxudNPtVzzHjFugKNk0pqXaYUSoQbjsD
         qTaJQwjx/7k9/USjQ4d3WcnHDGeggMImUjfwroNXRez+be1MalvY9wC+tJACbXrCc/ZL
         u+31O4gmR6+4sL7HWMRu3B8vhd8+iYiQBtRxzunmxLORUwOrRkwQCIQxztIzav6+38El
         ba4g==
X-Gm-Message-State: AAQBX9fc/yZWdZSn1NaaYr/0tn1bWg2vOnN9p1y139ywQHYPfZKwdH1i
        6VOpeawrr6FWohnPvWNH1FmCmQ==
X-Google-Smtp-Source: AKy350Y7Fw06Ti4rs1SIt8+FMy0kxlBfXMz3kQAm8T9OBnkSZzrVwAdBZAJxLh+KZkL6Kup5oJ/e+Q==
X-Received: by 2002:a05:6a20:3546:b0:d6:c9e2:17af with SMTP id f6-20020a056a20354600b000d6c9e217afmr5487405pze.45.1681114352087;
        Mon, 10 Apr 2023 01:12:32 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id m17-20020aa79011000000b0062d8e79ea22sm7234100pfo.40.2023.04.10.01.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 01:12:31 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 2/2] sched/core: Avoid double calling update_rq_clock()
Date:   Mon, 10 Apr 2023 16:12:06 +0800
Message-Id: <20230410081206.23441-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230410081206.23441-1-jiahao.os@bytedance.com>
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

This also works for unthrottle_cfs_rq(), so we also removed
update_rq_clock() from the unthrottle_cfs_rq() function to avoid
warnings caused by calling it multiple times, such as
__cfsb_csd_unthrottle() and unthrottle_offline_cfs_rqs(). and
in order to avoid missing rq clock update, we correspondingly add
update_rq_clock() calls before unthrottle_cfs_rq() runs.

Note that the rq clock has been updated before the set_rq_offline()
function runs, so we don't need to add update_rq_clock() call in
unthrottle_offline_cfs_rqs().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c | 11 +++++++----
 kernel/sched/fair.c |  9 ++++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..c1abd88ec1ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2376,7 +2376,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
-	update_rq_clock(rq);
 	rq = move_queued_task(rq, rf, p, dest_cpu);
 
 	return rq;
@@ -2434,10 +2433,12 @@ static int migration_cpu_stop(void *data)
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
@@ -10759,8 +10760,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		cfs_rq->runtime_enabled = runtime_enabled;
 		cfs_rq->runtime_remaining = 0;
 
-		if (cfs_rq->throttled)
+		if (cfs_rq->throttled) {
+			update_rq_clock(rq);
 			unthrottle_cfs_rq(cfs_rq);
+		}
 		rq_unlock_irq(rq, &rf);
 	}
 	if (runtime_was_enabled && !runtime_enabled)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6986ea31c984..03ced34e992e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5438,8 +5438,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	cfs_rq->throttled = 0;
 
-	update_rq_clock(rq);
-
 	raw_spin_lock(&cfs_b->lock);
 	cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
 	list_del_rcu(&cfs_rq->throttled_list);
@@ -5518,6 +5516,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 	struct rq_flags rf;
 
 	rq_lock(rq, &rf);
+	update_rq_clock(rq);
 
 	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
@@ -5547,6 +5546,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 	bool first;
 
 	if (rq == this_rq()) {
+		update_rq_clock(rq);
 		unthrottle_cfs_rq(cfs_rq);
 		return;
 	}
@@ -5563,6 +5563,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 #else
 static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
+	update_rq_clock(rq_of(cfs_rq));
 	unthrottle_cfs_rq(cfs_rq);
 }
 #endif
@@ -5640,8 +5641,10 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 	if (local_unthrottle) {
 		rq = cpu_rq(this_cpu);
 		rq_lock_irqsave(rq, &rf);
-		if (cfs_rq_throttled(local_unthrottle))
+		if (cfs_rq_throttled(local_unthrottle)) {
+			update_rq_clock(rq);
 			unthrottle_cfs_rq(local_unthrottle);
+		}
 		rq_unlock_irqrestore(rq, &rf);
 	}
 
-- 
2.37.0

