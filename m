Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5655E8EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIXQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiIXQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:57:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA68B2CC;
        Sat, 24 Sep 2022 09:57:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso3091955pjd.1;
        Sat, 24 Sep 2022 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=a8E584MihiKhrfPuBohiQk7ujLHrncMgdIyW+Lv5p9E=;
        b=pDyguElPLfm2FUgIbSAlVJVNX0tPTsOjM/ZASm55g97xmRQsYeY4X6Z/QiqhiC6LNy
         eMMAnYSjtyMg8/10AOdPOJBgZGmnsHaHFJ4M8WC45ONr95jp9Y6BDVwQ4aF4x8XWV54F
         eL8wAYPxJVDZCTown19NL1q5bgnqqwtlRB755AIx+dhMXtYLfJVX32CSR3+uarK9xacx
         X6nXx6K/POtKN4YI4gmhSBwZNF9fKcpvn4Ta4g7PMbj6HHDtrJi+HQ3QXM4cio5OrxmC
         UMb+XE1dJ/NKRsro/WWSm+yZuP7x5v7Z3RWxFMzptu7T1g60UOyuDOA/EygfMSWzRtw8
         pUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=a8E584MihiKhrfPuBohiQk7ujLHrncMgdIyW+Lv5p9E=;
        b=pIx5MWwpuDGLI1wO8vzxZdTUVr3Vf3ujpy5uT53uawCdXeN8Mof2Thnk0h/ZqI/D6g
         GAJNilH6Na7cl4hKid9Vc5EDuL7yBQSnkOWAOIUryJQe9J9pli0yfV1RynlN3F0GoKMV
         8Mjovz3z6Nb9KqPu7XBCehrXhCKPNyyH1o3XjdKLjTgKWijQOek2ZtjGOnHGF5R91mbJ
         jzfJGd/qaaAs8zMNsfek+SpYwoIstR7oGfTRSs/71HbgTlcBSq9io7h8NNeHNE9s8dyI
         JIwpJ3iYHPDdkASRSiJUee6NDSO2Sv2/x4/IUuLbkve3lW+c9CLnKW2UDPrbPhuEQiH/
         MpnQ==
X-Gm-Message-State: ACrzQf0HLArf7HH1G1fFqsEEFE5vkihXhCafQpxOxRzqbRUYLhSFXDg2
        LUf68bE8vxwRuC/z9QKWZnpEFUQlf8Y=
X-Google-Smtp-Source: AMsMyM4d4/WzlSFWilGf7cobCWuRXC5dd1QxXso3ZgtR2ZADj6hDysA8ijj3BBySt8ozXd0vs8d+Mg==
X-Received: by 2002:a17:902:d34a:b0:176:b8ad:ba76 with SMTP id l10-20020a170902d34a00b00176b8adba76mr14545411plk.139.1664038664920;
        Sat, 24 Sep 2022 09:57:44 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:20c0:42d3:7ef1:1f3])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00176675adbe1sm7960082plc.208.2022.09.24.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:57:44 -0700 (PDT)
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
Date:   Sat, 24 Sep 2022 09:57:36 -0700
Message-Id: <20220924165737.956428-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220924165737.956428-1-namhyung@kernel.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
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
2.37.3.998.g577e59143f-goog

