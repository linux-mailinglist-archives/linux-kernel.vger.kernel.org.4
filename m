Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668E750C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGLPQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjGLPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:16:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FEB1BD7;
        Wed, 12 Jul 2023 08:16:20 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R1LsR4M9JzrRhJ;
        Wed, 12 Jul 2023 23:15:39 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 23:16:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] rcu: Delete a redundant check in rcu_check_gp_kthread_starvation()
Date:   Wed, 12 Jul 2023 23:15:56 +0800
Message-ID: <20230712151557.760-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230712151557.760-1-thunder.leizhen@huawei.com>
References: <20230712151557.760-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel provides the only legal way, that is, function set_task_cpu(),
to dynamically change the value of task_cpu(p). And in which the validity
of the CPU ID is checked.
set_task_cpu():
	WARN_ON_ONCE(!cpu_online(new_cpu));
	__set_task_cpu(p, new_cpu);

Therefore, in normal cases, the value of task_cpu(gpk) is always valid.
Then for the following snippet in rcu_check_gp_kthread_starvation():
	cpu = gpk ? task_cpu(gpk) : -1;
	if (gpk) {
		if (cpu >= 0) {

The above condition "if (gpk)" already ensures that gp_kthread is created,
so the local variable 'cpu' cannot be negative here.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree_stall.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a48b..dcfaa3d5db2cbc7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -537,13 +537,11 @@ static void rcu_check_gp_kthread_starvation(void)
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
-			if (cpu >= 0) {
-				if (cpu_is_offline(cpu)) {
-					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
-				} else  {
-					pr_err("Stack dump where RCU GP kthread last ran:\n");
-					dump_cpu_task(cpu);
-				}
+			if (cpu_is_offline(cpu)) {
+				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
+			} else  {
+				pr_err("Stack dump where RCU GP kthread last ran:\n");
+				dump_cpu_task(cpu);
 			}
 			wake_up_process(gpk);
 		}
-- 
2.25.1

