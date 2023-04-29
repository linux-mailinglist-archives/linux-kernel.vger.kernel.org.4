Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06F6F230F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjD2Ffb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjD2Ff3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:35:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666D2D67
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:35:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7550dca3so968156276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746527; x=1685338527;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRvWpupBHy9tpG1G52m6JU3o8mpqbbJS8gI2fZtfwrc=;
        b=iiPk0TX2SJqBQ3Cus3Tq630vqKhHPWCoPQnTKEooFo7XOHnwkZGorPthHPhjuy7LJ9
         1bWhc2YGJimK5+jfhOleoSfUqiyVxsvYCNjC1umUZA6Kza6h6Zqho1bheUVmhrmkuRyU
         mUCQmaGW4IYgAjxZkOQveiFRYnmplqeX6uyD/HRllZQljm5SfN/Kl+MqspKrvmG+OcA/
         0JbSl0vB/ul2rXk9RmCkY2pEJIruGlVdptEPsUFkrGFRlvRONp206CQLznwzAD2oqDOY
         K9woGOlY69hwCA6xdH1/8rKH72eKtUgXALO634qxDwOGgfRKPES9qvcxIHCneelcO3yc
         S1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746527; x=1685338527;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRvWpupBHy9tpG1G52m6JU3o8mpqbbJS8gI2fZtfwrc=;
        b=M11jEJVM6WO8b9FvrUVsUEzVnMzhFdzlUPu8Wai2OCv3ZeE182CBOiDK4cFj6pPCZb
         pNWj2iadmWJlPW+McGJAtL2lOtgqwPvZOFxQinekytnPG2AWW4+dOJK9hSPe6Xq027hT
         N+F7ALGJdtEuZj+BJHd1lX+ud21Ma2UxwGUhgeb5EXLb8QaYTdONsk/BXBO9L0fgBLRz
         zpUb2Pq6v0i42HM/8vs6fWHdCypy6f9zIlp8Zp3uMYugYaDD4ZR4LsCVcOum45Hvxthy
         t/YAq7Whtl00KYylmIBKGxxc1OLtPdFiU+j8xCZR2D99/FbELpLnYdxFZLL+GntosVWK
         RQhQ==
X-Gm-Message-State: AC+VfDzuDqml+Hvszi+Vr4wwdlenjkC3UA9csCiucTQ9Vt+5HL6Raa0n
        wZzyjQM223mN+w1I69IMq3D9+2Kh/2Dd
X-Google-Smtp-Source: ACHHUZ5nAIUs8wh/8rmf2rg+uh74WEsY/tVD4MDCg1iDPt+S2qJ3542QGocRCmfWoN2bRaaTc/Ksro7WJbIY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:ab24:0:b0:b9a:65b0:b39 with SMTP id
 u33-20020a25ab24000000b00b9a65b00b39mr2753356ybi.10.1682746527295; Fri, 28
 Apr 2023 22:35:27 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:21 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-2-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 01/46] perf stat: Disable TopdownL1 on hybrid
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

Bugs with event parsing, event grouping and metrics causes the
TopdownL1 metricgroup to crash the perf command. Temporarily disable
the group if no events/metrics are spcecified.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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

