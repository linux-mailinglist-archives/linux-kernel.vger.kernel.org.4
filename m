Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D26F12C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjD1Hri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbjD1HrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:47:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563765FC7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:45:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555f6759323so156310717b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667862; x=1685259862;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJW1/njAj3I5TfoOZIYiPABtDS/F19x/StsUrA22TLo=;
        b=ckJDi7NZ0gVVnXJVN/5WSW5tmXBnuJCbOC6WYFUpZu7bqgwcpJRbHWKmYPO4hZF4f8
         Of47QunQbGLIyrCV7pm8hsokZIaG7M0sUFo9IyhdEtdHQmTsjDvorr39NtuSQjXp3Xp1
         wMkXyQdyQihMseXEeriCDzXl+btQCZGhJLDujNRNZlrIlWskQTl/9HZHdvmM58Y4UYDk
         ROvQYWhyaZMvt//2ah8bktaOKkvbuCmKcM6Clq4GESdLzB/7f5z+XbeH8Xkp2D1qpSK+
         oG2oqc5om7gzkJAHHc/LNskoI6cd/uGly1GiFmGk6m51G3r+oW46zOsnyAifID4iiBQr
         axew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667862; x=1685259862;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJW1/njAj3I5TfoOZIYiPABtDS/F19x/StsUrA22TLo=;
        b=O3hPb0oUPUBeT3xM7LwpPocnaOlhssuLSD0ZxHDKge+uDxHRDb4BnJ9tp+yzVZfC3S
         OFjWIdcxspqbTeOs1F4AHrZKvbXnkTtxJjXEPCQVR1YXyVSNMzvgKDGtetl4XZFao0bd
         H+1Zi27tY1X2g4GS14XVU08ggERNnnvFpQwqwJY4SjX5b3wPSE/kElBWBQ0ZDM6DkHdW
         CNkM1A/E04K/A6adjS685jtsygTI22wj00KwlR13HLmyZMPcFLK3ZMSLy38BeSUQLqFp
         uUlLr76voj0mT44T24sHqQdruFSbMZJJZhtc71POYC0vN0VvyhYOx6+PQIDrud2R/SrA
         a39w==
X-Gm-Message-State: AC+VfDzK87j3LfZ+2kPaw+87PgmeI0wx8Nv73SkCsSODM3n8wityXBSs
        OcxG3aAnXK1wcTj3ZrwYe+l1r2/ThgNB
X-Google-Smtp-Source: ACHHUZ7sVlDXNtg6gUChyNqTRybxOs1j94ari1qaF1ioDW1RTA73zCkdS5NP7Gh17HToIbd0uU8dBExskq69
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:ac5b:0:b0:556:fa9:f1c7 with SMTP id
 z27-20020a81ac5b000000b005560fa9f1c7mr2529667ywj.10.1682667862557; Fri, 28
 Apr 2023 00:44:22 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:09 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-44-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 43/43] perf parse-events: Reduce scope of is_event_supported
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move to print-events.c and make static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 39 ----------------------------------
 tools/perf/util/parse-events.h |  2 --
 tools/perf/util/print-events.c | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9cd823fce247..bf58de8c7cf6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,7 +28,6 @@
 #include "util/bpf-filter.h"
 #include "util/util.h"
 #include "tracepoint.h"
-#include "thread_map.h"
 
 #define MAX_NAME_LEN 100
 
@@ -133,44 +132,6 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-bool is_event_supported(u8 type, u64 config)
-{
-	bool ret = true;
-	int open_return;
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type = type,
-		.config = config,
-		.disabled = 1,
-	};
-	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
-
-	if (tmap == NULL)
-		return false;
-
-	evsel = evsel__new(&attr);
-	if (evsel) {
-		open_return = evsel__open(evsel, NULL, tmap);
-		ret = open_return >= 0;
-
-		if (open_return == -EACCES) {
-			/*
-			 * This happens if the paranoid value
-			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that
-			 * by default as some ARM machines do not support it.
-			 *
-			 */
-			evsel->core.attr.exclude_kernel = 1;
-			ret = evsel__open(evsel, NULL, tmap) >= 0;
-		}
-		evsel__delete(evsel);
-	}
-
-	perf_thread_map__put(tmap);
-	return ret;
-}
-
 const char *event_type(int type)
 {
 	switch (type) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 2a8cafe0ee8f..2021fe145410 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -18,8 +18,6 @@ struct parse_events_error;
 struct option;
 struct perf_pmu;
 
-bool is_event_supported(u8 type, u64 config);
-
 const char *event_type(int type);
 
 /* Arguments encoded in opt->value. */
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index d416c5484cd5..45a625ab4e1a 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -27,6 +27,7 @@
 #include "tracepoint.h"
 #include "pfm.h"
 #include "pmu-hybrid.h"
+#include "thread_map.h"
 
 #define MAX_NAME_LEN 100
 
@@ -224,6 +225,44 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 	strlist__delete(sdtlist);
 }
 
+static bool is_event_supported(u8 type, u64 config)
+{
+	bool ret = true;
+	int open_return;
+	struct evsel *evsel;
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.disabled = 1,
+	};
+	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
+
+	if (tmap == NULL)
+		return false;
+
+	evsel = evsel__new(&attr);
+	if (evsel) {
+		open_return = evsel__open(evsel, NULL, tmap);
+		ret = open_return >= 0;
+
+		if (open_return == -EACCES) {
+			/*
+			 * This happens if the paranoid value
+			 * /proc/sys/kernel/perf_event_paranoid is set to 2
+			 * Re-run with exclude_kernel set; we don't do that
+			 * by default as some ARM machines do not support it.
+			 *
+			 */
+			evsel->core.attr.exclude_kernel = 1;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
+		}
+		evsel__delete(evsel);
+	}
+
+	perf_thread_map__put(tmap);
+	return ret;
+}
+
 int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct perf_pmu *pmu = NULL;
-- 
2.40.1.495.gc816e09b53d-goog

