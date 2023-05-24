Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58647100D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjEXWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjEXWVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:21:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B116E4D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:20:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56552a72cfbso29697447b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966777; x=1687558777;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/uSoOkKrLV2P01KOT7/05nAwNtg1NZmOZIVSrGqD1k=;
        b=AnKvdlUdQjQEEAq6HeZq7zmB6gXv01G0cNNgNxVh13Iy+L8MK0uM/sSyX8zOpVJzzj
         LtvtAjrsF6ZUkNcumXtEBBqhAtaTXivZg5uh9HUG3ggoCvT1KBDP5u6fGhM2uPhybH+0
         IRPtuFglOvFjuOWq6/CbvzlITCjdA4TyXBPz19kXSoq7VcI4CYMwdBQxFdBnjnbjoL6P
         LxSPLWqi5o7mHIUqLRxbYbRi/kTwfvbWyjhyeaTnIYhge/LAYfV6+KLEKMuPY3zpQM0A
         43v2qjCsMWYwXQDEQ08GdcQRHh9y9JvpJizhR5eGNt/mVktDaKoGL7OMDri5nQHfF3mJ
         WXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966777; x=1687558777;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/uSoOkKrLV2P01KOT7/05nAwNtg1NZmOZIVSrGqD1k=;
        b=LNYk+YepakPkNyFFthR0KAyqMLRb0Wc7ZsmEaS2guDevjYLNOhOCLyoIF6dfFps9iy
         MclMWQgo+FRVaqBFXafw0wmbjc9xJ5GFKG30eba6DocPVQvI/NPf3rfw/HTFFPhJQYV1
         GtkJFrMyQf/facvsL0mFbYRwcD8MgBkDC4BexkqCiT+4qPZdy6LjtzuCMa8lR4DJap55
         rskwOIBICk6bt/OPws5vQEFiGsvnYFbS5ym4Wcj3SP1PMSuX6XUNAoYYx6EYZIJe8keD
         773ycPN8yTSRaIIUCg/3luiOGF2FPv457sC8m6Bz/e5NRF7S8vJEmORiG+ccsEGBD/I9
         GGXA==
X-Gm-Message-State: AC+VfDxab2bLCK9xBJNgMc3nYcc1G8S+8exoqcAMduFQBMLRN/LiVid1
        1AWzaPnu96SKY2Bfpb63VPe6z91HDsJw
X-Google-Smtp-Source: ACHHUZ7sEtK0LR8WwQQK9cpyIqNh6Pc7ybEP8C6sxaWdG4+eXpOeGFVug3xou45ngKes3xW1FpxdzJYoO/4m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:441b:0:b0:55d:9484:f153 with SMTP id
 r27-20020a81441b000000b0055d9484f153mr11963093ywa.7.1684966777192; Wed, 24
 May 2023 15:19:37 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:23 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-28-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 27/35] perf x86 mem: minor refactor to is_mem_loads_aux_event
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

Find the PMU and then the event off of it.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.40.1.698.g37aff9b760-goog

