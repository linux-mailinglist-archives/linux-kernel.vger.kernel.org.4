Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBD6F819F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEELZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjEELYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:24:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A1C1A4AF;
        Fri,  5 May 2023 04:24:35 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QCSsT1Qglz18KCs;
        Fri,  5 May 2023 19:20:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:32 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <corbet@lwn.net>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <qiang1.zhang@intel.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <peterz@infradead.org>, <frankwoo@google.com>,
        <Rhinewuwu@google.com>
CC:     <liujian56@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH 8/9] softirq,rcu: Use softirq_needs_break()
Date:   Fri, 5 May 2023 19:33:14 +0800
Message-ID: <20230505113315.3307723-9-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505113315.3307723-1-liujian56@huawei.com>
References: <20230505113315.3307723-1-liujian56@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

SoftIRQs provide their own timeout/break code now, use that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/rcu/tree.c      | 29 +++++++----------------------
 kernel/rcu/tree_nocb.h |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f52ff7241041..1942e3db4145 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -397,10 +397,6 @@ static bool rcu_kick_kthreads;
 static int rcu_divisor = 7;
 module_param(rcu_divisor, int, 0644);
 
-/* Force an exit from rcu_do_batch() after 3 milliseconds. */
-static long rcu_resched_ns = 3 * NSEC_PER_MSEC;
-module_param(rcu_resched_ns, long, 0644);
-
 /*
  * How long the grace period must be before we start recruiting
  * quiescent-state help from rcu_note_context_switch().
@@ -2050,7 +2046,7 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Throttle as specified by rdp->blimit.
  */
-static void rcu_do_batch(struct rcu_data *rdp)
+static void rcu_do_batch(struct softirq_action *h, struct rcu_data *rdp)
 {
 	int div;
 	bool __maybe_unused empty;
@@ -2058,7 +2054,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
-	long pending, tlimit = 0;
+	long pending;
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
@@ -2082,12 +2078,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (in_serving_softirq() && unlikely(bl > 100)) {
-		long rrn = READ_ONCE(rcu_resched_ns);
-
-		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
-		tlimit = local_clock() + rrn;
-	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
@@ -2126,13 +2116,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			 * Make sure we don't spend too much time here and deprive other
 			 * softirq vectors of CPU cycles.
 			 */
-			if (unlikely(tlimit)) {
-				/* only call local_clock() every 32 callbacks */
-				if (likely((count & 31) || local_clock() < tlimit))
-					continue;
-				/* Exceeded the time limit, so leave. */
+			if (unlikely(!(count & 31)) && softirq_needs_break(h))
 				break;
-			}
 		} else {
 			// In rcuoc context, so no worries about depriving
 			// other softirq vectors of CPU cycles.
@@ -2320,7 +2305,7 @@ static void strict_work_handler(struct work_struct *work)
 }
 
 /* Perform RCU core processing work for the current CPU.  */
-static __latent_entropy void rcu_core(void)
+static __latent_entropy void rcu_core(struct softirq_action *h)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
@@ -2374,7 +2359,7 @@ static __latent_entropy void rcu_core(void)
 	/* If there are callbacks ready, invoke them. */
 	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active))) {
-		rcu_do_batch(rdp);
+		rcu_do_batch(h, rdp);
 		/* Re-invoke RCU core processing if there are callbacks remaining. */
 		if (rcu_segcblist_ready_cbs(&rdp->cblist))
 			invoke_rcu_core();
@@ -2391,7 +2376,7 @@ static __latent_entropy void rcu_core(void)
 
 static void rcu_core_si(struct softirq_action *h)
 {
-	rcu_core();
+	rcu_core(h);
 }
 
 static void rcu_wake_cond(struct task_struct *t, int status)
@@ -2462,7 +2447,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		*workp = 0;
 		local_irq_enable();
 		if (work)
-			rcu_core();
+			rcu_core(NULL);
 		local_bh_enable();
 		if (*workp == 0) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f2280616f9d5..44fc907fdb5e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -951,7 +951,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	 * instances of this callback would execute concurrently.
 	 */
 	local_bh_disable();
-	rcu_do_batch(rdp);
+	rcu_do_batch(NULL, rdp);
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.34.1

