Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDA61F7A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiKGPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiKGPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:30:44 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF713D1C;
        Mon,  7 Nov 2022 07:30:42 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5ZtY5CcGz15MPT;
        Mon,  7 Nov 2022 23:30:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:30:39 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:30:39 +0800
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
Subject: [PATCH] rcu: Illustrate the stall information of CONFIG_RCU_CPU_STALL_CPUTIME=y
Date:   Mon, 7 Nov 2022 23:29:35 +0800
Message-ID: <20221107152935.167-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describes how to quickly determine the RCU stall fault type based on the
extra output information during CONFIG_RCU_CPU_STALL_CPUTIME=y.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/RCU/stallwarn.rst | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index dfa4db8c0931eaf..40748bff8b8186e 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -390,3 +390,59 @@ for example, "P3421".
 
 It is entirely possible to see stall warnings from normal and from
 expedited grace periods at about the same time during the same run.
+
+RCU_CPU_STALL_CPUTIME
+=====================
+If CONFIG_RCU_CPU_STALL_CPUTIME=y or rcupdate.rcu_cpu_stall_cputime=1,
+some statistics related to interrupts and tasks are shown additionally
+as follows:
+rcu:          hardirqs   softirqs   csw/system
+rcu:  number:      624         45            0
+rcu: cputime:       69          1         2425   ==> 2500(ms)
+
+These statistics are collected in the second half of the rcu stall
+timeout. The values in row "number:" are the number of hard interrupts,
+number of soft interrupts, and number of context switches. The values in
+row "cputime:" are the cputime of hard interrupts, cputime of soft
+interrupts, cputime of tasks, and sampling period. Because user-mode tasks
+do not cause rcu stall, these tasks can only be kernel tasks, that's why
+only the cputime of system are considered.
+
+The following describes four typical scenarios:
+1. A CPU looping with interrupts disabled.
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:        0          0            0
+   rcu: cputime:        0          0            0   ==> 2500(ms)
+   The start time of the interrupt processing is marked when the handler
+   is entered, and the end time is marked when the handler is exited. The
+   cputime of hard interrupts is zero because the current processing time
+   of current interrupt has not been calculated. Since the irq is disabled,
+   all other counts must be zero in the second half of rcu stall timeout.
+
+2. A CPU looping with bottom halves disabled.
+   Similar to the former, but the number and cputime of hard interrupts
+   are non-zero.
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:      624          0            0
+   rcu: cputime:       49          0         2446   ==> 2500(ms)
+   The cputime of system is non-zero, so local_bh_disable() is called in
+   current task. Otherwise, the cputime of softirqs should be non-zero.
+   Note, in this case, the number of soft interrupts is always zero.
+
+3. A CPU looping with preemption disabled.
+   The number and cputime of hard interrupts and soft interrupts are all
+   non-zero. Only the number of context switches is zero.
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:      624         45            0
+   rcu: cputime:       69          1         2425   ==> 2500(ms)
+
+4. No looping, but massive hard and soft interrupts.
+   rcu:          hardirqs   softirqs   csw/system
+   rcu:  number:       xx         xx            0
+   rcu: cputime:       xx         xx            0   ==> 2500(ms)
+   The number and cputime of hard interrupts are all non-zero. The number
+   of context switches and the cputime of system are zero. The number and
+   cputime of soft interrupts depends on the cputime of hard interrupts,
+   either all zeros or all non-zeros.
+   If it can be reproduced, cat /proc/interrupts or write code to trace
+   each interrupt by referring to show_interrupts().
-- 
2.25.1

