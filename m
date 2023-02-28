Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B26A5897
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjB1LxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjB1Lw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:52:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9F35AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:52:54 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so13424980pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfFwm9/whD1jR/5n6DKKR8V6Fa945UAISwsDPx5HLJU=;
        b=wbv7ziCPJxqwbDWQhst1eW5b1dBwhJRXlbUxZezytqOmUHFMzhW4NWpoKafXASCkB7
         GeL34Pgb3wfWJ4NsX4UEzTCvdzr1siXmUfB6y/EEOatKrLTXlNU5SfvkOn3FpKOiu/aD
         V45usGfgtn3wBdgEvXtjuBhRoxgFMxUg5GOiu5PjvkAKB1D3nOt3CWnnY7BLvA7q3J99
         oT+Gxgu2CygU46jOjfUzF0oGUmHrPSIIReBlomRNOf4lQ38cm3BrPqUijxow22PbVzWk
         MByhiEjCTg/yEzg2k4+gB4WRlaOIsMNSuGYqYBbc2+jDfaVDvh6+AbXKx2qWsyXzVShL
         Zttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfFwm9/whD1jR/5n6DKKR8V6Fa945UAISwsDPx5HLJU=;
        b=F7cSI7dshZKf8Km4z2lXKmhy3VVkqdfjP2ppbiswbRSMMY3CFiuq5+jrMwJtmZxL0h
         GJdouKweVvBqDb+2MBLSo596jaQHaOVPkpDPrA9n/wROHVH21EGo/LdEbBYZlHo2lb13
         4tt+Yx6Gg++DzGxWSyjLeQT8pFdfmBoUlmrlH2nePfPw3FaRFuOC9LWNQpFDACHM9jM+
         z+kJr3NlvhhVQVwbc6d2kAMIRzcAz72a/kqUaGICGnQrAGzb3qbZBrWFVMzS2tO7K3ta
         9oUwiPQNOF75CHR4whkKch3pCD4kOHUZNhe4Wy/dBp/XdNE5XB7PAyG0ycxnVk3rYoRZ
         fZbg==
X-Gm-Message-State: AO0yUKVCyw40NWoa338JeTDC4AcmrwBOhbgSnvtihbRUFZeUTbNp1GsN
        tk1P+xv1EHV/z+cJbkeoaTm8nQ==
X-Google-Smtp-Source: AK7set+RyVPlxna1uVA+l/uQXFZn+/+JbDCj4AjboMdynOdSiXT5U81AqAlc4WUVIXEChAlTf+gDLg==
X-Received: by 2002:a17:90b:4a83:b0:235:9d0c:6e3f with SMTP id lp3-20020a17090b4a8300b002359d0c6e3fmr2884941pjb.31.1677585174069;
        Tue, 28 Feb 2023 03:52:54 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:52:53 -0800 (PST)
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
Subject: [PATCH v3 01/14] perf kvm: Refactor overall statistics
Date:   Tue, 28 Feb 2023 19:51:12 +0800
Message-Id: <20230228115125.144172-2-leo.yan@linaro.org>
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

