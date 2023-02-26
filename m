Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A36A2E27
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBZEWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBZEWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:22:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C2DE39F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso3070803pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfT+QNOxQJmHazP6lqFky4KrZI/iD3/8HshJqJUPAo0=;
        b=qptnsxVeddCZzP54pGIw/EKkorQ3BUbeevNbGhdcaMLpijxTPMJi50KWHZftsfuYK6
         Gv8h/QGhDjIqG6Fg97YhgGVaoVaFpVCf3TC++qJYSiOHUkZyrT/t8xy0V1ibvLZTg1WS
         RlkEdeeHGxp9QgwI/5hMjkP0D1ZMbdmNlzgV/+Oro/B54uu37MSZ7m2iiOQdD9KI2XRS
         2OrxxEIkBlTWtTk/GK4beifpBISUsQlDDuwOMyMNjYKqx2qDaLfQusp8FsY3LX78iZr+
         ba5D4di5hlfNNXMB6aHRP5OWUgzUIcOkCGecJ/2CzPWaNTiYzQaIZvWmKjh59hEStboC
         Jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfT+QNOxQJmHazP6lqFky4KrZI/iD3/8HshJqJUPAo0=;
        b=ExoOncLZ4QHycAJ/pYXaC7bpneUFSHRbb/oYG2b5QJBsNWVdFNwQZCTVdMESh0eNK+
         Y+ilXkShEww7aMghUrIKyKFiI7lwHPp6j3kpnJFljzJg7sRN6peEa1CB8pbJzq4JMHvy
         y/pB94BJki7OE0z44tmhPDxngo2E10GzYBCSGSeAVD8hRN3AXgTXu0MAwMg2HfR6B/SM
         51vGZIc26pyGQib1hNDu9vrMgg5vMhHWmui/9O3r/7O6EmT0NkDJ2r1XofgibMl0JeRZ
         VrcphtXXzU4KV+JkRafjg1l2+2HGNtQDmmmhAWXk78lInfkGzrIcCRdoBDFQu9XEom3O
         p6vQ==
X-Gm-Message-State: AO0yUKXAyWRbgfNHflW+UGzKvuX3EEAS1OrBNAXJAX6sVfb0L9mdcGy0
        7GUZn2MqEKO1krpYAbd0OGqVmw==
X-Google-Smtp-Source: AK7set+BDOEJ2XnrDX5dG1tyW64g3EQGqYSORZmc7omU5rhotsinTSK1VmmCR2hr/yBZbp25Ahf4Qg==
X-Received: by 2002:a17:903:22cc:b0:19a:a6ec:6721 with SMTP id y12-20020a17090322cc00b0019aa6ec6721mr25044023plg.16.1677385308551;
        Sat, 25 Feb 2023 20:21:48 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:48 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 11/14] perf kvm: Support printing attributions for dimensions
Date:   Sun, 26 Feb 2023 12:20:50 +0800
Message-Id: <20230226042053.1492409-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds header, entry callback and width for every dimension,
thus in TUI mode the tool can print items with the defined attributions.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 105 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 741ba65bf092..a56d0983c585 100644
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
@@ -102,9 +106,32 @@ empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return 0;
 }
 
+static int fmt_width(struct perf_hpp_fmt *fmt,
+		     struct perf_hpp *hpp __maybe_unused,
+		     struct hists *hists __maybe_unused);
+
+static int ev_name_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he)
+{
+	struct kvm_event *event;
+	int width = fmt_width(fmt, hpp, he->hists);
+	char decode[decode_str_len];
+	struct perf_kvm_stat *perf_kvm;
+
+	event = container_of(he, struct kvm_event, he);
+
+	perf_kvm = event->perf_kvm;
+	perf_kvm->events_ops->decode_key(perf_kvm, &event->key, decode);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, decode);
+}
+
 static struct kvm_dimension dim_event = {
+	.header		= "Event name",
 	.name		= "name",
 	.cmp		= empty_cmp,
+	.entry		= ev_name_entry,
+	.width		= 40,
 };
 
 #define EV_METRIC_CMP(metric)						\
@@ -130,29 +157,77 @@ EV_METRIC_CMP(max)
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
@@ -165,6 +240,30 @@ static struct kvm_dimension *dimensions[] = {
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
@@ -214,9 +313,9 @@ static struct kvm_fmt *get_format(const char *name)
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

