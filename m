Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049063B28E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiK1TwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiK1Tv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:51:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6B2CC94
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:51:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C28B61416
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E2FC433C1;
        Mon, 28 Nov 2022 19:51:52 +0000 (UTC)
Date:   Mon, 28 Nov 2022 14:51:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 6.1
Message-ID: <20221128145150.02fd60e2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing fixes for 6.1:

- Fix osnoise duration type to 64bit not 32bit.

- Have histogram triggers be able to handle an unexpected NULL pointer
  for the record event, that can happen when the histogram first starts up.

- Clear out ring buffers when dynamic events are removed, as the type
  that is saved in the ring buffer is used to read the event, and a
  stale type that is reused by another event could cause use after free
  issues.

- Trivial comment fix.

- Fix memory leak in user_event_create().


Please pull the latest trace-v6.1-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.1-rc6

Tag SHA1: ace7e8ba9a89438bc7438ef42453fa8abf6fdb94
Head SHA1: 4313e5a613049dfc1819a6dfb5f94cf2caff9452


Colin Ian King (1):
      tracing/hist: add in missing * in comment blocks

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Fix duration type

Steven Rostedt (Google) (3):
      tracing: Fix race where histograms can be called before the event
      tracing: Add tracing_reset_all_online_cpus_unlocked() function
      tracing: Free buffers when a used dynamic event is removed

Xiu Jianfeng (1):
      tracing/user_events: Fix memory leak in user_event_create()

----
 kernel/trace/trace.c              | 11 ++++++++++-
 kernel/trace/trace.h              |  1 +
 kernel/trace/trace_dynevent.c     |  2 ++
 kernel/trace/trace_events.c       | 13 +++++++++++--
 kernel/trace/trace_events_hist.c  |  7 +++++--
 kernel/trace/trace_events_synth.c |  2 --
 kernel/trace/trace_events_user.c  |  4 +++-
 kernel/trace/trace_osnoise.c      |  6 +++---
 8 files changed, 35 insertions(+), 11 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a7fe0e115272..5cfc95a52bc3 100644
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
index 54ee5711c729..d42e24507152 100644
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
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 154996684fb5..4376887e0d8a 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -118,6 +118,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		if (ret)
 			break;
 	}
+	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
 out:
 	argv_free(argv);
@@ -214,6 +215,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 			break;
 	}
 out:
+	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
 
 	return ret;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0356cae0cf74..f71ea6e79b3c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2880,7 +2880,10 @@ static int probe_remove_event_call(struct trace_event_call *call)
 		 * TRACE_REG_UNREGISTER.
 		 */
 		if (file->flags & EVENT_FILE_FL_ENABLED)
-			return -EBUSY;
+			goto busy;
+
+		if (file->flags & EVENT_FILE_FL_WAS_ENABLED)
+			tr->clear_trace = true;
 		/*
 		 * The do_for_each_event_file_safe() is
 		 * a double loop. After finding the call for this
@@ -2893,6 +2896,12 @@ static int probe_remove_event_call(struct trace_event_call *call)
 	__trace_remove_event_call(call);
 
 	return 0;
+ busy:
+	/* No need to clear the trace now */
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		tr->clear_trace = false;
+	}
+	return -EBUSY;
 }
 
 /* Remove an event_call */
@@ -2972,7 +2981,7 @@ static void trace_module_remove_events(struct module *mod)
 	 * over from this module may be passed to the new module events and
 	 * unexpected results may occur.
 	 */
-	tracing_reset_all_online_cpus();
+	tracing_reset_all_online_cpus_unlocked();
 }
 
 static int trace_module_notify(struct notifier_block *self,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 48465f7e97b4..1c82478e8dff 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
  * A trigger can define one or more variables.  If any one of them is
  * currently referenced by any other trigger, this function will
  * determine that.
-
+ *
  * Typically used to determine whether or not a trigger can be removed
  * - if there are any references to a trigger's variables, it cannot.
  *
@@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
  * events.  However, for convenience, users are allowed to directly
  * specify an event field in an action, which will be automatically
  * converted into a variable on their behalf.
-
+ *
  * This function creates a field variable with the name var_name on
  * the hist trigger currently being defined on the target event.  If
  * subsys_name and event_name are specified, this function simply
@@ -5143,6 +5143,9 @@ static void event_hist_trigger(struct event_trigger_data *data,
 	void *key = NULL;
 	unsigned int i;
 
+	if (unlikely(!rbe))
+		return;
+
 	memset(compound_key, 0, hist_data->key_size);
 
 	for_each_hist_key_field(i, hist_data) {
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
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ae78c2d53c8a..539b08ae7020 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1100,8 +1100,10 @@ static int user_event_create(const char *raw_command)
 
 	group = current_user_event_group();
 
-	if (!group)
+	if (!group) {
+		kfree(name);
 		return -ENOENT;
+	}
 
 	mutex_lock(&group->reg_mutex);
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 78d536d3ff3d..4300c5dc4e5d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -917,7 +917,7 @@ void osnoise_trace_irq_entry(int id)
 void osnoise_trace_irq_exit(int id, const char *desc)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	int duration;
+	s64 duration;
 
 	if (!osn_var->sampling)
 		return;
@@ -1048,7 +1048,7 @@ static void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
 static void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	int duration;
+	s64 duration;
 
 	if (!osn_var->sampling)
 		return;
@@ -1144,7 +1144,7 @@ thread_entry(struct osnoise_variables *osn_var, struct task_struct *t)
 static void
 thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
 {
-	int duration;
+	s64 duration;
 
 	if (!osn_var->sampling)
 		return;
