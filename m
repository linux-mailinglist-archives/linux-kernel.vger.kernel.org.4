Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B148636824
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiKWSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiKWSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:22 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9160F9;
        Wed, 23 Nov 2022 10:02:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so2526268pjc.2;
        Wed, 23 Nov 2022 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJjAbNczdPmI+pY4vossNpZ8T3nSlNCnYIGtcl6U+Gg=;
        b=Cuu5H+8mTH7jygpCY2UXxe3pbnrfQIhaMU6p0rkTvte1Km2MeKSYJZTuy4LGGZ4fQV
         CbWtT4Sh771YsHRjJRBizqAvlZihRRztwBtcuezbqhthK3EFE+MasRmYGe9H27JRrVSa
         MmmUnr86X1depxIc1WwSs1rQnn9eprRM/XuajsgY5n++dVlrkfh9ZahatVaJYGa4V7od
         Sk6D30WhLENC3MGc9sCNSzcI/eRzI7rKVUIXjrsz5HDiGaqq7vgL+NmW2yH1/KuXIZW3
         /gsDhP7BE5a8/WZay0s512Okedc0ZGrT3OzUwRM/GSXipeIG1W2L5q0ZVo220T1/+td1
         Cu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJjAbNczdPmI+pY4vossNpZ8T3nSlNCnYIGtcl6U+Gg=;
        b=P5f+dUx3zs1Gu4NThVS4Kt2Tz+iJWEIE2j/UsiDzeIg2xQBVZgy7OkiPsbZXV236OD
         xanrHd1x2H2gl6opS7mcSvK2wsDYDyXo/+VLD3PJlRoO4f85IeuJuZ0ivZNnmCZvNZh2
         PkTHpi+iKPDixPJ6+834sSW3b3OUMjOYw5Zyc+AIAcXCMTOvzqUScGBsbi8Zn6jyau3E
         nX51sGLv2IEsRrbTbDBg/GiFdN/BDtieMk7x/QtDHniL/WDVmc38rdeacaTd6fIjwGug
         Zcxy6BtgWEPcY/IkT63xy5mlwSkHwwc7qWlue1GamrrXkONNw+8dVXnmYI6KP8/X2E4s
         Ax4g==
X-Gm-Message-State: ANoB5pkVUyDifnKzbxZqfGvOe41wM4vUX7EkzExJkod0tg67XNn6HXz2
        3ebWmanqIy/COMxeMYU/wyU=
X-Google-Smtp-Source: AA0mqf4p/kgDNen/7sM22GZpgInzPhmqpNtPY4PSttpSYgeuSwkMCYCJ+hbZgk3ZkE7UIKsmQ+YU2Q==
X-Received: by 2002:a17:90a:2b44:b0:213:d66b:4973 with SMTP id y4-20020a17090a2b4400b00213d66b4973mr37992528pjc.85.1669226540963;
        Wed, 23 Nov 2022 10:02:20 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:20 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 07/15] perf stat: Pass const char *prefix to display routines
Date:   Wed, 23 Nov 2022 10:02:00 -0800
Message-Id: <20221123180208.2068936-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
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

This is a minor cleanup and preparation for the later change.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/iostat.h       |  2 +-
 tools/perf/util/stat-display.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
index 23c1c46a331a..c22688f87cb2 100644
--- a/tools/perf/util/iostat.h
+++ b/tools/perf/util/iostat.h
@@ -28,7 +28,7 @@ enum iostat_mode_t {
 
 extern enum iostat_mode_t iostat_mode;
 
-typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, char *);
+typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, const char *);
 
 int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
 int iostat_parse(const struct option *opt, const char *str,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b8432c0a0ec3..d2894a519d61 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -675,7 +675,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
 
 static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
 		     struct evsel *counter, double uval,
-		     char *prefix, u64 run, u64 ena, double noise,
+		     const char *prefix, u64 run, u64 ena, double noise,
 		     struct runtime_stat *st, int map_idx)
 {
 	struct perf_stat_output_ctx out;
@@ -804,7 +804,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
-				   char *prefix)
+				   const char *prefix)
 {
 	FILE *output = config->output;
 	u64 ena, run, val;
@@ -843,7 +843,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 static void print_metric_begin(struct perf_stat_config *config,
 			       struct evlist *evlist,
-			       char *prefix, int aggr_idx,
+			       const char *prefix, int aggr_idx,
 			       struct cgroup *cgrp)
 {
 	struct perf_stat_aggr *aggr;
@@ -874,7 +874,7 @@ static void print_metric_end(struct perf_stat_config *config)
 
 static void print_aggr(struct perf_stat_config *config,
 		       struct evlist *evlist,
-		       char *prefix)
+		       const char *prefix)
 {
 	struct evsel *counter;
 	int s;
@@ -901,7 +901,7 @@ static void print_aggr(struct perf_stat_config *config,
 
 static void print_aggr_cgroup(struct perf_stat_config *config,
 			      struct evlist *evlist,
-			      char *prefix)
+			      const char *prefix)
 {
 	struct evsel *counter, *evsel;
 	struct cgroup *cgrp = NULL;
@@ -934,7 +934,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 }
 
 static void print_counter(struct perf_stat_config *config,
-			  struct evsel *counter, char *prefix)
+			  struct evsel *counter, const char *prefix)
 {
 	int s;
 
@@ -952,7 +952,7 @@ static void print_counter(struct perf_stat_config *config,
 
 static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
-				 char *prefix)
+				 const char *prefix)
 {
 	int all_idx;
 	struct perf_cpu cpu;
@@ -1301,7 +1301,7 @@ static void print_footer(struct perf_stat_config *config)
 }
 
 static void print_percore(struct perf_stat_config *config,
-			  struct evsel *counter, char *prefix)
+			  struct evsel *counter, const char *prefix)
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
@@ -1345,7 +1345,7 @@ static void print_percore(struct perf_stat_config *config,
 }
 
 static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
-				 char *prefix)
+				 const char *prefix)
 {
 	struct cgroup *cgrp = NULL;
 	struct evsel *counter;
-- 
2.38.1.584.g0f3c55d4c2-goog

