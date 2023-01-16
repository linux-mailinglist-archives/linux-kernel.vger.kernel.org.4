Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC366B9FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjAPJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjAPJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:14:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320B1449A;
        Mon, 16 Jan 2023 01:13:49 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:13:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673860426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qu6T2u5QqV7NYrJSK3GWcl2n1qPVAedbnw8VqSw0zo=;
        b=4t7EmSf+VAT3JNrKRA/Xvo3fty/takKYhaYWFobK2aVwWhkuDaHFzMQLMhiCD63n41JW77
        ElsPWsZ3aKIZgzRTsmFFKewGuvjGrvet4LcKZrYWYTK97xrjtM8XxPAO3EM4eFrlO6yJ3A
        dy+0KWGJStK3MZzyPf+kgHQSkxtFJKY16FSDX6JS+t6hNIpOZ+7AqyoCzCmM18dxpz4H93
        szwjvkh4ISNzZWaLq+kFGvK48/6MsENEQP200vDSJtacE7ED/pjymI5OwtI7wgKvXZCP0/
        WFf/QHxMKUeEw+Zv8mBNoXZyJBPjUr7AavPTVzADYYtLNKhEGkJb/ICiKa13tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673860426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qu6T2u5QqV7NYrJSK3GWcl2n1qPVAedbnw8VqSw0zo=;
        b=vgiajWa2Qz0uwLOlzJgiVMjvanUyYX1tuflE3rsXS7WrCqlmZR/mI8cectZUBoFyAUMCfe
        WpeVKQFp2ZNCoMCQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix NULL pointer access fault in
 sched_setaffinity() with non-SMP configs
Cc:     kernel test robot <yujie.liu@intel.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230115193122.563036-1-longman@redhat.com>
References: <20230115193122.563036-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <167386042602.4906.3347789446999182606.tip-bot2@tip-bot2>
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

Commit-ID:     5657c116783545fb49cd7004994c187128552b12
Gitweb:        https://git.kernel.org/tip/5657c116783545fb49cd7004994c187128552b12
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Sun, 15 Jan 2023 14:31:22 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Jan 2023 10:07:25 +01:00

sched/core: Fix NULL pointer access fault in sched_setaffinity() with non-SMP configs

The kernel commit 9a5418bc48ba ("sched/core: Use kfree_rcu() in
do_set_cpus_allowed()") introduces a bug for kernels built with non-SMP
configs. Calling sched_setaffinity() on such a uniprocessor kernel will
cause cpumask_copy() to be called with a NULL pointer leading to general
protection fault. This is not really a problem in real use cases as
there aren't that many uniprocessor kernel configs in use and calling
sched_setaffinity() on such a uniprocessor system doesn't make sense.

Fix this problem by making sure cpumask_copy() will not be called in
such a case.

Fixes: 9a5418bc48ba ("sched/core: Use kfree_rcu() in do_set_cpus_allowed()")
Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230115193122.563036-1-longman@redhat.com
---
 kernel/sched/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb1ee6d..e838feb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8290,12 +8290,18 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
+	/*
+	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
+	 * alloc_user_cpus_ptr() returns NULL.
+	 */
 	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (IS_ENABLED(CONFIG_SMP) && !user_mask) {
+	if (user_mask) {
+		cpumask_copy(user_mask, in_mask);
+	} else if (IS_ENABLED(CONFIG_SMP)) {
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
-	cpumask_copy(user_mask, in_mask);
+
 	ac = (struct affinity_context){
 		.new_mask  = in_mask,
 		.user_mask = user_mask,
