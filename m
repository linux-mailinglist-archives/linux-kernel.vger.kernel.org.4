Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093DF5E6A49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiIVSC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiIVSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F75C106A05
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663869679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjH1as/LDI5IJuljZ+OOdK8KpVo326IxxOG9a4w9AZY=;
        b=aHsUuqhfoAibGET++6zD4obQaocTBUbPnhEen9pz8jGrcZH2n2gWm34cmzb8PdR+dn08zn
        6kc1CG5QVB+w6EAFGNOYuQxeINTF0raguFIyN8BqRbXkSFdKfzbWY4J1dDq+C7btTwWwi1
        alEubJaqn9cR93f9K1MKzfY0TdsVNao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-zvgp1i1GPuGFUduITcUBkw-1; Thu, 22 Sep 2022 14:01:13 -0400
X-MC-Unique: zvgp1i1GPuGFUduITcUBkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50C60101E14E;
        Thu, 22 Sep 2022 18:01:12 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3063140EBF4;
        Thu, 22 Sep 2022 18:01:11 +0000 (UTC)
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
Subject: [PATCH v10 5/5] sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
Date:   Thu, 22 Sep 2022 14:00:41 -0400
Message-Id: <20220922180041.1768141-6-longman@redhat.com>
In-Reply-To: <20220922180041.1768141-1-longman@redhat.com>
References: <20220922180041.1768141-1-longman@redhat.com>
MIME-Version: 1.0
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

