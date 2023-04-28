Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AA6F129C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbjD1Hmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbjD1Hl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:41:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670F5FD7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:41:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7ba919dcso3018642276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667670; x=1685259670;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7D6E0hATCK7e1RhJ0eODuZwXaDaxrE5gp17wu1kd6s=;
        b=ze/5ew3jpj1KZCjt6ajAUTfCpdW80hWtznpenfko15Ukgv1jI1BfGB3KTNQiEH6KDC
         1xMdEah4Uxe6ETsfgCKT/3jok0H8+ORWcFJuQ4LcuXjJlSALIOMJ2RzNfFEpN1fkQYPB
         rtBym2YzutGfTsvbh6D5Cn2qC00s6j3+4uYJFDxWObaGh4bjDLHhz55P/PKklMStxD+k
         gcTDoAU2Z6vFQ386XXuRKS1vlnAl+ff1LneEQw0DzfXLoN9JarWmQjmUu2PHnE0zaWzd
         jygMKmf9yDqaqukbh22PNNw4XSYlH6HA1RRuh4EevlGyUx5t7F1ntGaRu9OUTDAry9+M
         0x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667670; x=1685259670;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7D6E0hATCK7e1RhJ0eODuZwXaDaxrE5gp17wu1kd6s=;
        b=cgD6+Q4OWbgESXij7SvbhSLiR6eatHVfNTFIcREzHsYn7El6ldRlAXu0d/XydaW1IM
         fwR3oSTMKql4nnHgqXuP5JbY8Ei4M5t/VrYzaW+1zXeOYXEy1yXgx6eKGqImYSbUTWPl
         lSLTImixuaEBuiFq0HRKzciCM1UKvbYBdWLUKfqIrHFb4LLeUYs+s7RrkNtRek+ktDzL
         mLYZizR4P2CS2C4SeEzjABFGOSLw/vhhvdufo/guWxwTZ4PLIp/XOY+w6DJ+douVtuQN
         jfPTTUrm36h9a5SXtpIZGcD/H1FR4KLYaReOyMRirP84/BBcecIE4PYfwXdGoJADOU6/
         sqJQ==
X-Gm-Message-State: AC+VfDxHQP14NcmdYmPuG4M/FNyJT3A5nKQ+G1ZfYf57HD7efSmF6sRR
        NE3iomkMFMqCQI8PddThk1sXsxTC8V3/
X-Google-Smtp-Source: ACHHUZ69ONUmbck70NtuZ3ln/f39SdDUlVMG4NhS9r1BK28Sp0MHS4/nu5DmC16S8yyoVF8MAFrCMTfs3f0z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:213:0:b0:b99:b753:342d with SMTP id
 19-20020a250213000000b00b99b753342dmr2433751ybc.7.1682667670411; Fri, 28 Apr
 2023 00:41:10 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:45 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-20-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 19/43] perf evsel: Modify group pmu name for software events
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

