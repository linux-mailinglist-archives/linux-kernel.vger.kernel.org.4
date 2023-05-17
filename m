Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E60706BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjEQPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjEQO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:59:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49C526E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso1656036276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335540; x=1686927540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85QXUmSzYQ7qJQE/KiBLPaTz0+VTd9+u5qwdQ9BqgEo=;
        b=IDUYTrDoXWwrrq3ucsv9m2Fp7hhTBFvwQiCG5BJ4RBTtjwcMSozRUM0FMQo2LCDSGs
         jX8yJaNCn8744PL6du8vEg4nx2zTGnfTpV5GxP6lOeFZHzZ/Y0UN1hT4042AGNJJsLxn
         /dN/jQDoQIWA+J4HcrtKyTce6f2gaT97DB52DEsAvuE3okght275WgiwR5hayl3HouRn
         cDjWShFZpT/50RrG2A3z4VKMKdfxW/8qwmMT67UheTsK9/5YPwhfVpljzupyA30d7b1P
         3tdlZ1BhlND5x7kpyLiQp4KwVjewMdh1I/l5GZ6ocAbhrutJ2I7eBw5PM0OAif+P4lgn
         7j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335540; x=1686927540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85QXUmSzYQ7qJQE/KiBLPaTz0+VTd9+u5qwdQ9BqgEo=;
        b=e2bRIWEYRUZP2BnO0NuaD8OPXpncI3GEwnsvpQmwJQfUR9iGYFMzldkxp5hUUteHrj
         ah3T26cPphbkiWJ1L+NSNsNO7+6DVnEEsq7LltfrMQlGaERLHiYkE4LmNMcsGwmukZCm
         3cPqkAtz5EieWG86Acd1Kpahzn3aOQDc0ZzZurcXyqkKmFBZE5YP0tialuc11gh8kAUl
         3xEa4GstMb0bV8pV4+NAv8hc45YiGU9/pRBqWV1MUOxMani4TvFRdnJGuihV0V2FNYXE
         onGDeEt9TOCF+CTimG2hijP62u+Wn0LDWY+LGghZ8Y++Rxl5o7ZAVks/sw84UgfqkGBu
         jVCQ==
X-Gm-Message-State: AC+VfDycUECV3jc6jo6OzFBiy2+sCU1Bh1L5hqA1W/0w3XQzNrBDa4HN
        wb9sB/38M6MiLZiPhDf3yFKoVV8AEgdy
X-Google-Smtp-Source: ACHHUZ5TwAkgVf6TwpeVN+nOLXdN7MV3y92amRDRD3tVQXRLC8B4atOH6VvndgKA2K+z5KD779f+YtHAi0Et
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:db07:0:b0:ba7:7478:195f with SMTP id
 g7-20020a25db07000000b00ba77478195fmr6028279ybf.13.1684335540478; Wed, 17 May
 2023 07:59:00 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:51 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-12-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 11/23] perf evsel: Compute is_hybrid from PMU being core
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

Short-cut when has_hybrid is false, otherwise return if the evsel's
PMU is core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b39615124672..2c0ed7d25466 100644
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
@@ -3133,7 +3133,13 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+	struct perf_pmu *pmu;
+
+	if (!perf_pmu__has_hybrid())
+		return false;
+
+	pmu = evsel__find_pmu(evsel);
+	return pmu->is_core;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
-- 
2.40.1.606.ga4b1b128d6-goog

