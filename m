Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7A5F10CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiI3R2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiI3R1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA261D8F31;
        Fri, 30 Sep 2022 10:27:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u12so4871660pjj.1;
        Fri, 30 Sep 2022 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=lB1WobpkhUf6urHo6McT5kj0otXKFdVMUG2TKkEYqg0=;
        b=jZ7QECLk3jxHAnEySG8oIfa0jV5Mcos+qHcxDi1XddyzrkPxUr0eTBLeweINIZf95q
         D92UmXqggk7ljSb+ErBVafmnNvKs+HwrP4GPq0qoLppE49A9RkkDRuKI/KKg2OnZjUVJ
         qxCaK5iqgqcYVFOExgRXSPMkspkrjkHk+HzLieogqnNn0g67tVc2mqrZVvD0gaqQqO2u
         UABGx7aASHJdnU0THOsxxRlYGSWvYz0++NTZiLrIDYg01HNkrr71zs8+RCtKu4XvGre5
         A0pUmLP6FtQbrPjKBGG4Y03RTOl521Ge+lrAob1GAZTuna25xaXPkc7v0MkXIopbRC+0
         1ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=lB1WobpkhUf6urHo6McT5kj0otXKFdVMUG2TKkEYqg0=;
        b=yqFnomkYp9X/5dollG+04LisNMZxFuUIQqgvpHLfH6dxY5m2RkaUKIcmWqInZtaVrZ
         r6SPcXNAfsMCxQJoXNE5TLHTuU4TXoypeNl2cvCrbNolTz35+6WMwr49DHncdqvEyNdq
         t+FGT3n9AO9zeJjmvIqhd79DWt9sBbLksYKEfJxz/UmsFt4rS1AZIakJU5cR9r58D8Fd
         MmiaNWwiI6+Qa4Oy9rSFAUMrB4/gwwfuGJ2m+48NfHj3j4I13Lkg9wBXEtp7LWzRmTPX
         RpPjaxT1tY5Xb7XZgw/mmcuBcXTDRDFehqI1EBYj4hZOVaW+LbxLSkJcdOelJhw1oTf5
         1c3A==
X-Gm-Message-State: ACrzQf39Cyo0I5bGY50K3dxKeVupI+dY/kO4D0UnKGUq1aVp/SeBfLu0
        o37iOsa0+fvYLQ1ucu9LL9E=
X-Google-Smtp-Source: AMsMyM4Bu1fMhTlG4S0PHAnxdIEBVhLc19mS8ZZ+7l/U0iFeGNvvbSNjHdZ2chAAK7XJv+Ux3y/6Lw==
X-Received: by 2002:a17:90b:33c5:b0:202:fa60:3765 with SMTP id lk5-20020a17090b33c500b00202fa603765mr23874242pjb.137.1664558854173;
        Fri, 30 Sep 2022 10:27:34 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b00168dadc7354sm2154762pls.78.2022.09.30.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:27:33 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 4/5] perf tools: Add evlist__add_sched_switch()
Date:   Fri, 30 Sep 2022 10:27:13 -0700
Message-Id: <20220930172714.711616-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930172714.711616-1-namhyung@kernel.org>
References: <20220930172714.711616-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a help to create a system-wide sched_switch event.  One merit is
that it sets the system-wide bit before adding it to evlist so that
the libperf can handle the cpu and thread maps correctly.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 15 +++++----------
 tools/perf/tests/switch-tracking.c  | 15 +++++----------
 tools/perf/util/evlist.c            | 17 +++++++++++++++++
 tools/perf/util/evlist.h            |  1 +
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 13933020a79e..793b35f2221a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/zalloc.h>
+#include <linux/err.h>
 #include <cpuid.h>
 
 #include "../../../util/session.h"
@@ -426,20 +427,14 @@ static int intel_pt_track_switches(struct evlist *evlist)
 	if (!evlist__can_select_event(evlist, sched_switch))
 		return -EPERM;
 
-	err = parse_event(evlist, sched_switch);
-	if (err) {
-		pr_debug2("%s: failed to parse %s, error %d\n",
+	evsel = evlist__add_sched_switch(evlist, true);
+	if (IS_ERR(evsel)) {
+		err = PTR_ERR(evsel);
+		pr_debug2("%s: failed to create %s, error = %d\n",
 			  __func__, sched_switch, err);
 		return err;
 	}
 
-	evsel = evlist__last(evlist);
-
-	evsel__set_sample_bit(evsel, CPU);
-	evsel__set_sample_bit(evsel, TIME);
-
-	evsel->core.system_wide = true;
-	evsel->no_aux_samples = true;
 	evsel->immediate = true;
 
 	return 0;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 2d46af9ef935..87f565c7f650 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -6,6 +6,7 @@
 #include <time.h>
 #include <stdlib.h>
 #include <linux/zalloc.h>
+#include <linux/err.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 #include <perf/mmap.h>
@@ -398,19 +399,13 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 		goto out;
 	}
 
-	err = parse_event(evlist, sched_switch);
-	if (err) {
-		pr_debug("Failed to parse event %s\n", sched_switch);
+	switch_evsel = evlist__add_sched_switch(evlist, true);
+	if (IS_ERR(switch_evsel)) {
+		err = PTR_ERR(switch_evsel);
+		pr_debug("Failed to create event %s\n", sched_switch);
 		goto out_err;
 	}
 
-	switch_evsel = evlist__last(evlist);
-
-	evsel__set_sample_bit(switch_evsel, CPU);
-	evsel__set_sample_bit(switch_evsel, TIME);
-
-	switch_evsel->core.system_wide = true;
-	switch_evsel->no_aux_samples = true;
 	switch_evsel->immediate = true;
 
 	/* Test moving an event to the front */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dcf57b271ff1..6612b00949e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -288,6 +288,23 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	return evsel;
 }
 
+struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
+{
+	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
+
+	if (IS_ERR(evsel))
+		return evsel;
+
+	evsel__set_sample_bit(evsel, CPU);
+	evsel__set_sample_bit(evsel, TIME);
+
+	evsel->core.system_wide = system_wide;
+	evsel->no_aux_samples = true;
+
+	evlist__add(evlist, evsel);
+	return evsel;
+};
+
 int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9d967fe3953a..16734c6756b3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -127,6 +127,7 @@ static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
 {
 	return evlist__add_aux_dummy(evlist, true);
 }
+struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide);
 
 int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
 			 evsel__sb_cb_t cb, void *data);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

