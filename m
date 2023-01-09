Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69066236D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjAIKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjAIKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:45:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5652615;
        Mon,  9 Jan 2023 02:45:52 -0800 (PST)
Date:   Mon, 09 Jan 2023 10:45:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673261150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPZb9ukPZTcxAtrvj1QdbsugeI7W3VLo/9zdEGtVAGw=;
        b=dH5FwsqqlyRCwg3sN9ZpbF3c+X3DE5SyVn32kURsg0bAqT5QaUKUmKbz68nhFB0kJIQHkr
        PNNQDoa4nibUmYhuHUxJd572YSSpx5gd0rGefy7lZ9esMdoM/L5qcnEWKrEnQj2kl7i7DK
        q3BhvVCAU0mE3nXTbCiH1oVlnk0ols711r3GTh7tXuqpnhW4NYsZ5tfSAIzSwYDbJrJ3dK
        mSWpNEvTon5zKxGJ8q3xlw7hqx85521MJX+lATzQ32VVSQiNQ75Pq9ck9+wcyzwb2JEYWw
        iyPrqdUFbyPG0w52mXuU1WGFoRYiWos6E/xkeIWONgNcA+jJLSjGJHAu7ZgZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673261150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPZb9ukPZTcxAtrvj1QdbsugeI7W3VLo/9zdEGtVAGw=;
        b=/G6eqSBW1UBko61m+yk6ua8qoRdcvRGfjqztX+pEu/Di6+K71vq8429WWZYK0zuc8KiF75
        OOIAOcUBed9ijDCA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Use kfree_rcu() in do_set_cpus_allowed()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221231041120.440785-3-longman@redhat.com>
References: <20221231041120.440785-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <167326114997.4906.573601630756814284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9a5418bc48babb313d2a62df29ebe21ce8c06c59
Gitweb:        https://git.kernel.org/tip/9a5418bc48babb313d2a62df29ebe21ce8c06c59
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 30 Dec 2022 23:11:20 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 11:43:23 +01:00

sched/core: Use kfree_rcu() in do_set_cpus_allowed()

Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
set. Unfortunately, some of the callers of do_set_cpus_allowed()
may have pi_lock held when calling it. So the following splats may be
printed especially when running with a PREEMPT_RT kernel:

   WARNING: possible circular locking dependency detected
   BUG: sleeping function called from invalid context

To avoid these problems, kfree_rcu() is used instead. An internal
cpumask_rcuhead union is created for the sole purpose of facilitating
the use of kfree_rcu() to free the cpumask.

Since user_cpus_ptr is not being used in non-SMP configs, the newly
introduced alloc_user_cpus_ptr() helper will return NULL in this case
and sched_setaffinity() is modified to handle this special case.

Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221231041120.440785-3-longman@redhat.com
---
 kernel/sched/core.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9f6e54..bb1ee6d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2604,9 +2604,29 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
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
@@ -2629,7 +2649,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	if (data_race(!src->user_cpus_ptr))
 		return 0;
 
-	user_mask = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
+	user_mask = alloc_user_cpus_ptr(node);
 	if (!user_mask)
 		return -ENOMEM;
 
@@ -3605,6 +3625,11 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return false;
 }
 
+static inline cpumask_t *alloc_user_cpus_ptr(int node)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_SMP */
 
 static void
@@ -8265,8 +8290,8 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
-	if (!user_mask) {
+	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+	if (IS_ENABLED(CONFIG_SMP) && !user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
