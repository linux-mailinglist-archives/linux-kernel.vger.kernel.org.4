Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9247D5BB231
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIPSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIPSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9BFB7756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663353155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+PEuxHCi+ATSWjwodTYHg19fW+xLGaox+jYGObcwjs=;
        b=R5m03Ml6RI9X4E4Akzepr4KknHBtBKazf/2dHE6+ah9YZqTHGI7QbwEip8nySKwubkslca
        Ydyec8mKRBWgOlxFPTIwYoqrx3ojKqkz0fM9CAt6ymDpvZO/tNWXmI+y43o3pJblR5D5J/
        XWoexWIYM2yOGS18aKjx39V/Oidg+K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-Oq0xZ-C2MairowVbc7yeXA-1; Fri, 16 Sep 2022 14:32:31 -0400
X-MC-Unique: Oq0xZ-C2MairowVbc7yeXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04EEF862FDC;
        Fri, 16 Sep 2022 18:32:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54AF3140EBF5;
        Fri, 16 Sep 2022 18:32:30 +0000 (UTC)
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
Subject: [PATCH v9 6/7] sched: Fix sched_setaffinity() and fork/clone() race
Date:   Fri, 16 Sep 2022 14:32:16 -0400
Message-Id: <20220916183217.1172225-7-longman@redhat.com>
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

sched_setaffinity() can also race with a concurrent fork/clone() syscall
calling dup_user_cpus_ptr(). That may lead to a use after free problem.
Fix that by protecting the cpumask copying using pi_lock of the source
task.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c748e56ba254..ce626cad4105 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2612,6 +2612,8 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		      int node)
 {
+	unsigned long flags;
+
 	if (!src->user_cpus_ptr)
 		return 0;
 
@@ -2619,7 +2621,10 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	if (!dst->user_cpus_ptr)
 		return -ENOMEM;
 
+	/* Use pi_lock to protect content of user_cpus_ptr */
+	raw_spin_lock_irqsave(&src->pi_lock, flags);
 	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
 	return 0;
 }
 
-- 
2.31.1

