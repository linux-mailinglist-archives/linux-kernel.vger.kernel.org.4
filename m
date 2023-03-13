Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B026B70D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCMIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjCMIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1047D8E;
        Mon, 13 Mar 2023 01:02:58 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D5r82Y022876;
        Mon, 13 Mar 2023 08:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0H7lKdFeJJjE4rjYMkL8DuxczvbSejEC0G/5u4wmswo=;
 b=hRK2JXZ56ntWlriO7uU84/SomqUj/9aouqWStr2F/k3g22TUKm1V2k1QQXwaO1XClhwM
 TR6NkYYxS2/+MXr/PlHyYMBxyPgYnvP1wqZe/sbpovcMn43lD7LBnDGIWGf5HmbEkvkq
 kUHSwEfmYmw6KuOf3VnfyP33YsOP6apUR6mer5lACZkNHCi5UOatasc1BPBh2Z0jacK4
 tGqdzwWtVUL9lExWm+mxXotEK9Tr6YM0zeF+goGGMMiAl0WGgPRWzmQKJ4snBhc55SJX
 y+OGijSVQyWbU/iC8LpzoSr7McMJAt0dgfKGFGxAK5gGAzW2E75dP+xdLoNUDOYrw1WU rw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93et61eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:02:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2h3YE028735;
        Mon, 13 Mar 2023 08:02:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96k05e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:02:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D82FlD1901138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:02:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 421E32054B;
        Mon, 13 Mar 2023 08:02:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0422A2052E;
        Mon, 13 Mar 2023 08:02:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 08:02:13 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 5/6] tools/perf/json: Add cache metrics for s390 z13
Date:   Mon, 13 Mar 2023 09:02:00 +0100
Message-Id: <20230313080201.2440201-5-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e1VabvnOg-tt-Co4jn8TyA9UTPtYJ7Tj
X-Proofpoint-ORIG-GUID: e1VabvnOg-tt-Co4jn8TyA9UTPtYJ7Tj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add metrics for s390 z13
- Percentage sourced from Level 2 cache
- Percentage sourced from Level 3 on same chip cache
- Percentage sourced from Level 4 Local cache on same book
- Percentage sourced from Level 4 Remote cache on different book
- Percentage sourced from memory

For details about the formulas see this documentation:
https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf

Output after:

 # ./perf stat -M l4rp -- find /
   ...find output deleted

 Performance counter stats for 'find /':

            2      L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES #     0.02 l4rp
          252      L1D_ONDRAWER_L4_SOURCED_WRITES
        3,465      L1D_ONDRAWER_L3_SOURCED_WRITES_IV
           80      L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES
          761      L1D_ONDRAWER_L3_SOURCED_WRITES
            0      L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES
  131,817,067      L1I_DIR_WRITES
            1      L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES
          447      L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES
           22      L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES
            7      L1I_ONDRAWER_L4_SOURCED_WRITES
            0      L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES
        1,071      L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES
            3      L1I_ONDRAWER_L3_SOURCED_WRITES
       13,352      L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV
       15,252      L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV
            0      L1I_ONDRAWER_L3_SOURCED_WRITES_IV
            0      L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV
   57,431,083      L1D_DIR_WRITES
            0      L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV

      15.386502874 seconds time elapsed

       0.647348000 seconds user
       3.537041000 seconds sys

 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../arch/s390/cf_z13/transaction.json         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
index 86bf83b4504e..71e2c7fa734c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
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
+    "MetricExpr": "((L1D_ONNODE_L4_SOURCED_WRITES + L1D_ONNODE_L3_SOURCED_WRITES_IV + L1D_ONNODE_L3_SOURCED_WRITES + L1I_ONNODE_L4_SOURCED_WRITES + L1I_ONNODE_L3_SOURCED_WRITES_IV + L1I_ONNODE_L3_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Remote cache on different book",
+    "MetricName": "l4rp",
+    "MetricExpr": "((L1D_ONDRAWER_L4_SOURCED_WRITES + L1D_ONDRAWER_L3_SOURCED_WRITES_IV + L1D_ONDRAWER_L3_SOURCED_WRITES + L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES + L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV + L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES + L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES + L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV + L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES + L1I_ONDRAWER_L4_SOURCED_WRITES + L1I_ONDRAWER_L3_SOURCED_WRITES_IV + L1I_ONDRAWER_L3_SOURCED_WRITES + L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES + L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES + L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES + L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from memory",
+    "MetricName": "memp",
+    "MetricExpr": "((L1D_ONNODE_MEM_SOURCED_WRITES + L1D_ONDRAWER_MEM_SOURCED_WRITES + L1D_OFFDRAWER_MEM_SOURCED_WRITES + L1D_ONCHIP_MEM_SOURCED_WRITES + L1I_ONNODE_MEM_SOURCED_WRITES + L1I_ONDRAWER_MEM_SOURCED_WRITES + L1I_OFFDRAWER_MEM_SOURCED_WRITES + L1I_ONCHIP_MEM_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
   }
 ]
-- 
2.39.1

