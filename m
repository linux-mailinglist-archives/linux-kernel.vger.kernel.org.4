Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D396F233D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347451AbjD2Fmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbjD2FmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:42:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7F30E0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51b51394f32so293207a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746838; x=1685338838;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMun7Fi9IhPa9JZ/I5pL4DGzuErIcYuCD85NRlCGuw4=;
        b=NOR6kuYQeLMZlxj1zCE6bhpoLNYJrS1pvKgXztTcrFGu/n4wtU+1EzvpxjDHVxiElN
         o2XrSaw2aATWLQaqLlmYVKW/PQt24W2YKKhai8nxbU2Vf3DJzwT1LGN90rkt/av2BEig
         D3adchfJM2SIzztxO5Vnzzl21fSd1a/xhze8Edr5K53m+YJ/OCL9aogHpZM+KTq5HnzV
         r+fv7XhRAc/Zc1UnJMlojEex36XVgbyXuL+BcWGbav1fwh+Dgz/VPmdIs4D/XhxuMKsz
         E869QHZEF26Oxm97ZOWHFd/i8lenuii7pM4ps29o0/gW9BWmJbu+p+hCEd1hMTFbvn3V
         Q1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746838; x=1685338838;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMun7Fi9IhPa9JZ/I5pL4DGzuErIcYuCD85NRlCGuw4=;
        b=UVcHH7DC1MXWOaHWOXbYD/NawzTwKdyHGEfNkXLnvF8plBIv/5kGywpFTUDZeaUmUx
         3Bdxh99D7wX9pchfBJDwcPpljqAJhJxc1OeD58YWBQw5Xi++wpMewlT/QlEI32sEJUtl
         Vyi7elqsm8YGsfLM/Dmi42En6WV/IXZwNPVwExrGHAltpQXRAottoTlrfzxEk3D9qhm0
         Wl/q6iHG9wRiksbQ9E+HjFaFhMIM9x/lcDdcBeTQfk1vS696qJ6aYhfZnwMWFueeKZyW
         RdL4Rb98SFQxU4RNY5Ceoqiqk16X0ggSZFkO66Uh22HsvRSGq/SSDn6QjuWMjvMKBjJd
         IJrA==
X-Gm-Message-State: AC+VfDwNgDPrv96P/HHbSK0tdJzz5zBoPVihTVYta0xdbYi/hCV7Jxc2
        CtRABvq79h1n1m4SNPPrcwFbH3vAc7Nn
X-Google-Smtp-Source: ACHHUZ67fiG7m1GUEoC5JSTkMfs2/pBn+8kf0Zoca1BEfV2lc5Fdx1GPiJaGe0T9xdHPG4F/Ry1VKt0S8nJ0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a63:213:0:b0:519:858f:ac7 with SMTP id
 19-20020a630213000000b00519858f0ac7mr1921689pgc.2.1682746838106; Fri, 28 Apr
 2023 22:40:38 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:58 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-39-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 38/46] perf parse-events: Don't auto merge hybrid wildcard events
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring back the behavior of not auto-merging hybrid events by
delegating to a test in pmu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 5 ++++-
 tools/perf/util/parse-events.y | 4 +++-
 tools/perf/util/pmu.c          | 5 +++++
 tools/perf/util/pmu.h          | 1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5d5d77fa398b..2dad88a6bf19 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1714,16 +1714,19 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct perf_pmu_alias *alias;
+		bool auto_merge_stats;
 
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
+		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
+
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
 				parse_events_copy_term_list(head, &orig_head);
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, orig_head,
-							  /*auto_merge_stats=*/true)) {
+							  auto_merge_stats)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f4ee03b5976b..4e1f5de35be8 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -327,10 +327,12 @@ PE_NAME opt_pmu_config
 				name += 7;
 			if (!perf_pmu__match(pattern, name, $1) ||
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
+				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
+
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
-							  /*auto_merge_stats=*/true)) {
+							  auto_merge_stats)) {
 					ok++;
 					parse_state->wild_card_pmus = true;
 				}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cd4247a379d4..f4f0afbc391c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1660,6 +1660,11 @@ bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
 }
 
+bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
+{
+	return !perf_pmu__is_hybrid(pmu->name);
+}
+
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5a19536a5449..0e0cb6283594 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -222,6 +222,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
+bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
-- 
2.40.1.495.gc816e09b53d-goog

