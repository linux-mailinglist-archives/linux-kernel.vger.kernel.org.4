Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F06B62DD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCLCRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCLCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F43E61B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so97198537b3.17
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587393;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Ijn71k8QI4DMQRSrbObFWviYSAeSJjwqU2daJUrts=;
        b=oWLEA466iP8i3teaQAOcf9qOtSvu06EnaktoId8F6SQqq3DCnsmfqsKDleXJ8BzOND
         jcdxH/0CFGdvBU2EwdXsFn/TCvrQzT84TaB4mklDOWsshnEmRYvIjVnTGra65Z8Q6bB+
         p1DfigrcVSDSYhQNO+2eLI+PMLoHcyGgt+IFQihIdXf7kCEl0ynz9W6CLTMKgWAv+p+A
         7Dqecp+/J2rsWGLs5hGWWA/qzaOUVdkeI6GiUZCkrnEJKP7aqLkygPxMmwqPXuQwWD03
         t4HSxIGmF8HPsYvp3CksnodqnXokpOHP3ksTuA2PBHwBaDKjKNFNAYcDD4ff6vz1Z5bY
         jhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587393;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Ijn71k8QI4DMQRSrbObFWviYSAeSJjwqU2daJUrts=;
        b=ztcYELG/sNdATiEeiKjzOC24WumPvJtf7s1+NrgfEdwpcf3iuUOWlPPYMIUeseP82d
         NK40R6/uogg4CLbCgkf9qqvNxDLeEURNigrnD5SZfsmINSmxXt7Z6HKckOzYEsqv05/a
         dqGjeOMb3svxonDdJjNWtSgldLv2g3y/CzrAPexzUW5DbJKoXo6PIOlOemdab9KWDP31
         MPvyR9qiYzCCpp0dfV5yNkB4BKIh7LuOdcE9ZPCc6DZ/fkeA/ZR3SUP6XYVH5b9hlTm/
         RmJ2Zirgzl0+02mHOXWpB036BVKLZUWk2q9nMcJcgew7zZJRdiXHfRx1QVBo+mv7wqzr
         iVbg==
X-Gm-Message-State: AO0yUKVZe0UT10VKbFBdZMVBVtZAJx31E3nzDVxbHpXKznC+Tc3nBJ4h
        frmZzHG1QiAmFnKn++A7Bz0T0dbrAnqv
X-Google-Smtp-Source: AK7set/4rBlIa3b+mGsFY1+yIPCZf66FBsecqFvck2bZTZtCsbqO36ckQWHaELQFVDqhxJFj+piQzVJkPHid
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr18419708ybr.6.1678587393270; Sat, 11
 Mar 2023 18:16:33 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:37 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-6-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 05/11] perf evsel: Allow const evsel for certain accesses
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
2.40.0.rc1.284.g88254d51c5-goog

