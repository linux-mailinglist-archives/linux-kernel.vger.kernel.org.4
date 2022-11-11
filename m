Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968B9625B02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiKKNIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKKNH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:07:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3B88550;
        Fri, 11 Nov 2022 05:07:51 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7zWb2VBDzHvDF;
        Fri, 11 Nov 2022 21:07:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 21:07:49 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 21:07:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH v7 6/6] rcu: Align the output of RCU stall
Date:   Fri, 11 Nov 2022 21:07:09 +0800
Message-ID: <20221111130709.247-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221111130709.247-1-thunder.leizhen@huawei.com>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time stamps is added to the output when CONFIG_PRINTK_TIME=y, which
will cause the alignment function to fail. So replace pr_cont() with
pr_err(), which also decouples the printing of subfunctions.

Before:
[   37.567343] rcu: INFO: rcu_preempt self-detected stall on CPU
[   37.567839] rcu:     0-....: (1500 ticks this GP) idle=***
[   37.568270]  (t=1501 jiffies g=4717 q=28 ncpus=4)
[   37.568668] CPU: 0 PID: 313 Comm: test0 Not tainted 6.1.0-rc4 #8

After:
[   36.762074] rcu: INFO: rcu_preempt self-detected stall on CPU
[   36.762543] rcu:     0-....: (1499 ticks this GP) idle=***
[   36.763003] rcu:     (t=1500 jiffies g=5097 q=27 ncpus=4)
[   36.763522] CPU: 0 PID: 313 Comm: test0 Not tainted 6.1.0-rc4 #9

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a91e844872e59d2..9dc76ba28d372e9 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -619,7 +619,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
+	pr_err("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
 	       smp_processor_id(), (long)(jiffies - gps),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
 	if (ndetected) {
@@ -680,7 +680,7 @@ static void print_cpu_stall(unsigned long gps)
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
+	pr_err("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
 		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
 
-- 
2.25.1

