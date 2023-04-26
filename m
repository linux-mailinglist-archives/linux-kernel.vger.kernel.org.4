Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A466EEED8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjDZHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbjDZHFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:05:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DAE30F1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:04:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f87c0a000so115020077b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492640; x=1685084640;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fotq48KuHjkkIqG4O4kp4abkW0OJKtGhJmftikqrD/I=;
        b=66Qm0Q8h+ZjEnpmdbko0kuaWNgjLAHEik525Eac6BYzO4ziIisoOVUY/uFMqlWhAFV
         gwYZVAaC8myOIa1hIZ4tCrI7dHYsG/XB+NHq26wnMLXyBWrK0LHRN0PoxgVGtfg3ihtu
         R5jsvMliOqkyPu0Lf1JvNiDFWo/he4dSzlE/2GiaJErmKjBaGnT6VlCUPNrl6EBB7R/4
         6AVOeWsic7b7Ib1n7u1PHgz3eecXVUG2xeOov6vR19y8ehUq5y1KtP7jTxIh0JFAG+Q3
         yuaqIiqVBufD5Jr9JVlDvK3jzWQCHUmusf2EEiQsV/GVltI5LhCf/Ar1FexQEd0WZA6B
         uhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492640; x=1685084640;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fotq48KuHjkkIqG4O4kp4abkW0OJKtGhJmftikqrD/I=;
        b=anvv6eqGHb5/qsEYgYP0UVRmzz/2ZGLIv6HBnSBehs/9VESC48NtFHS9/Gbpbcp5Tg
         l0ek8tuTMldTMfQzcdw5/CmG6Rm6uHaqAj6JhKbfO0W0LQW11IWRY3rKqyf4pASrdmfg
         tduEUoXT8V9xX/CTXufmy4kYBherZtLp/lNdnt9UC6dmEXaIYg0kvjA2Vaq0ojePGnO3
         jVDWz1HrwNXkLkcjjTsD1Bi27HhE7omwtPTUSaBdk+rs2h8RLBebHtjMJFLhWvBbhOvT
         FKaIf3qrcu4jrjRwVtBaRg0slSHAY17EPmOe748LCoczxhxOWFmmwPMqz/15j5MMNB6Z
         xJbg==
X-Gm-Message-State: AAQBX9cGOwl7lQnwHwZYV6O7sxJIiNPAO0KZbGqoqKb/Cs4a9bi7d6/C
        UHOPQPnBccS20l1/NpJngl1bUgIH8CMX
X-Google-Smtp-Source: AKy350a6sV2D51xiHw5wC4xT9XS+ki8UCIzWRsG+pdt3mBmdRlbZxumLBo8ejsUnhQRGr2xKljbpNHfBthH6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a0d:ec48:0:b0:54f:899f:890f with SMTP id
 r8-20020a0dec48000000b0054f899f890fmr10261442ywn.9.1682492639957; Wed, 26 Apr
 2023 00:03:59 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:32 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-23-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 22/40] perf print-events: Print legacy cache events for
 each PMU
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

Mirroring parse_events_add_cache, list the legacy name alongside its
alias with the PMU. Remove the now unnecessary hybrid logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  2 +-
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/print-events.c | 85 ++++++++++++++++------------------
 3 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e007b2bc1ab4..ae421a5c9ddd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -413,7 +413,7 @@ static int config_attr(struct perf_event_attr *attr,
  *                                     contain hyphens and the longest name
  *                                     should always be selected.
  */
-static int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config)
+int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config)
 {
 	int len, cache_type = -1, cache_op = -1, cache_result = -1;
 	const char *name_end = &name[strlen(name) + 1];
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0c26303f7f63..4e49be290209 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -173,6 +173,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_error *error,
 			   struct list_head *head_config);
+int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct list_head *list, int *idx,
 				u64 addr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 93bbb868d400..d416c5484cd5 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -226,56 +226,49 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 
 int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
 {
+	struct perf_pmu *pmu = NULL;
 	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
 
-	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-			/* skip invalid cache type */
-			if (!evsel__is_cache_op_valid(type, op))
-				continue;
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		/*
+		 * Skip uncore PMUs for performance. Software PMUs can open
+		 * PERF_TYPE_HW_CACHE, so skip.
+		 */
+		if (pmu->is_uncore || pmu->type == PERF_TYPE_SOFTWARE)
+			continue;
 
-			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
-				struct perf_pmu *pmu = NULL;
-				char name[64];
-
-				__evsel__hw_cache_type_op_res_name(type, op, res,
-								   name, sizeof(name));
-				if (!perf_pmu__has_hybrid()) {
-					if (is_event_supported(PERF_TYPE_HW_CACHE,
-								type | (op << 8) | (res << 16))) {
-						print_cb->print_event(print_state,
-								"cache",
-								/*pmu_name=*/NULL,
-								name,
-								/*event_alias=*/NULL,
-								/*scale_unit=*/NULL,
-								/*deprecated=*/false,
-								event_type_descriptor,
-								/*desc=*/NULL,
-								/*long_desc=*/NULL,
-								/*encoding_desc=*/NULL);
-					}
+		for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
+			for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
+				/* skip invalid cache type */
+				if (!evsel__is_cache_op_valid(type, op))
 					continue;
-				}
-				perf_pmu__for_each_hybrid_pmu(pmu) {
-					if (is_event_supported(PERF_TYPE_HW_CACHE,
-					    type | (op << 8) | (res << 16) |
-					    ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT))) {
-						char new_name[128];
-						snprintf(new_name, sizeof(new_name),
-							"%s/%s/", pmu->name, name);
-						print_cb->print_event(print_state,
-								"cache",
-								pmu->name,
-								name,
-								new_name,
-								/*scale_unit=*/NULL,
-								/*deprecated=*/false,
-								event_type_descriptor,
-								/*desc=*/NULL,
-								/*long_desc=*/NULL,
-								/*encoding_desc=*/NULL);
-					}
+
+				for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
+					char name[64];
+					char alias_name[128];
+					__u64 config;
+					int ret;
+
+					__evsel__hw_cache_type_op_res_name(type, op, res,
+									name, sizeof(name));
+
+					ret = parse_events__decode_legacy_cache(name, pmu->type,
+										&config);
+					if (ret || !is_event_supported(PERF_TYPE_HW_CACHE, config))
+						continue;
+					snprintf(alias_name, sizeof(alias_name), "%s/%s/",
+						 pmu->name, name);
+					print_cb->print_event(print_state,
+							"cache",
+							pmu->name,
+							name,
+							alias_name,
+							/*scale_unit=*/NULL,
+							/*deprecated=*/false,
+							event_type_descriptor,
+							/*desc=*/NULL,
+							/*long_desc=*/NULL,
+							/*encoding_desc=*/NULL);
 				}
 			}
 		}
-- 
2.40.1.495.gc816e09b53d-goog

