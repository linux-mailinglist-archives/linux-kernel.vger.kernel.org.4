Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4667580A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjATPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjATPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D647DF96
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674226999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JV/ESkSwVKzhkko42aCx2p6hA+p3ybUeT3T+J1aTWFk=;
        b=J5ALeAYwCS0mgLtuxWdUdQcOzRVo1I/kkXGEZ2RbAKNo4WnFSaaRKCos22MUAjDwN3mnjQ
        Uclpe2zc4/YbozVzhMgM8/xco8Uw2oNJmoK0ZAazuMs/uwweHAz3ziT7C1o3U3/DE3z0aD
        za7AGfru0Jz8v/iSLYCdpkUYEpmvF9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-hTSGCuu2PG2YUUno0xEQkw-1; Fri, 20 Jan 2023 10:03:18 -0500
X-MC-Unique: hTSGCuu2PG2YUUno0xEQkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 164F8181E3F2;
        Fri, 20 Jan 2023 15:03:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69408492B02;
        Fri, 20 Jan 2023 15:03:01 +0000 (UTC)
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
        Wander Lairson Costa <wander@redhat.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Paul McKenney <paulmck@kernel.org>
Subject: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe function
Date:   Fri, 20 Jan 2023 12:02:39 -0300
Message-Id: <20230120150246.20797-2-wander@redhat.com>
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

With PREEMPT_RT, it is unsafe to call put_task_struct() in atomic
contexts because it indirectly acquires sleeping locks.

Introduce put_task_struct_atomic_safe(), which schedules
__put_task_struct() through call_rcu() when the kernel is compiled with
PREEMPT_RT.

A more natural approach would use a workqueue, but since
in PREEMPT_RT we can't allocate dynamic memory from atomic context,
the code would become more complex because we would need to put the
work_struct instance in the task_struct and initialize it when we
allocate a new task_struct.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/task.h | 21 +++++++++++++++++++++
 kernel/fork.c              |  8 ++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..80b4c5812563 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -127,6 +127,27 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
 
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
index 9f7fe3541897..3d7a4e9311b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -859,6 +859,14 @@ void __put_task_struct(struct task_struct *tsk)
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
2.39.0

