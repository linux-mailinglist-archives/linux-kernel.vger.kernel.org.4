Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1466E23BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDNM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDNM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589D6584
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681476977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWFEUBEXcCftzEc0hD+kF0Un2IVbNKstSMRg6ONrT+s=;
        b=IYIVdq5e6oJZhrn+9439dc8BsHt+FMpGmDeKGC0+sCLyS+LoG/uFgzKVrRhGtbQvKx/ST+
        FDKquLJfb5OK47hzRCRf17RGpkOpv2P9MX39xl6B6wWJFilHZ2ETL9Em8dJmA8vhPYNhfo
        y0n9djHomqmVJUdl2fXTwgDNYxaawII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-7T0V0wkQOSK6KOzPfQ9_AQ-1; Fri, 14 Apr 2023 08:56:07 -0400
X-MC-Unique: 7T0V0wkQOSK6KOzPfQ9_AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6FA185A790;
        Fri, 14 Apr 2023 12:56:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28918406AA66;
        Fri, 14 Apr 2023 12:55:59 +0000 (UTC)
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Cc:     Hu Chunyu <chuhu@redhat.com>, Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v6 2/3] sched/task: Add the put_task_struct_atomic_safe() function
Date:   Fri, 14 Apr 2023 09:55:28 -0300
Message-Id: <20230414125532.14958-3-wander@redhat.com>
In-Reply-To: <20230414125532.14958-1-wander@redhat.com>
References: <20230414125532.14958-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the possibility of indirectly acquiring sleeping locks, it is
unsafe to call put_task_struct() in atomic contexts when the kernel is
compiled with PREEMPT_RT.

To mitigate this issue, this commit introduces
put_task_struct_atomic_safe(), which schedules __put_task_struct()
through call_rcu() when PREEMPT_RT is enabled. While a workqueue would
be a more natural approach, we cannot allocate dynamic memory from
atomic context in PREEMPT_RT, making the code more complex.

This implementation ensures safe execution in atomic contexts and
avoids any potential issues that may arise from using the non-atomic
version.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Hu Chunyu <chuhu@redhat.com>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
 kernel/fork.c              |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index b597b97b1f8f..5c13b83d7008 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
 
 void put_task_struct_rcu_user(struct task_struct *task);
 
+extern void __delayed_put_task_struct(struct rcu_head *rhp);
+
+static inline void put_task_struct_atomic_safe(struct task_struct *task)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * Decrement the refcount explicitly to avoid unnecessarily
+		 * calling call_rcu.
+		 */
+		if (refcount_dec_and_test(&task->usage))
+			/*
+			 * under PREEMPT_RT, we can't call put_task_struct
+			 * in atomic context because it will indirectly
+			 * acquire sleeping locks.
+			 * call_rcu() will schedule delayed_put_task_struct_rcu()
+			 * to be called in process context.
+			 *
+			 * __put_task_struct() is called called when
+			 * refcount_dec_and_test(&t->usage) succeeds.
+			 *
+			 * This means that it can't "conflict" with
+			 * put_task_struct_rcu_user() which abuses ->rcu the same
+			 * way; rcu_users has a reference so task->usage can't be
+			 * zero after rcu_users 1 -> 0 transition.
+			 */
+			call_rcu(&task->rcu, __delayed_put_task_struct);
+	} else {
+		put_task_struct(task);
+	}
+}
+
 /* Free all architecture-specific resources held by a thread. */
 void release_thread(struct task_struct *dead_task);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 0c92f224c68c..9884794fe4b8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -854,6 +854,14 @@ void __put_task_struct(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
+void __delayed_put_task_struct(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	__put_task_struct(task);
+}
+EXPORT_SYMBOL_GPL(__delayed_put_task_struct);
+
 void __init __weak arch_task_cache_init(void) { }
 
 /*
-- 
2.39.2

