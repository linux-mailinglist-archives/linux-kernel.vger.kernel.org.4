Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CAD6548B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiLVWuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLVWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBEE23303
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671749390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfSGkTDuYUvqeEnObzIwz3NpKprmZ2AVZdKuQbfuWHY=;
        b=KeUpT5sV7eBgKcMgeMjQLsT+bVKJC76HUSo01i0YPfBd5+OIqFX9fWSKN5+k031c1XyptF
        MD6FubjFaedr2GZimk5hpMfa/bmcpPBB01MFiwBhdr026fVSXBPAwyB1E3AI1JQjid2sef
        6/t5AkRrYo3z6ruSvpfJ4XOMJ0fGPm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-_6wmPkzhM-e504EW_7ccEw-1; Thu, 22 Dec 2022 17:49:47 -0500
X-MC-Unique: _6wmPkzhM-e504EW_7ccEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0D4D85C064;
        Thu, 22 Dec 2022 22:49:46 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457CB51EF;
        Thu, 22 Dec 2022 22:49:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        =?UTF-8?q?David=20Wang=20=E7=8E=8B=E6=A0=87?= 
        <wangbiao3@xiaomi.com>, Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/2] sched: Use kfree_rcu() in do_set_cpus_allowed()
Date:   Thu, 22 Dec 2022 17:49:37 -0500
Message-Id: <20221222224937.21028-3-longman@redhat.com>
In-Reply-To: <20221222224937.21028-1-longman@redhat.com>
References: <20221222224937.21028-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
 kernel/sched/core.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b93d030b9fd5..c2df236fd8c1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2604,9 +2604,19 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
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
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
@@ -2614,6 +2624,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 {
 	cpumask_t *user_mask;
 	unsigned long flags;
+	int size;
 
 	/*
 	 * Always clear dst->user_cpus_ptr first as their user_cpus_ptr's
@@ -2629,7 +2640,11 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	if (data_race(!src->user_cpus_ptr))
 		return 0;
 
-	user_mask = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
+	/*
+	 * See do_set_cpus_allowed() for the rcu_head usage.
+	 */
+	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
+	user_mask = kmalloc_node(size, GFP_KERNEL, node);
 	if (!user_mask)
 		return -ENOMEM;
 
@@ -8230,7 +8245,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	struct affinity_context ac;
 	struct cpumask *user_mask;
 	struct task_struct *p;
-	int retval;
+	int retval, size;
 
 	rcu_read_lock();
 
@@ -8263,7 +8278,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	/*
+	 * See do_set_cpus_allowed() for the rcu_head usage.
+	 */
+	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
+	user_mask = kmalloc(size, GFP_KERNEL);
 	if (!user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
-- 
2.31.1

