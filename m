Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC01735894
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFSNar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjFSNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:30:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2C1A4;
        Mon, 19 Jun 2023 06:30:41 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ql9Zg5ZdFzLmq5;
        Mon, 19 Jun 2023 21:28:43 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 21:30:39 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <zhengyejian1@huawei.com>
Subject: [PATCH 5.15] tracing: Add tracing_reset_all_online_cpus_unlocked() function
Date:   Tue, 20 Jun 2023 09:30:52 +0800
Message-ID: <20230620013052.1127047-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

commit e18eb8783ec4949adebc7d7b0fdb65f65bfeefd9 upstream.

Currently the tracing_reset_all_online_cpus() requires the
trace_types_lock held. But only one caller of this function actually has
that lock held before calling it, and the other just takes the lock so
that it can call it. More users of this function is needed where the lock
is not held.

Add a tracing_reset_all_online_cpus_unlocked() function for the one use
case that calls it without being held, and also add a lockdep_assert to
make sure it is held when called.

Then have tracing_reset_all_online_cpus() take the lock internally, such
that callers do not need to worry about taking it.

Link: https://lkml.kernel.org/r/20221123192741.658273220@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

[Refers to commit message of 417d5ea6e735e5d88ffb6c436cf2938f3f476dd1,
this patch is pre-depended, and tracing_reset_all_online_cpus() should
be called after trace_types_lock is held as its comment describes.]
Fixes: 417d5ea6e735 ("tracing: Free buffers when a used dynamic event is removed")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c              | 11 ++++++++++-
 kernel/trace/trace.h              |  1 +
 kernel/trace/trace_events.c       |  2 +-
 kernel/trace/trace_events_synth.c |  2 --
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f8b5abd6e36c..0202f23ae960 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2175,10 +2175,12 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
 }
 
 /* Must have trace_types_lock held */
-void tracing_reset_all_online_cpus(void)
+void tracing_reset_all_online_cpus_unlocked(void)
 {
 	struct trace_array *tr;
 
+	lockdep_assert_held(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (!tr->clear_trace)
 			continue;
@@ -2190,6 +2192,13 @@ void tracing_reset_all_online_cpus(void)
 	}
 }
 
+void tracing_reset_all_online_cpus(void)
+{
+	mutex_lock(&trace_types_lock);
+	tracing_reset_all_online_cpus_unlocked();
+	mutex_unlock(&trace_types_lock);
+}
+
 /*
  * The tgid_map array maps from pid to tgid; i.e. the value stored at index i
  * is the tgid last observed corresponding to pid=i.
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 66b6c8395fbc..2c3d9b6ce148 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -580,6 +580,7 @@ int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
+void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1aadc9a6487b..160298d285c0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2974,7 +2974,7 @@ static void trace_module_remove_events(struct module *mod)
 	 * over from this module may be passed to the new module events and
 	 * unexpected results may occur.
 	 */
-	tracing_reset_all_online_cpus();
+	tracing_reset_all_online_cpus_unlocked();
 }
 
 static int trace_module_notify(struct notifier_block *self,
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2fdf3fd591e1..08c7df42ade7 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1416,7 +1416,6 @@ int synth_event_delete(const char *event_name)
 	mutex_unlock(&event_mutex);
 
 	if (mod) {
-		mutex_lock(&trace_types_lock);
 		/*
 		 * It is safest to reset the ring buffer if the module
 		 * being unloaded registered any events that were
@@ -1428,7 +1427,6 @@ int synth_event_delete(const char *event_name)
 		 * occur.
 		 */
 		tracing_reset_all_online_cpus();
-		mutex_unlock(&trace_types_lock);
 	}
 
 	return ret;
-- 
2.25.1

