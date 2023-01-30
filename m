Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3468189C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjA3SUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjA3STp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:45 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214883D08F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:42 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d10so5466800ilc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuWeF3rfcHFcdnyMOOHBGhKB3R6BOcBMPglXzqcwFlo=;
        b=eDvVksg45BXpGSZya+HZiS5XDauERJNk96T18q5/kTMGyvhH7lz8UQ94QnPxlikI/G
         Z2Tj6GS7qe0Lw59kk2QrfuXruiPUazivNEiWqO3S0d7M8rOqvPASnb0Rfvn717WTTVgZ
         Hq21+nbTo+zEJfDhrh2HlYBnu1RgSNiDbamf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuWeF3rfcHFcdnyMOOHBGhKB3R6BOcBMPglXzqcwFlo=;
        b=mI/cR3DJYfocyS0iBPDKiPHoJz6NS9Z0AIcXqjnFaNSFoF+AclpAvCElJFJJqunvGj
         87q9y1rnNIrFsR+43Du1O6yLcdbCQgqidLLG87lQx3IsgJoB4ydwUczR+NFP+ASXUN1b
         srEbTpPWT/cizObnoWrWlHhHeA95Kb7gIWf+IoF5i2P2LWZqVSyzosEP7TeJ4/eCMd7/
         sSkpIZWBoOKSn/u7n+u4aQ4w0uOI2XOr9UfX3X1M98YXVRM96prgMZXg7zS3I/tRPYyF
         8WqaNkbhRirGTQxVBYGI/GsnemRIbljm1b3wDwEw6F4Ie/jN3Hae9b7Xjcqlhxpqa3TO
         /Hbg==
X-Gm-Message-State: AO0yUKUa+i6dRN+fninyUgzyTQ6UgWilarD/WKA+e3PNZ3uwXoJ/H1y6
        W0oZIEAyw7+As01ct1vAxTt5qF8eFzt6VdC+
X-Google-Smtp-Source: AK7set/TFGUGCZ3dnywOAl+St5sUEvEv83qJT9/5SVXE7CEke0EIRWmDTdx74h3UjF/WdIeHbjGDhA==
X-Received: by 2002:a05:6e02:1b83:b0:310:cbfc:1160 with SMTP id h3-20020a056e021b8300b00310cbfc1160mr11857336ili.19.1675102781207;
        Mon, 30 Jan 2023 10:19:41 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:40 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/9] tracing: always use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:07 -0700
Message-Id: <20230130181915.1113313-2-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

Many comments and Kconfig help messages in the tracing code still refer
to this older debugfs path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 include/linux/kernel.h                    |  2 +-
 include/linux/tracepoint.h                |  4 ++--
 kernel/trace/Kconfig                      | 20 ++++++++++----------
 kernel/trace/kprobe_event_gen_test.c      |  2 +-
 kernel/trace/ring_buffer.c                |  2 +-
 kernel/trace/synth_event_gen_test.c       |  2 +-
 kernel/trace/trace.c                      |  2 +-
 samples/user_events/example.c             |  4 ++--
 scripts/tracing/draw_functrace.py         |  6 +++---
 scripts/tracing/ftrace-bisect.sh          |  4 ++--
 tools/lib/api/fs/tracing_path.c           |  4 ++--
 tools/lib/traceevent/event-parse.c        |  8 ++++----
 tools/tracing/latency/latency-collector.c |  2 +-
 13 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d151..40bce7495af8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -297,7 +297,7 @@ bool mac_pton(const char *s, u8 *mac);
  *
  * Use tracing_on/tracing_off when you want to quickly turn on or off
  * tracing. It simply enables or disables the recording of the trace events.
- * This also corresponds to the user space /sys/kernel/debug/tracing/tracing_on
+ * This also corresponds to the user space /sys/kernel/tracing/tracing_on
  * file, which gives a means for the kernel and userspace to interact.
  * Place a tracing_off() in the kernel where you want tracing to end.
  * From user space, examine the trace, and then echo 1 > tracing_on
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 4b33b95eb8be..fa1004fcf810 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -471,7 +471,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	* This is how the trace record is structured and will
  *	* be saved into the ring buffer. These are the fields
  *	* that will be exposed to user-space in
- *	* /sys/kernel/debug/tracing/events/<*>/format.
+ *	* /sys/kernel/tracing/events/<*>/format.
  *	*
  *	* The declared 'local variable' is called '__entry'
  *	*
@@ -531,7 +531,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * tracepoint callback (this is used by programmatic plugins and
  * can also by used by generic instrumentation like SystemTap), and
  * it is also used to expose a structured trace record in
- * /sys/kernel/debug/tracing/events/.
+ * /sys/kernel/tracing/events/.
  *
  * A set of (un)registration functions can be passed to the variant
  * TRACE_EVENT_FN to perform any (un)registration work.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e9e95c790b8e..4b85674935d7 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -232,7 +232,7 @@ config DYNAMIC_FTRACE
 	  enabled, and the functions not enabled will not affect
 	  performance of the system.
 
-	  See the files in /sys/kernel/debug/tracing:
+	  See the files in /sys/kernel/tracing:
 	    available_filter_functions
 	    set_ftrace_filter
 	    set_ftrace_notrace
@@ -292,7 +292,7 @@ config STACK_TRACER
 	select KALLSYMS
 	help
 	  This special tracer records the maximum stack footprint of the
-	  kernel and displays it in /sys/kernel/debug/tracing/stack_trace.
+	  kernel and displays it in /sys/kernel/tracing/stack_trace.
 
 	  This tracer works by hooking into every function call that the
 	  kernel executes, and keeping a maximum stack depth value and
@@ -332,7 +332,7 @@ config IRQSOFF_TRACER
 	  disabled by default and can be runtime (re-)started
 	  via:
 
-	      echo 0 > /sys/kernel/debug/tracing/tracing_max_latency
+	      echo 0 > /sys/kernel/tracing/tracing_max_latency
 
 	  (Note that kernel size and overhead increase with this option
 	  enabled. This option and the preempt-off timing option can be
@@ -356,7 +356,7 @@ config PREEMPT_TRACER
 	  disabled by default and can be runtime (re-)started
 	  via:
 
-	      echo 0 > /sys/kernel/debug/tracing/tracing_max_latency
+	      echo 0 > /sys/kernel/tracing/tracing_max_latency
 
 	  (Note that kernel size and overhead increase with this option
 	  enabled. This option and the irqs-off timing option can be
@@ -506,7 +506,7 @@ config TRACER_SNAPSHOT
 	  Allow tracing users to take snapshot of the current buffer using the
 	  ftrace interface, e.g.:
 
-	      echo 1 > /sys/kernel/debug/tracing/snapshot
+	      echo 1 > /sys/kernel/tracing/snapshot
 	      cat snapshot
 
 config TRACER_SNAPSHOT_PER_CPU_SWAP
@@ -518,7 +518,7 @@ config TRACER_SNAPSHOT_PER_CPU_SWAP
 	  full swap (all buffers). If this is set, then the following is
 	  allowed:
 
-	      echo 1 > /sys/kernel/debug/tracing/per_cpu/cpu2/snapshot
+	      echo 1 > /sys/kernel/tracing/per_cpu/cpu2/snapshot
 
 	  After which, only the tracing buffer for CPU 2 was swapped with
 	  the main tracing buffer, and the other CPU buffers remain the same.
@@ -565,7 +565,7 @@ config PROFILE_ANNOTATED_BRANCHES
 	  This tracer profiles all likely and unlikely macros
 	  in the kernel. It will display the results in:
 
-	  /sys/kernel/debug/tracing/trace_stat/branch_annotated
+	  /sys/kernel/tracing/trace_stat/branch_annotated
 
 	  Note: this will add a significant overhead; only turn this
 	  on if you need to profile the system's use of these macros.
@@ -578,7 +578,7 @@ config PROFILE_ALL_BRANCHES
 	  taken in the kernel is recorded whether it hit or miss.
 	  The results will be displayed in:
 
-	  /sys/kernel/debug/tracing/trace_stat/branch_all
+	  /sys/kernel/tracing/trace_stat/branch_all
 
 	  This option also enables the likely/unlikely profiler.
 
@@ -629,8 +629,8 @@ config BLK_DEV_IO_TRACE
 	  Tracing also is possible using the ftrace interface, e.g.:
 
 	    echo 1 > /sys/block/sda/sda1/trace/enable
-	    echo blk > /sys/kernel/debug/tracing/current_tracer
-	    cat /sys/kernel/debug/tracing/trace_pipe
+	    echo blk > /sys/kernel/tracing/current_tracer
+	    cat /sys/kernel/tracing/trace_pipe
 
 	  If unsure, say N.
 
diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index c736487fc0e4..4850fdfe27f1 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -21,7 +21,7 @@
  * Then:
  *
  * # insmod kernel/trace/kprobe_event_gen_test.ko
- * # cat /sys/kernel/debug/tracing/trace
+ * # cat /sys/kernel/tracing/trace
  *
  * You should see many instances of the "gen_kprobe_test" and
  * "gen_kretprobe_test" events in the trace buffer.
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b21bf14bae9b..c4ad4939d149 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2868,7 +2868,7 @@ rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
-		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
+		  "  echo global > /sys/kernel/tracing/trace_clock\n"
 		  "or add trace_clock=global to the kernel command line\n");
 }
 
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 8d77526892f4..8dfe85499d4a 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -22,7 +22,7 @@
  * Then:
  *
  * # insmod kernel/trace/synth_event_gen_test.ko
- * # cat /sys/kernel/debug/tracing/trace
+ * # cat /sys/kernel/tracing/trace
  *
  * You should see several events in the trace buffer -
  * "create_synth_test", "empty_synth_test", and several instances of
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a7fe0e115272..4a034b9c429d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1143,7 +1143,7 @@ void tracing_snapshot_instance(struct trace_array *tr)
  *
  * Note, make sure to allocate the snapshot with either
  * a tracing_snapshot_alloc(), or by doing it manually
- * with: echo 1 > /sys/kernel/debug/tracing/snapshot
+ * with: echo 1 > /sys/kernel/tracing/snapshot
  *
  * If the snapshot buffer is not allocated, it will stop tracing.
  * Basically making a permanent snapshot.
diff --git a/samples/user_events/example.c b/samples/user_events/example.c
index d06dc24156ec..18e34c9d708e 100644
--- a/samples/user_events/example.c
+++ b/samples/user_events/example.c
@@ -23,8 +23,8 @@
 #endif
 
 /* Assumes debugfs is mounted */
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *status_file = "/sys/kernel/tracing/user_events_status";
 
 static int event_status(long **status)
 {
diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index 438516bdfb3c..42fa87300941 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -12,9 +12,9 @@ calls. Only the functions's names and the call time are provided.
 
 Usage:
 	Be sure that you have CONFIG_FUNCTION_TRACER
-	# mount -t debugfs nodev /sys/kernel/debug
-	# echo function > /sys/kernel/debug/tracing/current_tracer
-	$ cat /sys/kernel/debug/tracing/trace_pipe > ~/raw_trace_func
+	# mount -t tracefs nodev /sys/kernel/tracing
+	# echo function > /sys/kernel/tracing/current_tracer
+	$ cat /sys/kernel/tracing/trace_pipe > ~/raw_trace_func
 	Wait some times but not too much, the script is a bit slow.
 	Break the pipe (Ctrl + Z)
 	$ scripts/tracing/draw_functrace.py < ~/raw_trace_func > draw_functrace
diff --git a/scripts/tracing/ftrace-bisect.sh b/scripts/tracing/ftrace-bisect.sh
index 926701162bc8..53244096489e 100755
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
@@ -35,7 +35,7 @@
 #
 #   Reboot back to test kernel.
 #
-#     # cd /sys/kernel/debug/tracing
+#     # cd /sys/kernel/tracing
 #     # mv ~/test-file ~/full-file
 #
 # If it didn't crash.
diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 5afb11b30fca..ca95310f7d8e 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -14,8 +14,8 @@
 #include "tracing_path.h"
 
 static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
-static char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
-static char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
+static char tracing_path[PATH_MAX]        = "/sys/kernel/tracing";
+static char tracing_events_path[PATH_MAX] = "/sys/kernel/tracing/events";
 
 static void __tracing_path_set(const char *tracing, const char *mountpoint)
 {
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 8e24c4c78c7f..9532bcf4138d 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6664,7 +6664,7 @@ static void parse_header_field(const char *field,
  * This parses the header page format for information on the
  * ring buffer used. The @buf should be copied from
  *
- * /sys/kernel/debug/tracing/events/header_page
+ * /sys/kernel/tracing/events/header_page
  */
 int tep_parse_header_page(struct tep_handle *tep, char *buf, unsigned long size,
 			  int long_size)
@@ -6758,7 +6758,7 @@ static int find_event_handle(struct tep_handle *tep, struct tep_event *event)
  *
  * These files currently come from:
  *
- * /sys/kernel/debug/tracing/events/.../.../format
+ * /sys/kernel/tracing/events/.../.../format
  */
 static enum tep_errno parse_format(struct tep_event **eventp,
 				   struct tep_handle *tep, const char *buf,
@@ -6912,7 +6912,7 @@ __parse_event(struct tep_handle *tep,
  *
  * These files currently come from:
  *
- * /sys/kernel/debug/tracing/events/.../.../format
+ * /sys/kernel/tracing/events/.../.../format
  */
 enum tep_errno tep_parse_format(struct tep_handle *tep,
 				struct tep_event **eventp,
@@ -6934,7 +6934,7 @@ enum tep_errno tep_parse_format(struct tep_handle *tep,
  *
  * These files currently come from:
  *
- * /sys/kernel/debug/tracing/events/.../.../format
+ * /sys/kernel/tracing/events/.../.../format
  */
 enum tep_errno tep_parse_event(struct tep_handle *tep, const char *buf,
 			       unsigned long size, const char *sys)
diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 59a7f2346eab..0fd9c747d396 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1584,7 +1584,7 @@ static void *do_printloop(void *arg)
 		/*
 		 * Toss a coin to decide if we want to sleep before printing
 		 * out the backtrace. The reason for this is that opening
-		 * /sys/kernel/debug/tracing/trace will cause a blackout of
+		 * /sys/kernel/tracing/trace will cause a blackout of
 		 * hundreds of ms, where no latencies will be noted by the
 		 * latency tracer. Thus by randomly sleeping we try to avoid
 		 * missing traces systematically due to this. With this option
-- 
2.39.1.456.gfc5497dd1b-goog

