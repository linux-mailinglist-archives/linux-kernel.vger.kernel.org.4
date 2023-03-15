Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F46BB685
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjCOOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjCOOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:51:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11592732
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:51:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c18so1711364ple.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfFwm9/whD1jR/5n6DKKR8V6Fa945UAISwsDPx5HLJU=;
        b=KZugxK1LyG7HAO7IqFjdN3jXvQsOjnRWzVpP1xL1Tkj+buVGEEfOWxmIeEWzSDvzmK
         ms1ChOuszpzDA+GTPp/cavDKlnHwnrbJg9aWEbONC8gCP4h9AIZXNdfdmIIU7PgS699C
         u+XvdrXbhxfDPsFJN08NVERlQD2BKD2nmG8abbH0x+v/k9xl6AqASAFL7+0vfO3Hjt7k
         bERWmLGJs6VPNa2I4JateIzEU26/E6faw4Ave7It1UOcVjHkD04K/7lOGh4LHpR15J6k
         AlWwjdIIPAaPJ0Q4V6r39X5q1fYtVug/G0lghp1RvBo1PdU2CPiviKq0RN8I5hNQQPKR
         ZuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfFwm9/whD1jR/5n6DKKR8V6Fa945UAISwsDPx5HLJU=;
        b=m/hA4DVpLr2s4UcB2ijwWKSjMaTsmY7RDYzFZ/ij7Gl9IwrRvWuSQptkYcb0r6VoP5
         750qScoLqGWdsNtXTItH/sZP1E+Y0dACKWViUgPg22REyov/DU9yRDVZgFRwlbm4wJK0
         /3h7vQ0jjxvKsE1rCfJvTnVyDg8lKM+jvGcj6zibcT1DxanlNcgnN/1bj0VxCgl7XP1j
         k41hzyBWLPnOkfiW7CGYuIkObAKdKy78dPZAKWcvpvT8PtHOC4wEzFXPS85nZtgcczJf
         dxdXMQlpBVIVGkulPqseGgkyhTf7UrAZ6CcxtJJ1xI8EU1ISxB5v6uKqahpMFpST1E8c
         feFg==
X-Gm-Message-State: AO0yUKVLBEsAygzo0gQJmRDyPz/rUXUPJmMuKRFp7ylQASYLYa3ZZc+b
        Cum0CvFQe1zi+fHNNAsw80JjPEiMDx9cZ92PNYZT9+LB
X-Google-Smtp-Source: AK7set8qMbJAPIuXCdVoB6UCNz7/oT7SO0QBq/H+qHjAhlwX1P6E2qUM6KgqjzOFIiqFu/nUM+XJAg==
X-Received: by 2002:a17:903:283:b0:1a1:78e6:d600 with SMTP id j3-20020a170903028300b001a178e6d600mr2650897plr.10.1678891895802;
        Wed, 15 Mar 2023 07:51:35 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:51:35 -0700 (PDT)
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
Subject: [PATCH v5 01/16] perf kvm: Refactor overall statistics
Date:   Wed, 15 Mar 2023 22:50:57 +0800
Message-Id: <20230315145112.186603-2-leo.yan@linaro.org>
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

