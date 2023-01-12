Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FA6676B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbjALOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjALOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:33:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302215B151
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:25:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vm8so45155461ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3+BrBUxQnYkGxjstTVVMr58Pod5wj5L4LOq9dJdnfLI=;
        b=LljAZMCyUX53tPkPqaYKiBqfIZEodEXSf4AQQ7t3cGEVJwfrLzh68ORX/7k+wTTfU6
         7BtMmbi5/1PeecvSPQwGa4mg3wgds/Qv/cG3elqk3vYQkIDLpxkE7OS4zknfE8CpWPpn
         +EnNc/+NUqbI+6robPoj6sYISNyZZ/W5O9W+b/Fa5ECgLfXo7Fali3QZN1iDmdGaYNJ0
         1WP/3S1d3DOG9/bgwbxpViZogLhPubgx/t1I56RDvMsWck1f1RJDMB70oAqblnC/fv3E
         Q+KbLjmCYgEF8bPGxsPJGA0gJp2wfwCmDSjeGOCmif93lbMzS89d44ZYeG5dOUYGu9UT
         MZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+BrBUxQnYkGxjstTVVMr58Pod5wj5L4LOq9dJdnfLI=;
        b=iQ2eHYVP2wREWzHumAa/VqXaoe50XAgKRoy3smW1jkMPRbVZuLZYOJAigmeGMC6Qn4
         n5Iu4Ss2A4kaPVQppKJJkYLeXUeQlPsFcwnS14TsNuVrt1AiOtricFi7+A7DzvJ1kfMl
         yLiCycvHHtCirINhgCDPmXLkYudYV9WsZ4qUiGpcAm/YhcdfthGf7D6k6QAXfkyCAcQJ
         rKAqNRobFKXOERCPy6CeE9CAGg+g0A1oOUFezE7s3JOBT2M3sFjuShh8CeYYGzHiDhRw
         7DXcgQY5FnAG1rC8Gs8yiXTy5CVMpr3StgnrA/lIk6ECnvZCKA8xZ6VAYK4MRWDCfQxx
         usSg==
X-Gm-Message-State: AFqh2kr/zDlLMWQbwIQxzEWw5v/hZaRNdX9JQI2zbwkLZUERjnXaJbTJ
        UxNyaNXT1eBaERtGv1VgG2M=
X-Google-Smtp-Source: AMrXdXusDmRSKTbsfO5Ie3X61McUbHUdC7grK0egl7ZUnsQazlmbyiXAh8xaWZH99PYI9RV+FuXE/A==
X-Received: by 2002:a17:907:9625:b0:7ad:9455:d57d with SMTP id gb37-20020a170907962500b007ad9455d57dmr74612097ejc.74.1673533533746;
        Thu, 12 Jan 2023 06:25:33 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm7436252ejf.210.2023.01.12.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:25:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Jan 2023 15:25:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Y8AYWxzqkoKQfgV9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-01-12

   # HEAD: 9a5418bc48babb313d2a62df29ebe21ce8c06c59 sched/core: Use kfree_rcu() in do_set_cpus_allowed()

- Fix scheduler frequency invariance bug related to overly long tickless periods
  triggering an integer overflow and disabling the feature.

- Fix use-after-free bug in dup_user_cpus_ptr().

- Fix do_set_cpus_allowed() deadlock scenarios related to calling kfree() with
  the pi_lock held. NOTE: the rcu_free() is the 'lazy' solution here - we looked
  at patches to free the structure after the pi_lock got dropped, but that looked
  quite a bit messier - and none of this is truly performance critical. We can
  revisit this if it's too lazy of a solution ...

 Thanks,

	Ingo

------------------>
Waiman Long (2):
      sched/core: Fix use-after-free bug in dup_user_cpus_ptr()
      sched/core: Use kfree_rcu() in do_set_cpus_allowed()

Yair Podemsky (1):
      sched/core: Fix arch_scale_freq_tick() on tickless systems


 kernel/sched/core.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b6ee5f..bb1ee6d7bdde 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2604,27 +2604,71 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		.user_mask = NULL,
 		.flags     = SCA_USER,	/* clear the user requested mask */
 	};
+	union cpumask_rcuhead {
+		cpumask_t cpumask;
+		struct rcu_head rcu;
+	};
 
 	__do_set_cpus_allowed(p, &ac);
-	kfree(ac.user_mask);
+
+	/*
+	 * Because this is called with p->pi_lock held, it is not possible
+	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
+	 * kfree_rcu().
+	 */
+	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
+}
+
+static cpumask_t *alloc_user_cpus_ptr(int node)
+{
+	/*
+	 * See do_set_cpus_allowed() above for the rcu_head usage.
+	 */
+	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
+
+	return kmalloc_node(size, GFP_KERNEL, node);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		      int node)
 {
+	cpumask_t *user_mask;
 	unsigned long flags;
 
-	if (!src->user_cpus_ptr)
+	/*
+	 * Always clear dst->user_cpus_ptr first as their user_cpus_ptr's
+	 * may differ by now due to racing.
+	 */
+	dst->user_cpus_ptr = NULL;
+
+	/*
+	 * This check is racy and losing the race is a valid situation.
+	 * It is not worth the extra overhead of taking the pi_lock on
+	 * every fork/clone.
+	 */
+	if (data_race(!src->user_cpus_ptr))
 		return 0;
 
-	dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
-	if (!dst->user_cpus_ptr)
+	user_mask = alloc_user_cpus_ptr(node);
+	if (!user_mask)
 		return -ENOMEM;
 
-	/* Use pi_lock to protect content of user_cpus_ptr */
+	/*
+	 * Use pi_lock to protect content of user_cpus_ptr
+	 *
+	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
+	 * do_set_cpus_allowed().
+	 */
 	raw_spin_lock_irqsave(&src->pi_lock, flags);
-	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	if (src->user_cpus_ptr) {
+		swap(dst->user_cpus_ptr, user_mask);
+		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	}
 	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
+
+	if (unlikely(user_mask))
+		kfree(user_mask);
+
 	return 0;
 }
 
@@ -3581,6 +3625,11 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return false;
 }
 
+static inline cpumask_t *alloc_user_cpus_ptr(int node)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_SMP */
 
 static void
@@ -5504,7 +5553,9 @@ void scheduler_tick(void)
 	unsigned long thermal_pressure;
 	u64 resched_latency;
 
-	arch_scale_freq_tick();
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+		arch_scale_freq_tick();
+
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
@@ -8239,8 +8290,8 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
-	if (!user_mask) {
+	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+	if (IS_ENABLED(CONFIG_SMP) && !user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
