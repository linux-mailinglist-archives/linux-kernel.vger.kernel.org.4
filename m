Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991886B7658
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCMLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCMLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCD6423B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nn12so11678101pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYZdsrHdzQhNgPnVDhJiRxXzSTwxol5Us4hF+GT6h6U=;
        b=HtcQ1Dsqji+5/51Jgddi4wmF19iXqpi5/q3y1S7vRBhkcO+9eiAHZNJgGKugNGFJe3
         UkoD8p5470YfPpMcfbRLFm5bOStdn4VWkAeoMi+TZxn/D3t3pSicndN++cAPueo3Hvbz
         LKRjR1hcEmtJosnFX8Z4prmbcLX5cNAyfkDsR7ygVXxehulkCD7Izhd+0Ub0LgtdDHhJ
         tIsa7ldlKyyL/QRvQP9yDoAhy6IYqsHZVfLUCstKIRUlKliUeGbQ5JHl9ISaj+XJM3db
         rjZOjynBXF9AG20TqUhT3PFcYJ9T758CuiZQ5EC76W+4cbLkqpefNzrSaE8/0LOmdxJE
         hVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYZdsrHdzQhNgPnVDhJiRxXzSTwxol5Us4hF+GT6h6U=;
        b=IbuwBBEGmVaMifzGsmiBRo2kjQytV7no07N0c6SWURR6OY/CT+mnGPmoHjD0IzpYtU
         UJ2cLaSRureFjBx18UkqlsKlAriNXDHBXx+NvEHjMgzWLXVH5cgntJPuPFAgCvicF/cz
         Uiln9p2wk54J4kF8J545omHUzF9wt1JI0KQfjg8RzDPNR7tg5M0Bus5dF0SUvbSd/HGZ
         qsyYq5u0JAwEAwehH50sQoqIwPRYCsneUQhcr0U7WovZgH/KwR6E15fPWLdjzzBYNyQj
         sG7QHFPJ67xnOlisom8v+GuUiQ+1+I+w4w1BjpPumpPq1h1ODVicb/M79mbHEO+QYd5W
         /IIg==
X-Gm-Message-State: AO0yUKXBWayeFJpT1lf9kDV38mtjNQJjYIxwuyzvHAT3zRj86r2P/glA
        9dqrbtiTrO1VKU0KzlqGPKGs6w==
X-Google-Smtp-Source: AK7set/BOeUqqeuViWC/Z5kQPNArKlQiD0EepwzcBVBkbMOYcfXI7afFPERJ2nJOxEjyUZWsVdxaSA==
X-Received: by 2002:a17:90b:1d12:b0:234:e3f:f53b with SMTP id on18-20020a17090b1d1200b002340e3ff53bmr34768751pjb.21.1678707697421;
        Mon, 13 Mar 2023 04:41:37 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 13/16] perf kvm: Support printing attributions for dimensions
Date:   Mon, 13 Mar 2023 19:40:15 +0800
Message-Id: <20230313114018.543254-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds header, entry callback and width for every dimension,
thus in TUI mode the tool can print items with the defined attributions.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c | 97 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 1e9338855239..0d857df826cf 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -83,8 +83,12 @@ struct kvm_hists {
 
 struct kvm_dimension {
 	const char *name;
+	const char *header;
+	int width;
 	int64_t (*cmp)(struct perf_hpp_fmt *fmt, struct hist_entry *left,
 		       struct hist_entry *right);
+	int (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he);
 };
 
 struct kvm_fmt {
@@ -102,9 +106,24 @@ static int64_t ev_name_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return -strcmp(left->kvm_info->name, right->kvm_info->name);
 }
 
+static int fmt_width(struct perf_hpp_fmt *fmt,
+		     struct perf_hpp *hpp __maybe_unused,
+		     struct hists *hists __maybe_unused);
+
+static int ev_name_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he)
+{
+	int width = fmt_width(fmt, hpp, he->hists);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, he->kvm_info->name);
+}
+
 static struct kvm_dimension dim_event = {
+	.header		= "Event name",
 	.name		= "ev_name",
 	.cmp		= ev_name_cmp,
+	.entry		= ev_name_entry,
+	.width		= 40,
 };
 
 #define EV_METRIC_CMP(metric)						\
@@ -130,29 +149,77 @@ EV_METRIC_CMP(max)
 EV_METRIC_CMP(min)
 EV_METRIC_CMP(mean)
 
+#define EV_METRIC_ENTRY(metric)						\
+static int ev_entry_##metric(struct perf_hpp_fmt *fmt,			\
+			     struct perf_hpp *hpp,			\
+			     struct hist_entry *he)			\
+{									\
+	struct kvm_event *event;					\
+	int width = fmt_width(fmt, hpp, he->hists);			\
+	struct perf_kvm_stat *perf_kvm;					\
+									\
+	event = container_of(he, struct kvm_event, he);			\
+	perf_kvm = event->perf_kvm;					\
+	return scnprintf(hpp->buf, hpp->size, "%*lu", width,		\
+		get_event_##metric(event, perf_kvm->trace_vcpu));	\
+}
+
+EV_METRIC_ENTRY(time)
+EV_METRIC_ENTRY(count)
+EV_METRIC_ENTRY(max)
+EV_METRIC_ENTRY(min)
+
 static struct kvm_dimension dim_time = {
+	.header		= "Time (ns)",
 	.name		= "time",
 	.cmp		= ev_cmp_time,
+	.entry		= ev_entry_time,
+	.width		= 12,
 };
 
 static struct kvm_dimension dim_count = {
+	.header		= "Samples",
 	.name		= "sample",
 	.cmp		= ev_cmp_count,
+	.entry		= ev_entry_count,
+	.width		= 12,
 };
 
 static struct kvm_dimension dim_max_time = {
+	.header		= "Max Time (ns)",
 	.name		= "max_t",
 	.cmp		= ev_cmp_max,
+	.entry		= ev_entry_max,
+	.width		= 14,
 };
 
 static struct kvm_dimension dim_min_time = {
+	.header		= "Min Time (ns)",
 	.name		= "min_t",
 	.cmp		= ev_cmp_min,
+	.entry		= ev_entry_min,
+	.width		= 14,
 };
 
+static int ev_entry_mean(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he)
+{
+	struct kvm_event *event;
+	int width = fmt_width(fmt, hpp, he->hists);
+	struct perf_kvm_stat *perf_kvm;
+
+	event = container_of(he, struct kvm_event, he);
+	perf_kvm = event->perf_kvm;
+	return scnprintf(hpp->buf, hpp->size, "%*lu", width,
+			 get_event_mean(event, perf_kvm->trace_vcpu));
+}
+
 static struct kvm_dimension dim_mean_time = {
+	.header		= "Mean Time (ns)",
 	.name		= "mean_t",
 	.cmp		= ev_cmp_mean,
+	.entry		= ev_entry_mean,
+	.width		= 14,
 };
 
 static struct kvm_dimension *dimensions[] = {
@@ -165,6 +232,30 @@ static struct kvm_dimension *dimensions[] = {
 	NULL,
 };
 
+static int fmt_width(struct perf_hpp_fmt *fmt,
+		     struct perf_hpp *hpp __maybe_unused,
+		     struct hists *hists __maybe_unused)
+{
+	struct kvm_fmt *kvm_fmt;
+
+	kvm_fmt = container_of(fmt, struct kvm_fmt, fmt);
+	return kvm_fmt->dim->width;
+}
+
+static int fmt_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hists *hists, int line __maybe_unused,
+		      int *span __maybe_unused)
+{
+	struct kvm_fmt *kvm_fmt;
+	struct kvm_dimension *dim;
+	int width = fmt_width(fmt, hpp, hists);
+
+	kvm_fmt = container_of(fmt, struct kvm_fmt, fmt);
+	dim = kvm_fmt->dim;
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, dim->header);
+}
+
 static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 {
 	struct kvm_fmt *kvm_fmt_a = container_of(a, struct kvm_fmt, fmt);
@@ -214,9 +305,9 @@ static struct kvm_fmt *get_format(const char *name)
 	fmt->cmp	= dim->cmp;
 	fmt->sort	= dim->cmp;
 	fmt->color	= NULL;
-	fmt->entry	= NULL;
-	fmt->header	= NULL;
-	fmt->width	= NULL;
+	fmt->entry	= dim->entry;
+	fmt->header	= fmt_header;
+	fmt->width	= fmt_width;
 	fmt->collapse	= dim->cmp;
 	fmt->equal	= fmt_equal;
 	fmt->free	= fmt_free;
-- 
2.34.1

