Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737676E0646
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDMFMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDMFLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:11:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F37281
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:11:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f810e01f5so58353547b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362709; x=1683954709;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20LX+VuUJ1BSN+qIRYiI4gfQcPYnYXttFourhz9CK78=;
        b=4RVGT2Zr7MWMuP4HpQs27pRst2yIZVtytQE79huvygxhWjVh1sjIDD0qYpA8hMtCHC
         pX6GOoOpuibwUOLnUJGShjK2M/hxUprfAu+zQlJ19WMX5dLY438SUR0Zp4KB7xi5UFy0
         a2FczJXms67Y7KjrsqKrnnomEYlP64WUIsMLEB5xuowuSLaBbMmTVwoZStTuW9iadh1d
         GyP1MK9/JCpy6Re05qCkIK0iIpVIyWpU6+8NYAPR5MzwR15AlXggCyc2BeCTdHcI5w77
         rHsJPtM6TFAO3kBS1Y/wsnSGZ2mVLBOK+9WI98vWHQxkPtLI/vqdQsrnw7Q6rTUvH6o0
         dy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362709; x=1683954709;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=20LX+VuUJ1BSN+qIRYiI4gfQcPYnYXttFourhz9CK78=;
        b=KnkOfRZco/hL6brWEqiASAanPfvCsxHE2ztWFhf4kJ0dj+lqAIMtOVILBZCRPrli05
         2d23o2OJKaZ7Nlvp+6OV1q09zVVp7QUytjxGF6vcMaVv6kRF8db0gDtPJBmuo7ZJKfH5
         7fmSD31mMDAoSPCgfS27VgkyMpRk9j80r6GP3yoSCODRE7Pc7Fo0BNI/ncoGBbUCOqeA
         p1TieOIYkEarlG9PzeGxVgRu5HgfuX5Bew1tua6w03TbsfI24DNsbRPCtJbivQ36zW8o
         oCt37eUXGcf913yKNHMW6BzhegqkkZ5ShKtW/G1DELycKqhFjtkdkYMfcY3ss7h828BY
         U4zA==
X-Gm-Message-State: AAQBX9d3lYGPrXIPrac1wLYJ2nLLe02dveJl+X9CS91XR/Kz2O5NGU/4
        sQC5RSPRp7+iEBPXU5V0B15M9m/y3ZQB
X-Google-Smtp-Source: AKy350YaThwaIiF37SeFOj39aWCAu3oO7sSCvwJox6C0Ks/QOtGdBHA6188TnxhJAIgO45izzzDa44lGfAt8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:dad7:0:b0:b8f:46d3:5af9 with SMTP id
 n206-20020a25dad7000000b00b8f46d35af9mr538616ybf.0.1681362708878; Wed, 12 Apr
 2023 22:11:48 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:09:58 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-9-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 08/21] perf vendor events intel: Fix uncore topics for broadwellx
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'uncore-other' topic classification, move to cache,
interconnect and io.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellx/uncore-cache.json     |  358 +-
 .../x86/broadwellx/uncore-interconnect.json   | 4297 ++++++++++++++---
 .../arch/x86/broadwellx/uncore-io.json        |  555 +++
 .../arch/x86/broadwellx/uncore-other.json     | 3242 -------------
 4 files changed, 4226 insertions(+), 4226 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-io.jso=
n
 delete mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.=
json

diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index f794d2992323..400d784d1457 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -8,7 +8,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LLC prefetch misses for data reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
@@ -19,7 +19,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode",
@@ -30,7 +30,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "MMIO reads. Derived from unc_c_tor_inserts.mi=
ss_opcode",
@@ -41,7 +41,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "MMIO writes. Derived from unc_c_tor_inserts.m=
iss_opcode",
@@ -52,7 +52,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "PCIe write misses (full cache line). Derived =
from unc_c_tor_inserts.miss_opcode",
@@ -63,7 +63,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LLC misses for PCIe read current. Derived fro=
m unc_c_tor_inserts.miss_opcode",
@@ -74,7 +74,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes. Derived from unc_c_tor_inserts.miss_op=
code",
@@ -85,7 +85,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LLC prefetch misses for RFO. Derived from unc=
_c_tor_inserts.miss_opcode",
@@ -96,7 +96,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_c_tor_inserts.miss_opcode",
@@ -107,7 +107,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L2 demand and L2 prefetch code references to =
LLC. Derived from unc_c_tor_inserts.opcode",
@@ -118,7 +118,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "PCIe writes (partial cache line). Derived fro=
m unc_c_tor_inserts.opcode",
@@ -128,7 +128,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode",
@@ -139,7 +139,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "PCIe write references (full cache line). Deri=
ved from unc_c_tor_inserts.opcode",
@@ -150,7 +150,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode",
@@ -161,7 +161,7 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode",
@@ -172,20 +172,20 @@
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Bounce Control",
         "EventCode": "0xA",
         "EventName": "UNC_C_BOUNCE_CONTROL",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Uncore Clocks",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Counter 0 Occupancy",
@@ -193,7 +193,7 @@
         "EventName": "UNC_C_COUNTER0_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "FaST wire asserted",
@@ -201,7 +201,7 @@
         "EventName": "UNC_C_FAST_ASSERTED",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles either the local=
 distress or incoming distress signals are asserted.  Incoming distress inc=
ludes both up and dn.",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "All LLC Misses (code+ data rd + data wr - inc=
luding demand and prefetch)",
@@ -212,7 +212,7 @@
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for any transaction originati=
ng from the IPQ or IRQ.  This does not include lookups originating from the=
 ISMQ.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x11",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
@@ -221,7 +221,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Lookups that Match NID",
@@ -230,7 +230,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Qualify one of the other subevents by=
 the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid.   In=
 conjunction with STATE =3D I, it is possible to monitor misses to specific=
 NIDs in the system.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Any Read Request",
@@ -239,7 +239,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
@@ -248,7 +248,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for only snoop requests comin=
g from the remote socket(s) through the IPQ.",
         "UMask": "0x9",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
@@ -257,7 +257,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cacheable and UC.",
         "UMask": "0x5",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
@@ -266,7 +266,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized",
@@ -275,7 +275,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
@@ -284,7 +284,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized",
@@ -293,7 +293,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "M line evictions from LLC (writebacks to memo=
ry)",
@@ -303,7 +303,7 @@
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
@@ -312,7 +312,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.; Qu=
alify one of the other subevents by the Target NID.  The NID is programmed =
in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is pos=
sible to monitor misses to specific NIDs in the system.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0",
@@ -321,7 +321,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Clean Victim with raw CV=3D0",
@@ -330,7 +330,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
@@ -339,7 +339,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.; Number of =
times that an RFO hit in S state.  This is useful for determining if it mig=
ht be good for a workload to use RspIWB instead of RspSWB.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
@@ -348,7 +348,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times when a Snoop hit in FSE states and triggered a silent evic=
tion.  This is useful because this information is lost in the PRE encodings=
.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc",
@@ -357,7 +357,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
@@ -366,7 +366,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times that a USWC write (WCIL(F)) transaction hit in the LLC in =
M state, triggering a WBMtoI followed by the USWC write.  This occurs when =
there is WC aliasing.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 0",
@@ -375,7 +375,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 0",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 1",
@@ -384,7 +384,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 2",
@@ -393,7 +393,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 2",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 3",
@@ -402,7 +402,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 3",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Bits Decremented",
@@ -411,7 +411,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often all LRU bits were decremented by 1=
",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; Non-0 Aged Victim",
@@ -420,7 +420,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often we picked a victim that had a non-=
zero age",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; All",
@@ -429,7 +429,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down",
@@ -438,7 +438,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX-- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even",
@@ -447,7 +447,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd",
@@ -456,7 +456,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up",
@@ -465,7 +465,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even",
@@ -474,7 +474,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd",
@@ -483,7 +483,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; All",
@@ -492,7 +492,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down",
@@ -501,7 +501,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in HSX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even",
@@ -510,7 +510,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd",
@@ -519,7 +519,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up",
@@ -528,7 +528,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in HSX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even",
@@ -537,7 +537,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd",
@@ -546,7 +546,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
@@ -555,7 +555,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
@@ -564,7 +564,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in HSX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even",
@@ -573,7 +573,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd",
@@ -582,7 +582,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up",
@@ -591,7 +591,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in HSX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even",
@@ -600,7 +600,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd",
@@ -609,7 +609,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AD",
@@ -617,7 +617,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AK",
@@ -625,7 +625,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; BL",
@@ -633,7 +633,7 @@
         "EventName": "UNC_C_RING_BOUNCES.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
@@ -641,7 +641,7 @@
         "EventName": "UNC_C_RING_BOUNCES.IV",
         "PerPkg": "1",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -650,7 +650,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -659,7 +659,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
@@ -668,7 +668,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters for Down polarity",
         "UMask": "0xcc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -677,7 +677,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD",
@@ -685,7 +685,7 @@
         "EventName": "UNC_C_RING_SINK_STARVED.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK",
@@ -693,7 +693,7 @@
         "EventName": "UNC_C_RING_SINK_STARVED.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL",
@@ -701,7 +701,7 @@
         "EventName": "UNC_C_RING_SINK_STARVED.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "IV",
@@ -709,14 +709,14 @@
         "EventName": "UNC_C_RING_SINK_STARVED.IV",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of cycles the Cbo is actively throttli=
ng traffic onto the Ring in order to limit bounce traffic.",
         "EventCode": "0x7",
         "EventName": "UNC_C_RING_SRC_THRTL",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
@@ -725,7 +725,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally startved and therefore we are blocking the IRQ.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
@@ -734,7 +734,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IRQ is externally starved and therefore we are blocking the IPQ.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
@@ -743,7 +743,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; Number of times that the ISMQ Bid.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; PRQ",
@@ -752,7 +752,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
@@ -761,7 +761,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
@@ -770,7 +770,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
@@ -779,7 +779,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; PRQ",
@@ -788,7 +788,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; PRQ",
@@ -797,7 +797,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
@@ -806,7 +806,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the IPQ in Internal S=
tarvation.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
@@ -815,7 +815,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the IRQ in Internal S=
tarvation.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
@@ -824,7 +824,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the ISMQ in Internal =
Starvation.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; PRQ",
@@ -833,7 +833,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Address Conflict",
@@ -842,7 +842,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject from an address conflicts.  Address conflicts out of the IPQ shou=
ld be rare.  They will generally only occur if two different sockets are se=
nding requests to the same address at the same time.  This is a true confli=
ct case, unlike the IPQ Address Conflict which is commonly caused by prefet=
ching characteristics.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Any Reject",
@@ -851,7 +851,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject.  TOR rejects from the IPQ can be caused by the Egress being full=
 or Address Conflicts.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No Egress Credits",
@@ -860,7 +860,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject from the Egress being full.  IPQ requests make use of the AD Egre=
ss for regular responses, the BL egress to forward data, and the AK egress =
to return credits.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No QPI Credits",
@@ -869,7 +869,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No AD Sbo Credits",
@@ -878,7 +878,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried because of it =
lacked credits to send an AD packet to the Sbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Target Node Filter",
@@ -887,7 +887,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried filtered by th=
e Target NodeID as specified in the Cbox's Filter register.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
@@ -896,7 +896,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IRQ was retried because of an address match in the TOR.  In order to=
 maintain coherency, requests to the same address are not allowed to pass e=
ach other up in the Cbo.  Therefore, if there is an outstanding request to =
a given address, one cannot issue another request to that address until it =
is complete.  This comes up most commonly with prefetches.  Outstanding pre=
fetches occasionally will not complete their memory fetch and a demand requ=
est to the same address will then sit in the IRQ and get retried until the =
prefetch fills the data into the LLC.  Therefore, it will not be uncommon t=
o see this case in high bandwidth streaming workloads when the LLC Prefetch=
er in the core is enabled.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
@@ -905,7 +905,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of IRQ retries that occur.=
  Requests from the IRQ are retried if they are rejected from the TOR pipel=
ine for a variety of reasons.  Some of the most common reasons include if t=
he Egress is full, there are no RTIDs, or there is a Physical Address match=
 to another outstanding request.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
@@ -914,7 +914,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IRQ was retried because it failed to acquire an entry in the Egress.=
  The egress is the buffer that queues up for allocating onto the ring.  IR=
Q requests can make use of all four rings and all four Egresses.  If any of=
 the queues that a given request needs to make use of are full, the request=
 will be retried.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No IIO Credits=
",
@@ -923,7 +923,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a request attempted to acqui=
re the NCS/NCB credit for sending messages on BL to the IIO.  There is a si=
ngle credit in each CBo that is shared between the NCS and NCB message clas=
ses for sending transactions on the BL ring (such as read data) to the IIO.=
",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
@@ -932,7 +932,7 @@
         "PerPkg": "1",
         "PublicDescription": "Qualify one of the other subevents by a give=
n RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER1.n=
id.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
@@ -941,7 +941,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of requests rejects because of lack o=
f QPI Ingress credits.  These credits are required in order to send transac=
tions to the QPI agent.  Please see the QPI_IGR_CREDITS events for more inf=
ormation.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
@@ -950,7 +950,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that requests fro=
m the IRQ were retried because there were no RTIDs available.  RTIDs are re=
quired after a request misses the LLC and needs to send snoops and/or reque=
sts to memory.  If there are no RTIDs available, requests will queue up in =
the IRQ and retry until one becomes available.  Note that there are multipl=
e RTID pools for the different sockets.  There may be cases where the local=
 RTIDs are all used, but requests destined for remote memory can still acqu=
ire an RTID because there are remote RTIDs available.  This event does not =
provide any filtering for this case.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No AD Sbo Cred=
its",
@@ -959,7 +959,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried because of it lacked credits to send an AD packet to=
 the Sbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No BL Sbo Cred=
its",
@@ -968,7 +968,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried because of it lacked credits to send an BL packet to=
 the Sbo.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Target Node Fi=
lter",
@@ -977,7 +977,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried filtered by the Target NodeID as specified in the Cb=
ox's Filter register.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
@@ -986,7 +986,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
total number of times that a request from the ISMQ retried because of a TOR=
 reject.  ISMQ requests generally will not need to retry (or at least ISMQ =
retries are less common than IRQ retries).  ISMQ requests will retry if the=
y are not able to acquire a needed Egress credit to get onto the ring, or f=
or cache evictions that need to acquire an RTID.  Most ISMQ requests alread=
y have an RTID, so eviction retries will be less common here.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No Egress Credits",
@@ -995,7 +995,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
number of times that a request from the ISMQ retried because of a TOR rejec=
t caused by a lack of Egress credits. The egress is the buffer that queues =
up for allocating onto the ring.  If any of the Egress queues that a given =
request needs to make use of are full, the request will be retried.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No IIO Credits",
@@ -1004,7 +1004,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Number of t=
imes a request attempted to acquire the NCS/NCB credit for sending messages=
 on BL to the IIO.  There is a single credit in each CBo that is shared bet=
ween the NCS and NCB message classes for sending transactions on the BL rin=
g (such as read data) to the IIO.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries",
@@ -1013,7 +1013,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
@@ -1022,7 +1022,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No RTIDs",
@@ -1031,7 +1031,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
number of times that a request from the ISMQ retried because of a TOR rejec=
t caused by no RTIDs.  M-state cache evictions are serviced through the ISM=
Q, and must acquire an RTID in order to write back to memory.  If no RTIDs =
are available, they will be retried.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries",
@@ -1040,7 +1040,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
         "UMask": "0x80",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credits=
",
@@ -1049,7 +1049,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried because of it lacked credits to send an AD packet t=
o the Sbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No BL Sbo Credits=
",
@@ -1058,7 +1058,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried because of it lacked credits to send an BL packet t=
o the Sbo.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; Target Node Filte=
r",
@@ -1067,7 +1067,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried filtered by the Target NodeID as specified in the C=
box's Filter register.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IPQ",
@@ -1076,7 +1076,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ",
@@ -1085,7 +1085,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ Rejected",
@@ -1094,7 +1094,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; PRQ Rejects",
@@ -1103,7 +1103,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Acquired; For AD Ring",
@@ -1112,7 +1112,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits acquired in a given cy=
cle, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Acquired; For BL Ring",
@@ -1121,7 +1121,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits acquired in a given cy=
cle, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Occupancy; For AD Ring",
@@ -1130,7 +1130,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits in use in a given cycl=
e, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Occupancy; For BL Ring",
@@ -1139,7 +1139,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits in use in a given cycl=
e, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; All",
@@ -1148,7 +1148,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR.    This includes requests that reside in the TOR for a shor=
t time, such as LLC Hits that do not need to snoop cores or requests that g=
et rejected and have to be retried through one of the ingress queues.  The =
TOR is more commonly a bottleneck in skews with smaller core counts, where =
the ratio of RTIDs to TOR entries is larger.  Note that there are reserved =
TOR entries for various request types, so it is possible that a given reque=
st type be blocked with an occupancy that is less than 20.  Also note that =
generally requests will not be able to arbitrate into the TOR pipeline if t=
here are no available TOR slots.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Evictions",
@@ -1157,7 +1157,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions in=
serted into the TOR.  Evictions can be quick, such as when the line is in t=
he F, S, or E states and no core valid bits are set.  They can also be long=
er if either CV bits are set (so the cores need to be snooped) and/or if th=
ere is a HitM (in which case it is necessary to write the request out to me=
mory).",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory",
@@ -1166,7 +1166,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
@@ -1175,7 +1175,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory",
@@ -1184,7 +1184,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
@@ -1193,7 +1193,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Miss Opcode Match",
@@ -1202,7 +1202,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory",
@@ -1211,7 +1211,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
@@ -1220,7 +1220,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched",
@@ -1229,7 +1229,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches=
 an RTID destination) transactions inserted into the TOR.  The NID is progr=
ammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it i=
s possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Evictions",
@@ -1238,7 +1238,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Miss All",
@@ -1247,7 +1247,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
         "UMask": "0x4a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
@@ -1256,7 +1256,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
@@ -1265,7 +1265,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Writebacks",
@@ -1274,7 +1274,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
         "UMask": "0x50",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Opcode Match",
@@ -1283,7 +1283,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory",
@@ -1292,7 +1292,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
@@ -1301,7 +1301,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
@@ -1310,7 +1310,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Any",
@@ -1319,7 +1319,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); All valid TO=
R entries.  This includes requests that reside in the TOR for a short time,=
 such as LLC Hits that do not need to snoop cores or requests that get reje=
cted and have to be retried through one of the ingress queues.  The TOR is =
more commonly a bottleneck in skews with smaller core counts, where the rat=
io of RTIDs to TOR entries is larger.  Note that there are reserved TOR ent=
ries for various request types, so it is possible that a given request type=
 be blocked with an occupancy that is less than 20.  Also note that general=
ly requests will not be able to arbitrate into the TOR pipeline if there ar=
e no available TOR slots.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Evictions",
@@ -1328,7 +1328,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding eviction transactions in the TOR.  Evictions can be quick, such a=
s when the line is in the F, S, or E states and no core valid bits are set.=
  They can also be longer if either CV bits are set (so the cores need to b=
e snooped) and/or if there is a HitM (in which case it is necessary to writ=
e the request out to memory).",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode",
@@ -1338,7 +1338,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
for miss transactions that match an opcode. This generally means that the r=
equest was sent to memory or MMIO.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1347,7 +1347,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matched"=
,
@@ -1356,7 +1356,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Miss All",
@@ -1365,7 +1365,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding miss requests in the TOR.  'Miss' means the allocation requires a=
n RTID.  This generally means that the request was sent to memory or MMIO."=
,
         "UMask": "0xa",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1374,7 +1374,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x2a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opcod=
e Matched",
@@ -1383,7 +1383,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Miss Opcode Match",
@@ -1392,7 +1392,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
for miss transactions that match an opcode. This generally means that the r=
equest was sent to memory or MMIO.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1401,7 +1401,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x8a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Opco=
de Matched",
@@ -1410,7 +1410,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched",
@@ -1419,7 +1419,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of NI=
D matched outstanding requests in the TOR.  The NID is programmed in Cn_MSR=
_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to mon=
itor misses to specific NIDs in the system.",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched Evictions",
@@ -1428,7 +1428,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding NID matched eviction transactions in the TOR .",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched",
@@ -1437,7 +1437,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
         "UMask": "0x4a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
@@ -1446,7 +1446,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID and an opcode.",
         "UMask": "0x43",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
@@ -1455,7 +1455,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match a NID and an opcode.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
@@ -1464,7 +1464,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matched =
write transactions int the TOR.",
         "UMask": "0x50",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Opcode Match",
@@ -1473,7 +1473,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1482,7 +1482,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Matched=
",
@@ -1491,7 +1491,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Writebacks",
@@ -1500,7 +1500,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Write transa=
ctions in the TOR.   This does not include RFO, but actual operations that =
contain data being sent from the core.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto AD Ring",
@@ -1508,7 +1508,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto AK Ring",
@@ -1516,7 +1516,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto BL Ring",
@@ -1524,7 +1524,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
@@ -1533,7 +1533,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the AD ring.  Some example include out=
bound requests, snoop requests, and snoop responses.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Corebo",
@@ -1542,7 +1542,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the AD ring.  This is commonly used for=
 outbound requests.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AK - Cachebo",
@@ -1551,7 +1551,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the AK ring.  This is commonly used fo=
r credit returns and GO responses.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AK - Corebo",
@@ -1560,7 +1560,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the AK ring.  This is commonly used for=
 snoop responses coming from the core and destined for a Cachebo.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; BL - Cacheno",
@@ -1569,7 +1569,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the BL ring.  This is commonly used to=
 send data from the cache to various destinations.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; BL - Corebo",
@@ -1578,7 +1578,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; IV - Cachebo",
@@ -1587,7 +1587,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the IV ring.  This is commonly used fo=
r snoops to the cores.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto AD Ring (to core)"=
,
@@ -1596,7 +1596,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that the core AD egress spent in starvation"=
,
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto AK Ring",
@@ -1605,7 +1605,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both AK egresses spent in starvation",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto BL Ring",
@@ -1614,7 +1614,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both BL egresses spent in starvation",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto IV Ring",
@@ -1623,7 +1623,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that the cachebo IV egress spent in starvati=
on",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BT Cycles Not Empty",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index 2819c6621089..e61a23f68899 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
@@ -6,7 +6,7 @@
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
@@ -15,1317 +15,4004 @@
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
-        "BriefDescription": "Number of qfclks",
-        "EventCode": "0x14",
-        "EventName": "UNC_Q_CLOCKTICKS",
+        "BriefDescription": "Total Write Cache Occupancy; Any Source",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of clocks in the QPI LL.  =
This clock runs at 1/4th the GT/s speed of the QPI link.  For example, a 4G=
T/s link will have qfclk or 1GHz.  BDX does not support dynamic link speeds=
, so this frequency is fixed.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks all requests f=
rom any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Count of CTO Events",
-        "EventCode": "0x38",
-        "EventName": "UNC_Q_CTO_COUNT",
+        "BriefDescription": "Total Write Cache Occupancy; Select Source",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks only those req=
uests that come from the port specified in the IRP_PmonFilter.OrderingQ reg=
ister.  This register allows one to select one specific queue.  It is not p=
ossible to monitor multiple queues at a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
+        "BriefDescription": "Clocks in the IRP",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of clocks in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CLFlush",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
+        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits.  Had there been enough credits, the spawn would have worked as th=
e RBT bit was set and the RBT tag matched.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x80",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss",
+        "BriefDescription": "Coherent Ops; CRd",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
+        "EventName": "UNC_I_COHERENT_OPS.CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d there weren't enough Egress credits.   The valid bit was set.",
-        "UMask": "0x20",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x2",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Invalid",
+        "BriefDescription": "Coherent Ops; DRd",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
+        "EventName": "UNC_I_COHERENT_OPS.DRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits AND the RBT bit was not set, but the RBT tag matched.",
-        "UMask": "0x8",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x4",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss, Invalid",
+        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
+        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match, t=
he valid bit was not set and there weren't enough Egress credits.",
-        "UMask": "0x80",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x20",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss",
+        "BriefDescription": "Coherent Ops; PCIRdCur",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
+        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match al=
though the valid bit was set and there were enough Egress credits.",
-        "UMask": "0x10",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x1",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT I=
nvalid",
+        "BriefDescription": "Coherent Ops; PCIItoM",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the route-back table (RBT) s=
pecified that the transaction should not trigger a direct2core transaction.=
  This is common for IO transactions.  There were enough Egress credits and=
 the RBT tag matched but the valid bit was not set.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x10",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss and Invalid",
+        "BriefDescription": "Coherent Ops; RFO",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d the valid bit was not set although there were enough Egress credits.",
-        "UMask": "0x40",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x8",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
+        "BriefDescription": "Coherent Ops; WbMtoI",
         "EventCode": "0x13",
-        "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
+        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn was successful.  There were sufficient cred=
its, the RBT valid bit was set and there was an RBT tag match.  The message=
 was marked to spawn direct2core.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x40",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Cycles in L1",
-        "EventCode": "0x12",
-        "EventName": "UNC_Q_L1_POWER_CYCLES",
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI qfclk cycles spent in L1 power=
 mode.  L1 is a mode that totally shuts down a QPI link.  Use edge detect t=
o count the number of instances when the QPI link entered L1.  Link power s=
tates are per link and per direction, so for example the Tx direction could=
 be in one state while Rx was in another. Because L1 totally shuts down the=
 link, it takes a good amount of time to exit this mode.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of A=
tomic Transactions as Secondary",
+        "UMask": "0x10",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Cycles in L0p",
-        "EventCode": "0x10",
-        "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of R=
ead Transactions as Secondary",
+        "UMask": "0x4",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Cycles in L0",
-        "EventCode": "0xF",
-        "EventName": "UNC_Q_RxL0_POWER_CYCLES",
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of W=
rite Transactions as Secondary",
+        "UMask": "0x8",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Bypassed",
-        "EventCode": "0x9",
-        "EventName": "UNC_Q_RxL_BYPASSED",
+        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "UMask": "0x2",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "CRC Errors Detected; LinkInit",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
+        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
; CRC errors detected during link initialization.",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Requests"=
,
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
+        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_XFER",
         "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Transfers=
 From Primary to Secondary",
+        "UMask": "0x20",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN0 Credit Consumed; DRS",
-        "EventCode": "0x1E",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
+        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the DRS message class.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints=
 From Primary to Secondary",
+        "UMask": "0x40",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN0 Credit Consumed; HOM",
-        "EventCode": "0x1E",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.HOM",
+        "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_TIMEOUT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the HOM message class.",
-        "UMask": "0x8",
-        "Unit": "QPI LL"
+        "PublicDescription": "Indicates the fetch for a previous prefetch =
wasn't accepted by the prefetch.   This happens in the case of a prefetch T=
imeOut",
+        "UMask": "0x80",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN0 Credit Consumed; NCB",
-        "EventCode": "0x1E",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCB",
+        "BriefDescription": "Misc Events - Set 1; Data Throttled",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.DATA_THROTTLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCB message class.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "IRP throttled switch data",
+        "UMask": "0x80",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN0 Credit Consumed; NCS",
-        "EventCode": "0x1E",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCS",
+        "BriefDescription": "Misc Events - Set 1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCS message class.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
+        "UMask": "0x10",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN0 Credit Consumed; NDR",
-        "EventCode": "0x1E",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NDR",
+        "BriefDescription": "Misc Events - Set 1; Received Invalid",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NDR message class.",
+        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN0 Credit Consumed; SNP",
-        "EventCode": "0x1E",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.SNP",
+        "BriefDescription": "Misc Events - Set 1; Received Valid",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the SNP message class.",
-        "UMask": "0x10",
-        "Unit": "QPI LL"
+        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
+        "UMask": "0x40",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN1 Credit Consumed; DRS",
-        "EventCode": "0x39",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.DRS",
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_E",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the DRS message class.",
+        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_I",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN1 Credit Consumed; HOM",
-        "EventCode": "0x39",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.HOM",
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_M",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the HOM message class.",
+        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN1 Credit Consumed; NCB",
-        "EventCode": "0x39",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCB",
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_S",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCB message class.",
+        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN1 Credit Consumed; NCS",
-        "EventCode": "0x39",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCS",
+        "BriefDescription": "AK Ingress Occupancy",
+        "EventCode": "0xA",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCS message class.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN1 Credit Consumed; NDR",
-        "EventCode": "0x39",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NDR",
+        "BriefDescription": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "EventCode": "0x4",
+        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NDR message class.",
-        "UMask": "0x20",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VN1 Credit Consumed; SNP",
-        "EventCode": "0x39",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.SNP",
+        "BriefDescription": "BL Ingress Occupancy - DRS",
+        "EventCode": "0x1",
+        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the SNP message class.",
-        "UMask": "0x10",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "VNA Credit Consumed",
-        "EventCode": "0x1D",
-        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
+        "BriefDescription": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "EventCode": "0x7",
+        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an RxQ VNA c=
redit was consumed (i.e. message uses a VNA credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
-        "Unit": "QPI LL"
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty",
-        "EventCode": "0xA",
-        "EventName": "UNC_Q_RxL_CYCLES_NE",
+        "BriefDescription": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "EventCode": "0x5",
+        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN0",
-        "EventCode": "0xF",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN0",
+        "BriefDescription": "BL Ingress Occupancy - NCB",
+        "EventCode": "0x2",
+        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN1",
-        "EventCode": "0xF",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN1",
+        "BriefDescription": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "EventCode": "0x8",
+        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN0",
-        "EventCode": "0x12",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN0",
+        "BriefDescription": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "EventCode": "0x6",
+        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN1",
-        "EventCode": "0x12",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN1",
+        "BriefDescription": "BL Ingress Occupancy - NCS",
+        "EventCode": "0x3",
+        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN0",
-        "EventCode": "0x10",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN0",
+        "BriefDescription": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "EventCode": "0x9",
+        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN1",
-        "EventCode": "0x10",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN1",
+        "BriefDescription": "Snoop Responses; Hit E or S",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Snoop Responses : Hit E or S",
+        "UMask": "0x4",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN0",
-        "EventCode": "0x11",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN0",
+        "BriefDescription": "Snoop Responses; Hit I",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Snoop Responses : Hit I",
+        "UMask": "0x2",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN1",
-        "EventCode": "0x11",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN1",
+        "BriefDescription": "Snoop Responses; Hit M",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Snoop Responses : Hit M",
+        "UMask": "0x8",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN0",
-        "EventCode": "0x14",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN0",
+        "BriefDescription": "Snoop Responses; Miss",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
+        "PublicDescription": "Snoop Responses : Miss",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN1",
-        "EventCode": "0x14",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN1",
+        "BriefDescription": "Snoop Responses; SnpCode",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Snoop Responses : SnpCode",
+        "UMask": "0x10",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN0",
-        "EventCode": "0x13",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN0",
+        "BriefDescription": "Snoop Responses; SnpData",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Snoop Responses : SnpData",
+        "UMask": "0x20",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN1",
-        "EventCode": "0x13",
-        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN1",
+        "BriefDescription": "Snoop Responses; SnpInv",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Snoop Responses : SnpInv",
+        "UMask": "0x40",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
+        "BriefDescription": "Inbound Transaction Count; Atomic",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of atomic =
transactions",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Other",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of 'other'=
 kinds of transactions.",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of read pr=
efetches.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only read requests (n=
ot including read prefetches).",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Write Prefetches",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of write p=
refetches.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD Egress Credit Stalls",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue a request to the R2PCIe because there are no AD Egress Credits=
 available.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue data to the R2PCIe because there are no BL Egress Credits avai=
lable.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "EventCode": "0xE",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "EventCode": "0xD",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Number of qfclks",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of clocks in the QPI LL.  =
This clock runs at 1/4th the GT/s speed of the QPI link.  For example, a 4G=
T/s link will have qfclk or 1GHz.  BDX does not support dynamic link speeds=
, so this frequency is fixed.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Count of CTO Events",
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_CTO_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits.  Had there been enough credits, the spawn would have worked as th=
e RBT bit was set and the RBT tag matched.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d there weren't enough Egress credits.   The valid bit was set.",
+        "UMask": "0x20",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Invalid",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits AND the RBT bit was not set, but the RBT tag matched.",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss, Invalid",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match, t=
he valid bit was not set and there weren't enough Egress credits.",
+        "UMask": "0x80",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match al=
though the valid bit was set and there were enough Egress credits.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT I=
nvalid",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the route-back table (RBT) s=
pecified that the transaction should not trigger a direct2core transaction.=
  This is common for IO transactions.  There were enough Egress credits and=
 the RBT tag matched but the valid bit was not set.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss and Invalid",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d the valid bit was not set although there were enough Egress credits.",
+        "UMask": "0x40",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn was successful.  There were sufficient cred=
its, the RBT valid bit was set and there was an RBT tag match.  The message=
 was marked to spawn direct2core.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles in L1",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L1 power=
 mode.  L1 is a mode that totally shuts down a QPI link.  Use edge detect t=
o count the number of instances when the QPI link entered L1.  Link power s=
tates are per link and per direction, so for example the Tx direction could=
 be in one state while Rx was in another. Because L1 totally shuts down the=
 link, it takes a good amount of time to exit this mode.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Bypassed",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; LinkInit",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
; CRC errors detected during link initialization.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; DRS",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the DRS message class.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; HOM",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the HOM message class.",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCB",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCB message class.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCS",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCS message class.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NDR",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NDR message class.",
+        "UMask": "0x20",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; SNP",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the SNP message class.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; DRS",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the DRS message class.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; HOM",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the HOM message class.",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NCB",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCB message class.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NCS",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCS message class.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NDR",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NDR message class.",
+        "UMask": "0x20",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; SNP",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the SNP message class.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Consumed",
+        "EventCode": "0x1D",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VNA c=
redit was consumed (i.e. message uses a VNA credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN0",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN1",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN0",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN1",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN0",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN1",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN0",
+        "EventCode": "0x11",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN1",
+        "EventCode": "0x11",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN0",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN1",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN0",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN1",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits receive=
d over QPI that do not hold protocol payload.  When QPI is not in a power s=
aving state, it continuously transmits flits across the link.  When there a=
re no protocol flits to send, it will send IDLE and NULL flits  across.  Th=
ese flits sometimes do carry a payload, such as credit returns, but are gen=
erally not considered part of the QPI bandwidth.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
+        "UMask": "0x18",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
  This includes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Flits",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
+        "UMask": "0x6",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; SNP Flits",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
 transmit non-coherent data across QPI.",
+        "UMask": "0xc",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations",
+        "EventCode": "0x8",
+        "EventName": "UNC_Q_RxL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN0",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN1",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN0",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN1",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN0",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN1",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN0",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN1",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN0",
+        "EventCode": "0xE",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN1",
+        "EventCode": "0xE",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN0",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN1",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS; for VN0",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS; for VN1",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM; for VN0",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM; for VN1",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB; for VN0",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB; for VN1",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS; for VN0",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS; for VN1",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR; for VN0",
+        "EventCode": "0x1A",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR; for VN1",
+        "EventCode": "0x1A",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP; for VN0",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP; for VN1",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - H=
OM",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the HOM message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - D=
RS",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the DRS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - S=
NP",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the SNP message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
DR",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NDR message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CS",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x20",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CB",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCB message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; Egress Credit=
s",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.EGRESS_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet because there were insufficient BGF cre=
dits.  For details on a message class granularity, use the Egress Credit Oc=
cupancy events.",
+        "UMask": "0x40",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; GV",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.GV",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled because a GV transition (frequency transition) w=
as taking place.",
+        "UMask": "0x80",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - H=
OM",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the HOM message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - D=
RS",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the DRS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - S=
NP",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the SNP message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
DR",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NDR message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CS",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x20",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CB",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCB message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_TxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Bypassed",
+        "EventCode": "0x5",
+        "EventName": "UNC_Q_TxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the Tx flit buffer and pass directly out the QPI Li=
nk. Generally, when data is transmitted across QPI, it will bypass the TxQ =
and pass directly to the link.  However, the TxQ will be used with L0p and =
when LLR occurs, increasing latency to transfer out to the link.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is almost ful=
l, we block some but not all packets.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is totally fu=
ll, we are not allowed to send any packets.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Cycles not Empty",
+        "EventCode": "0x6",
+        "EventName": "UNC_Q_TxL_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the TxQ is =
not empty. Generally, when data is transmitted across QPI, it will bypass t=
he TxQ and pass directly to the link.  However, the TxQ will be used with L=
0p and when LLR occurs, increasing latency to transfer out to the link.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
+        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
+        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency."=
,
+        "UMask": "0x18",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of data flits transmitted over QPI on the DR=
S (Data Response) channel.  DRS flits are used to transmit data with cohere=
ncy.  This does not count data flits transmitted over the NCB channel which=
 transmits non-coherent data.  This includes only the data flits (not the h=
eader).",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of protocol flits transmitted over QPI on th=
e DRS (Data Response) channel.  DRS flits are used to transmit data with co=
herency.  This does not count data flits transmitted over the NCB channel w=
hich transmits non-coherent data.  This includes only the header flits (not=
 the data).  This includes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of flits transmitted over QPI on the home channel.=
",
+        "UMask": "0x6",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of non-request flits transmitted over QPI on the h=
ome channel.  These are most commonly snoop responses, and this event can b=
e used as a proxy for that.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of data request transmitted over QPI on the home c=
hannel.  This basically counts the number of remote memory requests transmi=
tted over QPI.  In conjunction with the local read count in the Home Agent,=
 one can calculate the number of LLC Misses.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of snoop request flits transmitted over QPI.  Thes=
e requests are contained in the snoop channel.  This does not include snoop=
 responses, which are transmitted on the home channel.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass flits.  These packets are generally us=
ed to transmit non-coherent data across QPI.",
+        "UMask": "0xc",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass data flits.  These flits are generally=
 used to transmit non-coherent data across QPI.  This does not include a co=
unt of the DRS (coherent) data flits.  This only counts the data flits, not=
 the NCB headers.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass non-data flits.  These packets are gen=
erally used to transmit non-coherent data across QPI, and the flits counted=
 here are for headers and other non-data flits.  This includes extended hea=
ders.",
+        "UMask": "0x8",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of NCS (non-coherent standard) flits transmitted over QPI.   =
 This includes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets to the lo=
cal socket which use the AK ring.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets destined =
for Route-thru to a remote socket.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations",
+        "EventCode": "0x4",
+        "EventName": "UNC_Q_TxL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Tx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
TxQ and pass directly to the link.  However, the TxQ will be used with L0p =
and when LLR occurs, increasing latency to transfer out to the link.  This =
event can be used in conjunction with the Flit Buffer Occupancy event in or=
der to calculate the average flit buffer lifetime.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy",
+        "EventCode": "0x7",
+        "EventName": "UNC_Q_TxL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of flits in the TxQ. =
 Generally, when data is transmitted across QPI, it will bypass the TxQ and=
 pass directly to the link.  However, the TxQ will be used with L0p and whe=
n LLR occurs, increasing latency to transfer out to the link. This can be u=
sed with the cycles not empty event to track average occupancy, or the allo=
cations event to track average lifetime in the TxQ.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN0"=
,
+        "EventCode": "0x26",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN1"=
,
+        "EventCode": "0x26",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N0",
+        "EventCode": "0x22",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N1",
+        "EventCode": "0x22",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
+        "EventCode": "0x28",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
+        "EventCode": "0x28",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
+        "EventCode": "0x24",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
+        "EventCode": "0x24",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN0"=
,
+        "EventCode": "0x27",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN1"=
,
+        "EventCode": "0x27",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N0",
+        "EventCode": "0x23",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N1",
+        "EventCode": "0x23",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
+        "EventCode": "0x29",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
+        "EventCode": "0x25",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN0"=
,
+        "EventCode": "0x2A",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN1"=
,
+        "EventCode": "0x2A",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for Shar=
ed VN",
+        "EventCode": "0x2A",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN_SHR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N0",
+        "EventCode": "0x1F",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for S=
hared VN",
+        "EventCode": "0x1F",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN_SHR",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "UMask": "0x4",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN0"=
,
+        "EventCode": "0x2B",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN1"=
,
+        "EventCode": "0x2B",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N0",
+        "EventCode": "0x20",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N1",
+        "EventCode": "0x20",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN0"=
,
+        "EventCode": "0x2C",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN1"=
,
+        "EventCode": "0x2C",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N0",
+        "EventCode": "0x21",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN0",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N1",
+        "EventCode": "0x21",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VNA Credits Returned",
+        "EventCode": "0x1C",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VNA credits returned.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "VNA Credits Pending Return - Occupancy",
+        "EventCode": "0x1B",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VNA credits in the Rx side that ar=
e waitng to be returned back across the link.",
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
         "EventCode": "0x1",
-        "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
+        "EventName": "UNC_R3_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the QPI uclk d=
omain.  This could be slightly different than the count in the Ubox because=
 of enable/freeze delays.  However, because the QPI Agent is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 10",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 11",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 12",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 13",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14_16",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 14&16",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 8",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 9",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO_15_17",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 15&17",
+        "UMask": "0x80",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 0",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 2",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 3",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 4",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 5",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 6",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 7",
+        "UMask": "0x80",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA0",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCB Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCS Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "EventCode": "0xB",
+        "EventName": "UNC_R3_IOT_BACKPRESSURE.HUB",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "EventCode": "0xB",
+        "EventName": "UNC_R3_IOT_BACKPRESSURE.SAT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "EventCode": "0xD",
+        "EventName": "UNC_R3_IOT_CTS_HI.CTS2",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "EventCode": "0xD",
+        "EventName": "UNC_R3_IOT_CTS_HI.CTS3",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "EventCode": "0xC",
+        "EventName": "UNC_R3_IOT_CTS_LO.CTS0",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "EventCode": "0xC",
+        "EventName": "UNC_R3_IOT_CTS_LO.CTS1",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; All",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; All",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; All",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 IV Ring in Use; Any",
+        "EventCode": "0xA",
+        "EventName": "UNC_R3_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 IV Ring in Use; Clockwise",
+        "EventCode": "0xA",
+        "EventName": "UNC_R3_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ring Stop Starved; AK",
+        "EventCode": "0xE",
+        "EventName": "UNC_R3_RING_SINK_STARVED.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles the ringstop is in starvati=
on (per ring)",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; HOM",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NDR",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; SNP",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; DRS",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; HOM",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; HOM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; NCB",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; NCS",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; NDR",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; NDR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; SNP",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; SNP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; DRS",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; DRS Ingress=
 Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; HOM",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; HOM Ingress=
 Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCB Ingress=
 Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCS Ingress=
 Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NDR",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NDR Ingress=
 Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; SNP",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; SNP Ingress=
 Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; DRS",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; D=
RS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; HOM",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; NCB",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
CB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; NCS",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
CS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; NDR",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; SNP",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; HOM",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; HOM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NCB",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NCS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NDR",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; NDR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; SNP",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; SNP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R3_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R3_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For AD Ring",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_SBO1_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits receive=
d over QPI that do not hold protocol payload.  When QPI is not in a power s=
aving state, it continuously transmits flits across the link.  When there a=
re no protocol flits to send, it will send IDLE and NULL flits  across.  Th=
ese flits sometimes do carry a payload, such as credit returns, but are gen=
erally not considered part of the QPI bandwidth.",
+        "PublicDescription": "Number of Sbo 1 credits acquired in a given =
cycle, per ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
+        "BriefDescription": "SBo1 Credits Acquired; For BL Ring",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_SBO1_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
-        "UMask": "0x18",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of Sbo 1 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
+        "BriefDescription": "SBo1 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2B",
+        "EventName": "UNC_R3_SBO1_CREDIT_OCCUPANCY.AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
-        "UMask": "0x8",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of Sbo 1 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
+        "BriefDescription": "SBo1 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2B",
+        "EventName": "UNC_R3_SBO1_CREDIT_OCCUPANCY.BL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
  This includes extended headers.",
-        "UMask": "0x10",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of Sbo 1 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; HOM Flits",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO0_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
-        "UMask": "0x6",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO0_BL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO1_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 1; SNP Flits",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO1_BL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
+        "BriefDescription": "Egress CCW NACK; AD CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.DN_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
 transmit non-coherent data across QPI.",
-        "UMask": "0xc",
-        "Unit": "QPI LL"
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.DN_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
+        "PublicDescription": "AK CounterClockwise Egress Queue",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.DN_BL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.UP_AD",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
+        "BriefDescription": "Egress CCW NACK; BL CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.UP_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.UP_BL",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Data Response (DRS).  DRS is generally used to transmit data with coher=
ency.  For example, remote reads and writes, or cache to cache transfers wi=
ll transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for the Home (HOM) message class.  HOM is generally used to send requests, =
request responses, and snoop responses.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
-        "EventCode": "0x3",
-        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data w=
ithout coherency.  For example, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Standard (NCS).  NCS is commonly used for ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; NDR pac=
kets are used to transmit a variety of protocol flits including grants and =
completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that=
 snoop responses flow on the HOM message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations",
-        "EventCode": "0x8",
-        "EventName": "UNC_Q_RxL_INSERTS",
+        "BriefDescription": "VN0 Credit Used; DRS Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN0",
-        "EventCode": "0x9",
-        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN0",
+        "BriefDescription": "VN0 Credit Used; HOM Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN1",
-        "EventCode": "0x9",
-        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN1",
+        "BriefDescription": "VN0 Credit Used; NCB Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCS Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NDR Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; SNP Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN0",
-        "EventCode": "0xC",
-        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN0",
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Data Response (DRS).  DRS is generally used to transmit data with coherency=
.  For example, remote reads and writes, or cache to cache transfers will t=
ransmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
the Home (HOM) message class.  HOM is generally used to send requests, requ=
est responses, and snoop responses.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN1",
-        "EventCode": "0xC",
-        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN1",
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data witho=
ut coherency.  For example, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Standard (NCS).  NCS is commonly used for ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; NDR packets=
 are used to transmit a variety of protocol flits including grants and comp=
letions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that sno=
op responses flow on the HOM message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN0",
-        "EventCode": "0xA",
-        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN0",
+        "BriefDescription": "VN1 Credit Used; DRS Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; HOM Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN1",
-        "EventCode": "0xA",
-        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN1",
+        "BriefDescription": "VN1 Credit Used; NCB Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCS Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NDR Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; SNP Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN0",
-        "EventCode": "0xB",
-        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN0",
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN1",
-        "EventCode": "0xB",
-        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN1",
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; DRS Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Data Response (DRS).  DRS =
is generally used to transmit data with coherency.  For example, remote rea=
ds and writes, or cache to cache transfers will transmit their data using D=
RS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; HOM Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for the Home (HOM) message cla=
ss.  HOM is generally used to send requests, request responses, and snoop r=
esponses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCB Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Broadcast (NC=
B).  NCB is generally used to transmit data without coherency.  For example=
, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCS Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Standard (NCS=
).",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NDR Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; NDR packets are used to transmit a va=
riety of protocol flits including grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; SNP Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Snoop (SNP) message class.=
  SNP is used for outgoing snoops.  Note that snoop responses flow on the H=
OM message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "R3QPI"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN0",
-        "EventCode": "0xE",
-        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN0",
+        "BriefDescription": "Bounce Control",
+        "EventCode": "0xA",
+        "EventName": "UNC_S_BOUNCE_CONTROL",
+        "PerPkg": "1",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "Uncore Clocks",
+        "EventName": "UNC_S_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "FaST wire asserted",
+        "EventCode": "0x9",
+        "EventName": "UNC_S_FAST_ASSERTED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles either the local=
 or incoming distress signals are asserted.  Incoming distress includes up,=
 dn and across.",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; All",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0xf",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.DOWN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in HSX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0xc",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Event",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Event ring polarity.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Odd",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in HSX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0x3",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up and Even",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.UP_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN1",
-        "EventCode": "0xE",
-        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN1",
+        "BriefDescription": "AD Ring In Use; Up and Odd",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN0",
-        "EventCode": "0xD",
-        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN0",
+        "BriefDescription": "AK Ring In Use; All",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
+        "UMask": "0xf",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN1",
-        "EventCode": "0xD",
-        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN1",
+        "BriefDescription": "AK Ring In Use; Down",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.DOWN",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
+        "UMask": "0xc",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - All Packets",
-        "EventCode": "0xB",
-        "EventName": "UNC_Q_RxL_OCCUPANCY",
+        "BriefDescription": "AK Ring In Use; Down and Event",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.DOWN_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Event ring polarity.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - DRS; for VN0",
-        "EventCode": "0x15",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN0",
+        "BriefDescription": "AK Ring In Use; Down and Odd",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.DOWN_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Odd ring polarity.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - DRS; for VN1",
-        "EventCode": "0x15",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN1",
+        "BriefDescription": "AK Ring In Use; Up",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.UP",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
+        "UMask": "0x3",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - HOM; for VN0",
-        "EventCode": "0x18",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN0",
+        "BriefDescription": "AK Ring In Use; Up and Even",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.UP_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - HOM; for VN1",
-        "EventCode": "0x18",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN1",
+        "BriefDescription": "AK Ring In Use; Up and Odd",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - NCB; for VN0",
-        "EventCode": "0x16",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN0",
+        "BriefDescription": "BL Ring in Use; All",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
+        "UMask": "0xf",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - NCB; for VN1",
-        "EventCode": "0x16",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN1",
+        "BriefDescription": "BL Ring in Use; Down",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.DOWN",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
+        "UMask": "0xc",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - NCS; for VN0",
-        "EventCode": "0x17",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN0",
+        "BriefDescription": "BL Ring in Use; Down and Event",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.DOWN_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Event ring polarity.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - NCS; for VN1",
-        "EventCode": "0x17",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN1",
+        "BriefDescription": "BL Ring in Use; Down and Odd",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.DOWN_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Odd ring polarity.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - NDR; for VN0",
-        "EventCode": "0x1A",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN0",
+        "BriefDescription": "BL Ring in Use; Up",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.UP",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
+        "UMask": "0x3",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Even",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.UP_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - NDR; for VN1",
-        "EventCode": "0x1A",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN1",
+        "BriefDescription": "BL Ring in Use; Up and Odd",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - SNP; for VN0",
-        "EventCode": "0x19",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN0",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.AD_CACHE",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "RxQ Occupancy - SNP; for VN1",
-        "EventCode": "0x19",
-        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN1",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - H=
OM",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_DRS",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the HOM message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - D=
RS",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_HOM",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.IV_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the DRS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - S=
NP",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCB",
+        "BriefDescription": "BL Ring in Use; Any",
+        "EventCode": "0x1E",
+        "EventName": "UNC_S_RING_IV_USED.DN",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the SNP message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  There is only 1 IV ring in HSX.  Therefore, i=
f one wants to monitor the Even ring, they should select both UP_EVEN and D=
N_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD=
.; Filters any polarity",
+        "UMask": "0xc",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
DR",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCS",
+        "BriefDescription": "BL Ring in Use; Any",
+        "EventCode": "0x1E",
+        "EventName": "UNC_S_RING_IV_USED.UP",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NDR message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  There is only 1 IV ring in HSX.  Therefore, i=
f one wants to monitor the Even ring, they should select both UP_EVEN and D=
N_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD=
.; Filters any polarity",
+        "UMask": "0x3",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CS",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NDR",
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.AD_CACHE",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.AD_CACHE",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x20",
-        "Unit": "QPI LL"
+        "UMask": "0x1",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CB",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_SNP",
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.AK_CORE",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.AK_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCB message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x10",
-        "Unit": "QPI LL"
+        "UMask": "0x2",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; Egress Credit=
s",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.EGRESS_CREDITS",
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.BL_CORE",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet because there were insufficient BGF cre=
dits.  For details on a message class granularity, use the Egress Credit Oc=
cupancy events.",
-        "UMask": "0x40",
-        "Unit": "QPI LL"
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN0; GV",
-        "EventCode": "0x35",
-        "EventName": "UNC_Q_RxL_STALLS_VN0.GV",
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.IV_CORE",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.IV_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled because a GV transition (frequency transition) w=
as taking place.",
-        "UMask": "0x80",
-        "Unit": "QPI LL"
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - H=
OM",
-        "EventCode": "0x3A",
-        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_DRS",
+        "BriefDescription": "Injection Starvation; AD - Bounces",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the HOM message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
+        "UMask": "0x2",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "Injection Starvation; AD - Credits",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - D=
RS",
-        "EventCode": "0x3A",
-        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_HOM",
+        "BriefDescription": "Injection Starvation; BL - Bounces",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the DRS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - S=
NP",
-        "EventCode": "0x3A",
-        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCB",
+        "BriefDescription": "Injection Starvation; BL - Credits",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the SNP message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
DR",
-        "EventCode": "0x3A",
-        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCS",
+        "BriefDescription": "Bypass; AD - Bounces",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NDR message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Bypass the Sbo Ingress.",
+        "UMask": "0x2",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CS",
-        "EventCode": "0x3A",
-        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NDR",
+        "BriefDescription": "Bypass; AD - Credits",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
-        "UMask": "0x20",
-        "Unit": "QPI LL"
+        "PublicDescription": "Bypass the Sbo Ingress.",
+        "UMask": "0x1",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CB",
-        "EventCode": "0x3A",
-        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_SNP",
+        "BriefDescription": "Bypass; AK",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.AK",
         "PerPkg": "1",
-        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCB message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "PublicDescription": "Bypass the Sbo Ingress.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Cycles in L0p",
-        "EventCode": "0xD",
-        "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
+        "BriefDescription": "Bypass; BL - Bounces",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Bypass the Sbo Ingress.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Cycles in L0",
-        "EventCode": "0xC",
-        "EventName": "UNC_Q_TxL0_POWER_CYCLES",
+        "BriefDescription": "Bypass; BL - Credits",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Bypass the Sbo Ingress.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Bypassed",
-        "EventCode": "0x5",
-        "EventName": "UNC_Q_TxL_BYPASSED",
+        "BriefDescription": "Bypass; IV",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.IV",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the Tx flit buffer and pass directly out the QPI Li=
nk. Generally, when data is transmitted across QPI, it will bypass the TxQ =
and pass directly to the link.  However, the TxQ will be used with L0p and =
when LLR occurs, increasing latency to transfer out to the link.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Bypass the Sbo Ingress.",
+        "UMask": "0x20",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
+        "BriefDescription": "Injection Starvation; AD - Bounces",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is almost ful=
l, we block some but not all packets.",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
-        "EventCode": "0x2",
-        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
+        "BriefDescription": "Injection Starvation; AD - Credits",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is totally fu=
ll, we are not allowed to send any packets.",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Cycles not Empty",
-        "EventCode": "0x6",
-        "EventName": "UNC_Q_TxL_CYCLES_NE",
+        "BriefDescription": "Injection Starvation; AK",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the TxQ is =
not empty. Generally, when data is transmitted across QPI, it will bypass t=
he TxQ and pass directly to the link.  However, the TxQ will be used with L=
0p and when LLR occurs, increasing latency to transfer out to the link.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
+        "UMask": "0x10",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
-        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
+        "BriefDescription": "Injection Starvation; BL - Bounces",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
-        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
+        "BriefDescription": "Injection Starvation; BL - Credits",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
-        "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
+        "BriefDescription": "Injection Starvation; IVF Credit",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.IFV",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency."=
,
-        "UMask": "0x18",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
+        "UMask": "0x40",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
-        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
+        "BriefDescription": "Injection Starvation; IV",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.IV",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
+        "UMask": "0x20",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; AD - Bounces",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x2",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; AD - Credits",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of data flits transmitted over QPI on the DR=
S (Data Response) channel.  DRS flits are used to transmit data with cohere=
ncy.  This does not count data flits transmitted over the NCB channel which=
 transmits non-coherent data.  This includes only the data flits (not the h=
eader).",
-        "UMask": "0x8",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x1",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
-        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
+        "BriefDescription": "Ingress Allocations; AK",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of protocol flits transmitted over QPI on th=
e DRS (Data Response) channel.  DRS flits are used to transmit data with co=
herency.  This does not count data flits transmitted over the NCB channel w=
hich transmits non-coherent data.  This includes only the header flits (not=
 the data).  This includes extended headers.",
+        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
-        "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
+        "BriefDescription": "Ingress Allocations; BL - Bounces",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of flits transmitted over QPI on the home channel.=
",
-        "UMask": "0x6",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
-        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
+        "BriefDescription": "Ingress Allocations; BL - Credits",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of non-request flits transmitted over QPI on the h=
ome channel.  These are most commonly snoop responses, and this event can b=
e used as a proxy for that.",
+        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
-        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
+        "BriefDescription": "Ingress Allocations; IV",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.IV",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of data request transmitted over QPI on the home c=
hannel.  This basically counts the number of remote memory requests transmi=
tted over QPI.  In conjunction with the local read count in the Home Agent,=
 one can calculate the number of LLC Misses.",
+        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x20",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; AD - Bounces",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
-        "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
+        "BriefDescription": "Ingress Occupancy; AD - Credits",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of snoop request flits transmitted over QPI.  Thes=
e requests are contained in the snoop channel.  This does not include snoop=
 responses, which are transmitted on the home channel.",
+        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
-        "EventCode": "0x1",
-        "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
+        "BriefDescription": "Ingress Occupancy; AK",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass flits.  These packets are generally us=
ed to transmit non-coherent data across QPI.",
-        "UMask": "0xc",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x10",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
-        "EventCode": "0x1",
-        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
+        "BriefDescription": "Ingress Occupancy; BL - Bounces",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass data flits.  These flits are generally=
 used to transmit non-coherent data across QPI.  This does not include a co=
unt of the DRS (coherent) data flits.  This only counts the data flits, not=
 the NCB headers.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
-        "EventCode": "0x1",
-        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
+        "BriefDescription": "Ingress Occupancy; BL - Credits",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass non-data flits.  These packets are gen=
erally used to transmit non-coherent data across QPI, and the flits counted=
 here are for headers and other non-data flits.  This includes extended hea=
ders.",
-        "UMask": "0x8",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
-        "EventCode": "0x1",
-        "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
+        "BriefDescription": "Ingress Occupancy; IV",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.IV",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of NCS (non-coherent standard) flits transmitted over QPI.   =
 This includes extended headers.",
-        "UMask": "0x10",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
+        "UMask": "0x20",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
-        "EventCode": "0x1",
-        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
+        "BriefDescription": "UNC_S_TxR_ADS_USED.AD",
+        "EventCode": "0x4",
+        "EventName": "UNC_S_TxR_ADS_USED.AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets to the lo=
cal socket which use the AK ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
-        "EventCode": "0x1",
-        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
+        "BriefDescription": "UNC_S_TxR_ADS_USED.AK",
+        "EventCode": "0x4",
+        "EventName": "UNC_S_TxR_ADS_USED.AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets destined =
for Route-thru to a remote socket.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Allocations",
+        "BriefDescription": "UNC_S_TxR_ADS_USED.BL",
         "EventCode": "0x4",
-        "EventName": "UNC_Q_TxL_INSERTS",
+        "EventName": "UNC_S_TxR_ADS_USED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the QPI Tx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
TxQ and pass directly to the link.  However, the TxQ will be used with L0p =
and when LLR occurs, increasing latency to transfer out to the link.  This =
event can be used in conjunction with the Flit Buffer Occupancy event in or=
der to calculate the average flit buffer lifetime.",
-        "Unit": "QPI LL"
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Occupancy",
-        "EventCode": "0x7",
-        "EventName": "UNC_Q_TxL_OCCUPANCY",
+        "BriefDescription": "Egress Allocations; AD - Bounces",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of flits in the TxQ. =
 Generally, when data is transmitted across QPI, it will bypass the TxQ and=
 pass directly to the link.  However, the TxQ will be used with L0p and whe=
n LLR occurs, increasing latency to transfer out to the link. This can be u=
sed with the cycles not empty event to track average occupancy, or the allo=
cations event to track average lifetime in the TxQ.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x2",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN0"=
,
-        "EventCode": "0x26",
-        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN0",
+        "BriefDescription": "Egress Allocations; AD - Credits",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
+        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN1"=
,
-        "EventCode": "0x26",
-        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN1",
+        "BriefDescription": "Egress Allocations; AK",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.AK",
         "PerPkg": "1",
-        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x10",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N0",
-        "EventCode": "0x22",
-        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN0",
+        "BriefDescription": "Egress Allocations; BL - Bounces",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N1",
-        "EventCode": "0x22",
-        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN1",
+        "BriefDescription": "Egress Allocations; BL - Credits",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
-        "EventCode": "0x28",
-        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN0",
+        "BriefDescription": "Egress Allocations; IV",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.IV",
         "PerPkg": "1",
-        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x20",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
-        "EventCode": "0x28",
-        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN1",
+        "BriefDescription": "Egress Occupancy; AD - Bounces",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
+        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
-        "EventCode": "0x24",
-        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN0",
+        "BriefDescription": "Egress Occupancy; AD - Credits",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
+        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
-        "EventCode": "0x24",
-        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN1",
+        "BriefDescription": "Egress Occupancy; AK",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.AK",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
+        "UMask": "0x10",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN0"=
,
-        "EventCode": "0x27",
-        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN0",
+        "BriefDescription": "Egress Occupancy; BL - Bounces",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN1"=
,
-        "EventCode": "0x27",
-        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN1",
+        "BriefDescription": "Egress Occupancy; BL - Credits",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N0",
-        "EventCode": "0x23",
-        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
+        "BriefDescription": "Egress Occupancy; IV",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.IV",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
+        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
+        "UMask": "0x20",
+        "Unit": "SBOX"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AD Ring",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N1",
-        "EventCode": "0x23",
-        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
+        "BriefDescription": "Injection Starvation; Onto AK Ring",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.AK",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
-        "EventCode": "0x29",
-        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED",
+        "BriefDescription": "Injection Starvation; Onto BL Ring",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
+        "UMask": "0x4",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
-        "EventCode": "0x25",
-        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY",
+        "BriefDescription": "Injection Starvation; Onto IV Ring",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.IV",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
+        "UMask": "0x8",
+        "Unit": "SBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN0"=
,
-        "EventCode": "0x2A",
-        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN0",
+        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-b=
it Fixed Counter",
+        "EventCode": "0xff",
+        "EventName": "UNC_U_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN1"=
,
-        "EventCode": "0x2A",
-        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN1",
+        "BriefDescription": "VLW Received",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for Shar=
ed VN",
-        "EventCode": "0x2A",
-        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN_SHR",
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
-        "UMask": "0x4",
-        "Unit": "QPI LL"
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N0",
-        "EventCode": "0x1F",
-        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN0",
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N1",
-        "EventCode": "0x1F",
-        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN1",
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for S=
hared VN",
-        "EventCode": "0x1F",
-        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN_SHR",
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN0"=
,
-        "EventCode": "0x2B",
-        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN0",
+        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
+        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN1"=
,
-        "EventCode": "0x2B",
-        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN1",
+        "BriefDescription": "RACU Request",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Number outstanding register requests within =
message channel tracker",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N0",
-        "EventCode": "0x20",
-        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN0",
+        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.CMC",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x10",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N1",
-        "EventCode": "0x20",
-        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN1",
+        "BriefDescription": "Monitor Sent to T0; Livelock",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x4",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN0"=
,
-        "EventCode": "0x2C",
-        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN0",
+        "BriefDescription": "Monitor Sent to T0; LTError",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x8",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN1"=
,
-        "EventCode": "0x2C",
-        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN1",
+        "BriefDescription": "Monitor Sent to T0; Monitor T0",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
         "PerPkg": "1",
-        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x1",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N0",
-        "EventCode": "0x21",
-        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN0",
+        "BriefDescription": "Monitor Sent to T0; Monitor T1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
-        "UMask": "0x1",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x2",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N1",
-        "EventCode": "0x21",
-        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN1",
+        "BriefDescription": "Monitor Sent to T0; Other",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.OTHER",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
-        "UMask": "0x2",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; PREQ, PSMI, P2U, Thermal, PCUSMI, PMI",
+        "UMask": "0x80",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "VNA Credits Returned",
-        "EventCode": "0x1C",
-        "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
+        "BriefDescription": "Monitor Sent to T0; Trap",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.TRAP",
         "PerPkg": "1",
-        "PublicDescription": "Number of VNA credits returned.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x40",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "VNA Credits Pending Return - Occupancy",
-        "EventCode": "0x1B",
-        "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
+        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.UMC",
         "PerPkg": "1",
-        "PublicDescription": "Number of VNA credits in the Rx side that ar=
e waitng to be returned back across the link.",
-        "Unit": "QPI LL"
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x20",
+        "Unit": "UBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/broadwellx/uncore-io.json
new file mode 100644
index 000000000000..01e04daf03da
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-io.json
@@ -0,0 +1,555 @@
+[
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "EventCode": "0x1",
+        "EventName": "UNC_R2_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the DRS message class.=
",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCB message class.=
",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCS message class.=
",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the DRS message =
class.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCB message =
class.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCS message =
class.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; All",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Dn",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RING_AK_BOUNCES.DN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Up",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RING_AK_BOUNCES.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; All",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; All",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0xf",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0xc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
B Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
S Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R2_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given R2PCIe =
Ingress queue in each cycles.  This tracks one of the three ring Ingress bu=
ffers.  This can be used with the R2PCIe Ingress Not Empty event to calcula=
te average occupancy or the R2PCIe Ingress Allocations event in order to ca=
lculate average queuing latency.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AD",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AD Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AK",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AK Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; BL",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; BL Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AD",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AD Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AK",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AK Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; BL",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; BL Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AD CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_AK",
+        "PerPkg": "1",
+        "PublicDescription": "AK CounterClockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_AD",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_AK",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_BL",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
deleted file mode 100644
index 43def2582617..000000000000
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
+++ /dev/null
@@ -1,3242 +0,0 @@
-[
-    {
-        "BriefDescription": "Total Write Cache Occupancy; Any Source",
-        "EventCode": "0x12",
-        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks all requests f=
rom any source port.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Total Write Cache Occupancy; Select Source",
-        "EventCode": "0x12",
-        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks only those req=
uests that come from the port specified in the IRP_PmonFilter.OrderingQ reg=
ister.  This register allows one to select one specific queue.  It is not p=
ossible to monitor multiple queues at a time.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Clocks in the IRP",
-        "EventName": "UNC_I_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of clocks in the IRP.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; CLFlush",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x80",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; CRd",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; DRd",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.DRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; PCIRdCur",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; PCIItoM",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; RFO",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.RFO",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; WbMtoI",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of A=
tomic Transactions as Secondary",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of R=
ead Transactions as Secondary",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of W=
rite Transactions as Secondary",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.FAST_REJ",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.FAST_REQ",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Requests"=
,
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.FAST_XFER",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Transfers=
 From Primary to Secondary",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints=
 From Primary to Secondary",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.PF_TIMEOUT",
-        "PerPkg": "1",
-        "PublicDescription": "Indicates the fetch for a previous prefetch =
wasn't accepted by the prefetch.   This happens in the case of a prefetch T=
imeOut",
-        "UMask": "0x80",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Data Throttled",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.DATA_THROTTLE",
-        "PerPkg": "1",
-        "PublicDescription": "IRP throttled switch data",
-        "UMask": "0x80",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.LOST_FWD",
-        "PerPkg": "1",
-        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Received Invalid",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Received Valid",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_E",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_I",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_M",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_S",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "AK Ingress Occupancy",
-        "EventCode": "0xA",
-        "EventName": "UNC_I_RxR_AK_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
-        "EventCode": "0x4",
-        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "BL Ingress Occupancy - DRS",
-        "EventCode": "0x1",
-        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_DRS_OCCUPANCY",
-        "EventCode": "0x7",
-        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
-        "EventCode": "0x5",
-        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "BL Ingress Occupancy - NCB",
-        "EventCode": "0x2",
-        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCB_OCCUPANCY",
-        "EventCode": "0x8",
-        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
-        "EventCode": "0x6",
-        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "BL Ingress Occupancy - NCS",
-        "EventCode": "0x3",
-        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCS_OCCUPANCY",
-        "EventCode": "0x9",
-        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Hit E or S",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Hit E or S",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Hit I",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Hit I",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Hit M",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Hit M",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Miss",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.MISS",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Miss",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; SnpCode",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : SnpCode",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; SnpData",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : SnpData",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; SnpInv",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : SnpInv",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Atomic",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of atomic =
transactions",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Other",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.OTHER",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of 'other'=
 kinds of transactions.",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of read pr=
efetches.",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Reads",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.READS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only read requests (n=
ot including read prefetches).",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Writes",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.WRITES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Write Prefetches",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of write p=
refetches.",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "No AD Egress Credit Stalls",
-        "EventCode": "0x18",
-        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number times when it is not possi=
ble to issue a request to the R2PCIe because there are no AD Egress Credits=
 available.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "No BL Egress Credit Stalls",
-        "EventCode": "0x19",
-        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number times when it is not possi=
ble to issue data to the R2PCIe because there are no BL Egress Credits avai=
lable.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Read Requests",
-        "EventCode": "0xE",
-        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Read Requests",
-        "EventCode": "0xF",
-        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Request Queue Occupancy",
-        "EventCode": "0xD",
-        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Number of uclks in domain",
-        "EventCode": "0x1",
-        "EventName": "UNC_R2_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
-        "EventCode": "0x33",
-        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the DRS message class.=
",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
-        "EventCode": "0x33",
-        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCB message class.=
",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
-        "EventCode": "0x33",
-        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCS message class.=
",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
-        "EventCode": "0x32",
-        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the DRS message =
class.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
-        "EventCode": "0x32",
-        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCB message =
class.",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
-        "EventCode": "0x32",
-        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCS message =
class.",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; All",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "AK Ingress Bounced; Dn",
-        "EventCode": "0x12",
-        "EventName": "UNC_R2_RING_AK_BOUNCES.DN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "AK Ingress Bounced; Up",
-        "EventCode": "0x12",
-        "EventName": "UNC_R2_RING_AK_BOUNCES.UP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; All",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; All",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Any",
-        "EventCode": "0xA",
-        "EventName": "UNC_R2_RING_IV_USED.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
-        "EventCode": "0xA",
-        "EventName": "UNC_R2_RING_IV_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Clockwise",
-        "EventCode": "0xA",
-        "EventName": "UNC_R2_RING_IV_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "EventCode": "0x10",
-        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCB Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "EventCode": "0x10",
-        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCS Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCB",
-        "EventCode": "0x11",
-        "EventName": "UNC_R2_RxR_INSERTS.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
B Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCS",
-        "EventCode": "0x11",
-        "EventName": "UNC_R2_RxR_INSERTS.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
S Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
-        "EventCode": "0x13",
-        "EventName": "UNC_R2_RxR_OCCUPANCY.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given R2PCIe =
Ingress queue in each cycles.  This tracks one of the three ring Ingress bu=
ffers.  This can be used with the R2PCIe Ingress Not Empty event to calcula=
te average occupancy or the R2PCIe Ingress Allocations event in order to ca=
lculate average queuing latency.; DRS Ingress Queue",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
-        "EventCode": "0x28",
-        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
-        "EventCode": "0x28",
-        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
-        "EventCode": "0x2A",
-        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
-        "EventCode": "0x2A",
-        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; AD",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AD Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; AK",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AK Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; BL",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; BL Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Not Empty; AD",
-        "EventCode": "0x23",
-        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AD Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Not Empty; AK",
-        "EventCode": "0x23",
-        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AK Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Not Empty; BL",
-        "EventCode": "0x23",
-        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; BL Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AD CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.DN_AD",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AK CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.DN_AK",
-        "PerPkg": "1",
-        "PublicDescription": "AK CounterClockwise Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.DN_BL",
-        "PerPkg": "1",
-        "PublicDescription": "BL CounterClockwise Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AK CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.UP_AD",
-        "PerPkg": "1",
-        "PublicDescription": "BL CounterClockwise Egress Queue",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.UP_AK",
-        "PerPkg": "1",
-        "PublicDescription": "AD Clockwise Egress Queue",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.UP_BL",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Number of uclks in domain",
-        "EventCode": "0x1",
-        "EventName": "UNC_R3_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of uclks in the QPI uclk d=
omain.  This could be slightly different than the count in the Ubox because=
 of enable/freeze delays.  However, because the QPI Agent is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 10",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 11",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 12",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 13",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14_16",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 14&16",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 8",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 9",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x1F",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO_15_17",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 15&17",
-        "UMask": "0x80",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 0",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 1",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 2",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 3",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 4",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 5",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 6",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 7",
-        "UMask": "0x80",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA0",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA1",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCB Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2D",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCS Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "IOT Backpressure",
-        "EventCode": "0xB",
-        "EventName": "UNC_R3_IOT_BACKPRESSURE.HUB",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "IOT Backpressure",
-        "EventCode": "0xB",
-        "EventName": "UNC_R3_IOT_BACKPRESSURE.SAT",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
-        "EventCode": "0xD",
-        "EventName": "UNC_R3_IOT_CTS_HI.CTS2",
-        "PerPkg": "1",
-        "PublicDescription": "Debug Mask/Match Tie-Ins",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
-        "EventCode": "0xD",
-        "EventName": "UNC_R3_IOT_CTS_HI.CTS3",
-        "PerPkg": "1",
-        "PublicDescription": "Debug Mask/Match Tie-Ins",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
-        "EventCode": "0xC",
-        "EventName": "UNC_R3_IOT_CTS_LO.CTS0",
-        "PerPkg": "1",
-        "PublicDescription": "Debug Mask/Match Tie-Ins",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
-        "EventCode": "0xC",
-        "EventName": "UNC_R3_IOT_CTS_LO.CTS1",
-        "PerPkg": "1",
-        "PublicDescription": "Debug Mask/Match Tie-Ins",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 HOM Messages",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 NDR Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 SNP Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2E",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2E",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2E",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2E",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 HOM Messages",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 NDR Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 SNP Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2F",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; All",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; All",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; All",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 IV Ring in Use; Any",
-        "EventCode": "0xA",
-        "EventName": "UNC_R3_RING_IV_USED.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0xf",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 IV Ring in Use; Clockwise",
-        "EventCode": "0xA",
-        "EventName": "UNC_R3_RING_IV_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0x3",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ring Stop Starved; AK",
-        "EventCode": "0xE",
-        "EventName": "UNC_R3_RING_SINK_STARVED.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles the ringstop is in starvati=
on (per ring)",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; HOM",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NDR",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; SNP",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Cycles Not Empty; DRS",
-        "EventCode": "0x14",
-        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; DRS Ingress Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Cycles Not Empty; HOM",
-        "EventCode": "0x14",
-        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; HOM Ingress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Cycles Not Empty; NCB",
-        "EventCode": "0x14",
-        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; NCB Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Cycles Not Empty; NCS",
-        "EventCode": "0x14",
-        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; NCS Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Cycles Not Empty; NDR",
-        "EventCode": "0x14",
-        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; NDR Ingress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Cycles Not Empty; SNP",
-        "EventCode": "0x14",
-        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI VN1=
  Ingress is not empty.  This tracks one of the three rings that are used b=
y the QPI agent.  This can be used in conjunction with the QPI VN1  Ingress=
 Occupancy Accumulator event in order to calculate average queue occupancy.=
  Multiple ingress buffers can be tracked at a given time using multiple co=
unters.; SNP Ingress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; DRS",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; DRS Ingress=
 Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; HOM",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; HOM Ingress=
 Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCB",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCB Ingress=
 Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCS",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCS Ingress=
 Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NDR",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NDR Ingress=
 Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; SNP",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; SNP Ingress=
 Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Allocations; DRS",
-        "EventCode": "0x15",
-        "EventName": "UNC_R3_RxR_INSERTS_VN1.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; D=
RS Ingress Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Allocations; HOM",
-        "EventCode": "0x15",
-        "EventName": "UNC_R3_RxR_INSERTS_VN1.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Allocations; NCB",
-        "EventCode": "0x15",
-        "EventName": "UNC_R3_RxR_INSERTS_VN1.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
CB Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Allocations; NCS",
-        "EventCode": "0x15",
-        "EventName": "UNC_R3_RxR_INSERTS_VN1.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
CS Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Allocations; NDR",
-        "EventCode": "0x15",
-        "EventName": "UNC_R3_RxR_INSERTS_VN1.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Allocations; SNP",
-        "EventCode": "0x15",
-        "EventName": "UNC_R3_RxR_INSERTS_VN1.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I VN1  Ingress.  This tracks one of the three rings that are used by the QP=
I agent.  This can be used in conjunction with the QPI VN1  Ingress Occupan=
cy Accumulator event in order to calculate average queue latency.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Occupancy Accumulator; DRS",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; DRS Ingress Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Occupancy Accumulator; HOM",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; HOM Ingress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NCB",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; NCB Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NCS",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; NCS Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NDR",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; NDR Ingress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Ingress Occupancy Accumulator; SNP",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI VN1=
  Ingress queue in each cycles.  This tracks one of the three ring Ingress =
buffers.  This can be used with the QPI VN1  Ingress Not Empty event to cal=
culate average occupancy or the QPI VN1  Ingress Allocations event in order=
 to calculate average queuing latency.; SNP Ingress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
-        "EventCode": "0x28",
-        "EventName": "UNC_R3_SBO0_CREDITS_ACQUIRED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
-        "EventCode": "0x28",
-        "EventName": "UNC_R3_SBO0_CREDITS_ACQUIRED.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
-        "EventCode": "0x2A",
-        "EventName": "UNC_R3_SBO0_CREDIT_OCCUPANCY.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
-        "EventCode": "0x2A",
-        "EventName": "UNC_R3_SBO0_CREDIT_OCCUPANCY.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo1 Credits Acquired; For AD Ring",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_SBO1_CREDITS_ACQUIRED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 1 credits acquired in a given =
cycle, per ring.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo1 Credits Acquired; For BL Ring",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_SBO1_CREDITS_ACQUIRED.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 1 credits acquired in a given =
cycle, per ring.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo1 Credits Occupancy; For AD Ring",
-        "EventCode": "0x2B",
-        "EventName": "UNC_R3_SBO1_CREDIT_OCCUPANCY.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 1 credits in use in a given cy=
cle, per ring.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "SBo1 Credits Occupancy; For BL Ring",
-        "EventCode": "0x2B",
-        "EventName": "UNC_R3_SBO1_CREDIT_OCCUPANCY.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Sbo 1 credits in use in a given cy=
cle, per ring.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO0_AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO0_BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO1_AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
-        "EventCode": "0x2C",
-        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO1_BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AD CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK.DN_AD",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AK CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK.DN_AK",
-        "PerPkg": "1",
-        "PublicDescription": "AK CounterClockwise Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK.DN_BL",
-        "PerPkg": "1",
-        "PublicDescription": "BL CounterClockwise Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AK CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK.UP_AD",
-        "PerPkg": "1",
-        "PublicDescription": "BL CounterClockwise Egress Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK.UP_AK",
-        "PerPkg": "1",
-        "PublicDescription": "AD Clockwise Egress Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK.UP_BL",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Data Response (DRS).  DRS is generally used to transmit data with coher=
ency.  For example, remote reads and writes, or cache to cache transfers wi=
ll transmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for the Home (HOM) message class.  HOM is generally used to send requests, =
request responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data w=
ithout coherency.  For example, non-coherent read data returns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Standard (NCS).  NCS is commonly used for ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; NDR pac=
kets are used to transmit a variety of protocol flits including grants and =
completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that=
 snoop responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; DRS Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; HOM Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; NCB Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; NCS Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; NDR Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; SNP Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Data Response (DRS).  DRS is generally used to transmit data with coherency=
.  For example, remote reads and writes, or cache to cache transfers will t=
ransmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
the Home (HOM) message class.  HOM is generally used to send requests, requ=
est responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data witho=
ut coherency.  For example, non-coherent read data returns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Standard (NCS).  NCS is commonly used for ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; NDR packets=
 are used to transmit a variety of protocol flits including grants and comp=
letions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that sno=
op responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; DRS Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; HOM Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; NCB Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; NCS Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; NDR Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; SNP Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
-        "EventCode": "0x33",
-        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
-        "EventCode": "0x33",
-        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; DRS Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Data Response (DRS).  DRS =
is generally used to transmit data with coherency.  For example, remote rea=
ds and writes, or cache to cache transfers will transmit their data using D=
RS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; HOM Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for the Home (HOM) message cla=
ss.  HOM is generally used to send requests, request responses, and snoop r=
esponses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; NCB Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Broadcast (NC=
B).  NCB is generally used to transmit data without coherency.  For example=
, non-coherent read data returns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; NCS Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Standard (NCS=
).",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; NDR Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; NDR packets are used to transmit a va=
riety of protocol flits including grants and completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; SNP Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Snoop (SNP) message class.=
  SNP is used for outgoing snoops.  Note that snoop responses flow on the H=
OM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Bounce Control",
-        "EventCode": "0xA",
-        "EventName": "UNC_S_BOUNCE_CONTROL",
-        "PerPkg": "1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Uncore Clocks",
-        "EventName": "UNC_S_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "FaST wire asserted",
-        "EventCode": "0x9",
-        "EventName": "UNC_S_FAST_ASSERTED",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles either the local=
 or incoming distress signals are asserted.  Incoming distress includes up,=
 dn and across.",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; All",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0xf",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; Down",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.DOWN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in HSX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0xc",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; Down and Event",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.DOWN_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Event ring polarity.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; Down and Odd",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.DOWN_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; Up",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.UP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in HSX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0x3",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; Up and Even",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.UP_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AD Ring In Use; Up and Odd",
-        "EventCode": "0x1B",
-        "EventName": "UNC_S_RING_AD_USED.UP_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; All",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
-        "UMask": "0xf",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; Down",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.DOWN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
-        "UMask": "0xc",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; Down and Event",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.DOWN_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Event ring polarity.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; Down and Odd",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.DOWN_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Odd ring polarity.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; Up",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.UP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
-        "UMask": "0x3",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; Up and Even",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.UP_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Even ring polarity.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "AK Ring In Use; Up and Odd",
-        "EventCode": "0x1C",
-        "EventName": "UNC_S_RING_AK_USED.UP_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Odd ring polarity.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; All",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.ALL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
-        "UMask": "0xf",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Down",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.DOWN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
-        "UMask": "0xc",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Down and Event",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.DOWN_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Event ring polarity.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Down and Odd",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.DOWN_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Down and Odd ring polarity.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Up",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.UP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in HSX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.",
-        "UMask": "0x3",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Up and Even",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.UP_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Even ring polarity.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Up and Odd",
-        "EventCode": "0x1D",
-        "EventName": "UNC_S_RING_BL_USED.UP_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop. We really have two rings in BDX -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the UP d=
irection is on the clockwise ring and DN is on the counter-clockwise ring. =
 On the right side of the ring, this is reversed.  The first half of the CB=
os are on the left side of the ring, and the 2nd half are on the right side=
 of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is N=
OT the same ring as CBo 2 UP AD because they are on opposite sides of the r=
ing.; Filters for the Up and Odd ring polarity.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.",
-        "EventCode": "0x5",
-        "EventName": "UNC_S_RING_BOUNCES.AD_CACHE",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
-        "EventCode": "0x5",
-        "EventName": "UNC_S_RING_BOUNCES.AK_CORE",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
-        "EventCode": "0x5",
-        "EventName": "UNC_S_RING_BOUNCES.BL_CORE",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
-        "EventCode": "0x5",
-        "EventName": "UNC_S_RING_BOUNCES.IV_CORE",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Any",
-        "EventCode": "0x1E",
-        "EventName": "UNC_S_RING_IV_USED.DN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  There is only 1 IV ring in HSX.  Therefore, i=
f one wants to monitor the Even ring, they should select both UP_EVEN and D=
N_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD=
.; Filters any polarity",
-        "UMask": "0xc",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "BL Ring in Use; Any",
-        "EventCode": "0x1E",
-        "EventName": "UNC_S_RING_IV_USED.UP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  There is only 1 IV ring in HSX.  Therefore, i=
f one wants to monitor the Even ring, they should select both UP_EVEN and D=
N_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD=
.; Filters any polarity",
-        "UMask": "0x3",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_RING_SINK_STARVED.AD_CACHE",
-        "EventCode": "0x6",
-        "EventName": "UNC_S_RING_SINK_STARVED.AD_CACHE",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_RING_SINK_STARVED.AK_CORE",
-        "EventCode": "0x6",
-        "EventName": "UNC_S_RING_SINK_STARVED.AK_CORE",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_RING_SINK_STARVED.BL_CORE",
-        "EventCode": "0x6",
-        "EventName": "UNC_S_RING_SINK_STARVED.BL_CORE",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_RING_SINK_STARVED.IV_CORE",
-        "EventCode": "0x6",
-        "EventName": "UNC_S_RING_SINK_STARVED.IV_CORE",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; AD - Bounces",
-        "EventCode": "0x15",
-        "EventName": "UNC_S_RxR_BUSY_STARVED.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; AD - Credits",
-        "EventCode": "0x15",
-        "EventName": "UNC_S_RxR_BUSY_STARVED.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; BL - Bounces",
-        "EventCode": "0x15",
-        "EventName": "UNC_S_RxR_BUSY_STARVED.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; BL - Credits",
-        "EventCode": "0x15",
-        "EventName": "UNC_S_RxR_BUSY_STARVED.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress because a message (credited/bounceable) is  being sent.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Bypass; AD - Bounces",
-        "EventCode": "0x12",
-        "EventName": "UNC_S_RxR_BYPASS.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Bypass the Sbo Ingress.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Bypass; AD - Credits",
-        "EventCode": "0x12",
-        "EventName": "UNC_S_RxR_BYPASS.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Bypass the Sbo Ingress.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Bypass; AK",
-        "EventCode": "0x12",
-        "EventName": "UNC_S_RxR_BYPASS.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Bypass the Sbo Ingress.",
-        "UMask": "0x10",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Bypass; BL - Bounces",
-        "EventCode": "0x12",
-        "EventName": "UNC_S_RxR_BYPASS.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Bypass the Sbo Ingress.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Bypass; BL - Credits",
-        "EventCode": "0x12",
-        "EventName": "UNC_S_RxR_BYPASS.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Bypass the Sbo Ingress.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Bypass; IV",
-        "EventCode": "0x12",
-        "EventName": "UNC_S_RxR_BYPASS.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Bypass the Sbo Ingress.",
-        "UMask": "0x20",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; AD - Bounces",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; AD - Credits",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; AK",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x10",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; BL - Bounces",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; BL - Credits",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; IVF Credit",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.IFV",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x40",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; IV",
-        "EventCode": "0x14",
-        "EventName": "UNC_S_RxR_CRD_STARVED.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Ingress cannot send a transaction onto the ring for=
 a long period of time.  In this case, the Ingress but unable to forward to=
 Egress due to lack of credit.",
-        "UMask": "0x20",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; AD - Bounces",
-        "EventCode": "0x13",
-        "EventName": "UNC_S_RxR_INSERTS.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; AD - Credits",
-        "EventCode": "0x13",
-        "EventName": "UNC_S_RxR_INSERTS.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; AK",
-        "EventCode": "0x13",
-        "EventName": "UNC_S_RxR_INSERTS.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x10",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; BL - Bounces",
-        "EventCode": "0x13",
-        "EventName": "UNC_S_RxR_INSERTS.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; BL - Credits",
-        "EventCode": "0x13",
-        "EventName": "UNC_S_RxR_INSERTS.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; IV",
-        "EventCode": "0x13",
-        "EventName": "UNC_S_RxR_INSERTS.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Ingress  =
The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x20",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy; AD - Bounces",
-        "EventCode": "0x11",
-        "EventName": "UNC_S_RxR_OCCUPANCY.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy; AD - Credits",
-        "EventCode": "0x11",
-        "EventName": "UNC_S_RxR_OCCUPANCY.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy; AK",
-        "EventCode": "0x11",
-        "EventName": "UNC_S_RxR_OCCUPANCY.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x10",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy; BL - Bounces",
-        "EventCode": "0x11",
-        "EventName": "UNC_S_RxR_OCCUPANCY.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy; BL - Credits",
-        "EventCode": "0x11",
-        "EventName": "UNC_S_RxR_OCCUPANCY.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy; IV",
-        "EventCode": "0x11",
-        "EventName": "UNC_S_RxR_OCCUPANCY.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Ingress buffers in t=
he Sbo.  The Ingress is used to queue up requests received from the ring.",
-        "UMask": "0x20",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_TxR_ADS_USED.AD",
-        "EventCode": "0x4",
-        "EventName": "UNC_S_TxR_ADS_USED.AD",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_TxR_ADS_USED.AK",
-        "EventCode": "0x4",
-        "EventName": "UNC_S_TxR_ADS_USED.AK",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "UNC_S_TxR_ADS_USED.BL",
-        "EventCode": "0x4",
-        "EventName": "UNC_S_TxR_ADS_USED.BL",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Allocations; AD - Bounces",
-        "EventCode": "0x2",
-        "EventName": "UNC_S_TxR_INSERTS.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Allocations; AD - Credits",
-        "EventCode": "0x2",
-        "EventName": "UNC_S_TxR_INSERTS.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Allocations; AK",
-        "EventCode": "0x2",
-        "EventName": "UNC_S_TxR_INSERTS.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
-        "UMask": "0x10",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Allocations; BL - Bounces",
-        "EventCode": "0x2",
-        "EventName": "UNC_S_TxR_INSERTS.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Allocations; BL - Credits",
-        "EventCode": "0x2",
-        "EventName": "UNC_S_TxR_INSERTS.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Allocations; IV",
-        "EventCode": "0x2",
-        "EventName": "UNC_S_TxR_INSERTS.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Sbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
-        "UMask": "0x20",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Occupancy; AD - Bounces",
-        "EventCode": "0x1",
-        "EventName": "UNC_S_TxR_OCCUPANCY.AD_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Occupancy; AD - Credits",
-        "EventCode": "0x1",
-        "EventName": "UNC_S_TxR_OCCUPANCY.AD_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Occupancy; AK",
-        "EventCode": "0x1",
-        "EventName": "UNC_S_TxR_OCCUPANCY.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
-        "UMask": "0x10",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Occupancy; BL - Bounces",
-        "EventCode": "0x1",
-        "EventName": "UNC_S_TxR_OCCUPANCY.BL_BNC",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Occupancy; BL - Credits",
-        "EventCode": "0x1",
-        "EventName": "UNC_S_TxR_OCCUPANCY.BL_CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Egress Occupancy; IV",
-        "EventCode": "0x1",
-        "EventName": "UNC_S_TxR_OCCUPANCY.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Occupancy event for the Egress buffers in th=
e Sbo.  The egress is used to queue up requests destined for the ring.",
-        "UMask": "0x20",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; Onto AD Ring",
-        "EventCode": "0x3",
-        "EventName": "UNC_S_TxR_STARVED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
-        "UMask": "0x1",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; Onto AK Ring",
-        "EventCode": "0x3",
-        "EventName": "UNC_S_TxR_STARVED.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
-        "UMask": "0x2",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; Onto BL Ring",
-        "EventCode": "0x3",
-        "EventName": "UNC_S_TxR_STARVED.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
-        "UMask": "0x4",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Injection Starvation; Onto IV Ring",
-        "EventCode": "0x3",
-        "EventName": "UNC_S_TxR_STARVED.IV",
-        "PerPkg": "1",
-        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
-        "UMask": "0x8",
-        "Unit": "SBO"
-    },
-    {
-        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-b=
it Fixed Counter",
-        "EventCode": "0xff",
-        "EventName": "UNC_U_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "VLW Received",
-        "EventCode": "0x42",
-        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
-        "PerPkg": "1",
-        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
-        "EventCode": "0x45",
-        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
-        "PerPkg": "1",
-        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "RACU Request",
-        "EventCode": "0x46",
-        "EventName": "UNC_U_RACU_REQUESTS",
-        "PerPkg": "1",
-        "PublicDescription": "Number outstanding register requests within =
message channel tracker",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.CMC",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x10",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Livelock",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; LTError",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Monitor T0",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Monitor T1",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Other",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.OTHER",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; PREQ, PSMI, P2U, Thermal, PCUSMI, PMI",
-        "UMask": "0x80",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Trap",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.TRAP",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x40",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.UMC",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x20",
-        "Unit": "UBOX"
-    }
-]
--=20
2.40.0.577.gac1e443424-goog

