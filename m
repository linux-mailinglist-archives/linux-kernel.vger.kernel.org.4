Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF96BB696
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjCOOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjCOOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:52:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4987A01
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2282827pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVnvf3zk72qzgXgdIPbzoctQ9SQ7bt/Ml2Z1pGndq/0=;
        b=h9lHKPyNbnYbq3F6NSGv0JQNKcWgzxoUGZioCn02L8zidZZGjbjzFE2KyTr2FWd4iO
         W3gUzXZlNcyraP+QiNBGGADuv/Ib/+MvWL77YVrvJgx8zXkTXIzSOt4AcjMsLBYHJua1
         RKBQ7HZrX6eHG4zbh3neC2IMvVXzrMuOV/rIg/xJG26nQPeFQfW9OMhRQAXoJdtgRgVa
         dJ8uWYLp9PzoJ5K7FNBMekCKj5uff/77qY9pv3Nm9TbjD/X5gcwKULbJilcoiY85q/tT
         pNZX2Dp37+qdq0Rggr0+QoC4crqurSdnN1wARdFMCs8fD8eJLRmnJ7gbEQ7ceVIOcnbj
         y07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVnvf3zk72qzgXgdIPbzoctQ9SQ7bt/Ml2Z1pGndq/0=;
        b=dMKGK2/JQdfi8wEyARVIHpjurjuBf/PYz2av+EzKJ5OXLQrng1lBgw0m2XNkuL25AD
         amAu6aoS3LfETOxCquqqU7glRO8U8U3tOy3tAzN7W3hjJJ3TjSUe9IKhGdTJaWVEuKNk
         xhwruxt6upXM/mv5W8YGIAyQpbNuo4NQbqUUgONVgkm9baPjlEKH940kzTZMPAVCHeRf
         JHD1dPFGPllueSJ9dU2toELOitsBKXysg4D6XzNQZVKdWe/gJkzDIUtPWyL/MATya52z
         0477y8RKufuSEum/W8gglWifRSnBm5SUoevbhUIYLKKmSgs+VSBtqAeP49ihUafqUqL+
         Ueuw==
X-Gm-Message-State: AO0yUKUlgywWVBCrr0o+oZloHu7BppLX8839tWkLBh/n5Xim1B6nnrne
        VjH1cq8JSeXxcrML8URWhlD+kA==
X-Google-Smtp-Source: AK7set+r3FQC59prCXVymFb4gV98LN3zPEPCcwLVumwG0uMonMH8J/HeeF0K6uziPkWIrIXYO+fYrQ==
X-Received: by 2002:a17:902:c70b:b0:19d:abd:bb7e with SMTP id p11-20020a170902c70b00b0019d0abdbb7emr2195040plp.34.1678891947352;
        Wed, 15 Mar 2023 07:52:27 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:27 -0700 (PDT)
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
Subject: [PATCH v5 10/16] perf kvm: Add dimensions for KVM event statistics
Date:   Wed, 15 Mar 2023 22:51:06 +0800
Message-Id: <20230315145112.186603-11-leo.yan@linaro.org>
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

To support KVM event statistics, this patch firstly registers histograms
columns and sorting fields; every column or field has its own format
structure, the format structure is dereferenced to access the dimension,
finally the dimension provides the comparison callback for sorting
result.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 232 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/kvm-stat.h |   2 +
 2 files changed, 230 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index fa91c8deb628..3f601ccb7aab 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -70,9 +70,9 @@ static int64_t cmp_event_ ## func(struct kvm_event *one,		\
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
 
@@ -90,13 +90,237 @@ struct kvm_hists {
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
 
+static int64_t ev_name_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			   struct hist_entry *left,
+			   struct hist_entry *right)
+{
+	/* Return opposite number for sorting in alphabetical order */
+	return -strcmp(left->kvm_info->name, right->kvm_info->name);
+}
+
+static struct kvm_dimension dim_event = {
+	.name		= "ev_name",
+	.cmp		= ev_name_cmp,
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
+{
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
+		pr_warning("Fail to find format for output field %s.\n", name);
+		return -EINVAL;
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
+		pr_warning("Fail to find format for sorting %s.\n", name);
+		return -EINVAL;
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
+	/* and then copy output fields to sort keys */
+	perf_hpp__append_sort_keys(hpp_list);
+out:
+	free(output);
+	free(sort);
+	return ret;
+}
+
 static int kvm_hists__init(void)
 {
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
-	return 0;
+	return kvm_hpp_list__parse(&kvm_hists.list, NULL, "ev_name");
 }
 
 static const char *get_filename_for_perf_kvm(void)
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 0cf704333c4c..fc30a72dfac1 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -46,6 +46,8 @@ struct kvm_event {
 	#define DEFAULT_VCPU_NUM 8
 	int max_vcpu;
 	struct kvm_event_stats *vcpu;
+
+	struct hist_entry he;
 };
 
 typedef int64_t (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
-- 
2.34.1

