Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8916EE12D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjDYLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjDYLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF3468A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682423027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFQziVpAX6XaFGXqO40sBdWG90AbxvK36TAoQxxNkWo=;
        b=GgepjmAX5XZDbs2iWgz7WO0AkEgp8pYpWEMR9O3VbW1AkBDyFdMZgLMXklCB2lXg6P3adW
        BoKM+yBR7X8jQR3blI0qJyOgCc/+x0A05Q4xxUoFykYISnuk795v+n0G/HbwqPUD75GpMW
        9x88WOx7UYQ119qagw5NU1xvrKE+0SQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-UQkMa4ztO0O8A3npY_Q1aA-1; Tue, 25 Apr 2023 07:43:43 -0400
X-MC-Unique: UQkMa4ztO0O8A3npY_Q1aA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5506F1C08786;
        Tue, 25 Apr 2023 11:43:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A307C15BA0;
        Tue, 25 Apr 2023 11:43:35 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v7 1/3] sched/core: warn on call put_task_struct in invalid context
Date:   Tue, 25 Apr 2023 08:43:01 -0300
Message-Id: <20230425114307.36889-2-wander@redhat.com>
In-Reply-To: <20230425114307.36889-1-wander@redhat.com>
References: <20230425114307.36889-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under PREEMPT_RT, spinlocks become sleepable locks. put_task_struct()
indirectly acquires a spinlock. Therefore, it can't be called in
atomic/interrupt context in RT kernels.

To prevent such conditions, add a check for atomic/interrupt context
before calling put_task_struct().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched/task.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..b597b97b1f8f 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -113,14 +113,28 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
 
 extern void __put_task_struct(struct task_struct *t);
 
+#define PUT_TASK_RESCHED_OFFSETS \
+	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
+
+#define __put_task_might_resched() \
+	__might_resched(__FILE__, __LINE__, PUT_TASK_RESCHED_OFFSETS)
+
+#define put_task_might_resched()			\
+	do {						\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))	\
+			__put_task_might_resched();	\
+	} while (0)
+
 static inline void put_task_struct(struct task_struct *t)
 {
+	put_task_might_resched();
 	if (refcount_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
 
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
+	put_task_might_resched();
 	if (refcount_sub_and_test(nr, &t->usage))
 		__put_task_struct(t);
 }
-- 
2.40.0

