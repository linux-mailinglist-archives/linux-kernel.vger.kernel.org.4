Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8B712F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbjEZV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbjEZVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:55:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2353310D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56183784dd3so16670987b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138127; x=1687730127;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vW2lbdpPJdg/r6QP2GPnX5xgemELHxkJ0mClCQxJlXE=;
        b=XgJYAm41O7NNFLVHPpeeRZju9bD5zUvsAC0wt/UXOVLw3GOfF0JaoBMe6TBnPqkDUE
         jYdH81MvGVvclARKFyJ+Jgl7dihH7i1nYuM33T1qAdu9hQxuma0ZNocFspbqG5fg53kf
         4CrE581+2bLeQ/wzdCJdRvTbLVN5+U11VRZTFLjVH5/IOwxEBng7w3jNTu1ciOoSniUD
         DFKPeorSfxpLWSMYHLy6dm+O2HDNl5TYai1K5TOZvxeVRCUhuNBy43xF9GawgVp2vtYq
         dC5SFDsDu1an8pxHIAPY58ESVMsOOWY6NjEK8t3G7kD/zcEjKDJ/j8pZhZcvZTis1nwh
         rpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138127; x=1687730127;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW2lbdpPJdg/r6QP2GPnX5xgemELHxkJ0mClCQxJlXE=;
        b=P9ddR7cjoqjlX2iuOdCp4JZc3OZsCYnO67OqfC9zpzNXyFWgpGXDVzBlZbio0SQ25w
         fVqg8qhMozb+cWE/e0IEOHqO7jIBw0xu73aK2y/XRQdSEqRHcIjfcQ1X1WEp/s3kZgXX
         KgI/GkdayA1+XGiVDMyk5VnAjMvmpJCh4bwNxBg6+cOD+ik374DYBVTG1Z8AXTj5rOog
         UF47GXDZ1WmaWwoZEY+1We2GX2ZGzbFJ64ZQbkV+9yFzPliJLU1z3G8R1/WkHXlNO/bp
         xm2R6TfmwthCCJQ1KkQvHpPM4BbXUeAJIaI9m6DCJS/wW7WDHqBCXTg+JK5dIumm9MfD
         TN3A==
X-Gm-Message-State: AC+VfDyNaKH9ojszG0JULPEkutX1NW/qjxoLBY//8B9BS6Vb5crh4baI
        i8ub/aTylPo21UVG8Z0oaZfN/RGkHvqj
X-Google-Smtp-Source: ACHHUZ4NRRDlyH/flCqp3jYK/1HAot9LkkCV9xPcWa5EvIdoqnj1c7Po8JDOungTNQVgPDVDILQcujc4hqvO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:b710:0:b0:565:cfdf:7a70 with SMTP id
 v16-20020a81b710000000b00565cfdf7a70mr64876ywh.2.1685138127743; Fri, 26 May
 2023 14:55:27 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:08 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-34-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 33/35] perf pmus: Add function to return count of core PMUs
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_pmus__num_core_pmus that will count core PMUs holding the
result in a static. Reuse for perf_pmus__num_mem_pmus.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmus.c | 21 ++++++++++++++-------
 tools/perf/util/pmus.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 6ecccb5ad03e..bf927aed162e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -229,14 +229,8 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 
 int perf_pmus__num_mem_pmus(void)
 {
-	struct perf_pmu *pmu = NULL;
-	int count = 0;
-
 	/* All core PMUs are for mem events. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
-		count++;
-
-	return count;
+	return perf_pmus__num_core_pmus();
 }
 
 /** Struct for ordering events as output in perf list. */
@@ -488,6 +482,19 @@ bool perf_pmus__has_hybrid(void)
 	return has_hybrid;
 }
 
+int perf_pmus__num_core_pmus(void)
+{
+	static int count;
+
+	if (!count) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
+			count++;
+	}
+	return count;
+}
+
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 9de0222ed52b..27400a027d41 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -19,5 +19,6 @@ int perf_pmus__num_mem_pmus(void);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
 bool perf_pmus__has_hybrid(void);
+int perf_pmus__num_core_pmus(void);
 
 #endif /* __PMUS_H */
-- 
2.41.0.rc0.172.g3f132b7071-goog

