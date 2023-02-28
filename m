Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A076A549C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjB1In0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjB1Im4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8167B2BEE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:39 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n6so8246997plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkGLzxiRgSOZTh04Z+2xATChlICYHMpA+J8qmtvpz8Q=;
        b=bYI3H6niPj1M255ceIj/3IHT0DykJl98GQ7A36QcZs2gdOeEfQkaKxZvOUKc/1gD+/
         vGVrKLrWCiiOFG7cpM2geG31ZZPs2i5iz0371D/r7edsVv8fauTLbuLrOzr0CyFpxTMA
         ugl32UO2xsQXRT8oinTxA3rb/fi7Dv78tm5t4xuyas9lNJh9JRmNyW9vdHx3kk52DBmh
         xXRkyt9adtoMkYaTfAh1LE5OswQstVigdkrdWdSWTsdSvAcEZM9TCcCRZo94kz7xl+Fj
         UERgC0fkONR3ZrBdeCLMCiQov3rP+imEo4u8Ws6z5dDyy1Y6i65EAR9I4ESz9MPmb4do
         JyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkGLzxiRgSOZTh04Z+2xATChlICYHMpA+J8qmtvpz8Q=;
        b=2OqNJ55hRjLukNKFBPEmHazyQ8fgc166Y5BYsXg39NM9qnyBwM+W4kQ22Wz7bNzDW6
         btzqMDA0CtJHedG6pzC5/jTLJgXBcBksjAbsll4xu63XAPqZqBCUbpyJFMsTXeTNJGDb
         0gbhTxn/kZZ7f4xKsTScpT/g+dQsZIBhNjGmtKHHf5/H8uWGuDWQkKAxeRO2PIzHlIIt
         NxnXhrKynEUHmKh05lyC2SgECgVIIa/QjkQSn6AFc/zZWaxibQm3Vsy+ovtzG+/JpQzl
         IXCXhK6xZBcOQR751Lv+L5Ev72nhtFb5KgHN1QQl2GciPCsD5By8v0Kf7AMutw5SYnx4
         mKmQ==
X-Gm-Message-State: AO0yUKXYzXdLcUgKqcuVez5Y2gR9W5x+KYfwL//nAipENwprdleDdee/
        G4Ap117bR50ByqFZWmN8XavVog==
X-Google-Smtp-Source: AK7set/5FuyPzdlCVwH9WJzVClF6Rc53wNebBmKizFH8bU1NrcynmiL1WYW1fw1OalM52ISkFjFbpw==
X-Received: by 2002:a05:6a20:54a3:b0:cd:47dc:82b5 with SMTP id i35-20020a056a2054a300b000cd47dc82b5mr3142913pzk.21.1677573756612;
        Tue, 28 Feb 2023 00:42:36 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:36 -0800 (PST)
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
Subject: [PATCH v2 08/14] perf kvm: Add dimensions for KVM event statistics
Date:   Tue, 28 Feb 2023 16:41:41 +0800
Message-Id: <20230228084147.106167-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
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

To support KVM event statistics, this patch firstly registers histograms
columns and sorting fields; every column or field has its own format
structure, the format structure is dereferenced to access the dimension,
finally the dimension provides the comparison callback for sorting
result.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 239 +++++++++++++++++++++++++++++++++++--
 tools/perf/util/kvm-stat.h |   2 +
 2 files changed, 234 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a9f467926bdd..da84f5063d4d 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -70,9 +70,9 @@ static int cmp_event_ ## func(struct kvm_event *one,			\
 	       get_event_ ##func(two, vcpu);				\
 }
 
-GET_EVENT_KEY(time, time);
-GET_EVENT_KEY(max, stats.max);
-GET_EVENT_KEY(min, stats.min);
+COMPARE_EVENT_KEY(time, time);
+COMPARE_EVENT_KEY(max, stats.max);
+COMPARE_EVENT_KEY(min, stats.min);
 COMPARE_EVENT_KEY(count, stats.n);
 COMPARE_EVENT_KEY(mean, stats.mean);
 
@@ -90,13 +90,238 @@ struct kvm_hists {
 	struct perf_hpp_list	list;
 };
 
+struct kvm_dimension {
+	const char *name;
+	int64_t (*cmp)(struct perf_hpp_fmt *fmt, struct hist_entry *left,
+		       struct hist_entry *right);
+};
+
+struct kvm_fmt {
+	struct perf_hpp_fmt	fmt;
+	struct kvm_dimension	*dim;
+};
+
 static struct kvm_hists kvm_hists;
 
-static int kvm_hists__init(void)
+static int64_t
+empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+	  struct hist_entry *left __maybe_unused,
+	  struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
+static struct kvm_dimension dim_event = {
+	.name		= "name",
+	.cmp		= empty_cmp,
+};
+
+#define EV_METRIC_CMP(metric)						\
+static int64_t ev_cmp_##metric(struct perf_hpp_fmt *fmt __maybe_unused,	\
+			       struct hist_entry *left,			\
+			       struct hist_entry *right)		\
+{									\
+	struct kvm_event *event_left;					\
+	struct kvm_event *event_right;					\
+	struct perf_kvm_stat *perf_kvm;					\
+									\
+	event_left  = container_of(left, struct kvm_event, he);		\
+	event_right = container_of(right, struct kvm_event, he);	\
+									\
+	perf_kvm = event_left->perf_kvm;				\
+	return cmp_event_##metric(event_left, event_right,		\
+				  perf_kvm->trace_vcpu);		\
+}
+
+EV_METRIC_CMP(time)
+EV_METRIC_CMP(count)
+EV_METRIC_CMP(max)
+EV_METRIC_CMP(min)
+EV_METRIC_CMP(mean)
+
+static struct kvm_dimension dim_time = {
+	.name		= "time",
+	.cmp		= ev_cmp_time,
+};
+
+static struct kvm_dimension dim_count = {
+	.name		= "sample",
+	.cmp		= ev_cmp_count,
+};
+
+static struct kvm_dimension dim_max_time = {
+	.name		= "max_t",
+	.cmp		= ev_cmp_max,
+};
+
+static struct kvm_dimension dim_min_time = {
+	.name		= "min_t",
+	.cmp		= ev_cmp_min,
+};
+
+static struct kvm_dimension dim_mean_time = {
+	.name		= "mean_t",
+	.cmp		= ev_cmp_mean,
+};
+
+static struct kvm_dimension *dimensions[] = {
+	&dim_event,
+	&dim_time,
+	&dim_count,
+	&dim_max_time,
+	&dim_min_time,
+	&dim_mean_time,
+	NULL,
+};
+
+static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+{
+	struct kvm_fmt *kvm_fmt_a = container_of(a, struct kvm_fmt, fmt);
+	struct kvm_fmt *kvm_fmt_b = container_of(b, struct kvm_fmt, fmt);
+
+	return kvm_fmt_a->dim == kvm_fmt_b->dim;
+}
+
+static void fmt_free(struct perf_hpp_fmt *fmt)
+{
+	struct kvm_fmt *kvm_fmt;
+
+	kvm_fmt = container_of(fmt, struct kvm_fmt, fmt);
+	free(kvm_fmt);
+}
+
+static struct kvm_dimension *get_dimension(const char *name)
 {
+	unsigned int i;
+
+	for (i = 0; dimensions[i] != NULL; i++) {
+		if (!strcmp(dimensions[i]->name, name))
+			return dimensions[i];
+	}
+
+	return NULL;
+}
+
+static struct kvm_fmt *get_format(const char *name)
+{
+	struct kvm_dimension *dim = get_dimension(name);
+	struct kvm_fmt *kvm_fmt;
+	struct perf_hpp_fmt *fmt;
+
+	if (!dim)
+		return NULL;
+
+	kvm_fmt = zalloc(sizeof(*kvm_fmt));
+	if (!kvm_fmt)
+		return NULL;
+
+	kvm_fmt->dim = dim;
+
+	fmt = &kvm_fmt->fmt;
+	INIT_LIST_HEAD(&fmt->list);
+	INIT_LIST_HEAD(&fmt->sort_list);
+	fmt->cmp	= dim->cmp;
+	fmt->sort	= dim->cmp;
+	fmt->color	= NULL;
+	fmt->entry	= NULL;
+	fmt->header	= NULL;
+	fmt->width	= NULL;
+	fmt->collapse	= dim->cmp;
+	fmt->equal	= fmt_equal;
+	fmt->free	= fmt_free;
+
+	return kvm_fmt;
+}
+
+static int kvm_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
+{
+	struct kvm_fmt *kvm_fmt = get_format(name);
+
+	if (!kvm_fmt) {
+		reset_dimensions();
+		return output_field_add(hpp_list, name);
+	}
+
+	perf_hpp_list__column_register(hpp_list, &kvm_fmt->fmt);
+	return 0;
+}
+
+static int kvm_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
+{
+	struct kvm_fmt *kvm_fmt = get_format(name);
+
+	if (!kvm_fmt) {
+		reset_dimensions();
+		return sort_dimension__add(hpp_list, name, NULL, 0);
+	}
+
+	perf_hpp_list__register_sort_field(hpp_list, &kvm_fmt->fmt);
+	return 0;
+}
+
+static int kvm_hpp_list__init(char *list,
+			      struct perf_hpp_list *hpp_list,
+			      int (*fn)(struct perf_hpp_list *hpp_list,
+					char *name))
+{
+	char *tmp, *tok;
+	int ret;
+
+	if (!list || !fn)
+		return 0;
+
+	for (tok = strtok_r(list, ", ", &tmp); tok;
+	     tok = strtok_r(NULL, ", ", &tmp)) {
+		ret = fn(hpp_list, tok);
+		if (!ret)
+			continue;
+
+		/* Handle errors */
+		if (ret == -EINVAL)
+			pr_err("Invalid field key: '%s'", tok);
+		else if (ret == -ESRCH)
+			pr_err("Unknown field key: '%s'", tok);
+		else
+			pr_err("Fail to initialize for field key: '%s'", tok);
+
+		break;
+	}
+
+	return ret;
+}
+
+static int kvm_hpp_list__parse(struct perf_hpp_list *hpp_list,
+			       const char *output_, const char *sort_)
+{
+	char *output = output_ ? strdup(output_) : NULL;
+	char *sort = sort_ ? strdup(sort_) : NULL;
+	int ret;
+
+	ret = kvm_hpp_list__init(output, hpp_list, kvm_hists__init_output);
+	if (ret)
+		goto out;
+
+	ret = kvm_hpp_list__init(sort, hpp_list, kvm_hists__init_sort);
+	if (ret)
+		goto out;
+
+	/* Copy sort keys to output fields */
+	perf_hpp__setup_output_field(hpp_list);
+
+out:
+	free(output);
+	free(sort);
+	return ret;
+}
+
+static int kvm_hists__init(struct perf_kvm_stat *kvm)
+{
+	const char *output_columns = "name,sample,time,max_t,min_t,mean_t";
+
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
-	return 0;
+	return kvm_hpp_list__parse(&kvm_hists.list, output_columns,
+				   kvm->sort_key);
 }
 
 static const char *get_filename_for_perf_kvm(void)
@@ -979,7 +1204,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	set_term_quiet_input(&save);
 	init_kvm_event_record(kvm);
 
-	kvm_hists__init();
+	kvm_hists__init(kvm);
 
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
@@ -1176,7 +1401,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	init_kvm_event_record(kvm);
 	setup_pager();
 
-	kvm_hists__init();
+	kvm_hists__init(kvm);
 
 	ret = read_events(kvm);
 	if (ret)
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 80d5c5a9ae31..ca5796959f66 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -40,6 +40,8 @@ struct kvm_event {
 	#define DEFAULT_VCPU_NUM 8
 	int max_vcpu;
 	struct kvm_event_stats *vcpu;
+
+	struct hist_entry he;
 };
 
 typedef int (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
-- 
2.34.1

