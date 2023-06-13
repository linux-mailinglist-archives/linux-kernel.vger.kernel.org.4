Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2509772D907
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbjFMFU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjFMFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:20:20 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699110E2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:20:17 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7608aae9355so54013185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686633616; x=1689225616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaVFx6PFTVsCMikKDqXFhftAW190U82u0GizTbg9/BI=;
        b=KNUd3arLLFqYGORJDXOwrtylv7nowpb/cvvbkxHdvYoSSQ8oLoJeqvR11Dj6Ld9Yzg
         BL7OQYVB7t5dTPgUaxDPcsVorDmdi0Na3DVSezzHaxJBV09vjZoyH/rNplmJ7Rgc25c3
         5EHO8sGCh5II2VCbNyZWEUXg2onc8a8439hr2g3JW5cdVldhC//LwJvBsOu2h/Btyvto
         +04cfsyvswWtzM0R+ohuebsAKMazvqAFGkJgzVOyX1nynjm/AJoYTwvIo2sWQJqVKEUh
         vvNYXaEKGl+i0yOrZ0FqEsLcnAlylJBhjHvWtMUkCoiLYzehW1Ct+mx3E3+Ib3USCYWw
         GKiQ==
X-Gm-Message-State: AC+VfDwa7FKKsPTLl+P1BgiXL3KxqzXAFAhlcBJNG2hmAtLWJWfnZJZ5
        dUdorGZ3EMtvmpr+kb12ArfZ1pM8GECC/Cgw
X-Google-Smtp-Source: ACHHUZ480gdS/W2XMdKFD3PllKeGq4qFWK6DbQBeHSAk3YPQFSWkL1k+hvGJhiOqrkMKvFrXhPnJTg==
X-Received: by 2002:a05:620a:3724:b0:75d:5571:64c0 with SMTP id de36-20020a05620a372400b0075d557164c0mr14967052qkb.37.1686633615661;
        Mon, 12 Jun 2023 22:20:15 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id o23-20020a05620a15d700b0075cdad9648dsm3375500qkm.25.2023.06.12.22.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 22:20:15 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: [RFC PATCH 2/3] sched/fair: Add SWQUEUE sched feature and skeleton calls
Date:   Tue, 13 Jun 2023 00:20:03 -0500
Message-Id: <20230613052004.2836135-3-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613052004.2836135-1-void@manifault.com>
References: <20230613052004.2836135-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
feature called swqueue, which places tasks into a FIFO queue on the
wakeup path, and then dequeues them when a core goes idle before
invoking newidle_balance(). We don't want to enable the feature by
default, so this patch defines and declares a new scheduler feature
called SWQUEUE which is disabled by default. In addition, we add some
calls to empty / skeleton functions in the relevant fair codepaths where
swqueue will be utilized.

A set of future patches will implement these functions, and enable
swqueue for both single and multi socket / CCX architectures.

Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c     | 35 +++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 292c593fc84f..807986bd6ea6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -140,6 +140,17 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 #ifdef CONFIG_SMP
+static void swqueue_enqueue(struct rq *rq, struct task_struct *p,
+			    int enq_flags)
+{}
+static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
+{
+	return 0;
+}
+
+static void swqueue_remove_task(struct task_struct *p)
+{}
+
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
  */
@@ -162,6 +173,17 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
+#else
+static void swqueue_enqueue(struct rq *rq, struct task_struct *p,
+			    int enq_flags)
+{}
+static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
+{
+	return 0;
+}
+
+static void swqueue_remove_task(struct task_struct *p)
+{}
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -6368,6 +6390,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
+	if (sched_feat(SWQUEUE))
+		swqueue_enqueue(rq, p, flags);
+
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
@@ -6449,6 +6474,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+	if (sched_feat(SWQUEUE))
+		swqueue_remove_task(p);
 }
 
 #ifdef CONFIG_SMP
@@ -8155,12 +8183,18 @@ done: __maybe_unused;
 
 	update_misfit_status(p, rq);
 
+	if (sched_feat(SWQUEUE))
+		swqueue_remove_task(p);
+
 	return p;
 
 idle:
 	if (!rf)
 		return NULL;
 
+	if (sched_feat(SWQUEUE) && swqueue_pick_next_task(rq, rf))
+		return RETRY_TASK;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
@@ -12325,6 +12359,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
+	swqueue_remove_task(p);
 	detach_task_cfs_rq(p);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..57b19bc70cd4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -101,3 +101,4 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+SCHED_FEAT(SWQUEUE, false)
-- 
2.40.1

