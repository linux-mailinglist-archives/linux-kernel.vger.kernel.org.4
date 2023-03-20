Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1ED6C0A72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCTGQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCTGQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:16:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61804211C8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:16:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id bc12so10757764plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679292993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7szfQ6l55dZUgXvWkesn/LLdQPqO6dub4gfCwuSe89g=;
        b=LQK3nddr0TzYW7JOZLdkn/QVsNbpjyGoYvfsa08hYUXQfXxtJvp+k7JViyGBsAOjfe
         u9QCG495i9t8NcMEGMYCVLnV3euxgBpYRro6RpKaz1FMrLh3yTm36UW6pGnBayX7MlZP
         Fvt9Fie+wwWHJoHqQRSmnN4o0ZjeuuMoNZrlmRyp+lM8C80jjRQ6qcDJNUvbR1scbEBp
         8JrqP758496qKyFeu8YFIqU6hc5AhNjx2RQ11F+AhnkmyrIGvFQ/bnwMuASUsz/yOlza
         gtvOAr4VPd6eM4sNKs5REaXXG0UNbhq+E0KQCW8yFf6mMGzmbzeokUadS+Sp1vvAJkbh
         ALcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7szfQ6l55dZUgXvWkesn/LLdQPqO6dub4gfCwuSe89g=;
        b=FnU/AlLw86nyXNrWuu/S2+0+1XE7kopm7S0Rt3ckNhXdEpeAVPdVTm6cfdJss1DVmV
         TYTbFjQONDEXorFHy2s6dPHNH4H69khUljqxrF0EUSApRKhKqYX0uc0WzgRTc8RQNDqv
         UtYMY0DD2IawkJ6g/fZ907kX/qd2hXD0JoF5DhVGqYbR9B1rk5eWO7J9xwVHDcuc9aPq
         kFsyRVYc0t8mySlZF7kilhvHwj+njiLHIM8pMjX7n8BYtW4anAoHEQAhgphT0pnAUmb8
         s/7YQuXCrdMmgqetSRXsrjk2LqSdohTDNkXGy/JjXV32/so+es0slxgcCjYnzOWi6Stz
         Xs2g==
X-Gm-Message-State: AO0yUKXi9SzGeg3v7JiHKllbmSkl0T1xM1ox0i4uhdPCMNgKWu9nS4D/
        z0AW3nzJjjh2m0SeiSzSpcgEFQ==
X-Google-Smtp-Source: AK7set+4QZvWX302eEC5ipBz2ILWx65BwdH0MsVLmEzj9q2mW69Fzqlz6Qg7eDJazg8RuiPyrMJ8bw==
X-Received: by 2002:a17:902:f301:b0:19a:a9d8:e47f with SMTP id c1-20020a170902f30100b0019aa9d8e47fmr12461633ple.36.1679292992802;
        Sun, 19 Mar 2023 23:16:32 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0019c61616f82sm5750129plo.230.2023.03.19.23.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:16:32 -0700 (PDT)
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
Subject: [PATCH 1/2] perf kvm: Support refcnt in structure kvm_info
Date:   Mon, 20 Mar 2023 14:16:18 +0800
Message-Id: <20230320061619.29520-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320061619.29520-1-leo.yan@linaro.org>
References: <20230320061619.29520-1-leo.yan@linaro.org>
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

hists__add_entry_ops() doesn't allocate a new histograms entry if it has
an existed entry for a KVM event, in this case, find_create_kvm_event()
allocates structure kvm_info but it's not used by any histograms and
never freed.

To fix the memory leak, this patch firstly introduces refcnt and a set
of functions for refcnt operations in the structure kvm_info.  When the
data structure is not used anymore, it invokes kvm_info__zput() to
decrease reference count and release the structure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   |  3 +--
 tools/perf/util/hist.c     |  5 +++++
 tools/perf/util/kvm-stat.h | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4c205df5106f..1e1cb5a9d0a2 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -768,7 +768,6 @@ static void kvm_he_free(void *he)
 {
 	struct kvm_event *kvm_ev;
 
-	free(((struct hist_entry *)he)->kvm_info);
 	kvm_ev = container_of(he, struct kvm_event, he);
 	free(kvm_ev);
 }
@@ -788,7 +787,7 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 
 	BUG_ON(key->key == INVALID_KEY);
 
-	ki = zalloc(sizeof(*ki));
+	ki = kvm_info__new();
 	if (!ki) {
 		pr_err("Failed to allocate kvm info\n");
 		return NULL;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3670136a0074..b296f572f881 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -628,6 +628,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 
 			block_info__zput(entry->block_info);
 
+			kvm_info__zput(entry->kvm_info);
+
 			/* If the map of an existing hist_entry has
 			 * become out-of-date due to an exec() or
 			 * similar, update it.  Otherwise we will
@@ -1323,6 +1325,9 @@ void hist_entry__delete(struct hist_entry *he)
 	if (he->block_info)
 		block_info__zput(he->block_info);
 
+	if (he->kvm_info)
+		kvm_info__zput(he->kvm_info);
+
 	zfree(&he->res_samples);
 	zfree(&he->stat_acc);
 	free_srcline(he->srcline);
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index bc6c8e38ef50..9bf34c0e0056 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -10,6 +10,9 @@
 #include "symbol.h"
 #include "record.h"
 
+#include <stdlib.h>
+#include <linux/zalloc.h>
+
 #define KVM_EVENT_NAME_LEN	40
 
 struct evsel;
@@ -25,6 +28,7 @@ struct event_key {
 
 struct kvm_info {
 	char name[KVM_EVENT_NAME_LEN];
+	refcount_t refcnt;
 };
 
 struct kvm_event_stats {
@@ -145,6 +149,39 @@ extern const char *vcpu_id_str;
 extern const char *kvm_exit_reason;
 extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
+
+static inline struct kvm_info *kvm_info__get(struct kvm_info *ki)
+{
+	if (ki)
+		refcount_inc(&ki->refcnt);
+	return ki;
+}
+
+static inline void kvm_info__put(struct kvm_info *ki)
+{
+	if (ki && refcount_dec_and_test(&ki->refcnt))
+		free(ki);
+}
+
+static inline void __kvm_info__zput(struct kvm_info **ki)
+{
+	kvm_info__put(*ki);
+	*ki = NULL;
+}
+
+#define kvm_info__zput(ki) __kvm_info__zput(&ki)
+
+static inline struct kvm_info *kvm_info__new(void)
+{
+	struct kvm_info *ki;
+
+	ki = zalloc(sizeof(*ki));
+	if (ki)
+		refcount_set(&ki->refcnt, 1);
+
+	return ki;
+}
+
 #endif /* HAVE_KVM_STAT_SUPPORT */
 
 extern int kvm_add_default_arch_event(int *argc, const char **argv);
-- 
2.39.2

