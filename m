Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743D462FE06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiKRTeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiKRTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9478D4B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668799999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vm4lYSuI39T5xePAN2iEqNP90UK7XrasUEw23g3xMyk=;
        b=CslY047qvblMjaIpMwnebuyi9Ml/WL7HrSs9pga0XgLwkTvMddTMZ+DQ+pOQiuC3mrRR4s
        y5gV6bNuNe2VHOvXVEESfISawSZ7Cqs60MGRvxBotic/FNXe350Ad+LBSkosJ+CA8Z1TQw
        +BwdVm6u6HzOayw/xyqdECn36A8H7hU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-a0HxK2E1MZyeMrjtuV38kw-1; Fri, 18 Nov 2022 14:33:16 -0500
X-MC-Unique: a0HxK2E1MZyeMrjtuV38kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5031385A588;
        Fri, 18 Nov 2022 19:33:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A092E140EBF3;
        Fri, 18 Nov 2022 19:33:15 +0000 (UTC)
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
Subject: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Date:   Fri, 18 Nov 2022 14:33:02 -0500
Message-Id: <20221118193302.522399-1-longman@redhat.com>
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
may not be in a context where kfree() can be safely called. So the
following splats may be printed:

   WARNING: possible circular locking dependency detected
   BUG: sleeping function called from invalid context

To avoid these problems without leaking memory, the free cpumask is now
put into a lockless list to be reused in a later sched_setaffinity()
call instead.

Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78b2d5cabcc5..8df51b08bb38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2527,6 +2527,11 @@ int push_cpu_stop(void *arg)
 	return 0;
 }
 
+/*
+ * A lockless list of user cpumask available to be reused.
+ */
+static LLIST_HEAD(free_cpumasks);
+
 /*
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
@@ -2606,7 +2611,14 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	};
 
 	__do_set_cpus_allowed(p, &ac);
-	kfree(ac.user_mask);
+	if (ac.user_mask) {
+		/*
+		 * We may not be in a context where kfree() can be called.
+		 * Put the free user_mask in free_cpumasks to be freed or
+		 * used later.
+		 */
+		llist_add((struct llist_node *)ac.user_mask, &free_cpumasks);
+	}
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
@@ -8194,7 +8206,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	struct affinity_context ac;
-	struct cpumask *user_mask;
+	struct cpumask *user_mask = NULL;
 	struct task_struct *p;
 	int retval;
 
@@ -8229,7 +8241,15 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	/*
+	 * Use the element in the free_cpumasks, if available.
+	 */
+	if (!llist_empty(&free_cpumasks))
+		user_mask = (struct cpumask *)llist_del_first(&free_cpumasks);
+
+	if (!user_mask)
+		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+
 	if (!user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
-- 
2.31.1

