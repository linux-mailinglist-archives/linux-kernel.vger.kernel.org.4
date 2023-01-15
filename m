Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDB66B3A8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAOTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAOTcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895C1043D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673811114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n4CmZaji8pvUDHfO+vX/Yeim0zrM+XTxLdvKCeZYpj4=;
        b=EU7HwaZirpFq5imgm+AMXOr/WV5N8QZm3XHD/lwuCItmrlN6g7+WtHyINrAfbO5KgcB0LS
        2BjefrFOpBdmOPejRnvpjrhn9e3yfmz8gxO94TSc1mYfVwca3thapiNloxaEfoRAHqgRkB
        Wc4F5rq5XBf/tiUjP5xVZlDO/pR/LJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-fovxcWLvNXa81h4NKpYbBw-1; Sun, 15 Jan 2023 14:31:53 -0500
X-MC-Unique: fovxcWLvNXa81h4NKpYbBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75D6801779;
        Sun, 15 Jan 2023 19:31:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5321121314;
        Sun, 15 Jan 2023 19:31:52 +0000 (UTC)
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
Cc:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] sched/core: Fix NULL pointer access fault in sched_setaffinity() with non-SMP configs
Date:   Sun, 15 Jan 2023 14:31:22 -0500
Message-Id: <20230115193122.563036-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb1ee6d7bdde..e838feb6adc5 100644
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
-- 
2.31.1

