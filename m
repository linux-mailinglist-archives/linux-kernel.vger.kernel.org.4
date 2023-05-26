Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6589712C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjEZSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbjEZSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD3E50
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5655d99d636so26772447b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126080; x=1687718080;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIZMpXPJ1dQ5s5NJpJTXLqv0Dy6GNIIEqB7VSkKLPVU=;
        b=5V7orP06jmDLBBXQbP6UcRYzgABu9vELxgXsdLr9L8wEqPxNVIE9LCYmrYGWLhJTF8
         lTYXhnYekALzZ0mJGasQ2tAQ56/+/yNdAzm0G62yd/o3YyKOCRlWYwAPt6AYgPIWYrOT
         BsodmpJk3C11+qh8TAY6uxUdRS6v4PXkuqUeT9pv1IXjGqupZmxd7w27241x7Ja8mfVo
         9NXeGl5zfuBE6w/1zTajEGjvNE9+j0Vv8NxmzwB+E4R0hWAuyg9/9lP0kX5aguOcJhST
         J3neLzlzCKSAbvDGM54MhZa3oQQ14ks39cYx0v6rfDLmus6MaN/qdy4paYxZisengb8a
         ImbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126080; x=1687718080;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIZMpXPJ1dQ5s5NJpJTXLqv0Dy6GNIIEqB7VSkKLPVU=;
        b=UFHFw9/dtHgh9gdoZ4sMrw/5wJwqE0TfQg+O4XwAcw+0r/Xl0FaDigRO1zbmXIvjRV
         MLRExFv8y2vMZ+DgvniJdlxcEd3bf2LqUlrrzfjEHDJEGVUk6UjlawO2PfXqPS+bCzkI
         vnWhLkCFDfO2Xg6ztCDjf+nU6Zrsr86PBJa5w+YChzXSeIkEArRjVtp+855WbaNBDXCA
         z8IcC0NrXYkpyb5OomTlS/jAABWrkf6EnriRbT1mj+h6MlRoJypArZQWXYLi1ImtKobU
         O9+orzthXKYQ6viAoNhlEr5Hds2KI/6RqxAzwvvGzbhAvLz/8/Z39nOwpD/C/B4xzupn
         RoPQ==
X-Gm-Message-State: AC+VfDwVp9W2KRZLbCPsxYUO+OawY+qakIkZvDOHFvj0q9ZPE9ZsbUyY
        SEJrghDTklsyTbYCb4XOLowXhawCyxey
X-Google-Smtp-Source: ACHHUZ5XqMKoVFQeOJB2IJzmU6NazOhnjZ2ccmm6/S/dj5/4ymEx1N+DWEf1VQXl9QyS8f4KREh3raln5CL9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ed06:0:b0:54f:bb71:c7b3 with SMTP id
 k6-20020a81ed06000000b0054fbb71c7b3mr1567729ywm.9.1685126080090; Fri, 26 May
 2023 11:34:40 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:58 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-14-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 13/16] perf scripting-engines: Move static to local variable
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid 16,384 bytes in .bss by stack allocating two bitmaps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/scripting-engines/trace-event-perl.c   | 4 ++--
 tools/perf/util/scripting-engines/trace-event-python.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 039d0365ad41..65b761d83a1f 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -67,8 +67,6 @@ INTERP my_perl;
 #define TRACE_EVENT_TYPE_MAX				\
 	((1 << (sizeof(unsigned short) * 8)) - 1)
 
-static DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
-
 extern struct scripting_context *scripting_context;
 
 static char *cur_field_name;
@@ -353,7 +351,9 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	void *data = sample->raw_data;
 	unsigned long long nsecs = sample->time;
 	const char *comm = thread__comm_str(thread);
+	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
 
+	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 	dSP;
 
 	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 41d4f9e6a8b7..40964078f92f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -93,8 +93,6 @@ PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #define TRACE_EVENT_TYPE_MAX				\
 	((1 << (sizeof(unsigned short) * 8)) - 1)
 
-static DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
-
 #define N_COMMON_FIELDS	7
 
 static char *cur_field_name;
@@ -934,6 +932,9 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	unsigned long long nsecs = sample->time;
 	const char *comm = thread__comm_str(al->thread);
 	const char *default_handler_name = "trace_unhandled";
+	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
+
+	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 
 	if (!event) {
 		snprintf(handler_name, sizeof(handler_name),
-- 
2.41.0.rc0.172.g3f132b7071-goog

