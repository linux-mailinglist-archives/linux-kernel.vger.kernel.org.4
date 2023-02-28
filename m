Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17806A549A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjB1InI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjB1Imo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38F2BF34
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:31 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ky4so9653991plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0Hu2w1HCV6BLAJH+BUXhSI8OHGX3HrQUpTuSp+vt2M=;
        b=VHOnJBevYRYSJ1epcLVTVpBcrZ5CmX6c3gwAqRdrBjJvuiaEMfhNnTWH7Jh8HlIyT2
         j3qky/eQhLlI+Nlu+qZtgGDDO0g3LHAMQERT66fq6A8bDmQBV0YH/PcfyQFNODGxyjpq
         vFPveBI3AxMrkUJWiAwV6n1jWroXngXuzZwo3CEFjc9VcHDj4BC9rpxVHZPFuHpkNx6G
         pqEfSSJrl3MC89ry60or1F6chie+yiVvm64q/NauO59k7dxX5Puly2P32DcwQI4o7QLC
         NFuYmAyAK58/hJHRFywf+DC1bn5HmS3GMgSmKtSJCe2VAYxXFrbrPPZDR/tO9ryOas/V
         PDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0Hu2w1HCV6BLAJH+BUXhSI8OHGX3HrQUpTuSp+vt2M=;
        b=L05VtWMZ1jXLj8rlyo+ae2Adv8G49LEIOIOys2+t1bVd1kQcjwsPkkgwViV4+yzmuI
         W40cNH4I5lND2QEkV2vesV4LbvceCbvrJm6/tA/89/avOTuDX974mDdrhnV5qbuP4sv6
         +8Hc1leh/mkWba9nT+4kUTKxgooNA+wY9K8eeZXAMCa4buyZQ39G3lfrb1J6u5SDACHj
         U0jpCUJqE73MwWfNUbjUr/5BAfnggoQqsw8QFxcIVyfZdo/MB3ECkhMdODYUhV+qumGF
         8hi9VCZ5eSMNoulnQRQoenipDAFh9W1zt5bn4ndv1j7mDn66mhoYLU5xgsPsQ0Nzfkxo
         WqBg==
X-Gm-Message-State: AO0yUKVbzHoUIxua7HWNsKOijg0x0etVgmmmyjYsRffIfHnIDTY5jT+J
        1E7B98+lcNOenwW+n7Lvr55Jpg==
X-Google-Smtp-Source: AK7set90FndkZvwZX75PAvXzSK43HcqfjDAThyt8jjik07yQKZSrA0v/pKr4OrDENx9BF8tgALzGqQ==
X-Received: by 2002:a05:6a20:6982:b0:cd:bd86:318e with SMTP id t2-20020a056a20698200b000cdbd86318emr3810088pzk.26.1677573748835;
        Tue, 28 Feb 2023 00:42:28 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:28 -0800 (PST)
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
Subject: [PATCH v2 06/14] perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
Date:   Tue, 28 Feb 2023 16:41:39 +0800
Message-Id: <20230228084147.106167-7-leo.yan@linaro.org>
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

