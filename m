Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA96B7628
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCMLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCMLkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:40:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96536485B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:40:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13so1651399pjh.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfFwm9/whD1jR/5n6DKKR8V6Fa945UAISwsDPx5HLJU=;
        b=UKMSaTwrX/iAEgtNVLYK1CXWlwTqjnwE629XOSX71tKhB6T3cAOlOXRTt3LvlrWi5X
         FqlTeRl98HKQVTHqKqa29/tAnEmIxP09oGP9/8q3Gu/uMR3E1dnVkTr0nDcF/SOpIkoP
         K1tgzxVrbtc398A2UEIShZ3XaBB3OyZkCx12EVsY2GMx99hts27vPZWdKGe1VXBA+1u6
         DikXAAaaBuGfS5cSKOLPHhi/GvbKi1EyuN0dErkJI4ai+P/eewM/XyDHcbX41FIesMjC
         bUSF2i+E4x58EQP94dSS6NFDlKbrBcYM7VPl7vL5Hx53Uoj3uCKZWCJSVqDlOx0icC9N
         HmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfFwm9/whD1jR/5n6DKKR8V6Fa945UAISwsDPx5HLJU=;
        b=YhzE2cetVu1MkUIa6cn7to0lEen1XWn2ShnUGUhvSCNDTn2R3IkH3ZIob/q7/uuYVA
         SR0HDUIomi/st/EGt3auAAWtFYOvRty/CK+TTu1T9cs1lTt2G7PNgunm5GFKuoleHMCS
         AZWR4qIiMFPG7mxcSJvQ7im3caxzcXAG+7Zli0BXP2gQQ0CuePRHncfdyrn/6n04Q5Hw
         Swc7iz/ngjYLKfgKby3HM/YcnmDkxmHZMGJvu72xE2L12JCnz6WDpJgEhSHdY7DfuJeK
         Rek6TtNYHE7EHKoFrEAkof6lRmFGS63t5uU1ZXAIj0LyqzZcNwSOCQpe47qulNHtC1e2
         qOVQ==
X-Gm-Message-State: AO0yUKWIlUm0GmLSE+DM7L4xvG4j1TgwVSAudGJwwFQbqmJ3fmDqhBb8
        QP87E1KLXv0siEB/r1teqe99pQ==
X-Google-Smtp-Source: AK7set9Qn3N/Y7oeDr4/exTQKdkEWr0ZNpz0BljQKMTsO0FQUS1zMkn4oSsJkGhlLxsW10/KuXmQFQ==
X-Received: by 2002:a17:902:a986:b0:19d:297:f30b with SMTP id bh6-20020a170902a98600b0019d0297f30bmr26907234plb.19.1678707641163;
        Mon, 13 Mar 2023 04:40:41 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:40:40 -0700 (PDT)
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
Subject: [PATCH v4 01/16] perf kvm: Refactor overall statistics
Date:   Mon, 13 Mar 2023 19:40:03 +0800
Message-Id: <20230313114018.543254-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
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
Reviewed-by: James Clark <james.clark@arm.com>
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

