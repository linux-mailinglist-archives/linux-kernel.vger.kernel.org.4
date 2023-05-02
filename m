Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4A6F4D49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjEBW5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjEBW5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:57:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4DA3A88
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:56:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a776a5eb2so9973169276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683068137; x=1685660137;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEgpbeTkYS2FHMjnmLxMSY6ngIlZOzdEJwjzo/4s4WU=;
        b=3dYfCJ2DpUmnAGItcsliPghXbfkdsbtO8Pv7WiOm01YrcwNDqg1rtAK7dKsEpLIa3w
         fKkAC+QCYK7efMokE8kOKI1svB2GgePo9SEeq2DXv8yxkaLIfVL68rvgO/1TDQX8UOpE
         UowMwrED8lLczAwPcKPHvAs0o1QntXdEh43ka1dahWo8gGLlF2yRWBZCSz/9+SZrsFTj
         CSA4W3gpuiXR6tscdAZhw39LFgQO8K+UCuAwVWVMbk0QguTsTozWCXPlqCSE5e1i40FN
         ppXuONpzY46APqdwuMM07G/Zazp0+xf0RbhvmwmSlGyelFqCrgJDpYlmihd0jZxDw3VP
         wRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683068137; x=1685660137;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEgpbeTkYS2FHMjnmLxMSY6ngIlZOzdEJwjzo/4s4WU=;
        b=k/lRDB4RRpp6IDpESrrEB2l+Dz8BARD36H61ki30w7WvSHiUvsn+OPUvMv1HChPCB1
         Natfg+SfamKVAeslRDiesfZhKIojW/U936gN5hl406/ZD4BsdS6OFNNkYUMO2eHogEhN
         rYHktiFQiHa7GGMGX/mfsoQXnOeWJVBAIRvZq4ueo3stCItHV/LZgDiVKBkb6IVPk/0C
         sJO2NJFwRiXSHR83wSxLigLymq2/Z+0njrmydgGVE7Q7i2hyKWIozxlugTZnV0Oy2MCR
         aMrM25Vrzh6SGY+3uAw4G5OPPHn9wZJ1ywk++Ejmwd8jyhuba3QRIgHWrB9WnguvT5KR
         F0ig==
X-Gm-Message-State: AC+VfDw607i7dy0FEri0p4nEh/US7It/VxIklD4o5G09dHYAXXNv8cCS
        MgxgSzKbObXSgTUxQF6yOFXdC7SrgMdm
X-Google-Smtp-Source: ACHHUZ7iAK7rWgSBX+DL5Qb5w89koRRW8YSxJzIwr8QMxTu7l35yOhMQy7ytDbOexlY9ioNBFJwmz0SHhJO1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:a745:0:b0:545:f7cc:f30 with SMTP id
 e66-20020a81a745000000b00545f7cc0f30mr11393988ywh.0.1683067466155; Tue, 02
 May 2023 15:44:26 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:51 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-45-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 44/44] perf parse-events: Reduce scope of is_event_supported
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 2dad88a6bf19..b93264f8a37c 100644
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
index d148842b205a..69492cbd6921 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -27,6 +27,7 @@
 #include "tracepoint.h"
 #include "pfm.h"
 #include "pmu-hybrid.h"
+#include "thread_map.h"
 
 #define MAX_NAME_LEN 100
 
@@ -228,6 +229,44 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
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

