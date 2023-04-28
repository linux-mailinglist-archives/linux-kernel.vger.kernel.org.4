Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC16F1294
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbjD1Hln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjD1HlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:41:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809D459FD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555d93630e7so134793917b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667647; x=1685259647;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbXUvllmN6lOIJh0HhCJsy55EV0m+rfCvLXAqUgmSBg=;
        b=D42i6N3+ccjH//e1G3S+nF9vNelVkHZvTAnroVPYLg6f6oGAymGZcwbwtWkeyec8UF
         q2hHXqvwVX6gzkQOhSvlryw0rMOiM/mJDM/yIn4uv7Htp9JZo08adKGAJ/F08kq8Oaoa
         ihSRZ9DuwJ+s6W4pEMznJeosp6XdGDM+u+15V3FAxMM+CmewhEFIY8HkGBGCzvqsvod+
         0fCYpKj7KkLfjoFkCBj73mxJb3XSIS8b1k4qFyI2emc8BGg1BblQa9QUGD9kY5V5wfgY
         wiFJL49+LRXWckeA9Wnex2aP+UlYkq3RxOn2rT5C46b1h1l4pPQRPE3fww9xjVnZGrro
         hoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667647; x=1685259647;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbXUvllmN6lOIJh0HhCJsy55EV0m+rfCvLXAqUgmSBg=;
        b=CWad3lBWWfNophqlKLLTWhQ/WJhb9LKXB2RfxuPoze1dRVgwUIu7+WMRS4yh4GqqT3
         dwxLaIhJVfFDiiLXGPO9M8BTlBaNVb+PdvDGVUA8nHp5FWL0smD5oRTonR4dZEH8PaY7
         RBWr6AhsOYIJN9Ci6QY4G6eqmQSCiEhv4APD42ZsHOhkupdpCTE7m2f6ivYwYhqjMNY+
         pxvsl7P1qeEFc514dp/QCKQlSqB9GmzFxiVChoK7QnAwDbna7a1ktaH5ticNSD8FGFaf
         Mi0kuHbeozuykOb89gYETG0wQHqnpYFC5S6L76GgFxo5iDoTveJWH68x7itK40Zz+u7t
         XSsQ==
X-Gm-Message-State: AC+VfDzSlicv31ZTu2Tmf9LB19eouGbAtVClP85ezThi4Mb04HY8l7Ws
        XYRBdtcrQRAsZGlpHPfO7pFbMkuGq+vy
X-Google-Smtp-Source: ACHHUZ71V9pkhdG7rcKIlESdiUEMEYUnhW0I3qGE6myj2T+rXemGxA2EA5SlXnqh7+gfUSEEx5BdhMtG+G2r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:690c:725:b0:556:d398:8714 with SMTP id
 bt5-20020a05690c072500b00556d3988714mr2607081ywb.0.1682667647450; Fri, 28 Apr
 2023 00:40:47 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:42 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-17-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 16/43] perf parse-events: Set pmu_name whenever a pmu is given
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

Change add_event to always set pmu_name when possible as not all code
checks both pmu->name and evsel->pmu_name, for example,
uniquify_counter in stat-display.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4ba01577618e..5ade1cc8851d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -269,6 +269,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
+	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -1500,12 +1501,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
 				    /*cpu_list=*/NULL);
-		if (evsel) {
-			evsel->pmu_name = name ? strdup(name) : NULL;
-			return 0;
-		} else {
-			return -ENOMEM;
-		}
+		return evsel ? 0 : -ENOMEM;
 	}
 
 	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
@@ -1561,7 +1557,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (evsel->name)
 		evsel->use_config_name = true;
 
-	evsel->pmu_name = name ? strdup(name) : NULL;
 	evsel->percore = config_term_percore(&evsel->config_terms);
 
 	if (parse_state->fake_pmu)
-- 
2.40.1.495.gc816e09b53d-goog

