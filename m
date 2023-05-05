Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C46F8197
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjEELYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEELYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:24:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068501A12A;
        Fri,  5 May 2023 04:24:30 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QCSwl5bkSzpW4q;
        Fri,  5 May 2023 19:23:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:26 +0800
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
Subject: [PATCH 3/9] softirq: Factor loop termination condition
Date:   Fri, 5 May 2023 19:33:09 +0800
Message-ID: <20230505113315.3307723-4-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505113315.3307723-1-liujian56@huawei.com>
References: <20230505113315.3307723-1-liujian56@huawei.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/softirq.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 59f16a9af5d1..48a81d8ae49a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -477,22 +477,6 @@ asmlinkage __visible void do_softirq(void)
 
 #endif /* !CONFIG_PREEMPT_RT */
 
-/*
- * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
- *
- * These limits have been established via experimentation.
- * The two things to balance is latency against fairness -
- * we want to handle softirqs as soon as possible, but they
- * should not be able to lock up the box.
- */
-#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
-#define MAX_SOFTIRQ_RESTART 10
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 /*
  * When we run softirqs from irq_exit() and thus on the hardirq stack we need
@@ -526,10 +510,33 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+/*
+ * We restart softirq processing but break the loop if need_resched() is set or
+ * after 2 ms. The MAX_SOFTIRQ_RESTART guarantees a loop termination if
+ * sched_clock() were ever to stall.
+ *
+ * These limits have been established via experimentation.  The two things to
+ * balance is latency against fairness - we want to handle softirqs as soon as
+ * possible, but they should not be able to lock up the box.
+ */
+#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
+#define MAX_SOFTIRQ_RESTART	10
+
+static inline bool __softirq_needs_break(u64 start)
+{
+	if (need_resched())
+		return true;
+
+	if (sched_clock() - start >= MAX_SOFTIRQ_TIME)
+		return true;
+
+	return false;
+}
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
+	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
 	unsigned long old_flags = current->flags;
-	int max_restart = MAX_SOFTIRQ_RESTART;
 	u64 start = sched_clock();
 	struct softirq_action *h;
 	unsigned long pending;
@@ -585,8 +592,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (sched_clock() - start < MAX_SOFTIRQ_TIME && !need_resched() &&
-		    --max_restart)
+		if (!__softirq_needs_break(start) && --max_restart)
 			goto restart;
 
 		wakeup_softirqd();
-- 
2.34.1

