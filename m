Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C491A5F97DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiJJFg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiJJFg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4347BB9;
        Sun,  9 Oct 2022 22:36:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso9480952pjk.1;
        Sun, 09 Oct 2022 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDi/57raCXYe0+xq0dxaV0OWm/rYl//UJ8wGRO2PpNQ=;
        b=oEaSErh+j674k/rte/i+WHl0RoLrfAp1Jg4Ws1Cm7Dz3+N4HWrwI+YlfWzSFIVZZmB
         dctrL+VdCzR+7t782QJUJ5SGIjegsZi4JZPDB4tYAp98yYRdUqoct42lJ5J3IfZcVivu
         1oWHyPGP5kriZVTz3BNPSu+6r34yPSIKfgUFpIZBEp2KW8o4LPTJoqT+67mazYyBA8t9
         Hwe1zN5VYTMVbo2r4xHqIWIOx1ZlZZuHlxdYaB4G0sW5TMNpszQMdPzcapbDKVOcX5dW
         h2EBFaqMNwga7nHEVMvygzzBzsW7eUa74lMOWOpkNX61mHPqAzbUZ5lz+g5vQFjFIeWL
         Ggrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDi/57raCXYe0+xq0dxaV0OWm/rYl//UJ8wGRO2PpNQ=;
        b=5PSATEXvF6EZFVn6Z2Lx12vSCN80Kwkjw6B5Zj5Nl3M2WcvNXJS3PKM0QYegYbNvje
         0qiRDb4YRStcR6iggXx+RzNDa5ivp1FerAWSbsIGS4jkZ9o40MohDjlaC6jnF2jkrDDp
         KbqzYSjOEI+IFKmALFX99VxmWqfOJA/AZsb4co4HnUbNJmf1W16smASfJF5lgffWEWFS
         u23VIjbZVkp8vvJULCDLzYOC7YTQ8nunfRvpTuiyY2ZlEym9k6GfUi0cEvQBy7vpU1QT
         38bSthX14VRxPDLVHe+lfOE4rawuFd7u7Rx6nCyQWFLrllos1KVQ3sVsYZKglnJBjoiW
         5StA==
X-Gm-Message-State: ACrzQf2oytf/tByhb6IsOMaOUBpH0b913vnYLDeLUOdCpIS9hYm9dw7i
        XXt+Rn+63OJhwON4Hsjt9Hg=
X-Google-Smtp-Source: AMsMyM4CoaWeqeeMqQlLoAcK3Z0ireY7ck28FFrkVOBk7HoLFEtPUNUJ9JUY61S0+Fa9DuwQqNg+DQ==
X-Received: by 2002:a17:90b:17c9:b0:20d:489b:55c0 with SMTP id me9-20020a17090b17c900b0020d489b55c0mr2831732pjb.232.1665380177959;
        Sun, 09 Oct 2022 22:36:17 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:17 -0700 (PDT)
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
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 10/19] perf stat: Aggregate per-thread stats using evsel->stats->aggr
Date:   Sun,  9 Oct 2022 22:35:51 -0700
Message-Id: <20221010053600.272854-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

Per-thread aggregation doesn't use the CPU numbers but the logic should
be the same.  Initialize cpu_aggr_map separately for AGGR_THREAD and use
thread map idx to aggregate counter values.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/stat.c    | 19 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 139e35ed68d3..c76240cfc635 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1468,6 +1468,21 @@ static int perf_stat_init_aggr_mode(void)
 		stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
 	}
 
+	if (stat_config.aggr_mode == AGGR_THREAD) {
+		nr = perf_thread_map__nr(evsel_list->core.threads);
+		stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
+		if (stat_config.aggr_map == NULL)
+			return -ENOMEM;
+
+		for (int s = 0; s < nr; s++) {
+			struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+			id.thread_idx = s;
+			stat_config.aggr_map->map[s] = id;
+		}
+		return 0;
+	}
+
 	/*
 	 * The evsel_list->cpus is the base we operate on,
 	 * taking the highest cpu number to be the size of
@@ -1677,6 +1692,22 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
 	bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
 
+	if (stat_config.aggr_mode == AGGR_THREAD) {
+		int nr = perf_thread_map__nr(evsel_list->core.threads);
+
+		stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
+		if (stat_config.aggr_map == NULL)
+			return -ENOMEM;
+
+		for (int s = 0; s < nr; s++) {
+			struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+			id.thread_idx = s;
+			stat_config.aggr_map->map[s] = id;
+		}
+		return 0;
+	}
+
 	if (!get_id)
 		return 0;
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 99874254809d..013dbe1c5d28 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -403,6 +403,24 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
 	perf_counts_values__scale(count, config->scale, NULL);
 
+	if (config->aggr_mode == AGGR_THREAD) {
+		struct perf_counts_values *aggr_counts = &ps->aggr[thread].counts;
+
+		/*
+		 * Skip value 0 when enabling --per-thread globally,
+		 * otherwise too many 0 output.
+		 */
+		if (count->val == 0 && config->system_wide)
+			return 0;
+
+		ps->aggr[thread].nr++;
+
+		aggr_counts->val += count->val;
+		aggr_counts->ena += count->ena;
+		aggr_counts->run += count->run;
+		goto update;
+	}
+
 	if (ps->aggr) {
 		struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
 		struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
@@ -437,6 +455,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
+update:
 	switch (config->aggr_mode) {
 	case AGGR_THREAD:
 	case AGGR_CORE:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

