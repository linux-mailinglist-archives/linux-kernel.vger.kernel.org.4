Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47A7402EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF0SLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjF0SKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC3297B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-570553a18deso67314877b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889453; x=1690481453;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=ic/uUxLDADiZsinLV836FUMBjwA4clCXnO3zJoz5EXIbi1vzujUI7YnlBalxEbY6Jr
         oqhuE44GRUbA4YFRItPjtnPNSZuGMpJY9cWyu337SnIqlkVYBY5tkzuNXyemUTtSYVHt
         cNI7pK1ELHaNon/Rt/uVBWz7LE0T5sn3ehHrsxsszZdh281296bZCIqTty4DYVCxyiCC
         uNP6M/icy39rmPwQ6ZT3VPDbg6zPgPf2Mb48GH+v+ZQBFpzujICXAoMqvkgqEy7yfEXc
         o+tAAOK4eg4U6a5bS/MlqRtXVyGY08LppDGk/vKjm904GInymr/HLFPu4RcwYJYP8A36
         9bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889453; x=1690481453;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=InIaZLAopSu6E8iPEcLcEACXGz5X8KSLlxDwg+NQIJwdeQ0uD+wxMVfN3Z2LSFEMkm
         SC8buVJ54Plfcv91iW65gq+z0+6HVCEI6hnrMd7KJ36r9OsnjRJpWe41QpZNSW5z3kc8
         gxxyXme/5pZ7M8QYpIYSVun3oj4qa5aLS+sfQz+7Cq7darCIXARe4ox/VAU9JUXr/70J
         inY8nr7BJoatbviB6fuwX12mPy62ozg51TOaor3cKtjFAGPrgEzoDB8CNjMe4kzbBeio
         QdQz17+jyjNyyBfnVCMgBOPZgkLcOrnQiLhSYYeVOH4YR8ZrGyNWc+6beBT4A3x3aPxG
         cUkg==
X-Gm-Message-State: AC+VfDwmsGW/LX6wKGlZ9jEEbSkuL93tmEQGmdqkSZSgMOZoEUX3ZAbN
        OIrWWgT94hm7jq/xPbD6IzolTGm+U+sE
X-Google-Smtp-Source: ACHHUZ7WMEj53/YOTC5fQeFqG+pKB8WUM8Wqp5CfW3X6NRJuJ5eUfxUuqqXvmD68sSI7ABQ2xhJFPv4Y3STK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:441b:0:b0:576:b244:5a4e with SMTP id
 r27-20020a81441b000000b00576b2445a4emr3880646ywa.10.1687889453097; Tue, 27
 Jun 2023 11:10:53 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:22 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-6-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 05/13] perf parse-events: Avoid regrouped warning for wild
 card events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

There is logic to avoid printing the regrouping warning for wild card
PMUs, this logic also needs to apply for wild card events.

Before:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

          2,979.16 MiB  data_read
            410.26 MiB  data_write

       1.001541923 seconds time elapsed
```
After:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1

 Performance counter stats for 'system wide':

          2,975.94 MiB  data_read
            432.05 MiB  data_write

       1.001119499 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..0aa4308edb6c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1722,6 +1722,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 							  auto_merge_stats)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
+					parse_state->wild_card_pmus = true;
 					ok++;
 				}
 				parse_events_terms__delete(orig_head);
-- 
2.41.0.162.gfafddb0af9-goog

