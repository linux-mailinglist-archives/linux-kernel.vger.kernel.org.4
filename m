Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E86633FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjAIWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbjAIWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:31:43 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315A1A3AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:31:39 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e5-20020a63f545000000b0049b36d5a272so4261061pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ug6Nd3EbDzaRS68tlrjiAydekO6Uv+/xgV5ztzybNo0=;
        b=U8fQDbOJkLtVzjsR9KLOdyUm2rp5noTDkiWILSq2ULrmIfLWwYKqwhEJHEUd851SLB
         zirmssgmt2kqWHhNOaP9xZm5Kwtxm0kh0urkRuCIizRyDAhSZ/fcJgGjegJP1HFiZxs1
         gXId/Xsx6KLaBOAt+PBVCQSQm+LJ11A2yOLwym3tbSdKhTpl+5hi+cWFGCcZrjyRXAfW
         4MHxNIpW13n4AuH4A9vh3KzB9JxjbCSmjeXS0ij6UV0figk6CGhg4O3WD19nK1+3vBkQ
         /XyrIhAfJwlmo7z+yE0CO80Fh3FHDOfMPMUV/45WTlCJiErGuSoKsfhKOmbEzWOvWcqj
         1I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ug6Nd3EbDzaRS68tlrjiAydekO6Uv+/xgV5ztzybNo0=;
        b=VTh2C08eb0q6/EuJCoB74hGNX5uyLtX2RdJaqijhnmvA10qV7JUhs3/LxMcEHgeBH3
         5YEwNVPQQGkvs2onjhpGtRBU9N8at1+t+lsM5WZ2BS4MaICgG3o/oBOJeVBm7J/ZcMNc
         Zo0xBWmH2zRPJwMGQB8TsfCpZeMtXxOedmlEyFGCdDP8CrkMXXgidPLHaDlyb4sIfMlK
         M0n1J5RGrSKzrOrsgn1abM6esnx3ccImE/8KbEbTWBEWXB+6qMfJSrbZdBLboJVsYDzV
         pfa7EWGc/C/8dEudNGvb9EwP3VpCKsutS0BEtjJxmlx5WsQy5BAz3WNUN3uk4aUAINrp
         /9MA==
X-Gm-Message-State: AFqh2kpOVKljGtAEbNuZR3AMDVtgBuccGbDCGtb1uxVW4ytMyichTsHa
        xaW/GdARVWmDnKFxrWZXG+h5p0LFc5i/
X-Google-Smtp-Source: AMrXdXurJ6mwuNrzdryHYSBx36xZxQ6KycO6AOHg0mFchv0+hm6/cKa6kKcT8Jiqh1NcnIHABQvHrh+8b9rc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a63:e257:0:b0:48a:1190:70a4 with SMTP id
 y23-20020a63e257000000b0048a119070a4mr4349441pgj.397.1673303498452; Mon, 09
 Jan 2023 14:31:38 -0800 (PST)
Date:   Mon,  9 Jan 2023 14:31:09 -0800
Message-Id: <20230109223110.1201541-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 1/2] perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE to be a version number
test on libtraceevent being >= to version 1.5.0. This also corrects a
greater-than test to be greater-than-or-equal.

Discussed here:
https://lore.kernel.org/lkml/20221205225940.3079667-3-irogers@google.com/

Fixes: b9a49f8cb02f ("perf tools: Check if libtracevent has TEP_FIELD_IS_RELATIVE")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config                             | 4 ----
 tools/perf/builtin-trace.c                             | 2 +-
 tools/perf/util/data-convert-bt.c                      | 2 +-
 tools/perf/util/evsel.c                                | 2 +-
 tools/perf/util/python.c                               | 2 +-
 tools/perf/util/scripting-engines/trace-event-perl.c   | 2 +-
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/sort.c                                 | 3 ++-
 tools/perf/util/trace-event.h                          | 3 +++
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c2504c39bdcb..f67ba8060162 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1204,10 +1204,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
-    LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \* 255 \* 255 + 5 \* 255 + 0) # 1.5.0
-    ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt $(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
-      CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
-    endif
   else
     dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
   endif
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 86e06f136f40..927622ecc42e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2729,7 +2729,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index b842273458b8..98454f7a820c 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -322,7 +322,7 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 		if (flags & TEP_FIELD_IS_RELATIVE)
 			offset += fmtf->offset + fmtf->size;
 #endif
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 999dd1700502..296292fa2c04 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2784,7 +2784,7 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 		if (field->flags & TEP_FIELD_IS_RELATIVE)
 			offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 212031b97910..25a276710dfb 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -442,7 +442,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 			if (field->flags & TEP_FIELD_IS_RELATIVE)
 				offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index c097b7934fd4..5bcec514f697 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -393,7 +393,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e930f5f1f36d..759ed6eafa3c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -994,7 +994,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e188f74698dd..cfcc253239f0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -28,6 +28,7 @@
 #include "time-utils.h"
 #include "cgroup.h"
 #include "machine.h"
+#include "trace-event.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 
@@ -2667,7 +2668,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 		if (field->flags & TEP_FIELD_IS_RELATIVE)
 			offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..1a1a2e6b24fb 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -20,6 +20,9 @@ struct trace_event {
 	struct tep_plugin_list	*plugin_list;
 };
 
+/* Computes a version number comparable with LIBTRACEEVENT_VERSION from Makefile.config. */
+#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
+
 typedef char *(tep_func_resolver_t)(void *priv,
 				    unsigned long long *addrp, char **modp);
 
-- 
2.39.0.314.g84b9a713c41-goog

