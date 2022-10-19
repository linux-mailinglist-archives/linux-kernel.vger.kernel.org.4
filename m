Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EE605373
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJSWwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiJSWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528C190472;
        Wed, 19 Oct 2022 15:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 618D9CE242E;
        Wed, 19 Oct 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA2C433D6;
        Wed, 19 Oct 2022 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219906;
        bh=cd9rgMHV5ytGRmwwPo9gYzUKZlyUq56zzJaeb9ZJrZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFduOefcF3DL5P78TykY4+I41g8zwf9ipFCX1ghnGq+rZ2F7oeLDQ3t6/PGJHe5FT
         lhhVZ1vE522OBbGx19z+6enNorzxpeNLqUQqIB49qVbTuc4u0zKMUKcQV3o1/ebZQP
         IUKC2sdvWq9i9w/EgpY1/G59nv+d3Hd/RoeLr85Yreq5Dv0ELqosSmsSPMf5iakGgI
         a10LJ/nGnHeUBJf7EYdPQRXemru4WmQJPebsrjdXUEB+1Ua8tZibX/zkrBIBcIYA9o
         5vBM4oRDM4qnD6o5tpJIRuI/AeTFdp+F0capyD+rTMI/DjP2mczY42srq6bGppUraC
         30lefLU9VMigQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 787575C0879; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/14] rcu: Fix late wakeup when flush of bypass cblist happens
Date:   Wed, 19 Oct 2022 15:51:32 -0700
Message-Id: <20221019225144.2500095-2-paulmck@kernel.org>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

When the bypass cblist gets too big or its timeout has occurred, it is
flushed into the main cblist. However, the bypass timer is still running
and the behavior is that it would eventually expire and wake the GP
thread.

Since we are going to use the bypass cblist for lazy CBs, do the wakeup
soon as the flush for "too big or too long" bypass list happens.
Otherwise, long delays can happen for callbacks which get promoted from
lazy to non-lazy.

This is a good thing to do anyway (regardless of future lazy patches),
since it makes the behavior consistent with behavior of other code paths
where flushing into the ->cblist makes the GP kthread into a
non-sleeping state quickly.

[ Frederic Weisbecker: Changes to avoid unnecessary GP-thread wakeups plus
		    comment changes. ]

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index ce526cc2791ca..f77a6d7e13564 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -433,8 +433,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
-			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -447,7 +448,12 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		// The flush succeeded and we moved CBs into the regular list.
+		// Don't wait for the wake up timer as it may be too far ahead.
+		// Wake up the GP thread now instead, if the cblist was empty.
+		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
+
 		return true; // Callback already enqueued.
 	}
 
-- 
2.31.1.189.g2e36527f23

