Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADD7132FB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjE0HYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjE0HYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB841A2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:45 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-256419413a3so452579a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172195; x=1687764195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csOWTo951DO4baytRGvCV+AGtywhGll+tnrLNxjPQY0=;
        b=C38tR/1RFw0fe/o2q2Trv6vb+/sMetouZoKl5RczGdJM3c1q+o0U0BjC1i4bjBEKJp
         1kl1gmNWPAOBXqn6I0TNfCIMKwnjrZjs6cPn2QyuUn6JbfCpZJHcH0qvK7k3zgqebmNa
         wyeJAAUdvWDt6l+i/HTcTREnsvQceX9qf1SsL2sxNY+gSImIlHhCgsEpESOZnCTkY61J
         Kx3LgdBvGB3Zx04lgA0PGpIJlbuaQl7NM0vBAz6mKL34dgisX3IhdnRHMAx9l/Xha2SM
         +6PGm+rdGLE82h4UgqVT8Ec2sxJnVJt8KcC16c8KEPDj6YAwyJP8SL++upz8V9gOB8Hi
         aGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172195; x=1687764195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csOWTo951DO4baytRGvCV+AGtywhGll+tnrLNxjPQY0=;
        b=KHOuu061W0oZ+QZbi3zpQnuXChtmUnpl8gJ1PQWQYw2WzZmlV3nCbwqPtcOeLdKbVh
         /SvmQMZXYKKpCfYTT+FkPreQmu2Nv0qZttenudmdu3Dc5NAx3T1lgQxyp93ySZZIrlyF
         ekEQp8DLnJRimweBMEWktGdQXgliu76q4MmKBbqk+uPsxUMpFW9EkZjqq2GeISAVr/Od
         SSbE6J4DKjzt/TZ5mxzX3//6UTMuiNhRIlVRS3ZB0+Z/JXRo83/4DkqDH3dM/3Qf0d2O
         bJbHrCUstkeq/SvW9bG5VDuqtPUtzRLDjWeDp12fYjiTqTmNQ1E912VxYakgEIxmzb/H
         glfw==
X-Gm-Message-State: AC+VfDzcsfIIso/8U0tMCbS3Mq+kZPf37uOD5oBI8BylfQu6d+IqynCy
        jNxAQ1WQdBMIlkOBTeXXHAyC8nWNHMw1
X-Google-Smtp-Source: ACHHUZ59aNA295e+X2wN34vRuIkRjmQcb7D1ba3SouitqOJ7T+jMAKDbBahYAHewEIQxxz1Zy9wxB9qyvPAj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:90a:5782:b0:253:4800:438b with SMTP id
 g2-20020a17090a578200b002534800438bmr249539pji.2.1685172195498; Sat, 27 May
 2023 00:23:15 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:54 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-19-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 18/34] perf topology: Avoid hybrid list for hybrid topology
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

Avoid perf_pmu__for_each_hybrid_pmu in hybrid_topology__new by
scanning all PMUs and processing the is_core ones. Add early exit for
non-hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/cputopo.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index ca1d833a0c26..a5c259bd5cc0 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -12,7 +12,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 
 #define PACKAGE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/package_cpus_list"
@@ -469,11 +469,17 @@ static int load_hybrid_node(struct hybrid_topology_node *node,
 
 struct hybrid_topology *hybrid_topology__new(void)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	struct hybrid_topology *tp = NULL;
-	u32 nr, i = 0;
+	u32 nr = 0, i = 0;
 
-	nr = perf_pmu__hybrid_pmu_num();
+	if (!perf_pmu__has_hybrid())
+		return NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->is_core)
+			nr++;
+	}
 	if (nr == 0)
 		return NULL;
 
@@ -482,7 +488,10 @@ struct hybrid_topology *hybrid_topology__new(void)
 		return NULL;
 
 	tp->nr = nr;
-	perf_pmu__for_each_hybrid_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_core)
+			continue;
+
 		if (load_hybrid_node(&tp->nodes[i], pmu)) {
 			hybrid_topology__delete(tp);
 			return NULL;
-- 
2.41.0.rc0.172.g3f132b7071-goog

