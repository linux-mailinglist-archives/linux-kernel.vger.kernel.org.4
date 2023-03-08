Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359E6B15C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCHXAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCHW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:59:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA617D13E3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:59:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c02ed619so708517b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316385;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+qDX3jH1lOKTsdGbFp7R/2wFTjz3Q2IIuidM+9GQKA=;
        b=DFFk2xpNm9WphrNvajgxOoqstDHJTuE9tDsxET5XisIInEgApHSWTWI2G8pfhOhkdu
         auwV0TE5vJMAgqS6U8DDgig52deviZ29JLQ9KSOE3iibC1QnV7KFE/lN0+OcfG0Qxd8i
         rF3fJchSi9XRDLMFUk7RGnkFVfTgY4YzIbiKmnTOPkunRiy/jy2MDGPCVdSHV3mebj3Q
         0a6l1bZnJ1Y/qGf392eLQ4qwM39jdFKPPEtuwTWLWwayxOCWPTfGfEqDeqsv0g7Nm7rX
         KvZIJa7JdBmJAdimef0LByK6niiZIXUYoIkfOLDNv4ApsQUkviJNZnQJNFVfetgpX0LZ
         OAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316385;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+qDX3jH1lOKTsdGbFp7R/2wFTjz3Q2IIuidM+9GQKA=;
        b=rMouz9v734CLmrwwJrbAJaxbukgYXn8st1pihGInZ5seP+EiQjQV1OAgxEG/LpBRzV
         LyJA3GuY+JwyfSW1DjudQpZWR1ePLed9uqcN0EEjxxlVGk1oisDApQ2LDDZQoNiXd3TF
         SnljRtLkaU4K82eUsrsgxHzwLcFpmPIQOmKFn0THoSbAl2hPfXXJCjKomlwRAYN5npV/
         E4vukecOJNCClClMd8aj6RqppFx8zYkXEJ5hQ3Mt7Ydx3BkiQY4hDQq39shQxBOa3pSn
         qgaZEXMt790HECXmGkXeijKGNE7bTqPDdU1TKqKmboLZxjsFh8MympClFU8HYHv2/0uI
         V+qA==
X-Gm-Message-State: AO0yUKVazoKQB8vloCPRGRMPYMeiHNFRHEEZ4L0TgTRqXDgFVCqVcuIw
        K1FsMtS7+7UF1Io2vo4h0Ba2KCnuuMTu
X-Google-Smtp-Source: AK7set9ivQfkcqqArDa6b9pj3bzD8ySHcNeWzHOTdX28H2b1F3vYOgRZIjL2p1LBLr26+2ih1TnHkNCXx1Ct
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a0d:de41:0:b0:533:7e62:80a with SMTP id
 h62-20020a0dde41000000b005337e62080amr3ywe.448.1678316384620; Wed, 08 Mar
 2023 14:59:44 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:04 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-4-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 03/11] perf pmu: Earlier PMU auxtrace initialization
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows event parsing to use the evsel__is_aux_event function,
which is important when determining event grouping.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.40.0.rc0.216.gc4246ad0f0-goog

