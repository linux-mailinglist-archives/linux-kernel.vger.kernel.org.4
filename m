Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01DE6A58A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjB1Lyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjB1LyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:54:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60E35B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i10so10095683plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owO6RMSXMhELaAiCDQfYtj1K3jFcb8cutoYS8UegXjk=;
        b=ITgM8j1GNblZluoCqcj6FUwDHNTxwKsb1LYP1MNGuaxh5G+XqwLEIsI4/pwROkU+I8
         8p5oBFu7V/VHOX6pMAjvbKB79L7Blhmrs/36PnPgRJYQrhv/QxikWDsg8TedlTxYMiWh
         /Zk9N3ZeLqXIXOxRejXRBAdpvCr7s0aW0/vBUAroM+dL8txrhE/hpHyTN9bqgEQg9etH
         de03ZvVRY3lLYt2aBgusTebVc4FVjtAbaIZa9qOE7GVT8/yv6aajd/x0YCYpSoGUwLR0
         lKMU2vI2TEMxS7JM2iE5UrZY77+RxfM5kEGLjzTN5GHOJC+pXAjS3qgMJSMXp9tatkFs
         pN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owO6RMSXMhELaAiCDQfYtj1K3jFcb8cutoYS8UegXjk=;
        b=OJWizj8MhBzVON4AGvS+fC3+HKxoRMcalBkNGvnTg4O7EKX2f7CuHVIvqvYIzFXYdj
         mA19I/M3PjcdAZQX4eOqvqezMqb7hMhHdd9MyYhDxOoBJK2auYouIjUJqGboCj27urSP
         4w8sB28arPGIVG6Vsp0TievpJH62Nk7ZnYamPTINDF+wtJZxhXMMSZvGe2Xo2Fa4QtlD
         P7nABAtWWrI2liVreYNdixco3fnAkM4QCDQCHFNq/GaIyytvjKOOeETU8AP5ErSoeUFu
         6VW1mcWvLcsHE0rOsy3cO+MkxEcYHalEGweVW7SNdFVzbtK9GNWotcx9p5mXNAVmHU0d
         4VGg==
X-Gm-Message-State: AO0yUKWQ4Tt0pVG7efZt/sSLSVDj1fY3pR/iUMSSIdcj9mWKDgP0+zlq
        NJgX1GArQDXRCoQH/lNrnUV4eg==
X-Google-Smtp-Source: AK7set8DtAIgce991bpJ51nCnfZYsOa3okIXdYADpriVE9RxYoxKWUHTjjKquyTj/2m7RtgRDvpzTg==
X-Received: by 2002:a17:90b:4b4a:b0:22b:fd93:7286 with SMTP id mi10-20020a17090b4b4a00b0022bfd937286mr3107411pjb.4.1677585233710;
        Tue, 28 Feb 2023 03:53:53 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:53 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 12/14] perf kvm: Add dimensions for percentages
Date:   Tue, 28 Feb 2023 19:51:23 +0800
Message-Id: <20230228115125.144172-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
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

Add dimensions for count and time percentages, it would useful for user
to review percentage statistics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c | 98 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a56d0983c585..5b1b2042dfed 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -230,10 +230,105 @@ static struct kvm_dimension dim_mean_time = {
 	.width		= 14,
 };
 
+#define PERC_STR(__s, __v)				\
+({							\
+	scnprintf(__s, sizeof(__s), "%.2F%%", __v);	\
+	__s;						\
+})
+
+static double percent(u64 st, u64 tot)
+{
+	return tot ? 100. * (double) st / (double) tot : 0;
+}
+
+#define EV_METRIC_PERCENT(metric)					\
+static int ev_percent_##metric(struct hist_entry *he)			\
+{									\
+	struct kvm_event *event;					\
+	struct perf_kvm_stat *perf_kvm;					\
+									\
+	event = container_of(he, struct kvm_event, he);			\
+	perf_kvm = event->perf_kvm;					\
+									\
+	return percent(get_event_##metric(event, perf_kvm->trace_vcpu),	\
+		       perf_kvm->total_##metric);			\
+}
+
+EV_METRIC_PERCENT(time)
+EV_METRIC_PERCENT(count)
+
+static int ev_entry_time_precent(struct perf_hpp_fmt *fmt,
+				 struct perf_hpp *hpp,
+				 struct hist_entry *he)
+{
+	int width = fmt_width(fmt, hpp, he->hists);
+	double per;
+	char buf[10];
+
+	per = ev_percent_time(he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int64_t
+ev_cmp_time_precent(struct perf_hpp_fmt *fmt __maybe_unused,
+		    struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = ev_percent_time(left);
+	per_right = ev_percent_time(right);
+
+	return per_left - per_right;
+}
+
+static struct kvm_dimension dim_time_percent = {
+	.header		= "Time%",
+	.name		= "percent_time",
+	.cmp		= ev_cmp_time_precent,
+	.entry		= ev_entry_time_precent,
+	.width		= 12,
+};
+
+static int ev_entry_count_precent(struct perf_hpp_fmt *fmt,
+				  struct perf_hpp *hpp,
+				  struct hist_entry *he)
+{
+	int width = fmt_width(fmt, hpp, he->hists);
+	double per;
+	char buf[10];
+
+	per = ev_percent_count(he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int64_t
+ev_cmp_count_precent(struct perf_hpp_fmt *fmt __maybe_unused,
+		     struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = ev_percent_count(left);
+	per_right = ev_percent_count(right);
+
+	return per_left - per_right;
+}
+
+static struct kvm_dimension dim_count_percent = {
+	.header		= "Sample%",
+	.name		= "percent_sample",
+	.cmp		= ev_cmp_count_precent,
+	.entry		= ev_entry_count_precent,
+	.width		= 12,
+};
+
 static struct kvm_dimension *dimensions[] = {
 	&dim_event,
 	&dim_time,
+	&dim_time_percent,
 	&dim_count,
+	&dim_count_percent,
 	&dim_max_time,
 	&dim_min_time,
 	&dim_mean_time,
@@ -406,7 +501,8 @@ static int kvm_hpp_list__parse(struct perf_hpp_list *hpp_list,
 
 static int kvm_hists__init(struct perf_kvm_stat *kvm)
 {
-	const char *output_columns = "name,sample,time,max_t,min_t,mean_t";
+	const char *output_columns = "name,sample,percent_sample,"
+				     "time,percent_time,max_t,min_t,mean_t";
 
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
-- 
2.34.1

