Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EC6A7A52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCBENa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCBENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA173D90F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:13:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaeceeaso300758387b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 20:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730387;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bygd021PGnvtCwZIuzbnz2JBaDd2eMkon8HHUjvbNBU=;
        b=jwsnSTAptQEZ+jP/eZLmspl0xIsJe4Ftvxsrx2655NshVyHk0nvMJKzqMAO8uwAaMZ
         YzXH5j+Ry0qbX5IAelfZwag959M0gTt5sGJD5Aj5jrgw37YgWNbr7caJTaBDd7eqV9F2
         y0BsqnWBqjdsG4+BCUxegbg4m973P4Y6F0qKWSi7DHy8+MuYeySbMMDiTRU4XMgvHRnR
         eShvW3gMcn8ngmfCIU2lNn2KKlFboCHFpEIkaC/W7E82xpYRNvsUTxunVgypc/EsWL7K
         jNgXtro+oTpJ7KFtu0/EBQ8/bT7bLQBfvDOsq/lQbKeAitZgMbHNqKYFQp5Jgl2sDosN
         inMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730387;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bygd021PGnvtCwZIuzbnz2JBaDd2eMkon8HHUjvbNBU=;
        b=PI+zZVrZzU9iFI1Kv5kag7/7rLU63RT6pYYO1dQjRMQba99gybBD/CjzK5iMRm/6CA
         hrC+aSwdmSfPe2Ui38wlcrJQWKNVCZMKFipdZ9EJ0GYlz1nbE1QaRIANNeF5a9U71Dd6
         /YsrTEeBsGQCWkKiJLyEmQUPAJZy+AKdRlWFlbYvxBV0I5NiNL31QZVLuFpy+G+PyAce
         belHfzUvtImQ0n+hNfksIi5NVVn5UnPayI0yqGKOWTognWj2clPj8Y0R3CFQnh19hn1/
         C4m/Y5KUgs60vuX1/7AxdlWE8IdN9STsHDflUNxMxEpxVOUo/CqO87v/u/7fzvyWj6NA
         B7cg==
X-Gm-Message-State: AO0yUKWCCNYUznYvuSKyTzX8dmWrfi3Hi0ceoumNIRb24GUWXJ7q6AUJ
        IMqgcMKcOsTac0XIO7DwziEAEZ6nNxvD
X-Google-Smtp-Source: AK7set8ZRO97weMI9CFo55ZrmML4Et9B8NSn12aowt3uVaG5LbWQaCuScUZqbYkLJuNweLexj7al8jzVkKYw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d1:b0:ab8:1ed9:cfd2 with SMTP id
 v17-20020a05690204d100b00ab81ed9cfd2mr3932135ybs.5.1677730387009; Wed, 01 Mar
 2023 20:13:07 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:05 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-5-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 04/10] perf stat: Modify the group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously nr_members would be 0 for an event with no group. The
previous change made that count 1, the event is its own leader without
a group. Make the find_stat logic consistent with this, an improvement
suggested by Namhyung Kim.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ef85f1ae1ab2..eeccab6751d7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -163,7 +163,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 			continue;
 
 		/* Ignore evsels that are part of different groups. */
-		if (evsel->core.leader->nr_members &&
+		if (evsel->core.leader->nr_members > 1 &&
 		    evsel->core.leader != cur->core.leader)
 			continue;
 		/* Ignore evsels with mismatched modifiers. */
-- 
2.39.2.722.g9855ee24e9-goog

