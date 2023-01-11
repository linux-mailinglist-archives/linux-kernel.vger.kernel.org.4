Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBB26654FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjAKHHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjAKHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:07:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D8AE77
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:07:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v9-20020a259d89000000b007b515f139e0so15418246ybp.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcIFJ2x72XnzKR9JnqBftaBgEZOVI/IGNNJWfUZh1kA=;
        b=bs7xtaVlYBLFOSzJZ04j49npQTIGs/SIaSKqB8GfS5VJJg+s0RhAnjmxYleMCIVJDH
         hx51RHmyDGfhvz+KDx8Mrc9gGchiuNDvXPc/zCpsmdWxMSFV0Me8j6yEIxDbTjSaOJ/N
         jsRfRdUC33UIBTi0J+WY1/q0jbue1dy81BD+fTEnE9+oe4ywPKoKW/hrU8c1RS2IwSyY
         i4VWyndqnxHly6smvSFU1oXcF9xTY8RCYnrbQuZ8FXpIAKpruu1RuxxJ9xkzksJKQMXv
         79Wii4zxgFbH2fSaza5P3ysc0B2ov15xFaFID3cUKZjX3V8FxdpRJExilSgckqZiXd9z
         6EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcIFJ2x72XnzKR9JnqBftaBgEZOVI/IGNNJWfUZh1kA=;
        b=Rq/VoTxsxXXMC2j/PELSvGBK4EJYA8hjjxkMySNTyHyjiC+1O1st4Zcjmgo77rOre0
         wlQ+OQL7FrKmO9+WBhWkbmJEV7MXRAhnDveTppTuG4uNPfFbdcRDcnwr89YnIe7tLMOO
         HDjDYBmb3z+b6kG5Z6EK62cr9iyGmjZWnjD2Yw2sBGBxgPbDYD+6Rlk1DjxGBJ86qr87
         CJsN9MgQH44IQBDpDpMQE1VUquolUtxfs3w9VAczG5c+MFLSOD59WW17rlBlGIv86sZ2
         EPH2IaqMROkr1CCSKIdVgugua2zHn/xaX4TJPL1SPK6xkp5fe+Cs1ZXoHChq+IZBqkjT
         kQ/Q==
X-Gm-Message-State: AFqh2kqp/JOfd9MZaJrxR6jZTwrOGavTvRnCgENCJVEg14R9/as6Coso
        d1BJTsZeG78E5akay/qtWroed84nrO1Z
X-Google-Smtp-Source: AMrXdXtXbYFw9WkQGSkwH1WYAT/s011j+Z/i7YPLsq5/LNKQff45l5yk2btwJFzkpawdMZcEPh4PvZ4VHo4H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:e309:0:b0:700:b6ef:34a9 with SMTP id
 z9-20020a25e309000000b00700b6ef34a9mr5408985ybd.527.1673420821147; Tue, 10
 Jan 2023 23:07:01 -0800 (PST)
Date:   Tue, 10 Jan 2023 23:06:40 -0800
In-Reply-To: <20230111070641.1728726-1-irogers@google.com>
Message-Id: <20230111070641.1728726-2-irogers@google.com>
Mime-Version: 1.0
References: <20230111070641.1728726-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 2/3] perf trace: Reduce #ifdefs for TEP_FIELD_IS_RELATIVE
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

Add a helper function that applies the mask to test, or returns false
if libtraceevent is too old or not present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                       |  4 +---
 tools/perf/util/data-convert-bt.c                |  4 +---
 tools/perf/util/evsel.c                          |  4 +---
 tools/perf/util/python.c                         |  4 +---
 .../util/scripting-engines/trace-event-perl.c    |  4 +---
 .../util/scripting-engines/trace-event-python.c  |  4 +---
 tools/perf/util/sort.c                           |  4 +---
 tools/perf/util/trace-event.h                    | 16 ++++++++++++++++
 8 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 927622ecc42e..a4240adbe42f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2729,10 +2729,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-				if (field->flags & TEP_FIELD_IS_RELATIVE)
+				if (tep_field_is_relative(field->flags))
 					offset += field->offset + field->size;
-#endif
 			}
 
 			val = (uintptr_t)(sample->raw_data + offset);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 98454f7a820c..2b732bccabad 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -322,10 +322,8 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-		if (flags & TEP_FIELD_IS_RELATIVE)
+		if (tep_field_is_relative(flags))
 			offset += fmtf->offset + fmtf->size;
-#endif
 	}
 
 	if (flags & TEP_FIELD_IS_ARRAY) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 296292fa2c04..8550638587e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2784,10 +2784,8 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-		if (field->flags & TEP_FIELD_IS_RELATIVE)
+		if (tep_field_is_relative(field->flags))
 			offset += field->offset + field->size;
-#endif
 	}
 
 	return sample->raw_data + offset;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 25a276710dfb..d948455e5ed4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -442,10 +442,8 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-			if (field->flags & TEP_FIELD_IS_RELATIVE)
+			if (tep_field_is_relative(field->flags))
 				offset += field->offset + field->size;
-#endif
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 5bcec514f697..83fd2fd0ba16 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -393,10 +393,8 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-				if (field->flags & TEP_FIELD_IS_RELATIVE)
+				if (tep_field_is_relative(field->flags))
 					offset += field->offset + field->size;
-#endif
 			} else
 				offset = field->offset;
 			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 759ed6eafa3c..2c2697c5d025 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -994,10 +994,8 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-				if (field->flags & TEP_FIELD_IS_RELATIVE)
+				if (tep_field_is_relative(field->flags))
 					offset += field->offset + field->size;
-#endif
 			}
 			if (field->flags & TEP_FIELD_IS_STRING &&
 			    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index cfcc253239f0..dcc4ea96236d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2668,10 +2668,8 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
-#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-		if (field->flags & TEP_FIELD_IS_RELATIVE)
+		if (tep_field_is_relative(field->flags))
 			offset += field->offset + field->size;
-#endif
 		/* record max width for output */
 		if (size > hde->dynamic_len)
 			hde->dynamic_len = size;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 1a1a2e6b24fb..ee968e5f6b7a 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -139,4 +139,20 @@ int common_lock_depth(struct scripting_context *context);
 #define SAMPLE_FLAGS_BUF_SIZE 64
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
 
+#if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
+#include <traceevent/event-parse.h>
+
+static inline bool tep_field_is_relative(unsigned long flags)
+{
+	return (flags & TEP_FIELD_IS_RELATIVE) != 0;
+}
+#else
+#include <linux/compiler.h>
+
+static inline bool tep_field_is_relative(unsigned long flags __maybe_unused)
+{
+	return false;
+}
+#endif
+
 #endif /* _PERF_UTIL_TRACE_EVENT_H */
-- 
2.39.0.314.g84b9a713c41-goog

