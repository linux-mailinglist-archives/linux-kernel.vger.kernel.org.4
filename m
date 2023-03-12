Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947CC6B62DE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCLCRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCLCRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:17:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269E4743C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5395c8fc4a1so95709767b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587401;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qyazbe46rOg/i1CEPSqWXRbYnptRPdE6UyDQgiYATTw=;
        b=IHiifOyhvr6dfYqaZRmzbuNmwYrNgU/Sf8u5McKF/J+58inhWo0wkALDzR811VOgqe
         eqcylIqeTBd9nrE0csz3mVz0czd6hIWXdNWqVsyLFnfI9OZNkNAQGtlSQpyhN1J0kDQM
         6mjsE3Gt5KTy1maWSq6yDO7qCGyoDlRIfnEBgYyiHAwTL/am/o1zxljzxMZi6UfjhbR5
         Gz5ASNYfTkEtxbswQBRX/a6a/0n3IjOd8YsAZxTARgR5y3PyKu0bE+gmm7LrAAUvGOf7
         LjTdkhaIQKNfzKcZ4e5YOdgM50+baq8E5+B9rK+/dMOl2Ocu/II98PCYve6fmz+qcrOy
         Tc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587401;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qyazbe46rOg/i1CEPSqWXRbYnptRPdE6UyDQgiYATTw=;
        b=EbpQluaSZ4Blr/pLLRqRPudacSzWRAqKdcTuP5EEhrzOnY600ag/Q8DuyC16+isAgy
         veklj/+TE/6QOF0UNse7w1N+M+TtYOAKpNzodAzNjamnleWfRJSVYDNwmB3MnX7j9Beh
         phuRwA4ZAbGhzbowijIeIhgJmtPJP7sUEWtyr0gEKjaSplMKuZxYKUa0EgIssEG8xvme
         5FA+R4ktY5hLaFawR1/vcJaWQ4blUf9n9Lfx09IDLFzxJi9z8r7U4IRJU2GJZPfhl9x3
         R6QxDLoqT0u9RmgbcVLt22MbGDO6cEIkXR4Hgc3YQVs3cgJjvTReC0N/nPJYjY3fd39Y
         HVng==
X-Gm-Message-State: AO0yUKVggy6EeOySmOeWPC2JI3JteQRC+HGKF1/8L7L+sktAbLkm42R1
        YM71dL3fa9qPcRVvvNOzZvqX/CLNMpGB
X-Google-Smtp-Source: AK7set/9Pci6ll2S5cvaxvSCPTRJzKo0tu/SmqL1I4hR2HufQBDLnGZDp+NGQCzGzAW0G1YD085drkwR/BUF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr18419870ybr.6.1678587401195; Sat, 11
 Mar 2023 18:16:41 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:38 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-7-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 06/11] perf evsel: Add function to compute group PMU name
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

The computed name respects software events and aux event groups, such
that the pmu_name is changed to be that of the aux event leader or
group leader for software events. This is done as a later change will
split events that are in different PMUs into different groups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2dc2c24252bb..51d9650267d0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
 	return "unknown";
 }
 
+const char *evsel__group_pmu_name(const struct evsel *evsel)
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
index 676c499323e9..d26745ca6147 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
+const char *evsel__group_pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
 static inline bool evsel__is_tool(const struct evsel *evsel)
-- 
2.40.0.rc1.284.g88254d51c5-goog

