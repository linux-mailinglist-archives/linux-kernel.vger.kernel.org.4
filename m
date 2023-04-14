Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD536E1E11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDNIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjDNIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECF7EF5;
        Fri, 14 Apr 2023 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460614; x=1712996614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3nHcjAW5hAXD3jrHcmKICBKZPcBY+tB2vS9Jj26IxgQ=;
  b=dglHk3STL+XoTEAcBm1p7GlojlLHnTIFjlP3TzcNoD4YIrk5PVTglCaZ
   SwruLGdz3Hu7q6wALVUpVLYliszc61pmLDesKZI7Pm1wQ+ekgNYYANhhn
   ySRb9EbGuXDjW1OMjH1Ehw8IfOc9vINvTkfs72oyoDiY269wpvFR0JPFX
   JCquoLQOybIx4JVDHz6YquGmWZhKnJiX2z7np+a3fpTs53UY2ZkZyXjir
   fhYkfwE6L0C4179o5b249s8pKg19hGBJmN/jCUGYsGxoxUlSgqUomXSgL
   nOR3O0QuFWfpeMAfV5dF5hcqk/kp1j7ZCVYjRM36YPbkI+DSxtdsvEMKf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="430708139"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="430708139"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683267542"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683267542"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:31 -0700
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
Subject: [PATCH RFC 4/5] perf: Add comm to the sideband ioctl
Date:   Fri, 14 Apr 2023 11:22:59 +0300
Message-Id: <20230414082300.34798-5-adrian.hunter@intel.com>
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

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ed4af231853a..cddc02c2e411 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8265,8 +8265,7 @@ static int perf_event_comm_match(struct perf_event *event)
 	return event->attr.comm;
 }
 
-static void perf_event_comm_output(struct perf_event *event,
-				   void *data)
+static int perf_event_comm_output(struct perf_event *event, void *data)
 {
 	struct perf_comm_event *comm_event = data;
 	struct perf_output_handle handle;
@@ -8275,7 +8274,7 @@ static void perf_event_comm_output(struct perf_event *event,
 	int ret;
 
 	if (!perf_event_comm_match(event))
-		return;
+		return -ENOENT;
 
 	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
 	ret = perf_output_begin(&handle, &sample, event,
@@ -8296,9 +8295,10 @@ static void perf_event_comm_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	comm_event->event_id.header.size = size;
+	return ret;
 }
 
-static void perf_event_comm_event(struct perf_comm_event *comm_event)
+static int perf_event_comm_event(struct perf_comm_event *comm_event, struct perf_event *event)
 {
 	char comm[TASK_COMM_LEN];
 	unsigned int size;
@@ -8312,17 +8312,15 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 
 	comm_event->event_id.header.size = sizeof(comm_event->event_id) + size;
 
-	perf_iterate_sb(perf_event_comm_output,
-		       comm_event,
-		       NULL);
+	return perf_output_sb(perf_event_comm_output, comm_event, NULL, event);
 }
 
-void perf_event_comm(struct task_struct *task, bool exec)
+static int __perf_event_comm(struct task_struct *task, bool exec, struct perf_event *event)
 {
 	struct perf_comm_event comm_event;
 
 	if (!atomic_read(&nr_comm_events))
-		return;
+		return -ENOENT;
 
 	comm_event = (struct perf_comm_event){
 		.task	= task,
@@ -8331,7 +8329,8 @@ void perf_event_comm(struct task_struct *task, bool exec)
 		.event_id  = {
 			.header = {
 				.type = PERF_RECORD_COMM,
-				.misc = exec ? PERF_RECORD_MISC_COMM_EXEC : 0,
+				.misc = (exec ? PERF_RECORD_MISC_COMM_EXEC : 0) |
+					(event ? PERF_RECORD_MISC_STATUS_ONLY : 0),
 				/* .size */
 			},
 			/* .pid */
@@ -8339,7 +8338,12 @@ void perf_event_comm(struct task_struct *task, bool exec)
 		},
 	};
 
-	perf_event_comm_event(&comm_event);
+	return perf_event_comm_event(&comm_event, event);
+}
+
+void perf_event_comm(struct task_struct *task, bool exec)
+{
+	__perf_event_comm(task, exec, NULL);
 }
 
 /*
@@ -12891,7 +12895,10 @@ static int perf_event_emit_namespaces(struct perf_event *event, struct task_stru
 
 static int perf_event_emit_comm(struct perf_event *event, struct task_struct *task)
 {
-	return -EINVAL;
+	if (!event->attr.comm)
+		return -EINVAL;
+
+	return __perf_event_comm(task, false, event);
 }
 
 static int perf_event_emit_mmap(struct perf_event *event, struct task_struct *task)
-- 
2.34.1

