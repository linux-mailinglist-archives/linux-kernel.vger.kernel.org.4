Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6E72D906
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbjFMFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjFMFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:20:17 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51D10DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:20:15 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-75d558c18d0so52592185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686633614; x=1689225614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGl3c9J8yc2x+Y9tCEMELC+GWzL/Lxdu0fXfos7pecw=;
        b=QAc3FJVab0ypAbq5bV+nlh486mAkqeAn8AinydV4mtFqiD/UUJlz54z8+e3DVijfwL
         I59Jl7ALQiAJYP3zNaQFayuZiTd7C9artnoYec5gZAw7xWm81BqsCOeEMTfXFG83IJnw
         7JTR/Xezpd9D80Cf+2XECrNUxV/os83+Ctp3u7RFopFIswZ9C5xKpLiYP5NKgiwHQT5n
         lRAK2HNPLF8iKwZkNscNVqZOXqLwswuSmm8yYGJbo0UAOxEZ3E8BxnelbKrOlD64XNw2
         37wRQgHMr26ra1RbU4JILCmlSItKykNoaapGqQWEprmGKybFwW1ToBEdMFbeb53mffuF
         dc8A==
X-Gm-Message-State: AC+VfDzKWLVb+/7svrDv+QwrJ+Op76Clf3SYdImY7zRCB8VtcbuB4PLe
        1pT8PoNNyZG6wCaXsVCwhKg8g8bNkbTpQMmf
X-Google-Smtp-Source: ACHHUZ6Zw00gzZpwFcd1BjNPkZ5NPpbzQQAQ3Y6qZMY25znpBMxB7VR2yE0PNzn38R6iVWJb5nZVbA==
X-Received: by 2002:ae9:edc8:0:b0:75e:c30a:81b5 with SMTP id c191-20020ae9edc8000000b0075ec30a81b5mr9130232qkg.9.1686633614231;
        Mon, 12 Jun 2023 22:20:14 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a146100b0074def53eca5sm3327657qkl.53.2023.06.12.22.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 22:20:13 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: [RFC PATCH 1/3] sched: Make migrate_task_to() take any task
Date:   Tue, 13 Jun 2023 00:20:02 -0500
Message-Id: <20230613052004.2836135-2-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613052004.2836135-1-void@manifault.com>
References: <20230613052004.2836135-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_task_to() function exposed from kernel/sched/core.c migrates
the current task, which is silently assumed to also be its first
argument, to the specified CPU. The function uses stop_one_cpu() to
migrate the task to the target CPU, which won't work if @p is not the
current task as the stop_one_cpu() callback isn't invoked on remote
CPUs.

While this operation is useful for task_numa_migrate() in fair.c, it
would be useful if __migrate_task() in core.c was given external
linkage, as it actually can be used to migrate any task to a CPU.

This patch therefore:
1. Renames the existing migrate_task_to() be called
   numa_migrate_current_task_to().
2. Renames __migrate_task() to migrate_task_to(), gives it global
   linkage, and updates all callers accordingly.

A follow-on patch will call the new migrate_task_to() from fair.c when
migrating a task in a shared wakequeue to a remote CPU.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  | 16 ++++++++--------
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac38225e6d09..d911b0631e7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2539,8 +2539,8 @@ struct set_affinity_pending {
  * So we race with normal scheduler movements, but that's OK, as long
  * as the task is no longer on this CPU.
  */
-static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
-				 struct task_struct *p, int dest_cpu)
+struct rq *migrate_task_to(struct rq *rq, struct rq_flags *rf,
+			   struct task_struct *p, int dest_cpu)
 {
 	/* Affinity changed (again). */
 	if (!is_cpu_allowed(p, dest_cpu))
@@ -2573,7 +2573,7 @@ static int migration_cpu_stop(void *data)
 	local_irq_save(rf.flags);
 	/*
 	 * We need to explicitly wake pending tasks before running
-	 * __migrate_task() such that we will not miss enforcing cpus_ptr
+	 * migrate_task_to() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
 	flush_smp_call_function_queue();
@@ -2605,12 +2605,12 @@ static int migration_cpu_stop(void *data)
 		}
 
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
+			rq = migrate_task_to(rq, &rf, p, arg->dest_cpu);
 		else
 			p->wake_cpu = arg->dest_cpu;
 
 		/*
-		 * XXX __migrate_task() can fail, at which point we might end
+		 * XXX migrate_task_to() can fail, at which point we might end
 		 * up running on a dodgy CPU, AFAICT this can only happen
 		 * during CPU hotplug, at which point we'll get pushed out
 		 * anyway, so it's probably not a big deal.
@@ -3259,7 +3259,7 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 	alloc_cpumask_var(&new_mask, GFP_KERNEL);
 
 	/*
-	 * __migrate_task() can fail silently in the face of concurrent
+	 * migrate_task_to() can fail silently in the face of concurrent
 	 * offlining of the chosen destination CPU, so take the hotplug
 	 * lock to ensure that the migration succeeds.
 	 */
@@ -9359,7 +9359,7 @@ bool sched_smp_initialized __read_mostly;
 
 #ifdef CONFIG_NUMA_BALANCING
 /* Migrate current task p to target_cpu */
-int migrate_task_to(struct task_struct *p, int target_cpu)
+int numa_migrate_current_task_to(struct task_struct *p, int target_cpu)
 {
 	struct migration_arg arg = { p, target_cpu };
 	int curr_cpu = task_cpu(p);
@@ -9439,7 +9439,7 @@ static int __balance_push_cpu_stop(void *arg)
 
 	if (task_rq(p) == rq && task_on_rq_queued(p)) {
 		cpu = select_fallback_rq(rq->cpu, p);
-		rq = __migrate_task(rq, &rf, p, cpu);
+		rq = migrate_task_to(rq, &rf, p, cpu);
 	}
 
 	rq_unlock(rq, &rf);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a45635..292c593fc84f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2278,7 +2278,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
-		ret = migrate_task_to(p, env.best_cpu);
+		ret = numa_migrate_current_task_to(p, env.best_cpu);
 		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, NULL, env.best_cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 556496c77dc2..5a86e9795731 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1718,7 +1718,7 @@ enum numa_faults_stats {
 	NUMA_CPUBUF
 };
 extern void sched_setnuma(struct task_struct *p, int node);
-extern int migrate_task_to(struct task_struct *p, int cpu);
+extern int numa_migrate_current_task_to(struct task_struct *p, int target_cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
@@ -1731,6 +1731,8 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+extern struct rq *migrate_task_to(struct rq *rq, struct rq_flags *rf,
+				  struct task_struct *p, int dest_cpu);
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct balance_callback *head,
-- 
2.40.1

