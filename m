Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1DB60536D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiJSWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJSWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEB18F0E0;
        Wed, 19 Oct 2022 15:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C4CB8260A;
        Wed, 19 Oct 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B440EC433C1;
        Wed, 19 Oct 2022 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219906;
        bh=JgCYhsIq4xhCHA9e/N+ivpZlC63szLfECFNNQENWSoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmmPHg3u79iCf77y3+BTRprS1zEoKx1IdYqgBKXj3kv7PWvc/alzqFWj7YcT9olOC
         GsE3TKr7s5RD0JDx5Gyd/nK2z0FHM0IO6g960wWIXKirt2Qzp4SzWVPyN9pi5JjNSR
         ROd8sGq9OAZb2A0N0q8V48fWZrcFhujmQk0mjtoU9pSgWcDG5jE0ZjkwNIE3im4o8i
         i+tKYRbtCh82xR0H7GAW30YK0omnw1aXSpnxRUOgobPAahwXsra6Bi+fSKiRW81eJl
         Ei+dYJTIXpPiqZqnSNAKp5gLYh7HwF6+ouEH3k6Peqxbfkd53igt/U63mMnhcvcJ6X
         MUrClLR0WxLag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A6055C0890; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/14] rcu: Fix missing nocb gp wake on rcu_barrier()
Date:   Wed, 19 Oct 2022 15:51:33 -0700
Message-Id: <20221019225144.2500095-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

In preparation for RCU lazy changes, wake up the RCU nocb gp thread if
needed after an entrain.  This change prevents the RCU barrier callback
from waiting in the queue for several seconds before the lazy callbacks
in front of it are serviced.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c      | 11 +++++++++++
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bb8e72bc8151..fb7a1b95af71e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool wake_nocb = false;
+	bool was_alldone = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3902,7 +3904,14 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	/*
+	 * Flush bypass and wakeup rcuog if we add callbacks to an empty regular
+	 * queue. This way we don't wait for bypass timer that can reach seconds
+	 * if it's fully lazy.
+	 */
+	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -3910,6 +3919,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
 	rcu_nocb_unlock(rdp);
+	if (wake_nocb)
+		wake_nocb_gp(rdp, false);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c3..925dd98f8b23b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f77a6d7e13564..094fd454b6c38 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+	return false;
+}
+
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-- 
2.31.1.189.g2e36527f23

