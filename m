Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7486670B543
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjEVGpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjEVGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:44:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E6BE6E
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c9e9e164so6502859276.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737838; x=1687329838;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eS5iHSDHpFh4XdVaHBCbrVny8PCbF73cyIUIzaUWEw=;
        b=CgHDDcC/bqqMU21nt7St6njPl7Rn53Y47s5fIwnhxiq0CxfpVDxjt0xXLXOSODasdE
         Tk92JdTJATwtUezQWA6Z3gAwX+/ec7MKOKi800MmW7EPwUD5McVn2WEkSU4FYIwhjsio
         bw2hdH9lbS+rBKpwWxSbj+5Q73Lr8QN+jiM9/Oe9R90fCdPuAH7vTos2YCQ3N+S79Eu0
         BA+PakRJh0qnm3y+jvU9D/MpI1oRvkom0oF/O6tCx18sSb18tnGsaRyfw1RCfP4TVMxv
         JNQ8+aMDPkUf8byLtKJtCqK+oHpyDMG9NStLm93IyJNFOzz5AQdPIM4QueYCtzvzDvMS
         qzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737838; x=1687329838;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eS5iHSDHpFh4XdVaHBCbrVny8PCbF73cyIUIzaUWEw=;
        b=YcBElS8JHIul0l1ahDiW6iNSxMOrdCwLzH2ny8/WJhiPIp/IlRBZdrsLMLk9GhgxOY
         Ll+eHxM3AYU3xZs3zNLr44brm9iHk0bk0ianOhGaOzCveI81fM+DNy/+xNMBOSWtKaI7
         L8uZJLqq5ye2XGWbJALTZkrZktIyRELOwjKGN/QuOcKrg0dsUAuFaSL/DMyhDFBQBVUl
         AkD7VByGT1C4/AsM+Xo0n5l5TMPM+f/I8PB/qDh2gnAayrYY2g4ut7aaLCAFW6A0Ous7
         tw8pZtoGWuSbFx2JLgIeidsatWZGYknVIva5JN3UfjUzUnXD/11+xx51NwbKiGeG/JEW
         0qug==
X-Gm-Message-State: AC+VfDxNQuzfI+YUbG9sYYPweUKNmWdJdJIE0CJNuhO33BGnCdGy5PuI
        d3J+3s7851LoPUzXiP5gGpibDVTX9UU7
X-Google-Smtp-Source: ACHHUZ4CGsfKcHUrmkLQzmUyhJN0XIWwtaPsa/Q19mBM+K+hLEXsAmiFVhHxp8qWU/VEY2xhQQxccmo/4t6P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a25:ac20:0:b0:ba8:91c0:3c50 with SMTP id
 w32-20020a25ac20000000b00ba891c03c50mr4043339ybi.7.1684737838276; Sun, 21 May
 2023 23:43:58 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:17 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-11-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 10/23] perf topology: Avoid hybrid list for hybrid topology
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

Avoid perf_pmu__for_each_hybrid_pmu in hybrid_topology__new by
scanning all PMUs and processing the is_core ones. Add early exit for
non-hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.40.1.698.g37aff9b760-goog

