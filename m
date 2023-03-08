Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704886B15FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCHXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCHXAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE742D239C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:59:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l24-20020a25b318000000b007eba3f8e3baso257152ybj.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316391;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=GlrQtbldYu3k0DDu2d6TktZ7Zisi4Ti65+jhiOj2ThVz42pumT6W4JOSR46rVrNgNu
         czv/K1YZ45ptiohVtKfHKQX4NCEpfM/hVrF/zKj5lI0iZWmDwj3uh1NlWwbMOB5OWQpU
         35URPYb0xSx/Q5yeBRF9cHOHceFR8pS4putcy170tHUvJk2R++0yOtlczpOqHYFmw5PI
         jUtBdDRVdF3YsjQO9R3lboR2hIx4wfuNcEk8Izba6r40rz+Sny61nL/AQZPiOIr2g4ky
         rBucCcXwqRIKvU3MsPoddsWgy/MklLN9gucUxmxla3k43gjrTjunTLUEsDwDBhUTqKH0
         srEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316391;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=nPzoQv4O6SmIEBWYdm7zmlhAR2ekArgo5zC5FH2h2/PeQGfqYNJhMWmA53RhycXt5J
         qXYjsPupFrBUem5YzW6hkJ3T/pjqPAqHgXD2rdjGXFdUsEdeFAYKiRQp+PNgeIkYo/HN
         3+sWfEtkzEr8/wqCHgJ+D0ka48Pcp8B7hh0b7GnQDno9iQYjk02+f5A+gNYAyHJV2JDe
         UJ8iP10b7kgh4zxCdQGLdUzHRcHEmrC726bOvdNAZLQZ5jsnmtJjihVPyRAOzb8wpmRJ
         hfS9DbaKoVjqdt1XywnEF7rptmnhCsC++qQjbhVR4fNeXRxoJJeWEuETJae2XTz/mcmI
         tfqA==
X-Gm-Message-State: AO0yUKXdovuEfuMjgRLHdl+OuOpbjuq4Nn/GM5o5JzKxvBcVm3hXcISD
        Dd/YX4zNHlXkO3PsOb2uHmCDoKqizBLn
X-Google-Smtp-Source: AK7set/H+awlmY7U1lmpbmtoMOdaIIQvJl0gR0hCJ93z0iImqLD5HSaQIYaP1vL/hmVoCX3BQcQN8qKFrYBQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a5b:9c8:0:b0:a1a:ba40:9790 with SMTP id
 y8-20020a5b09c8000000b00a1aba409790mr3ybq.251.1678316391572; Wed, 08 Mar 2023
 14:59:51 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:05 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-5-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 04/11] perf stat: Modify the group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

