Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4275F97D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiJJFgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJJFgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB511D0E7;
        Sun,  9 Oct 2022 22:36:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12so3249024pjk.0;
        Sun, 09 Oct 2022 22:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DXTY41ddKxdcq29BADTCjhKr9aBOk2Cqelh2Y8ODfo=;
        b=Dqk6DD9wo5nb3PE+BcSytODfcs2WlweFTK8+DoMDvemAlT8uHjolY3M6l2JK4SLqr9
         ypP+Bbx2x+WdOvugY+LeMN7vU1Aupw7EHH4cci8PYkgdZ++l7Agf8fzPwlBmfwOTq2R9
         bWHf8ufgBoA3Ol5DErGH0vlj9tfI/KLJUCDS4m8tMbxv6ITCF9fnlT5AqRDYTVXWVdc6
         gY9yHpA6wWSyQnTv7iqkZA3OssJh0QVWh82dIFa+/SmBYFX3LdCR4djot/WL74cCY+vc
         Lk9yJh17LiOJSL438ABrMEHWzQ1ukTEaXAPs4DI2UIpLhqSu8IoFjO4uox6Nr61KucwU
         zMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5DXTY41ddKxdcq29BADTCjhKr9aBOk2Cqelh2Y8ODfo=;
        b=0MdXiq3ZVYxN9ZQLHcNePX39aSUZYHgSqGdj8/hDsTEGTbO+AgPf4ocedtDRkP7rSS
         lFEUn+EUdgTbLy/5F88+fbyi+8vNy5hCGnDItipNMFAFFyVflNrsuXOIAKBMNB/UwXXY
         rsgCBpTbudW0AVKJSZXqyhJda2Vec6d4IzSxEhNBAZeQSSQznGCBFtfvZtHxBrljEp/r
         636l9sb5gWNlF5fv6kvD73SxBk5tWXdbnEVw9gepz9+74bzTgCRsrfIEOjTI3fkkD0o6
         htSGoOVUZAvln+jb/pKxKFB+gOJ9fC6xfxveO+N18jYyuf5ZGgftdJJMhv0aoo5orVaK
         OXgA==
X-Gm-Message-State: ACrzQf0Wy8BpS6NlxjHtG0tHVPrgH1B7JqE8gU2ZS1rZ1kDa6/bDukqy
        xCEFuJFvn25XAZdWeYJXkI8=
X-Google-Smtp-Source: AMsMyM7gsllDbY5t2sT339PolgW0VloOjokCqTz41Wvhz02R2kIlGgQ4o06oFcgBOTAyDOsJkx3F6g==
X-Received: by 2002:a17:90b:1e0f:b0:203:2308:2ae6 with SMTP id pg15-20020a17090b1e0f00b0020323082ae6mr18844414pjb.187.1665380172002;
        Sun, 09 Oct 2022 22:36:12 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:11 -0700 (PDT)
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
Date:   Sun,  9 Oct 2022 22:35:47 -0700
Message-Id: <20221010053600.272854-7-namhyung@kernel.org>
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
index b00ef20aef5b..e5ddf60ab31d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1461,8 +1461,9 @@ static int perf_stat_init_aggr_mode(void)
 	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr(stat_config.aggr_mode);
 
 	if (get_id) {
+		bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
 		stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
-							 get_id, /*data=*/NULL);
+							 get_id, /*data=*/NULL, needs_sort);
 		if (!stat_config.aggr_map) {
 			pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
 			return -1;
@@ -1677,11 +1678,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
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
2.38.0.rc1.362.ged0d419d3c-goog

