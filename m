Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106F6741AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjF1VXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjF1VWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1708358D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687987022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3eqHPH2jtk9ZGDW+IjmQhCJcfivZfs/kcGLVBmAENnY=;
        b=Np/d+38taulB1M0SKI9+Wjy7bMjtXKC2HTsbjZ8x5QMRVy8FyTGc8nfzfvjJx4zA6aYmun
        v6cY9SQHiOPThLJf3UdUDF+NUl0vMXNi82zNixgNRTWDfEUenMbsD2T3GZ5hHTXsNQDuQA
        kWj7HkA2b/xcUCai6R7nxmEcmQqPRQk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-yLOE8C9UN72SkTNYt8H-zQ-1; Wed, 28 Jun 2023 17:16:58 -0400
X-MC-Unique: yLOE8C9UN72SkTNYt8H-zQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 117F01C06ED1;
        Wed, 28 Jun 2023 21:16:58 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36DF8F5CD4;
        Wed, 28 Jun 2023 21:16:57 +0000 (UTC)
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
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] sched/core: Use empty mask to reset cpumasks in sched_setaffinity()
Date:   Wed, 28 Jun 2023 17:16:37 -0400
Message-Id: <20230628211637.1679348-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), user provided CPU affinity via sched_setaffinity(2) is
perserved even if the task is being moved to a different cpuset. However,
that affinity is also being inherited by any subsequently created child
processes which may not want or be aware of that affinity.

One way to solve this problem is to provide a way to back off from
that user provided CPU affinity.  This patch implements such a scheme
by using an empty cpumask to signal a reset of the cpumasks to the
default as allowed by the current cpuset.

Before this patch, passing in an empty cpumask to sched_setaffinity(2)
will return an EINVAL error. With this patch, an error will no longer
be returned. Instead, the user_cpus_ptr that stores the user provided
affinity, if set, will be cleared and the task's CPU affinity will be
reset to that of the current cpuset. This reverts the cpumask change
done by all the previous sched_setaffinity(2) calls.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..f4806d969fc9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8317,7 +8317,12 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 	}
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+
+	/* Default to cpus_allowed with NULL new_mask */
+	if (ctx->new_mask)
+		cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+	else
+		cpumask_copy(new_mask, cpus_allowed);
 
 	ctx->new_mask = new_mask;
 	ctx->flags |= SCA_CHECK;
@@ -8366,6 +8371,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	bool reset_cpumasks = cpumask_empty(in_mask);
 	struct affinity_context ac;
 	struct cpumask *user_mask;
 	struct task_struct *p;
@@ -8403,13 +8409,23 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		goto out_put_task;
 
 	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
+	 * If an empty cpumask is passed in, clear user_cpus_ptr, if set,
+	 * and reset the current cpu affinity to the default for the
+	 * current cpuset.
 	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+	if (reset_cpumasks) {
+		in_mask = NULL;	/* To be updated in __sched_setaffinity */
+		user_mask = NULL;
+	} else {
+		/*
+		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used
+		 * and alloc_user_cpus_ptr() returns NULL.
+		 */
+		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+	}
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
-	} else if (IS_ENABLED(CONFIG_SMP)) {
+	} else if (!reset_cpumasks && IS_ENABLED(CONFIG_SMP)) {
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
-- 
2.31.1

