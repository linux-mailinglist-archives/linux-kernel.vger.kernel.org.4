Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE296B1602
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCHXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCHXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4740D2925
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:59:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n139-20020a25d691000000b00b1f2dad8a21so241611ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316399;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSc6zWu+gp18coqfyQ+Fs9l1x/Sawfb5L2ZQMm92/Ks=;
        b=cZ1RkdbKHiQp8iMzmHZSmHN7kF686F5RFHncPOAulqbFLk/uhkfBFby2QgkyclXSPv
         7ZBNaJvLwhpnIbBGUillqyhQJSqOlE8aCOP7AO234mDx3bTyNJRaJl0k5NiHWCHi8fPl
         vLiQbMCfJXVvSUMhVygJX7OATIF9KGdSMJ5sTvUtU/DWfjI6H4uCvnwMhwVIA9773yE5
         b8JnshUYlXGTYvQEHBxe6ZUcKAa1VI3klTdxbJ5Vl11Im4MVFOmCbh/bPHnXRUNUYQ5M
         WIvGLcSJndZQBNrlny0Vwrz2h/qY8yJ8BMRoGG2ti/a0RBHBIKq2iV/9/W3m+xxxknE+
         uqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316399;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSc6zWu+gp18coqfyQ+Fs9l1x/Sawfb5L2ZQMm92/Ks=;
        b=4+5vR2cmQk+RXuhnuIZgcRtaljsnLrVBXRdD3HoPCGdiM4UqQUbNkONuCktHFT7Ekk
         8Z1GCPkaOkI0oIJ62k8kVtTs08n68AwPiFjsC/1g490q5tpIyLGdUMV58ECv44dVCdvu
         kTOSn9Ikj+7JyObj+mw5zkTQptz+cp1qmKekkIW87UbP4Q7fg3XlhBS8KsEoFsWST9da
         Mo46TcK3g3Z+QQfU5EyDAG11Z5BEG/LNuSWVwezpsNDePlg4JZHP+DbzU9nDQYLC8s2+
         jWODBMGU835U0jRDIwF3b7FAJXMewck6bGWfGYdXMhSWN4JsoyX/TUuN1FhN0fCBvLcD
         9Z0w==
X-Gm-Message-State: AO0yUKWHy8say5ZJXB2ffngsuNHkZwICuVXwVBhZgNjpBQPtiycL8xhn
        VRtugFyyjIAIAdH7cc0uZnI1u1tuTAQb
X-Google-Smtp-Source: AK7set+GjOEy31vfCiRG+Epqik+QPGMKXWEdUC8OwVI6098oYXCrT+cZWV4LoN0QPEtPPKf2c+Df2ABuQuEi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a5b:38d:0:b0:8ea:3d09:b125 with SMTP id
 k13-20020a5b038d000000b008ea3d09b125mr9627359ybp.0.1678316399079; Wed, 08 Mar
 2023 14:59:59 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:06 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-6-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 05/11] perf evsel: Allow const evsel for certain accesses
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
2.40.0.rc0.216.gc4246ad0f0-goog

