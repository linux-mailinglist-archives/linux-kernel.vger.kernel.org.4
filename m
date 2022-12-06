Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70DB644AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLFR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLFR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:58:10 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266D2ED51;
        Tue,  6 Dec 2022 09:58:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c7so11847053pfc.12;
        Tue, 06 Dec 2022 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BdUvwqC29XOrztFHqs4wKWQVR7XBu2du92zx1lFNE64=;
        b=PSe4+mYXzHhEgVlaq0aOgQBDwpCWFjR+24lSiDv96NMafzHjaZwhYoxLoSUvGVHlX+
         VpANMjL5sk0bWwZ35I8Ut2DVhHHy/GeuwmRSV6wr+ZLH5tWN0dJZNtnRpN3chryyQCOL
         G101IC2eqPz4/9gaD4jUOVh+vLjMb+HvOJmM9RkZ8tb6mTiSpBXOZcAC7nNAlgXB3w80
         RpQVmBlCTrg1QoO/dXZoZ9r0y9OPRn4sSFXM7M0U0Mj4mnh/LiJVMmLrC5XoP03xvTO9
         2dfomQ1R5u5q5j3eLupbe+U3JCPyNSbO03asgW5kLThd/mKx25sZ0Vv8It9bGXPw1qfJ
         SNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdUvwqC29XOrztFHqs4wKWQVR7XBu2du92zx1lFNE64=;
        b=5JxWE2u59kWakPYJWd3F5QTSyKBAtp9+BntcNYwWQpxYVweBsnVeI13HopnetVNoYe
         KEtEujpb7b2Ul5lAGVUlSxie+/w8K9iZiFexA8XKV3Kp+4nS0lTNawrzicFqbcIH/v1B
         dRDI2SgxKl+4YdS25j1oZ8f9mQ0uNbfvHuG1yVEg7m/ZhnwsnyjkZQew2k1ca3Ds1KbN
         cHY90os/txkAsC0ISwXgNmgnwuGJdKSX7s7plqw99bEcAQFSnfeVyQqDzd2sIQXI+CFA
         AzVfIC9FC2NCnZOjpLNaPGYbsu1FFKdwUZ489aw/aqVS/EP4jtvBz8jg7dt9SkFBFl2S
         4hqA==
X-Gm-Message-State: ANoB5pmIoHNpPXAV4zncJFvQtAHyLSWmokeW1nFUvJlydB6QTOcpSxdV
        kqE8Dh9PE2P26Kd6ij/RtO4=
X-Google-Smtp-Source: AA0mqf5920htsApHboXlf6EKdP55hmYLFoMzX6lqrYKAVep4HU9fKaApcshTLc056BVJW6DuPK62kQ==
X-Received: by 2002:a63:5611:0:b0:478:c151:cd85 with SMTP id k17-20020a635611000000b00478c151cd85mr8617847pgb.49.1670349489025;
        Tue, 06 Dec 2022 09:58:09 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:8948:2f20:37fb:a548])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001899007a721sm12836894pll.193.2022.12.06.09.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:58:08 -0800 (PST)
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v2] perf stat: Update event skip condition
Date:   Tue,  6 Dec 2022 09:58:04 -0800
Message-Id: <20221206175804.391387-1-namhyung@kernel.org>
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
Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 847acdb5dc40..a45aacc9df64 100644
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
 
@@ -950,9 +952,6 @@ static void print_counter(struct perf_stat_config *config,
 	if (!config->aggr_map)
 		return;
 
-	if (counter->merged_stat)
-		return;
-
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		print_counter_aggrdata(config, counter, s, os);
 	}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

