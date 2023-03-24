Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8D6C78C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCXHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCXHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277F26C28
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5458dde029bso10565627b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642604;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICoBRC5p7C47vzNPhCu4TQTxzhqKflbzynhlXLr/MKk=;
        b=inT7u+9TwAQtxFFfgIO8RMy9BFj07KRl/hoSst3W8wIYbzSrZW90KD7MHxxq6kockM
         ganZwhueYcsw0IZ52zbNwnxtIrLMBswQSZYpMGHdoSf5lQZ61Ug/geUNWh9gaX2NBfsc
         W+mlsldVETakrI2UcUXMom6K5+fEuJmFIHIsl3kWvH7np0RuS60k9MM7E3ei+mCr1mYH
         zwhdOmCLKMKWoNdw7IUS/I1bEIbmh4yj8j9YfsfFQQhJH5LyEAN7FzF6N5Yi3BAwP7j/
         aNkZdt34YqeCwoIs+kKG4SEtc5FeGCLH/6rlENwHYmzCxWweHLNvuc8rWkPEYngiyE7v
         /Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642604;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICoBRC5p7C47vzNPhCu4TQTxzhqKflbzynhlXLr/MKk=;
        b=yKQnR9uagR92ZZ+t63R4+ca5lC17qWeD1pAAvrz4HYUfmglTFnJS5bF1EFybFKaCbp
         n9hGLmvy72ufUJioRW5omzbeVz9KUVbCFS60wGVRtGjg5u9xXU/L3iMU0+FHBZ5Lv2yO
         AJ0A08eLJUi3xkmGIT4AuzVewduJbc7nb3ugHOfn+E7x6PoarHLiPapW+MLNj2CtgMgt
         KamfOoGla62fU6889GVhExcgyQ3ZhleLGWq+Fm5kwhJjJwgFEsyU1tvp8Qe7M2zqEryW
         N3VzbldC6HsY/PV/ElAmZaU2we4cUE4yw71eaxMdXMcA8BawH2rwoF4PQzp90/LiZUNs
         +JJQ==
X-Gm-Message-State: AAQBX9dUcv36XGyxT/Y5JjJzHPpgPdBZBu/uSBvWr7hojb4eVgpjHjAr
        BOGjc3Tn1JEkng2KWgPtXwQu56JrF1k4
X-Google-Smtp-Source: AKy350ZNw85tA/wL+jbgGjCjdFcC/MQWc77h9qpHx6Ul7Eyb+vrmjsHcEoWmBJNSlmW3r3YUK7icbM0W0DB/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:1501:b0:b4c:9333:2a2 with SMTP id
 q1-20020a056902150100b00b4c933302a2mr582591ybu.9.1679642604628; Fri, 24 Mar
 2023 00:23:24 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:15 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-7-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 6/9] perf vendor events: Jaketown v23 events
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
 tools/perf/pmu-events/arch/x86/jaketown/pipeline.json | 8 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv            | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index 85c04fe7632a..d0edfdec9f01 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -202,6 +202,14 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e1a609401fff..e41c289fa427 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -16,7 +16,7 @@ GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
 GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
-GenuineIntel-6-2D,v22,jaketown,core
+GenuineIntel-6-2D,v23,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
-- 
2.40.0.348.gf938b09366-goog

