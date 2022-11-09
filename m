Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC862272F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiKIJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKIJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:38:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E56E5F8C;
        Wed,  9 Nov 2022 01:38:28 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6fz93D0WzmVjL;
        Wed,  9 Nov 2022 17:38:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:38:26 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:38:25 +0800
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
Subject: [PATCH v6 2/2] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
Date:   Wed, 9 Nov 2022 17:37:38 +0800
Message-ID: <20221109093739.187-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221109093739.187-1-thunder.leizhen@huawei.com>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
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

This commit doucments how to quickly determine the bug causing a given
RCU CPU stall fault warning based on the output information provided
by CONFIG_RCU_CPU_STALL_CPUTIME=y.

[ paulmck: Apply wordsmithing. ]

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 88 +++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index dfa4db8c0931eaf..5e24e849290a286 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -390,3 +390,91 @@ for example, "P3421".
 
 It is entirely possible to see stall warnings from normal and from
 expedited grace periods at about the same time during the same run.
+
+RCU_CPU_STALL_CPUTIME
+=====================
+
+In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
+rcupdate.rcu_cpu_stall_cputime=1, the following additional information
+is supplied with each RCU CPU stall warning::
+
+rcu:          hardirqs   softirqs   csw/system
+rcu:  number:      624         45            0
+rcu: cputime:       69          1         2425   ==> 2500(ms)
+
+These statistics are collected during the sampling period. The values
+in row "number:" are the number of hard interrupts, number of soft
+interrupts, and number of context switches on the stalled CPU. The
+first three values in row "cputime:" indicate the CPU time in
+milliseconds consumed by hard interrupts, soft interrupts, and tasks
+on the stalled CPU.  The last number is the measurement interval, again
+in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
+stalls, these tasks are typically kernel tasks, which is why only the
+system CPU time are considered.
+
+The sampling period is shown as follows:
+|<------------first timeout---------->|<-----second timeout----->|
+|<--half timeout-->|<--half timeout-->|                          |
+|                  |<--first period-->|                          |
+|                  |<-----------second sampling period---------->|
+|                  |                  |                          |
+|          sampling time point    1st-stall                  2nd-stall
+
+
+The following describes four typical scenarios:
+
+1. A CPU looping with interrupts disabled.::
+
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:        0          0            0
+   rcu: cputime:        0          0            0   ==> 2500(ms)
+
+   Because interrupts have been disabled throughout the measurement
+   interval, there are no interrupts and no context switches.
+   Furthermore, because CPU time consumption was measured using interrupt
+   handlers, the system CPU consumption is misleadingly measured as zero.
+   This scenario will normally also have "(0 ticks this GP)" printed on
+   this CPU's summary line.
+
+2. A CPU looping with bottom halves disabled.
+
+   This is similar to the previous example, but with non-zero number of
+   and CPU time consumed by hard interrupts, along with non-zero CPU
+   time consumed by in-kernel execution.::
+
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:      624          0            0
+   rcu: cputime:       49          0         2446   ==> 2500(ms)
+
+   The fact that there are zero softirqs gives a hint that these were
+   disabled, perhaps via local_bh_disable().  It is of course possible
+   that there were no softirqs, perhaps because all events that would
+   result in softirq execution are confined to other CPUs.  In this case,
+   the diagnosis should continue as shown in the next example.
+
+3. A CPU looping with preemption disabled.
+
+   Here, only the number of context switches is zero.::
+
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:      624         45            0
+   rcu: cputime:       69          1         2425   ==> 2500(ms)
+
+   This situation hints that the stalled CPU was looping with preemption
+   disabled.
+
+4. No looping, but massive hard and soft interrupts.::
+
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:       xx         xx            0
+   rcu: cputime:       xx         xx            0   ==> 2500(ms)
+
+   Here, the number and CPU time of hard interrupts are all non-zero,
+   but the number of context switches and the in-kernel CPU time consumed
+   are zero. The number and cputime of soft interrupts will usually be
+   non-zero, but could be zero, for example, if the CPU was spinning
+   within a single hard interrupt handler.
+
+   If this type of RCU CPU stall warning can be reproduced, you can
+   narrow it down by looking at /proc/interrupts or by writing code to
+   trace each interrupt, for example, by referring to show_interrupts().
-- 
2.25.1

