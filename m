Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F403F67AB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjAYIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjAYIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:12:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F58A75;
        Wed, 25 Jan 2023 00:12:54 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 5so11869567plo.3;
        Wed, 25 Jan 2023 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dz5A2+hnEs/TwXVPFfFU6bx14y/lc5WXCpWs10bBDqM=;
        b=iXPa1+kxoWTwOCe5ehYgKWhQRJqeN3VcuVAIISKDjU6u45Z1jC/vRleCX8uRrdCd90
         Edgqo96OZFSR5caNAqRnVmaxv6fTzgd4B4CafII8OwaafU9hZnazbQ+JnPvCeImdUXhP
         MacF+RIwZ259Ii4On0zq2za1MJ7kw0W02dCRNvunZhMmtjzH4jl1hLMxM7lESSrwLZyU
         1hQ0ZMi8WhmWzQyhVU3K7VIN9tDsz3Z3JFQlgaLFJK4QvdP0d0GSkJphlUcbLxdSCmD6
         gtuo+cE8ySGDyBZZLaWVWa/V2HbkS3gjMIe39YrWCG5ueF9K9kml/NMREBGVKXgZlbHR
         nITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz5A2+hnEs/TwXVPFfFU6bx14y/lc5WXCpWs10bBDqM=;
        b=V2fw3KnGSGmzfglnWJWHeFbrtvHLSSB+3p+mcm56ACUxC02E6+Vn97ignptviGWfD2
         pu9tnZa+jJZ9hYft1xSXdAPBYSvogoiK5WxoMgIgbPVGJJwzyXkT0UWM/ps03oniogwc
         fmldPoUEol8z3b4aZsivjfhhPqrMm4n5gunX9FHksgdw1G20mJ6y9YJrDszekGo2gFXI
         oy0PP8vwTfW330fxpXSbvRSZj+1j2dqfoOtTNO5DSe5lYGw/190/l8n2JKS9ZCzfxRy0
         24Dw5jyCqyatqcxHFP9QCdbrcmdZWnBEsbwirZm88L+inpEAboFWY1VRAAVerP6cHHif
         ft6Q==
X-Gm-Message-State: AFqh2krCfU1oGlLbHsqfQOgQqPtDQkrxzLQuIl/xvDUtdoZkELw1/Aig
        +l4/fK4MU52gzdSO1la5shk=
X-Google-Smtp-Source: AMrXdXu+Obv6+t6XFycPBaTAs5DSdUd2i91WLyKPwzmCyG4EDIRDrcl5Y5T6OfknsSzwNmDfebKUsg==
X-Received: by 2002:a17:902:e847:b0:194:7cd3:329a with SMTP id t7-20020a170902e84700b001947cd3329amr40518184plg.10.1674634373648;
        Wed, 25 Jan 2023 00:12:53 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:269f:fac5:4c75:d85e])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b0017f756563bcsm2992139pls.47.2023.01.25.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:12:53 -0800 (PST)
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf stat: Hide invalid uncore event output for aggr mode
Date:   Wed, 25 Jan 2023 00:12:51 -0800
Message-Id: <20230125081251.1244997-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
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

The current display code for perf stat iterates given cpus and build the
aggr map to collect the event data for the aggregation mode.

But uncore events have their own cpu maps and it won't guarantee that
it'd match to the aggr map.  For example, per-package uncore events
would generate a single value for each socket.  When user asks per-core
aggregation mode, the output would contain 0 values for other cores.

Thus it needs to check the uncore PMU's cpumask and if it matches to the
current aggregation id.

Before:
  $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1

   Performance counter stats for 'system wide':

  S0-D0-C0              1               3.73 Joules power/energy-pkg/
  S0-D0-C1              0      <not counted> Joules power/energy-pkg/
  S0-D0-C2              0      <not counted> Joules power/energy-pkg/
  S0-D0-C3              0      <not counted> Joules power/energy-pkg/

         1.001404046 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
  	echo 0 > /proc/sys/kernel/nmi_watchdog
  	perf stat ...
  	echo 1 > /proc/sys/kernel/nmi_watchdog

The core 1, 2 and 3 should not be printed because the event is handled
in a cpu in the core 0 only.  With this change, the output becomes like
below.

After:
  $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1

   Performance counter stats for 'system wide':

  S0-D0-C0              1               2.09 Joules power/energy-pkg/

Fixes: b89761351089 ("perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events")
Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8bd8b0142630..b9dcb13650d0 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -787,6 +787,22 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
 		uniquify_event_name(counter);
 }
 
+static bool check_uncore_event_aggr(struct perf_stat_config *config,
+				    struct evsel *counter,
+				    struct aggr_cpu_id *id)
+{
+	struct perf_cpu cpu;
+	int idx;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, counter->core.own_cpus) {
+		struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
+
+		if (aggr_cpu_id__equal(id, &own_id))
+			return true;
+	}
+	return false;
+}
+
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   struct outstate *os)
@@ -814,12 +830,21 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	/*
-	 * Skip value 0 when enabling --per-thread globally, otherwise it will
-	 * have too many 0 output.
-	 */
-	if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
-		return;
+	if (val == 0) {
+		/*
+		 * Skip value 0 when enabling --per-thread globally,
+		 * otherwise it will have too many 0 output.
+		 */
+		if (config->aggr_mode == AGGR_THREAD && config->system_wide)
+			return;
+		/*
+		 * Skip value 0 when it's an uncore event and the given aggr id
+		 * does not belong to the PMU cpumask.
+		 */
+		if (counter->core.requires_cpu &&
+		    !check_uncore_event_aggr(config, counter, &id))
+			return;
+	}
 
 	if (!metric_only) {
 		if (config->json_output)
-- 
2.39.1.405.gd4c25cc71f-goog

