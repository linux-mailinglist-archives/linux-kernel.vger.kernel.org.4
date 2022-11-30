Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F363DCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiK3SOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiK3SNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B29862D3;
        Wed, 30 Nov 2022 10:13:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1430BB81C9B;
        Wed, 30 Nov 2022 18:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D8C433D7;
        Wed, 30 Nov 2022 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832007;
        bh=PS6L08FWflyTwRyMdRxiUT1KwyXbAuVOfA4oJ9gzHj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGXc5mgCEhUZNWYca5bydsevRHCbD4DO79w1BS8KcYR7QYHB9zGV0G0A4fauxBfHh
         5I5ab21+L/vX8s6hvLXGlgwd0x6QD9xFKdj32OX3EmAH2dB0OubMvStmc2il1CLL5/
         5kNGkiri929t2+8e/nJY9xRKK/CQnnKPpo7JIagwvvPV1Sg5h11usqvCBSoXx4QTT8
         Mk17SV3zMXp0jSFua5jMhHhUeD/tfP9/ML1pXsyw+1yPCPGlkt7Hcdtcg69ow3yryx
         ZVg/uvhtcNf9DfyZl6lNLCGc6Vz0N77HpD6iRbJquWS+tUsqHYZzjYdwAi4sXUXzTw
         xAnA0LIGox9eA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E8AC5C0BA0; Wed, 30 Nov 2022 10:13:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 05/16] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
Date:   Wed, 30 Nov 2022 10:13:14 -0800
Message-Id: <20221130181325.1012760-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This consolidates the code a bit and makes it cleaner. Functionally it
is the same.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d6e4c076b0515..213daf81c057f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  *
  * Note that this function always returns true if rhp is NULL.
  */
-static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
 				     unsigned long j, bool lazy)
 {
 	struct rcu_cblist rcl;
+	struct rcu_head *rhp = rhp_in;
 
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
@@ -345,16 +346,16 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	/*
 	 * If the new CB requested was a lazy one, queue it onto the main
-	 * ->cblist so we can take advantage of a sooner grade period.
+	 * ->cblist so that we can take advantage of the grace-period that will
+	 * happen regardless. But queue it onto the bypass list first so that
+	 * the lazy CB is ordered with the existing CBs in the bypass list.
 	 */
 	if (lazy && rhp) {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
-		rcu_cblist_enqueue(&rcl, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
-	} else {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+		rhp = NULL;
 	}
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+	WRITE_ONCE(rdp->lazy_len, 0);
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
-- 
2.31.1.189.g2e36527f23

