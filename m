Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817275FE8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJNGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJNGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:15:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6231193EE0;
        Thu, 13 Oct 2022 23:15:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b5so3489548pgb.6;
        Thu, 13 Oct 2022 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHWFfD5uXAIuo8SM1relQgBWw32fsgzMn6vLvoZArhU=;
        b=RHJRhm6gb4zpIYhz4wfgoUEV5boxAePR7GAVqHy7ZqETvvPv6oYZ/KKIthRTUIC6r9
         0atOmTyrK5jQwwlwMdXALJljCpmQj/AHZZVaFYNfcZ7f+hjYYqEsuUn/Qi7Wz5XACIK2
         YGIB17pKZj2eY0DE6QSHFnYsg9ryHYmPLox1gzgmlVaeetHgqOvILkciANx2N1RBQ/Zp
         4IlnvWVVG/mCFbPp33wxssQWkeByROFmbsZHe+COptJMXNZIxsAIAcHA7WluYbmd1OSm
         dDQlY2lV0/Bxd4isnP87yxIgFvShoK9E2l0JAP5qrg3+uTu043FNtnI8tkfVikL9rPdF
         LNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHWFfD5uXAIuo8SM1relQgBWw32fsgzMn6vLvoZArhU=;
        b=QCyHaXfq9K+AEbwOdx9/FE4Cm/TtK5zNENn/6Q1j/NrylS1FNRMmy96cbytBFryxJw
         bcQ2UJPuViLS8Bfxr3nk5MVUYx2LICKJLgwOoYa6+XeJCPMlx+A8wiqDVc5+Mzj72VWi
         /LHETfCYquaGKchoO7uJKgajsdxsKGBPAJc3CLSdH//YknfN3FS0317o5xiFeVGI64JL
         rI5lQjy4WrwOCyQVsK3GalFqhILMtM8D9ik3EvdAYnJ/nm7+w8qUqrBiuq39OnEpYKxr
         4h1PygbwDtaLSd/Myz7NegFo43CMPepl3zDnowJTbYzAiGGt5RnLheSUyI9TkbTiPxFZ
         NcXQ==
X-Gm-Message-State: ACrzQf2pTa9ufBdeYWm3CavogwQpS4MbFC1WEzZq976olJZZq3hfVNCa
        GN172QuBoekdRvlyHylUqWs=
X-Google-Smtp-Source: AMsMyM4L/HsJhg7gmaYlOhy3VMwDk4LpJB5I2BLASdOkZNMK1sKP/bhWAw3s9ACQ55je7kED64XOog==
X-Received: by 2002:a05:6a02:10e:b0:43b:e57d:2bfa with SMTP id bg14-20020a056a02010e00b0043be57d2bfamr3143314pgb.263.1665728154111;
        Thu, 13 Oct 2022 23:15:54 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:15:53 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 01/19] perf tools: Save evsel->pmu in parse_events()
Date:   Thu, 13 Oct 2022 23:15:32 -0700
Message-Id: <20221014061550.463644-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now evsel has a pmu pointer, let's save the info and use it like in
evsel__find_pmu().

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c        | 1 +
 tools/perf/util/parse-events.c | 1 +
 tools/perf/util/pmu.c          | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 76605fde3507..196f8e4859d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -467,6 +467,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
+	evsel->pmu = orig->pmu;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 437389dacf48..9e704841273d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -263,6 +263,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
+	evsel->pmu = pmu;
 
 	if (name)
 		evsel->name = strdup(name);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 74a2cafb4e8d..15bf5943083a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1048,11 +1048,15 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
+	if (evsel->pmu)
+		return evsel->pmu;
+
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		if (pmu->type == evsel->core.attr.type)
 			break;
 	}
 
+	evsel->pmu = pmu;
 	return pmu;
 }
 
-- 
2.38.0.413.g74048e4d9e-goog

