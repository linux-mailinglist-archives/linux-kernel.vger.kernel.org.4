Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8196F12B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjD1Hpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbjD1HpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:45:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279D5FC1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:44:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so3417138276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667799; x=1685259799;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc4/DOHtUjxnpuXBD+d4Mwt6syGmHUcHsLOGGNoKJoI=;
        b=THaUz2E6iAcSpDZC35TojRRZePpKoN0MtioWnQzx/ug3Xayu7qZsNFhTeIySMK2hkg
         /GnHGVPVPr3bXoBAI/OeRMW2easDVQkwEFHqgA+Ys7zIQ8u3DUZsrw3uaEjUiyyH1Ll+
         44fb9+T2txUP9a0g6jwkmyFBdDPvZM+Ml+YVgUzGDkxQGSU75lYZFh1FUY8BKhuoV6XA
         L7y9BaM84HKyRe7HXjk/EOq1yMLb8gJnQ8kYrfB5zkWMbD7mVsYBMkihBoE4cwAwvCFY
         6ntdWlRo2DV4c32BXfUnblO01OjHTDNWdw2z89lQFfLpnuWM1LJAkY3c+qt2ZxgAa8Gt
         ZTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667799; x=1685259799;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc4/DOHtUjxnpuXBD+d4Mwt6syGmHUcHsLOGGNoKJoI=;
        b=lF43Mra+uhtgEp+TH0tDwtv+lio8outEvAUen9FT3NG4PQCxFB6SqN6qPCvQK227Y/
         6X8dqgph+FKtR5aKBr58aZRDojtu3DYmTN/D3HkMoOTjcqjhtla8HQqt8Mc8tO+omFr+
         /cZ8H5T19x51EzBkuAUswuGWkMNHKct+WpAifxXcs6rI6E3Ah3C0c7PIv9tEf5n2F5+n
         UsmETZ+/SoAueHG/vuETTe/BMrS/iUBTcsi9VGRbOfTdyiIPj75YU4JtQTAhTtlum+Q9
         7ZWtmMznNhQHh8VI7PmvswMSZvhmcMHRNJ7PlQBSxkpEbQxhhUieOF4KMqz6i9zxXlPN
         U8jg==
X-Gm-Message-State: AC+VfDz/iJI7vzUl/xeNra1kH3VzEFhfOS2uQtMtHXVcdQFFFZCLIJpE
        vhJ45zxvyl4jykocHKYsWzaY2bmA1fr7
X-Google-Smtp-Source: ACHHUZ7AEA+mDyQk3I1alKpm39Fjt9eC0im5uNIiRZ70bkUKO+uVz15MtQCrIwyB7SqBr6VzpJzpLlFWxv2n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:188d:b0:b96:a18:1b4c with SMTP id
 cj13-20020a056902188d00b00b960a181b4cmr1711533ybb.13.1682667799397; Fri, 28
 Apr 2023 00:43:19 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:01 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-36-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 35/43] perf parse-events: Don't auto merge hybrid wildcard events
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
index 13057f50751e..9cd823fce247 100644
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

