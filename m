Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F1706BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjEQPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjEQO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:59:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413FA5E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed50e1so837807276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335547; x=1686927547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIHJY1c1GNTLAYnNmYaDkKa9lZTOh2b6niLk2VTctc8=;
        b=pxyOdOPcLeT6SLboxl+va0YTH/BsH/WhlGhRC8pe6tTnbsMIdRyG0ljVQgrfT8/A8r
         fHvHHGLrVngOEpDdDgGQ/09tMmOCv5Pd+bzMJ8A6Uf10qZJwlTueTs04oEGGm5WcsVnP
         Y/7WQj0iNx+k9UwcOOyI3vrA9ToOOeoiEvdIHeNrh34EUHRDGeY2qXrIHqEvL63QfSZC
         /AdbXBTkhLbvzXcDkiwdg0OsQFcz+JJjaJ82m4OB7aNqr6kHrNQ41oUtUv7j7Ww59sw7
         cbJLxixjt3K+5zNozwloPn1RZ2pUcuxs8TTZ/XY0/5YznWMiWRF5VWi8Jq6zdmqyrXti
         VatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335547; x=1686927547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIHJY1c1GNTLAYnNmYaDkKa9lZTOh2b6niLk2VTctc8=;
        b=ZxaU8GJqM8+MngYyjNrzK7IHrYm1dUgX4C2vz/abGcWqrzl4VyRKSJsvnQJTmYXHaS
         rIySYrwVNGPEyDvvxjQT7/oId2AcKnFv3erTO4r68qWzAON5zphKv6uI+pGmRNQiGz60
         pagnOdz8LQz1F7FcbpdACk+DGTDb+futD4EXBxy5Me2bO/602ua6yK6HBJ3R9Rjrh/vF
         /D9vl9IHrEpSjKeJIQGnByYJJARQOHMk3IXhs6BXGeH9yuPwl0WAEJBxswRTZYWgQbVK
         qGGtc4llGHyA+/u+92ZZgqa9yFbGD4j25bWui3TomAcPAiyBEzrmzoxVi6iG00I5o79o
         ju1A==
X-Gm-Message-State: AC+VfDzM/p0cxylD1rRZ+OZj/pJnIxtjQ3VmaygbG+/n3DPfqmCbbn8I
        MzVs1PlBDLaelUJ4xw38oM9fPZuAjOL/
X-Google-Smtp-Source: ACHHUZ6D58g6NbtAP9zKEFLU8vrjmWED8tztuQXAU+VNZz78a2f/hTIcWDz3GtSipqhipXcFNnpDY3NOLIWG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a05:6902:104:b0:ba7:8628:93e2 with SMTP id
 o4-20020a056902010400b00ba7862893e2mr1613221ybh.4.1684335547066; Wed, 17 May
 2023 07:59:07 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:54 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-15-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 14/23] perf stat: Avoid hybrid PMU list
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
        Raul Silvera <rsilvera@google.com>,
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

perf_pmu__is_hybrid implicitly uses the hybrid PMU list. Instead
return false if hybrid isn't present, if it is then see if any evsel's
PMUs are core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ede0477d958a..164715113b9e 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -19,7 +19,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include "iostat.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -680,11 +680,14 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
+	if (!perf_pmu__has_hybrid())
+		return false;
+
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->pmu_name &&
-		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+		struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+		if (pmu->is_core)
 			return true;
-		}
 	}
 
 	return false;
-- 
2.40.1.606.ga4b1b128d6-goog

