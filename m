Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD06B70D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCMIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCMIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:05:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E995678F;
        Mon, 13 Mar 2023 01:02:50 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D50Mu3006865;
        Mon, 13 Mar 2023 08:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=+qbUTEhvQGDrYnaMfPIouUJlL9iRBGow4XkFs/sR6Go=;
 b=FLQwtG0SPJo/6XAUfi3MmNoDpdmgZ1gK1ojrxW8M1yOiDpRS6cqzIC2jkfhiLHo5bTAz
 FKuSgsW8CxLYr33FcT6rjSJkbNDyN+O8TujLRYTsI6FgDaSmuD2vgLROL+P665ZC2mVY
 wRhQdpwgD1TP7l2ycSR74u+16VnmMQO129gXDau+9+eLeHToKUnKMcd8vOziJcIL7RRb
 AP3z9rciIHIdyGpUV31VJCWa1lcAEvkaKlTxuWZOoH6I5zyjahsi43XLzdA4CmY8hfW3
 edaWd2zybu6UKuUSBLCV5DZsW4k5dWkQawuGnoAIn5tj06tTAefMAQFr1dcH4WDGaktr Tg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93fs65hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:02:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D1aeOe029999;
        Mon, 13 Mar 2023 08:02:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfb0y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:02:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D82CkJ3670762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:02:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CF6020546;
        Mon, 13 Mar 2023 08:02:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EDB72054B;
        Mon, 13 Mar 2023 08:02:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 08:02:12 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 4/6] tools/perf/json: Add cache metrics for s390 z14
Date:   Mon, 13 Mar 2023 09:01:59 +0100
Message-Id: <20230313080201.2440201-4-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 31u_9OUofeteGZtpiA0VG6UQ-L1nwPXX
X-Proofpoint-ORIG-GUID: 31u_9OUofeteGZtpiA0VG6UQ-L1nwPXX
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

Add metrics for s390 z14
- Percentage sourced from Level 2 cache
- Percentage sourced from Level 3 on same chip cache
- Percentage sourced from Level 4 Local cache on same book
- Percentage sourced from Level 4 Remote cache on different book
- Percentage sourced from memory

For details about the formulas see this documentation:
https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf

Outpuf after:
 # ./perf stat -M l4rp -- find /
 .... find output deleted

 Performance counter stats for 'find /':

             0      L1I_OFFDRAWER_L4_SOURCED_WRITES  #     0.01 l4rp
            84      L1D_OFFDRAWER_L4_SOURCED_WRITES
             0      L1I_OFFDRAWER_L3_SOURCED_WRITES
    71,535,353      L1I_DIR_WRITES
           219      L1D_OFFDRAWER_L3_SOURCED_WRITES
        16,436      L1D_OFFDRAWER_L3_SOURCED_WRITES_IV
             0      L1I_OFFDRAWER_L3_SOURCED_WRITES_IV
    46,343,940      L1D_DIR_WRITES

  10.530805537 seconds time elapsed

   0.774396000 seconds user
   1.602714000 seconds sys

 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../arch/s390/cf_z14/transaction.json         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
index 86bf83b4504e..cca237bdb7ba 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
@@ -18,5 +18,30 @@
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
     "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 2 cache",
+    "MetricName": "l2p",
+    "MetricExpr": "((L1D_L2D_SOURCED_WRITES + L1I_L2I_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 3 on same chip cache",
+    "MetricName": "l3p",
+    "MetricExpr": "((L1D_ONCHIP_L3_SOURCED_WRITES + L1D_ONCHIP_L3_SOURCED_WRITES_IV + L1I_ONCHIP_L3_SOURCED_WRITES + L1I_ONCHIP_L3_SOURCED_WRITES_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Local cache on same book",
+    "MetricName": "l4lp",
+    "MetricExpr": "((L1D_ONCLUSTER_L3_SOURCED_WRITES + L1D_ONCLUSTER_L3_SOURCED_WRITES_IV + L1D_ONDRAWER_L4_SOURCED_WRITES + L1I_ONCLUSTER_L3_SOURCED_WRITES + L1I_ONCLUSTER_L3_SOURCED_WRITES_IV + L1I_ONDRAWER_L4_SOURCED_WRITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV + L1D_ONCHIP_L3_SOURCED_WRITES_RO + L1I_OFFCLUSTER_L3_SOURCED_WRITES + L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Remote cache on different book",
+    "MetricName": "l4rp",
+    "MetricExpr": "((L1D_OFFDRAWER_L3_SOURCED_WRITES + L1D_OFFDRAWER_L3_SOURCED_WRITES_IV + L1D_OFFDRAWER_L4_SOURCED_WRITES + L1I_OFFDRAWER_L3_SOURCED_WRITES + L1I_OFFDRAWER_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_L4_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from memory",
+    "MetricName": "memp",
+    "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
   }
 ]
-- 
2.39.1

