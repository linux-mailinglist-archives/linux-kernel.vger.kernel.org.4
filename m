Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF2563B73D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiK2B20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiK2B2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:28:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357ED5C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669685243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cb+GJVP8BDbcl5LGnBLGBzwbl14EqkncZfcKi5UPOb8=;
        b=cc/t5mFOwlhemMJhjuzM7hAAy/mmKkh1WzddqI3HytktZIVP/2NcUR+h3LiDkbQVxvr0yV
        Dn9CUYWsFZQHd6K7NEr7Td53Q+9j7+eCvVeON3sv0iclEYsNHYoyfeOpbidJ7ee/mxmNPV
        GwXLJbPAQXxOxjM5Uget/0f5YP6H5tI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-zpv4IemwNFeA1UcKgd1MEg-1; Mon, 28 Nov 2022 20:27:18 -0500
X-MC-Unique: zpv4IemwNFeA1UcKgd1MEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DBC8382C966;
        Tue, 29 Nov 2022 01:27:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECB3C1410DD9;
        Tue, 29 Nov 2022 01:27:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2] sched: Use kfree_rcu() in do_set_cpus_allowed()
Date:   Mon, 28 Nov 2022 20:26:43 -0500
Message-Id: <20221129012643.1382368-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f7c5253bfd21..bf9066b4f481 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2593,6 +2593,11 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		set_next_task(rq, p);
 }
 
+union cpumask_rcuhead {
+	void *cpumask;
+	struct rcu_head rcu;
+};
+
 /*
  * Used for kthread_bind() and select_fallback_rq(), in both cases the user
  * affinity (if any) should be destroyed too.
@@ -2606,7 +2611,13 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	};
 
 	__do_set_cpus_allowed(p, &ac);
-	kfree(ac.user_mask);
+
+	/*
+	 * Because this is called with p->pi_lock held, it is not possible
+	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
+	 * kfree_rcu().
+	 */
+	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
@@ -8220,7 +8231,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	struct affinity_context ac;
 	struct cpumask *user_mask;
 	struct task_struct *p;
-	int retval;
+	int retval, size;
 
 	rcu_read_lock();
 
@@ -8253,7 +8264,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	/*
+	 * See do_set_cpus_allowed() for the rcu_head usage.
+	 */
+	size = max_t(int, cpumask_size(), sizeof(union cpumask_rcuhead));
+	user_mask = kmalloc(size, GFP_KERNEL);
 	if (!user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
-- 
2.31.1

