Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773A96B70D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCMIGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCMIFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:05:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFC59410;
        Mon, 13 Mar 2023 01:02:49 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D7pWne007420;
        Mon, 13 Mar 2023 08:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=W3sSDkvUeJHf9tD3g5PeDz9HU2CPI9L7sOUY3ZAn8SQ=;
 b=hK75zh4A9hr7U0DSLZS/uzhVk4U1Gipa7TO3KwbMpDUJl4tlOt2wLrZ3/Lx7mOMtwH4T
 5HfFf8O//h1cmvQ5BB92bw72E78xeeM50DxrzN+16x7VRjjV7s4jxgLdLoEvo9GKLOUf
 rUoLpJGCoNfVm7a+gC78v8Gxhl0qgLAsh23AB0+q6u2wLU0wEgX7E0J0yIRtfm8FozNx
 3uBj5CIf51GjB1Bh2NO4Cu5pASGCEG+sSI5smWGouNwzL+AwBir4c0TOLBFeY44bMnhF
 pBngnjhUXPd5VEQRJEMnwboVo/hJLx0wiZt3D9z+TiLomwAzC/uSUYo5ayjrjAI3VB6H DA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93fs65c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:02:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2kieq028609;
        Mon, 13 Mar 2023 08:02:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96k058-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:02:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D827d956361380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:02:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 329DD204B4;
        Mon, 13 Mar 2023 08:02:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7D5520536;
        Mon, 13 Mar 2023 08:02:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 08:02:06 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/6] tools/perf/json: Add common metrics for s390
Date:   Mon, 13 Mar 2023 09:01:56 +0100
Message-Id: <20230313080201.2440201-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l3efZP7XxXzcOHKReJtlnggfpeZEis1L
X-Proofpoint-ORIG-GUID: l3efZP7XxXzcOHKReJtlnggfpeZEis1L
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 3 metrics for s390 machines:
- Cycles per instruction: Amount of CPU cycles used per instructions,
  named cpi.
- Problem state ratio: Ratio of instructions executed in problem state
  compared to total number of instructions, named prbstate.
- Level one instruction and data cache misses per 100 instructions,
  named l1mp.

For details about the formulas see this documentation:
https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf

Outpuf after:
 # ./perf stat -M cpi -- dd if=/dev/zero of=/dev/null bs=1M count=10K
 10240+0 records in
 10240+0 records out
 10737418240 bytes (11 GB, 10 GiB) copied, 1.30151 s, 8.2 GB/s

Performance counter stats for 'dd if=/dev/zero of=/dev/null .....':

  6,779,778,802      CPU_CYCLES              #     1.96 cpi
  3,461,975,090      INSTRUCTIONS

  1.306873021 seconds time elapsed

  0.001034000 seconds user
  1.305677000 seconds sys
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z13/transaction.json  | 15 +++++++++++++++
 .../pmu-events/arch/s390/cf_z14/transaction.json  | 15 +++++++++++++++
 .../pmu-events/arch/s390/cf_z15/transaction.json  | 15 +++++++++++++++
 .../pmu-events/arch/s390/cf_z16/transaction.json  | 15 +++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
index 1a0034f79f73..86bf83b4504e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
@@ -3,5 +3,20 @@
     "BriefDescription": "Transaction count",
     "MetricName": "transaction",
     "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  },
+  {
+    "BriefDescription": "Cycles per Instruction",
+    "MetricName": "cpi",
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Problem State Instruction Ratio",
+    "MetricName": "prbstate",
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
+  },
+  {
+    "BriefDescription": "Level One Miss per 100 Instructions",
+    "MetricName": "l1mp",
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
index 1a0034f79f73..86bf83b4504e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
@@ -3,5 +3,20 @@
     "BriefDescription": "Transaction count",
     "MetricName": "transaction",
     "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  },
+  {
+    "BriefDescription": "Cycles per Instruction",
+    "MetricName": "cpi",
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Problem State Instruction Ratio",
+    "MetricName": "prbstate",
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
+  },
+  {
+    "BriefDescription": "Level One Miss per 100 Instructions",
+    "MetricName": "l1mp",
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
index 1a0034f79f73..86bf83b4504e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
@@ -3,5 +3,20 @@
     "BriefDescription": "Transaction count",
     "MetricName": "transaction",
     "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  },
+  {
+    "BriefDescription": "Cycles per Instruction",
+    "MetricName": "cpi",
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Problem State Instruction Ratio",
+    "MetricName": "prbstate",
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
+  },
+  {
+    "BriefDescription": "Level One Miss per 100 Instructions",
+    "MetricName": "l1mp",
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index 1a0034f79f73..86bf83b4504e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -3,5 +3,20 @@
     "BriefDescription": "Transaction count",
     "MetricName": "transaction",
     "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  },
+  {
+    "BriefDescription": "Cycles per Instruction",
+    "MetricName": "cpi",
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Problem State Instruction Ratio",
+    "MetricName": "prbstate",
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
+  },
+  {
+    "BriefDescription": "Level One Miss per 100 Instructions",
+    "MetricName": "l1mp",
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
   }
 ]
-- 
2.39.1

