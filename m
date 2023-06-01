Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6169271959F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjFAIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFAIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:30:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB812F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:30:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b238ee8so838834276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685608211; x=1688200211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2W+D3X61SHji5TdcPTT7aQE7+SKMk9nGQHSrp9XR3js=;
        b=hFIvLmGP3lv7GenwMucp7vgjD92bKKVaKTHzPrnD0d5s2WVEN+JDM4TmLgr1bPgKy1
         7IjnHzCWR6v9OjFGON+bq8ILrk/5KyCBmclQhLXrjVcmxKksBw33B/w3G3YtehGwyaj3
         5/pvgPkxiT739fYEk0zq8KuyIg12SXt8xRW9V5bkDXq5ArJu4hDz5dWZ1Bl4h0B3k57p
         7GS5yHSKPem6KDK8XLnNVHoyQUcPiURYWAAjWIYExIORyP4qYAGBSnKVmox7VGE0fPBP
         DE1oiy1aDLl5M4KG/5VKbR3FkAy3/+uVJYIumaGGr64vDXs5m6FB4mAlnbGkms9glEKs
         +ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608211; x=1688200211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W+D3X61SHji5TdcPTT7aQE7+SKMk9nGQHSrp9XR3js=;
        b=NU202zsx3gmJ7N3WJbpwCrYIhBFGq1kWr9NbVJwc9Prhqphs80/vo9mK9GbizdtWaW
         fHeLIikoZRi7rBZhgvaWpYhfWsKRlrgPXNjAYqTJFnDKlAShikaaowubSxqIkm62jmuq
         FjqALbIrny/Z5q6zW6v32UETfRmfsw34dJi/iG+g6MPAnqcbV4SsfYaDrc42a2pqO70U
         4z4mb7d60BZL4wdMaXqGW+v2pCccYKy+wW0DGXF5BHQLSovkbGsOXtsmRzTQg3ULsMGZ
         53iKWIZH1V23lPR+g3Rc1UBqFru6w3FPykpI/qcWbm/hchisXSv2OO7TBNJnqE0A62Sc
         Xylg==
X-Gm-Message-State: AC+VfDzbeqUMKRiBvYodr977ytXy0y+l0Yk7JKyO5WMxgnF6VdeKYAHY
        z9gNy93FuMKnHjVvbVLdjJn/jtcpwjxu
X-Google-Smtp-Source: ACHHUZ4CtvHxqbmMlOebUnOkHAbQEfnmI2HybhjxUjmo0bcgbzA6MKi2iuDhUt8X/cL0NStkjLBjtimTjIwJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a05:6902:729:b0:bb1:445a:6f05 with SMTP id
 l9-20020a056902072900b00bb1445a6f05mr2517804ybt.4.1685608211098; Thu, 01 Jun
 2023 01:30:11 -0700 (PDT)
Date:   Thu,  1 Jun 2023 01:29:52 -0700
In-Reply-To: <20230601082954.754318-1-irogers@google.com>
Message-Id: <20230601082954.754318-3-irogers@google.com>
Mime-Version: 1.0
References: <20230601082954.754318-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 2/4] perf evsel: Add verbose 3 print of evsel name when opening
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
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
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

It is often useful to know not just the attribute and perf_event_open
details when opening an evsel, but also the evsel's name. Add this
debug output for verbose 3 so that it won't interfere with the current
verbose 2 output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 46da3f0bb47e..779bc2b574f4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2038,6 +2038,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 fallback_missing_features:
 	evsel__disable_missing_features(evsel);
 
+	pr_debug3("Opening: %s\n", evsel__name(evsel));
 	display_attr(&evsel->core.attr);
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
-- 
2.41.0.rc0.172.g3f132b7071-goog

