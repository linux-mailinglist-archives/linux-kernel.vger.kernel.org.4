Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE56F231D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbjD2Fhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbjD2Fhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:37:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E54468F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:36:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso16072511276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746609; x=1685338609;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=plp8jNunI45YXnTgcIa90XW8dmc+0uDhLWyMSPKR7UY=;
        b=6dAThpLFujNNO34yULX2NxehJBIaeK+GrJQgFMoks9CoK3rdn4qprX+nogfmh1TkTJ
         oyKEXCVB5rS51WTG2HoudMX5p6Au7/MNn0Wi55rGQSvuDpU3DHj9UCObE6dGyOr0asYf
         SN0sZxdP3qsVXhCstwmMFviegP5hunTZdM4utVs8owV8T02dxk6J/0UxP3xNh4XQit9o
         Gse/5ujs833RS+GjtnfRHvjnXHqR+KG5Uhm2f9Qcwo5cqCarofkX4SFeVp1EM51uH65A
         Rwh5ajupqgNQiptffJoV+y8uLjshG/imqgXIvZRa7Kz5qFuPP5RYL44WA7ckBmeBx62E
         3OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746609; x=1685338609;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plp8jNunI45YXnTgcIa90XW8dmc+0uDhLWyMSPKR7UY=;
        b=hCVmPwV61R2IOw+LljHlcSGTsgjPzhVljgH/h2OtoDZahh4Ngv/ayuHKdhpmQf37C8
         FMi/NF3RARcXPDXoPZHybr1qydbB026qODEwhvn5HnBQqqOgMLEHgdnCaC6b6B6SfC1m
         lxSTu4kBscRgtMmg94iRL2NBMd+hwL/GBqM00lrVMn8o6vNfQsClxTdBIAafKsdIy+83
         DwCC+xKOkWu0PTSxPRJrdzpqHCmJT9FPXrWizc1fZVGWzuHONWyjZbzJNv3LDI5Ozc9i
         HfG7qTfvDed4lIxuq/+1eRdItwQalfZ9CNUN7mtLwWmAmBkQh8P7CG09pn0xCu6gwyHF
         cLRA==
X-Gm-Message-State: AC+VfDy9brMRL5f1Y28ADsl/xz5aa4IOIG1jcMd3NCUo5YE1qP0I9HNu
        sFAhL7v3DTCDA/MQf/qftDX7LQ6+VfZf
X-Google-Smtp-Source: ACHHUZ5NkJ+eWbRvlTe45zKIH9rMlZ9mfr7e4F2J/u0+NfsamZdvPBGACWToFTUgYSyCjwHpz5ryuTG+ZW2O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f82:b0:54f:e2ca:3085 with SMTP
 id ew2-20020a05690c2f8200b0054fe2ca3085mr7506556ywb.1.1682746609688; Fri, 28
 Apr 2023 22:36:49 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:31 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-12-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 11/46] perf stat: Avoid segv on counter->name
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

Switch to use evsel__name that doesn't return NULL for hardware and
similar events.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d87fb5328543..bf5a6c14dfcd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;
 
 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
-- 
2.40.1.495.gc816e09b53d-goog

