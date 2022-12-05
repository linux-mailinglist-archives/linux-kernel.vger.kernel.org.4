Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8879164395C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiLEXQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiLEXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:16:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661FDFAC9;
        Mon,  5 Dec 2022 15:16:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v3so11834285pgh.4;
        Mon, 05 Dec 2022 15:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l1eMXUb35CswTS4yMhs6a5ng51PFHAvAxv8mok77/yY=;
        b=bpq4PJbPK9gkYXgRg+nxuqvx2NBP04RUBKdEzYu9tlvBrrJG6sA9KirAUtoNNkrvv7
         dg1iwSuojPzB5Wqn48xfpWbmGW0ccXkQE4hVBaW4/NWV6+8+KFx3674rt8VAsx5+mIcZ
         r0Mrl3JZ/f71Ra4lgKzNyLhgN4C3hW/pvWUawAJueSAYrrJO9MSn9e+lGagdU1vPEhZr
         /WqDbiyDynKbWqPc5lKnTbDdhuwNbPnLW0QxzuWbt0qQe5/WmWgo0wKrXhYwxAi8yFFD
         g6tt0njpEurEPl+VXk2Xf4rsgbdLLq1DXEsuaRPGInKYL0b66DHwMJxMqODZOuM0NtIh
         0LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1eMXUb35CswTS4yMhs6a5ng51PFHAvAxv8mok77/yY=;
        b=xsmYGDVKQJ9MO/cpShP7CqJgSLRWroM0Le1IRO9qXE/g20RUoKa7C6lGBcVy+uKtUc
         OXSEh8zaTwv3Rso7++KuwV54/ERxV7e0iit64r1y/zZgcF+OskPHCzCYMgbzQs1Bv6Lp
         RFWk2zz4sceMnNbnjMbEEaP4tj795T07yOC6Oi3Ro/I7z6OYW9tgj4i0AnxIHr1tCJhu
         OvTbBTozwUipDZ5LGidbscjNjIuyvZv3QrhxHe3bDTheyK2+PK7LDmhLNzo/qxVdOhki
         ZG/HY43bZvl0Lpr/nfMYxErtHeIlC477o1MskW1costn2QfGPw3llJdbyA5GcwmyQNe9
         jNaw==
X-Gm-Message-State: ANoB5pmYMV4jOTKoc/KZYFbJi3HkUIUwlQY/mIW+7L32hvcc6hn9xEQZ
        Kf+HPVw1rgIl3Ddhc8VAVts=
X-Google-Smtp-Source: AA0mqf7Zt0JiQq/jVcV4BbK4E2NDYPYC4BF9OlA7SzOMkRCGrgqSS1un9XF14Kl3g0spU2YvA+clnw==
X-Received: by 2002:a62:60c7:0:b0:56b:94f5:400c with SMTP id u190-20020a6260c7000000b0056b94f5400cmr66412045pfb.31.1670282192786;
        Mon, 05 Dec 2022 15:16:32 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:8f7c:b9c9:e06c:7b30])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001891b01addfsm11039616plg.274.2022.12.05.15.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:16:32 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf stat: Update event skip condition
Date:   Mon,  5 Dec 2022 15:16:30 -0800
Message-Id: <20221205231630.319759-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In print_counter_aggrdata(), it skips some events that has no aggregate
count.  It's actually for system-wide per-thread mode and merged uncore
and hybrid events.

Let's update the condition to check them explicitly.

Fixes: 91f85f98da7a ("Display event stats using aggr counts")
Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Athira, could you please check this fixes the problem?

 tools/perf/util/stat-display.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 847acdb5dc40..6c0de52ac4be 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -814,7 +814,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	os->nr = aggr->nr;
 	os->evsel = counter;
 
-	if (counter->supported && aggr->nr == 0)
+	/* Skip already merged uncore/hybrid events */
+	if (counter->merged_stat)
 		return;
 
 	uniquify_counter(config, counter);
@@ -823,6 +824,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
+	/*
+	 * Skip value 0 when enabling --per-thread globally, otherwise it will
+	 * have too many 0 output.
+	 */
+	if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
+		return;
+
 	if (!metric_only) {
 		if (config->json_output)
 			fputc('{', output);
@@ -899,9 +907,6 @@ static void print_aggr(struct perf_stat_config *config,
 		print_metric_begin(config, evlist, os, s);
 
 		evlist__for_each_entry(evlist, counter) {
-			if (counter->merged_stat)
-				continue;
-
 			print_counter_aggrdata(config, counter, s, os);
 		}
 		print_metric_end(config, os);
@@ -928,9 +933,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 			print_metric_begin(config, evlist, os, s);
 
 			evlist__for_each_entry(evlist, counter) {
-				if (counter->merged_stat)
-					continue;
-
 				if (counter->cgrp != os->cgrp)
 					continue;
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

