Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A596BB698
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjCOOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjCOOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:53:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E22974BF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id rj10so8519450pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXjE1lNyQ6Ulq2wrJYSF6aHLvPPQtJdwrD75rVojf8A=;
        b=BCoP6UXH2x8VV6ZsOW13Ae9hQ4T2I9/6OiiOOf26BOC3ZUWn3FhlVxYrwF0uGT2820
         Z89j0GTbYPZbd2m0FTGAmQ3aeVDmEJtZzF1e/zHOZHQEwvVoNGq/xuYbvVwuqdT9d1ZE
         SMzXSpKbDY/rFapSOecLZBq8+zwdrzi6TujVS4OhT+wrSE/zUcm1EjBldfw1Mq+JajgA
         BwHIdRwEWuAS/5nOs4hcd4JPjVlkula1o2YjLf8HFYGm+SX7NX03Ph2xIXtoPM/cMhIv
         H8Lrwb4ru/Wj3svRHVKnevbHu7BtAfzHGDj+o4Dms7Ia98uaFLE1ZLCxRbiXzLeDdOr0
         sfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXjE1lNyQ6Ulq2wrJYSF6aHLvPPQtJdwrD75rVojf8A=;
        b=ASKfImd6hRszgqQUOIQfJ9aCR0X5z8Y09eSKEDM1G6l6RWjkZ/8xZS0OHOENYNNRXr
         09Nwv5ksYcR4QeDTMKE/38OvUdM9eqyCJL9W5jqTIfAYq+VpKTLCVJ1gHRYQAfDvIAuT
         2j7RT89l1lHL98sUi5PLFQZcQNdPGdaOWFpiEzFIssULUumzJe++wA2pANiJ6QQB98fs
         gLSB5VOHe5D9dDsIBONISwTKjHlyn7/Rpo2QIVXtOo1i7dUk1owI+o5JVEwAdQL4I+DM
         eGK8eMs5O7sgVuR2Y2vO9x5z/DrjRcVwYrLnIaUAASB42Nj+uhubL9Qjfr/EBYL97z+6
         QwyA==
X-Gm-Message-State: AO0yUKUqw9MUxCaAmZn5a2vzpU32fChwfVTSgOGMQL9tvjr3PwEQunjc
        UQQW1gzF53xynr4kqgoEQ+Zxo1grGN7Uwtd3Mt8vaXVx
X-Google-Smtp-Source: AK7set/x2sbhiI0KJMwBONL5ZF5YA0yPzV1seKM6HmyYEhYd4ut50lJhZLlgYJcc5Kcg6TFT3KxMtg==
X-Received: by 2002:a17:902:f54e:b0:1a0:76d1:545c with SMTP id h14-20020a170902f54e00b001a076d1545cmr2950647plf.10.1678891958787;
        Wed, 15 Mar 2023 07:52:38 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:38 -0700 (PDT)
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
Subject: [PATCH v5 12/16] perf kvm: Polish sorting key
Date:   Wed, 15 Mar 2023 22:51:08 +0800
Message-Id: <20230315145112.186603-13-leo.yan@linaro.org>
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

Since histograms supports sorting, the tool doesn't need to maintain the
mapping between the sorting keys and the corresponding comparison
callbacks, therefore, this patch removes structure kvm_event_key.

But we still need to validate the sorting key, this patch uses an array
for sorting keys and renames function select_key() to is_valid_key()
to validate the sorting key passed by user.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 29 ++++++++++-------------------
 tools/perf/util/kvm-stat.h |  8 --------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ba3134613bcb..1e9338855239 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -76,15 +76,6 @@ COMPARE_EVENT_KEY(min, stats.min);
 COMPARE_EVENT_KEY(count, stats.n);
 COMPARE_EVENT_KEY(mean, stats.mean);
 
-#define DEF_SORT_NAME_KEY(name, compare_key)				\
-	{ #name, cmp_event_ ## compare_key }
-
-static struct kvm_event_key keys[] = {
-	DEF_SORT_NAME_KEY(sample, count),
-	DEF_SORT_NAME_KEY(time, mean),
-	{ NULL, NULL }
-};
-
 struct kvm_hists {
 	struct hists		hists;
 	struct perf_hpp_list	list;
@@ -757,18 +748,18 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-static bool select_key(struct perf_kvm_stat *kvm)
+static bool is_valid_key(struct perf_kvm_stat *kvm)
 {
-	int i;
+	static const char *key_array[] = {
+		"ev_name", "sample", "time", "max_t", "min_t", "mean_t",
+	};
+	unsigned int i;
 
-	for (i = 0; keys[i].name; i++) {
-		if (!strcmp(keys[i].name, kvm->sort_key)) {
-			kvm->compare = keys[i].key;
+	for (i = 0; i < ARRAY_SIZE(key_array); i++)
+		if (!strcmp(key_array[i], kvm->sort_key))
 			return true;
-		}
-	}
 
-	pr_err("Unknown compare key:%s\n", kvm->sort_key);
+	pr_err("Unsupported sort key: %s\n", kvm->sort_key);
 	return false;
 }
 
@@ -1198,7 +1189,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		return ret;
 
 	if (!verify_vcpu(kvm->trace_vcpu) ||
-	    !select_key(kvm) ||
+	    !is_valid_key(kvm) ||
 	    !register_kvm_events_ops(kvm)) {
 		goto out;
 	}
@@ -1393,7 +1384,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!verify_vcpu(vcpu))
 		goto exit;
 
-	if (!select_key(kvm))
+	if (!is_valid_key(kvm))
 		goto exit;
 
 	if (!register_kvm_events_ops(kvm))
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 3f0cbecb862c..35d03894fac3 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -49,13 +49,6 @@ struct kvm_event {
 	struct hist_entry he;
 };
 
-typedef int64_t (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
-
-struct kvm_event_key {
-	const char *name;
-	key_cmp_fun key;
-};
-
 struct child_event_ops {
 	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
@@ -98,7 +91,6 @@ struct perf_kvm_stat {
 	const char *exit_reasons_isa;
 
 	struct kvm_events_ops *events_ops;
-	key_cmp_fun compare;
 
 	u64 total_time;
 	u64 total_count;
-- 
2.34.1

