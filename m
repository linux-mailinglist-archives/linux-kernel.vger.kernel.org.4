Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59DA6BBD86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjCOTpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjCOTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF23B0F5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t9so1349914qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=208GxfDZm7oSyOpPWnvVrrbR0LSr9U2B1RRikPcTIHU=;
        b=SwfZcZz22GQ86AfZbWhrkMmC0APeen3E/TYOlJxwfPQj5qa3k998D+cUVTsr+OrgyK
         WvbfHiF17cuaKhsWGLmCE3S/m6YnKZ9M/k74AU81Siisp2uBs9tI/TxBZD5TyjWVi8wS
         x5b4+KHAhLFQQO1DjIaf7rO6WNKuOgp35UykA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=208GxfDZm7oSyOpPWnvVrrbR0LSr9U2B1RRikPcTIHU=;
        b=zRGPSlsXlFXHe8yGkQHRG1VmF5qy1VIMX/TpTLUTfnt/AERVYcDk8QBJxMBb/mndKL
         oKNvAcDozWma5k3VGFsR7L24FqWUBp0LmneiLlusb1guIUcxzIXa/ejBLbcQ1RP65848
         kxtuXmi30lGCGLCShZXJpg7GroDyD2NTcpTzEov9tLSf9icXuDxnVrFTyjifER9jt3j+
         uWx2EoXV4ozbnHdUmwYw5qAxmrajplu/j1uEzz9SrJsZpCp9MS86V+PZ0dZ4rYEiTRVd
         myRCBEUT3I726SJEUBe71a2aKt1fTHiiv+QN0yihF1sAD47xnS6Qmj141UEXKq76AhzV
         uHHQ==
X-Gm-Message-State: AO0yUKUV7tuemThZ3O973Tah0Mu4vGLk6Pk+EsS/PqAhfLtEDbalZkPj
        idHMZ7eOjAabVV5aXMhQSyqVO3qK+D1g5KvBRVA=
X-Google-Smtp-Source: AK7set+CAI/fwx2l399eAuZ9xV5Jlp4O6BubsvjdMkMS6+QB/t270bnUo23l5y+5gqaF6IPk8+QwXw==
X-Received: by 2002:ac8:5c13:0:b0:3d4:8ce9:cef7 with SMTP id i19-20020ac85c13000000b003d48ce9cef7mr2038670qti.8.1678909475786;
        Wed, 15 Mar 2023 12:44:35 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:35 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Mark Brown <broonie@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH 7/9] rcu-tasks: Report stalls during synchronize_srcu() in rcu_tasks_postscan()
Date:   Wed, 15 Mar 2023 19:43:47 +0000
Message-Id: <20230315194349.10798-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
2.40.0.rc1.284.g88254d51c5-goog

