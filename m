Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F76C78C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCXHYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCXHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D449413509
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 185-20020a250ac2000000b00b6d0cdc8e3bso1082936ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+twZgD2lANnEj4Ejgw/Tmpo0NzizDYZveDuYYTFvBkQ=;
        b=SWvZOQZzGbL+4m830PxxQcYm/+IoASmFxlJxcy93YaBxAHqY2HYr0hb0AbK36J+Z1r
         KIcyGN0RnALk9GZNfMqrHdYVfBi9CW3eMQPBmdUuCL6tgnD+2TurBHTMPNmjEV9YpCmH
         ftN833h+lKBP3j6mumN9tfy/OSPTuwwPnGu0bLJe6CK0KDKk1zfA2k617TC+gIag4kxD
         zYOzmQjbb6/8V6gfyGXDl9xKSOpCY25m5jjMCV41exFdA3OhVpVtZpq4S1dD8XmB0NYG
         iRISrPiVbGMumorkMHZNWN2IVqgRE+lccnzdAllCJlxMAi0iabaSONF3Xjfvy7KlTgBL
         elVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+twZgD2lANnEj4Ejgw/Tmpo0NzizDYZveDuYYTFvBkQ=;
        b=DVcv96b93J8Z+pU0L8Qx6a3dBielzjOn69eo7OZ6MkkLmAaseBtaIw2xGXnmauEQGF
         QnvBi56YrFrcYvGt4qRR72oPgCsx0lep/vwvFLLeZ1Jan2os59xMNo5yUcNCeyDidFWQ
         snnBOdTXkycQA6wFnIHbMJa3Va7HHwH78uHxxnCEeEg1zRDB/N/EHbBdMjtJrow9HhdN
         r2Cx5vRi/luYP50BjfxFV2pjaGvVmVnpFMVX05CoSkCMMg9gAUPya6Hm8Ab0WBCbmNtT
         hEe7a49luh6otrVYVLLWXJoYZ3E+dYZszJCYn6njToXszQ4sjFZ7JfI9C/Nu/uUQLLrk
         5ljg==
X-Gm-Message-State: AAQBX9eq8AX/VNgNajx3KTzzEKfEwtX0EdNbLRq5sMqPSa3y9DaGI8Bp
        kUOFyNAAfFRd6n5kyBmUK8RWAo5BRhXV
X-Google-Smtp-Source: AKy350aXXKzgEOH65S8VEA7hDBdvZm+V3aREXE/mfJ94S5n64ddYtTWpd4eyhZD3Cq+Nr+hLeclvv1QNL9L+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:1148:b0:b76:5c0b:3573 with SMTP
 id p8-20020a056902114800b00b765c0b3573mr574672ybu.5.1679642613109; Fri, 24
 Mar 2023 00:23:33 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:16 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-8-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 7/9] perf vendor events: Sandybridge v19 events
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

