Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13776A2E26
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBZEWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBZEWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:22:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D54C15C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso6822608pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjL18aIBPgYfHqrjofZNutkN8+DYauLGt6A7ZGJ8B24=;
        b=iAaSKRQm+FOLvfH3xW+UZRCqNcZ9ZcCC8SZ8qSTMKlHcTHAaMlDYLbjYMQI4Dyye3X
         G9cxLmKM1zzFzw051kf7KT3cbqPkYAW39t5Bb/f7RPOkTK/yftpgxGJO7tq6x/dUiDM3
         5R5iKeqB1r2qOmmRBeGqRkI7hqDrAUDBLyMouI9ej3wvbtCIWcVCGSbzNigTtvia0Veb
         Hq80ibcu4nd7uYc87D7L1JNs8iLnu2HGojw2ntSiYl6G6TjWPE8HCigkivvT1+FHcZGi
         pPi5sttWl7Ly0A6bv3y09aAHyqcwMdKJAM7PYIjgATI/fbeDL8jmffXEIcUylSFpGHxg
         /V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjL18aIBPgYfHqrjofZNutkN8+DYauLGt6A7ZGJ8B24=;
        b=XaB+Iwd4nXQpLqJiJLDK8BegYS5yYposqemhMgmGS18olWC25K7NkQTFrdY5Dhr902
         z1Mm+yIzENtzRH75kAVzzeWFOT1ED77AinYC/S9/8+TQPOiE8hDh2hVMpcZHTcq/sqqr
         y8MawMiY4Uirfmw/Dhg9HU/9UvT2Z9OexMtaAQeSRkVxnnSMFUMVv4NGzjDwX6cM2XDw
         vimJh2t9+SUocScotAZE/bdT+9DMqtCqaXrUKMUxAJC//LrjX/TU4asVcVlppzRbrO1m
         jQTpynOQjXD7wB2w/2uSvH2HWd1WWxcV/eHwt1N05/K+labTWhTxV3J4WxWI8ReUiBbo
         zGug==
X-Gm-Message-State: AO0yUKUFoCY6/hiSTqA4VKCJHGwHmzA03RJktIED7V5qbt5bgGARm1gj
        lBlUB4TrXuiFuEedxXqG1FJ1lg==
X-Google-Smtp-Source: AK7set+zoFK1SCKVui96RRRLxSG0gaoeA6zB+Fc0bS/v6wmVQjR7GUCqIPAc9QYpF/28rlrpRfkY2Q==
X-Received: by 2002:a17:902:dac6:b0:19b:c491:21be with SMTP id q6-20020a170902dac600b0019bc49121bemr24672072plx.64.1677385304682;
        Sat, 25 Feb 2023 20:21:44 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:44 -0800 (PST)
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
Subject: [PATCH v1 10/14] perf kvm: Polish sorting key
Date:   Sun, 26 Feb 2023 12:20:49 +0800
Message-Id: <20230226042053.1492409-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
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

