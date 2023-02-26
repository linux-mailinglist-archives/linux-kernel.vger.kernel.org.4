Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABD6A2E22
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBZEWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjBZEVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:42 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD9E04C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p20so2316562plw.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0Hu2w1HCV6BLAJH+BUXhSI8OHGX3HrQUpTuSp+vt2M=;
        b=du6tVr4cyHV9cIUuzZPA2mgvK3Yj70mmmSOE0beA5v6GpWHF6NBKXa19txUG3uYjcJ
         3T6S0RTvBKqN3MDtZO/7rIekMG6UVd7VB3Usc4Po8lLhpX6c/apvcVfXKByrbjUBszaN
         GxFKZqElik0a9SnwiYGmbz+pHRrfeUidxxWp13LQJDxcda45mr22lCMMBoT8RMFvDBjV
         EDM50sA31l9H8keZyN3jRUNWMbN+Uxg/tlbq07lpYPvphyOG/g0RwFpvDSGK/8ydMSbC
         7iVnPsOj6L7lGsqWvGEgJE2N7/8qD4bZ/Qny/CiI6+W9KcXtaVsz5akUq+lLSwSQ5p+v
         kJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0Hu2w1HCV6BLAJH+BUXhSI8OHGX3HrQUpTuSp+vt2M=;
        b=MV7RB1VZAFISr53a4UxoYutB8OMidfTFdGQ4zBmwcAJRYFZxRV+crojYnraV5AuZlq
         BaUxwcW7ZVzPn5H2Mk40XnfLXUAzpxLWrBk+d1yicC9+i+b8pKx+4k60eNG+Z+RGdwYf
         UY0xkeXmLLdFHfOHxgIpdIpGxRmI16l6KJHkrJRCLDOgq/K238Ef6ybzth9g0wK9RBVS
         dBCcIqDoWQ4S/vI9eLBfFyCdo6dTtT7UArXt9qu4Tdozmo87T8xERAwv2hy2qwsPDdzp
         zob4MXz+1y3SF253o0g+LeFBjdojn1MVEs8ls9OJc+pGQq1fm6o6alDrBEvtIv3ikBBV
         EHGg==
X-Gm-Message-State: AO0yUKUc3yuht4VCsZNpBqOnv4uMf7KqkepW4p6R32VF3oyBZT4TnAuV
        Uwj942nx0G3NZGzDZEMFQehigg==
X-Google-Smtp-Source: AK7set9beEmEDB/Jyu8tUwOhN/WaoDy7GuCqVAjAUV+73N3trUgVDT0HjMUgu/dtF3HNPJ1muq3xGw==
X-Received: by 2002:a17:902:d4c3:b0:19c:17d1:28a4 with SMTP id o3-20020a170902d4c300b0019c17d128a4mr25077299plg.67.1677385288941;
        Sat, 25 Feb 2023 20:21:28 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:28 -0800 (PST)
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
Subject: [PATCH v1 06/14] perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
Date:   Sun, 26 Feb 2023 12:20:45 +0800
Message-Id: <20230226042053.1492409-7-leo.yan@linaro.org>
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

This patch adds an argument 'sample' for kvm_alloc_init_event(), and its
caller functions are updated as well for passing down the 'sample'
pointer.

This is a preparation change to allow later patch to create histograms
entries for kvm event, no any functionality changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4ae54ba4fdaf..779881901a05 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -260,7 +260,8 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 }
 
 static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
-					      struct event_key *key)
+					      struct event_key *key,
+					      struct perf_sample *sample __maybe_unused)
 {
 	struct kvm_event *event;
 
@@ -277,7 +278,8 @@ static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
 }
 
 static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
-					       struct event_key *key)
+					       struct event_key *key,
+					       struct perf_sample *sample)
 {
 	struct kvm_event *event;
 	struct list_head *head;
@@ -290,7 +292,7 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 			return event;
 	}
 
-	event = kvm_alloc_init_event(kvm, key);
+	event = kvm_alloc_init_event(kvm, key, sample);
 	if (!event)
 		return NULL;
 
@@ -300,15 +302,16 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 
 static bool handle_begin_event(struct perf_kvm_stat *kvm,
 			       struct vcpu_event_record *vcpu_record,
-			       struct event_key *key, u64 timestamp)
+			       struct event_key *key,
+			       struct perf_sample *sample)
 {
 	struct kvm_event *event = NULL;
 
 	if (key->key != INVALID_KEY)
-		event = find_create_kvm_event(kvm, key);
+		event = find_create_kvm_event(kvm, key, sample);
 
 	vcpu_record->last_event = event;
-	vcpu_record->start_time = timestamp;
+	vcpu_record->start_time = sample->time;
 	return true;
 }
 
@@ -375,12 +378,12 @@ static bool is_child_event(struct perf_kvm_stat *kvm,
 static bool handle_child_event(struct perf_kvm_stat *kvm,
 			       struct vcpu_event_record *vcpu_record,
 			       struct event_key *key,
-			       struct perf_sample *sample __maybe_unused)
+			       struct perf_sample *sample)
 {
 	struct kvm_event *event = NULL;
 
 	if (key->key != INVALID_KEY)
-		event = find_create_kvm_event(kvm, key);
+		event = find_create_kvm_event(kvm, key, sample);
 
 	vcpu_record->last_event = event;
 
@@ -429,7 +432,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 		return true;
 
 	if (!event)
-		event = find_create_kvm_event(kvm, key);
+		event = find_create_kvm_event(kvm, key, sample);
 
 	if (!event)
 		return false;
@@ -500,7 +503,7 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 		return true;
 
 	if (kvm->events_ops->is_begin_event(evsel, sample, &key))
-		return handle_begin_event(kvm, vcpu_record, &key, sample->time);
+		return handle_begin_event(kvm, vcpu_record, &key, sample);
 
 	if (is_child_event(kvm, evsel, sample, &key))
 		return handle_child_event(kvm, vcpu_record, &key, sample);
-- 
2.34.1

