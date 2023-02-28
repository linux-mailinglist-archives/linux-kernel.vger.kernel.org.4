Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2C6A589F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjB1Lx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjB1Lxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A31113C7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:23 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i5so8422041pla.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIJRxgs2DKmjVAUdCuR1p8WFkclPBjAv6BB5zEl99zk=;
        b=KDCS8+cGYK+wyovEBj9oQdHlUEcysmGYjckcSBhaGYNVH2G3FZO+OW331XJrU6n+nR
         QQZ/PJbbmQ9LUvqUoKWzXkzP2MpaS+6yay3aDnDlh3r8hwpiABqwJTbi0++nS/UiK9lH
         yftRx/079adiiX7zPZpxKElp9gLE75C7890sxyZNf0eLAKD+h7S4yXLIsTm0QlNGI74d
         o79sBtStg0pFWoB3yvdwJ3z2FR+i732ngUf0OYsU0NnL8mtbjUfYvLt60hgmpTk18oQX
         deL3hABczKCEMPkbu+EdAnsEgNAiF8hM+DWsNxbI7mNqmVzS1gvgLKYIi6/t7X/i6m29
         WJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIJRxgs2DKmjVAUdCuR1p8WFkclPBjAv6BB5zEl99zk=;
        b=HFai1KC20bjc/+rV4VcKdvPlQlC2BK/sZYDYAIWMK3pgZ+YdX77aEr+1eh4ZHTMxIm
         tUbMJCJnN26nbg6rO6RXLJ58MuXciN0zOQLdtAPIDC8m+oqX3Mj99TM0psFsC+iYWhWO
         fVXoZRUBxZrNKJ6KCYOFszOpC/tQvdDRpA9Tvq62Tvpmp/TMl1bOPd6r0WTEWLJZ5kLd
         uKwVQy3Z4isk55t9UqD/6hmRkVbr9wvxJn8X/Cdbj5OaC6/JXIsm2DLmwlxVAj70E/LK
         LPlAdS3kix5ctFeQt99dFXL5LZYaNxggAAmrd90trz8yIal/JfDia0fYrd7IYFXFvmX4
         a7pQ==
X-Gm-Message-State: AO0yUKUNDLtJZST+z7+rghZiiC+azzWAja+5FCeNNjzlHY7wERBq7pwE
        ygFTjNZM+wNs16/XsUNttsIvug==
X-Google-Smtp-Source: AK7set+MWGmqM+uSXAg8BTkRV1oFwsyK3KJamoKhnqXGJp8v1+71rxGRvEyuvi2E+Uv/aJCtCE3OTg==
X-Received: by 2002:a17:90b:1b4b:b0:237:401c:9bd5 with SMTP id nv11-20020a17090b1b4b00b00237401c9bd5mr3018117pjb.46.1677585202677;
        Tue, 28 Feb 2023 03:53:22 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:22 -0800 (PST)
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
Subject: [PATCH v3 06/14] perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
Date:   Tue, 28 Feb 2023 19:51:17 +0800
Message-Id: <20230228115125.144172-7-leo.yan@linaro.org>
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

This patch adds an argument 'sample' for kvm_alloc_init_event(), and its
caller functions are updated as well for passing down the 'sample'
pointer.

This is a preparation change to allow later patch to create histograms
entries for kvm event, no any functionality changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
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

