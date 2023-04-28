Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF856F1299
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbjD1HmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjD1HlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:41:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BC59F1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a753ce33cso3285339276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667656; x=1685259656;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1UrpzSlF6e1IL2Ub99FazCajkEnmAPiwupuP2N/bo=;
        b=WbeD55FD/AXjfAsTkDotpJL0au7iu5wE0rmKDc9KCwMs0A5eegIalBEGvnrc5duQnq
         9jrm8XtiR42DnjVlcEeMIFIraQD183z2RhPsNCipdKheBRHgNQFz8kDQaDBG8TXoNCF0
         WYUXeC+MhOdL+K296ehziK0/q+Q24KmsqTwj02CBH7xOREVDKGo1HBaahTqeaP5Hh4ZE
         ZmCX6UfkMZnSmN1P+lWah0B0fll2UZPFV14lL9e9x5/s3KfSdyfQXFiVwYx5CGE7AL5N
         nZLOtOsOFnTWoa31T+M6pXCT5/VBaqH26qJdVwn6mlDhj2aIaC5rNnkkcpxgcHYKpwdr
         Svdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667656; x=1685259656;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1UrpzSlF6e1IL2Ub99FazCajkEnmAPiwupuP2N/bo=;
        b=LQsmO0olRJvmzy54UjBnngp1hYpoWFDk/wRirEG0FgKg15VcGZsKKxA7ioR+FowYA6
         oFFY0ohjxuiXQsGY9HLwSe+oOW5S5NWpdpY8+bOOa0iVvmeY0plV+v8I7hVBJgd3IEDc
         uCmvxXggc+1RZOdWC/5o1lFPvdYrGpT1m7PJsz14y5tYkVPfhBKOKIH0dOVrTkZAZCDv
         kaPjYLpKV6W71a2Ev8BY/BZVcOVBAcwnJecLTnvswXKnu8PbgF34cNFGfxBEmJMo8BFY
         M+93+uLH5/D+RXtNvy4/4VhjP+o2U+hrzv3Qh4vPYQUkJYEGRESv3YCAfu1B9kV8utML
         W5mw==
X-Gm-Message-State: AC+VfDxRbU61lPJnjDwmpOwgvQI9sklnQ5Uzbte9rgy3z/S45Cq2G5uO
        t3cuuXmS4WBnwavUi5FeMQI6pzGkZ3R7
X-Google-Smtp-Source: ACHHUZ6Za4HfU3R3K1Qb+acJRn4V3kZ7LYaQH7bCLULSJ/cSWM2onAta7gj72f4iYrh9JTJnxp8bxln+moQN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c3:b0:b95:6b30:9752 with SMTP
 id ck3-20020a05690218c300b00b956b309752mr2485546ybb.12.1682667656306; Fri, 28
 Apr 2023 00:40:56 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:43 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-18-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 17/43] perf print-events: Avoid unnecessary strlist
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

The strlist in print_hwcache_events holds the event names as they are
generated, and then it is iterated and printed. This is unnecessary
and each event can just be printed as it is processed.
Rename the variable i to res, to be more intention revealing and
consistent with other code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 60 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 386b1ab0b60e..93bbb868d400 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -226,58 +226,60 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 
 int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	struct strlist *evt_name_list = strlist__new(NULL, NULL);
-	struct str_node *nd;
+	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
 
-	if (!evt_name_list) {
-		pr_debug("Failed to allocate new strlist for hwcache events\n");
-		return -ENOMEM;
-	}
 	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
 		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
 			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
-			for (int i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
+			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
 				struct perf_pmu *pmu = NULL;
 				char name[64];
 
-				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
+				__evsel__hw_cache_type_op_res_name(type, op, res,
+								   name, sizeof(name));
 				if (!perf_pmu__has_hybrid()) {
 					if (is_event_supported(PERF_TYPE_HW_CACHE,
-							       type | (op << 8) | (i << 16)))
-						strlist__add(evt_name_list, name);
+								type | (op << 8) | (res << 16))) {
+						print_cb->print_event(print_state,
+								"cache",
+								/*pmu_name=*/NULL,
+								name,
+								/*event_alias=*/NULL,
+								/*scale_unit=*/NULL,
+								/*deprecated=*/false,
+								event_type_descriptor,
+								/*desc=*/NULL,
+								/*long_desc=*/NULL,
+								/*encoding_desc=*/NULL);
+					}
 					continue;
 				}
 				perf_pmu__for_each_hybrid_pmu(pmu) {
 					if (is_event_supported(PERF_TYPE_HW_CACHE,
-					    type | (op << 8) | (i << 16) |
+					    type | (op << 8) | (res << 16) |
 					    ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT))) {
 						char new_name[128];
-							snprintf(new_name, sizeof(new_name),
-								 "%s/%s/", pmu->name, name);
-							strlist__add(evt_name_list, new_name);
+						snprintf(new_name, sizeof(new_name),
+							"%s/%s/", pmu->name, name);
+						print_cb->print_event(print_state,
+								"cache",
+								pmu->name,
+								name,
+								new_name,
+								/*scale_unit=*/NULL,
+								/*deprecated=*/false,
+								event_type_descriptor,
+								/*desc=*/NULL,
+								/*long_desc=*/NULL,
+								/*encoding_desc=*/NULL);
 					}
 				}
 			}
 		}
 	}
-
-	strlist__for_each_entry(nd, evt_name_list) {
-		print_cb->print_event(print_state,
-				"cache",
-				/*pmu_name=*/NULL,
-				nd->s,
-				/*event_alias=*/NULL,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				event_type_descriptors[PERF_TYPE_HW_CACHE],
-				/*desc=*/NULL,
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-	}
-	strlist__delete(evt_name_list);
 	return 0;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

