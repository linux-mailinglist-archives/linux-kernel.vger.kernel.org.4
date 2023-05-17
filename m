Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD7706BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjEQPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjEQO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:59:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A0A250
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561ba4e8ceeso13540817b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335542; x=1686927542;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lf/8hxCzQpNjHzWukJV+4jFN6uFu6lEtBSl3J7I1nZY=;
        b=Nay2/Y9VQgRkTRjYQsrtoubcISP/lly9q68dZu16//xSdEEDB6jAKmPvCgKvS1MDp8
         HB5c8R9YCQ3z6X0vYwmJ4REAKa1achWvqfjtuQeOkHwKI6mPFZzsXzV0bLAPjJzGizOT
         yNeqSVIuNkDzx9x0wuPgl9A88c5JaTJ9ftM3pjuLC6DtYfIPMF/0H8GRVJBfhbvb9CWx
         U2gEue7Js3gsKbw8iT6iavD0UcikLr4+5jvoUoge3l1eQb6CKb1O+sF1DXnLhsb1oshp
         b6SJZvu6wsr/Xq0RiD+htui3aZHT7Sa86qqAIOR3HV2fLf8MP3pBKAnohyCcqTkm4AXt
         gl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335542; x=1686927542;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf/8hxCzQpNjHzWukJV+4jFN6uFu6lEtBSl3J7I1nZY=;
        b=a/Fz+yO/onlorFQLudflccBUIxmvMVjMHpX9MJoBbsC2GECb2PcQZe548st7zpqhlW
         pT10SnkIBEFuOAQsQZyMGeqETZDY9aUhyRcEDKGAt0ZPjCFnT09gzUuBWSooBj0fuElk
         JtHRzKZbTv+084SYsbf937MwKVh+tgiHcjkPMbGmuv46Pi0DMokpE9IXcS7IDPtlATYE
         DSojSauLuWb47rAPigM6xdtcn9tzVZzbUST7zidVDRdjJ7vkUdt+XKyUHWMTjVgWfCS5
         XhxcAFTdHeWsQulgqzjIV7Z+lXvQH1FVGSxwhXDScq0K1R9mfzeGpTFl0uieevHMaPOU
         cfiQ==
X-Gm-Message-State: AC+VfDxJcE5i+RO5WUZFu71nm5pgJ63uIrGmUTCcU/Qm3tpdi5Md8KZW
        RXq17Ph/PiXGLcRQcmT2n11ZI0yQDuTq
X-Google-Smtp-Source: ACHHUZ6VoZUrC6EiZAlnVlcFeo0+/IFgZymrHY8SipcP/PmqCYApS3tdMoqxNMXgD9tobYPeVb9FmmrqsGUa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a81:c402:0:b0:55d:ea61:d8e9 with SMTP id
 j2-20020a81c402000000b0055dea61d8e9mr20859767ywi.7.1684335542635; Wed, 17 May
 2023 07:59:02 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:52 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-13-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 12/23] perf header: Avoid hybrid PMU list in write_pmu_caps
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

Avoid perf_pmu__for_each_hybrid_pmu by iterating all PMUs are dumping
the core ones. This will eventually allow removal of the hybrid PMU
list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 276870221ce0..e24cc8f316cd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -51,7 +51,6 @@
 #include "bpf-event.h"
 #include "bpf-utils.h"
 #include "clockid.h"
-#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1589,17 +1588,21 @@ static int write_pmu_caps(struct feat_fd *ff,
 	 * Write hybrid pmu caps first to maintain compatibility with
 	 * older perf tool.
 	 */
-	pmu = NULL;
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		ret = __write_pmu_caps(ff, pmu, true);
-		if (ret < 0)
-			return ret;
+	if (perf_pmu__has_hybrid()) {
+		pmu = NULL;
+		while ((pmu = perf_pmu__scan(pmu))) {
+			if (!pmu->is_core)
+				continue;
+
+			ret = __write_pmu_caps(ff, pmu, true);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	pmu = NULL;
 	while ((pmu = perf_pmu__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    !pmu->nr_caps || perf_pmu__is_hybrid(pmu->name))
+		if (pmu->is_core || !pmu->nr_caps)
 			continue;
 
 		ret = __write_pmu_caps(ff, pmu, true);
-- 
2.40.1.606.ga4b1b128d6-goog

