Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320E46F1289
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbjD1Hkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbjD1Hka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C5527C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:39:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c58ec19so1906524276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667592; x=1685259592;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugIhEtk/VyqflTLZQyLveAtNDuQp0AbC6O0Oizom+5Y=;
        b=bKrI3I0E7mDZGIHzFFL6t1syGwwse2WTtdcLaY9TeF3RypIgA8yDxAyumXeI+73ZDo
         AxXxaWLbnMpZiiX4/Nq75FFu5aEs2IpkwHpLrKDylNueiDOEQmuBD063C/eVnx3DEDkn
         q/7w9a2ai7/2qohZKViLTMHWxD2JddIPdOJeKGtMQq9ZREo2NRbU1k7s5xPGfad7Ttr3
         EO0bJhpUo6QUkKTHVD8+juMI7hDkph+e2qJZ1HGkGkPjLDGEM7E2N4mmG+oeOXeREjny
         YsVSLEiS/FSRLkHYBRbDxED93kvDW+2xvnp8otGWtM3jGEoTBhjJkZ6lv0JmCbR5tENC
         QUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667592; x=1685259592;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugIhEtk/VyqflTLZQyLveAtNDuQp0AbC6O0Oizom+5Y=;
        b=Zcwmz/n93kEZTPB0OKM/ZuTXVUv/+hoFjvijpbD7uLVetPePBjZtkR/mWHqMycrIeY
         y1zwuJGsS50Oqjb5qAo9Fj0sVSwzHIn7cyhXwT2MuN0z4rhMYytETk13Wv8YtarRnK4n
         FNAqurLNr58NNAER/4E6Sr8cmrWkBP2q+RVFwD2nKCvQKsN5Vh+Z9UCpTzlbeAW85V6/
         944d++sgo7QKqbpgkTUfeENQOaFWJtopYENU6rAQoKddpVIRFgPQrP64v9OSLW3vFHnf
         qAu5gWvGsl+/+z6MIR59S9ipxEwZzLfpGEoIoUAdLMDitCyqm0AWceya+9ZrlNobaYfu
         0CZw==
X-Gm-Message-State: AC+VfDxNJw/T1o7W9PtBBpWoxlAeMuIS43XCZ77aD/g7lLdj4OAQU+tH
        Wy1c1t7oBvjXXB4TbRlvO/Ecg5F+KyHL
X-Google-Smtp-Source: ACHHUZ5nJkKRWVKFoyNlyVjtP4LLhHoFmkoaY+wjirkA91uZk9JbB2dRl/7KN7qC/2SaQXx+KTghgF4v9FYP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:d6c1:0:b0:b96:7fb0:f927 with SMTP id
 n184-20020a25d6c1000000b00b967fb0f927mr2545334ybg.12.1682667592612; Fri, 28
 Apr 2023 00:39:52 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:35 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-10-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 09/43] perf stat: Avoid segv on counter->name
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

Switch to use evsel__name that doesn't return NULL for hardware and
similar events.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index df6337f2480b..7aa7e16fa7c4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -748,7 +748,7 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;
 
 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
-- 
2.40.1.495.gc816e09b53d-goog

