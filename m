Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799EE63DCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiK3SOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiK3SNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66DD862D4;
        Wed, 30 Nov 2022 10:13:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F407CE1ACC;
        Wed, 30 Nov 2022 18:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAC0C433D6;
        Wed, 30 Nov 2022 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832007;
        bh=KTUh/BBOVf/jDi48jtrSyvr3uGxVW8ae61JQrk9NyJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8Ib8dqo0tM2ZZX1nN5aPSqBIQqvc+AFNKQ9RXDNJHY7jdtD5p70hLzIGA+ZplQn9
         yNjVd3NK9aPO965vSs9Vxf2u7XONZv0fe7n09XoPaKp9RIKv91a7/I0AQ7kSthytkW
         Tr4sLMqh6hy03j1NuMEVmSvUV4p4Aw6Ers1Xb9d3m4edfqbeNf2K1i1k8peYxz+01m
         jFywHwADwCLsnoEfQDXsnQSZERbTmMKe26WKNqh7Ivr5ZSmu4LY07LmV0OSh36uYm2
         5yRt7Xd0DlSZXIHyPtgMwz20ir1LCys0eIY5urJHAQqB9g80LnsUGhlFagIHmTJKtZ
         eZ52DRv0AsnUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 558095C051C; Wed, 30 Nov 2022 10:13:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/16] rcu: Simplify rcu_init_nohz() cpumask handling
Date:   Wed, 30 Nov 2022 10:13:10 -0800
Message-Id: <20221130181325.1012760-1-paulmck@kernel.org>
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

