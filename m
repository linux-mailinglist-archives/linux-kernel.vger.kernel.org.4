Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1763444F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiKVTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiKVTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243B88F8B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669144035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EdhjQKV+ZzYu+PMSguTcq06YsxJdSb6Km7Bwb+5zyus=;
        b=fw2579WgS8pqmua8csJ2z+dhBoXe2hsxJhX892kAOGfW8KSa3YoBSiB9ChPQO3wRVCAoxL
        vNQaZgCNLUERVUTLTj2OMBom7VdSUSr2ErzbpLSY8oUsYeExDH2wuqMJWvugU5P8So6GqE
        +R9AJqwRTpJVD0L90DO/slr+G/3BdRM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-y6aAC1uTNdCLD6k0LmOdjw-1; Tue, 22 Nov 2022 14:07:11 -0500
X-MC-Unique: y6aAC1uTNdCLD6k0LmOdjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 941F83826A44;
        Tue, 22 Nov 2022 19:07:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E82D11415102;
        Tue, 22 Nov 2022 19:07:09 +0000 (UTC)
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
Subject: [PATCH] sched: Fix NULL user_cpus_ptr check in dup_user_cpus_ptr()
Date:   Tue, 22 Nov 2022 14:06:53 -0500
Message-Id: <20221122190653.818506-1-longman@redhat.com>
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
index 8df51b08bb38..f447a6285ea2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2625,7 +2625,14 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		      int node)
 {
 	unsigned long flags;
+	cpumask_t *user_mask = NULL;
 
+	/*
+	 * If there is a concurrent sched_setaffinity(), we may miss the
+	 * newly updated user_cpus_ptr. However, a non-NULL user_cpus_ptr
+	 * is relatively unlikely and it is not worth the extra overhead
+	 * of taking the pi_lock on every fork/clone.
+	 */
 	if (!src->user_cpus_ptr)
 		return 0;
 
@@ -2633,10 +2640,22 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	if (!dst->user_cpus_ptr)
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

