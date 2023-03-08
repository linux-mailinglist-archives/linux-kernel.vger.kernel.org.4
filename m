Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020B6B00B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCHIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCHIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:18:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936127F01A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:18:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a5a0b6e3so164531807b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263490;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLp16thdoL8gYxkkfhRZgItEDw/VHlYRuSQJ2A/KjWw=;
        b=EfW+9a47KBIdziTM7x7a2ANP1WlRWe9rDGoGTPnoi9oLeCZbdrYqEUBp/iMW01A+HW
         O6ai2+XCJRNw/O1LxcmNlCxYhzfwqZM8q7gVlkWJYtboZ3LosTlkrP3/3/RutYVouUHG
         IT5nKQq6fKEZXQBj3nBbFiJTmYv64TUl6SeNfOrqrMzj6QVE8c9AK5gPOH+MV2bHeFJe
         kWrTlcYhqi7GPk2+ExxcE26UsPYaaSBeo5SYQm3eHV9cB3R1dTON3A6BwHQMWbHfyQyd
         uoiqH8jEKGJCwdAbTz81jSEfW9eb5PszlU0MMLkKFXZAPg1eJvWeRoVbShcJftGbyBOQ
         fe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263490;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLp16thdoL8gYxkkfhRZgItEDw/VHlYRuSQJ2A/KjWw=;
        b=eCpyCaqjfix5GaJy80Ocq7XLlV4ID6CN3pu6hAF8IhCog/3mCmjCkBNq+vxwZFrjf3
         IOUjECVlZWsGVFiDsInBpDouuuhTxTy6VNNhJtffMJdSEgyOBISCW8mAfCEAmZqgOqbF
         HehatJy823yz6EbOyfNTb2JNyPE41inTj/aeg+9BCf2KRwO+3y717ftcjIZt75r1tAlW
         UFnWk4GX70faC/YTG2aIX5eFRReordbwYOcILQT45IqKPR+9sJJFkbBBqQNIaeXrUGyU
         BN1N1fD6my293XxMC536hybL+UvRdT7r69kxOsRpnmQLHya1AitM+hecN3vJRswQ3gbf
         lV9A==
X-Gm-Message-State: AO0yUKWI7k2PneLexVh8duEBUgVfYg+VLLp0Nz5/VPD/uV4E2G4oX9pU
        d19JJIv8zwDNNtUUX9YPO5tF7w/fQrcT
X-Google-Smtp-Source: AK7set/r6knPTbdZZ65XOastihxReoqy7J+DgQeV11VF8N93mA6AZ2m+HNStQQOI5vnPLMDQCu62VB0J1Apk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a25:e90b:0:b0:9fc:e3d7:d60f with SMTP id
 n11-20020a25e90b000000b009fce3d7d60fmr7943980ybd.5.1678263490719; Wed, 08 Mar
 2023 00:18:10 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:23 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-4-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 03/11] perf record: Early auxtrace initialization before
 event parsing
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
        Qi Liu <liuqi115@huawei.com>,
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
 tools/perf/builtin-record.c         |  6 ++++++
 tools/perf/util/auxtrace.h          |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49..de1e4842ea2e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -15,6 +15,19 @@
 #include "../../../util/intel-bts.h"
 #include "../../../util/evlist.h"
 
+void auxtrace__early_init(void)
+{
+	struct perf_pmu *intel_pt_pmu;
+	struct perf_pmu *intel_bts_pmu;
+
+	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
+	if (intel_pt_pmu)
+		intel_pt_pmu->auxtrace = true;
+	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
+}
+
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 						    int *err)
@@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..a0870c076dc0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
 	return ret;
 }
 
+__weak void auxtrace__early_init(void)
+{
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
 	if (err)
 		return err;
 
+	auxtrace__early_init();
+
 	argc = parse_options(argc, argv, record_options, record_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (quiet)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 29eb82dff574..49a86aa6ac94 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -457,6 +457,8 @@ struct addr_filters {
 
 struct auxtrace_cache;
 
+void auxtrace__early_init(void);
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

