Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1C6369E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiKWT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiKWT1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:27:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAE120B2;
        Wed, 23 Nov 2022 11:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412CA61C44;
        Wed, 23 Nov 2022 19:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6030C433D6;
        Wed, 23 Nov 2022 19:27:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oxvPJ-000vzB-2V;
        Wed, 23 Nov 2022 14:27:41 -0500
Message-ID: <20221123192741.658273220@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Nov 2022 14:25:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [PATCH 1/2] tracing: Add tracing_reset_all_online_cpus_unlocked() function
References: <20221123192556.738176467@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c              | 11 ++++++++++-
 kernel/trace/trace.h              |  1 +
 kernel/trace/trace_events.c       |  2 +-
 kernel/trace/trace_events_synth.c |  2 --
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a47fed2f473..93a75a97118f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2180,10 +2180,12 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
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
@@ -2195,6 +2197,13 @@ void tracing_reset_all_online_cpus(void)
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
index d9b470a0adf2..48643f07bc01 100644
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
index 7372fffb8109..0449e3c7d327 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3039,7 +3039,7 @@ static void trace_module_remove_events(struct module *mod)
 	 * over from this module may be passed to the new module events and
 	 * unexpected results may occur.
 	 */
-	tracing_reset_all_online_cpus();
+	tracing_reset_all_online_cpus_unlocked();
 }
 
 static int trace_module_notify(struct notifier_block *self,
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 29fbfb27c2b2..c3b582d19b62 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1425,7 +1425,6 @@ int synth_event_delete(const char *event_name)
 	mutex_unlock(&event_mutex);
 
 	if (mod) {
-		mutex_lock(&trace_types_lock);
 		/*
 		 * It is safest to reset the ring buffer if the module
 		 * being unloaded registered any events that were
@@ -1437,7 +1436,6 @@ int synth_event_delete(const char *event_name)
 		 * occur.
 		 */
 		tracing_reset_all_online_cpus();
-		mutex_unlock(&trace_types_lock);
 	}
 
 	return ret;
-- 
2.35.1


