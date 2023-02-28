Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02876A5899
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjB1LxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjB1LxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D6FB761
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13453277pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=xtZQMpff+QWOaUFLpccpEDYz77bqJRqchLzhWGNtquHoPoTdhJMYdmUdKMNjw99h5n
         GtCXH4AwJaDvBj6Ma6yRRSsYOemJR92n5ViC2aLfr0zNW0fFS40b2yM7GTUE/qnSu6tJ
         xdbcxjp8KaTuB1P5l4NDtZvUbQQg7Dd9ZxNiIq4RDSgNQajlQowMV4kz6VaOpt71wZNS
         8Sf/LqhBKZt0ec/HQ+XZaJDGYvweeKfGg6FKAIuA18sTrrzCl0IWTW93S4fDy1EGvMbM
         yFK8176oqXcdXQSvEiKZsV84iNpgLKDCkae1wHeU11kgtmUxsaD32k0nf2tZqfNM3z3Q
         mNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=pNOU6bPxtzY+EtwuCLdvKjF377WCMbIzv3XrKKAZgaGNP2nSLZjN9aegdMkqDZcXqZ
         Qh7Xw9YcQrP5HnDKx6fQGzq93nxtzhXlgQTexgDlB2+7Zph8iMlqWC/zJRdtpob8/6E+
         qEGVqAqHvMlpypYoeG7hiLg9+XBWn0o0pko9a8dfs+vJr5U2FT4McePxR1sRLyTarM2O
         hVqQ6VQBdv1MsASWLFUf2jvO03glubZL3CVSDosGdYiiz/sI8mnI7q8T6MjjSpT0Yvyv
         8dlTF3klGwOhokPgMbcNYd6Ee5rHddGrKufpZgUU+idSIle10R4GdgLptgCp55I6GHbV
         u9zg==
X-Gm-Message-State: AO0yUKXDrgBQUBBjtSFtVg/oNICvXLVHzZiAhdfluiPfjK3V+kS4KrNw
        2yK03Na2qcvY3VVmWq+mYfc7XA==
X-Google-Smtp-Source: AK7set+X+RCd9I9e6CQ52iQO/JLj9MHi60/nh04ESMcdfp+lHvPzHe4IllOmeh0Ov3U7ZxYhmxAm0w==
X-Received: by 2002:a17:90a:190f:b0:233:c9e7:c885 with SMTP id 15-20020a17090a190f00b00233c9e7c885mr2915100pjg.36.1677585184107;
        Tue, 28 Feb 2023 03:53:04 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:03 -0800 (PST)
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
Subject: [PATCH v3 03/14] perf kvm: Move up metrics helpers
Date:   Tue, 28 Feb 2023 19:51:14 +0800
Message-Id: <20230228115125.144172-4-leo.yan@linaro.org>
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

