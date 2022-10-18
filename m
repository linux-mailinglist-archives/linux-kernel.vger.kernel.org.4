Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697776020C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJRCDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJRCCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802CC8BB84;
        Mon, 17 Oct 2022 19:02:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c24so12491440plo.3;
        Mon, 17 Oct 2022 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5CrG2Qn7/sdGMA9qw8v3f1wqR62+gBzxB8W+0YBYW8=;
        b=Vzx+mg4UQoni7cM+BNOEIcGwkEUUNjBpyZzYPEfdNLVugf6uVCUusMi0F/IRZPUeWl
         8PmNIYX8iWNKWIL6aZ+gSSwcN0l8MF4GFnnke9MKeWfJJz1Tr7XDMJS0Mi9rtjalUhK1
         3wfkXPeEVBmfJePLA/Eu2wKVcFHnmW5s6mr7rInLyu3KWz5prRFA82SwISAAEFfYjknE
         xV3UihvchvdxWNQOV/v05zz+16thxm98keeSr0exLyneX+6xem48M5hkNQoRVXiq7gw+
         raadCH4Na93GBtYk7HMkpQNMpzZrGIZNCSwV8GiLI9cVhiny7aaOreA9fUlp5CXp2PEa
         ZH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5CrG2Qn7/sdGMA9qw8v3f1wqR62+gBzxB8W+0YBYW8=;
        b=pV/xwiuE30cDoL/gWJ2Yf7khVykSMVWLZuZ3SyNGI7+mTNKCx91aJyppPBYdGqt9cO
         nGDfJ6c8AGZLvMXr9rmR7o2b7RmIt9/XJ2gggH241VhtPnDF0hcHu6MztVm8UdUPqPcE
         11j+o09UJaT/AAZ7ji8m4QrsYnx+4evt/Xgo2+99bSDCkrUrPOsArGogf0oCwTXZtC3j
         X1SsWrarcNRieE2zi93BsjpTVt+EkEqYbtxErg1FExHyQwnrX9C4w5tNNt/MssWCG/kB
         B1b83dkscLYarCoYVf2wwh+J4Akf/WdbEp6Ch5UCcdK8wPGnzzEKO++hb/GsIvd+db37
         C+zA==
X-Gm-Message-State: ACrzQf00jq/YKjByjJCZWtkdfTIRaRNBdabLsbUYM5poV5fYaGx10BbH
        uh6sRZcT9T86Zv+W6Sbv9Qg=
X-Google-Smtp-Source: AMsMyM4t5p9DVSfWTlmljK5AnwVxu+uJCa5o6I2b/p+MLZTYUPk2oNHHkay/o8wpA9A8VyaAFAadPw==
X-Received: by 2002:a17:90b:268b:b0:20c:e5fa:db70 with SMTP id pl11-20020a17090b268b00b0020ce5fadb70mr869950pjb.23.1666058561317;
        Mon, 17 Oct 2022 19:02:41 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:40 -0700 (PDT)
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 06/20] perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
Date:   Mon, 17 Oct 2022 19:02:13 -0700
Message-Id: <20221018020227.85905-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
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

