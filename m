Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808276EEECE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbjDZHEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbjDZHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:03:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051B2118
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f32cc8c31so11548913276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492572; x=1685084572;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1UrpzSlF6e1IL2Ub99FazCajkEnmAPiwupuP2N/bo=;
        b=ejl0TCvV5fpMBxQn6WqDGfZmntPZib49H9wwWIPY8XFs7yfIwv8VwQ3QfS9YkPh1Og
         Px/WsHDSFMAKLq0fu2yxkSXbsUp4Ql4Bl9FVt72SAHbzurVY8/RpHLa+tFankZ3yImQA
         MPvRtS4fkqN2e47S13HaP2shRTAgERnbtvKla0n97C1iw+1nZsSRGTj4j/dpa+jEh4as
         q0G3jPvQRXR9OsIYv2fqQyrtAFFsnrTrZQhnIglG925H1VRHYoL+e0a6+xFjhVNPZnLI
         1P+ByINBI07ddf4Q5q72dVEANE2KAl7OggePqrQa4MaVuc3Ic12+iGhgY4ldmajnQOIV
         3/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492572; x=1685084572;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1UrpzSlF6e1IL2Ub99FazCajkEnmAPiwupuP2N/bo=;
        b=Q0mlPz6i0WL8jg8hmnPEiR2ukT7k0yxtWKeoPw/3WGX9vwdbczreB0J3Zl7M78Igzn
         /kdnkQNl+NBVFRyKXnncY1i6MSzSRr0wTHUwpPBEMZiJsrmFAk+OClnnumhX1YDGOV7s
         SSpRDsomW7hIfJXRH7AHbBp4/iwvgQffd8QrCzDVWiXpM2pCbdgXHHGE83nY5Tglygi0
         LRi0MC5KT5TpqKByN1aIKHGsp/eWwDnF+ejij1tWRZXMhk4pbukZtCZVISta1AV7X3Cd
         5Q0IM8Q3yJqXkN7QRiLlXFkeeinPEKxVlzAL2ahvTxEhQNZEkVE/wecRMtI0MaoZsrQy
         AzQQ==
X-Gm-Message-State: AAQBX9eovP8qHiwf5eNMNEjARR+EqBNq2nrKLgahsxJxTCjfQfpSK9B7
        Ra8ASR2BkAqRDG5gxaRB5eNOJyFikneL
X-Google-Smtp-Source: AKy350aTHcKAYafwo7D5bC44MFU0xshxWohk7N7yn3eSmqRtR1KcU5abiEoMavm1OTvq9F911I/F1D2sdIsc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:734e:0:b0:b99:4877:99e4 with SMTP id
 o75-20020a25734e000000b00b99487799e4mr6072621ybc.11.1682492572229; Wed, 26
 Apr 2023 00:02:52 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:24 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-15-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 14/40] perf print-events: Avoid unnecessary strlist
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

