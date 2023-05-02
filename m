Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FAF6F4D03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjEBWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjEBWlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:41:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46BC3A98
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:41:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso5496584276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067275; x=1685659275;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6Qd+fJp/raw+o0EdprpNNrlfsXq40MPV/2YI8RBqA=;
        b=3VydHCm3HgLmx6zItjD+1wFhHOgcny1QSRaN3JIELmw2g1+8kUo1PNF2GtCA4vzcB7
         XZ4D97vkLvkwLYfW99cCITs05raM8q4aKas0B6aBoFngrecoVIdqsQm3OxyxbEM4avbo
         95oI8DfQkLA89kdERL9rh3AzfWNVbsPTAO78TAt5Qw2W4FmqRDJNmUWGRuaZ1GQ8FhLL
         D2pvTp5E1oLMLMEL83qdXu33mzrJ0uG/UlHRH6kPBDHpMH/4TytLwno+eKUGUJm/l0Iw
         PsW6Y9UhDutNVlGl9HcghLFy53aFt4qUb8Ey0yMuPBohy93WaJJw/Wmo2+wS1dGLA6dF
         6Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067275; x=1685659275;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6Qd+fJp/raw+o0EdprpNNrlfsXq40MPV/2YI8RBqA=;
        b=hX25eiwIsb0D3bsXvlzbJ13iKlrCbpOzwzzejdYG7HkS0MZN2uobHiUDW2INbxi4EJ
         vqM6EJAyfB0jhr4B7Aqc+MxQ3CTOy058lr6K/MIvWnqvfl7YsRuuXjzYO0DzYg3c1K2b
         qP59JtzIsV/1cm2COL2LTL+VknSQbA86QoaSnROyyCMvYbCNs5P9zlPjWADwtCeViaUD
         sR9nBmUkgIbOCeJP2IsZeEIhTsOSZejD2Q0Pt4NCU2eyU7KT0seuLSwbPzJSCN9hov0L
         31d0sQlii3svsRHQxN9eua1YJ+VdqF3SsFPK2FZVQBxqd7Fl8jZ+gP+FHAdGj5zUWzVP
         hiEA==
X-Gm-Message-State: AC+VfDzz2Ylqh5Pzt/hUrlSThBP/vK6Y/4zPCFDmcdnuV/i2DLVbP0lV
        ry06ytKgRmg6XpPQFxByQzxjB23m4pAz
X-Google-Smtp-Source: ACHHUZ6/hhd6yEUy1giaHBhk/Dt9KBSzPepqdFaaTHsd+AwHkMOfSYDqQVzXja176m6G5LOonb3Z4bUJc/fF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:584:0:b0:b9e:5d82:f542 with SMTP id
 126-20020a250584000000b00b9e5d82f542mr2875249ybf.5.1683067275451; Tue, 02 May
 2023 15:41:15 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:23 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-17-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 16/44] perf parse-events: Set pmu_name whenever a pmu is given
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
index 707c53f1be09..9cb5f040a74c 100644
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

