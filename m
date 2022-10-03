Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C45F374E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJCUrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJCUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:46:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C434BD23;
        Mon,  3 Oct 2022 13:46:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16367527pjq.3;
        Mon, 03 Oct 2022 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=lB1WobpkhUf6urHo6McT5kj0otXKFdVMUG2TKkEYqg0=;
        b=BCxkPM4wNcakQCrEgGv4KicusofArmbjlK7ZurM5BGgBlbOlfmVI4MPFHhpSJN46AO
         qBzNe415CS9ziijx0eAL3O4SjY9JV4ggw7ka/8s+EAt+yLM1aW+f8YZYlkJ3GHWWDiVS
         izmPKpzQoyhsCTtiL2SpaNpza7ztCtXWDp97vZPhchlSoPPvPV9kHsXwCOFWB0jRyy6Y
         stXObazFrOU1KnVruZj1MPLy5fDtkuDjj1syIs+1Zvo5917BxhtbvB5raHg0KsW2MzX6
         oTNvmw2esDJesvFKPXrbLVPuaMVPkJJj98GceXREi6NvkR8EI3//5Iw1keNgOLdRciOy
         Nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=lB1WobpkhUf6urHo6McT5kj0otXKFdVMUG2TKkEYqg0=;
        b=H0NmxMquyOVu+q0xt0JnL1v/aGq+0SCouKNac9ixdbY1vtU/tVFIrFyAJL5KjWtNrv
         vhux/7TO6DpQt2TqSUiIXhGfshswt9sDn9iUgUnAy/UP0vXUzEaWn9KUEFjcGzwozI8p
         +9FNXBZHCbL92+vgTMsLvTyJpp4oG9gc1CcciX/vy/RlL7/2YtkztJObFag6Gc4VOWdj
         XjNcBcvEynp87lWa1fIHIhjL2xh7HgKDpI0q6dDpSdNuFnUQVgsG3tFva6mlSypSIy11
         +Sx4bysUUNcwClkdj/7qD0OxPfns9w9nkIyVskB9NcPxR3NFk2N9L4yeziIxf0XnLa5S
         Zpag==
X-Gm-Message-State: ACrzQf3j8rxiUKsWm0PMLahATVRBjIO5KI7Gmv/vRrCe8EsKJCuhfrsk
        lX8ssZNKBLyNWnDXHEEQxf0=
X-Google-Smtp-Source: AMsMyM5FEDAa6jhKMGPZjWfmy4GZaj+9TqSgAK5POwULjIyyGCnLTsyqzacWRW4MMbDc8NBuy0rX4Q==
X-Received: by 2002:a17:902:ea0e:b0:17f:624e:8afd with SMTP id s14-20020a170902ea0e00b0017f624e8afdmr5070262plg.46.1664830014424;
        Mon, 03 Oct 2022 13:46:54 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:63c9:72b6:3eb9:490a])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b0020a821e97fbsm3522931pjt.13.2022.10.03.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:46:54 -0700 (PDT)
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
Date:   Mon,  3 Oct 2022 13:46:46 -0700
Message-Id: <20221003204647.1481128-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221003204647.1481128-1-namhyung@kernel.org>
References: <20221003204647.1481128-1-namhyung@kernel.org>
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

