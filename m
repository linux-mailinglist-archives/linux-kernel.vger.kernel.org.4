Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AE71804E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjEaMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbjEaMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:49:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A680128
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2eMIcUWTYRxHYeCUlMm6R4u+dyrFJONAkwQnAOCUvFo=; b=IAexiwHhA6DsahLOAZx44wTyAI
        htsLvETjs7HgIeYzogrv3uVeL0nbYfwKHMSe2Ie/LSiyhRv0398pKkirB6YvC5L7KD5/UO0q9f6pT
        uYo6rfkQ8WSLvFmVgxw6kfwmrgNFFj5IA/+Nvxe5YDZD6mhoZ5Ybe7vo4EaYL0M4GRHKEMia38ULQ
        CjFgKr4YMEv0gYHHR+3/1k5udY9e6N6xTu5FPZMYp9wWJ9d7JjVvls9r9s1VeByY5EsH3b7eMuDef
        FP4lh+FQs1QldUrCIUjEYyYJTpP47Tx7e/e7A8+7gGDMOlQLFU9KJMy6O7PJX4Z3GAajlB/77E2H/
        F0vtY5qg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEq-00FSLI-0V;
        Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91570300E3F;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 17AEC22BA645D; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.410388887@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:51 +0200
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
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        Parth Shah <parth@linux.ibm.com>
Subject: [RFC][PATCH 12/15] sched: Introduce latency-nice as a per-task attribute
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Latency-nice indicates the latency requirements of a task with respect
to the other tasks in the system. The value of the attribute can be within
the range of [-20, 19] both inclusive to be in-line with the values just
like task nice values.

Just like task nice, -20 is the 'highest' priority and conveys this
task should get minimal latency, conversely 19 is the lowest priority
and conveys this task will get the least consideration and will thus
receive maximal latency.

[peterz: rebase, squash]
Signed-off-by: Parth Shah <parth@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h            |    1 +
 include/uapi/linux/sched.h       |    4 +++-
 include/uapi/linux/sched/types.h |   19 +++++++++++++++++++
 init/init_task.c                 |    3 ++-
 kernel/sched/core.c              |   27 ++++++++++++++++++++++++++-
 kernel/sched/debug.c             |    1 +
 tools/include/uapi/linux/sched.h |    4 +++-
 7 files changed, 55 insertions(+), 4 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -791,6 +791,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_prio;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE		0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -10,6 +10,7 @@ struct sched_param {
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
+#define SCHED_ATTR_SIZE_VER2	60	/* add: latency_nice */
 
 /*
  * Extended scheduling parameters data structure.
@@ -98,6 +99,22 @@ struct sched_param {
  * scheduled on a CPU with no more capacity than the specified value.
  *
  * A task utilization boundary can be reset by setting the attribute to -1.
+ *
+ * Latency Tolerance Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the relative latency
+ * requirements of a task with respect to the other tasks running/queued in the
+ * system.
+ *
+ * @ sched_latency_nice	task's latency_nice value
+ *
+ * The latency_nice of a task can have any value in a range of
+ * [MIN_LATENCY_NICE..MAX_LATENCY_NICE].
+ *
+ * A task with latency_nice with the value of LATENCY_NICE_MIN can be
+ * taken for a task requiring a lower latency as opposed to the task with
+ * higher latency_nice.
  */
 struct sched_attr {
 	__u32 size;
@@ -120,6 +137,8 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* latency requirement hints */
+	__s32 sched_latency_nice;
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_prio	= DEFAULT_PRIO,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
@@ -89,7 +90,7 @@ struct task_struct init_task
 		.fn = do_no_restart_syscall,
 	},
 	.se		= {
-		.group_node 	= LIST_HEAD_INIT(init_task.se.group_node),
+		.group_node	= LIST_HEAD_INIT(init_task.se.group_node),
 	},
 	.rt		= {
 		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4719,6 +4719,8 @@ int sched_fork(unsigned long clone_flags
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_prio = NICE_TO_PRIO(0);
+
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -7477,7 +7479,7 @@ static struct task_struct *find_process_
 #define SETPARAM_POLICY	-1
 
 static void __setscheduler_params(struct task_struct *p,
-		const struct sched_attr *attr)
+				  const struct sched_attr *attr)
 {
 	int policy = attr->sched_policy;
 
@@ -7501,6 +7503,13 @@ static void __setscheduler_params(struct
 	set_load_weight(p, true);
 }
 
+static void __setscheduler_latency(struct task_struct *p,
+				   const struct sched_attr *attr)
+{
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
+		p->latency_prio = NICE_TO_PRIO(attr->sched_latency_nice);
+}
+
 /*
  * Check the target process has a UID that matches the current process's:
  */
@@ -7641,6 +7650,13 @@ static int __sched_setscheduler(struct t
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		if (attr->sched_latency_nice > MAX_NICE)
+			return -EINVAL;
+		if (attr->sched_latency_nice < MIN_NICE)
+			return -EINVAL;
+	}
+
 	if (pi)
 		cpuset_read_lock();
 
@@ -7675,6 +7691,9 @@ static int __sched_setscheduler(struct t
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
+		    attr->sched_latency_nice != PRIO_TO_NICE(p->latency_prio))
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -7763,6 +7782,7 @@ static int __sched_setscheduler(struct t
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
+	__setscheduler_latency(p, attr);
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
@@ -7973,6 +7993,9 @@ static int sched_copy_attr(struct sched_
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
 
+	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
+	    size < SCHED_ATTR_SIZE_VER2)
+		return -EINVAL;
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -8210,6 +8233,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
+	kattr.sched_latency_nice = PRIO_TO_NICE(p->latency_prio);
+
 #ifdef CONFIG_UCLAMP_TASK
 	/*
 	 * This could race with another potential updater, but this is fine
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1085,6 +1085,7 @@ void proc_sched_show_task(struct task_st
 #endif
 	P(policy);
 	P(prio);
+	P(latency_prio);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE		0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */


