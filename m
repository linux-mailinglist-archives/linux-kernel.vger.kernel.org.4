Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC1F686343
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBAKBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjBAKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:00:55 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4AE32517
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:00:52 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:49242.919551229
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id C7CAB1002AE;
        Wed,  1 Feb 2023 18:00:49 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-5cf44cb88-lf9qz with ESMTP id 2a85ec2559e34408a72b32d4ebc4d7fa for mingo@redhat.com;
        Wed, 01 Feb 2023 18:00:50 CST
X-Transaction-ID: 2a85ec2559e34408a72b32d4ebc4d7fa
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kernel/sched/core: adjust rt_priority accordingly when prio is changed
Date:   Wed,  1 Feb 2023 18:01:20 +0800
Message-Id: <1675245680-2811-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a high priority process is acquiring a rtmutex which is held by a
low priority process, the latter's priority will be boosted up by calling
rt_mutex_setprio->__setscheduler_prio.

However, p->prio is changed but p->rt_priority is not, as a result, the
equation between prio and rt_priority is broken, which is:

	prio = MAX_RT_PRIO - 1 - rt_priority

It's confusing to the user when it calls sched_getparam, which only
returns rt_priority.

This patch addresses this issue by adjusting rt_priority according to
the new value of prio, what's more, it also returns normal_prio for
CFS processes instead of just a zero.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/sched/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb1ee6d7bdde..1c2c4ada08cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6933,14 +6933,16 @@ EXPORT_SYMBOL(default_wake_function);
 
 static void __setscheduler_prio(struct task_struct *p, int prio)
 {
+	p->prio = prio;
+
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
-	else if (rt_prio(prio))
+	else if (rt_prio(prio)) {
+		p->rt_priority = MAX_RT_PRIO - 1 - prio;
 		p->sched_class = &rt_sched_class;
+	}
 	else
 		p->sched_class = &fair_sched_class;
-
-	p->prio = prio;
 }
 
 #ifdef CONFIG_RT_MUTEXES
@@ -8058,6 +8060,8 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 
 	if (task_has_rt_policy(p))
 		lp.sched_priority = p->rt_priority;
+	else
+		lp.sched_priority = normal_prio(p);
 	rcu_read_unlock();
 
 	/*
-- 
2.25.1

