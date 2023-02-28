Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376DE6A58A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjB1Lyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjB1LyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:54:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0921954
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so6585592plz.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVA/SliggfFjyn1LtlyRDRM3jLle/ZCLsZr9XDCOvr4=;
        b=cwaSdMK2MosBJmFPQ/Yz+X8w6vJQFeqlpKXTuMEkpAbwdsXVZsA7aI9Bhr6MdaA7ik
         hHlobYafFhEA+RyhWqM+V4zoFeZKGAT2UcQ09SiYl/FlQSx6mKbybsaZdSig9uwdcJpM
         7MPEggnnLXmeXb0lcSRAIOgGmlfHkhHadZPHKyUn+oYbvGWQ3eY4nfAcX476IOkhZRbY
         ofIKbDfUSF5Cf0j8RvOWoqwVVr0d49FzCSl2X8AEfhXlyxy5rGI5SqdR1/iTpPJUkNB6
         ogH+kBsvzFOTzngsOyan8MTDivDFF12j/5HSIIzLGpBqT+tk68Ibg/ZzZ+58gujFILMR
         lBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVA/SliggfFjyn1LtlyRDRM3jLle/ZCLsZr9XDCOvr4=;
        b=geJYv3JDmOITPbQzb/h2e6A/v87RPvt8yhKRwVRDllsfHuAVF71LfqKzdPGfSk7c1I
         Wz8QCU5UXshdMOcHRjWP8YJkvMDparN2AIxTGdBoeb61OpsKOZn364mPu8hRnH1wvv3g
         XRCKraZvzFBAQqHAgB5cEz5wQCNXQHWt5Q6XVHGlI7G9CWio6N8JEQ/vyM2+SXI032DQ
         U4aGiyLU59RkM70ZdV6BNTRgjd6RUFIEJuc6q694guvguGj/oy3XbKLmLo4g9P4W1kwE
         J65wqU7gmwTH3rsNOuYYzZo3bJIr2o/JCjIkJAkS2ETVMgByCS6eH+4q5OSR52H4tugc
         bd4g==
X-Gm-Message-State: AO0yUKXESw5TWG8xfADlIYwynS7AMoBYXM0vujZ6syX2jN6daETxOYxE
        Cn0Egr0kgFKZ37KawPBL1GfNGQ==
X-Google-Smtp-Source: AK7set8h4tOy6A4rKkBURR6cbLmv7aSoNCG38/0VHxDX58D/uxKiVvPifngHERVeFiT0t8a3gvMnBA==
X-Received: by 2002:a17:90a:345:b0:236:75d3:fedc with SMTP id 5-20020a17090a034500b0023675d3fedcmr3063340pjf.8.1677585223568;
        Tue, 28 Feb 2023 03:53:43 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:43 -0800 (PST)
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
Subject: [PATCH v3 10/14] perf kvm: Polish sorting key
Date:   Tue, 28 Feb 2023 19:51:21 +0800
Message-Id: <20230228115125.144172-11-leo.yan@linaro.org>
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

Since histograms supports sorting, the tool doesn't need to maintain the
mapping between the sorting keys and the corresponding comparison
callbacks, therefore, this patch removes structure kvm_event_key.

But we still need to validate the sorting key, this patch uses an array
for sorting keys and renames function select_key() to is_valid_key()
to validate the sorting key passed by user.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 27 +++++++++------------------
 tools/perf/util/kvm-stat.h |  8 --------
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 32dc697ff707..741ba65bf092 100644
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
@@ -766,18 +757,18 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-static bool select_key(struct perf_kvm_stat *kvm)
+static bool is_valid_key(struct perf_kvm_stat *kvm)
 {
+	const char *key_array[] = {
+		"sample", "time", "max_t", "min_t", "mean_t",
+	};
 	int i;
 
-	for (i = 0; keys[i].name; i++) {
-		if (!strcmp(keys[i].name, kvm->sort_key)) {
-			kvm->compare = keys[i].key;
+	for (i = 0; ARRAY_SIZE(key_array); i++)
+		if (!strcmp(key_array[i], kvm->sort_key))
 			return true;
-		}
-	}
 
-	pr_err("Unknown compare key:%s\n", kvm->sort_key);
+	pr_err("Unsupported key: %s\n", kvm->sort_key);
 	return false;
 }
 
@@ -1201,7 +1192,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		return ret;
 
 	if (!verify_vcpu(kvm->trace_vcpu) ||
-	    !select_key(kvm) ||
+	    !is_valid_key(kvm) ||
 	    !register_kvm_events_ops(kvm)) {
 		goto out;
 	}
@@ -1395,7 +1386,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!verify_vcpu(vcpu))
 		goto exit;
 
-	if (!select_key(kvm))
+	if (!is_valid_key(kvm))
 		goto exit;
 
 	if (!register_kvm_events_ops(kvm))
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index c38d320c7cbe..a8e919ca59f4 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -43,13 +43,6 @@ struct kvm_event {
 	struct hist_entry he;
 };
 
-typedef int (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
-
-struct kvm_event_key {
-	const char *name;
-	key_cmp_fun key;
-};
-
 struct child_event_ops {
 	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
@@ -92,7 +85,6 @@ struct perf_kvm_stat {
 	const char *exit_reasons_isa;
 
 	struct kvm_events_ops *events_ops;
-	key_cmp_fun compare;
 
 	u64 total_time;
 	u64 total_count;
-- 
2.34.1

