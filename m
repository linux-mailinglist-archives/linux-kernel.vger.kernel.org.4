Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C66A8B46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCBV4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:56:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EFA559C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:56:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536b7eb9117so3948667b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677794157;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZEua8oTOpEy63/43z9gHKJd5DuGh8paDEjQxW2aig=;
        b=JQjrH4wMa1a61Rm/qB8rOzj+BqFXZs/vcxRoNqjZIwzsrx4DFMYTCx+XOZnmbaTMo7
         5LPywruZvRi0HY0nf16Z1M25zPquhObLBKtK4LmcZywG3EvrimeCZbofFDP1Gch04u0i
         bbTsilLDfF8pwp2ngnRvUW+lZC2tXBm9rCehDV3LqTR8EZpyq8/BC6IIVPJVSO+p33q2
         LMzvsD25ajJIiap+LCNqmIV4yztBL/JhtijuXvROu/vOZaQo4ZKC3h2Cx8Faov0dIDwI
         8/JJscO2dJbJaVAYXia7hEz9VZBDpo7dXB5PJiY30aIlHU7UUQjTabb4lQ+4NVYci77r
         YBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794157;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZEua8oTOpEy63/43z9gHKJd5DuGh8paDEjQxW2aig=;
        b=LdFN9lMTdqPG5OrEfkkAVWGMKh/pNtt+m/RGNKNfZaz6aOAxpIIpwDgmFGwDXSWF66
         OKDLYagjPDKLnW++w5lhhdIFQyLhd+yZza2zkb5JqJ05RBijRNE7dm1inZiFwumSx0Rr
         S7LudYg+/Gupt1UKvH3M8KYMNs64DaJR4lNmKRs681MkaBcucnR7YkKXvgpImWRbfC9j
         kPiUCHXpiP0Ju3RnHnzw0U+cOOTcC0HlCEhw4nk72hRTMxmgveFxP9otg5kqfE0vq7It
         SQYmHkyHd7AymzyUzLo0ZnkPHVD0n0YEGU0ZLpgQHDSABO5RQPxxspjXI1sN+EVXJRij
         0LDA==
X-Gm-Message-State: AO0yUKX2ByCYRS7R90pO/9ONuQ3M72K+OZ8+yAaHlquZuNYDt01Cnq+H
        FcT0TQ9BB7yb8C1CHoFPjdHWj0tRW7Ds
X-Google-Smtp-Source: AK7set9TS9AIzk17qdo6XO2UQeX7T5f+JoZlvnDu9vwkLALw4z4bmxPkvoTtgbCu8K9raAkgAtQEfYVer3Cy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a81:5d89:0:b0:536:4aec:295d with SMTP id
 r131-20020a815d89000000b005364aec295dmr28ywb.453.1677792395505; Thu, 02 Mar
 2023 13:26:35 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:27 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-7-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 06/10] perf evsel: Add function to compute pmu_name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

The computed pmu_name respects software events and aux event groups,
such that the pmu_name is changed to be that of the aux event leader
or group leader for software events. This is done as a later change
will split events that are in different PMUs into different groups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2dc2c24252bb..9c6b486f8bd4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
 	return "unknown";
 }
 
+const char *evsel__pmu_name(const struct evsel *evsel)
+{
+	const struct evsel *leader;
+
+	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
+	if (evsel->pmu_name)
+		return evsel->pmu_name;
+	/*
+	 * Software events may be in a group with other uncore PMU events. Use
+	 * the pmu_name of the group leader to avoid breaking the software event
+	 * out of the group.
+	 *
+	 * Aux event leaders, like intel_pt, expect a group with events from
+	 * other PMUs, so substitute the AUX event's PMU in this case.
+	 */
+	leader  = evsel__leader(evsel);
+	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
+	    leader->pmu_name) {
+		return leader->pmu_name;
+	}
+
+	return "cpu";
+}
+
 const char *evsel__metric_id(const struct evsel *evsel)
 {
 	if (evsel->metric_id)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 676c499323e9..72121194d3b1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
 static inline bool evsel__is_tool(const struct evsel *evsel)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

