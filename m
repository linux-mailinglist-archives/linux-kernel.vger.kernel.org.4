Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12BC6A8B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCBWS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCBWSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:18:52 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C09EE1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:18:51 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id z5-20020a6b5c05000000b007447572f3f8so327234ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677795530;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=W+2xG7D+dZqUJ1WZDQJCtpRA9ITAxO7RSg/G+jVBFVMM0PgFMVfZi+WA78iFXOZuiH
         PaOnSKAHaXsm3puQ+b3wf9LpxqVKN1ykwwQc2XHQOgfbXrFr9Rv3LRsU2qdyX22f99Yh
         joaYML8N3uQovYrIiCxNRlDHiJWJlhChf4LTboRcGvM1Rk1X7C/TtA+iXrBWyIp/VvZ3
         qR4/Lvwkb7uh+HZn9WhwAVp0SZrm58mJzdO8Mm6i0hUFCTwUoFCyb8cz2bj7w24ddAFt
         sjeRE9Q5uQA2dEQG+S0gDnAFdys6JFnPFwx8uRg55hYCU+FgF0fj+5D9TYerLgdaGEB3
         ODlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795530;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=4QBARcdZmUvVK2tj0O2ciBvW1ks3DN9Nc5u3xjWvRw9iUjsGvau0MDZzpFH4SCT2kj
         dY7uSgc10366lMDNHSyBs4Y82K+526cYiDJwh4xtWH4gRDPm8zFUfNztDKdiQMF6rKI5
         Di0ArBrBUXyOoLIhkScAN3XNr8hBlFjZfXRX0B5bXPR2vvRjn/bU95gDKqOhQJ/jRo3R
         EQDgD2ArbomqdPx39l4Dq7spA9g/RyRVzqKp9A0tA1gzmcWEVHjfhkAuMPdEbWhUGVsm
         z8PrElqIX8qhrj8W30APCf4so3EstvL2x/3S6C72nIcBpzj6n2wGQlKOpPS8i4rbP6jl
         GziA==
X-Gm-Message-State: AO0yUKVl9Zv7s7HveBj71qPSPPpfeuYeM/EN4INTuQmZgkrGLN9OkQGd
        LEp01F3mCZduYGiPiRXiXtbIdNJgQmY8
X-Google-Smtp-Source: AK7set/VsA1HeM14pe/4lFMqpkMj6EPzo21Zf4W04XTdb1j3BgpGJ06CGU154fyiO+ld8pTCysXaZZgkXxmf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a5b:1cf:0:b0:a43:52fe:c36f with SMTP id
 f15-20020a5b01cf000000b00a4352fec36fmr5200622ybp.7.1677792379741; Thu, 02 Mar
 2023 13:26:19 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:25 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-5-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 04/10] perf stat: Modify the group test
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

Currently nr_members is 0 for an event with no group, however, they
are always a leader of their own group. A later change will make that
count 1 because the event is its own leader. Make the find_stat logic
consistent with this, an improvement suggested by Namhyung Kim.

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
2.40.0.rc0.216.gc4246ad0f0-goog

