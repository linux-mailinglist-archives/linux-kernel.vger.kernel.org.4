Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8816B62DA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCLCQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCLCQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:34 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB546143
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:18 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y35-20020a056a00182300b005e8e2c6afe2so4890315pfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587378;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BT/x/3Eyz2BuEqpSdLzkRqcNHW14bzsOIxfh6FRlfxo=;
        b=lHkf3zlh1pVGSdM1GC3AxnylNDGWw4m4GJlJE4wRPSdCCUFN3He51cJPy0m5AyZ/zv
         /SzbVozvJfQqUfitexmgUsgWBFu/tkgmcX9cwlr0C6zKLYgTD7CUdX/9kFuEu8xRfD6R
         VJ6Jh2D0oe3Fhe67mGw5s3OOOHYfh8AsbdG0Y0kRrclYNzMovnQVtBqNXwD2Iv3gKZrY
         btWan+zTRIHcpSja+4FLQ3WkvJUYnWBExNjhJMbU5/XAOyZySYxySxWh0uVHd2Yut+VL
         6VvsruF/H1OzxW6rUp15I4kVz8EWLI9P6ijhJqbYhapqB4RPKk89sA8NKJOlPW3vPnqx
         HSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587378;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT/x/3Eyz2BuEqpSdLzkRqcNHW14bzsOIxfh6FRlfxo=;
        b=ce9RkvA2K4/nQ6rSN0JViz69vPdJOXW9fLBoKf78/cX6D47Gk0LWxwG8Oho8lsBHcF
         BEeUJZaQIOoKK/7jmOhYviFOEnpRZ+kwo1ZmxlsCt2z7UCujf9aurEsuqUxS6cVI+SKA
         qThZv6D2i3grbDDc+W7qJYomLFOruFNWsQAsL45QpXZG7gwNb0d3sfFNLaCv/HoOoqZt
         bTsU43Z1Fa8pgCW/rgyFJCLAa35IvgK2xVjg0FReIcdfASROGGIGxy278oarIGihd8ba
         i679BMR1koDu2B4CiCrbBJBXjma0NVhVvwirmNQoTqTNE/gBASZPBYTaIRtunPNyJSZq
         ZuCA==
X-Gm-Message-State: AO0yUKVx5hID8rwNJGEJSP7mZl/5fC4rXQSbvku0xw04eyyqnRI876iS
        MR8UfhU5AXFAS2a6MmqNAdDjkkusP80r
X-Google-Smtp-Source: AK7set+TQZtCja/vps9x30qK//1pOedYZ63oAHSdXRy5p5SUcpJFeG3+UZvcmc6a0VnbQm5HEOvgJz9CyaOl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a17:90b:46cf:b0:23b:517d:beca with SMTP id
 jx15-20020a17090b46cf00b0023b517dbecamr315230pjb.0.1678587378274; Sat, 11 Mar
 2023 18:16:18 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:35 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-4-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 03/11] perf pmu: Earlier PMU auxtrace initialization
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows event parsing to use the evsel__is_aux_event function,
which is important when determining event grouping.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 4 ----
 tools/perf/arch/x86/util/pmu.c      | 8 ++++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49..330d03216b0e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -26,11 +26,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 358340b34243..f73b80dcd8bd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -27,10 +27,14 @@ static bool cached_list;
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
-	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME))
+	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
+		pmu->auxtrace = true;
 		return intel_pt_pmu_default_config(pmu);
-	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME))
+	}
+	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
+	}
 #endif
 	return NULL;
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

