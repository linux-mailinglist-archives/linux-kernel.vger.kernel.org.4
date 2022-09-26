Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C85E9BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiIZIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiIZITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:19:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A650A475
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:19:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i6so1743129pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NjIyqUpRVXy5DWN7PDhIdKjKlv7GlZJeHLPiKGqOEhQ=;
        b=rNM0y2h9GhGDWPoW94JOco1DtMdA/YQ0uOsixP5x1nk90GYc6XQOLaYpzxOeGyx/YK
         E+p5+74T20lYhYLcG4titCr5pmfP13DaCZEN81S32aJykcITUrlnw/LEfzCPcalWf27M
         G88tBQH7KyT+MrHJSnbwOq4IjndhOxyE2RkxEBZW4ZhfOU7uJvqSUi2vPvadnPT4IjuT
         1mekXJhL0mr2BMlpOFoFs43BRSZ3on+1TWNqu7CrnnXXPtNCFDgFoOBqxX1+hsnTXmF7
         cKGZ9Xgk9J896y4+up0vZlhg/kCePxawaacBnQKKifrRgikF4D/i2Ns8PcAQV7eQL3eF
         lzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NjIyqUpRVXy5DWN7PDhIdKjKlv7GlZJeHLPiKGqOEhQ=;
        b=7ISh3ZnNTO7y71u01msAuTSlmpVTbBvBSBTsVOasH3XyyFM0sGiv8G/B2hNNG8QWwB
         B12WS2dxDEzJdN6qDb3ZvN1Su5/nRBPc3wYhRYS9yb25w/ycHHcWz+k8S9qW+lVXwrq3
         tspZrigFC+jO1YpWgvyudxxBN5hK6ZD3HDz24+zHuagGvpVZr/ywGeTpLllCJTQmeo6F
         kENsMBPNKc2TMXnwdT4TVBe2uDlLD2XOc2fr42xEMjDq9at1sa95S/4Yh6g0O/DxgXpm
         B+4bZiYbvF1VpwuW1q+iEgXDyplHn2aJCNhMzw3gEkO8SVMj5jA69J4Uwk/xdOVAQ6uD
         keag==
X-Gm-Message-State: ACrzQf2e8u/bbNfoPbTs6VdgzduAx03h0IGr9+4+/e0daajxwjh8Mmli
        BzGMIh+qPTmosqJ7gdyJKlfgSA==
X-Google-Smtp-Source: AMsMyM4yjE1/qwe9dyCZt1bsvYoMHnFJ2NQU93iKeua2APjjQ5MiFTp6vNy9/p4E2TzGcXaJTvjxjw==
X-Received: by 2002:a05:6a00:14d3:b0:546:e93c:4768 with SMTP id w19-20020a056a0014d300b00546e93c4768mr21956819pfu.36.1664180386967;
        Mon, 26 Sep 2022 01:19:46 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b001746f66244asm10739632pll.18.2022.09.26.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:19:46 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/psi: Use task->psi_flags to clear in CPU migration
Date:   Mon, 26 Sep 2022 16:19:31 +0800
Message-Id: <20220926081931.45420-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d583d360a620 ("psi: Fix psi state corruption when schedule()
races with cgroup move") fixed a race problem by making cgroup_move_task()
use task->psi_flags instead of looking at the scheduler state.

We can extend task->psi_flags usage to CPU migration, which should be
a minor optimization for performance and code simplicity.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/sched.h |  3 ---
 kernel/sched/core.c   |  2 +-
 kernel/sched/stats.h  | 22 ++++------------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5cdf746988a1..cffce0eaf640 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -890,9 +890,6 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
-#ifdef CONFIG_PSI
-	unsigned			sched_psi_wake_requeue:1;
-#endif
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7fa9802dfde..2d98b9b5185f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2056,7 +2056,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!(flags & ENQUEUE_RESTORE)) {
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, flags & ENQUEUE_WAKEUP);
+		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
 	uclamp_rq_inc(rq, p);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 84a188913cc9..38f3698f5e5b 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -128,11 +128,9 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (p->in_memstall)
 		set |= TSK_MEMSTALL_RUNNING;
 
-	if (!wakeup || p->sched_psi_wake_requeue) {
+	if (!wakeup) {
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
-		if (p->sched_psi_wake_requeue)
-			p->sched_psi_wake_requeue = 0;
 	} else {
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
@@ -143,8 +141,6 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
-	int clear = TSK_RUNNING;
-
 	if (static_branch_likely(&psi_disabled))
 		return;
 
@@ -157,10 +153,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 	if (sleep)
 		return;
 
-	if (p->in_memstall)
-		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
-
-	psi_task_change(p, clear, 0);
+	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
@@ -172,19 +165,12 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	 * deregister its sleep-persistent psi states from the old
 	 * queue, and let psi_enqueue() know it has to requeue.
 	 */
-	if (unlikely(p->in_iowait || p->in_memstall)) {
+	if (unlikely(p->psi_flags)) {
 		struct rq_flags rf;
 		struct rq *rq;
-		int clear = 0;
-
-		if (p->in_iowait)
-			clear |= TSK_IOWAIT;
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
 
 		rq = __task_rq_lock(p, &rf);
-		psi_task_change(p, clear, 0);
-		p->sched_psi_wake_requeue = 1;
+		psi_task_change(p, p->psi_flags, 0);
 		__task_rq_unlock(rq, &rf);
 	}
 }
-- 
2.37.2

