Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50E7132FA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjE0HY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjE0HYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC63E7E
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-3f6c4674e3cso23912411cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172194; x=1687764194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKlpZwIe+ZNMqSgCu8evjP4rcM8k5wR/kLw9LO8buYU=;
        b=lsZLeHt5sAbeY7UZ0KeCF7oCQNqze4XVDBB51YNyFTPseP/6U28Jwpu8SY0CwhLDSE
         tpa1XII3YpCbwOoh5Fd2BOD9GyUYKW6Ah+AAOJe135CVOsm3rIMB1/wos/3d8ThA0qMG
         qsd8FS901G/nV5YGFGGQ2c+4WTJ4ryArpyEFOsbity3IhAoXt5GpH1u4UFN8D0JJbZIz
         htK0BYRY+UBSxNMFyx4AMvxubhvRCgpuXJmxqHeTw5joUCq0I+tZsm00WBMn115McmCv
         AcikFFlGivB2xbjVmYPVvBWful9CtaV+bCdtGbzI+1/tWQByYgVy6lzpp3YT1VdUR3Ve
         xrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172194; x=1687764194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKlpZwIe+ZNMqSgCu8evjP4rcM8k5wR/kLw9LO8buYU=;
        b=Ms0XgPUHWQa5dAACHIAswXcDQUtgD+0QWi0Yks2TwF6Yv7DFbQmFhXuektPd8qHnds
         DvDUDYPtymIODQLMyZD8qX7myFwc1WKWNmkw2jr+aIUQkSYidPMyRLEZgYyyjfPt3KIw
         GfrFIxbHHziadkGoU0kAGqd+Ps2CxQyMvBp+2DRQPjBsg2apr9uR1sFyUCjHPEsfhSY1
         mgVNOGvIswiw7pkEZYwdJ/rIE4eGQAXgciRV82pibnT3Qqmm7kwGfvkJ5oQsZ8GcvnBm
         W9UT3OMr2uUZEL9Eqi3cucQT9hf7HoDZU19cixeF86fw3T/wOFG79ExEya1l7bTKoWcH
         TS1g==
X-Gm-Message-State: AC+VfDw3VEbz9HYIHNxG5Zn1ADklMFT8gwFee1fr3Dhtr9R/x2EBn7e6
        CjhjMERIDHStHN8kvg9rnMt6nNYXyBaR
X-Google-Smtp-Source: ACHHUZ4jekes7nIRnkxzUdy4DbvGJAqgfFnphibXKR3KuIyMq02R8j6YRDjQghdmNBvBIuDqp/vlPDxErrXl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:a989:0:b0:552:b607:634b with SMTP id
 g131-20020a81a989000000b00552b607634bmr2512177ywh.4.1685172173971; Sat, 27
 May 2023 00:22:53 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:45 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-10-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 09/34] perf evlist: Allow has_user_cpus to be set on hybrid
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CPU map propagation only sets valid CPUs for core PMUs, there
is no reason to disable "has_user_cpus" for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a0504316b06f..2e2c3509bec3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
+	evlist->core.has_user_cpus = !!target->cpu_list;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

