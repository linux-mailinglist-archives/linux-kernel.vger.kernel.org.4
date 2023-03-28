Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174F6CCE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC1XmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjC1XmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:42:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A5A1FE2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:41:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5416d3a321eso136992567b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680046916;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/SOJzwszuK4oXlHtoTT/8rLoX+FLi6BZsrzcBCEAsAI=;
        b=XsmKZlCFkNQsFlUwJu6hXd5IS6qS1B/ZMp6kn/1IDeJ7CZVUm1LwibD6gkVVl2F9fe
         Gc7Gdih33kyxSxvuw1SdMHS8knhZVJ6jx2rAS5qloJkHRa70HYTQ8yDACXj7J4mSE+B3
         WPFBSnNT2t8t3fY6QmIzYNQY6NjjXF4RZZa3WGoBQNAnL07e727AsjE3KVd8Q16SMXLq
         G+h80/Es90S+Wen7zqYABysuKe5A3uUpWyuOjeTX+M1RaTb1r4kmgHKjLK2Umv5Fycgi
         PD5KNVbfvkFejqGPxA832UlTr4zbDyRGPJn/Fukwsds52dl8XPvf/3w/I1GbTQkg5a+Q
         ztFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680046916;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SOJzwszuK4oXlHtoTT/8rLoX+FLi6BZsrzcBCEAsAI=;
        b=kDQ9nutJn4eVnLYeZ+HM1k1lsbR4AaAHz86Lms1+dQoMld/QEyOOVKujOs/qrckDp2
         g4pgYZhTWKMLC38ia2nU2Qrek8yv7Mcs19W8VxquL6qkaWIqJBZ0l9vTCiBQYyiL4lK9
         VOsqEHtR/p6VNL3dQ5wpPQfgE74VM2VCt55q38UyjKPYe5jw4NIhp2It/HhjHHjf2Cvo
         DeKIdRLqLWzBS58PLOFkUwa0nh1+/x/2iKVobkLCir8R6cOU5mzcBNZgHbTbApe8ip3G
         gXtTovC0agYaUTh2ZzR6CDDw4XcytZ2k92iNbgq8hXXyAGIf406k9IkQu+Sw73PkAKFV
         us7A==
X-Gm-Message-State: AAQBX9cV7OfLbe/aAHcFMgY054BoZHMRXP5Ti8d2UZ3vMJOEldplCX8S
        HVognhuLYhBY0o9FpdJygJ7+wXSZnHfN
X-Google-Smtp-Source: AKy350Y6rfpfUk90+x61rAFYwxjj4dzqwGEWuwh63ONPFHCeJrWJH8BFOkPPu5uiEBUywjbzS3P1aMBiH6FG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a05:6902:18cd:b0:b78:45fd:5f01 with SMTP
 id ck13-20020a05690218cd00b00b7845fd5f01mr10193380ybb.7.1680046915938; Tue,
 28 Mar 2023 16:41:55 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:41:42 -0700
Message-Id: <20230328234142.1080045-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1] perf vendor events intel: Update ivybridge and ivytown
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to versions 24 and 23 respectively. Adds the event
BR_MISP_EXEC.INDIRECT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json | 8 ++++++++
 tools/perf/pmu-events/arch/x86/ivytown/pipeline.json   | 8 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv             | 4 ++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index d1e64e0d683e..30a3da9cd22b 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -215,6 +215,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
index d1e64e0d683e..30a3da9cd22b 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
@@ -215,6 +215,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 41d755d570e6..97b3ffc284a6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -14,8 +14,8 @@ GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
-GenuineIntel-6-3A,v23,ivybridge,core
-GenuineIntel-6-3E,v22,ivytown,core
+GenuineIntel-6-3A,v24,ivybridge,core
+GenuineIntel-6-3E,v23,ivytown,core
 GenuineIntel-6-2D,v23,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
-- 
2.40.0.348.gf938b09366-goog

