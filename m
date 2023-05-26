Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B83712F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbjEZV4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbjEZVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:55:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115BE6C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8338f20bdso1621376276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138099; x=1687730099;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgTQ1iEJGskpPHfEYybesE3qQwBGSnBu79Mg3GVHTdE=;
        b=C06rKEXYr6sGGHXGQF8ebpofD61Y65PP7APe2G3FE3PQ0Jv6x1fX+I1wj77Jk98CpM
         PnjT3pZ7n8nxr/Wu0o4zyMxXEOot7eKSkaPNu1dtuCE/+p3/ScGbByZjMr23kbsIJQ7W
         SMBpK4soCaeBT2tRu/2pLgbUPMf9eERfAm/opO5P2N2U7VfJaSsc+QZNxjGk9udPensM
         vJul9wllepIcufFPXTW97znuXfvxZuDaicIOUcfkbvQO/QpugIrJ6T+kI3X5Bg+pUnBc
         dVWz84pYD0zBkL37vSCpRUGXSoMeGr15OswAs8gQH51GuWu8s0nL3ah2uixOqVCG2ZPa
         aLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138099; x=1687730099;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgTQ1iEJGskpPHfEYybesE3qQwBGSnBu79Mg3GVHTdE=;
        b=AUtXD+RfTD8rXBS9zswOkrcehl4lNDl+A9HIOPz1/WYokiLIJfXNrPuZs3522PHwoU
         gmLi5Q4GLGlgKcSsS+KQUJZ9dOoNnz7TMX0Zy4MQVopPe3g2fUYKsgaTKinzAHwJdrkU
         dWXpzUeH/drAeBMAWTOE/TmTKHllnYtVUnfkbpP++pgI77RvF2CGzNKmWfJY/OY7dzIX
         Fx0Vx6v4JtSfx/0KMwUpeBsRcIV2VV7yBTELS3QrDp3ZMulgAN8jkwOO7mgD4qkHdY2t
         TeBB4jLnXUkOW1zUxEfIv1BeaecDqc1yfOVQSqiwTgIAyXRW77cBpPbaAgZxdgFZOlMA
         SoCA==
X-Gm-Message-State: AC+VfDzaF50k14RIF0EYZUa+s/SKX1HWKP2fEv60HrJHMpLUFf1vXpDc
        voPazdzMUpAA4HH/2CfywicpMHCjMjps
X-Google-Smtp-Source: ACHHUZ4bB7g8nhd96w/L/fl4sYgmRAHWC+6YJnv5PjTZXis8me1qLpFi36zK9C/llTi90esMz0wguF7COqPi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8e06:0:b0:bac:fd27:28c1 with SMTP id
 p6-20020a258e06000000b00bacfd2728c1mr1699730ybl.0.1685138098902; Fri, 26 May
 2023 14:54:58 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:55 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-21-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 20/35] perf evsel: Compute is_hybrid from PMU being core
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

Short-cut when has_hybrid is false, otherwise return if the evsel's
PMU is core. Add a comment for the some what surprising no PMU cases
of hardware and legacy cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1df8f967d2eb..1c6e22e3f345 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,8 +46,8 @@
 #include "memswap.h"
 #include "util.h"
 #include "util/hashmap.h"
-#include "pmu-hybrid.h"
 #include "off_cpu.h"
+#include "pmu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include "util/bpf-filter.h"
@@ -3132,9 +3132,17 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 	}
 }
 
+/**
+ * evsel__is_hybrid - does the evsel have a known PMU that is hybrid. Note, this
+ *                    will be false on hybrid systems for hardware and legacy
+ *                    cache events.
+ */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+	if (!perf_pmu__has_hybrid())
+		return false;
+
+	return evsel->core.is_pmu_core;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
-- 
2.41.0.rc0.172.g3f132b7071-goog

