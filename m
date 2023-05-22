Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA270B53B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjEVGnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjEVGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:43:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E769FDB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f1c2af16so50819867b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737819; x=1687329819;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoYQrktSOccz718yMhyWafTj7aToTsjoW8qdnpiUZYY=;
        b=p4E3xAl4XG1dKT000lYOPmwBSht2Qw2MVH35qpYGcnO9gDR1I/yWJmhkM2Y/cdCj+Q
         zuWQEAmrev+Yx2pU9KoOdGwuAjyfi0QspHLQEHvx3oVAzDsKGOFw2kHAlz4tsnof/O31
         yezQYBJcjfWx/N7dtIRCs2X8oq/QyaOvco7lZJytBmbJaljJw5LnGHe4W0mb8IlYxPc5
         wU+G/8UUCXSsbloow9Q4ZGdstpRp+gbLed12UVBy+PuecKiTQz9mvgxUofGWJIxg6D32
         w/qwzsxMxnGXJV+b7pCmIX3JUCE5wfmnyJ9Y25NvyycPG8Dinxa595ydHwPeJthq4b0u
         KxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737819; x=1687329819;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoYQrktSOccz718yMhyWafTj7aToTsjoW8qdnpiUZYY=;
        b=LxlH2vJsN8Hktvh2x4bJXg+9r21gb/eG9xc9XtplUK7ZedUxNgi+2bYG4cwW1J8UuX
         n0ktpOY7ebvmWoiUAYnpyYsyeVnsK7S+yqU7wV++gLOGmr26oAqS3eZD9DMK9hYavCoa
         pF2DFi7Mr8k2B1FqyUmh+I1266olNwOvD/Vw/NU53j6YtgYzXXfNvdPNFhelYqB03+S8
         gwmGpq0GNIp0Tvth1UP1DrY4np9ozzFtYDGJE+mOUPbQ0vPy7/rCdinOasP0vM9W1Ubw
         XI5hf5IR71ViBbGdwFUkuCzYIwqQ1lKDLeJVi5WM6C9o0F6UFwnM8hQIWr3OKOTvmUZe
         vQwA==
X-Gm-Message-State: AC+VfDxuQ99SY0L0R8xjJ7+SKm5UOcwms5dC9u9pk1KgFuRDNjSInbVS
        A88mhaWYVwhfK3F/UISELAVbDSE5n+kp
X-Google-Smtp-Source: ACHHUZ5zk5F+ezydcSeNEXKAuTWtoOxv1KsUK53ta6Dl2Ey4DOCdRM1cKjKUCN/xLGjgziKs06G4WAqcGHSR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a81:a9c9:0:b0:561:c10b:6ebb with SMTP id
 g192-20020a81a9c9000000b00561c10b6ebbmr6099609ywh.1.1684737819008; Sun, 21
 May 2023 23:43:39 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:09 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-3-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 02/23] perf evlist: Remove evlist__warn_hybrid_group
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
        autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1.698.g37aff9b760-goog

