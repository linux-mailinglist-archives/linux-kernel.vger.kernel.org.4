Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11105BB230
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIPScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiIPSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E2B775E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663353155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjH1as/LDI5IJuljZ+OOdK8KpVo326IxxOG9a4w9AZY=;
        b=botAaDIN7zVrwuN6TJsrA0fmW5r4I0rpz4+jNlJufbDQEjaLJIxS8fhQwps159wh7ubb1N
        sYL2zqDEkj8+81dEVNmzeDR6rSPtjw+OZU0oYVXIoxjPXdhItw1mFbyx8pUOZykXXsBwx/
        WKjwj1GDu+zLNu/9j1akbiHqBwpgjJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-n9I3xfAlNeWQizh70neE7w-1; Fri, 16 Sep 2022 14:32:32 -0400
X-MC-Unique: n9I3xfAlNeWQizh70neE7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B66A880206D;
        Fri, 16 Sep 2022 18:32:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10AF9140EBF3;
        Fri, 16 Sep 2022 18:32:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 7/7] sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
Date:   Fri, 16 Sep 2022 14:32:17 -0400
Message-Id: <20220916183217.1172225-8-longman@redhat.com>
In-Reply-To: <20220916183217.1172225-1-longman@redhat.com>
References: <20220916183217.1172225-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The do_set_cpus_allowed() function is used by either kthread_bind() or
select_fallback_rq(). In both cases the user affinity (if any) should be
destroyed too.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ce626cad4105..a5240c603667 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2599,14 +2599,20 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		set_next_task(rq, p);
 }
 
+/*
+ * Used for kthread_bind() and select_fallback_rq(), in both cases the user
+ * affinity (if any) should be destroyed too.
+ */
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct affinity_context ac = {
 		.new_mask  = new_mask,
-		.flags     = 0,
+		.user_mask = NULL,
+		.flags     = SCA_USER,	/* clear the user requested mask */
 	};
 
 	__do_set_cpus_allowed(p, &ac);
+	kfree(ac.user_mask);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
-- 
2.31.1

