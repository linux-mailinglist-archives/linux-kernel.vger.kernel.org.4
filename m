Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1206C6B712F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCMIav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCMIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:30:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2531366A2;
        Mon, 13 Mar 2023 01:30:40 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D8OMc6006944;
        Mon, 13 Mar 2023 08:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=XefQJx/nB6d8qQAZLRs/7LrvMTHdfc1jGzHHDnw/ZKM=;
 b=XnnXlTQNToG/uBkXo8Z4Ujxxygv0N6e2W8fsAsJl6VfgXXG7wgsKsIIbyVq75ItnfwsT
 jZglnyP4dbraGe//dGK1lpuiYqTltfdXwumTTrkuf8h7oOB+7E6jKNyLCTWGblaW0kMS
 NTjWnLAuUOlhlgy7eDJYsWW7Rv6/+JA+crHpe4cFADR1Uyhhreaokn7uAk7nuDZc/ePF
 eXzqK+g7hzcpDASWKueqz8Q4oQXw2zAKMqDT2bjBqdGXW6VU+SKG5duTYd+HJtCa6uly
 QIrDsECLobIEqI1GWBUkqGq7IBebnKZCXfBMWvMzTYgJoRaVLI/ClnlQ3jtoeD/ayzjY cw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93fs6t4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:30:38 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32CJoSEr019195;
        Mon, 13 Mar 2023 08:30:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p8h96jbx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:30:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D8UVbO4260412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:30:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D27D82052D;
        Mon, 13 Mar 2023 08:02:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94BF72052A;
        Mon, 13 Mar 2023 08:02:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 08:02:08 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
Date:   Mon, 13 Mar 2023 09:01:57 +0100
Message-Id: <20230313080201.2440201-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: li-TVPCnnInWhQ01U3kFCCV1xStTjp0a
X-Proofpoint-ORIG-GUID: li-TVPCnnInWhQ01U3kFCCV1xStTjp0a
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

Add metrics for s390 z16
- Percentage sourced from Level 2 cache
- Percentage sourced from Level 3 on same chip cache
- Percentage sourced from Level 4 Local cache on same book
- Percentage sourced from Level 4 Remote cache on different book
- Percentage sourced from memory

For details about the formulas see this documentation:
https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf

Outpuf after:
 # ./perf stat -M l4rp -- dd if=/dev/zero of=/dev/null bs=10M count=10K
 .... dd output deleted

 Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=10M count=10K':

                 0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l4rp
           431,866      L1I_DIR_WRITES
             2,395      IDCW_OFF_DRAWER_IV
                 0      ICW_OFF_DRAWER
                 0      IDCW_OFF_DRAWER_DRAWER_HIT
             1,437      DCW_OFF_DRAWER
       425,960,793      L1D_DIR_WRITES

      12.165030699 seconds time elapsed

       0.001037000 seconds user
      12.162140000 seconds sys

 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../arch/s390/cf_z16/transaction.json         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index 86bf83b4504e..dde0735a7d22 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -18,5 +18,30 @@
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
     "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 2 cache",
+    "MetricName": "l2p",
+    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 3 on same chip cache",
+    "MetricName": "l3p",
+    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + DCW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Local cache on same book",
+    "MetricName": "l4lp",
+    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_ON_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + IDCW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDCW_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Remote cache on different book",
+    "MetricName": "l4rp",
+    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAWER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+  },
+  {
+    "BriefDescription": "Percentage sourced from memory",
+    "MetricName": "memp",
+    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
   }
 ]
-- 
2.39.1

