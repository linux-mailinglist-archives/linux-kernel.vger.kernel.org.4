Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2C6F2318
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjD2Fgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbjD2Fg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:36:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA59344A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:36:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b66a3275eso417158b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746560; x=1685338560;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIl1kUAo9IYD/UhzcgxFmKKCjB+AQPORsd+rIG9tHuw=;
        b=cVN0YdL7ddtj5JrxAYIqU+LfGzYb7kPu1CHgv4NhurPXxTGeimWIepl5GMNSUjxSVs
         RHfYOVexoa6QpeeDNXZCSSFl9GTzyRXj1v0aWsc7UkG0JtVNtc8FFAMYu6FQbSuUEUDO
         9LbBx2B+LVdUTnt7zB0VJSxm84lBlfjP6r72oXFmfNMRxuiCEpaIZlYppbNf/Xh0m3w1
         WQ8hPqt935xZdYZ0NPxGgQZt5WiSQ4IOhSncysujVc9d4HaS98tQX1BJvDYUXMMl2sg4
         Y11KLLulZMT1fQPvofXrOKeE3eLV/S5Rmqt3lqRm8r3j8GxwQPX4Rfz22sjzpV5A9EK/
         JHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746560; x=1685338560;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIl1kUAo9IYD/UhzcgxFmKKCjB+AQPORsd+rIG9tHuw=;
        b=EO5gpThres8WnrVd2quaukWAsSNZz1oYgNsBI3DRtz0IFm1If/+qvkTSMK5OsdNMJ9
         d4xwT00Rnu4HW7RM3qZivDgycSSDsIFoghN45+Cr6HZv10v5TJdPayOL2wOMpdUQyRgd
         I4p1xDwtP5cTUsE7RYIwpgqHEG0Jtk9zLOCpmOOELn9X9JSGmiNY+DBNJPOfMUg3yLYs
         ndfxqMhm33CwzZa/3Kqm0VauOsehvrqxH4fmn0VHV1ltj6tjIPq9A5BQNPv/fEq6ZmYY
         pJfNHBWmEXvTGMoG6aPJ2+FWCBwpb7ho12+egQWmrZl4zAbXqeROvK+nWIgqXKDcCwD4
         +j2g==
X-Gm-Message-State: AC+VfDySLs3NfURyEW3RhMN+a64KDnmBlmJeBTw0Ram9wEi0YsiTXWAW
        vyOuHJAyGRotQmEzZIOlKszIqfbM5kKe
X-Google-Smtp-Source: ACHHUZ4PXxHbwDxdRNRMUj2a+HODRdvSZGCSs65evD6naAIq3Wpq0ZJ1JnDD4jTqcf7pGI8+A0KR4geV3uOA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1625:b0:63d:255f:36f8 with SMTP
 id e5-20020a056a00162500b0063d255f36f8mr1991185pfc.3.1682746560270; Fri, 28
 Apr 2023 22:36:00 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:25 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-6-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 05/46] perf parse-events: Don't reorder ungrouped events by pmu
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
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

The pmu_group_name by default returns "cpu" which on non-hybrid/ARM
means that ungrouped software, and hardware events are all going to
sort by the original insertion index. However, on hybrid and ARM
wildcard expansion may mean the PMU name is set and events will be
unnecessarily reordered - triggering the reordering warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d71019dcd614..34ba840ae19a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2140,25 +2140,32 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 	int *leader_idx = state;
 	int lhs_leader_idx = *leader_idx, rhs_leader_idx = *leader_idx, ret;
 	const char *lhs_pmu_name, *rhs_pmu_name;
+	bool lhs_has_group = false, rhs_has_group = false;
 
 	/*
 	 * First sort by grouping/leader. Read the leader idx only if the evsel
 	 * is part of a group, as -1 indicates no group.
 	 */
-	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1)
+	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
+		lhs_has_group = true;
 		lhs_leader_idx = lhs_core->leader->idx;
-	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1)
+	}
+	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
+		rhs_has_group = true;
 		rhs_leader_idx = rhs_core->leader->idx;
+	}
 
 	if (lhs_leader_idx != rhs_leader_idx)
 		return lhs_leader_idx - rhs_leader_idx;
 
-	/* Group by PMU. Groups can't span PMUs. */
-	lhs_pmu_name = evsel__group_pmu_name(lhs);
-	rhs_pmu_name = evsel__group_pmu_name(rhs);
-	ret = strcmp(lhs_pmu_name, rhs_pmu_name);
-	if (ret)
-		return ret;
+	/* Group by PMU if there is a group. Groups can't span PMUs. */
+	if (lhs_has_group && rhs_has_group) {
+		lhs_pmu_name = evsel__group_pmu_name(lhs);
+		rhs_pmu_name = evsel__group_pmu_name(rhs);
+		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
+		if (ret)
+			return ret;
+	}
 
 	/* Architecture specific sorting. */
 	return arch_evlist__cmp(lhs, rhs);
-- 
2.40.1.495.gc816e09b53d-goog

