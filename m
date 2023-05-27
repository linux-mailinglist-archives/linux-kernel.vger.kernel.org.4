Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB97132F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjE0HXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjE0HXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:23:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653BE10DD
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565c380565dso18761027b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172181; x=1687764181;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB5DwHaFliMtpjMaDk6VQJIJ/vYpJ6gF1J8Li4H573U=;
        b=1q3O3kORw3mhrv9r+5Zm+HmDwQqwJv+99w5JzN0QUUC/TY9In8fPqaMUipHqJgvX7/
         Uprm0cd9ycrLByMipQKENNw5PyVP28q5fEl8Y+a8f4XKFtBza21OB7LUrbsDgdJs0e3t
         BS5yJlC2UJUlXCX+n9MZ4smc9T26Gv9RCzCzzYBQIPgXMinE+7qy+vhLuKCdo0ROIVPd
         K/Am4jtggtE2HVG+DyNxNGSm3Ahgt7138kB/lZSRTOjLhQ4XpB6sws4fq9KZ35AvOKmn
         /JgY49Dovg2sPZDURVmLjmE5KAFM4AvPvh3WM7wsCWZh3CcrZC6/RfkcxHP1nvm/TfBj
         rAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172181; x=1687764181;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB5DwHaFliMtpjMaDk6VQJIJ/vYpJ6gF1J8Li4H573U=;
        b=c7nxQqeTlerpSLBqWGv4om6MMHuCybglRPGCj2+6Oq66g8Adt17XZcwvI2CBsW8IWX
         weJ8i6djcgEYNnwrp0WL7ZVUhe0xMQ5Q4DLbyrcEFLTrhlBEo+YEfHxqi/goJpI63tGy
         oeThKz6tUhmcE1gAyTiPlWPsNNo38W150AIBs4QKbFiKakslSMC0XLC02C39JztPyASG
         0+asLaVJrZHSSgYG1HZa9D+bJpsHfxqK8fxSivX80WhpMLfYNRBSjBwairmCcGkvbFUX
         b1Ox13JH4f34IRImgKjG1o1uyiAkJS3MUV+ApgTCMkSJ4TmM+GfMmHAWafEf7M5m1/dC
         hs+g==
X-Gm-Message-State: AC+VfDxgKVFMw/YMrhPLDwGg8HxuPDPqLsbAMAgzPhLnYwfCje77eqpe
        CUsAqalEzZt8e4e6j0oVb+uCGT6flH0d
X-Google-Smtp-Source: ACHHUZ4jLC1vmLpLgbwOdjeFBOq0LEOKedmcP+O4hGNqxQGSrB/qRWVBxEbqo8dTyOb9PruBLjyhspy4BqvY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:b71d:0:b0:565:ab24:ef3 with SMTP id
 v29-20020a81b71d000000b00565ab240ef3mr1032326ywh.0.1685172181086; Sat, 27 May
 2023 00:23:01 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:48 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-13-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 12/34] perf evlist: Remove evlist__warn_hybrid_group
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c       |  3 ---
 tools/perf/util/evlist-hybrid.c | 32 --------------------------------
 tools/perf/util/evlist-hybrid.h |  1 -
 3 files changed, 36 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 84d304cffd2c..d414ee30dcf9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -189,9 +189,6 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
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
2.41.0.rc0.172.g3f132b7071-goog

