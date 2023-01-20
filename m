Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E867580D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjATPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjATPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FDB81013
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674227022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1TJWHWdZqDFCr8xEA0m937H+WTiVZmJanYCSnQgjrk=;
        b=aBw3t80SCMtSlaTEoenyoVBHtZz+Vxk9rFf7DH2Lv66xzogqsM5cjEBtW+rvh1kRa1g1LR
        3rOuEySgjIG/wSgvGemc1SpdTW3z11BQLYtsXZdkRlN+T3LwK7Tktmb7AINbZ8PTqkPohB
        i9grLRDACUvJucBwrv1JbVJf9ZE8RmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-XksM0rtCN-K57tGpGanOQQ-1; Fri, 20 Jan 2023 10:03:35 -0500
X-MC-Unique: XksM0rtCN-K57tGpGanOQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18E4F181E3EE;
        Fri, 20 Jan 2023 15:03:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B13492B02;
        Fri, 20 Jan 2023 15:03:29 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] sched/rt: use put_task_struct_atomic_safe() to avoid potential splat
Date:   Fri, 20 Jan 2023 12:02:41 -0300
Message-Id: <20230120150246.20797-4-wander@redhat.com>
In-Reply-To: <20230120150246.20797-1-wander@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rto_push_irq_work_func() is called in hardirq context, and it calls
push_rt_task(), which calls put_task_struct().

If the kernel is compiled with PREEMPT_RT and put_task_struct() reaches
zero usage count, it triggers a splat because __put_task_struct()
indirectly acquires sleeping locks.

The put_task_struct() call pairs with an earlier get_task_struct(),
which makes the probability of the usage count reaches zero pretty
low. In any case, let's play safe and use the atomic safe version.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/rt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..30a4e9607bec 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2147,7 +2147,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		/*
 		 * Something has shifted, try again.
 		 */
-		put_task_struct(next_task);
+		put_task_struct_atomic_safe(next_task);
 		next_task = task;
 		goto retry;
 	}
@@ -2160,7 +2160,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 
 	double_unlock_balance(rq, lowest_rq);
 out:
-	put_task_struct(next_task);
+	put_task_struct_atomic_safe(next_task);
 
 	return ret;
 }
-- 
2.39.0

