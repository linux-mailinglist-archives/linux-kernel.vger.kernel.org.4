Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7255A6B00BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCHITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCHISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:18:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D39A3348
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:18:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536af109f9aso163948007b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263513;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVnqvPJIWvW8Q6RkCDyc/WyuejWqbt8BpFQxOyzWTY=;
        b=Dd5AtqIxiqrKsdgITUYGy2qdvIWIn7hXGg3AystvVuMH0hMFS4fltx0yn1PeTZ765O
         qs2MIFkZAd7KlrTcReMU0ShQYFbUF/72oakyl5cRJCKwpE1Q0ZuQVghBUkNPooxs6O91
         UciQ8fl+tMAT5weLM5rKPkrqZSm59V7ag5o19Oa8TxqwYmDQ+1dTciodHMlEd9f0EoTW
         rG7IpJNhJGzZzMM4GzyCLE/h7vh3m6ASkjAM+Q/YUJdSg6osNREONSmSZROS+0Fe9B2h
         Iy+OjU/WgANSB0TVouA8ZGbON99vA4ny+yRgRvV5xsYfHZr9j/ZRpCpSC94pIKJebPah
         8mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263513;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVnqvPJIWvW8Q6RkCDyc/WyuejWqbt8BpFQxOyzWTY=;
        b=vShaJYjwDhb73zlKLi14/66ehtDX6U6efa5zdm2jN0e7eyPVyQ5Bjr/WN/Z0xoNIbH
         H68EjQBo4h+E7Omk5DunJcD8vB3/qCBTCTzUiGokXAnTAW10/naPQKD5qzI3NZMAXGI4
         tRXEey6/bS+FwopE+NN0WPuN5xn0f61J1jAT5/QyCxZ+xxdfzGVqFvl3fsSL7GRR6p+F
         E0Q93aI4EMklikQl9wXb1za8bC1JG/hhxLdWdqnKn68WDFbaEbyJ49by78+W7bzX9fW/
         WkG99xWvdbeAWe+Z5kBXuwl21kj1Vui7hFAUicyjsceFVM7nQN+iKJvffhqLeMLWRW8b
         bzsg==
X-Gm-Message-State: AO0yUKWhaCeTGNYOooChcdFWaCPpAJC/abrecI6oIl5GhcWgzY6xRX8h
        +ZxcEIZaurl+FRRgQbxd64svhXT6KC9N
X-Google-Smtp-Source: AK7set9yRy04IKzIcosRVW9Zn3vDebQNB9h1NT13rTmOw/BVNpWGDlEwr26BwCGuN+axvpjYbeROetb+KceI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr8504481ybh.1.1678263513764; Wed, 08 Mar
 2023 00:18:33 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:26 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-7-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 06/11] perf evsel: Add function to compute group PMU name
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.40.0.rc0.216.gc4246ad0f0-goog

