Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6A6BB699
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjCOOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjCOOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:53:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905661885
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id rj10so8519773pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYZdsrHdzQhNgPnVDhJiRxXzSTwxol5Us4hF+GT6h6U=;
        b=Z/6R9liCK/YrFp9eYW9AUu6LjcM4VNWD0T+ur1ctZrYkL/CCX04ldFgRVAvsmKANMa
         MsBCR2iX9Z9KTNnc6Y2u4ilNwAy2qDvMnXvp1nHxGR+xafim2knMSamta8dG6pc5Tm1x
         PU0Bm8kEjchwO1RrLqoRcLJ3yf94PdOKIJNgS70HHS0x3bbwMhDCfo/ZIMwRc/xDUa1+
         sSnTN4Y1WRhhMXf+4BwbtzgcBtfCG8YnXP8KAVnY8FbyteeKVJbFjUox/ebgs61Y1/bm
         oJj9Rg8UBr6GO30Zr/Cf0vnBkp3n5OrZ/cFwHWbPkpJdQbSMxkTN5I24WSpjmq5DkTcR
         DW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYZdsrHdzQhNgPnVDhJiRxXzSTwxol5Us4hF+GT6h6U=;
        b=klmX4oltWRtAJbls84sqcvv6hYInRXpMmrjhTtWGwmScMeO0eG2pIrj0M5HRoRjL4P
         lkfmnDJSHACBtfc2I3V+2UoCtetZwd4Tr9oYKR9ToZQksHJvBC6VSuTdhfH9szm3MoHl
         RqpxOdWMVanSfL+2QMLEwrIWrL4Vlwbdro4iRGh89zwFwYkrDEl/TExPSuaDZSZeA7uC
         5xVHqKDQ4uYMgQ/iZmpXiQnNnhLH9YDFHQPHhW8HVGpgUYPqG4QszPsn45IL02QefBOu
         RjeQyMznV0jPblmHmLswZ3CfyN+1r47WAUpcRNxktSzwJwp8eRLAbA+3tpPIunU4lG7B
         SmAQ==
X-Gm-Message-State: AO0yUKX0Qe4VS2C25PdSAAWfdYX5lS8qhE4hI94QWIp3SnUcBUnv8BXT
        e+U2ubtKTF1PytHhl7OJSDSdaA==
X-Google-Smtp-Source: AK7set9WYvSWjIWJgp0gOzWd6Dr90KziquqYDNhjoLU7G8Dq0TcdXxYH33jyfL2gx99UjaaeADGPiQ==
X-Received: by 2002:a17:902:cecd:b0:19e:9f97:f427 with SMTP id d13-20020a170902cecd00b0019e9f97f427mr3556306plg.10.1678891964438;
        Wed, 15 Mar 2023 07:52:44 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:44 -0700 (PDT)
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
Subject: [PATCH v5 13/16] perf kvm: Support printing attributions for dimensions
Date:   Wed, 15 Mar 2023 22:51:09 +0800
Message-Id: <20230315145112.186603-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

