Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997960536A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiJSWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiJSWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B2181CB1;
        Wed, 19 Oct 2022 15:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A17D619E8;
        Wed, 19 Oct 2022 22:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC79DC433D7;
        Wed, 19 Oct 2022 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219906;
        bh=KTUh/BBOVf/jDi48jtrSyvr3uGxVW8ae61JQrk9NyJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMnspMzNjGvI3eZcJ9PJnKKYTgCQgWhpSkDUKzx4lmQ5tOQf3lVjsfp2BOtXzL5Gk
         vu0dEyFrZXgwafcYKYjpu0Y27GSxwm1KKhl3FjaFKv5nuABUfkhHjkjKQWSxRZkYCb
         HM2E+cqEyFrqiVfSRTvAYhMOlQMtpcmVKbH/iXfmSW3CCCIwZCp1cWnsYvQsWOUF2B
         0qr9TT+Yzb8/ra4woz0xMTP5HazBmWakNQyf1nDfed3yguzWkgUCFzQAy36bhMDgAp
         OWwQm2ASc6yz6oYl5r1Ue7kMaR5Xdx9A/4UK+jvcTo6GWYkT3b0z5I2amWSrjauGKx
         fxXkLf+1pzVRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 756C85C06B4; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/14] rcu: Simplify rcu_init_nohz() cpumask handling
Date:   Wed, 19 Oct 2022 15:51:31 -0700
Message-Id: <20221019225144.2500095-1-paulmck@kernel.org>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
Except that kernels booted without the rcu_nocbs= will not have
allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
its need_rcu_nocb_mask and offload_all local variables to track the
rcu_nocb and nohz_full state.

But there is a much simpler approach, namely creating a cpumask pointer
to track the default and then using cpumask_available() to check the
rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
and shortening the rcu_init_nohz() function.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef414845..ce526cc2791ca 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1210,45 +1210,33 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
-	bool offload_all = false;
 	struct rcu_data *rdp;
-
-#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
-	if (!rcu_state.nocb_is_setup) {
-		need_rcu_nocb_mask = true;
-		offload_all = true;
-	}
-#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
+	const struct cpumask *cpumask = NULL;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
-		need_rcu_nocb_mask = true;
-		offload_all = false; /* NO_HZ_FULL has its own mask. */
-	}
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+		cpumask = tick_nohz_full_mask;
+#endif
+
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) &&
+	    !rcu_state.nocb_is_setup && !cpumask)
+		cpumask = cpu_possible_mask;
 
-	if (need_rcu_nocb_mask) {
+	if (cpumask) {
 		if (!cpumask_available(rcu_nocb_mask)) {
 			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
 				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
 				return;
 			}
 		}
+
+		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
 		rcu_state.nocb_is_setup = true;
 	}
 
 	if (!rcu_state.nocb_is_setup)
 		return;
 
-#if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running)
-		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
-
-	if (offload_all)
-		cpumask_setall(rcu_nocb_mask);
-
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.31.1.189.g2e36527f23

