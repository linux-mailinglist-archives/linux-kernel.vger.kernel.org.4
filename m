Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DF656AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiL0MPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiL0MOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901B4D73;
        Tue, 27 Dec 2022 04:13:50 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJp3yTekyyDYBvWYZWqPd0jNQY9v+mFZgmrixc/PdMc=;
        b=XEMCnf1fbUdhYyDQM0dUQWBZ0lOA3rpoSXJpOBOHRQqeAYY/81ULkHFM7AS6E/o+75Ydpu
        Km6Ms2EoMiEP9PFpsnFlrjyE1ctxZ4ZCBOPeeXxuuGQvKIMnloKzvEKl3rBw6bGenV8Bzo
        gfd863YRxzCQtXrUNpJQQP2WY5H/3Xhmo284pq6NLPjjPaNlUiovmmbDHoncgo2mXgxD3h
        M7/oZRf8QWtcrUf3AZ2jksv8pXLfeT09OLp2fNKCI1MInhrRlU9fhbzL8OZkQauK8vVHFP
        BxSUfOrziPq5ociBSCoLiCxabB9BC3dcaardJl6HC7gdV98KSWv8TWxKdG77ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJp3yTekyyDYBvWYZWqPd0jNQY9v+mFZgmrixc/PdMc=;
        b=lZLrDevfqu2ryaBEWuHy4qnYQONXh2rm03JNysGgKbEX/dN1XZXfAwJfDcEb7lITV3+92x
        AfuG/YdW9D/VECBQ==
From:   "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make const-safe
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221212144946.2657785-1-willy@infradead.org>
References: <20221212144946.2657785-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID: <167214322885.4906.11959236651271020649.tip-bot2@tip-bot2>
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

Commit-ID:     904cbab71dda1689d41a240541179f21ff433c40
Gitweb:        https://git.kernel.org/tip/904cbab71dda1689d41a240541179f21ff433c40
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Mon, 12 Dec 2022 14:49:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:16 +01:00

sched: Make const-safe

With a modified container_of() that preserves constness, the compiler
finds some pointers which should have been marked as const.  task_of()
also needs to become const-preserving for the !FAIR_GROUP_SCHED case so
that cfs_rq_of() can take a const argument.  No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221212144946.2657785-1-willy@infradead.org
---
 kernel/sched/core.c  |  8 +++++---
 kernel/sched/fair.c  | 16 +++++++++-------
 kernel/sched/sched.h | 22 ++++++++++------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75830b7..1f3259c 100644
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
index ea81d48..d0e2a48 100644
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
@@ -11852,7 +11852,8 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 /*
  * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
  */
-static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
+static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
+			 bool forceidle)
 {
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -11877,11 +11878,12 @@ void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
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
index c2d7467..1072502 100644
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
@@ -1244,7 +1244,8 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
+bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
+			bool fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
@@ -1423,7 +1424,7 @@ static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
 }
 
 /* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+static inline struct cfs_rq *cfs_rq_of(const struct sched_entity *se)
 {
 	return se->cfs_rq;
 }
@@ -1436,19 +1437,16 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 
 #else
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
+#define task_of(_se)	container_of(_se, struct task_struct, se)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+static inline struct cfs_rq *task_cfs_rq(const struct task_struct *p)
 {
 	return &task_rq(p)->cfs;
 }
 
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+static inline struct cfs_rq *cfs_rq_of(const struct sched_entity *se)
 {
-	struct task_struct *p = task_of(se);
+	const struct task_struct *p = task_of(se);
 	struct rq *rq = task_rq(p);
 
 	return &rq->cfs;
