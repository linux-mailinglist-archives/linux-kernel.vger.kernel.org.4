Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19216B00B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCHISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCHIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:18:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD944A1D9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:18:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso17247996ybe.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263498;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=pxEIKL3PPwlLN25TpuV0eautgYwV0o0aW2grlqQeTcfwjmIZQil6pJYUPMEAxU4Srb
         7+OwVGY8HDpmBsBFFS+oKiq/0OnJFSw3yr+fvEmx9wepn6Q1dHpQdhJpbeK8gd9PVEHK
         4FBPWrwDUUadtk0Gdf3tDQ5Ed66djl1JBTDVZxfvgA4m504KL7o9Ra8UxQIuntd+6DlH
         n5XFdEsf43PQ7RZhOnb6wys4naGaG31RZel3b39NTMP6PcWfVhy7V7ay9lC06kgXCsPt
         pgrINEKblHASyMrd53gusCR6hN9faCsRSq43QRhNT9OJKncHrUeoxMP+H1ZNWZhsUpSK
         6ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263498;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=OKSrv4+E7G7I5gyDILg5gdSh6VewsfLTJIUpYSdqbGexc11IwAfLOIoCThP2clZVwS
         6jm8TzkugUQ/9wvNGZ2zn6vXf4th82x/ZgAXCzy54ztFo59vuhFMqDjI0Q0GavyrIJKH
         c1rhvrVfWKTFgkxP+tRNBb0ZvXdcGAcFwCKQN8IQwx8szLvFuaEh0EgWA2DL2vdk9aTB
         bgud048+NHTzQckePF32FblBBgWO1HfHBpxjdfEgCA7l9IYH2FoGdM/41O3rpROKACon
         lc2/nCx+5pvu8mPx4/nIgIeuIFgotm0PYYBiJ3wuNBMWUEct8Msj4wJ+jilzbIdqLkzJ
         RjrA==
X-Gm-Message-State: AO0yUKX2roXsDB2BawYDatEE5BpmLRZZPqQS/13Rklgeug/GneB+r14J
        5QLR8TTEGHzjr1cml/Te1N0eVeBPev9l
X-Google-Smtp-Source: AK7set+9O9Wk5BTCkRajxDbon6ycn1pAYNIVG/NGlctTUcdXrjn2qjwP6WpHtNlyYFMb9Y/pOgb8vp5bjVOq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:c0b:0:b0:80b:4f92:1623 with SMTP id
 f11-20020a5b0c0b000000b0080b4f921623mr6ybq.370.1678263498380; Wed, 08 Mar
 2023 00:18:18 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:24 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-5-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 04/11] perf stat: Modify the group test
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

