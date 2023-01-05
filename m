Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18A65E17F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbjAEAYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjAEAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E74435E;
        Wed,  4 Jan 2023 16:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A06EB8198A;
        Thu,  5 Jan 2023 00:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A1CC433A7;
        Thu,  5 Jan 2023 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878188;
        bh=Zj66HaKlbW7or4kBjbwXaM4/EWUfv7i59XPipGrmdK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulKYLo2ZelNq3JjSgOVb1UmueUei/z6vfdW5xa/K9HlH5Rsqxsctdb4/Tujqz4bh/
         SLYLIFY/7LXH42rZs2DBm8dPtZ1qhcWCwxzBEygxCyfmvOdrUWWi0K5bldjYXGM4+E
         A9qGjQEKRNTZ8DR0SNwMy2p6ZCtRikhj613LcOEgJZs0oF7I4zuX7AzlLz0qOQKgTv
         HHus1peh8fjC+fXpJ/m3aPrcp1+8W+GvMdwq4JY1CdjHAejq388N7yzHmDMQp0FWMQ
         poja+Oartem/2us8mYOzK07V7SCE79MquyoyOJ7/B4JcXdza+m7UNi7/wbrns8bgin
         VY5gly0yNjKFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 84A6B5C1C64; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/10] rcu: Remove redundant call to rcu_boost_kthread_setaffinity()
Date:   Wed,  4 Jan 2023 16:23:05 -0800
Message-Id: <20230105002305.1768591-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The rcu_boost_kthread_setaffinity() function is invoked at
rcutree_online_cpu() and rcutree_offline_cpu() time, early in the online
timeline and late in the offline timeline, respectively.  It is also
invoked from rcutree_dead_cpu(), however, in the absence of userspace
manipulations (for which userspace must take responsibility), this call
is redundant with that from rcutree_offline_cpu().  This redundancy can
be demonstrated by printing out the relevant cpumasks

This commit therefore removes the call to rcu_boost_kthread_setaffinity()
from rcutree_dead_cpu().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 80b84ae285b41..89313c7c17b62 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4076,15 +4076,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  */
 int rcutree_dead_cpu(unsigned int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
-
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
-- 
2.31.1.189.g2e36527f23

