Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7926A5898
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjB1LxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB1LxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292A4217
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:52:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so13370224pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN7zwUTTarFdEEyI4xavpEstkRipyyWqLXdanEnFXps=;
        b=wEOZZ9u5LCTPZQy4HE9U8wHkT/7PQDW8KhdkurYABU3ChAPtXh8/R+oNAkSiy5wRIA
         paW/5AIubz1Uo62EB+KO4YpDcmphpyxEGC+2YWqrxO8u6JfbLfQbTFYAsEHcrMT3ultE
         sD/ZezHJpwZT69eIGjHGgo6YRjTCW29BpQ8ci9wNJEIf5+jegRkchbrzFEu7oIJqblBI
         NdZgARLUml0ARuz5OObX4Pjl4h+aDZu0sgLd0LUzvNaNCbVRgHboiCZlp61sNLfiyadV
         4GBMVG7R+c5o8TaZegumSMxx7V13xIHwdkXTvlI7IUzROwMgqfd9/pBCRw9tOh7aLu+s
         9dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN7zwUTTarFdEEyI4xavpEstkRipyyWqLXdanEnFXps=;
        b=4peWJTOrbc4Ldb3xBHzaJ6mZ/uHzabTE43IBAJ+TI3mnkEaed2XjPsElfwYlLB93BJ
         1Q5Fuui3PzavEhMdN2JapwuYfa1Of8s7it8rrCYf4cNWal3hZB5cO1d5uymXNhCcQ/uo
         FKYamti4GfTq8W2ceAkvPJFP4hU4HHLUQyVrpMolnGL2LIXIKfIj4vgyu4k3kYWjoidH
         QrPS7AzIF/zy7akmJBbTJlvooy87GjpQqR4oUhPtPKcZiLWn1xBq/4qGKs3G2G2HWx+h
         pv5gpNfembWDJikByxZ4pxndGUvOp3oPEQ535I56mWexCzJd+/5TtTLwd3ftUIts15AT
         Mx2w==
X-Gm-Message-State: AO0yUKW9E3/6LrzBGFcrtWmOchBxrPQeZooyZ051xVowMTMTaMUDmW/W
        j91VMmZsgwCzulzXouxebpNdnw==
X-Google-Smtp-Source: AK7set/B6c1iXV5EOT/x23Mgl2KM/qOAmTQcGVrgnuWmGKIhMWFWcJ3ME015ZGXyzumi/HdZe3OMpw==
X-Received: by 2002:a17:90b:3841:b0:237:5c37:d99c with SMTP id nl1-20020a17090b384100b002375c37d99cmr2962374pjb.21.1677585178945;
        Tue, 28 Feb 2023 03:52:58 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:52:58 -0800 (PST)
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
Subject: [PATCH v3 02/14] perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
Date:   Tue, 28 Feb 2023 19:51:13 +0800
Message-Id: <20230228115125.144172-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
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

Sometimes, handling kvm events needs to base on global variables, e.g.
when read event counts we need to know the target vcpu ID; the global
variables are stored in structure perf_kvm_stat.

This patch adds add a 'perf_kvm_stat' pointer in kvm event structure,
it is to be used by later refactoring.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 6 ++++--
 tools/perf/util/kvm-stat.h | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0172e5b0d26e..3d2560ec6b37 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -209,7 +209,8 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 	return true;
 }
 
-static struct kvm_event *kvm_alloc_init_event(struct event_key *key)
+static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
+					      struct event_key *key)
 {
 	struct kvm_event *event;
 
@@ -219,6 +220,7 @@ static struct kvm_event *kvm_alloc_init_event(struct event_key *key)
 		return NULL;
 	}
 
+	event->perf_kvm = kvm;
 	event->key = *key;
 	init_stats(&event->total.stats);
 	return event;
@@ -238,7 +240,7 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 			return event;
 	}
 
-	event = kvm_alloc_init_event(key);
+	event = kvm_alloc_init_event(kvm, key);
 	if (!event)
 		return NULL;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 6f0fa05b62b6..40a4b66cfee6 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -24,10 +24,13 @@ struct kvm_event_stats {
 	struct stats stats;
 };
 
+struct perf_kvm_stat;
+
 struct kvm_event {
 	struct list_head hash_entry;
 	struct rb_node rb;
 
+	struct perf_kvm_stat *perf_kvm;
 	struct event_key key;
 
 	struct kvm_event_stats total;
@@ -44,8 +47,6 @@ struct kvm_event_key {
 	key_cmp_fun key;
 };
 
-struct perf_kvm_stat;
-
 struct child_event_ops {
 	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
-- 
2.34.1

