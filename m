Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005BF6F12BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbjD1HrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjD1Hqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:46:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F286E94
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:45:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b99ef860a40so8162852276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667856; x=1685259856;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=LLfkDBC7PedxnCQkXPoSOiduwH5AF3j3Hikp4aA/7DD4cM03ZQ9eeqF6K6CORBawQ0
         OiRWNKbT4HZd0Di99topSMclU83fSyBWdqFVUmXUY2uQfVpRi3qsnjrQxIl76fj1wg8F
         O7qAr9LNFMwMQzXhXD6qlvsk6nuuX8M7xqtCuVdkqLKWAgm3BJhT3r2p2S153Q8yQso+
         jodFj9QwDezg2nl2XYQYaeRr53tVilWTSpe8RcZrPVAnggOZ7Lywh3EQlp0mtx05XI+x
         AaTcqKQ1IFdU2K0xUiEp4HnBzKamNMtY+V6P7Nvx9rwL5GZOfHVqSj7XST2kp3VzL1Q4
         5NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667856; x=1685259856;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=bJzKHnAyvUoSXV/g2WRRezvM3UANBJJzk4+sk6bOcbnbE8QM5JBUFxJpTuu7g3JZ9D
         eqKZx0dYHMg/yMwjYARXCZy801PO33pnQHE/tg/i51LfKNYXMrB4Eu7tVIvajEr0SUJ5
         yojepQKjTAJg0krNTfZgAQOjdYzZAfuF2abugEg6cZnJvN0qRVCggypLomKu0fzkzHkM
         Scq5WLU7Sg/ishGx7fh1Vl3LZi0h3i9DeHN2XDtXTVWly1GN2vbkSXVItrG1l1Xq+Ech
         uIGOV/WU0TQweL/Mt/+9TtDOhBtvzv8ULsW1+cwXkwUuL7DNbtNhihw3uVVBEASKU1+L
         iK3g==
X-Gm-Message-State: AC+VfDwuqy1oSnV/VgDcWOUvHWZnG+Pr7NBeEKMnLlF9uHZSJDr1XUpv
        lTBtlfLqm4j4mLRO6qqkGlT/FNwFwlyB
X-Google-Smtp-Source: ACHHUZ4ZAIabklG4DQKE6HxUzEczGncaQD/83/qMjGwJet9u0/pQ7v2CcifHVbig50qNbhcqmYU5J+j0HNRG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:24d4:0:b0:b8f:53a2:a34f with SMTP id
 k203-20020a2524d4000000b00b8f53a2a34fmr1567466ybk.3.1682667855565; Fri, 28
 Apr 2023 00:44:15 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:08 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-43-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 42/43] perf stat: Don't disable TopdownL1 metric on hybrid
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

