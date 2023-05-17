Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B0706BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjEQPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEQO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:59:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB9A5F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561ba4e8ceeso13546227b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335557; x=1686927557;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JHMYFOy4Rnq7km0f1P5d0Novi2NnIhZ5v+qGyCXvJA=;
        b=NUt5ix3/hj9HrpcM6MYDNvnTwoSP1xH6wlLrX9e9Tz0miwMSQTtGIKClG5qwv57l6O
         A//ubPkeYK0kARPpDLYkyvpjLLta860QhwX1nXfQwg8tEZLVlbK1kWXym/2eZ5dZsq8x
         6GYSvX9bRBm6eKGkHksg3BVoR2OCrj+UmGMMJkEVE+YWGLO4+6/QkfWQgMT0Iy3tbpGd
         ywGR+r1YyKpTyXhgNpMcIreGImEsF2uwH3qWnvocCFxv0Q+CgvLR1UjKizk+npEV17LY
         iPj9Md3WG1Jl5fTkxw6s8n+6E6qDJXYki1HnUtkNIJNcA+Ge2Zpy40/9HA4D8oS+Fc45
         I6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335557; x=1686927557;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JHMYFOy4Rnq7km0f1P5d0Novi2NnIhZ5v+qGyCXvJA=;
        b=O/Oyw+e5TJJmeq2YgqV4QaOseUD5FnWj6ntHkxeXjvtLLpmB0mLQj4vetbcgum5NDp
         Adht9RdjrdSvbi2lW5zGG/aMF7IVMp4dKXunicBBBS8EoIAjtI3GsdNTn1gJDrFH5WM4
         NTEcsZN9TVbGf4i6m+kWlxkNmqnyWVzXxB1bhOD1omMiYULOuOBFi/kKSZGfZGewwXMw
         EG58pzvVt15x+n1NlSiqboN2VGWD2sbLd5RwZpPq8yA0pPyJ8pTB/P9ZXQOcZzX+OtMN
         9MmgMameheudjbhA6K/PT8WqasJAbOOi9raIyoLECBHT7h+0qRWXdIwxKeG5XfJXIHyt
         SU4Q==
X-Gm-Message-State: AC+VfDy/E28hECbfKjdD5F6eCtO1qQipiLnq56fXp/9IYHg530FnlEcX
        Q7stjmSenpviZCs4KMdDZkg89JzxMV9Q
X-Google-Smtp-Source: ACHHUZ6qLhjY1rr5lAa1CEqcs76khLRuf/sGQ5pDoD/zXoJpttx+p0MDEXNhFEWooXgXjWu1SfGXD+0KmT/A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a81:b50d:0:b0:561:4cde:92cc with SMTP id
 t13-20020a81b50d000000b005614cde92ccmr7867334ywh.8.1684335557303; Wed, 17 May
 2023 07:59:17 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:58 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-19-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 18/23] perf x86 mem: minor refactor to is_mem_loads_aux_event
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Find the PMU and then the event off of it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/mem-events.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index f683ac702247..02d65e446f46 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -55,13 +55,13 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
 
 bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	if (perf_pmu__find("cpu")) {
-		if (!pmu_have_event("cpu", "mem-loads-aux"))
-			return false;
-	} else if (perf_pmu__find("cpu_core")) {
-		if (!pmu_have_event("cpu_core", "mem-loads-aux"))
-			return false;
-	}
+	struct perf_pmu *pmu = perf_pmu__find("cpu");
+
+	if (!pmu)
+		pmu = perf_pmu__find("cpu_core");
+
+	if (pmu && !pmu_have_event(pmu->name, "mem-loads-aux"))
+		return false;
 
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
-- 
2.40.1.606.ga4b1b128d6-goog

