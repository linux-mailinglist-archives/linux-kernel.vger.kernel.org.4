Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F736E0662
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDMFQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDMFPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:15:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D16A5D2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:13:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8d4f1ca1so46161927b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362817; x=1683954817;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/wMb40ntUrrtEKX0pWRjZNO+TlYXtCqLFbV8EoKRtw=;
        b=3ll+a4rO/hkzDomcN+uUTdQoNpva3pseryloYnCYlSHRmA5NPoqQybNuqSqdnqdYoz
         Mls76nTML3+wqQJRH52IxzextN0OIP9zoRZg987/TFPeEROgyo4UpVTD3VlUVbtUFkH5
         Lwiu66HV5xQMMY41DiHqmKUulODoP5tdAtZjt2Xxy7gcaBjsdETIrZq7Er0ElsZpGODy
         eHAZsP/UpQL3+Si6GPXa4f64VAbuwusCHzX0uZiCR7a3dgGm/qpA1Qcw5T03LTjbxZuH
         ENwu4P9I6mcW0AL0HRsS0VNyaTST3xHB8445R6mYeCfjaonJ8qFXpUjLBScTC8VEqSL6
         YZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362817; x=1683954817;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/wMb40ntUrrtEKX0pWRjZNO+TlYXtCqLFbV8EoKRtw=;
        b=kW22qzncM5t4mYj/xgE+k7Gcqq1rDfM+QLDRslLY7uvgpjm69vW6/dEFMnXjztwLPO
         YbqOq40Yrq+IpDpLtPPhWuStSmdtEpMcAjeiXzPPvVaPoth5+uQW0wmYs17J80obvwNm
         4y1Q1tD+kyfg/u2799kd5G2XIV52fa0LVXV08DVbSa6mRD9xtIowf5ML0H22Z5kIQuM8
         l4VvhvsDf9ir8TTpWZXw6CPayjRwcN7C8eMaOZED8eLTrS0bwGi29yjpiBAS2bWMhnJq
         SCf/uTQSozju35kJnKJebqoFJii3wtuYxdeN7brhzr1a2k/qCkC5Uq6HgzuVRcmgdZBq
         dLJw==
X-Gm-Message-State: AAQBX9e/H6mLcRkoikOb1kfuO9ZJ7j+I/jzFIlZWS7Y4mdTQmSM6X6LB
        kVkWDP6hzZrCjcumm8QojbkxtcEmuyTN
X-Google-Smtp-Source: AKy350Y/FMQhqiVsOUOR3toB+Av2/hykwYChW5I5bXtqnaRoz1wfRI4WJhQRgnc2CYThQNaDYLpkFl76ub90
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a0d:ec02:0:b0:54c:2723:560d with SMTP id
 q2-20020a0dec02000000b0054c2723560dmr636699ywn.3.1681362817559; Wed, 12 Apr
 2023 22:13:37 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:10:11 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-22-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 21/21] perf vendor events intel: Fix uncore topics for tigerlake
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
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

Move events from 'uncore-other' topic classification to interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../x86/tigerlake/uncore-interconnect.json    | 90 +++++++++++++++++++
 .../arch/x86/tigerlake/uncore-other.json      | 88 ------------------
 2 files changed, 90 insertions(+), 88 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
new file mode 100644
index 000000000000..eed1b90a2779
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
@@ -0,0 +1,90 @@
+[
+    {
+        "BriefDescription": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from it's allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
index 6e43aaf64e28..c6596ba09195 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
@@ -1,92 +1,4 @@
 [
-    {
-        "BriefDescription": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from it's allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "UNC_CLOCK.SOCKET",
         "EventCode": "0xff",
-- 
2.40.0.577.gac1e443424-goog

