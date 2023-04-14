Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8152E6E1E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDNIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDNIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6B6E9D;
        Fri, 14 Apr 2023 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460607; x=1712996607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xhw2PFI44xhxatWgOY9IkkDtUpBt0VWfQQBb/Lx2E8k=;
  b=ahgM5qkA4p9/HBmOgo2SAuiCLd3kduResrfoGooNywsBgx5l1JM8Q9i1
   xjQyu2bcqAUEQO8YfujHtZ7omMlZNBB/l+43gAv7mww2ICgi8nA49vh4a
   D3bQWHbdWm2SWI02cjBeVq2e3jnnPDFyFBOGk18P8jjrQ72/jr32sYIHi
   HhRZP5SjH3DAg8l0UOuPc+loFyRXBfX3DzdVTHXyZOsz00VzywDwKCkWR
   mrHGFH84mR167vx+mm5WhcqDOHZGDaqTaZwYLkigygkxH101+cZ6RINcr
   uGPJ7jXBSkWjw8s8A/iID5IwkabT0UAwOjIqRbk+6pGBN2JiUCEorDUV6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="430708106"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="430708106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683267482"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683267482"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] perf: Add fork to the sideband ioctl
Date:   Fri, 14 Apr 2023 11:22:57 +0300
Message-Id: <20230414082300.34798-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414082300.34798-1-adrian.hunter@intel.com>
References: <20230414082300.34798-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the case of output to an active event, and return an error if
output is not possible in that case. Set PERF_RECORD_MISC_STATUS_ONLY to
differentiate the ioctl status-only sideband event from a "real" sideband
event.

Set the fork parent pid/tid to the real parent for a thread group leader,
or to the thread group leader otherwise.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 88 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5cbcc6851587..4e76596d3bfb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7948,6 +7948,54 @@ perf_iterate_sb(perf_iterate_f output, void *data,
 	rcu_read_unlock();
 }
 
+typedef int (perf_output_f)(struct perf_event *event, void *data);
+
+static int perf_event_output_sb(struct perf_event *event, perf_output_f output, void *data)
+{
+	int err = -ENOENT;
+
+	preempt_disable();
+
+	if (event->state != PERF_EVENT_STATE_ACTIVE ||
+	    !event_filter_match(event) ||
+	    READ_ONCE(event->oncpu) != smp_processor_id())
+		goto out;
+
+	err = output(event, data);
+out:
+	preempt_enable();
+	return err;
+}
+
+struct perf_output_f_data {
+	perf_output_f *func;
+	void *data;
+};
+
+void perf_output_f_wrapper(struct perf_event *event, void *data)
+{
+	struct perf_output_f_data *f_data = data;
+
+	f_data->func(event, f_data->data);
+}
+
+static int perf_output_sb(perf_output_f output, void *data,
+			  struct perf_event_context *task_ctx,
+			  struct perf_event *event)
+{
+	struct perf_output_f_data f_data = {
+		.func = output,
+		.data = data,
+	};
+
+	if (event)
+		return perf_event_output_sb(event, output, data);
+
+	perf_iterate_sb(perf_output_f_wrapper, &f_data, task_ctx);
+
+	return 0;
+}
+
 /*
  * Clear all file-based filters at exec, they'll have to be
  * re-instated when/if these objects are mmapped again.
@@ -8107,8 +8155,7 @@ static int perf_event_task_match(struct perf_event *event)
 	       event->attr.task;
 }
 
-static void perf_event_task_output(struct perf_event *event,
-				   void *data)
+static int perf_event_task_output(struct perf_event *event, void *data)
 {
 	struct perf_task_event *task_event = data;
 	struct perf_output_handle handle;
@@ -8117,7 +8164,7 @@ static void perf_event_task_output(struct perf_event *event,
 	int ret, size = task_event->event_id.header.size;
 
 	if (!perf_event_task_match(event))
-		return;
+		return -ENOENT;
 
 	perf_event_header__init_id(&task_event->event_id.header, &sample, event);
 
@@ -8134,6 +8181,14 @@ static void perf_event_task_output(struct perf_event *event,
 							task->real_parent);
 		task_event->event_id.ptid = perf_event_pid(event,
 							task->real_parent);
+	} else if (task_event->event_id.header.misc & PERF_RECORD_MISC_STATUS_ONLY) {
+		if (thread_group_leader(task)) {
+			task_event->event_id.ppid = perf_event_pid(event, task->real_parent);
+			task_event->event_id.ptid = perf_event_tid(event, task->real_parent);
+		} else {
+			task_event->event_id.ppid = perf_event_pid(event, task);
+			task_event->event_id.ptid = perf_event_pid(event, task);
+		}
 	} else {  /* PERF_RECORD_FORK */
 		task_event->event_id.ppid = perf_event_pid(event, current);
 		task_event->event_id.ptid = perf_event_tid(event, current);
@@ -8148,18 +8203,19 @@ static void perf_event_task_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	task_event->event_id.header.size = size;
+	return ret;
 }
 
-static void perf_event_task(struct task_struct *task,
-			      struct perf_event_context *task_ctx,
-			      int new)
+static int perf_event_task(struct task_struct *task,
+			   struct perf_event_context *task_ctx,
+			   int new, struct perf_event *event)
 {
 	struct perf_task_event task_event;
 
 	if (!atomic_read(&nr_comm_events) &&
 	    !atomic_read(&nr_mmap_events) &&
 	    !atomic_read(&nr_task_events))
-		return;
+		return -ENOENT;
 
 	task_event = (struct perf_task_event){
 		.task	  = task,
@@ -8167,7 +8223,7 @@ static void perf_event_task(struct task_struct *task,
 		.event_id    = {
 			.header = {
 				.type = new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
-				.misc = 0,
+				.misc = event ? PERF_RECORD_MISC_STATUS_ONLY : 0,
 				.size = sizeof(task_event.event_id),
 			},
 			/* .pid  */
@@ -8178,14 +8234,12 @@ static void perf_event_task(struct task_struct *task,
 		},
 	};
 
-	perf_iterate_sb(perf_event_task_output,
-		       &task_event,
-		       task_ctx);
+	return perf_output_sb(perf_event_task_output, &task_event, task_ctx, event);
 }
 
 void perf_event_fork(struct task_struct *task)
 {
-	perf_event_task(task, NULL, 1);
+	perf_event_task(task, NULL, 1, NULL);
 	perf_event_namespaces(task);
 }
 
@@ -12817,7 +12871,11 @@ EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 
 static int perf_event_emit_fork(struct perf_event *event, struct task_struct *task)
 {
-	return -EINVAL;
+	if (!event->attr.comm && !event->attr.mmap && !event->attr.mmap2 &&
+	    !event->attr.mmap_data && !event->attr.task)
+		return -EINVAL;
+
+	return perf_event_task(task, NULL, 1, event);
 }
 
 static int perf_event_emit_namespaces(struct perf_event *event, struct task_struct *task)
@@ -13115,7 +13173,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * won't get any samples after PERF_RECORD_EXIT. We can however still
 	 * get a few PERF_RECORD_READ events.
 	 */
-	perf_event_task(child, child_ctx, 0);
+	perf_event_task(child, child_ctx, 0, NULL);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
 		perf_event_exit_event(child_event, child_ctx);
@@ -13157,7 +13215,7 @@ void perf_event_exit_task(struct task_struct *child)
 	 * child contexts and sets child->perf_event_ctxp[] to NULL.
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
-	perf_event_task(child, NULL, 0);
+	perf_event_task(child, NULL, 0, NULL);
 }
 
 static void perf_free_event(struct perf_event *event,
-- 
2.34.1

