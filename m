Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5166A549F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjB1Inw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjB1InO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:43:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D442CC41
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id oj5so5023113pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfT+QNOxQJmHazP6lqFky4KrZI/iD3/8HshJqJUPAo0=;
        b=iuxzl/3ycUirKWW7g7rP9l+Ew/AxwyvOiKcKab9PtFO2ZLRmobAnn1PvPdA/c/K9dK
         VHInkL1PSTRV+9Jos31sv+D92sFAsaJsoswIwTSjVWzM1XwXt+7y9jV1l7WM5ZFOJny4
         MPalqbfrrxEBBJtk+E+eRFXtFZKHSEf0f2FU7QOQC4RywMC1y5BuYczdwmh5/RpJRq0+
         4f/VaxfYu27xdyWJ2vsKVmOMLpnmyaQYztlxXqqET6uZvDXGJbJD5YLSBmZE7h80HPyB
         bTWJ9n9yGc9PYjY8JyHRMr/lroAtIYBwuetuZ07aLHVttnjOWsn78PJRfl01bc8E5yxr
         zcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfT+QNOxQJmHazP6lqFky4KrZI/iD3/8HshJqJUPAo0=;
        b=c0h11rjHkonga5KJ0qCYjCv94voUJpBgxrwoVFq5LLotO25+lLqNO+PMbwAQO1zvgo
         wsclvQL5nVFmMaBhXty2VNQAtkitVwdSY9drvLIdBtiBJ8wNJiRCUloYNHO4BeF5vRqu
         NA65fNtKQFrgPXGYySRtBsNTHX9jOExctS56zcy/FG9v454fD/FIFIITJVct0Xw+GgXn
         RR1sBRyXETBrTVcWcRLIlgzX7Grt+zlkMuMx62S/7s3K/rvywz+W6eemWdm37QrCvAkI
         0zhygwqukn4oaA65l5CTqLtCdNrBX3cuE7E45m8USJ2199JJgtsu98cHwNs9hr/beuvq
         ehbg==
X-Gm-Message-State: AO0yUKXrGnIHOuYabtaxKdPxKfZxIBMcI3tXeJsYC/vu5ajBa8QAyZ3W
        s3O8ABuXUDyOeh2ERR5EJpH8tQ==
X-Google-Smtp-Source: AK7set/dX2kNPLCqWPn/PwI3Svm6TNlA5iuUHw00BsINNLtGytVxSoBawKidocpjcD8+cs7VQwTR1w==
X-Received: by 2002:a05:6a20:3d91:b0:cd:3f04:6452 with SMTP id s17-20020a056a203d9100b000cd3f046452mr3218142pzi.49.1677573768163;
        Tue, 28 Feb 2023 00:42:48 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:47 -0800 (PST)
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
Subject: [PATCH v2 11/14] perf kvm: Support printing attributions for dimensions
Date:   Tue, 28 Feb 2023 16:41:44 +0800
Message-Id: <20230228084147.106167-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
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

