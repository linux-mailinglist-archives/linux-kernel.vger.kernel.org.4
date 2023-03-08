Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6666B00B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCHITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCHISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:18:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2C58B6F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:18:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c039f859so164428207b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263506;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSc6zWu+gp18coqfyQ+Fs9l1x/Sawfb5L2ZQMm92/Ks=;
        b=gLWDALHSInxky1q6KNIpnowuYEoAGOGZqYbXoY4UG9TnPphzEsx1yixDt3YiKOyxy1
         XEKNGbnfoszZmuZYOOn1uPUN942/LROjz6KlDdi+FPTEjr/1QP440MweC2zp02lgEOmC
         E+S14VlZ8ME5YG8xPOkBs3cPdBsjbW+OEvwKzM8F2J7nGW9pCZwCgUedh8OT31ehxrcM
         7xAtmVbyAGN6ehrI35e+jjqnzVdIMOjJxe96QrrvDDwF9P2CZffeldPb6ktuDsSAVC63
         mGgZVK0PXgMVjtv+89zCZeeBEbXau66K9sL9q9vm8KxfN2xQ1SlPCmC/MYAUyQFCay4I
         m0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263506;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSc6zWu+gp18coqfyQ+Fs9l1x/Sawfb5L2ZQMm92/Ks=;
        b=uC7KbX9oyZvGs2AjZND7IPOtYKpvCgNFENGOgMQH42F9BWyhS9/x+2bTZGIia4ZDE1
         7g/2xZu8Q5NoAWbEJLbqAITWIz1pLA4ktCrwhZMFmk8z+ZPXxjwxdtInj2U+h3QIXcKP
         cNQCxBc6d5fkdcKs2mqwmQBDFA7BPtKoHKlOYv3eUgUStvFbwt80V4ek5NIWf3WW2djX
         vNPOLYRb6b1uHTq5uEYUjPkHb/unqdWpT6HDJiQp6EvarMQ/Vse8yiXJopZ6ZrxDVenv
         cWV874KkrL8ZAHR/KH7AHQ8vh+gyLqCxCm+kBGYyoaF7n2cwqk12UaT3sa3Qrns9A1QA
         KS0A==
X-Gm-Message-State: AO0yUKXphx/lcUfGJS6iG6ybf9tJ79U5XRs0V2qeYubk4Fhto1V+4tnp
        xu+8B/8FoI+5i5mDKKdvZb7u5Ce1CwF0
X-Google-Smtp-Source: AK7set/23H5ZOdtcYZfBRDyjidz9RK2zlWG161Fx6tujXY+ah9CAk/M7KPO62g4Wp4xGn09+d51ommDZZNtV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr10409623ybr.6.1678263506184; Wed, 08
 Mar 2023 00:18:26 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:25 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-6-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 05/11] perf evsel: Allow const evsel for certain accesses
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.40.0.rc0.216.gc4246ad0f0-goog

