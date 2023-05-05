Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1B6F8190
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjEELYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEELY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:24:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094701A124;
        Fri,  5 May 2023 04:24:26 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCSsH57DqzZfkS;
        Fri,  5 May 2023 19:20:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:23 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <corbet@lwn.net>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <qiang1.zhang@intel.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <peterz@infradead.org>, <frankwoo@google.com>,
        <Rhinewuwu@google.com>
CC:     <liujian56@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH 0/9] fix softlockup in run_timer_softirq
Date:   Fri, 5 May 2023 19:33:06 +0800
Message-ID: <20230505113315.3307723-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered the run_timer_softirq lockup issue[1] many times during fuzz
tests. We analyze __run_timers() and find the following problem.

In the while loop of __run_timers(), because there are too many timers or
improper timer handler functions, if the processing time of the expired
timers is always greater than the time wheel's next_expiry, the function
will loop infinitely.

Here base on Peter's softirq_needs_break patchset[2], use the timeout/break
logic jump out of the loop.

[1] https://lore.kernel.org/lkml/fb8d80434b2148e78c0032c6c70a8b4d@huawei.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=core/softirq

Liu Jian (1):
  softirq, timer: Use softirq_needs_break()

Peter Zijlstra (8):
  softirq: Rewrite softirq processing loop
  softirq: Use sched_clock() based timeout
  softirq: Factor loop termination condition
  softirq: Allow early break
  softirq: Context aware timeout
  softirq: Provide a softirq_needs_break() API
  softirq,net: Use softirq_needs_break()
  softirq,rcu: Use softirq_needs_break()

 Documentation/admin-guide/sysctl/net.rst | 11 +--
 include/linux/interrupt.h                |  5 ++
 kernel/rcu/tree.c                        | 29 ++-----
 kernel/rcu/tree_nocb.h                   |  2 +-
 kernel/softirq.c                         | 97 +++++++++++++++---------
 kernel/time/timer.c                      | 12 ++-
 net/core/dev.c                           |  6 +-
 net/core/dev.h                           |  1 -
 net/core/sysctl_net_core.c               |  8 --
 9 files changed, 86 insertions(+), 85 deletions(-)

-- 
2.34.1

