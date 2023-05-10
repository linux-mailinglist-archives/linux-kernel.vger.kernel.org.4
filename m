Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C293D6FE2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjEJRDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjEJRDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE38C4ED7;
        Wed, 10 May 2023 10:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C2564A1E;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6226C4339C;
        Wed, 10 May 2023 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738163;
        bh=877l4CUT4YO2vkuyC7nkck2lZ0w74fb2w1R/1pwbZ18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEGNa6dSoOgt9+0HxMDmt57xJjCygj0zhXTETavEwjfa3Hl7hfzFrojx5XUZ56JWy
         BUmtu6X6B45ftCN2ByBaeiYFZixPdbX4DS2ZufelFxsC04PPONnHizxSyN6TkLmQg4
         14lxT/WV7S3CxzZPcTXBz6p8mUkOxNab1JjF+0lSk4Rf6L78CxTAormgPG/TwggwV6
         WMw9BmtpOklml6aKvMh3Y3UK6aSsqBVj+IJCRL6trJclf77OeTSHKyHU1VdRBbaPpP
         G2voZG2/d28ay4Wl+zgQT9j1dECnn9SRxQkbIrw9+3+lmhz46KIqv8o8Z1oRZkTm75
         a70W2YoEFHPjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53BD2CE127D; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/8] rcu/kvfree: Invoke debug_rcu_bhead_unqueue() after checking bnode->gp_snap
Date:   Wed, 10 May 2023 10:02:38 -0700
Message-Id: <20230510170242.2187714-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
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

From: Zqiang <qiang1.zhang@intel.com>

If kvfree_rcu_bulk() sees that the required grace period has failed to
elapse, it leaks the memory because readers might still be using it.
But in that case, the debug-objects subsystem still marks the relevant
structures as having been freed, even though they are instead being
leaked.

This commit fixes this mismatch by invoking debug_rcu_bhead_unqueue()
only when we are actually going to free the objects.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7452ba97ba34..426f1f3bb5f2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2922,8 +2922,8 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 	unsigned long flags;
 	int i;
 
-	debug_rcu_bhead_unqueue(bnode);
 	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
+		debug_rcu_bhead_unqueue(bnode);
 		rcu_lock_acquire(&rcu_callback_map);
 		if (idx == 0) { // kmalloc() / kfree().
 			trace_rcu_invoke_kfree_bulk_callback(
-- 
2.40.1

