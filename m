Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC36EEEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbjDZHHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbjDZHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:07:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A843A9F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8a3f6b03so105014377b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492737; x=1685084737;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQLtw5RMB3Daw/2/bml2TpAPLMkiCqaBNsV2CgoJXks=;
        b=B5KI0A9KFlYxcY+7k1D7CUDFZvprNXA/okbjoAqOhSuauCGJZ5b07igWWW7E4jq/tm
         mZVH2hMLBFESMUOz5Xd+aKqrOfdewmKFgg7MAQVhe+gle01u1BFOMGwYv0jEQA83aPEZ
         ftkWXWafkTEhLxvP7dyb+UF0TT3g9MXnMyOGVACYEr10+zbpuCmJEXJjOstzbPcTZSZK
         JzXrmjxKE8sO0n1ZmTCpCa9s3CF+KEV+hpQPZrDV+T/EJni3d4WgJB+S1E6xJYt8OMxj
         t9KvpchghLLXp056Ssqn5bPldItVr8r3cgKtTfkKSV1PyH8lBaZKUrSiXdKjKb/5/E02
         UaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492737; x=1685084737;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQLtw5RMB3Daw/2/bml2TpAPLMkiCqaBNsV2CgoJXks=;
        b=FrEj4lpgcb/l0IgOeNOtjpy8PXjOQWn79kHsFdUEIoJuWMMu6GAvaGZM1ET/2yMdVO
         Gfo0jwjpDi8NnzfwwterKlHJ5JcsiDn4AT7MJwKjGJYM4IznNsBXho/o9mHsRvwpXFhv
         8C915XbSIDSEhT0uIAqGsMADYmfOFOuhMnFIm9zq2n+qWXv9uOTsal12mV+aHlYhUyX6
         nv6xzS7y2AFPe+ApNo6EYHjypojPWmv+0aqivdnpZTzQ5vDgmLQl0+BabRTZGpIPrzCv
         4P/+PCwIOqagcW2o3HCn9pmdIg0bgwmW8ao3iMKYsLYC11W/thURv09bjwZUysU9zpg8
         FXkw==
X-Gm-Message-State: AAQBX9f2g1zgcCnP2hWFn3tnqd+sOa132vumNNE7wmAuCMxX4S2FfzQr
        i6HGvza0Ujp6+mrEANNsTg/q2IekhJxO
X-Google-Smtp-Source: AKy350apWTU9HkhOaCBsCC7bZbmli/pO0tdxpBoo4po1yUZ6tk74U1W6It++yGs+Htsw8VyVXAfYW1zipfqO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:a843:0:b0:54f:68a1:b406 with SMTP id
 f64-20020a81a843000000b0054f68a1b406mr9571080ywh.2.1682492736855; Wed, 26 Apr
 2023 00:05:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:43 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-34-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 33/40] perf parse-events: Don't auto merge hybrid wildcard events
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
index 98e424257278..b62dcc51b22f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1718,16 +1718,19 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
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

