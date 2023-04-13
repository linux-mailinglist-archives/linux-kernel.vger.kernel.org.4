Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61546E0653
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDMFNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDMFNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:13:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B849ED0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:12:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f810e01f5so58363267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362742; x=1683954742;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6L0/on0u5NMowuDk77nSJEhKTRaml/Cx+QEJI6a3/w=;
        b=sOmxvBnsHqZ4aOr67OViykdsAPpYFBjbQmCjsK9jHyhkDvkbdyxTlPoA4iXjiYrJ2m
         UWJhzvJNQeE5LtbyD5fLgwTWUXi/gg2wJhxg3neVhtdCwcZ9DuF/EGWN8NAXWd/CPZKL
         HtPS/HYsg/7E9ULz5jnRN3Pi6xgVkt48FnbQq2GbS1+UAw1LK9RaVE2jW70wrHlvbj3d
         qFsHNUIxMUkyxjK5QsC9CefadjCmdnwUjauoBAWFsHZGvxKiYFfSNDmYUtr5Z5WQ2+xn
         P8Vt8bET5pBgMuT5b4i8CRfQZU1r3ai/0mvLtG+PC0FbvCCVFxjUHxur8MASmzcySad4
         w3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362742; x=1683954742;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6L0/on0u5NMowuDk77nSJEhKTRaml/Cx+QEJI6a3/w=;
        b=hT188psqjRDvMs69QxG2nntCYM2FZpzMBUW9yaK9ePxj+DM8SDGq5dAy1RLiXGmY/r
         caoQMDumvDGGrC6xtB8Tph+aMnfFp0vfq/2VculS4E2sRq/O77LPbdNg9Udb5lRZF9aY
         0byB0fjOHh2iJD0W8saFElaGYZ6tr8bhhhVd7zXfFFk9U3DiYtSpPjeqTGqpVEoOET4p
         Vmeeq5n8PqZJN8cGUUeYipPEdCBzryUIdG0A4285OZzYFdQNTUCnIH5e14sc9rt5XqjU
         CQxF4ax8OBQfz6EJGLhZ9hVNsEy0efK6WbpLMGZ0X4SyPkKy2WyFz5DFOEryJvDDG0qg
         20Pw==
X-Gm-Message-State: AAQBX9cZgLKV0PxP419AbxsbCd5YS30i+564rXGQ6RSkFvd0MSh/zHR6
        3zbcK3v329o9HCg9YVhuj6xEdeAkqAeP
X-Google-Smtp-Source: AKy350ZcsmfcwQdwkxx01egVxEw1rNtjqoqtcIySw5Uu5mdrPGg1Jnbw3ZLdYGb2JzEZcy4ZE0a6JCaWGrpj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:dad2:0:b0:b8f:485d:9fcc with SMTP id
 n201-20020a25dad2000000b00b8f485d9fccmr520993ybf.4.1681362742774; Wed, 12 Apr
 2023 22:12:22 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:10:02 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-13-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 12/21] perf vendor events intel: Fix uncore topics for icelake
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
Content-Transfer-Encoding: quoted-printable
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
 .../arch/x86/icelake/uncore-interconnect.json | 74 +++++++++++++++++++
 .../arch/x86/icelake/uncore-other.json        | 72 ------------------
 2 files changed, 74 insertions(+), 72 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/uncore-interconn=
ect.json

diff --git a/tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.json
new file mode 100644
index 000000000000..8027590f1776
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.json
@@ -0,0 +1,74 @@
+[
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core. This event is not su=
pported on ICL products but is supported on RKL products.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core. T=
his event is not supported on ICL products but is supported on RKL products=
.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic. T=
his event is not supported on ICL products but is supported on RKL products=
.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Total number of all outgoing entries allocate=
d. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches. This event is not supported on ICL products but is=
 supported on RKL products.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/icelake/uncore-other.json
index b27d95b2c857..c6596ba09195 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
@@ -1,76 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core. This event is not su=
pported on ICL products but is supported on RKL products.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core. T=
his event is not supported on ICL products but is supported on RKL products=
.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic. T=
his event is not supported on ICL products but is supported on RKL products=
.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Total number of all outgoing entries allocate=
d. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches. This event is not supported on ICL products but is=
 supported on RKL products.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "UNC_CLOCK.SOCKET",
         "EventCode": "0xff",
--=20
2.40.0.577.gac1e443424-goog

