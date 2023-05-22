Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C622A70B547
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjEVGqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjEVGpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:45:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10A1B5
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561a80d872dso97041677b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737847; x=1687329847;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTVXYQjQQATmf8Mkt9G679/N0B13fTOwc5aaHfZePg0=;
        b=iiAigpdsXnQfOAaO/v/Fv96nlaEAFhaaiUurcRIqIJTdcXk4yZT84UKPYZtT8gnXAl
         rrcTqe20TVqxTno06d806fmEBBSujg/yLqe6D5QSiSJzOa3tLfqxS8LxbCeNL5R2HOG2
         wP6M1Wb+0Yn0RrqnaHR1pvTYu4IWwIPuNBv/cMJilRLa7ju2TZAhD55yGnze+5INTpae
         huN1BhxYAcSrWnNTtXfdgLgNpfhGE0CZRhepAgkRlqWsUZ71tKCmJPcCEriyj97T6wcH
         QivLA0P58eOG42Re93b11WLQpl0JnX/4wAuQsaX1WvpK5OF0lpCB9UlGfCAkYBLJGbl4
         ngVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737847; x=1687329847;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTVXYQjQQATmf8Mkt9G679/N0B13fTOwc5aaHfZePg0=;
        b=a1LVekeVUoX18XesMj7qrk/wo6wBip00OiS+JD0FiRu2WeS99Ak610vfGS9pWUPl3b
         wviOCrgjabs3XqKT3O0MKaAM76eOcJe4wP7KUOruAVKWpHJvj8gaOvUZGSPXnXVCoe3i
         Ui2GnSXPS3A2xCjK9IkySeS+t04g1AIRz4ClKZukHQMzM8KwAEf4WiZ7UnMGCAjZall1
         o/WehhiJq42ZQP78synvKiFS1oYkKCif9GS15vBBeaiOUkTypoBzTnKqdU/RmSbUKWHr
         VY8y8WKH9qxe3d4StewJvRks9j46yaFMnWpVtKyb/ODl7Y1o8QynsChI2O5r+z2Bz4Pa
         XG4g==
X-Gm-Message-State: AC+VfDzDW322GQVze4vbpjfWKPVF38jeZWFWljbRC8HIGyqNACmzWOf6
        dBZJeuIN4jJLFDBSPo2rv16lhZdcR5Xj
X-Google-Smtp-Source: ACHHUZ7Sf8g2b29rTvR7d1W+WDJ54MMM6khifbI9MGuLm1xPmEkEB6hz+aOq+v1LLmQ9r+uQjhqSIRv7LUwm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a81:a9c7:0:b0:564:c5fd:6d98 with SMTP id
 g190-20020a81a9c7000000b00564c5fd6d98mr3718059ywh.10.1684737847732; Sun, 21
 May 2023 23:44:07 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:21 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-15-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 14/23] perf stat: Avoid hybrid PMU list
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
2.40.1.698.g37aff9b760-goog

