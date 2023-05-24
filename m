Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD497100D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbjEXWUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbjEXWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7AA10F9
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba88ec544ddso3170011276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966768; x=1687558768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xohs+RPxgQPJo1czRcXVjEN6Ep07r6+wQ3n8ob7tftg=;
        b=IgfaH00zw1PRDkqwd/QwU4Sg5TJxQ7feV/pDX0v7A7dRzdpe13pLIG6GaS/JKXqvvg
         ev2dtZc04e9KWDyVr2G86au0saClF58Kh2k5UqyhLSFrZRim46pA8475WEW10d+nK7Q8
         AuJ5Qrusdz12jpgCcZCwhMqm6k5meHHrATRSwUpNhDNhVd1uq/as7AANV0NTOK0sIDaC
         ylyZNhgvKKWdgx6eILUv8tsxyqBsW3CbkhNkI5BgQ5mVc2/sMQtqHzkp55NEtG97JRyE
         PCuklBhHC8GBSKDKsBZoIfEtwM9VGUpouwsQJY4fCBgYF5Cb9M3ZTxkWD9/qm6+pKPCH
         27CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966768; x=1687558768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xohs+RPxgQPJo1czRcXVjEN6Ep07r6+wQ3n8ob7tftg=;
        b=IJdtf2I5Z+6o6yXj4Vh6/L6j9MeV4TjAZr9iDxqOA2ywwCuuytzInGjcGBiUiVgBkO
         wEebvV600nA+CdRTU/pYTKXC83hRcjtXKeYZP8lg7se/Z8CHE5SEPfAETrxlpmefjREe
         j3FI+9CXsUJHszUE4YcYCY0JoEfwWV988c+gx+H2sTNNgDydkcFr7U8cnWml/q+zo4ke
         ABTwwA89gNB4uGbIP/KZzugHwP6O0Avur0TbMcvoiFJVZRGhkg0hTRVSbYxxQa8fIlKL
         QXpOtMjSAiNSwroV1t6H9jsDJN/UKiifFJvqCgS60ZOT1V0SB/UGw/hhKSY/jtLO+j24
         IHxg==
X-Gm-Message-State: AC+VfDz/AU8dUzAjdeMibObxzzUKkMOUbDySQ7bzfhqMVPSAbSkjos8E
        u/SfnJ9jI/ADxDnONGb2zbF6en7rNa41
X-Google-Smtp-Source: ACHHUZ74qT7vuVNsbtmSv30uJE6ZkJtddOJ2ysembhatAzi/XHx184YwKBpC20/oi8O5XKcLYnGlaUmTM7AH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ca:b0:ba8:84fb:6ad with SMTP id
 v10-20020a05690204ca00b00ba884fb06admr789426ybs.4.1684966767759; Wed, 24 May
 2023 15:19:27 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:19 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-24-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 23/35] perf stat: Avoid hybrid PMU list
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

perf_pmu__is_hybrid implicitly uses the hybrid PMU list. Instead
return false if hybrid isn't present, if it is then see if any evsel's
PMUs are core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ede0477d958a..78ce7095dbcb 100644
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
@@ -680,11 +680,12 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
+	if (!perf_pmu__has_hybrid())
+		return false;
+
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->pmu_name &&
-		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+		if (evsel->core.is_pmu_core)
 			return true;
-		}
 	}
 
 	return false;
-- 
2.40.1.698.g37aff9b760-goog

