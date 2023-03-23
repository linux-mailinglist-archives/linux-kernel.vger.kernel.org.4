Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EBD6C7101
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjCWTWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCWTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7F1E2A9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5417f156cb9so230466057b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599294;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+twZgD2lANnEj4Ejgw/Tmpo0NzizDYZveDuYYTFvBkQ=;
        b=DOLfyLdfXIIJboU8zkl6Uhv2DoOuJI7tOmholFicsh5wHtqPfHBoa4d/ksaQZ4UpZX
         0Ev8jrFOmVtp7YhsQdV9BHyssb4h1LrsqfMVJDUD8lg9Oo+8pCZssHgEnNAjDxZhZ0wP
         555bUqffvW2GDA+AXwxnpF/XJAB9zHUGgOTS9L9GKnqu8ZQhl1/hXf5lzv6TiXYKcs5v
         qLOwjbPkhgcSb+9G5g3Sn6KV53JpIz/EnMJp5CUmlYfmgXbjtzGrK8IzLmmG158kQxjk
         VWfqj+7HlJ9BIg0Jkp6HeprNltgm7EOSmmVdDc9NL08qGBUNIIB3zEqVuPrXsSRWYqbG
         FKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599294;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+twZgD2lANnEj4Ejgw/Tmpo0NzizDYZveDuYYTFvBkQ=;
        b=UN2dVGnzBo31qwVdzxIzg0rLlRWHBHesdh/OeFgpE85f7J5JeGqLbUk23jrCYCAt48
         zFRfa62GuCpnTcv01CfwPjT/pdEh9kJTKYmLIU12n13Myg9to/dp+OLQcwXEClBMSWZk
         Vq8S3Lf2vTUcT58NomTF38JZKoaPMRVxZTGu53xcKNwFA0U6d1KUcua0F8UlyQPIAF/i
         PMBei115LXm+JG+nhumaCjbS1AUR+pucKcvlP1eVLtXeScVn/08GgP12UrFx3tMWSnad
         gDDBZxSp+wGMxby+CNU7ihGrf3VnackED+kNewVVfnMWAO+OhTQsi4UVowp6+o0Mmcxz
         EDZQ==
X-Gm-Message-State: AAQBX9e8ydgUaLWQHN+oeCNrz/z5iI60REZwctlXA5YuHzMbJjseOwhM
        nnYnCEEgwv42topiTU4V979/vUWKGCrB
X-Google-Smtp-Source: AKy350YAsxyhvHlQHOGw0WgC47yvbSzbSDYgNoOHhjZ7NRm+hmzKEIv3YnQvdG7T6KSoQ5hl/QSBOAY1lj93
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a25:f407:0:b0:b6d:1483:bc18 with SMTP id
 q7-20020a25f407000000b00b6d1483bc18mr2938380ybd.7.1679599294516; Thu, 23 Mar
 2023 12:21:34 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:26 -0700
In-Reply-To: <20230323192028.135759-1-irogers@google.com>
Message-Id: <20230323192028.135759-8-irogers@google.com>
Mime-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 7/9] perf vendor events: Sandybridge v19 events
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
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
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

Adds BR_MISP_EXEC.INDIRECT event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv               | 2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e41c289fa427..41d755d570e6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
-GenuineIntel-6-2A,v18,sandybridge,core
+GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 54454e5e262c..ecaf94ccc9c7 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -210,6 +210,14 @@
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
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches.",
         "EventCode": "0x89",
-- 
2.40.0.348.gf938b09366-goog

