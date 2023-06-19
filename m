Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA0735576
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjFSLGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjFSLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:05:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFD19B6;
        Mon, 19 Jun 2023 04:04:53 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687172692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J97AV1wbvGzM84xSecIv75HNLCdjTpNilZUb/XHuEvw=;
        b=QqOqFoJ+f1IVCZkhDbXydMy8yHrAFn9sBrzw6jE05H/dn7wihkQ9u5KWZTqZ8u7E/xDGU1
        mXti7X4JXEJxQZ5SNiQLcLJIWCokigBkNgZl0U2JSpWADD1AtjwDc6WO8knvn7nHAStomF
        WMrxPy1lHX9bFqFhmKfug/V5LZXinIM4N9QayNX83CShLHEjDgWD2bfY3WWZ0EGr6jLcr8
        QfYVQYieR/s9mSVlkMsN2Y48Ezaz2cfbrIEZem/YkSWqHCQwMR+bMORt9S0Yx1K4C0Ng8e
        mogtTxZLCwnFTbjnB+kSENqZV5E++xNgn7Uusf2Dw7gf88mFEru1jzS3vp/bIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687172692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J97AV1wbvGzM84xSecIv75HNLCdjTpNilZUb/XHuEvw=;
        b=Jqmvjs6qkWzSLcXJr40+UfI821V/Nb0EfnphKp/Ij9hP1NzOSxEnQdSrbIMr0lPDBXg+gG
        Y4R009F8AHshr9AQ==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fixed missing rq clock update before
 calling set_rq_offline()
Cc:     Ben Segall <bsegall@google.com>, Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613082012.49615-2-jiahao.os@bytedance.com>
References: <20230613082012.49615-2-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <168717269157.404.12414969911873741834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cab3ecaed5cdcc9c36a96874b4c45056a46ece45
Gitweb:        https://git.kernel.org/tip/cab3ecaed5cdcc9c36a96874b4c45056a46ece45
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Tue, 13 Jun 2023 16:20:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:12 +02:00

sched/core: Fixed missing rq clock update before calling set_rq_offline()

When using a cpufreq governor that uses
cpufreq_add_update_util_hook(), it is possible to trigger a missing
update_rq_clock() warning for the CPU hotplug path:

  rq_attach_root()
    set_rq_offline()
      rq_offline_rt()
	__disable_runtime()
	  sched_rt_rq_enqueue()
	    enqueue_top_rt_rq()
	      cpufreq_update_util()
		data->func(data, rq_clock(rq), flags)

Move update_rq_clock() from sched_cpu_deactivate() (one of it's
callers) into set_rq_offline() such that it covers all
set_rq_offline() usage.

Additionally change rq_attach_root() to use rq_lock_irqsave() so that
it will properly manage the runqueue clock flags.

Suggested-by: Ben Segall <bsegall@google.com>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20230613082012.49615-2-jiahao.os@bytedance.com
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/topology.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac38225..442efe5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9585,6 +9585,7 @@ void set_rq_offline(struct rq *rq)
 	if (rq->online) {
 		const struct sched_class *class;
 
+		update_rq_clock(rq);
 		for_each_class(class) {
 			if (class->rq_offline)
 				class->rq_offline(rq);
@@ -9726,7 +9727,6 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
-		update_rq_clock(rq);
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cb92dc5..d3a3b26 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -487,9 +487,9 @@ static void free_rootdomain(struct rcu_head *rcu)
 void rq_attach_root(struct rq *rq, struct root_domain *rd)
 {
 	struct root_domain *old_rd = NULL;
-	unsigned long flags;
+	struct rq_flags rf;
 
-	raw_spin_rq_lock_irqsave(rq, flags);
+	rq_lock_irqsave(rq, &rf);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
@@ -515,7 +515,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_rq_unlock_irqrestore(rq, flags);
+	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
