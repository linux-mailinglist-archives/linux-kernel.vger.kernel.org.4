Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD3648618
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLIQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:04:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C3511C1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uriMDI2ZCE8yJ2s7gliLiFl9TTIyTtgkAsDBvtqWibY=; b=uKj/FxhqB8krz9Rqdy8k27wZBX
        KpnM67BLl5YrRtxp9F7m8oparV/7xJ3FJRU5QNtW7bVA441JtRJ+flpqfBV6Ex6+jk5tuKaEq1Snp
        JUcicfbyZI3+8ZPGEwghQSBFpWL66fiM47Ulfo0BeG99pZeiNIoPtbBcW2fh6fGcW2rmxI/nFF1dZ
        wFbeI+OmAZpJhQU3FbVvFJVPHMSv1PQx9941VAm6L92bR9pLTRyZLWM7HE1iGBAORIa4Bp2mF9eBh
        26pvZLCtqTG0WfuzvQdv6BFqKkwtE29vSaonIBlBAJysafgg2Cld9t++5UvftSxViGIssZI+WvIWQ
        ZeAzkHpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3frW-008B1J-6s; Fri, 09 Dec 2022 16:04:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] sched: Make const-safe
Date:   Fri,  9 Dec 2022 16:04:31 +0000
Message-Id: <20221209160431.1948817-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a modified container_of() that preserves constness, the compiler
finds some variables which should have been const and some functions
which should have had their arguments marked as const.  No change to
generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/sched/core.c  |  8 +++++---
 kernel/sched/fair.c  | 16 +++++++++-------
 kernel/sched/sched.h | 11 ++++++-----
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b6ee5f..853188cb6c84 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -152,7 +152,7 @@ __read_mostly int scheduler_running;
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
 /* kernel prio, less is more */
-static inline int __task_prio(struct task_struct *p)
+static inline int __task_prio(const struct task_struct *p)
 {
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
@@ -174,7 +174,8 @@ static inline int __task_prio(struct task_struct *p)
  */
 
 /* real prio, less is less */
-static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
+static inline bool prio_less(const struct task_struct *a,
+			     const struct task_struct *b, bool in_fi)
 {
 
 	int pa = __task_prio(a), pb = __task_prio(b);
@@ -194,7 +195,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 	return false;
 }
 
-static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
+static inline bool __sched_core_less(const struct task_struct *a,
+				     const struct task_struct *b)
 {
 	if (a->core_cookie < b->core_cookie)
 		return true;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..855470310903 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -468,7 +468,7 @@ is_same_group(struct sched_entity *se, struct sched_entity *pse)
 	return NULL;
 }
 
-static inline struct sched_entity *parent_entity(struct sched_entity *se)
+static inline struct sched_entity *parent_entity(const struct sched_entity *se)
 {
 	return se->parent;
 }
@@ -595,8 +595,8 @@ static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 	return min_vruntime;
 }
 
-static inline bool entity_before(struct sched_entity *a,
-				struct sched_entity *b)
+static inline bool entity_before(const struct sched_entity *a,
+				 const struct sched_entity *b)
 {
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
@@ -11728,7 +11728,8 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 /*
  * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
  */
-static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
+static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
+			 bool forceidle)
 {
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -11753,11 +11754,12 @@ void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
 	se_fi_update(se, rq->core->core_forceidle_seq, in_fi);
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
+bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
+			bool in_fi)
 {
 	struct rq *rq = task_rq(a);
-	struct sched_entity *sea = &a->se;
-	struct sched_entity *seb = &b->se;
+	const struct sched_entity *sea = &a->se;
+	const struct sched_entity *seb = &b->se;
 	struct cfs_rq *cfs_rqa;
 	struct cfs_rq *cfs_rqb;
 	s64 delta;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..aa729d54cf94 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -248,7 +248,7 @@ static inline void update_avg(u64 *avg, u64 sample)
 
 #define SCHED_DL_FLAGS (SCHED_FLAG_RECLAIM | SCHED_FLAG_DL_OVERRUN | SCHED_FLAG_SUGOV)
 
-static inline bool dl_entity_is_special(struct sched_dl_entity *dl_se)
+static inline bool dl_entity_is_special(const struct sched_dl_entity *dl_se)
 {
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 	return unlikely(dl_se->flags & SCHED_FLAG_SUGOV);
@@ -260,8 +260,8 @@ static inline bool dl_entity_is_special(struct sched_dl_entity *dl_se)
 /*
  * Tells if entity @a should preempt entity @b.
  */
-static inline bool
-dl_entity_preempt(struct sched_dl_entity *a, struct sched_dl_entity *b)
+static inline bool dl_entity_preempt(const struct sched_dl_entity *a,
+				     const struct sched_dl_entity *b)
 {
 	return dl_entity_is_special(a) ||
 	       dl_time_before(a->deadline, b->deadline);
@@ -1236,7 +1236,8 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
+bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
+			bool fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
@@ -1415,7 +1416,7 @@ static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
 }
 
 /* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+static inline struct cfs_rq *cfs_rq_of(const struct sched_entity *se)
 {
 	return se->cfs_rq;
 }
-- 
2.35.1

