Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79A6F4D09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjEBWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEBWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:42:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26033C3D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:41:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a805e82a9so9887843276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067295; x=1685659295;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7D6E0hATCK7e1RhJ0eODuZwXaDaxrE5gp17wu1kd6s=;
        b=D/bkUj+CvVAC7aYfNgnj4KG5nYd3eTAqh9e6DM0gZZCoQjFlJnRsvX7S3ZBoM9MfVM
         KovVZNSKZIy2UKW3qeC63Thp8iWn9rHXFjDF1VBowQR1A9soWiwMrXhk3BKdOYLbxIHi
         iy2ENXEPlZWq6HdDGDMhx6Fp+UZyezvplvUvthMQ3yN0+8U1X0zMaAvbBHvjg2hEzSGA
         8RC+TbU+v1BSw9c8YFFtAevtcRnNXp+uQh7oL0j0PWWa7H+9zbM0fQaAiO6xVNMKOSC9
         E/0k/1HdFn9HJrPvmmkZgc7CzWtGHCF3DM03VK8bXN+3zyxaRJG7karDc8BdJ147CuHc
         aKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067295; x=1685659295;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7D6E0hATCK7e1RhJ0eODuZwXaDaxrE5gp17wu1kd6s=;
        b=gFadxnz/10jB0Hw3e7HaO18C9Hj9++5xsmstIBLXiYZzDVC3kvIrPjnlZqmvYwk3jU
         mekoVZ6CWWToUz5N1r8sr5klsNKNU2o5D8+6L00IXK4ygixo1SjTTHCmnii14ywIVpHa
         75IDsYcaJ9pyHpQ3dRRr0rjDbaAgRa3WPOGNae975zCGbwMxkc5Xul0xVmNA5wGGr3n1
         z1kbViqGnoutbL6uL3jJYggIrqTxZq4C5Z8pUNIn22IaXbhVrhZKrO3SBUpy1xXXk8pp
         XQ03fzEX0+frIKL2KS8G1Bd4H8/OQj9ITwLSAeXRxLzTXZFolNsOD+WPB+Z+2HTDLIpN
         K7xA==
X-Gm-Message-State: AC+VfDxgWyfTjpev3NgSyexvNhJeRFqHyGU7R4yG+migCOtGKZ/cVnz5
        5aWP+9wUdiwYXL15JY36AIYXzRa37gk6
X-Google-Smtp-Source: ACHHUZ7LYH229NyKNMZkZWsQienaXd755Yu/epnis0xg39gsfR3yA6p0IrF5aj4wIWeZaeopiMz6DL1RqYce
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:d08a:0:b0:b99:34c:ab15 with SMTP id
 h132-20020a25d08a000000b00b99034cab15mr7544350ybg.1.1683067295712; Tue, 02
 May 2023 15:41:35 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:26 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-20-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 19/44] perf evsel: Modify group pmu name for software events
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

If we have a group of {cycles,faults} then we need the faults software
event to appear to be on the same PMU as cycles so that we don't split
the group in parse_events__sort_events_and_fix_groups. This case is
relatively easy as cycles is the leader and will have a PMU name. In
the reverse case, {faults,cycles} we still need faults to appear to
have the PMU name of cycles but the old behavior is just to return
"cpu". For hybrid this fails as cycles will be on "cpu_core" or
"cpu_atom", causing faults to be split into a different group.

Change the behavior for software events so that the whole group is
searched for the named PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1cd04b5998d2..63522322e118 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -829,23 +829,26 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
 
 const char *evsel__group_pmu_name(const struct evsel *evsel)
 {
-	const struct evsel *leader;
+	struct evsel *leader, *pos;
 
 	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
 	if (evsel->pmu_name)
 		return evsel->pmu_name;
 	/*
 	 * Software events may be in a group with other uncore PMU events. Use
-	 * the pmu_name of the group leader to avoid breaking the software event
-	 * out of the group.
+	 * the pmu_name of the first non-software event to avoid breaking the
+	 * software event out of the group.
 	 *
 	 * Aux event leaders, like intel_pt, expect a group with events from
 	 * other PMUs, so substitute the AUX event's PMU in this case.
 	 */
 	leader  = evsel__leader(evsel);
-	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
-	    leader->pmu_name) {
-		return leader->pmu_name;
+	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
+		/* Starting with the leader, find the first event with a named PMU. */
+		for_each_group_evsel(pos, leader) {
+			if (pos->pmu_name)
+				return pos->pmu_name;
+		}
 	}
 
 	return "cpu";
-- 
2.40.1.495.gc816e09b53d-goog

