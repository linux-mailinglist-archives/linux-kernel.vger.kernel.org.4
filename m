Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BCB6A54A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjB1In4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjB1InQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:43:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF32D49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:54 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q23so5153122pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NEkdhqDMouB1zUi5eCnhcHJNUH+bFnGQLi//L7nojk=;
        b=kcEEzMreNl5FMq37xbdP6dRx4NwX0NDL58nbB1jomIOINWboKLHQkKTqlslCT1PKlo
         2FFWmbcq25EQ3syarFxQv7IaNshtqYLMOUaw5NIXbMOwwW9EtX/Xe7U2i09irAcpTBRU
         hx+lNzaMHrzdM9q6fPMbgX3RARRzthBFnlD6EHQwMzGqLyVLZZ4xTbobNVvNBO4TBicm
         AjHd3b+sO4BKrlxoTj2TqlDQEwIATeF6HIy91NdFJHiPWHg6iVfEdWX9D0HTwkE/smRr
         pJm++pf+UorDUGzrQpiJMg4KECv6apmPUQLPmQMdngvsvrWNIT+mBaz68FzTJtGbCt15
         JmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NEkdhqDMouB1zUi5eCnhcHJNUH+bFnGQLi//L7nojk=;
        b=uBvsiI4TPFQxPZoKi7qF5i2zQaxIVNiM5HW1p3kTh1GBJkadkgxWABtHi/Ll/EpdiH
         Kppm/xKX2bbUz/u+VNlF6/ePJ8nMKB2vDmTG42f1nFLA1q2TIlbv5TbM2HgtUxbKbDAu
         qhpiTPLTNmT6rZMV/Yc5z3O0KHaOEn4PnUG79M+s3W7+OpWC5cf+qLG8z8KvQSsKUTQ3
         L7bMuRITGKR7XGPcy7wkOez92Xq2sAUscYASo/g2gh9fyJyE+Bg7kNI5WsFQP3k7vQye
         UNF5YI9huypBTwM3oejTQ/kRYcc4MLq9FWib49mdMTKyNOPETZJNRulSuMAwm7uKhVt9
         n+tQ==
X-Gm-Message-State: AO0yUKXrByhaaBlpFGhiYlL2kAqLwUPS2TbaKwzhlsF1/ZSYVM4EV2aH
        M7/e74fqQF1fnx5lUqMMX2N7D1IH0Ni0rUCRr9E=
X-Google-Smtp-Source: AK7set/mr+InGhXG/QfaNvdNf6pAsaSnQCzdQB0XMxb8WqE7V6YlHo1I2iTS5O2hKkBpmg2m8befAw==
X-Received: by 2002:a62:5214:0:b0:5e5:a473:9498 with SMTP id g20-20020a625214000000b005e5a4739498mr1749717pfb.27.1677573771970;
        Tue, 28 Feb 2023 00:42:51 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:51 -0800 (PST)
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
Subject: [PATCH v2 12/14] perf kvm: Add dimensions for percentages
Date:   Tue, 28 Feb 2023 16:41:45 +0800
Message-Id: <20230228084147.106167-13-leo.yan@linaro.org>
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

Add dimensions for count and time percentages, it would useful for user
to review percentage statistics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

