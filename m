Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC136A7A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCBEMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCBEMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:12:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA924AFD9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:12:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 66-20020a250245000000b00a53c1100d72so2754718ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 20:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730363;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HlToJfehRhwifEwaYoS40OI/SsPSnYmXMj6fUkz2Ls=;
        b=qevYgswAKLTMJHEpZ1D1rEx/wavZ8kB2WNYP1lCXw7WBpA/nHbKIZmNSPWC5ob4DhT
         7k0KxAShaTJ0mwzvG4+i02UJBYmj3XZd3TsitdcsrP90PomolW/s/Y83V0G+ZDuBh17F
         f78faMJJN1lWF4bzwdBtmeqxtDMrxn4iH3Mz26EZKZnYYyKHx5iaTdsBtRR2zABdiCAp
         qG+tHXcvei5IJNJBmGJlTkfoiQ9i8/DhuB0cSa9GRLJJOBDNHdBUvZ8sTyH5hMRQAsKR
         UKZLkeojPJAr/7Rv9h7xHt6ErpJHb60esoMn4Mcja/SYSXOxysgXYSC8ASWEXi1xzWU1
         Ig9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730363;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HlToJfehRhwifEwaYoS40OI/SsPSnYmXMj6fUkz2Ls=;
        b=etgslwY2vJg00Czr/fzQ363MYjFVcIwQkezGk2Q8pU2V9fD2rYN8sg+aYtgO9NEMbw
         jmHAqWXsPQl0LV6s5ZyiM7grKDhwqjH+e8soVGiLGZCwLgPEg4bw9f7AZtc7kwIGEwGE
         AgrnTeqIXuVD/ICzPTtdMypwUW7SRZDXgtDcufCT2GuLe93V75oscxqQh5DskWaGpxjQ
         WMM6+Fda7MsfBsn5zb2dH4QJ4cO0yM8B5//V2d76Jojr7LZYgM34kMxRtl5b1Rp7HhHw
         1EpE4GHWQDxwiJCTunkVtmIC1p9aiZsbier64CA8cYgrrT2l1SzBIGT866Am1YZMvV1+
         o1ZA==
X-Gm-Message-State: AO0yUKVJLy7RZ/NHvkZ4PB0imh0EE27saf0V8IEBTIV/hCbmdFEZpWVn
        pxbTfIJb3AtlCcrYY5YOY1cpdtT0Vtqx
X-Google-Smtp-Source: AK7set++5gPppZpZoeoSdEk4o80WCpbyfqtkcyaNbCceeKcnZ863H2evX2BEcZlXwVMLNoOn7FpEduuP4Gea
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a5b:98d:0:b0:a59:4709:c785 with SMTP id
 c13-20020a5b098d000000b00a594709c785mr13ybq.678.1677730362957; Wed, 01 Mar
 2023 20:12:42 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:02 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-2-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 01/10] libperf evlist: Avoid a use of evsel idx
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.39.2.722.g9855ee24e9-goog

