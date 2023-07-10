Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5ED74DEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGJUE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjGJUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:08 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F88133
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:06 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-635ee3baa14so26803866d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019446; x=1691611446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ayla9KElOyNjvPVUw7NmGEhrNVDhwYYpaWmdT7SKM8=;
        b=ie81bPbNM7mLSHlSzBMi6rwgbYM/E9HVkMaRFpgrmMz0oo4YwcAqe45b8Tw8amNDxj
         88mClPtCTbgBD1wYr/Cp4J1DWi8pc46BYN2ncTEarqyroChBxgFtYaCi1mvntAC7fNEK
         Sl272rdqLkkp2Ggs8S5OK7/J4CezYcZd5AprR8jxg44Y4gIxyceFguXJkMNwwYV+oZ0i
         2X39BGd/JyQWdVn/WVLQKUjxYbdqtlvyniEmbIkyeWkzY/bULTiFI7PXGdvIx3cy4H9g
         gWX+AnlYPbq0QAVBzfktRvk15UkACAQ35Bz+/sB8G3D0JvMcLAeWftcwsk+vXZ1Ecv3U
         +0gA==
X-Gm-Message-State: ABy/qLYcmu8zaAnO3zB30edAp4aL6/29aEwr3z5N+pPbSFV4rCtTu/ZM
        sWqj7k44Dfk1dbgVzLF2HoWZaGwlKKPV1BFk
X-Google-Smtp-Source: APBJJlFntbu3bQ+lJi7C0W+HToUThh+y0P+uSFPBrL7d7AOnJ4gRVoWQm2B2WLRqfJLFO0qQ/ensZQ==
X-Received: by 2002:a0c:f3c4:0:b0:635:d10b:aea0 with SMTP id f4-20020a0cf3c4000000b00635d10baea0mr10844846qvm.54.1689019445619;
        Mon, 10 Jul 2023 13:04:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b00767ded911a3sm112469qkj.116.2023.07.10.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:04:05 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 4/7] sched/fair: Add SHARED_RUNQ sched feature and skeleton calls
Date:   Mon, 10 Jul 2023 15:03:39 -0500
Message-Id: <20230710200342.358255-5-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain workloads in CFS, CPU utilization is of the upmost
importance. For example, at Meta, our main web workload benefits from a
1 - 1.5% improvement in RPS, and a 1 - 2% improvement in p99 latency,
when CPU utilization is pushed as high as possible.

This is likely something that would be useful for any workload with long
slices, or for which avoiding migration is unlikely to result in
improved cache locality.

We will soon be enabling more aggressive load balancing via a new
feature called shared_runq, which places tasks into a FIFO queue on the
wakeup path, and then dequeues them in newidle_balance(). We don't want
to enable the feature by default, so this patch defines and declares a
new scheduler feature called SHARED_RUNQ which is disabled by default.
In addition, we add some calls to empty / skeleton functions in the
relevant fair codepaths where shared_runq will be utilized.

A set of future patches will implement these functions, and enable
shared_runq for both single and multi socket / CCX architectures.

Note as well that in future patches, the location of these calls may
change. For example, if we end up enqueueing tasks in a shared runqueue
any time they become runnable, we'd move the calls from
enqueue_task_fair() and pick_next_task_fair() to __enqueue_entity() and
__dequeue_entity() respectively.

Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c     | 32 ++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e882b7bf5b4..f7967be7646c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -140,6 +140,18 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 #ifdef CONFIG_SMP
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
+				     int enq_flags)
+{}
+
+static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
+{
+	return 0;
+}
+
+static void shared_runq_dequeue_task(struct task_struct *p)
+{}
+
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
  */
@@ -162,6 +174,13 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
+#else
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
+				     int enq_flags)
+{}
+
+static void shared_runq_dequeue_task(struct task_struct *p)
+{}
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -6386,6 +6405,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
+	if (sched_feat(SHARED_RUNQ))
+		shared_runq_enqueue_task(rq, p, flags);
+
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
@@ -6467,6 +6489,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+	if (sched_feat(SHARED_RUNQ))
+		shared_runq_dequeue_task(p);
 }
 
 #ifdef CONFIG_SMP
@@ -8173,6 +8198,9 @@ done: __maybe_unused;
 
 	update_misfit_status(p, rq);
 
+	if (sched_feat(SHARED_RUNQ))
+		shared_runq_dequeue_task(p);
+
 	return p;
 
 idle:
@@ -11843,6 +11871,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!cpu_active(this_cpu))
 		return 0;
 
+	if (sched_feat(SHARED_RUNQ) && shared_runq_pick_next_task(this_rq, rf))
+		return -1;
+
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
@@ -12343,6 +12374,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
+	shared_runq_dequeue_task(p);
 	detach_task_cfs_rq(p);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..cd5db1a24181 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -101,3 +101,4 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+SCHED_FEAT(SHARED_RUNQ, false)
-- 
2.40.1

