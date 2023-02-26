Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5466A2E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBZEVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBZEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89155BDFD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:10 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so1843504pla.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6XdpHkz8A8bOxvOk1eGAORWD0fU8Q/VwNFknF3nlZE=;
        b=oFoLR3FiLT+h5TvDFl1GMv2yCpurUwpbMglbpeM+aHbUkBo57SGlAj4ysITb90pRAD
         RJ3V9S1eBxSMEfVi/I8ve+chS48IInvz4zhBCxbkjhk8ePeevlcGnhvHL7H2qkgvfGn6
         QOp+r2aLbM3gavUNPxXcV0yFWFpzC7632yZ5mcjdf4XgPapjcE/kFIO/pAFNYVQ/q+Fo
         qO6r1ooid1B+V8U0sm33s/nYeARnc+J2yWtxGa/ydAXudiqdHBjSN8Juwj5OohtDRMOU
         l47QGgZktZHueXcz4NmSS7ZJCan5UhNlTweSj1pBbKPuMRG9sYhGQlRL8ULigehujOwK
         sUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6XdpHkz8A8bOxvOk1eGAORWD0fU8Q/VwNFknF3nlZE=;
        b=ugFOOF2zHq86tAw7q6jYfF6hFMZNiyyoYA8klBKMOs9jwG38Jp6lSPsAuu1Gaz9UgC
         6L/cN9L3GWLeM3GSrd5fGglxbishniRJgbz9NOvhOHPteMKmMgG3urRVDVT4JYMUYDYx
         Ur4wJgxwCUfO5hquULmnCsmHYnr9e/MR37aEiGbhHzi+91aOIy5/fP055fJLdULXRZnl
         RKSSoIO8JZzYge+n6TXhJ/QxjCsxP8rJTKqqe/UCfjDesOcwgnuFgS/z0cSW6yv4Uzir
         hJ1dIaykc1Fdx2hvfnlB93ktbGwYJyp1NKi8W9HFdYQc6Il5kx3/3cdUZqRaLhK16lWO
         YqLQ==
X-Gm-Message-State: AO0yUKU8T1tuxtnkfkaGWchHivjZ5dhZWhX5u2JRJ52NIONtbO44ujTV
        zoo2rVbKXUOr0y8DK1jC6HP91Q==
X-Google-Smtp-Source: AK7set8d6gnX4LOmAYlzfD6ivuYo2gNNIR2DBnedvHEhU0G6tEEigiU79oAzkXZ6JvBQnI3lBRKSQQ==
X-Received: by 2002:a17:902:f903:b0:19d:7a4:4073 with SMTP id kw3-20020a170902f90300b0019d07a44073mr259328plb.59.1677385269877;
        Sat, 25 Feb 2023 20:21:09 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:09 -0800 (PST)
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
Subject: [PATCH v1 01/14] perf kvm: Refactor overall statistics
Date:   Sun, 26 Feb 2023 12:20:40 +0800
Message-Id: <20230226042053.1492409-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
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

Currently the tool computes overall statistics when sort the results.
This patch refactors overall statistics during events processing,
therefore, the function update_total_coun() is not needed anymore, an
extra benefit is we can de-couple code between the statistics and the
sorting.

This patch is not expected any functionality changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 641e739c717c..0172e5b0d26e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -278,9 +278,14 @@ static double kvm_event_rel_stddev(int vcpu_id, struct kvm_event *event)
 				avg_stats(&kvm_stats->stats));
 }
 
-static bool update_kvm_event(struct kvm_event *event, int vcpu_id,
+static bool update_kvm_event(struct perf_kvm_stat *kvm,
+			     struct kvm_event *event, int vcpu_id,
 			     u64 time_diff)
 {
+	/* Update overall statistics */
+	kvm->total_count++;
+	kvm->total_time += time_diff;
+
 	if (vcpu_id == -1) {
 		kvm_update_event_stats(&event->total, time_diff);
 		return true;
@@ -399,7 +404,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 		}
 	}
 
-	return update_kvm_event(event, vcpu, time_diff);
+	return update_kvm_event(kvm, event, vcpu, time_diff);
 }
 
 static
@@ -526,15 +531,6 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
 	rb_insert_color(&event->rb, result);
 }
 
-static void
-update_total_count(struct perf_kvm_stat *kvm, struct kvm_event *event)
-{
-	int vcpu = kvm->trace_vcpu;
-
-	kvm->total_count += get_event_count(event, vcpu);
-	kvm->total_time += get_event_time(event, vcpu);
-}
-
 static bool event_is_valid(struct kvm_event *event, int vcpu)
 {
 	return !!get_event_count(event, vcpu);
@@ -549,7 +545,6 @@ static void sort_result(struct perf_kvm_stat *kvm)
 	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
 		list_for_each_entry(event, &kvm->kvm_events_cache[i], hash_entry) {
 			if (event_is_valid(event, vcpu)) {
-				update_total_count(kvm, event);
 				insert_to_result(&kvm->result, event,
 						 kvm->compare, vcpu);
 			}
-- 
2.34.1

