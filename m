Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79AF6F819E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEELY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjEELYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:24:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE11A1C9;
        Fri,  5 May 2023 04:24:33 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCSw369jXzsR6d;
        Fri,  5 May 2023 19:22:43 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:30 +0800
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
Subject: [PATCH 6/9] softirq: Provide a softirq_needs_break() API
Date:   Fri, 5 May 2023 19:33:12 +0800
Message-ID: <20230505113315.3307723-7-liujian56@huawei.com>
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

So that all open_softirq() users can employ the same break conditions
and work off the same time-base in case of multiple pending vectors.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 include/linux/interrupt.h |  5 +++++
 kernel/softirq.c          | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..94d1047fe0c3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -584,8 +584,13 @@ extern const char * const softirq_to_name[NR_SOFTIRQS];
 struct softirq_action
 {
 	void	(*action)(struct softirq_action *);
+	u64	start;
+	u64	timo;
 };
 
+extern struct softirq_action softirq_action_now(void);
+extern bool softirq_needs_break(struct softirq_action *action);
+
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index baa08ae1604f..dc4299e40dad 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -533,6 +533,20 @@ static inline bool __softirq_needs_break(u64 start, u64 timo)
 	return false;
 }
 
+bool softirq_needs_break(struct softirq_action *h)
+{
+	return __softirq_needs_break(h->start, h->timo);
+}
+
+struct softirq_action softirq_action_now(void)
+{
+	struct softirq_action h = {
+		.start = sched_clock(),
+		.timo = MAX_SOFTIRQ_TIME,
+	};
+	return h;
+}
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
@@ -572,6 +586,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		__clear_bit(vec_nr, &pending);
 
 		h = softirq_vec + vec_nr;
+		h->start = start;
+		h->timo = timo;
 
 		prev_count = preempt_count();
 
-- 
2.34.1

