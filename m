Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580B3635FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiKWNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiKWNdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3A8B82
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669209388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hOjXEo74LMv/9JyDqLl/For3+JWaKkwN289eetN1FnE=;
        b=cLIwygiwbe+YGnzt8HztW367gHaXKiEnhgY6c0ZKPYWssbxAlXqtqRRkVz9V48JSN9pSM8
        eAnOvaqHTV3kpmZI8ocWwFigiEsAGt/eAfLWPexIBWA89ie9Dcfh4agSOdIAOJI2HsY0Oc
        zaD8B7qB6Z05BpXE1QhRrCNLOnJ2FPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-z1Aa5QxNN061Zxr5IJP3dQ-1; Wed, 23 Nov 2022 08:16:25 -0500
X-MC-Unique: z1Aa5QxNN061Zxr5IJP3dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E09B801585;
        Wed, 23 Nov 2022 13:16:24 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1165A2024CBE;
        Wed, 23 Nov 2022 13:16:24 +0000 (UTC)
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
Subject: [PATCH-tip v2] sched: Fix NULL user_cpus_ptr check in dup_user_cpus_ptr()
Date:   Wed, 23 Nov 2022 08:16:12 -0500
Message-Id: <20221123131612.914906-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, a non-null user_cpus_ptr will remain set until the task dies.
A possible exception to this is the fact that do_set_cpus_allowed()
will clear a non-null user_cpus_ptr. To allow this possible racing
condition, we need to check for NULL user_cpus_ptr under the pi_lock
before duping the user mask.

Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8df51b08bb38..6b259d9e127a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2624,8 +2624,14 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		      int node)
 {
+	cpumask_t *user_mask = NULL;
 	unsigned long flags;
 
+	/*
+	 * This check is racy and losing the race is a valid situation.
+	 * It is not worth the extra overhead of taking the pi_lock on
+	 * every fork/clone.
+	 */
 	if (!src->user_cpus_ptr)
 		return 0;
 
@@ -2633,10 +2639,23 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	if (!dst->user_cpus_ptr)
 		return -ENOMEM;
 
-	/* Use pi_lock to protect content of user_cpus_ptr */
+	/*
+	 * Use pi_lock to protect content of user_cpus_ptr
+	 *
+	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
+	 * do_set_cpus_allowed(). When this happens, we need to clear
+	 * dst->user_cpus_ptr and free the allocated memory afterward.
+	 */
 	raw_spin_lock_irqsave(&src->pi_lock, flags);
-	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	if (src->user_cpus_ptr)
+		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	else
+		swap(dst->user_cpus_ptr, user_mask);
 	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
+
+	if (unlikely(user_mask))
+		kfree(user_mask);
+
 	return 0;
 }
 
-- 
2.31.1

