Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91246A549E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjB1Inr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjB1InH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:43:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16D2B2AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a7so5181156pfx.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjL18aIBPgYfHqrjofZNutkN8+DYauLGt6A7ZGJ8B24=;
        b=R7n+tvnkno2FYxYX3IUx7j3vvWvMtUuuapv0NKmYlu3yZjFjX/5C6/LyuT0LTuUdns
         DY3nDRyac832UHNLvQISEgrD4151zxnCMptuaLtHNdNh59pfo1j1rza4k1LoiPxtA9Wu
         wyHeIZgVDsKuLScYJFS03xJLHlZ6eNyTjn/dgHwvulh8ye7XJXcCjPp16UDWV0edkmFv
         YTeEeQKWc2J/aMUr6PRonHF04Scm6rTAeHr8mHfQWP0XFvMuJ8E389sKJj+aoRce+mYb
         eInH34QcOaIdIN2PWDewKbQEH6qE8VuvC3IjoLYsTyOhpnMO7rsoa597L076WyQF3vVZ
         lzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjL18aIBPgYfHqrjofZNutkN8+DYauLGt6A7ZGJ8B24=;
        b=BLFPpKlh2IGAjpdtbalMr75UazreGPescpAEXJ/23XcdHPmNv1E1SYNSObS6jVSU0t
         T7T9SRbaHoWlkFXvz8moJlcviuShvC1RvdIibHhCl1Izy8CXl7FMUau9CpUog5fJX8xu
         o88o/2RN4GuSNEtG+Fu5qJUdcbwsaM0IlAgisaia8btchR7yEwYeUI1GtbCvmDyvmVDR
         x2kRMMQttMu+b+qzGBu0Ud0peXC5aTfCdNpIkidYxWEK9FTwth6OTy6U/WY/S6SFN+R+
         7E+55dMWgcLw6/ZZr4+8pFj7GRYKmoKh7Qqil6YA4E0qgAsGJqX5xxZOnizUYVu8WeJ4
         ssBw==
X-Gm-Message-State: AO0yUKVRVbyBBjLdfS6iOTEM8Cr43Cnaa4Ey578JzJh1Fw0geBuLm7m7
        ghFA9SfFkxS/VKDYAthIyhivag==
X-Google-Smtp-Source: AK7set+8S/+rOVRikEOYR1B+03WN24sCAuRM5Dbx9Z7KZB8NYY4ehla2JBwO/GaD/BoCrAZnhnVxIQ==
X-Received: by 2002:aa7:9acc:0:b0:600:cc40:258c with SMTP id x12-20020aa79acc000000b00600cc40258cmr1689839pfp.10.1677573764099;
        Tue, 28 Feb 2023 00:42:44 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:43 -0800 (PST)
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
Subject: [PATCH v2 10/14] perf kvm: Polish sorting key
Date:   Tue, 28 Feb 2023 16:41:43 +0800
Message-Id: <20230228084147.106167-11-leo.yan@linaro.org>
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

