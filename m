Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461FF6F4D20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjEBWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjEBWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:46:46 -0400
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31C3AA2
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:46:16 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-559f142fce7so71447187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067459; x=1685659459;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=gojl9HwHH6dSomxA0iNDxmuQP/iGSlTIAnnlpuwgAwND6HM9nhykps55V9hrixO7GH
         JqqMikZyvzC9grNkp52yXWH6Zx8COeV321VVi53ed6Xx8I3VGnICqY3cYUJAos95eVe2
         qlUatBbFGGJYZbckoX48NQC1R/fhQj9H3NkdcNHtr1s5y4UDCtzjeHOyOWD8N+MYnRVa
         yrMpVe6C4X4UOmZucbVlNOGBrWOEaLM6AoPH2wUReYOcjyTBWPLhXsP2srxjBxt9d72A
         V2uhVYBNstyLerh3Mhaj/PktKJLTji+8nYZi7xFblE0D3UtQJCVrQkfxufV/hUCrFGK5
         v8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067459; x=1685659459;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=BmrFIwdEfvcMuNMee09l3QGn0EYxf/IIl6PXDB1E6dyXcF/Ea9dIBVC0/aWbLCcEZL
         iLF1x+828N8k9DfqkjXzPeXTI8/2158LQdFfw5lc+9MUMVuzbkJzOWCMS8H0RzpjfZ7k
         lbYG7aIIo+dH2x7SmbbLgVB0B/afrF2g6hVZwP840tPsGNGjk3+NXGiKWgQvKReHnAeH
         usowdCe2BC3+DbfgL6jeIlT/YdVSbOflfhEhPddiKK7geyZrWKueZvIwLFyIK/SeVL/t
         2OIB8EmGmnMdMnGhHlyRd0cbLo6ROCX7FPbQZxIFHNO+QNic29S8YoEwHNWou8iiOgUR
         FQyg==
X-Gm-Message-State: AC+VfDwaFrGt4SkVzIBMNjjMVMY/wepb7uLxwEcMJoFmiwAiXICAFlmg
        NmNbmimWfxS8TtsyfJsR+++UiJ6gvKHQ
X-Google-Smtp-Source: ACHHUZ5zFcnSGoYy10fGDH40vDdIwUQ+uQ6vQnbd4Izu2cHsmeAi8zbJBTEGQqFzRAOUO0v/SGTjrmnnvfNE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:ad58:0:b0:559:f1b0:6eb with SMTP id
 l24-20020a81ad58000000b00559f1b006ebmr6888406ywk.4.1683067459645; Tue, 02 May
 2023 15:44:19 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:50 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-44-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 43/44] perf stat: Don't disable TopdownL1 metric on hybrid
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that hybrid bugs are fixed sufficient to run TopdownL1 metrics,
don't implicitly disable them for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f4e572f9de6b..67dc69270ae4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1900,12 +1900,7 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		/*
-		 * TODO: TopdownL1 is disabled on hybrid CPUs to avoid a crashes
-		 * caused by exposing latent bugs. This is fixed properly in:
-		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
-		 */
-		if (metricgroup__has_metric(pmu, "TopdownL1") && !perf_pmu__has_hybrid()) {
+		if (metricgroup__has_metric(pmu, "TopdownL1")) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
-- 
2.40.1.495.gc816e09b53d-goog

