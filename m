Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87270706BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjEQO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEQO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:58:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC22468A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba84d0916a4so1460742276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335520; x=1686927520;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=co4J+RLQCrSsAkDbz+O0JQN5mf/3HC6cUdD7SOOuvnw=;
        b=KdRTZhvOJomjWjIy1icXpBmC245/59/sRUbHHt+KQUTyK7w6Yq+vR0TRAv3ybdI5OG
         TPKAdklu/9GchHUfMhrjwzE/2gk+b5odq2C0RdCfgi4V8plv6OCPfwJpk9ecrXuNxtJg
         Q/X5O4+GJ3RlbgXiLznCywRf7fRqCokSHUsclUyGIfiTOCVOFfoyyXXTnn2pPJwUzqK1
         1cutCf5Tyd+VjNLNAR/pZATVHkIAI/R2SGAyBZ4v2hqbjXPm2CUKX/cUFzaGrqpklj58
         ND3Hi/19GNwv+arcdVULoqX6unerqdZgvV/T4g/xhNO0txuiBEceokB9eQxUoHzY3cIV
         DpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335520; x=1686927520;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=co4J+RLQCrSsAkDbz+O0JQN5mf/3HC6cUdD7SOOuvnw=;
        b=lTE8bib9xozm4ZctGwYGOudzj9mlN/MD1OZoZcuTfbvkoOiNlr6KyzT/rwa/1S3gm0
         sy1D1aEE8L8sQx0cBx2KFJlm18eCmWwsh0UB85dl9txJRJDtA75GmqVfH1GBu8bxgsCQ
         oCKUpU0qxJNTY9zvNBnReSAyOhqxHLwCcb5HsFPbMvTHYHtp2oTtBuILT366hqmWBoBY
         ouMKrL0PQ+fdbVSpjqiZ2tVXwqRpxFW1jqhyLUxShlLvortwoSmnMGgeO9h0Uveeihjc
         F4E/6tO3fm9y47NTitwT5I2sFs4KJgKyjO98PZa33j/1PuL7l8vfWjv3U2hOoFaMp+47
         0E8A==
X-Gm-Message-State: AC+VfDwy+0dWC9MDH2n2zY0UDw8mUZi/s19a/TWPqhjvMc8M/06TnWGj
        /+WEFOnS5WbInekWUuYdesSlxuuJ5+iM
X-Google-Smtp-Source: ACHHUZ6XUS995g82GPvS4dREMZj76DbvNdtPUZXP+4TKIsfpmu0mHvVd9YjkhzjZA6P40Xi31dE98BouBXNt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a5b:5c8:0:b0:ba1:919a:8f08 with SMTP id
 w8-20020a5b05c8000000b00ba1919a8f08mr17403057ybp.2.1684335519983; Wed, 17 May
 2023 07:58:39 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:42 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-3-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 02/23] perf evlist: Remove evlist__warn_hybrid_group
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

Parse events now corrects PMU groups in
parse_events__sort_events_and_fix_groups and so this warning is no
longer possible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c       |  3 ---
 tools/perf/util/evlist-hybrid.c | 32 --------------------------------
 tools/perf/util/evlist-hybrid.h |  1 -
 3 files changed, 36 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 612467216306..084cc570b8e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -187,9 +187,6 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 {
 	struct evsel *evsel, *warned_leader = NULL;
 
-	if (evlist__has_hybrid(evlist))
-		evlist__warn_hybrid_group(evlist);
-
 	evlist__for_each_entry(evlist, evsel) {
 		struct evsel *leader = evsel__leader(evsel);
 
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index db3f5fbdebe1..0f59c80f27b2 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -41,38 +41,6 @@ int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
 	return 0;
 }
 
-static bool group_hybrid_conflict(struct evsel *leader)
-{
-	struct evsel *pos, *prev = NULL;
-
-	for_each_group_evsel(pos, leader) {
-		if (!evsel__is_hybrid(pos))
-			continue;
-
-		if (prev && strcmp(prev->pmu_name, pos->pmu_name))
-			return true;
-
-		prev = pos;
-	}
-
-	return false;
-}
-
-void evlist__warn_hybrid_group(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_group_leader(evsel) &&
-		    evsel->core.nr_members > 1 &&
-		    group_hybrid_conflict(evsel)) {
-			pr_warning("WARNING: events in group from "
-				   "different hybrid PMUs!\n");
-			return;
-		}
-	}
-}
-
 bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index 19f74b4c340a..4b000eda6626 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -8,7 +8,6 @@
 #include <unistd.h>
 
 int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
-void evlist__warn_hybrid_group(struct evlist *evlist);
 bool evlist__has_hybrid(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
-- 
2.40.1.606.ga4b1b128d6-goog

