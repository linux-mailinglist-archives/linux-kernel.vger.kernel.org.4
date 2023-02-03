Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88AB68A17A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjBCSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2CA9D4F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675448356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XdOFGLSYUsJ/RKKJ+NOOdsDiamKhjLHpPH6mDK28tTE=;
        b=NtzTvAYHjdR4SCB913ZO7C/5QabgNtsPUS75VZzxCUuRNujUaLa4OzLcNxWsWbUof5ztfE
        URMkP3mEQE+hzRtQOchk7CU0sqKrDv1qMvbAEQRvja0X7R1qs4LmsSgiBJJw3wwQdZVlPx
        0S/sHRoHvQocaKReC3VG6RcivMQBndg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-oBDmnYVFOhu8k3uWohsoqw-1; Fri, 03 Feb 2023 13:19:06 -0500
X-MC-Unique: oBDmnYVFOhu8k3uWohsoqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01B7380610C;
        Fri,  3 Feb 2023 18:19:05 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC77053AA;
        Fri,  3 Feb 2023 18:19:04 +0000 (UTC)
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
        Will Deacon <will@kernel.org>
Cc:     Phil Auld <pauld@redhat.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] sched/core: Fix a missed update of user_cpus_ptr
Date:   Fri,  3 Feb 2023 13:18:49 -0500
Message-Id: <20230203181849.221943-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), a successful call to sched_setaffinity() should always save
the user requested cpu affinity mask in a task's user_cpus_ptr. However,
when the given cpu mask is the same as the current one, user_cpus_ptr
is not updated. Fix this by saving the user mask in this case too.

Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30d9752e2ca5..91255f791df3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2951,8 +2951,11 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	}
 
 	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
-		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
+		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
+			if (ctx->flags & SCA_USER)
+				swap(p->user_cpus_ptr, ctx->user_mask);
 			goto out;
+		}
 
 		if (WARN_ON_ONCE(p == current &&
 				 is_migration_disabled(p) &&
-- 
2.31.1

