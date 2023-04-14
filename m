Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9D26E1E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDNIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDNIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB78F;
        Fri, 14 Apr 2023 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460611; x=1712996611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9xICirPTs+XLNZnMSTUNHHk49e/SSv9s64WeLS7yIQ=;
  b=nXPByUpyyio0vmdQQDD/xoorBkijXOofEqiFlchUd+d7oB/vbHItpkr/
   dL9M7252bMA2lCSt4dc+ZacK4OYyiifgTiLBRdz1iTm+swkAspdHcYsdT
   bpH5h5RLNM1/JUO650C60fQlzqRHUwc3WmyPhgoc+JySyOS79T7u26YiK
   ynR1ClorVNFEqgvh+hZOddvfGJPPiXllnrqGbPkbcz2k7jO+cqk6HZBuN
   3Nnhwv+kYRPcP8khjYjv+sjnd/H2PS8tsLhZwjqLVX8sj2O9fEA6kPqjB
   2iiLE+qfAPD7VtgW8RefJsBd5H2dtkB5gPAogw8xZaT9lYQr10w886GsN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="430708125"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="430708125"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683267520"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683267520"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:27 -0700
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
Subject: [PATCH RFC 3/5] perf: Add namespaces to the sideband ioctl
Date:   Fri, 14 Apr 2023 11:22:58 +0300
Message-Id: <20230414082300.34798-4-adrian.hunter@intel.com>
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
 kernel/events/core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4e76596d3bfb..ed4af231853a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8364,8 +8364,7 @@ static int perf_event_namespaces_match(struct perf_event *event)
 	return event->attr.namespaces;
 }
 
-static void perf_event_namespaces_output(struct perf_event *event,
-					 void *data)
+static int perf_event_namespaces_output(struct perf_event *event, void *data)
 {
 	struct perf_namespaces_event *namespaces_event = data;
 	struct perf_output_handle handle;
@@ -8374,7 +8373,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	int ret;
 
 	if (!perf_event_namespaces_match(event))
-		return;
+		return -ENOENT;
 
 	perf_event_header__init_id(&namespaces_event->event_id.header,
 				   &sample, event);
@@ -8395,6 +8394,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	namespaces_event->event_id.header.size = header_size;
+	return ret;
 }
 
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
@@ -8414,20 +8414,20 @@ static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
 	}
 }
 
-void perf_event_namespaces(struct task_struct *task)
+static int __perf_event_namespaces(struct task_struct *task, struct perf_event *event)
 {
 	struct perf_namespaces_event namespaces_event;
 	struct perf_ns_link_info *ns_link_info;
 
 	if (!atomic_read(&nr_namespaces_events))
-		return;
+		return -ENOENT;
 
 	namespaces_event = (struct perf_namespaces_event){
 		.task	= task,
 		.event_id  = {
 			.header = {
 				.type = PERF_RECORD_NAMESPACES,
-				.misc = 0,
+				.misc = event ? PERF_RECORD_MISC_STATUS_ONLY : 0,
 				.size = sizeof(namespaces_event.event_id),
 			},
 			/* .pid */
@@ -8467,9 +8467,12 @@ void perf_event_namespaces(struct task_struct *task)
 			       task, &cgroupns_operations);
 #endif
 
-	perf_iterate_sb(perf_event_namespaces_output,
-			&namespaces_event,
-			NULL);
+	return perf_output_sb(perf_event_namespaces_output, &namespaces_event, NULL, event);
+}
+
+void perf_event_namespaces(struct task_struct *task)
+{
+	__perf_event_namespaces(task, NULL);
 }
 
 /*
@@ -12880,7 +12883,10 @@ static int perf_event_emit_fork(struct perf_event *event, struct task_struct *ta
 
 static int perf_event_emit_namespaces(struct perf_event *event, struct task_struct *task)
 {
-	return -EINVAL;
+	if (!event->attr.namespaces)
+		return -EINVAL;
+
+	return __perf_event_namespaces(task, event);
 }
 
 static int perf_event_emit_comm(struct perf_event *event, struct task_struct *task)
-- 
2.34.1

