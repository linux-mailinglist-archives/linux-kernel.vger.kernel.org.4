Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F85FE8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJNGQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJNGQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732F61ACA97;
        Thu, 13 Oct 2022 23:16:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq16so4045794pjb.2;
        Thu, 13 Oct 2022 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5CrG2Qn7/sdGMA9qw8v3f1wqR62+gBzxB8W+0YBYW8=;
        b=ecdtNwOW4la+h9gxPqzdVVZAAuOGaARVWg9USJMX5lUxWYwmEVVtZbAgCKLZL/Pa3j
         5sfEZ6fdR9yqIQf00lGtAl3niatSqMfy31HSG44jXhwoN2Y5iEMIETJ150FB4xz2JU6+
         6eOxmCZJwx7rhe1ikhKzq1jxd9w/ylkwpPMGf5YDR9gXsZTW7DCxMIR1nFkEj1FaWtKu
         pxIYbqJO7XVDu8XQ3uvXy0TrGtI95Ss/AeG5UDt3/K/QqWPqQCRAgFGJclZDMsPN/6W1
         iSeI+qPz2Qj44oqcrJe26m9uFHTZp1KVBaFHjPH1hhIvEOqQ7rj4C2xx4zpd/10Z7seI
         NKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5CrG2Qn7/sdGMA9qw8v3f1wqR62+gBzxB8W+0YBYW8=;
        b=vRYpZXjmnaf+eqI3GMc76VlhPlxmlYNFgO/QRULmh6aNT/RQDfO8DE+C4LJ2X7y+q7
         alvOQeHVZ3Se87jNfidfIv983my/kpuaaPo3l2PVs+ow6RKaEAoB+Vyp24VICQtOT3Lr
         5MK2LYkq4cAZc4CUJMGo9JAfmCmIUSm7u7llc7L5cZ+YstJa/EGlSY01yMKzZdCSFZrs
         M8teHabQg/4gO72VLchGUN5MHGcuHl/Eu3UUItQEpH3KqWeOs0nApZxYkfEh4Ph7luIU
         d/nmoQIyL/v5pMtJqiddDHd4+fUzrolaoAkBriHdzhoXo18GbvcyQmiuhhgmqPCm9q4B
         kj2w==
X-Gm-Message-State: ACrzQf2JMHPoXPJ0grcwgY8xPx3TcvCMhHabiqUL5nk0duWmg8QPvjcd
        YPx3b6570DL+AGmxEluUprE=
X-Google-Smtp-Source: AMsMyM61KGH3Oo14GuFweFI35SgA3W4sR/3pXi3wFv9CTjEk5Kfk328wpOjdCKpOlw6NknIvXwV68w==
X-Received: by 2002:a17:903:2606:b0:180:8799:3685 with SMTP id jd6-20020a170903260600b0018087993685mr3520101plb.31.1665728162181;
        Thu, 13 Oct 2022 23:16:02 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:01 -0700 (PDT)
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
Subject: [PATCH 06/19] perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
Date:   Thu, 13 Oct 2022 23:15:37 -0700
Message-Id: <20221014061550.463644-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
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

In case of no aggregation, it needs to keep the original (cpu) ordering
in the aggr_map so that it can be in sync with the cpu map.  This will
make the code easier to handle AGGR_NONE similar to others.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 7 +++++--
 tools/perf/util/cpumap.c  | 6 ++++--
 tools/perf/util/cpumap.h  | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b03b530fe9a6..9053fd4d15a7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1458,8 +1458,9 @@ static int perf_stat_init_aggr_mode(void)
 	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr(stat_config.aggr_mode);
 
 	if (get_id) {
+		bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
 		stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
-							 get_id, /*data=*/NULL);
+							 get_id, /*data=*/NULL, needs_sort);
 		if (!stat_config.aggr_map) {
 			pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
 			return -1;
@@ -1674,11 +1675,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 {
 	struct perf_env *env = &st->session->header.env;
 	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
+	bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
 
 	if (!get_id)
 		return 0;
 
-	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus, get_id, env);
+	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
+						 get_id, env, needs_sort);
 	if (!stat_config.aggr_map) {
 		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
 		return -1;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 60209fe87456..6e3fcf523de9 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -234,7 +234,7 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
 
 struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 				       aggr_cpu_id_get_t get_id,
-				       void *data)
+				       void *data, bool needs_sort)
 {
 	int idx;
 	struct perf_cpu cpu;
@@ -270,8 +270,10 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 		if (trimmed_c)
 			c = trimmed_c;
 	}
+
 	/* ensure we process id in increasing order */
-	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
+	if (needs_sort)
+		qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
 
 	return c;
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index b2ff648bc417..da28b3146ef9 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -97,7 +97,7 @@ typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(struct perf_cpu cpu, void *data)
  */
 struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 				       aggr_cpu_id_get_t get_id,
-				       void *data);
+				       void *data, bool needs_sort);
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a);
-- 
2.38.0.413.g74048e4d9e-goog

