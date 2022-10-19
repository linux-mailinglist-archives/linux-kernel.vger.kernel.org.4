Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0643C605360
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiJSWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJSWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D01849BE;
        Wed, 19 Oct 2022 15:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD7BB82613;
        Wed, 19 Oct 2022 22:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4999C433D6;
        Wed, 19 Oct 2022 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=zhI+nSG0LEQR2PAAAvwCyyYQdtfxOPlUmkdh0E4iu6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ie/0CtZv4oEdoViQqjdmdwAOkuUbEniXSDznUSiM+fM8btdjJ+wZZM2Nh2vOHGJBK
         kuQUWupa2Mqkf1yLJFOutIuIHllryTzfrPxQyLNBM4qdYDtaHkftNSP3NVz68HSGB0
         IIUB+ijLG9OUCiSW8lCz5etbYQY3MHEHNmg0wwb/8d5S9ximif6nNJQpgMmBPNNZZP
         tS8EnPBF1QFqoIJD96pTmSVl2edtkzBI6abWSzoYOroWhUZhPPIYAcKUWvpNyH43vD
         9iuN2l8GfB7H79el4Pi63Mw0C+d6nAORSLbaPu0MJXOakr8ZDhujDXh/SPrsKFgKBH
         YlnijjYTyPRSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A6FAF5C0879; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Pingfan Liu <kernelfans@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/8] rcu: Synchronize ->qsmaskinitnext in rcu_boost_kthread_setaffinity()
Date:   Wed, 19 Oct 2022 15:46:53 -0700
Message-Id: <20221019224659.2499511-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
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

From: Pingfan Liu <kernelfans@gmail.com>

Once either rcutree_online_cpu() or rcutree_dead_cpu() is invoked
concurrently, the following rcu_boost_kthread_setaffinity() race can
occur:

        CPU 1                               CPU2
mask = rcu_rnp_online_cpus(rnp);
...

                                   mask = rcu_rnp_online_cpus(rnp);
                                   ...
                                   set_cpus_allowed_ptr(t, cm);

set_cpus_allowed_ptr(t, cm);

This results in CPU2's update being overwritten by that of CPU1, and
thus the possibility of ->boost_kthread_task continuing to run on a
to-be-offlined CPU.

This commit therefore eliminates this race by relying on the pre-existing
acquisition of ->boost_kthread_mutex to serialize the full process of
changing the affinity of ->boost_kthread_task.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e3142ee35fc6a..7b0fe741a0886 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1221,11 +1221,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * We don't include outgoingcpu in the affinity set, use -1 if there is
  * no outgoing CPU.  If there are no CPUs left in the affinity set,
  * this function allows the kthread to execute on any CPU.
+ *
+ * Any future concurrent calls are serialized via ->boost_kthread_mutex.
  */
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 	struct task_struct *t = rnp->boost_kthread_task;
-	unsigned long mask = rcu_rnp_online_cpus(rnp);
+	unsigned long mask;
 	cpumask_var_t cm;
 	int cpu;
 
@@ -1234,6 +1236,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
 	mutex_lock(&rnp->boost_kthread_mutex);
+	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
-- 
2.31.1.189.g2e36527f23

