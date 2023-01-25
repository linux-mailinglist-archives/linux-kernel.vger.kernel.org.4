Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50B067BAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjAYTYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjAYTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:24:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E43683EA;
        Wed, 25 Jan 2023 11:24:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9so18824158pll.9;
        Wed, 25 Jan 2023 11:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ujiGpL29kziCWkNZQbKbe7voLq0Mqz36QhUqxaZlsdM=;
        b=JHuIDbTOkriV+7vCGtCkabHvcDkLESfQRA7thPAEAEF+H4JuF/cNVzNRdXIRsZs7ZH
         E4CcOLUY2LIWLiNdrPuexD+wmk4hG6NI8Bp3CeJGaqHwOIkTnwN7nWmJsi63lrdRErc2
         E9UB+XcLSo6SbOCVMscCUjvTLpn7t88KQMn+FQtUALsYFMmogsPFFIXAF/JX6lqRKt7j
         Mfe4e+z/Q9WedfmQZWXv4MEk+bA/fX7hVrhvUR5AofRgzaG4njUoSBrqHgEtsOq6lz8T
         7M2rFinedK7XXRPtZ8njOCSyELxH15USKqB/lz68alIq8GBoQSkrkpJe1vRLXZDFUJeN
         R1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujiGpL29kziCWkNZQbKbe7voLq0Mqz36QhUqxaZlsdM=;
        b=s5w+TdTbUgj/FpFmO38MHS7LNgoz6QZC0WiEVXn0WYGmQ1V6nMqr4eJs+PkRGVYXWa
         URr99azKqIkXqlnd98egPWgTdyXu53UDYd7bti+8BLxej3XgT3T5aZHmQ0IqFtct/AQc
         v9/x+J5UfF8f3O0CfqLRpVizYw0Ro4Sh993MGsHUujgZrN5g5z5fkjlEc6P128BrL/EL
         RWK+W4Ec5YwLCIyCkVoUrSk6apaVQyOoepmKGp/znPOmzQwJ4FlyIAICHfrXeKNW200H
         UpAqVQhsS6uIFYThRcYrFS2TO9QTfk/5NCd/RCPqPTk6Vvxa/31rKTgaRME+QuP616zd
         mtIQ==
X-Gm-Message-State: AFqh2kpjdwcJ8MXyzXDFproDnRoNsw+wk9YeXJEITaIfzrvUGjbmVCJp
        2hz4Kr6QyS1vhwFYX6E2vuo=
X-Google-Smtp-Source: AMrXdXs66379RJjn3gx3zcd7OM9OrtJLjL+TLhKUxwLwik3Svcsffp1m6Vw/cD69o5b80o2s7aCBUw==
X-Received: by 2002:a17:902:b68f:b0:193:30be:d146 with SMTP id c15-20020a170902b68f00b0019330bed146mr31649213pls.63.1674674674428;
        Wed, 25 Jan 2023 11:24:34 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:29ee:2efb:110e:b369])
        by smtp.gmail.com with ESMTPSA id p5-20020a170903248500b00189a50d2a3esm3972667plw.241.2023.01.25.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:24:33 -0800 (PST)
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
Subject: [PATCH v2] perf stat: Hide invalid uncore event output for aggr mode
Date:   Wed, 25 Jan 2023 11:24:31 -0800
Message-Id: <20230125192431.2929677-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Tested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* rename to 'should_skip_zero_counter'
* check pmu->cpus instead
* add kernel-doc style comments
* add Ian's Tested-by tag

 tools/perf/util/stat-display.c | 51 ++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8bd8b0142630..1b5cb20efd23 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -787,6 +787,51 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
 		uniquify_event_name(counter);
 }
 
+/**
+ * should_skip_zero_count() - Check if the event should print 0 values.
+ * @config: The perf stat configuration (including aggregation mode).
+ * @counter: The evsel with its associated cpumap.
+ * @id: The aggregation id that is being queried.
+ *
+ * Due to mismatch between the event cpumap or thread-map and the
+ * aggregation mode, sometimes it'd iterate the counter with the map
+ * which does not contain any values.
+ *
+ * For example, uncore events have dedicated CPUs to manage them,
+ * result for other CPUs should be zero and skipped.
+ *
+ * Return: %true if the value should NOT be printed, %false if the value
+ * needs to be printed like "<not counted>" or "<not supported>".
+ */
+static bool should_skip_zero_counter(struct perf_stat_config *config,
+				     struct evsel *counter,
+				     const struct aggr_cpu_id *id)
+{
+	struct perf_cpu cpu;
+	int idx;
+
+	/*
+	 * Skip value 0 when enabling --per-thread globally,
+	 * otherwise it will have too many 0 output.
+	 */
+	if (config->aggr_mode == AGGR_THREAD && config->system_wide)
+		return true;
+	/*
+	 * Skip value 0 when it's an uncore event and the given aggr id
+	 * does not belong to the PMU cpumask.
+	 */
+	if (!counter->pmu || !counter->pmu->is_uncore)
+		return false;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
+		struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
+
+		if (aggr_cpu_id__equal(id, &own_id))
+			return false;
+	}
+	return true;
+}
+
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   struct outstate *os)
@@ -814,11 +859,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	/*
-	 * Skip value 0 when enabling --per-thread globally, otherwise it will
-	 * have too many 0 output.
-	 */
-	if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
+	if (val == 0 && should_skip_zero_counter(config, counter, &id))
 		return;
 
 	if (!metric_only) {
-- 
2.39.1.456.gfc5497dd1b-goog

