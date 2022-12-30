Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330CB6599BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiL3Pdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3Pd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5711B1E2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672414361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feZ5hwjDZqG9+vMkKLDMh4mCqDRJ9BgRHgD4LRZUVhU=;
        b=buPEZ12kDLPYAN+vwxdP0jF7FJgxiLdspEG3jinG1CxSEKkk4cXb2mh6cD9Pl+cNfG02lw
        9PwSd8xbtf1Ln1N5hzXlBZ/zP3u6o30xxyf3eSCCG9ImrTBGoEwCChs4SrsL2VIBDrFiAf
        LM/a0XSDR+mW7ECuMdQ/vk300T7/pRg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-8UIeCCqsOZWYN3Xstv0c3Q-1; Fri, 30 Dec 2022 10:32:38 -0500
X-MC-Unique: 8UIeCCqsOZWYN3Xstv0c3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47DAF1C05EB9;
        Fri, 30 Dec 2022 15:32:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0B6F40C2005;
        Fri, 30 Dec 2022 15:32:36 +0000 (UTC)
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
Subject: [PATCH v5 2/2] sched: Use kfree_rcu() in do_set_cpus_allowed()
Date:   Fri, 30 Dec 2022 10:32:18 -0500
Message-Id: <20221230153218.354214-3-longman@redhat.com>
In-Reply-To: <20221230153218.354214-1-longman@redhat.com>
References: <20221230153218.354214-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
 kernel/sched/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b93d030b9fd5..31a14650bd7e 100644
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
 
@@ -8263,7 +8283,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
 	if (!user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
-- 
2.31.1

