Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E26A7A58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCBEO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCBENf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:35 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C1469D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:13:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c039f859so304656987b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 20:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730410;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xN8iuJv1MwmAnYiwxUStUWtntqNOPw9NdTU5dZ4INM=;
        b=AvkU0jrks7LC3k+CG51zaJjxNiUmWOkBDUXwqMuaTkpPnvWrtSWjLG+i9D6LB3phPJ
         dd+Jyg27C0Ak5OqjBpy/965D6LNvaRQxe3AJO4JJFFdJ11PEuAi2/KtZQh8nVDK2bLY+
         M2jL2FLqYS5Nr7K3JAP3yzvJYIPFR42JsGjoAFwAJJuzkTVRACFJ6N4Kl65cL+D1Bafy
         f77PtaJ2NzAR9HmuH0Fr2FROhhNQKBqapDIpRzyXHxQTbqMpV3k3apHOLV0Dy6FjyUCW
         xGxWDZ2Hm1mnixNeJddZyJcY3Xfq9ICe1bS+SUaFLBKpLz4fnuX20UdQu6vwcshlyimJ
         l5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730410;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xN8iuJv1MwmAnYiwxUStUWtntqNOPw9NdTU5dZ4INM=;
        b=QAY98xr2LCnoQW9UGpMxSXk3C0N2IkK7y1K2YhRxR4Vy2bHBK78WG43xN/6mL/MIur
         6XpA3q1XmvoXz+xj8hvYjxHvFzNwZcJ9AAAriKkKWzso+VzI8cXGjUGSEaO0DTgqQdxX
         oPovKm0AvF6ng5p34O6bVMU3jNJTGrsdaoX3NvS1WNvoUTmq06Pq26dm6T+NtSZLwO3z
         OGxbccQPmXr1wepCYYVLn+dRF9sAbq6yFsRvWB1dOUIXTLU82pKHIALb3lqpscTVDDmg
         KDbufGwBY+0I17UZ5TAoCIeA4H+PfyNWSrTOGww9nJJ+iOrCHCsaJOHX3znUtL4J1Tgp
         JhwA==
X-Gm-Message-State: AO0yUKVTqGsgD2FXNd3JGU1PBuIzJY+LnBe/6I4Az+9WBaL6UpGs705b
        U8xqtNaCjnEyuZcvR/e6C6Wxl3Uxz030
X-Google-Smtp-Source: AK7set/LhGMjABxvayYzpREccFiH3hj+NJM9GUP/aPbn5ocwVtCFBMRnbM1lX1csQTDnx4DarH6rYnJl0reU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a81:4515:0:b0:534:eef8:caa9 with SMTP id
 s21-20020a814515000000b00534eef8caa9mr5430233ywa.8.1677730410545; Wed, 01 Mar
 2023 20:13:30 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:08 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-8-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 07/10] perf evsel: Add function to compute pmu_name
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
2.39.2.722.g9855ee24e9-goog

