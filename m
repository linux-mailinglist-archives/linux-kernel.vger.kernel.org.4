Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD06B7130
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCMIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCMIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:31:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139BD3757C;
        Mon, 13 Mar 2023 01:31:15 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D86qmm007154;
        Mon, 13 Mar 2023 08:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0/Upl9RgBya3omBRsGx9r8Q0UqZd8QiQCHdi3M+y5GM=;
 b=ilWR8VoaGadUEOY3EQeTxzsmqw7hQp+lJE0vDzSOP3vDOhmcYVkZrXfujY4eie7V64Sd
 ATXg2pw2A1AQw0+BgY/GCLrhQI9fC4gJsNHOfmtC+xtrWmjCLNMTXX/pYnH/fNxw/Bkt
 RfC48ah4zcjAqxPCiTjF4saL+tRFwcF7RuP29/Dw73W8rvrqkCYcZlJThjxHxw2Wl93B
 h0KdTOfyHPfW5MASU9DgvPLSQlI1dkYpRfdV76Qk01W+NptvU10A5sbpCb6aWdGin0tH
 uqXNkhTqUU2VX0s2vq+niNkR8K6JGLldL7Lf3n+GJ/cR2MexpqB8N6cKW4K9+FeZVk/7 eQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93t1emt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:31:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2WtP0028627;
        Mon, 13 Mar 2023 08:31:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96k1fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 08:31:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D8UoWX3474004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:30:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E67D2053F;
        Mon, 13 Mar 2023 08:02:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E436F20534;
        Mon, 13 Mar 2023 08:02:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 08:02:09 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/6] tools/perf/json: Add cache metrics for s390 z15
Date:   Mon, 13 Mar 2023 09:01:58 +0100
Message-Id: <20230313080201.2440201-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xA_juDxz_0SYpn1aVeZj86sAtV8UsHTq
X-Proofpoint-ORIG-GUID: xA_juDxz_0SYpn1aVeZj86sAtV8UsHTq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add metrics for s390 z15
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

              5      L1I_OFFDRAWER_L4_SOURCED_WRITES  #     0.01 l4rp
            187      L1D_OFFDRAWER_L4_SOURCED_WRITES
              0      L1I_OFFDRAWER_L3_SOURCED_WRITES
    231,333,165      L1I_DIR_WRITES
          3,303      L1D_OFFDRAWER_L3_SOURCED_WRITES
         47,461      L1D_OFFDRAWER_L3_SOURCED_WRITES_IV
              0      L1I_OFFDRAWER_L3_SOURCED_WRITES_IV
    126,706,244      L1D_DIR_WRITES

   27.870355461 seconds time elapsed

    0.521562000 seconds user
   12.494503000 seconds sys
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../arch/s390/cf_z15/transaction.json         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
index 86bf83b4504e..cca237bdb7ba 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
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

