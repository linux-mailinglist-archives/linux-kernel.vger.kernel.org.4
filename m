Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22D70B546
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjEVGp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjEVGpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:45:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519510F6
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559c416b024so65827437b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737845; x=1687329845;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP27CftfdHYnLweWt0lX22v4lNIGIpmQh1ljDLrV4jA=;
        b=MhqwCJBtPyT5b02ahng0nI7ganYJvCeSMOskyson56OnoKeJ481W1TYdZWj1JoQ95r
         wuDPYIkhk/NZwXe0CTxVQKbfv+gqsM0j26sRc+OeTdtmHigaxZV6fk/yseq3N0YnQHX9
         0KnUlv9Zqv7SggUA1BhxajbxFcxpcDkcYZFIZq04EHtQcg185xnzwBc/fT7tb7tebere
         9XsVoFpw5B5enV926TymTvp6irXOwGEGnbP/Kg9xFJlCyTIF+gVlxrZ8Am7aD97VN0BW
         Na+J7IgiziND4KB+K5rXmzS+kHNRU8d9qu5XJW/oHj2sBTxSLuqP4ed7kGE29lS3EXiw
         3/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737845; x=1687329845;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP27CftfdHYnLweWt0lX22v4lNIGIpmQh1ljDLrV4jA=;
        b=O+bWy2s4aBEc7aQmVbZi/F3uAN7SBWHwGLPAvUBhvuW3g2lWEP30wDvLulj07nRSl8
         ls3/tXw6OD4TT7SyFit2g5kF0smdVVHtx9V14rIoCyA2KiT+mAf+LgzcYrUH2QT5iHlk
         kBc140k3t4nrST5HeOie8VATWufL+7e/4e8qYUdyi/m8Hl1FcPWGT00cXlZQpM7er+aT
         yQXPasrJL369A/gCqkGRp2I0OniFGBTtjomndJ+gJMK1Pliu/Y1tioPgz8EiJcJTchcL
         Y9HpN296VW9lN4ukdOXUjTCPyuC1hXdkALMfHHKuhKoaMQoHxRMUgzrqKmBV2nwKMxs3
         s46A==
X-Gm-Message-State: AC+VfDz1eQJsC8P2aoPpxyjXK0bEjkTfoAvYnPtvxyE9TSrirnPwQoOA
        0WU4vFHNFkFhHZrjZaBqTWZGjE9hhmrC
X-Google-Smtp-Source: ACHHUZ6D6GJ/kDIQ4pJeBPj2fMGgwl7DniHm6drdApF9GQl/cS7AHqn9R8+z1PDzPpRbQhZDI9VADrzkzCRy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a5b:e85:0:b0:ba8:97f8:620f with SMTP id
 z5-20020a5b0e85000000b00ba897f8620fmr5949030ybr.8.1684737845479; Sun, 21 May
 2023 23:44:05 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:20 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-14-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 13/23] perf metrics: Remove perf_pmu__is_hybrid use
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

Switch from perf_pmu__is_hybrid to avoid implicitly using the hybrid
PMU list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7de721e9d895..72583f62eda8 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -11,7 +11,6 @@
 #include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
 #include "print-events.h"
 #include "smt.h"
 #include "expr.h"
@@ -274,7 +273,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
-	bool all_pmus = !strcmp(pmu, "all") || !perf_pmu__is_hybrid(pmu);
+	bool all_pmus = !strcmp(pmu, "all") || !perf_pmu__has_hybrid() || !is_pmu_hybrid(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -288,8 +287,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		struct expr_id_data *val_ptr;
 
 		/* Don't match events for the wrong hybrid PMU. */
-		if (!all_pmus && ev->pmu_name &&
-		    perf_pmu__is_hybrid(ev->pmu_name) &&
+		if (!all_pmus && ev->pmu_name && evsel__is_hybrid(ev) &&
 		    strcmp(ev->pmu_name, pmu))
 			continue;
 		/*
-- 
2.40.1.698.g37aff9b760-goog

