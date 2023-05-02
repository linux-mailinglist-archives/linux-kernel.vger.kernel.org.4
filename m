Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F976F4D04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjEBWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEBWl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:41:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4473A85
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:41:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7d92d0f7so7691262276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067282; x=1685659282;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSuig3L8R5UEDXeqP0djSS5EgyFufZhQb0rbIBIx5wU=;
        b=tDLYa0DQagvJ/QEPb9MjF/kNyIbrftWOqww62OA+GLPcY0iPlzA9ULd7zv3ROY9sar
         WqJIcorOzUgc626O10s3jw3jAjVb1lhnelGHisy/AzS9YiQbhGWMILCDsNslA7qu/XE+
         B3f9unZkl+ue2Q5QZSr/nNdXW2Tx0mwZeBKtc2NjkDCz1vQVctEpZSRnQykEZnJHmVAq
         kDdug1BZcy8lT5cOtr2dGNG1+MixqjPC36LVFwhnWLzOgMc739di1qwHBtxtOoc1s8uG
         edlsXphPdjdnMdCQIY2LUJWLvwQ9xlXP3JQcelH0gfLNcg6Dq8H83iG9gwDRfVQjapaL
         cSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067282; x=1685659282;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSuig3L8R5UEDXeqP0djSS5EgyFufZhQb0rbIBIx5wU=;
        b=j2rXOHZggmX5vt/Ofk4yzOOB/c6yOjvtYiT+8HccPVFIh48w5P8088azA8y/equ2GV
         DYU3mF2mRBRYDGYjysSM9gMObJJynqN7G+3EEasQM+pNnC2RsPGWSw8Q+eTJalgdr0j4
         om5Y68jUXPJ6DPRCwcDQVDDo0Kv8iTxUpjez2PQSfI6CGLN+SRR4TIoccdFwTka2CQhq
         96CeMRNlrOlfrvLbLBDCRfshtpFMo61xtEYRaMdMueUjuh7mqwwIZSCOEZiYArue3iRD
         JJnGAQhCvBblq7q5UT+mDjJDCKKwEY2Pg+q1hUAPqOhxOa/Ks5IoVCJR2UvAODKvqwBS
         xuWg==
X-Gm-Message-State: AC+VfDxNMPiSd0m1gvVftsFTrGPOVp6oMjplko577euNq6vWdMtM5w7J
        OsNN5SCj+tdXQzvo7QVtmKcMfwElgWXj
X-Google-Smtp-Source: ACHHUZ4Sq05iGbzmiRWZnqfkmEkdK/S23O3fX4bTPuRLUM7P1GSv/HY6a7FCp6laKk36EZyzo5FJl5vK7p6I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:4245:0:b0:b97:8207:443b with SMTP id
 p66-20020a254245000000b00b978207443bmr6892574yba.5.1683067282203; Tue, 02 May
 2023 15:41:22 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:24 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-18-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 17/44] perf print-events: Avoid unnecessary strlist
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
index ee145cec42c0..89ac34a922c9 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -230,58 +230,60 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 
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

