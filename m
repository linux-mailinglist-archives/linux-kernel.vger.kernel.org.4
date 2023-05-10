Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372C6FE2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjEJQ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjEJQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0EA0;
        Wed, 10 May 2023 09:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9186863F40;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1742C433D2;
        Wed, 10 May 2023 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737914;
        bh=lQMcRttOrnsmeuCGpfDl3MfHTsoNHuhuIBx3bHzbYGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arJy9OLkowmfnbg7ezlR1oAzrgv3Gvd39Xj86Spc7DcLNl2FnMkaD+uPlspX0KAne
         laMlsxdoHplNCpx+nhiBjQk/hXj/1mHa674d04JdOismzbcGwK1E6zQj3hNLfZwKMr
         aMtFQfO59H5+C6S66KeE3CwSpzR088PCSSQZeEFFLh6zm/28HJ7WRM0kKjzCmIsT1r
         h6aPmIi/9LWY55genLWYgtynRSQLkgaGDrc3my86jYSLGGQvwbzg+y0uKzcIi5f5r/
         1BLqoWek4dw4j1nsp0NPfptlMpTaSgW5k4PD6Da7FZ2SPZed5JSoOqx0ylp/9oxKBq
         3plhQ4BeJAtrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8D68ECE1279; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/8] rcu: Check callback-invocation time limit for rcuc kthreads
Date:   Wed, 10 May 2023 09:58:27 -0700
Message-Id: <20230510165832.2187453-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a callback-invocation time limit is enforced only for
callbacks invoked from the softirq environment, the rationale being
that when callbacks are instead invoked from rcuc and rcuoc kthreads,
these callbacks cannot be holding up other softirq vectors.

Which is in fact true.  However, if an rcuc kthread spends too much time
invoking callbacks, it can delay quiescent-state reports from its CPU,
which can also be a problem.

This commit therefore applies the callback-invocation time limit to
callback invocation from the rcuc kthreads as well as from softirq.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f52ff7241041..9a5c160186d1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2046,6 +2046,13 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 	rcu_report_qs_rdp(rdp);
 }
 
+/* Return true if callback-invocation time limit exceeded. */
+static bool rcu_do_batch_check_time(long count, long tlimit)
+{
+	// Invoke local_clock() only once per 32 consecutive callbacks.
+	return unlikely(tlimit) && !likely(count & 31) && local_clock() >= tlimit;
+}
+
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Throttle as specified by rdp->blimit.
@@ -2082,7 +2089,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (in_serving_softirq() && unlikely(bl > 100)) {
+	if ((in_serving_softirq() || rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING) &&
+	    unlikely(bl > 100)) {
 		long rrn = READ_ONCE(rcu_resched_ns);
 
 		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
@@ -2126,21 +2134,23 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			 * Make sure we don't spend too much time here and deprive other
 			 * softirq vectors of CPU cycles.
 			 */
-			if (unlikely(tlimit)) {
-				/* only call local_clock() every 32 callbacks */
-				if (likely((count & 31) || local_clock() < tlimit))
-					continue;
-				/* Exceeded the time limit, so leave. */
+			if (rcu_do_batch_check_time(count, tlimit))
 				break;
-			}
 		} else {
-			// In rcuoc context, so no worries about depriving
-			// other softirq vectors of CPU cycles.
+			// In rcuc/rcuoc context, so no worries about
+			// depriving other softirq vectors of CPU cycles.
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
 			cond_resched_tasks_rcu_qs();
 			lockdep_assert_irqs_enabled();
 			local_bh_disable();
+			// But rcuc kthreads can delay quiescent-state
+			// reporting, so check time limits for them.
+			if (rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING &&
+			    rcu_do_batch_check_time(count, tlimit)) {
+				rdp->rcu_cpu_has_work = 1;
+				break;
+			}
 		}
 	}
 
-- 
2.40.1

