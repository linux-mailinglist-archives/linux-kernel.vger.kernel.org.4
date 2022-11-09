Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6060262272E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiKIJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKIJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:38:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EB26DD;
        Wed,  9 Nov 2022 01:38:26 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6fyw1FCFzHvkk;
        Wed,  9 Nov 2022 17:38:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:38:24 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:38:24 +0800
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
Subject: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
Date:   Wed, 9 Nov 2022 17:37:36 +0800
Message-ID: <20221109093739.187-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
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

v5 --> v6:
1. When there are more than two continuous RCU stallings, correctly handle the
   value of the second and subsequent sampling periods. Update comments and
   document.
   Thanks to Elliott, Robert for the test.
2. Change "rcu stall" to "RCU stall".

v4 --> v5:
1. Resolve a git am conflict. No code change.

v3 --> v4:
1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.

v2 --> v3:
1. Fix the return type of kstat_cpu_irqs_sum()
2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
   rcupdate.rcu_cpu_stall_deep_debug.
3. Add comments and normalize local variable name


v1 --> v2:
1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
   kcpustat_this_cpu cannot be used.
@@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
        if (r->gp_seq != rdp->gp_seq)
                return;

-       cpustat = kcpustat_this_cpu->cpustat;
+       cpustat = kcpustat_cpu(cpu).cpustat;
2. Move the start point of statistics from rcu_stall_kick_kthreads() to
   rcu_implicit_dynticks_qs(), removing the dependency on irq_work.

v1:
In some extreme cases, such as the I/O pressure test, the CPU usage may
be 100%, causing RCU stall. In this case, the printed information about
current is not useful. Displays the number and usage of hard interrupts,
soft interrupts, and context switches that are generated within half of
the CPU stall timeout, can help us make a general judgment. In other
cases, we can preliminarily determine whether an infinite loop occurs
when local_irq, local_bh or preempt is disabled.

Zhen Lei (2):
  rcu: Add RCU stall diagnosis information
  doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information

 Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  6 ++
 kernel/rcu/Kconfig.debug                      | 11 +++
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/tree.c                             | 17 ++++
 kernel/rcu/tree.h                             | 19 ++++
 kernel/rcu/tree_stall.h                       | 29 ++++++
 kernel/rcu/update.c                           |  2 +
 8 files changed, 173 insertions(+)

-- 
2.25.1

