Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B665E150
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjAEALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjAEAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667A744347;
        Wed,  4 Jan 2023 16:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8D83B81984;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC8C433AC;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=C6HzkjFAA72iQ6ev+Vk91gXKITUtU7V20ZYXLoH/gA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIiqFL1tgkDtve0tSWcO9gciiwj029HJ1kZkVPw0gOpLA2IlP/PHZvBrND3zXB18l
         P/adILooJ5HQY8ScS9AD8Y2M95QfEj7CuCJRkJgnhf3Gr8ajx5FP46jSzCoyAcce9Y
         Vo699GpNpct5W6G15CRLwmctBsXMSq46A5zTGu8O8Uh1ZfCPb0VaH9Iwi31ZJPp+C7
         X/1ylbNo9a0WIPXAQ1N5Qvex8j+pxxgBusof6vWO9ccycjs5FUdOsaa8+IOUCS3pJg
         MpCAxDUy/ELJMB2NW3hoiozlWgAzcdlb6m2nA+pXyAdxLoU9tUl5OJWTXKH3B7RwLB
         u1sUXNyTpZ0fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D85835C1C78; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/15] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
Date:   Wed,  4 Jan 2023 16:09:52 -0800
Message-Id: <20230105000955.1767218-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

This commit documents the additional RCU CPU stall warning output
produced by kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted
with rcupdate.rcu_cpu_stall_cputime=1.

[ paulmck: Apply wordsmithing. ]

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 88 +++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index dfa4db8c0931e..c1e92dfef40d5 100644
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
+:<------------first timeout---------->:<-----second timeout----->:
+:<--half timeout-->:<--half timeout-->:                          :
+:                  :<--first period-->:                          :
+:                  :<-----------second sampling period---------->:
+:                  :                  :                          :
+:          snapshot time point    1st-stall                  2nd-stall
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
2.31.1.189.g2e36527f23

