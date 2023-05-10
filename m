Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8C6FE2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEJQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjEJQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013A11D;
        Wed, 10 May 2023 09:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 993D763F32;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058B1C4339E;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737914;
        bh=Me3Kqr9uGd2TfIIIWzyQD74ZVyYw70Fp/6TxMe8zjFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1TdPulpc0Fay6L9gjHHhILfIAdAL8QPi97Xqr0spylCPVSnbwPeaJ2NePxbA+THP
         eXEWdHZsiKXDszihD5HV88r9S3yJ4gsljgDWiG7hBZiKF6on2WarmEWE4kI/2fctMb
         obqNNDLnGQZgi+p0MjmCCca3A3cVOOcwj66vNqR0LSXhin0tInFAsEYAWtn0QVRF67
         r94nOb7T+TVwXEP/xlikS77r97wi/P/1pzPb3PA6woNG0+Ef3Vy76EZ8HSjQ7ILWb6
         gXOsOswLlUkisiCuEhIjtBhvp/ugO4IRJ1CEyDH0ohpOsU0ksZfgHmoLwpWXa2VqHn
         Es55T/aDjXDZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8FBE7CE127F; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Domas Mituzas <dmituzas@meta.com>
Subject: [PATCH rcu 4/8] rcu: Employ jiffies-based backstop to callback time limit
Date:   Wed, 10 May 2023 09:58:28 -0700
Message-Id: <20230510165832.2187453-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if there are more than 100 ready-to-invoke RCU callbacks queued
on a given CPU, the rcu_do_batch() function sets a timeout for invocation
of the series.  This timeout defaulting to three milliseconds, and may
be adjusted using the rcutree.rcu_resched_ns kernel boot parameter.
This timeout is checked using local_clock(), but the overhead of this
function combined with the common-case very small callback-invocation
overhead means that local_clock() is checked every 32nd invocation.

This works well except for longer-than average callbacks.  For example,
a series of 500-microsecond-duration callbacks means that local_clock()
is checked only once every 16 milliseconds, which makes it difficult to
enforce a three-millisecond timeout.

This commit therefore adds a Kconfig option RCU_DOUBLE_CHECK_CB_TIME
that enables backup timeout checking using the coarser grained but
lighter weight jiffies.  If the jiffies counter detects a timeout,
then local_clock() is consulted even if this is not the 32nd callback.
This prevents the aforementioned 16-millisecond latency blow.

Reported-by: Domas Mituzas <dmituzas@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 18 ++++++++++++++++++
 kernel/rcu/tree.c  | 28 ++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 9071182b1284..bdd7eadb33d8 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -314,4 +314,22 @@ config RCU_LAZY
 	  To save power, batch RCU callbacks and flush after delay, memory
 	  pressure, or callback list growing too big.
 
+config RCU_DOUBLE_CHECK_CB_TIME
+	bool "RCU callback-batch backup time check"
+	depends on RCU_EXPERT
+	default n
+	help
+	  Use this option to provide more precise enforcement of the
+	  rcutree.rcu_resched_ns module parameter in situations where
+	  a single RCU callback might run for hundreds of microseconds,
+	  thus defeating the 32-callback batching used to amortize the
+	  cost of the fine-grained but expensive local_clock() function.
+
+	  This option rounds rcutree.rcu_resched_ns up to the next
+	  jiffy, and overrides the 32-callback batching if this limit
+	  is exceeded.
+
+	  Say Y here if you need tighter callback-limit enforcement.
+	  Say N here if you are unsure.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9a5c160186d1..e2dbea6cee4b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2047,10 +2047,15 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 }
 
 /* Return true if callback-invocation time limit exceeded. */
-static bool rcu_do_batch_check_time(long count, long tlimit)
+static bool rcu_do_batch_check_time(long count, long tlimit,
+				    bool jlimit_check, unsigned long jlimit)
 {
 	// Invoke local_clock() only once per 32 consecutive callbacks.
-	return unlikely(tlimit) && !likely(count & 31) && local_clock() >= tlimit;
+	return unlikely(tlimit) &&
+	       (!likely(count & 31) ||
+		(IS_ENABLED(CONFIG_RCU_DOUBLE_CHECK_CB_TIME) &&
+		 jlimit_check && time_after(jiffies, jlimit))) &&
+	       local_clock() >= tlimit;
 }
 
 /*
@@ -2059,13 +2064,17 @@ static bool rcu_do_batch_check_time(long count, long tlimit)
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
+	long bl;
+	long count = 0;
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	struct rcu_head *rhp;
+	unsigned long jlimit;
+	bool jlimit_check = false;
+	long pending;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count = 0;
-	long pending, tlimit = 0;
+	struct rcu_head *rhp;
+	long tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
@@ -2090,11 +2099,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
 	if ((in_serving_softirq() || rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING) &&
-	    unlikely(bl > 100)) {
+	    (IS_ENABLED(CONFIG_RCU_DOUBLE_CHECK_CB_TIME) || unlikely(bl > 100))) {
+		const long npj = NSEC_PER_SEC / HZ;
 		long rrn = READ_ONCE(rcu_resched_ns);
 
 		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
 		tlimit = local_clock() + rrn;
+		jlimit = jiffies + (rrn + npj + 1) / npj;
+		jlimit_check = true;
 	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
@@ -2134,7 +2146,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			 * Make sure we don't spend too much time here and deprive other
 			 * softirq vectors of CPU cycles.
 			 */
-			if (rcu_do_batch_check_time(count, tlimit))
+			if (rcu_do_batch_check_time(count, tlimit, jlimit_check, jlimit))
 				break;
 		} else {
 			// In rcuc/rcuoc context, so no worries about
@@ -2147,7 +2159,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			// But rcuc kthreads can delay quiescent-state
 			// reporting, so check time limits for them.
 			if (rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING &&
-			    rcu_do_batch_check_time(count, tlimit)) {
+			    rcu_do_batch_check_time(count, tlimit, jlimit_check, jlimit)) {
 				rdp->rcu_cpu_has_work = 1;
 				break;
 			}
-- 
2.40.1

