Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0CB613405
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJaKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJaKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:54:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B623A6;
        Mon, 31 Oct 2022 03:54:00 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:53:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667213638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaNurCJbtcwOCKgbGDmdD1pyoT5KwJzQ0tjIxKc/eqo=;
        b=lRtlelk4CsmPqa3Q8irKCRH0pJZCWWmB6UWpqOrSPXmzFyh6bvAHnBCchvC+RputDwJC0c
        TUhyjBGO6gVilO4K8Km3PdfWErSq6zya75VR5Che2yFaLnOMY55BRZjkP63wFIxlYGCgVt
        f172eteAr/FY0lPkz2IXdnTrJJmmiG02DasMqKOiFEgTtbrk3w200Mme+1qXscRhmxZVYj
        1s3ROQvog3q4UFZdgbY/SINNf57QksLAQRZr1hfI+kUIUNK1dpDJEpwmKiObVjZI5NUEqS
        sYKNRU+P8iZSlSyh9TlLlFkFO9lWQo/9pKEDSvdWtNQEYMz95a1cpvlNcJROvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667213638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaNurCJbtcwOCKgbGDmdD1pyoT5KwJzQ0tjIxKc/eqo=;
        b=PK8Wo3/GlBuqjkCNuVV568nsSsmniyFjhVnSxX4X3TJJAaq/XgFfmZM0KlGFxasabNZ8rt
        /1KXMGEmVSmN7qBw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Use task->psi_flags to clear in CPU migration
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220926081931.45420-1-zhouchengming@bytedance.com>
References: <20220926081931.45420-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166721363659.7716.10522729624614709628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     52b33d87b9197c51e8ffdc61873739d90dd0a16f
Gitweb:        https://git.kernel.org/tip/52b33d87b9197c51e8ffdc61873739d90dd0a16f
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Mon, 26 Sep 2022 16:19:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 30 Oct 2022 10:12:15 +01:00

sched/psi: Use task->psi_flags to clear in CPU migration

The commit d583d360a620 ("psi: Fix psi state corruption when schedule()
races with cgroup move") fixed a race problem by making cgroup_move_task()
use task->psi_flags instead of looking at the scheduler state.

We can extend task->psi_flags usage to CPU migration, which should be
a minor optimization for performance and code simplicity.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220926081931.45420-1-zhouchengming@bytedance.com
---
 include/linux/sched.h |  3 ---
 kernel/sched/core.c   |  2 +-
 kernel/sched/stats.h  | 22 ++++------------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb5..23de7fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -888,9 +888,6 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
-#ifdef CONFIG_PSI
-	unsigned			sched_psi_wake_requeue:1;
-#endif
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87c9cdf..07ac08c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2053,7 +2053,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!(flags & ENQUEUE_RESTORE)) {
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, flags & ENQUEUE_WAKEUP);
+		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
 	uclamp_rq_inc(rq, p);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 84a1889..38f3698 100644
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
