Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB82F6E065B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDMFOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDMFOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:14:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6BA26C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:12:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54efad677cbso132222517b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362775; x=1683954775;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZt20Z7hTMj/DUmjIhsYx65tA/VQTBMfCLcsGtkqEtU=;
        b=iahnEwdvP3qFlniu5f+CxnRMLBH37+e807k/aAQxKTWXHm0bJUCsxoqDwaiXLKRIZM
         33/eJ6jzNIJ/nR8h8KpbFTHkh6XELcKJEqQbGFJz0M74CHCw5OUgrNQPAM+t35s0IC+P
         9egR6zRtg4FSol+wjywkTjXWUiSWdNO1VrVJLQ+fwN2maPatSGrWEdH9wdkw866rBFFO
         H5aVq4d/7e6nOsa+ewB4vdBo+cwkENUAbTIHBwwdVCXEu0A+2phC9KuA0BcLgqaHW29I
         wjRLty1Hd+UC83jIZ7htALYMz2ABEMDgfR29SKz23K33QQtujfjTOdybcOpI3QaakwYG
         EcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362775; x=1683954775;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rZt20Z7hTMj/DUmjIhsYx65tA/VQTBMfCLcsGtkqEtU=;
        b=AMuDEaUEE+TAPXLE8GioUGbenF21x5644F534hJa37Al4RuNcihWvRTSdULNRcAkPv
         DySxj+sCDaiBfbNhVUm654N/GPF4xxg1qgwyJJXYe5tUZSnFTopTe5T8p4IIN8/7ox0f
         fSvTO5GWGtNWFFIhuRnm01Ou8rYgzvJUhXE07SMpUpdtWhIdO8dZyFbkXT2IpctqNj8o
         nVAhQotTJAh/meYE+cRcUAECGvKWQNEHYIzQ6oIj8xhO+uw9LPxqvxpvMQlitds4jMd7
         2FBH0IAI8T+06LcAvtoXcN26AFRvETdv2KriTAEl6B5mbVlUIQiZno71K4egS6tIqZz7
         iG2w==
X-Gm-Message-State: AAQBX9fece5RvMvLILaS/dTmrq8kWP2CxMR3aJG4QBjmmhdVnojEnltD
        1YUXOF+v0q9oZwfcO/Wg2UVUbDpqQ9r8
X-Google-Smtp-Source: AKy350a73uyOAph3is4CxHpL8YIsVWYOHxz1QPnZWaBJkgNVsEKt32vmQ2bpEa5zwSm0NSdPLtQmuTQ2kXY3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:30c2:0:b0:b8f:553a:ddfd with SMTP id
 w185-20020a2530c2000000b00b8f553addfdmr499864ybw.5.1681362775476; Wed, 12 Apr
 2023 22:12:55 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:10:06 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-17-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 16/21] perf vendor events intel: Fix uncore topics for knightslanding
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'uncore-other' topic classification, move to cache, io and
memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../{uncore-other.json =3D> uncore-cache.json}  | 260 ------------------
 .../arch/x86/knightslanding/uncore-io.json    | 194 +++++++++++++
 .../x86/knightslanding/uncore-memory.json     |  68 +++++
 3 files changed, 262 insertions(+), 260 deletions(-)
 rename tools/perf/pmu-events/arch/x86/knightslanding/{uncore-other.json =
=3D> uncore-cache.json} (91%)
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-io=
.json

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
similarity index 91%
rename from tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
index fc85e0c95318..1b8dcfa5461c 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
@@ -55,74 +55,6 @@
         "UMask": "0x24",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Number of EDC Hits or Misses. Miss I",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "ECLK count",
-        "EventName": "UNC_E_E_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "EDC_ECLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache.",
-        "EventCode": "0x01",
-        "EventName": "UNC_E_RPQ_INSERTS",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "EDC_ECLK"
-    },
-    {
-        "BriefDescription": "UCLK count",
-        "EventName": "UNC_E_U_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_WPQ_INSERTS",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "EDC_ECLK"
-    },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0",
         "EventCode": "0x80",
@@ -3429,197 +3361,5 @@
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
-        "PerPkg": "1",
-        "UMask": "0x80",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
-        "PerPkg": "1",
-        "UMask": "0x40",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
-        "PerPkg": "1",
-        "UMask": "0x80",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
new file mode 100644
index 000000000000..898f7e425cd4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
@@ -0,0 +1,194 @@
+[
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
index 47da947b1a6e..fb752974179b 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
@@ -1,4 +1,72 @@
 [
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Number of EDC Hits or Misses. Miss I",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "ECLK count",
+        "EventName": "UNC_E_E_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache.",
+        "EventCode": "0x01",
+        "EventName": "UNC_E_RPQ_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "UCLK count",
+        "EventName": "UNC_E_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_WPQ_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "EDC_ECLK"
+    },
     {
         "BriefDescription": "CAS All",
         "EventCode": "0x03",
--=20
2.40.0.577.gac1e443424-goog

