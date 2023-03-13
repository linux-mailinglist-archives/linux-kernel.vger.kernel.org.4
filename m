Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9BE6B712D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCMIaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCMI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:29:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748013646C;
        Mon, 13 Mar 2023 01:29:55 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D82RE4007039;
        Mon, 13 Mar 2023 08:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=+RbjSmD6FJZnhR3wntxnHXaRrbaADvVd/IxWP8Tt+HE=;
 b=sgZP3HrS9tYKYPi0Joa41GhFEVXahPgUzlGksIgf4KqjAC6r3b5e199xGEj52lMYA1pR
 mnOFz1Cb4Ly/0B1WiaZ+yrtDPCe2YOHkR8TF6ZED+r+t16rxo8SRMI+VmCcamMpZFsQS
 mHEj7jzpNlfcSGRyzdCqcqr4Yvo0YiYEfFmBi37bHKTCoVO7p6Qzrf86LWlF9s5D6AZN
 siHPJfTc4sNfVvOpWPLr9kn0eHeruGwMJOwuixvIKE1JB0JgA1gkyu+YqM2DU66X8xVg
 Fy5DOz4zxfwqawLY8cZ6tbIAv9sPmbhA1MAN4wiILKuKtRLtEbI/UsSiD6p5Kg5cfm0O DQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93fs6set-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:29:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2Q4Zb029926;
        Mon, 13 Mar 2023 08:29:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfb25d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:29:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D8ThJ344958056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:29:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63D842054F;
        Mon, 13 Mar 2023 08:02:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D1620547;
        Mon, 13 Mar 2023 08:02:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 08:02:15 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 6/6] tools/perf/json: Add metric for tlb and cache s390
Date:   Mon, 13 Mar 2023 09:02:01 +0100
Message-Id: <20230313080201.2440201-6-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lt20Sa2K532UG0M9Ww18QPcqVUsOnQo_
X-Proofpoint-ORIG-GUID: Lt20Sa2K532UG0M9Ww18QPcqVUsOnQo_
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

Add metrics for tlb and cache statistics:
- finite_cpi: Cycles per Instructions from Finite cache/memory
- est_cpi: Estimated Instruction Complexity CPI infinite Level 1
- scpl1m: Estimated Sourcing Cycles per Level 1 Miss
- tlb_percent: Estimated TLB CPU percentage of Total CPU
- tlb_miss: Estimated Cycles per TLB Miss

For details about the formulas see this documentation:
https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf

Output after:
 # ./perf stat -M tlb_miss -- dd if=/dev/zero of=/dev/null bs=1M count=10K
 ... dd output removed

 Performance counter stats for
 			'dd if=/dev/zero of=/dev/null bs=1M count=10K':

           667,726      DTLB2_MISSES             #   440.96 tlb_miss
               198      ITLB2_WRITES
       795,170,260      L1C_TLB2_MISSES
             9,478      ITLB2_MISSES
               820      DTLB2_WRITES
     1,197,126,869      L1D_PENALTY_CYCLES
         2,457,447      L1I_PENALTY_CYCLES

       1.249342187 seconds time elapsed

       0.001030000 seconds user
       1.248105000 seconds sys

 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../arch/s390/cf_z13/transaction.json         | 30 +++++++++++++++++++
 .../arch/s390/cf_z14/transaction.json         | 25 ++++++++++++++++
 .../arch/s390/cf_z15/transaction.json         | 25 ++++++++++++++++
 .../arch/s390/cf_z16/transaction.json         | 25 ++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
index 71e2c7fa734c..b941a7212a4d 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
@@ -43,5 +43,35 @@
     "BriefDescription": "Percentage sourced from memory",
     "MetricName": "memp",
     "MetricExpr": "((L1D_ONNODE_MEM_SOURCED_WRITES + L1D_ONDRAWER_MEM_SOURCED_WRITES + L1D_OFFDRAWER_MEM_SOURCED_WRITES + L1D_ONCHIP_MEM_SOURCED_WRITES + L1I_ONNODE_MEM_SOURCED_WRITES + L1I_ONDRAWER_MEM_SOURCED_WRITES + L1I_OFFDRAWER_MEM_SOURCED_WRITES + L1I_ONCHIP_MEM_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
+    "MetricName": "finite_cpi",
+    "MetricExpr": "L1C_TLB1_MISSES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
+    "MetricName": "est_cpi",
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB1_MISSES / INSTRUCTIONS)"
+  },
+  {
+    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
+    "MetricName": "scpl1m",
+    "MetricExpr": "L1C_TLB1_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
+  },
+  {
+    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
+    "MetricName": "tlb_percent",
+    "MetricExpr": "((DTLB1_MISSES + ITLB1_MISSES) / CPU_CYCLES) * (L1C_TLB1_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
+  },
+  {
+    "BriefDescription": "Estimated Cycles per TLB Miss",
+    "MetricName": "tlb_miss",
+    "MetricExpr": "((DTLB1_MISSES + ITLB1_MISSES) / (DTLB1_WRITES + ITLB1_WRITES)) * (L1C_TLB1_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
+  },
+  {
+    "BriefDescription": "Page Table Entry misses",
+    "MetricName": "pte_miss",
+    "MetricExpr": "(TLB2_PTE_WRITES / (DTLB1_WRITES + ITLB1_WRITES)) * 100"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
index cca237bdb7ba..ce814ea93396 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
@@ -43,5 +43,30 @@
     "BriefDescription": "Percentage sourced from memory",
     "MetricName": "memp",
     "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
+    "MetricName": "finite_cpi",
+    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
+    "MetricName": "est_cpi",
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS)"
+  },
+  {
+    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
+    "MetricName": "scpl1m",
+    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
+  },
+  {
+    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
+    "MetricName": "tlb_percent",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
+  },
+  {
+    "BriefDescription": "Estimated Cycles per TLB Miss",
+    "MetricName": "tlb_miss",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
index cca237bdb7ba..ce814ea93396 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
@@ -43,5 +43,30 @@
     "BriefDescription": "Percentage sourced from memory",
     "MetricName": "memp",
     "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
+    "MetricName": "finite_cpi",
+    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
+    "MetricName": "est_cpi",
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS)"
+  },
+  {
+    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
+    "MetricName": "scpl1m",
+    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
+  },
+  {
+    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
+    "MetricName": "tlb_percent",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
+  },
+  {
+    "BriefDescription": "Estimated Cycles per TLB Miss",
+    "MetricName": "tlb_miss",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index dde0735a7d22..ec2ff78e2b5f 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -43,5 +43,30 @@
     "BriefDescription": "Percentage sourced from memory",
     "MetricName": "memp",
     "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
+    "MetricName": "finite_cpi",
+    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
+  },
+  {
+    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
+    "MetricName": "est_cpi",
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS)"
+  },
+  {
+    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
+    "MetricName": "scpl1m",
+    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
+  },
+  {
+    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
+    "MetricName": "tlb_percent",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
+  },
+  {
+    "BriefDescription": "Estimated Cycles per TLB Miss",
+    "MetricName": "tlb_miss",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
   }
 ]
-- 
2.39.1

