Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B256A5496
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB1Imc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjB1ImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447922BF1C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:14 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z11so5193290pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpZ5nkw8exH6pwfmixa8Q7/xf5HABCQppgg+JZ7ONP0=;
        b=bkNjJlgsFaniZFnEBrVC/8eR7XRiD8jF4esOwr6DwL9knjpC8TMdYEKIhfajyMVu3J
         zYst4NnOj0018T6y8H1j3/uDZ231VtuNTDe0bQEvH55eOoBvFbQTxaGV08v3J5UWjuXw
         MLV03zzeZfla0MLgVNKobMDfXcgKZ2WURiDMFIV2KOGeVYeiDxUUuFT6HZ5g/RGSb5l/
         AggEFH6S7y5p2YPcXGMq2fTWCAKJSt5sINcKOHiD89iLHQaVykYp5aXrGgV5jVe+6GNJ
         O7UAgaia6gWetzD3UqK1pwwAY7TboLjjlun0m+Gg1FT7IvX0hArrtrXeMHllQlC6SIMt
         eJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpZ5nkw8exH6pwfmixa8Q7/xf5HABCQppgg+JZ7ONP0=;
        b=lmJ2CCwoPU5abfr/jg8BPN81kfKPn7rFEARE5q87MQvweL+4m3UICq0xUktzzxUfiZ
         1V0O6/bCFchrQgBXx9URC2hcc3dep1Xb94tbtRbT/amJob/wa6LZybQSHE2drxI6LuBu
         fdRnsyzb2Yr9uWBhZzX0BsZApHYerhStS6zl82NznlMp7dQiVCFToyVp4ZThGnanr6RA
         HP540kJItvVoqZDLqKHdfQHom8d0bmMt/kTGkNYLEt5x20kFMmf2WH65/2LzjzTKRiJV
         s8bRFxoiI27wG0cBFINBu1GBC/66ZY0I0wVG2jzhn423EYXkYeqXPn7TKdxy03INhgkI
         3tBg==
X-Gm-Message-State: AO0yUKVQAm23WRiPW5EOmNyZ/z86oZDq9RSQ2Wb0oT8BoxuzRRFp3SYs
        nruts/AgOTWOtHNGqE82Cu9eyA==
X-Google-Smtp-Source: AK7set+wD55KJzTyIXxQ5710IRZ53crBDuVrVE9lHicbaWu3jyLeU6IMpNUa9XCwV4bQmN8bdAnt8w==
X-Received: by 2002:a62:1b02:0:b0:5a8:cb5f:94d4 with SMTP id b2-20020a621b02000000b005a8cb5f94d4mr1388359pfb.32.1677573733361;
        Tue, 28 Feb 2023 00:42:13 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:12 -0800 (PST)
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
Subject: [PATCH v2 02/14] perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
Date:   Tue, 28 Feb 2023 16:41:35 +0800
Message-Id: <20230228084147.106167-3-leo.yan@linaro.org>
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

Sometimes, handling kvm events needs to base on global variables, e.g.
when read event counts we need to know the target vcpu ID; the global
variables are stored in structure perf_kvm_stat.

This patch adds add a 'perf_kvm_stat' pointer in kvm event structure,
it is to be used by later refactoring.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

