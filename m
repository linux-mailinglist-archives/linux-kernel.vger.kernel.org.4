Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1D6A8B52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCBV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCBV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:56:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F55D457
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:56:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a5a0b6e3so4161507b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677794177;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=STUCW2gWCheT4kjcqAtawNvWVMVPKCuiUgda3XMABvovl8zbU9GDaLL/KP6CP1833R
         Bdr9f7yUo7HUGuyZPS/MQofVjfG40EHrlPEhvTwkIoveD6zxOrcczyjdAtgFpbngNUnQ
         hDRDIVoPwgaf0wdKhG1MaD/MPrHhqhd5JQ/Dgz+Ew/pCHl+jMMS0faHQ5mc9MpkZy+eH
         e3h2XO6OY4tutXUw3ob1pRexWvzCy4Hxh7WlGnpeILRyGT/qrtqFIhk4Vo4NVUTpil+x
         W9hNbLmMMi2hxCvIIYBQHyR6Hw+/F/ytQBGHGrvo57gw6c+rwPQwQYMDkgdo4RB2uQod
         jo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794177;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=SdAy+GltYQCKM4Sy+n+y4JQIGbcuWwLRdNRafeC/49GfSm8bvv0sPZV/d/1zscLU22
         V3FcQEff0ea0HWtW4UMmbKtHQbMhcpbeGc8M9diYD44lxrtebyI6Osd9kyegjote5w+V
         hQ91phP10p/fa7cQBFyG9LUgVSMepcb394Ve7WI/seEM0EgUXmm0Pe506dt+JlgW3Jxv
         UEkDlRXnGvHFNs4h1GBq9V1+vAVrY8evbLI6iZe3cnLPLSA72k5YfC3DzGJnZOhIJPz8
         xGVlyMh8N41iT4Rndl6bm8idigG3GDkIc7oXEXbNT+M4qo/D21A3GR685azgm2Y2zTbs
         pUpQ==
X-Gm-Message-State: AO0yUKWSdNuwbafyFuk5Ez42bXQva+O1hXElZ48yYdt2Jvn7QQd2AVw5
        EeNTVTZV1c7Ag8l0R+eB6aXzuwt+PxzU
X-Google-Smtp-Source: AK7set+rCgX2CZtYsyNOpnPcTnPyatlq0OsTFID9T30qC/qUpHHpo3m0ptqs2gLK4HuXN1OA8yF0VE8ih5Ah
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a81:8414:0:b0:52f:1c60:923 with SMTP id
 u20-20020a818414000000b0052f1c600923mr25ywf.149.1677792356226; Thu, 02 Mar
 2023 13:25:56 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:22 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-2-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 01/10] libperf evlist: Avoid a use of evsel idx
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

Setting the leader iterates the list, so rather than use idx (which
may be changed through list reordering) just count the elements and
set afterwards.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 61b637f29b82..2d6121e89ccb 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -687,15 +687,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 
 void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *first, *last, *evsel;
-
-	first = list_first_entry(list, struct perf_evsel, node);
-	last = list_last_entry(list, struct perf_evsel, node);
-
-	leader->nr_members = last->idx - first->idx + 1;
+	struct perf_evsel *evsel;
+	int n = 0;
 
-	__perf_evlist__for_each_entry(list, evsel)
+	__perf_evlist__for_each_entry(list, evsel) {
 		evsel->leader = leader;
+		n++;
+	}
+	leader->nr_members = n;
 }
 
 void perf_evlist__set_leader(struct perf_evlist *evlist)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

