Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A876F2328
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbjD2Fi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347277AbjD2FiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:38:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9381C2D55
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7ba919dcso1032093276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746657; x=1685338657;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qB7CrIho8sUs4uqST1FvQg7dTPewP8sCTz3Jefkl1h4=;
        b=7gxKY/CXr66YpcHpzLZE2nsQ7TZrubJwCdqtd2TR9kfo1sD5akgNOPK4YrdA4XcK/x
         jLE4EPEwYK+C38VKN93Huvo8z30gwGjl+Dx7XDf2LXOtk0ffRww+TxoJS/5b1sUfrGYd
         y4DWtE33wbxwHVHmQtDW/KDsS1YxOSmfmWRgJIsh2H8peRCWEPRpKyIdt9p10d5E5Xvx
         eeYXTc1VWWnI9hGpTfUJOr0q/MUVjiDC/q0mdr5qejd4EkLOZ6miPm8MagodLwREHeEz
         AcIf8v+IlpQil8C9aYCqcrkTAKtFrvG1OFkHQqrk7OsSSlNXECp1BvEUu0RFtOfJgfGj
         oCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746657; x=1685338657;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB7CrIho8sUs4uqST1FvQg7dTPewP8sCTz3Jefkl1h4=;
        b=VNUNnURYJonuHR7YdquauqeN/cG8jJ+qOJ108z5jdkuAJyCvcBqQJ4e2Nn8nngPFTQ
         JI8qmlDpraQ5EK8AZO/jPmJH0InA7ikCXLX2vYw6BE+JqVNZQ7smFPqC3cevO1yVBJ8b
         vnyTXiKZq5OaYgZO9yqEnC9PTWHz6rzJmEyM/BRQ7NhBGb54j5on8wYvhPijLhp8+z8N
         0FN+rRSa31CpzJ6dF1Wc1302C2PGw6LMIRK4bJ8j1DyK6gEl4X8d6PAMF9j44zOROxmQ
         6nlHrDQpTiavsbB68kaC8zti0D/j8Q7S+KMVFFbIbo2Ser5eQPgfK0u/J0G9R0lNCLV7
         gNRA==
X-Gm-Message-State: AC+VfDy+iymJFg/4PugYHd91gZ7zHUT+b2EHvJP14lS1eilGeoEQtkfX
        ElKUO7NExavgGsjZRPazuBOSBHDvpVb2
X-Google-Smtp-Source: ACHHUZ6vNySFlcMODgCnig3lQZyAoM6qXdID05lwe4DrriZsJrlozcR43ce5m25/RCiZAtzPVNi70WGqvciq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:7495:0:b0:b68:7a4a:5258 with SMTP id
 p143-20020a257495000000b00b687a4a5258mr4265164ybc.3.1682746656744; Fri, 28
 Apr 2023 22:37:36 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:37 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-18-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 17/46] perf parse-events: Set attr.type to PMU type early
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 34ba840ae19a..707c53f1be09 100644
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

