Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27E6B762D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCMLl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCMLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB2C6507C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:40:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so11372665pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=lnyLElApv7NnUsgOvaifBSHgYeHAmg6da7c7jzAexRiFFgCaBVjIDqWsedH4pS3CQ2
         Jw0+7ZrHOQBWZGR/XKq2dkLxLEMHw9AE9/58WvGpBwyGvQ3Ilrj0Kvhm04xfWfySExcD
         5DETnEtSfjQIEf27I/QR4HS4fKDgHnT/aeCKKy0yZLaKzO229NgEPXyov+ObigOAonz7
         bKX4em//1FqtEQVLJPTz+j5dg7zEIfAaUKv78qttuZnOp2Om45cIM4cLM1RFnGFaQEVR
         OoAG6i+q6Mg9TyDVwnMQFQNHCNp7OlDcOZq1aUkdLzU8yUP0OSLjyo9xKTLqAI+LI6jU
         EZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=MhiXXHTwaGeTcB8I3mlZiqSgz2ujTVq4sIarthtstcQHXSwfyXKyf/aJsRW43XZLo7
         6OpMcuygiAE4eh4jkXoS2Qytil04UnrnNQVBbax70JHUg+4XqtUmMDG+eGJvhTqdIm1F
         aqu+GGcXx9qtbLGS75nvQwyka0f0v3C1Cj4XOzbMtp51GUNq1ZGcWXlZn/o5LkCroCOk
         iSNhOjIXnaBVhXAPNXZ6EGQWqqa80XAhfMiEY7ysxR6HSRGbnfd1h3xcxVWCFs/ERyqG
         pNI1yEvoFH8BEAEIHvzkehl5yyKZ16LJk8Ljuei1lLnU/um3BkXa9cFDZLLeVUd3dMGu
         Zibg==
X-Gm-Message-State: AO0yUKVxtZnYNoToumQ3yU2zGfp8t78ME/HiizfRRgHGKNvTTgguAI86
        ok8SAeCygYZNUY/orXLDoYN33g==
X-Google-Smtp-Source: AK7set9NefgnF+3svVDo4B3o+1IDC59WD7sj8UM5nnDc9xjSkGgKmUAixlouEv38J+Ox6ns97dZuQg==
X-Received: by 2002:a17:90b:38c3:b0:237:d44c:5861 with SMTP id nn3-20020a17090b38c300b00237d44c5861mr35810313pjb.12.1678707654867;
        Mon, 13 Mar 2023 04:40:54 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:40:54 -0700 (PDT)
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
Subject: [PATCH v4 03/16] perf kvm: Move up metrics helpers
Date:   Mon, 13 Mar 2023 19:40:05 +0800
Message-Id: <20230313114018.543254-4-leo.yan@linaro.org>
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

This patch moves up the helper functions of event's metrics for later
adding code to call them.

No any functionality changes, but has a function renaming from
compare_kvm_event_{metric}() to cmp_event_{metric}().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c | 72 ++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 3d2560ec6b37..62c097a37da9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -49,6 +49,42 @@
 #include <math.h>
 #include <perf/mmap.h>
 
+#define GET_EVENT_KEY(func, field)					\
+static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
+{									\
+	if (vcpu == -1)							\
+		return event->total.field;				\
+									\
+	if (vcpu >= event->max_vcpu)					\
+		return 0;						\
+									\
+	return event->vcpu[vcpu].field;					\
+}
+
+#define COMPARE_EVENT_KEY(func, field)					\
+GET_EVENT_KEY(func, field)						\
+static int cmp_event_ ## func(struct kvm_event *one,			\
+			      struct kvm_event *two, int vcpu)		\
+{									\
+	return get_event_ ##func(one, vcpu) >				\
+	       get_event_ ##func(two, vcpu);				\
+}
+
+GET_EVENT_KEY(time, time);
+GET_EVENT_KEY(max, stats.max);
+GET_EVENT_KEY(min, stats.min);
+COMPARE_EVENT_KEY(count, stats.n);
+COMPARE_EVENT_KEY(mean, stats.mean);
+
+#define DEF_SORT_NAME_KEY(name, compare_key)				\
+	{ #name, cmp_event_ ## compare_key }
+
+static struct kvm_event_key keys[] = {
+	DEF_SORT_NAME_KEY(sample, count),
+	DEF_SORT_NAME_KEY(time, mean),
+	{ NULL, NULL }
+};
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -461,42 +497,6 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-#define GET_EVENT_KEY(func, field)					\
-static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
-{									\
-	if (vcpu == -1)							\
-		return event->total.field;				\
-									\
-	if (vcpu >= event->max_vcpu)					\
-		return 0;						\
-									\
-	return event->vcpu[vcpu].field;					\
-}
-
-#define COMPARE_EVENT_KEY(func, field)					\
-GET_EVENT_KEY(func, field)						\
-static int compare_kvm_event_ ## func(struct kvm_event *one,		\
-					struct kvm_event *two, int vcpu)\
-{									\
-	return get_event_ ##func(one, vcpu) >				\
-				get_event_ ##func(two, vcpu);		\
-}
-
-GET_EVENT_KEY(time, time);
-COMPARE_EVENT_KEY(count, stats.n);
-COMPARE_EVENT_KEY(mean, stats.mean);
-GET_EVENT_KEY(max, stats.max);
-GET_EVENT_KEY(min, stats.min);
-
-#define DEF_SORT_NAME_KEY(name, compare_key)				\
-	{ #name, compare_kvm_event_ ## compare_key }
-
-static struct kvm_event_key keys[] = {
-	DEF_SORT_NAME_KEY(sample, count),
-	DEF_SORT_NAME_KEY(time, mean),
-	{ NULL, NULL }
-};
-
 static bool select_key(struct perf_kvm_stat *kvm)
 {
 	int i;
-- 
2.34.1

