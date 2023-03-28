Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18B6CBD23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC1LIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjC1LHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F87EF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gcokwTRoOXLfqm29bKIdOPIEzWft2hYogOiPRUmi49Q=; b=GHYFFKG+BT1DHI9SlCIGz8zxDc
        2kXPnZJYPtx2muz2w2qSiBeNG8N/tAEOKjBxQAbnkSvYkpe0ZaB0b1byfaq6NaUnYeHKPtgK856bb
        YwAYiu+kEQlUHYO2xWsCeFpSXJ2ePf8TFnKwDoH5sDY+M9+SyBZ7QcFNAQceUMKcCUAjHvRd7BWCA
        XagdPMn6pzTa0rJfabE5TI738QcqLeuLybgBxIJ1piFFvFW9p5Bu2OhCCIxfnHGVI860767LdOxYp
        ZA0sz/fT8UltwflDRD17LdiZbu0HtenSRsn0fbL6CHfhxho24HQeuAGp+Uzzm7y2H+QlkQK4mwc8Y
        Eza4jXxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79k-008MD1-Pu; Tue, 28 Mar 2023 11:06:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5BE1300747;
        Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AA1012CB8CEB4; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110353.711028613@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 02/17] sched/fair: Add latency_offset
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>


Murdered-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h |    2 ++
 kernel/sched/core.c   |   12 +++++++++++-
 kernel/sched/fair.c   |    8 ++++++++
 kernel/sched/sched.h  |    2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -568,6 +568,8 @@ struct sched_entity {
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
 #endif
+	/* preemption offset in ns */
+	long				latency_offset;
 
 #ifdef CONFIG_SMP
 	/*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1285,6 +1285,11 @@ static void set_load_weight(struct task_
 	}
 }
 
+static void set_latency_offset(struct task_struct *p)
+{
+	p->se.latency_offset = calc_latency_offset(p->latency_prio - MAX_RT_PRIO);
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4433,6 +4438,8 @@ static void __sched_fork(unsigned long c
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
+	set_latency_offset(p);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
@@ -4685,6 +4692,7 @@ int sched_fork(unsigned long clone_flags
 		set_load_weight(p, false);
 
 		p->latency_prio = NICE_TO_PRIO(0);
+		set_latency_offset(p);
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -7457,8 +7465,10 @@ static void __setscheduler_params(struct
 static void __setscheduler_latency(struct task_struct *p,
 				   const struct sched_attr *attr)
 {
-	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
 		p->latency_prio = NICE_TO_PRIO(attr->sched_latency_nice);
+		set_latency_offset(p);
+	}
 }
 
 /*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -703,6 +703,14 @@ int sched_update_scaling(void)
 }
 #endif
 
+long calc_latency_offset(int prio)
+{
+	u32 weight = sched_prio_to_weight[prio];
+	u64 base = sysctl_sched_min_granularity;
+
+	return div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
+}
+
 /*
  * delta /= w
  */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2475,6 +2475,8 @@ extern unsigned int sysctl_numa_balancin
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
+extern long calc_latency_offset(int prio);
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*


