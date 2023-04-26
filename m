Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A66EEECC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbjDZHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbjDZHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:03:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D13A82
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5529a6f9f28so101472287b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492565; x=1685084565;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVN+WtVBinIPas0ggbaTczLlntAFDczu4JgyAZ0ncIE=;
        b=VKJsvk7sfsTdWRe0vWM/KmnbLXQsbdtRZ1+JEgmzNSG0FDKos+QNepsT1cgFyqWHxs
         7C8cnTiz2RnJB+DZ0A9tNM/ufFBzmjZYUXGLPcMZdxg2T+Sv7pP8MDIGGUS4BnYoAL7p
         GqvJYMvjGJRkBk8AD8UOnD49u6X+irbxyIiH/sDNjmtqYUUcm9UQDJlFphpUNvvuxQWU
         xwf4LlJqIMG3ZtcMBUccLYO1423riHdGwgvqBrH+6wCxff02KNd/dwWUHZe5ERJioQ5y
         +KlxnJ5WD3m834lEf4BsMPLJn6a8y5GNd6h/S8H0dal5LiKWc9I62KSyJjVmzEDpdRlC
         r+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492565; x=1685084565;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVN+WtVBinIPas0ggbaTczLlntAFDczu4JgyAZ0ncIE=;
        b=D+VB+Zb0wa+1yMhPPIt8p7xE5Tr7wZ3vdrlt3Gd8FkixqiH8CkaMvUas+8Q0P2nufg
         PxW1VzdJHDurGHELXZ4NpUucD7LJxZdhq8eGClkcjK+b6Ow13GjUFoLk5n/DPg7HaAbF
         ygmbkVLbIoOTUQxjVsXS0RLGtKTohvdw0r7ZCRAIvIU4uijx5XIsP7UFA8uiXBUx6m3i
         sMcGNKooKgewKwG2LQ7HI6IfmMKGoA732sysohfpaEhvoRTHzWWB9pZ1Ty85TFZQAx+6
         KHyFKIOcOPwlGpn10xTsxv6N4kFzPqRK9gUEN/HhLlJj6IzgLrgDkQDNJmWepw4tN3sX
         vUrA==
X-Gm-Message-State: AAQBX9c7Bs6ejDnVLO/9qq/YWLBufpllfYIqHvb/YL6tETMK4xCJQkrZ
        uWY83gQxmQMWfBNIqYcy+4VDXertBvdb
X-Google-Smtp-Source: AKy350Zcvs2BYb9Qr+9Ja9Vk/hiFYSxiSRh213CZK99Z64gTB26/44mUXglSUz2Koc8XYOIFiI7dYmN3BqHo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:a983:0:b0:54f:a35e:e79a with SMTP id
 g125-20020a81a983000000b0054fa35ee79amr9131447ywh.8.1682492565338; Wed, 26
 Apr 2023 00:02:45 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:23 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-14-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 13/40] perf parse-events: Set attr.type to PMU type early
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set attr.type to PMU type early so that later terms can override the
value. Setting the value in perf_pmu__config means that earlier steps,
like config_term_pmu, can override the value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/pmu.c          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d71019dcd614..4ba01577618e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1492,9 +1492,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	} else {
 		memset(&attr, 0, sizeof(attr));
 	}
+	attr.type = pmu->type;
 
 	if (!head_config) {
-		attr.type = pmu->type;
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ad209c88a124..cb33d869f1ed 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1398,7 +1398,6 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 {
 	bool zero = !!pmu->default_config;
 
-	attr->type = pmu->type;
 	return perf_pmu__config_terms(pmu->name, &pmu->format, attr,
 				      head_terms, zero, err);
 }
-- 
2.40.1.495.gc816e09b53d-goog

