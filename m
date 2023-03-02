Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01526A7A57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCBEOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCBENc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:32 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EAA9770
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:13:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53700262a47so297050487b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 20:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730403;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LO/fXR3d0HBdbn73nzsVmC5djU2rebKQYcjeddZt4gc=;
        b=tM9qYoUEaaXREEFmacTnEmStmZ6agaAgsp+JnFwMQP9QMIU5gPctUEa6FHUHwTD4VK
         O3eKrk4jmGXeNg/FegWcldmwH+YFGpkdZ9ytrLMYyikj6hdcrq9UymZ6eQyXlIbrzxsn
         GCQle6+2Q3wvk6ZhgsGbacwHXuBwR3TZF+oO0qROO7CG5EYuItSCzRSWfmRNEMlncNlm
         jb6kNoJu3Th5uhvBJvtG5yhbirR55i+E8aMt9H+o42+fFmXKPZOMFFU6djQ5eq5OvNEL
         OTaFbaZnY2dDIs9Vm8x6ZY3zqtysUq2dCm8oqbMGmZFFiivIQVlSFFsHv3gq9rGHe4oD
         +uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730403;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LO/fXR3d0HBdbn73nzsVmC5djU2rebKQYcjeddZt4gc=;
        b=Y26RMKZdwdCp5WlsmNLtU18L3aDI0klFmB6T8KtvwCmgPSgLekXvi4QmjRdcEn/QnS
         mBlYIwJQl4oapsiY7kJIccMtp0Ju+UBMFdmUlcvfJfHMpJHViW0CjGbwkRSYv44ktMBq
         eqGw835ffjE6tpMgpTwy0nExU7apDrPJj/glFzBDcEQi9hzNxNbDJU7izSasnwdCLeDA
         HDsUO9Xnmc4a7YkrVdHz1fS/pZdD1qYyvn/TZFmQ4bOisfAxqHCLoFuSAwi0Wq3DX6I3
         aY42Hyc6cmJz7c19GFExygK0d4PlFo8v+dmIZ41aMbu1YB652491gZcgGzQNZoCva67l
         QOiQ==
X-Gm-Message-State: AO0yUKXghYkp/5ZLjFm0xjCqrWYLhnyoSQ0a4+RChYl0MhZ2xEBxA2a/
        9Ykz9k5HTRlYvRizO7l52AAsZt81PLYn
X-Google-Smtp-Source: AK7set8YF2QqPRVKwruz8Qwtn0JHT3jjcH/cTQiEYKL2cWR61jVvGW3DReDRIQnhEUVX+WmObfOCfMp9spy9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a05:6902:4b:b0:a09:314f:a3ef with SMTP id
 m11-20020a056902004b00b00a09314fa3efmr4717618ybh.12.1677730402765; Wed, 01
 Mar 2023 20:13:22 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:07 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-7-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 06/10] perf evsel: Allow const evsel for certain accesses
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List sorting, added later to evlist, passes const elements requiring
helper functions to also be const. Make the argument to
evsel__find_pmu, evsel__is_aux_event and evsel__leader const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c  | 2 +-
 tools/perf/util/evsel.h  | 6 +++---
 tools/perf/util/pmu.c    | 6 +++---
 tools/perf/util/python.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 51e8ce6edddc..2dc2c24252bb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3139,7 +3139,7 @@ bool evsel__is_hybrid(const struct evsel *evsel)
 	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
 }
 
-struct evsel *evsel__leader(struct evsel *evsel)
+struct evsel *evsel__leader(const struct evsel *evsel)
 {
 	return container_of(evsel->core.leader, struct evsel, core);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 814a49ebb7e3..676c499323e9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -212,8 +212,8 @@ int evsel__object_config(size_t object_size,
 			 int (*init)(struct evsel *evsel),
 			 void (*fini)(struct evsel *evsel));
 
-struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
-bool evsel__is_aux_event(struct evsel *evsel);
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
+bool evsel__is_aux_event(const struct evsel *evsel);
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
 
@@ -505,7 +505,7 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
 void evsel__zero_per_pkg(struct evsel *evsel);
 bool evsel__is_hybrid(const struct evsel *evsel);
-struct evsel *evsel__leader(struct evsel *evsel);
+struct evsel *evsel__leader(const struct evsel *evsel);
 bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 43b6182d96b7..45d9b8e28e16 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -988,7 +988,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 	return NULL;
 }
 
-struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
@@ -1000,11 +1000,11 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 			break;
 	}
 
-	evsel->pmu = pmu;
+	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
 
-bool evsel__is_aux_event(struct evsel *evsel)
+bool evsel__is_aux_event(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 42e8b813d010..ab48ffbb6448 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -83,7 +83,7 @@ const char *perf_env__arch(struct perf_env *env __maybe_unused)
  * far, for the perf python binding known usecases, revisit if this become
  * necessary.
  */
-struct perf_pmu *evsel__find_pmu(struct evsel *evsel __maybe_unused)
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
 {
 	return NULL;
 }
-- 
2.39.2.722.g9855ee24e9-goog

