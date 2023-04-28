Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9799A6F127F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjD1Hih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbjD1Hie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:38:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719140FE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:38:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54faf2edb18so176754267b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667512; x=1685259512;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8p/C4BL6ztuAn+meFB+SfP0NDlKL/GOWeX5v3wZKBY=;
        b=WbUD/G+NoyBE4ZNcZOWOYvELY8fEfERVFoEoLjmm+dlKOc0PNEoYF/pZEySdFr3Gmp
         AaSG3gRxQRXXjXibbXzgyRwoRZnvl3tCRHFoxlVIjFohuhmwEpDEkoKZOAZYz+8gH+az
         d9+p43sn2EO7aPZimMkfoBlFm7gqn60x52pRzJhKiVUCBEQdhsrHcLYJ7ZHpIwu+P327
         Rhxi5MFWs+bOe4NifHyKANuz1n5oPxbwDEIKInLEWSnoy2OxDDE2//sJJ02vkWyvmhSW
         84unIUGDhshoy02zW/lQykPRZQYXSeTWPzR6ECFO0zHvXDeRG2CAZ/21D+0RqRNAVOaH
         EbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667512; x=1685259512;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8p/C4BL6ztuAn+meFB+SfP0NDlKL/GOWeX5v3wZKBY=;
        b=R0rmHgytViEh+51h3Vq/XnZu4cqv17m2NXfFmrNfqTgVHXV1469dFS5bPhEEmFKnB2
         lFgVbd7IfDjyGqNEAZIXfHgtdYdChyqelsbdikNC54FShNsgZ3/RGg48l+7SXkoHBB10
         6j+zpss0bbaFNqYn7G2KzytHS0qCxHTj/RTjPRgjr9IlyJQiyl978F/mGmH30iOgJqba
         dtsCou8WdceHDmzPK3XenSo94rAPT6XE9UqS5p1fUDGNpZEb0+4mgTjYdgZI8IPMWNLR
         wAz9FUuhuiNBoDdkB/0ubGHtC17LNWAvcpAdzPbbldkCNBuurpwEGIlaDyT2q/MGykZO
         NC6g==
X-Gm-Message-State: AC+VfDz95XyS3DgiVcqJQr3aF459dgrt1bvboH/+/7amTWBaGFDdCN/l
        RvLQ9QFJkNChDX1JqtMwtg6qs4qjRABg
X-Google-Smtp-Source: ACHHUZ480F+EYUumT0eT6vvzWWopJX04BRu3pGc/beyzV+fRguhM2asLOQayNsOWsmk1Rx2BwnZljCi2Qjgp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:b145:0:b0:552:f777:88ce with SMTP id
 p66-20020a81b145000000b00552f77788cemr2689258ywh.3.1682667512197; Fri, 28 Apr
 2023 00:38:32 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:27 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-2-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 01/43] perf stat: Disable TopdownL1 on hybrid
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

Bugs with event parsing, event grouping and metrics causes the
TopdownL1 metricgroup to crash the perf command. Temporarily disable
the group if no events/metrics are spcecified.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index efda63f6bf32..be9677aa642f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1885,7 +1885,12 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		if (metricgroup__has_metric("TopdownL1") &&
+		/*
+		 * TODO: TopdownL1 is disabled on hybrid CPUs to avoid a crashes
+		 * caused by exposing latent bugs. This is fixed properly in:
+		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
+		 */
+		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid() &&
 		    metricgroup__parse_groups(evsel_list, "TopdownL1",
 					    /*metric_no_group=*/false,
 					    /*metric_no_merge=*/false,
@@ -1894,6 +1899,7 @@ static int add_default_attributes(void)
 					    stat_config.system_wide,
 					    &stat_config.metric_events) < 0)
 			return -1;
+
 		/* Platform specific attrs */
 		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
 			return -1;
-- 
2.40.1.495.gc816e09b53d-goog

