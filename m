Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5676C8FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjCYRej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjCYReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62AEF81
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a5so4504568qto.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDgsb2d+hZmc+VQbS7ffR7EbpJzTOYghTZrLGYmTtWc=;
        b=jhaF7jMZ0YB7rLiRDFZrRklRXt1OS7zPKXAlOrC6Ofk00510pCD4FnDFVqfLxhpUjD
         BgjbV9/qa/zMtSEVZ9i8O8NwPGlXueA5d8pnRbjRaOifUjtUqVzrrbg4wXpX7QQON0Ga
         h2cXsbZfUrcDoLDyKLO+AqiHanYO7hZFWtMyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDgsb2d+hZmc+VQbS7ffR7EbpJzTOYghTZrLGYmTtWc=;
        b=8H2J6UvxKzQ93HcuDsCJtDMntn6PBbTMp8qWY4bX/oaGi4lL208vf4CtGWEtp41GWl
         PnUielnDXc0VYC8R9aUFkKqndj/YrT/vSDxfnPjgChXCflNsl0Y7d7cfk9MRRWMFCx7S
         63xmFMk44HIy1a6BQTH7DTDf13feru2YTepJDmlrK+cZWTKH9obqf/APRgyu3HnIs3Zj
         PQLAhs521cQ5fkdcEJhEbf+Vtmy+i+whWbMTcOCqjPuL7f7+4rP2oXr3hGM4XcratE/I
         zWR+/x1G5Di3JBk6qMuQPJfMGgQm55VzVdR+G6P5BMwnPhj4i9ZJ5X5QIftC25ruV1nA
         ZbzQ==
X-Gm-Message-State: AO0yUKVDpcNbnsiUWYZPpwJ0Ns+sV5sxtivEl1tKVBDcvtXe5eXq1Bkp
        r5q1f05TFYV96z65xUXusjzv/UYY8PgS1/vaHfM=
X-Google-Smtp-Source: AKy350ZKIT2t3gxR4Zylf8zYlF3puKJt9xTfHezSW7rx/lBHNOBE+j7Z/Q9dY0lrU51bFaQa0S0IRA==
X-Received: by 2002:ac8:5755:0:b0:3e1:7465:91f5 with SMTP id 21-20020ac85755000000b003e1746591f5mr12423604qtx.10.1679765644872;
        Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH v2 11/13] rcu-tasks: Report stalls during synchronize_srcu() in rcu_tasks_postscan()
Date:   Sat, 25 Mar 2023 17:33:14 +0000
Message-Id: <20230325173316.3118674-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

The call to synchronize_srcu() from rcu_tasks_postscan() can be stalled
by a task getting stuck in do_exit() between that function's calls to
exit_tasks_rcu_start() and exit_tasks_rcu_finish().   To ease diagnosis
of this situation, print a stall warning message every rcu_task_stall_info
period when rcu_tasks_postscan() is stalled.

[ paulmck: Adjust to handle CONFIG_SMP=n. ]

Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/rcu/20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1/
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tasks.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bfb5e1549f2b..baf7ec178155 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -139,6 +139,12 @@ static struct rcu_tasks rt_name =							\
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
+#ifdef CONFIG_TASKS_RCU
+/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
+static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
+static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
+#endif
+
 /* Avoid IPIing CPUs early in the grace period. */
 #define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
 static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
@@ -830,6 +836,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
+	int rtsi = READ_ONCE(rcu_task_stall_info);
+
+	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
+		tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
+		add_timer(&tasks_rcu_exit_srcu_stall_timer);
+	}
+
 	/*
 	 * Exiting tasks may escape the tasklist scan. Those are vulnerable
 	 * until their final schedule() with TASK_DEAD state. To cope with
@@ -848,6 +861,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * call to synchronize_rcu().
 	 */
 	synchronize_srcu(&tasks_rcu_exit_srcu);
+
+	if (!IS_ENABLED(CONFIG_TINY_RCU))
+		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
 }
 
 /* See if tasks are still holding out, complain if so. */
@@ -923,6 +939,21 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
+static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
+{
+#ifndef CONFIG_TINY_RCU
+	int rtsi;
+
+	rtsi = READ_ONCE(rcu_task_stall_info);
+	pr_info("%s: %s grace period number %lu (since boot) gp_state: %s is %lu jiffies old.\n",
+		__func__, rcu_tasks.kname, rcu_tasks.tasks_gp_seq,
+		tasks_gp_state_getname(&rcu_tasks), jiffies - rcu_tasks.gp_jiffies);
+	pr_info("Please check any exiting tasks stuck between calls to exit_tasks_rcu_start() and exit_tasks_rcu_finish()\n");
+	tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
+	add_timer(&tasks_rcu_exit_srcu_stall_timer);
+#endif // #ifndef CONFIG_TINY_RCU
+}
+
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
-- 
2.40.0.348.gf938b09366-goog

