Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F95735572
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjFSLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjFSLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:05:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F919BB;
        Mon, 19 Jun 2023 04:04:52 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687172690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhYkG18CC3IZQfpEnroweZVnAOhXoho2OODeQCJsAWA=;
        b=a+FBCzJ1ri6PRrvBcNEVkDBiAR3HwKUrwMYhbx9gapwJhGFFG2VsvA4hoDl7gwNncCGsnM
        +4sRn328KjopVXT1Xi8PuahG1HlDrkNZb8ze7OxFPl5M+pm+i5goe05wnKMtXZE6DkWlqB
        AV17ngY/Us19V4S+ixVxxiiS3q0m4MbHZMYAfr4GI8kSugHaqXWq4VuQhMBEEKBM69Q/t9
        lB8+QABnVXhKg3lDkbtZAe1Eyve95Actut7XpfnUmfAs7gIe0CtNyPnIRgpvFHC7mdOgie
        CcI1jlHCs4K9I+IY8+/AIV8UWK2MMS9SXU1njvPBu3XvMamzb+SxAOal5m/NoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687172690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhYkG18CC3IZQfpEnroweZVnAOhXoho2OODeQCJsAWA=;
        b=7Nx3KwTFnoN+9OEnM9PXgXcSw7g50Rc/EFNi2Zl8+TpP88Osv9uIgi0PqXAGt1xQomEQpt
        p2QyWiMheSVf83Aw==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Avoid multiple calling
 update_rq_clock() in __cfsb_csd_unthrottle()
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613082012.49615-4-jiahao.os@bytedance.com>
References: <20230613082012.49615-4-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <168717269012.404.5147060722554254381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ebb83d84e49b54369b0db67136a5fe1087124dcc
Gitweb:        https://git.kernel.org/tip/ebb83d84e49b54369b0db67136a5fe1087124dcc
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Tue, 13 Jun 2023 16:20:11 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:13 +02:00

sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()

After commit 8ad075c2eb1f ("sched: Async unthrottling for cfs
bandwidth"), we may update the rq clock multiple times in the loop of
__cfsb_csd_unthrottle().

A prior (although less common) instance of this problem exists in
unthrottle_offline_cfs_rqs().

Cure both by ensuring update_rq_clock() is called before the loop and
setting RQCF_ACT_SKIP during the loop, to supress further updates.
The alternative would be pulling update_rq_clock() out of
unthrottle_cfs_rq(), but that gives an even bigger mess.

Fixes: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")
Reviewed-By: Ben Segall <bsegall@google.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20230613082012.49615-4-jiahao.os@bytedance.com
---
 kernel/sched/fair.c  | 18 ++++++++++++++++++
 kernel/sched/sched.h | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7666dbc..a80a739 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5577,6 +5577,14 @@ static void __cfsb_csd_unthrottle(void *arg)
 	rq_lock(rq, &rf);
 
 	/*
+	 * Iterating over the list can trigger several call to
+	 * update_rq_clock() in unthrottle_cfs_rq().
+	 * Do it once and skip the potential next ones.
+	 */
+	update_rq_clock(rq);
+	rq_clock_start_loop_update(rq);
+
+	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
 	 * the CSD list. However, this RCU critical section annotates the
 	 * fact that we pair with sched_free_group_rcu(), so that we cannot
@@ -5595,6 +5603,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rcu_read_unlock();
 
+	rq_clock_stop_loop_update(rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -6115,6 +6124,13 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * The rq clock has already been updated in the
+	 * set_rq_offline(), so we should skip updating
+	 * the rq clock again in unthrottle_cfs_rq().
+	 */
+	rq_clock_start_loop_update(rq);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
@@ -6137,6 +6153,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 	rcu_read_unlock();
+
+	rq_clock_stop_loop_update(rq);
 }
 
 #else /* CONFIG_CFS_BANDWIDTH */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 36e23e4..50d4b61 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1546,6 +1546,28 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
+/*
+ * During cpu offlining and rq wide unthrottling, we can trigger
+ * an update_rq_clock() for several cfs and rt runqueues (Typically
+ * when using list_for_each_entry_*)
+ * rq_clock_start_loop_update() can be called after updating the clock
+ * once and before iterating over the list to prevent multiple update.
+ * After the iterative traversal, we need to call rq_clock_stop_loop_update()
+ * to clear RQCF_ACT_SKIP of rq->clock_update_flags.
+ */
+static inline void rq_clock_start_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	SCHED_WARN_ON(rq->clock_update_flags & RQCF_ACT_SKIP);
+	rq->clock_update_flags |= RQCF_ACT_SKIP;
+}
+
+static inline void rq_clock_stop_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+}
+
 struct rq_flags {
 	unsigned long flags;
 	struct pin_cookie cookie;
