Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069746F2326
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347321AbjD2Fit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbjD2Fih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:38:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4E3C16
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:38:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7766d1f2so589677276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746673; x=1685338673;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1UrpzSlF6e1IL2Ub99FazCajkEnmAPiwupuP2N/bo=;
        b=jWNONZprXKMNXC1M/BE62Rc9N1DG0dhUBrVLMs1pgzFvX42kZpdYOXcpmuhniB9SDj
         blFNIVkszyQPrh02mFojCC/kfpvGEzHzdwyWb1Kia5mRmYLT8DozCuSZ9EoRLbXHvrCX
         kNPAa5T8zM7aWmvtjO4anjHLACOoAHs/5fs9mvdDrJu60Ddmnqs2KxZjTg8tLunsXBxC
         OMKOiDm72yZMR8sGVsYfdtBxfY5ImLUQqaXaOL0gqtbdzU7Q83nFc9odJLBpKrstceyQ
         8D/QjNn/eDPljRi/KRv+DfS9w5G/8+WBtfAJIaIhf5BIMCbP9+RVgiH4SOxs8alv0W1Z
         5DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746673; x=1685338673;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1UrpzSlF6e1IL2Ub99FazCajkEnmAPiwupuP2N/bo=;
        b=WUuHV1qF7wEBYCCl5Hv6rR4g8es6W82sFXFCR4K2se4PA9/2tPCJLPUeF2H2wWCe1e
         mWi7UKN2L8aZMlDDozNoYqaPNwzVO2qS1b40Bui9Ro7eNkAGZUyrk/5gQGOMbC1MYvYN
         WE4mQQvwMNz4x4sj8MsxLOUBJg8MG3ZJc6m+lbdao/9JV15+ECRLsnCHbR8FI5iCwxok
         mQTU+L/XEnK9xhTWbw6/N/MFsRMgeBVlVMsEhh/1pmr7jykjGWj7TYp2MTwy8cgBpWO6
         VyI5OjLmJ7QPD01IjLdvjHTM0lyY9bSmXHTWelqHsFfov4ejx4hrOpHFm83ayYmKn2vy
         hDZA==
X-Gm-Message-State: AC+VfDwVQN7YTxMLJr6Vyyc8Vi246kjmoiPzSzoWyQ76FegD27U5ogrJ
        S+pYPHjKdw8LFwu8gYXEI+UltTg+fVXy
X-Google-Smtp-Source: ACHHUZ4zhSjOUlUB3901TXdCEvm9WT9oIfHc+7dfa3l3pkbcQh3AGMzAsGSo8w4Bb9j/twtqAQt++sQlA9bJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1891:b0:b99:4c9d:3b5a with SMTP
 id cj17-20020a056902189100b00b994c9d3b5amr4638533ybb.7.1682746673044; Fri, 28
 Apr 2023 22:37:53 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:39 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-20-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 19/46] perf print-events: Avoid unnecessary strlist
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

