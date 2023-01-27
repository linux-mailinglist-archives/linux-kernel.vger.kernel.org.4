Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020167DADC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjA0Af2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjA0Af1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:35:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357044BD8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:35:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 126C9B81F53
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFDFC433D2;
        Fri, 27 Jan 2023 00:35:20 +0000 (UTC)
Date:   Thu, 26 Jan 2023 19:35:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chuang Wang <nashuiliang@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Natalia Petrova <n.petrova@fintech.ru>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] tracing: Updates for 6.2
Message-ID: <20230126193518.53da979d@gandalf.local.home>
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

Tracing updates for 6.2:

- Fix filter memory leak by calling ftrace_free_filter()

- Initialize trace_printk() earlier so that ftrace_dump_on_oops shows data
  on early crashes.

- Update the outdated instructions in scripts/tracing/ftrace-bisect.sh

- Add lockdep_is_held() to fix lockdep warning

- Add allocation failure check in create_hist_field()

- Don't initialize pointer that gets set right away in enabled_monitors_write()

- Update MAINTAINER entries

- Fix help messages in Kconfigs

- Fix kernel-doc header for update_preds()


Please pull the latest trace-v6.2-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.2-rc5

Tag SHA1: 08c8ae3bc6ff93089952df685713118aad717c3c
Head SHA1: 78020233418518faa72fba11f40e1d53b9e88a2e


Chuang Wang (1):
      tracing/osnoise: Use built-in RCU list checking

Colin Ian King (1):
      rv: remove redundant initialization of pointer ptr

Mark Rutland (2):
      ftrace: Export ftrace_free_filter() to modules
      ftrace: Maintain samples/ftrace

Masami Hiramatsu (Google) (1):
      bootconfig: Update MAINTAINERS file to add tree and mailing list

Natalia Petrova (1):
      trace_events_hist: add check for return value of 'create_hist_field'

Randy Dunlap (3):
      tracing: Kconfig: Fix spelling/grammar/punctuation
      lib: Kconfig: fix spellos
      tracing/filter: fix kernel-doc warnings

Steven Rostedt (Google) (2):
      tracing: Make sure trace_printk() can output as soon as it can be used
      ftrace/scripts: Update the instructions for ftrace-bisect.sh

----
 MAINTAINERS                                 |  5 +++++
 kernel/trace/Kconfig                        |  8 +++----
 kernel/trace/ftrace.c                       | 23 ++++++++++++++++++-
 kernel/trace/rv/rv.c                        |  2 +-
 kernel/trace/trace.c                        |  2 ++
 kernel/trace/trace.h                        |  1 +
 kernel/trace/trace_events_filter.c          |  8 +++----
 kernel/trace/trace_events_hist.c            |  2 ++
 kernel/trace/trace_osnoise.c                |  5 ++---
 kernel/trace/trace_output.c                 |  3 +--
 lib/Kconfig.debug                           |  2 +-
 lib/Kconfig.kcsan                           |  2 +-
 samples/ftrace/ftrace-direct-multi-modify.c |  1 +
 samples/ftrace/ftrace-direct-multi.c        |  1 +
 scripts/tracing/ftrace-bisect.sh            | 34 ++++++++++++++++++++++-------
 15 files changed, 74 insertions(+), 25 deletions(-)
---------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index f781f936ae35..e64ba36ced78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7894,7 +7894,11 @@ F:	include/linux/extcon/
 
 EXTRA BOOT CONFIG
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/admin-guide/bootconfig.rst
 F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
@@ -8570,6 +8574,7 @@ F:	kernel/trace/fgraph.c
 F:	arch/*/*/*/*ftrace*
 F:	arch/*/*/*ftrace*
 F:	include/*/ftrace.h
+F:	samples/ftrace
 
 FUNGIBLE ETHERNET DRIVERS
 M:	Dimitris Michailidis <dmichail@fungible.com>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 197545241ab8..d7043043f59c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -933,8 +933,8 @@ config RING_BUFFER_RECORD_RECURSION
 	default y
 	help
 	  The ring buffer has its own internal recursion. Although when
-	  recursion happens it wont cause harm because of the protection,
-	  but it does cause an unwanted overhead. Enabling this option will
+	  recursion happens it won't cause harm because of the protection,
+	  but it does cause unwanted overhead. Enabling this option will
 	  place where recursion was detected into the ftrace "recursed_functions"
 	  file.
 
@@ -1017,8 +1017,8 @@ config RING_BUFFER_STARTUP_TEST
 	 The test runs for 10 seconds. This will slow your boot time
 	 by at least 10 more seconds.
 
-	 At the end of the test, statics and more checks are done.
-	 It will output the stats of each per cpu buffer. What
+	 At the end of the test, statistics and more checks are done.
+	 It will output the stats of each per cpu buffer: What
 	 was written, the sizes, what was read, what was lost, and
 	 other similar details.
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 442438b93fe9..750aa3f08b25 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1248,12 +1248,17 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
 	call_rcu(&hash->rcu, __free_ftrace_hash_rcu);
 }
 
+/**
+ * ftrace_free_filter - remove all filters for an ftrace_ops
+ * @ops - the ops to remove the filters from
+ */
 void ftrace_free_filter(struct ftrace_ops *ops)
 {
 	ftrace_ops_init(ops);
 	free_ftrace_hash(ops->func_hash->filter_hash);
 	free_ftrace_hash(ops->func_hash->notrace_hash);
 }
+EXPORT_SYMBOL_GPL(ftrace_free_filter);
 
 static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 {
@@ -5839,6 +5844,10 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
  *
  * Filters denote which functions should be enabled when tracing is enabled
  * If @ip is NULL, it fails to update filter.
+ *
+ * This can allocate memory which must be freed before @ops can be freed,
+ * either by removing each filtered addr or by using
+ * ftrace_free_filter(@ops).
  */
 int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 			 int remove, int reset)
@@ -5858,7 +5867,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
  *
  * Filters denote which functions should be enabled when tracing is enabled
  * If @ips array or any ip specified within is NULL , it fails to update filter.
- */
+ *
+ * This can allocate memory which must be freed before @ops can be freed,
+ * either by removing each filtered addr or by using
+ * ftrace_free_filter(@ops).
+*/
 int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
 			  unsigned int cnt, int remove, int reset)
 {
@@ -5900,6 +5913,10 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
  *
  * Filters denote which functions should be enabled when tracing is enabled.
  * If @buf is NULL and reset is set, all functions will be enabled for tracing.
+ *
+ * This can allocate memory which must be freed before @ops can be freed,
+ * either by removing each filtered addr or by using
+ * ftrace_free_filter(@ops).
  */
 int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
 		       int len, int reset)
@@ -5919,6 +5936,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
  * Notrace Filters denote which functions should not be enabled when tracing
  * is enabled. If @buf is NULL and reset is set, all functions will be enabled
  * for tracing.
+ *
+ * This can allocate memory which must be freed before @ops can be freed,
+ * either by removing each filtered addr or by using
+ * ftrace_free_filter(@ops).
  */
 int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
 			int len, int reset)
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c97cc2d754a..7e9061828c24 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -516,7 +516,7 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 	struct rv_monitor_def *mdef;
 	int retval = -EINVAL;
 	bool enable = true;
-	char *ptr = buff;
+	char *ptr;
 	int len;
 
 	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a555a861b978..78ed5f1baa8c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10295,6 +10295,8 @@ void __init early_trace_init(void)
 			static_key_enable(&tracepoint_printk_key.key);
 	}
 	tracer_alloc_buffers();
+
+	init_events();
 }
 
 void __init trace_init(void)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e46a49269be2..4eb6d6b97a9f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1490,6 +1490,7 @@ extern void trace_event_enable_cmd_record(bool enable);
 extern void trace_event_enable_tgid_record(bool enable);
 
 extern int event_trace_init(void);
+extern int init_events(void);
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 extern void __trace_early_add_events(struct trace_array *tr);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 96acc2b71ac7..e095c3b3a50d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -128,7 +128,7 @@ static bool is_not(const char *str)
 }
 
 /**
- * prog_entry - a singe entry in the filter program
+ * struct prog_entry - a singe entry in the filter program
  * @target:	     Index to jump to on a branch (actually one minus the index)
  * @when_to_branch:  The value of the result of the predicate to do a branch
  * @pred:	     The predicate to execute.
@@ -140,16 +140,16 @@ struct prog_entry {
 };
 
 /**
- * update_preds- assign a program entry a label target
+ * update_preds - assign a program entry a label target
  * @prog: The program array
  * @N: The index of the current entry in @prog
- * @when_to_branch: What to assign a program entry for its branch condition
+ * @invert: What to assign a program entry for its branch condition
  *
  * The program entry at @N has a target that points to the index of a program
  * entry that can have its target and when_to_branch fields updated.
  * Update the current program entry denoted by index @N target field to be
  * that of the updated entry. This will denote the entry to update if
- * we are processing an "||" after an "&&"
+ * we are processing an "||" after an "&&".
  */
 static void update_preds(struct prog_entry *prog, int N, int invert)
 {
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fcaf226b7744..5edbf6b1da3f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1988,6 +1988,8 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		hist_field->fn_num = flags & HIST_FIELD_FL_LOG2 ? HIST_FIELD_FN_LOG2 :
 			HIST_FIELD_FN_BUCKET;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
+		if (!hist_field->operands[0])
+			goto free;
 		hist_field->size = hist_field->operands[0]->size;
 		hist_field->type = kstrdup_const(hist_field->operands[0]->type, GFP_KERNEL);
 		if (!hist_field->type)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 94c1b5eb1dc0..210e1f168392 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -147,9 +147,8 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	 * register/unregister serialization is provided by trace's
 	 * trace_types_lock.
 	 */
-	lockdep_assert_held(&trace_types_lock);
-
-	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
+	list_for_each_entry_rcu(inst, &osnoise_instances, list,
+				lockdep_is_held(&trace_types_lock)) {
 		if (inst->tr == tr) {
 			list_del_rcu(&inst->list);
 			found = 1;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 57a13b61f186..bd475a00f96d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1535,7 +1535,7 @@ static struct trace_event *events[] __initdata = {
 	NULL
 };
 
-__init static int init_events(void)
+__init int init_events(void)
 {
 	struct trace_event *event;
 	int i, ret;
@@ -1548,4 +1548,3 @@ __init static int init_events(void)
 
 	return 0;
 }
-early_initcall(init_events);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..6426dbf99c12 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1917,7 +1917,7 @@ config FUNCTION_ERROR_INJECTION
 	help
 	  Add fault injections into various functions that are annotated with
 	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
-	  value of theses functions. This is useful to test error paths of code.
+	  value of these functions. This is useful to test error paths of code.
 
 	  If unsure, say N
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 375575a5a0e3..4dedd61e5192 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -194,7 +194,7 @@ config KCSAN_WEAK_MEMORY
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
 
-	  Depends on KCSAN_STRICT, because the options strenghtening certain
+	  Depends on KCSAN_STRICT, because the options strengthening certain
 	  plain accesses by default (depending on !KCSAN_STRICT) reduce the
 	  ability to detect any data races invoving reordered accesses, in
 	  particular reordered writes.
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index d52370cad0b6..a825dbd2c9cf 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -152,6 +152,7 @@ static void __exit ftrace_direct_multi_exit(void)
 {
 	kthread_stop(simple_tsk);
 	unregister_ftrace_direct_multi(&direct, my_tramp);
+	ftrace_free_filter(&direct);
 }
 
 module_init(ftrace_direct_multi_init);
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index ec1088922517..d955a2650605 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -79,6 +79,7 @@ static int __init ftrace_direct_multi_init(void)
 static void __exit ftrace_direct_multi_exit(void)
 {
 	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	ftrace_free_filter(&direct);
 }
 
 module_init(ftrace_direct_multi_init);
diff --git a/scripts/tracing/ftrace-bisect.sh b/scripts/tracing/ftrace-bisect.sh
index 926701162bc8..bb4f59262bbe 100755
--- a/scripts/tracing/ftrace-bisect.sh
+++ b/scripts/tracing/ftrace-bisect.sh
@@ -12,7 +12,7 @@
 #   (note, if this is a problem with function_graph tracing, then simply
 #    replace "function" with "function_graph" in the following steps).
 #
-#  # cd /sys/kernel/debug/tracing
+#  # cd /sys/kernel/tracing
 #  # echo schedule > set_ftrace_filter
 #  # echo function > current_tracer
 #
@@ -20,22 +20,40 @@
 #
 #  # echo nop > current_tracer
 #
-#  # cat available_filter_functions > ~/full-file
+# Starting with v5.1 this can be done with numbers, making it much faster:
+#
+# The old (slow) way, for kernels before v5.1.
+#
+# [old-way] # cat available_filter_functions > ~/full-file
+#
+# [old-way] *** Note ***  this process will take several minutes to update the
+# [old-way] filters. Setting multiple functions is an O(n^2) operation, and we
+# [old-way] are dealing with thousands of functions. So go have coffee, talk
+# [old-way] with your coworkers, read facebook. And eventually, this operation
+# [old-way] will end.
+#
+# The new way (using numbers) is an O(n) operation, and usually takes less than a second.
+#
+# seq `wc -l available_filter_functions | cut -d' ' -f1` > ~/full-file
+#
+# This will create a sequence of numbers that match the functions in
+# available_filter_functions, and when echoing in a number into the
+# set_ftrace_filter file, it will enable the corresponding function in
+# O(1) time. Making enabling all functions O(n) where n is the number of
+# functions to enable.
+#
+# For either the new or old way, the rest of the operations remain the same.
+#
 #  # ftrace-bisect ~/full-file ~/test-file ~/non-test-file
 #  # cat ~/test-file > set_ftrace_filter
 #
-# *** Note *** this will take several minutes. Setting multiple functions is
-# an O(n^2) operation, and we are dealing with thousands of functions. So go
-# have  coffee, talk with your coworkers, read facebook. And eventually, this
-# operation will end.
-#
 #  # echo function > current_tracer
 #
 # If it crashes, we know that ~/test-file has a bad function.
 #
 #   Reboot back to test kernel.
 #
-#     # cd /sys/kernel/debug/tracing
+#     # cd /sys/kernel/tracing
 #     # mv ~/test-file ~/full-file
 #
 # If it didn't crash.
