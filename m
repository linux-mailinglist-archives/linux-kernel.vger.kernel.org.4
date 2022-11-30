Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9563CF35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiK3GaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiK3GaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:30:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F512391DE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:30:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d2994e2d7dso25014787b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lha3Kd4WHFBCvvAfaMAOkc1TPFOurCRe2KIXhb9Lg+s=;
        b=tbYWTlkoh3HC2/boHCOqE4z2jFROYutDeVXnfVOM/WaEQ5V0AiMbkUWKqaHYr6SxPj
         RgDTxtorxl6kfuoCRbUFrZw9hsijqLjhV4mVEBK8Z735bpm/HNvl1SIGdlIyOlcDuz7e
         I2Ljg0BFulbygmqyKrZxqdDa8oELnS75fw5Gmmy+Aei0AKbmPtfhRCY0tM/OL0Xx4Q9c
         8p+KMxNFnCMCbU7V+rTX24i0zUfXKhsZRiSHkZXpQuLQbMsgwDqGZu+mA27srobQamV2
         HRsjvI7ylALkNuvVnG8UVvVdVdXrDZaVzteDqFgiKjTsQA2G6u2R6NA2Ka8Gls/FIPI0
         PFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lha3Kd4WHFBCvvAfaMAOkc1TPFOurCRe2KIXhb9Lg+s=;
        b=u/kCghncnRvKE7L3eXu1iON16RK8TZ9nDyb7kL41AqF3dpZuEF1hauOollo0OKSDqD
         L1lSaUdAi53WL3WqD5WK8xxZBzD8ctFOaJrR21kaUinCVECz+l+s49hMMgK6fO9sDknb
         8+Gy34myFMVH/DIQUdY8OBYt+p4Hhv9RnmygpCoHKE065kLsKkdZavXq87/5L1xKf21y
         VG2C7etRhls/zEhFSh4Wvg47bY3yAxi9v7zUIGNqxkzlMIaZGMCI5Hb7hUke/5QHULjQ
         5v87KyLaJBSKYQLQD8m7NtpifUfz1ZYG/NqwaE3t+bMN4+X0pvcC1eSjd5iURJUDvZhY
         3CyQ==
X-Gm-Message-State: ANoB5pl6QpGCNbk+zy7kl7oMdFEoH0mrNl/8NISEfk0P6iTRWxoERT4c
        nAFK5IeqcpBqF8MquE900lgthxv0BtKK
X-Google-Smtp-Source: AA0mqf5QbZ0WaudvfB0LFXVWYxcBY4hUbCSZVBwOtqtrh6E3uwvyJrfCLcf8gh2ubZUYVb/po0pu4m8pJjOs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:788c:ccf4:3670:3362])
 (user=irogers job=sendgmr) by 2002:a25:c5d4:0:b0:6cc:7860:8452 with SMTP id
 v203-20020a25c5d4000000b006cc78608452mr55001151ybe.51.1669789801589; Tue, 29
 Nov 2022 22:30:01 -0800 (PST)
Date:   Tue, 29 Nov 2022 22:29:33 -0800
In-Reply-To: <20221130062935.2219247-1-irogers@google.com>
Message-Id: <20221130062935.2219247-3-irogers@google.com>
Mime-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 2/4] perf util: Add host_is_bigendian to util.h
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid libtraceevent dependency for tep_is_bigendian or trace-event.h
dependency for bigendian. Add a new host_is_bigendian to util.h, using
the compiler defined __BYTE_ORDER__ when available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c    |  4 ++--
 tools/perf/tests/sample-parsing.c  |  4 ++--
 tools/perf/util/evsel.c            |  5 +----
 tools/perf/util/trace-event-info.c | 14 +++-----------
 tools/perf/util/trace-event-read.c |  3 ++-
 tools/perf/util/trace-event.h      |  2 --
 tools/perf/util/util.h             | 19 +++++++++++++++++++
 7 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 95feb6ef34a0..cb8cd09938d5 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -16,7 +16,6 @@
 #include "dso.h"
 #include "env.h"
 #include "parse-events.h"
-#include "trace-event.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
@@ -28,6 +27,7 @@
 #include "util/mmap.h"
 #include "util/string2.h"
 #include "util/synthetic-events.h"
+#include "util/util.h"
 #include "thread.h"
 
 #include "tests.h"
@@ -79,7 +79,7 @@ static size_t read_objdump_chunk(const char **line, unsigned char **buf,
 	 * see disassemble_bytes() at binutils/objdump.c for details
 	 * how objdump chooses display endian)
 	 */
-	if (bytes_read > 1 && !bigendian()) {
+	if (bytes_read > 1 && !host_is_bigendian()) {
 		unsigned char *chunk_end = chunk_start + bytes_read - 1;
 		unsigned char tmp;
 
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 20930dd48ee0..927c7f0cc4cc 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -13,7 +13,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "util/synthetic-events.h"
-#include "util/trace-event.h"
+#include "util/util.h"
 
 #include "tests.h"
 
@@ -117,7 +117,7 @@ static bool samples_same(const struct perf_sample *s1,
 		COMP(branch_stack->hw_idx);
 		for (i = 0; i < s1->branch_stack->nr; i++) {
 			if (needs_swap)
-				return ((tep_is_bigendian()) ?
+				return ((host_is_bigendian()) ?
 					(FLAG(s2).value == BS_EXPECTED_BE) :
 					(FLAG(s2).value == BS_EXPECTED_LE));
 			else
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 45f4f08399ae..0f617359a82f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2320,11 +2320,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 	 * as it has variable bit-field sizes. Instead the
 	 * macro takes the bit-field position/size,
 	 * swaps it based on the host endianness.
-	 *
-	 * tep_is_bigendian() is used here instead of
-	 * bigendian() to avoid python test fails.
 	 */
-	if (tep_is_bigendian()) {
+	if (host_is_bigendian()) {
 		new_val = bitfield_swap(value, 0, 1);
 		new_val |= bitfield_swap(value, 1, 1);
 		new_val |= bitfield_swap(value, 2, 1);
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 892c323b4ac9..c24b3a15e319 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -26,6 +26,7 @@
 #include <api/fs/tracing_path.h>
 #include "evsel.h"
 #include "debug.h"
+#include "util.h"
 
 #define VERSION "0.6"
 #define MAX_EVENT_LENGTH 512
@@ -38,15 +39,6 @@ struct tracepoint_path {
 	struct tracepoint_path *next;
 };
 
-int bigendian(void)
-{
-	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4, 0x0, 0x0, 0x0, 0x0};
-	unsigned int *ptr;
-
-	ptr = (unsigned int *)(void *)str;
-	return *ptr == 0x01020304;
-}
-
 /* unfortunately, you can not stat debugfs or proc files for size */
 static int record_file(const char *file, ssize_t hdr_sz)
 {
@@ -79,7 +71,7 @@ static int record_file(const char *file, ssize_t hdr_sz)
 
 	/* ugh, handle big-endian hdr_size == 4 */
 	sizep = (char*)&size;
-	if (bigendian())
+	if (host_is_bigendian())
 		sizep += sizeof(u64) - hdr_sz;
 
 	if (hdr_sz && pwrite(output_fd, sizep, hdr_sz, hdr_pos) < 0) {
@@ -564,7 +556,7 @@ static int tracing_data_header(void)
 		return -1;
 
 	/* save endian */
-	if (bigendian())
+	if (host_is_bigendian())
 		buf[0] = 1;
 	else
 		buf[0] = 0;
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 8a01af783310..43146a4ce2fb 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -17,6 +17,7 @@
 
 #include "trace-event.h"
 #include "debug.h"
+#include "util.h"
 
 static int input_fd;
 
@@ -414,7 +415,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 		return -1;
 	}
 	file_bigendian = buf[0];
-	host_bigendian = bigendian();
+	host_bigendian = host_is_bigendian() ? 1 : 0;
 
 	if (trace_event__init(tevent)) {
 		pr_debug("trace_event__init failed");
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 640981105788..8f39f5bcb2c2 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -27,8 +27,6 @@ trace_event__tp_format(const char *sys, const char *name);
 
 struct tep_event *trace_event__tp_format_id(int id);
 
-int bigendian(void);
-
 void event_format__fprintf(struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 63cdab0e5314..87d418cb6792 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -94,4 +94,23 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
 		0;						\
 	})
 
+static inline bool host_is_bigendian(void)
+{
+#ifdef __BYTE_ORDER__
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	return false;
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	return true;
+#else
+#error "Unrecognized __BYTE_ORDER__"
+#endif
+#else
+	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4, 0x0, 0x0, 0x0, 0x0};
+	unsigned int *ptr;
+
+	ptr = (unsigned int *)(void *)str;
+	return *ptr == 0x01020304;
+#endif
+}
+
 #endif /* __PERF_UTIL_H */
-- 
2.38.1.584.g0f3c55d4c2-goog

