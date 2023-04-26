Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3F6EEEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbjDZHII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDZHHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:07:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01740ED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:06:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f6d2ac543so12900517276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492743; x=1685084743;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=0z/PrK6g6Xg4czeVIlj/pX3dWF4UNtJWqvXu+++3gH/z292bUXYL+CP5liRdzaOXwK
         G0FMKhhAKAFSTw9bYZ0YvNnJhYCTYp1Iogw8KjhJLvRS6ut+2nRWuUIKZKySwKNpDE04
         6qql3m+G/H0iVxs0/09IG1lOCs/N6J2G2XR2nEzo4PgiW639yuwiNHXbOLIfSEprwr1G
         AYECmWQuGkvgI0wWw9a2B1j5kj8IE/9ymlXpo/Fx12X33R5K96yesB0lXUK9B0HUyOzw
         Xr9plpsGCYkbzwKZ9HEzUopdL4/Tt4Yw4D5C1sVuBsfMtpkhzu0epGLIhrqimnyLobPq
         7Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492743; x=1685084743;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=V4ahITxO6Q0WpD3uK8ZY5AcAhzkmy4lBWNg/28XH1ChFdIfTcknTA+pB4oj/pQaysN
         IFQubKsGiMqgspH+z+UwaHnWHLGkVgVPZl0ZwShoJInL/ukFXB6EAfcGY+N52sWkNdCG
         3EKD4+Eb0QwaD2hjYqqanhxP3Pg2viDGFClEcsQIa2+jCJk6/vOHolO7MC5NTC3bekk4
         ijTs56ID5N2VwIeFk6uVxCokdcceWY7e7uLcpokPd9w9K+7SqygSvX6q/BDgwaT+bZ3B
         3uJQ7nlgUpq5XzDQEgRu6RXJcD47GjBujB949xz42QcG1yp9BDeMJ02Hb2Q+JOYicCeW
         A0Aw==
X-Gm-Message-State: AAQBX9dfvDlbBE2vD0dOlA8PBTITpW/AKS1+1LAnsWZZ0ZUR+msI9uyo
        dZ/vyW/yKWjlOWvy4LuOGKzFUJAOPu8o
X-Google-Smtp-Source: AKy350ZW/8qb50C6+D2zOw6h8DWAL4oDMWu5eMmEbwxOsS26DXiiJWDPDp4nKg7TB/ukOVNir4OT10PfxKQK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:d7d8:0:b0:b78:8bd8:6e77 with SMTP id
 o207-20020a25d7d8000000b00b788bd86e77mr11071249ybg.8.1682492743662; Wed, 26
 Apr 2023 00:05:43 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:44 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-35-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 34/40] perf parse-events: Don't reorder atom cpu events
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

On hybrid systems the topdown events don't share a fixed counter on
the atom core, so they don't require the sorting the perf metric
supporting PMUs do.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index d4193479a364..1b6065841fb0 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -6,6 +6,7 @@
 #include "util/event.h"
 #include "util/pmu-hybrid.h"
 #include "topdown.h"
+#include "evsel.h"
 
 static int ___evlist__add_default_attrs(struct evlist *evlist,
 					struct perf_event_attr *attrs,
@@ -67,8 +68,7 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
-	if (topdown_sys_has_perf_metrics() &&
-	    (!lhs->pmu_name || !strncmp(lhs->pmu_name, "cpu", 3))) {
+	if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
 		/* Ensure the topdown slots comes first. */
 		if (strcasestr(lhs->name, "slots"))
 			return -1;
-- 
2.40.1.495.gc816e09b53d-goog

