Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E85630DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiKSJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiKSJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:26:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57254776F1;
        Sat, 19 Nov 2022 01:26:49 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDpDv544NzRpBC;
        Sat, 19 Nov 2022 17:26:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:26:47 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:26:47 +0800
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
Subject: [PATCH v8 3/6] sched: Add helper nr_context_switches_cpu()
Date:   Sat, 19 Nov 2022 17:25:05 +0800
Message-ID: <20221119092508.1766-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221119092508.1766-1-thunder.leizhen@huawei.com>
References: <20221119092508.1766-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returns the number of context switches on the specified CPU, which can be
used to diagnose rcu stall.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/kernel_stat.h | 1 +
 kernel/sched/core.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 898076e173a928a..9935f7ecbfb9e31 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -52,6 +52,7 @@ DECLARE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 #define kstat_cpu(cpu) per_cpu(kstat, cpu)
 #define kcpustat_cpu(cpu) per_cpu(kernel_cpustat, cpu)
 
+extern unsigned long long nr_context_switches_cpu(int cpu);
 extern unsigned long long nr_context_switches(void);
 
 extern unsigned int kstat_irqs_cpu(unsigned int irq, int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3068..a0d19f67f2046d9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5229,6 +5229,11 @@ bool single_task_running(void)
 }
 EXPORT_SYMBOL(single_task_running);
 
+unsigned long long nr_context_switches_cpu(int cpu)
+{
+	return cpu_rq(cpu)->nr_switches;
+}
+
 unsigned long long nr_context_switches(void)
 {
 	int i;
-- 
2.25.1

