Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562175E6A40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiIVSCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiIVSBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C23AA4C4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663869674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7F5jNXOig7p4gZdg2FFWDOqFX0Eoffdyr2osFUuJU4=;
        b=LaVbi0xeMzwFfI8DJItalVrfzghvtsnJhxnLNn0x5DCEO1+10fYkNwQy+fxTHswIFsmMm0
        ZaUXbf4VXiEKuGL2Cic2WIVVHU3tGdc1Ni1+aQ9JqcQyojHFe6jtQZ2Z8KfwE9Fqb/tZxO
        wukLoeJ8Vte4cIdAi0ZjfglyimBOC2o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-F4yJqfX3NfaHkY9kTKG-NA-1; Thu, 22 Sep 2022 14:01:10 -0400
X-MC-Unique: F4yJqfX3NfaHkY9kTKG-NA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CB431C160C4;
        Thu, 22 Sep 2022 18:01:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8EB0140EBF5;
        Thu, 22 Sep 2022 18:01:08 +0000 (UTC)
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
Subject: [PATCH v10 1/5] sched: Add __releases annotations to affine_move_task()
Date:   Thu, 22 Sep 2022 14:00:37 -0400
Message-Id: <20220922180041.1768141-2-longman@redhat.com>
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

affine_move_task() assumes task_rq_lock() has been called and it does
an implicit task_rq_unlock() before returning. Add the appropriate
__releases annotations to make this clear.

A typo error in comment is also fixed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..b351e6d173b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2696,6 +2696,8 @@ void release_user_cpus_ptr(struct task_struct *p)
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
 			    int dest_cpu, unsigned int flags)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
@@ -3005,7 +3007,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 
 /*
  * Restrict the CPU affinity of task @p so that it is a subset of
- * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
+ * task_cpu_possible_mask() and point @p->user_cpus_ptr to a copy of the
  * old affinity mask. If the resulting mask is empty, we warn and walk
  * up the cpuset hierarchy until we find a suitable mask.
  */
-- 
2.31.1

