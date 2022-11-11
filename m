Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337EE625B93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiKKNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiKKNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:54:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFB4730D;
        Fri, 11 Nov 2022 05:54:19 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDf521014746;
        Fri, 11 Nov 2022 13:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PiO1Nw8WNkhYqTikOaHjoasy+WqCfLTwDG9queKORd8=;
 b=i+TuiWfOVyYDkgV0fhw/3y4A5fGGi96j3p58P6WDFWdYwc9onwpUWQHI09yFV9yirnHI
 ltzYW7Ga1Ymmn60sw9ON5IjtiTO3hIxSZxvzASQHXLNSJDqfHL4v3Du/JLIhIdNT9ws+
 /oMzDGA72ow9jMa6qjFK1cOlA8i1de6v0+IzR/u5GZ39QtSA0ACAnPZpG0MrtPSP7uH1
 L/Nzvx6aVb9/xzdvq+PJnd1qio6MjFyKF438yd0igqm5Dbm6FXl3IdcVeIHKwxYtmnW/
 Cet9zf5+9YS5UqqZKzPjLf/oP8pBKl5Bz5yibjJnhMPetzrpFihTO9edY/MW3CvlzpjN 0g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksqg4gatc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 13:54:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ABDqx1o007649;
        Fri, 11 Nov 2022 13:54:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3kngqdgry9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 13:54:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ABDs9ml721420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 13:54:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A6B24C04E;
        Fri, 11 Nov 2022 13:54:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07FFA4C04A;
        Fri, 11 Nov 2022 13:54:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Nov 2022 13:54:08 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf list: Add PMU pai_ext event description for IBM z16
Date:   Fri, 11 Nov 2022 14:54:02 +0100
Message-Id: <20221111135402.858623-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BaBJfbqCTOSGO2KySnXZUmM9ATHJUXkg
X-Proofpoint-ORIG-GUID: BaBJfbqCTOSGO2KySnXZUmM9ATHJUXkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_07,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 spamscore=0
 mlxlogscore=853 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the event description for the IBM z16 pai_ext PMU released with
commit c432fefe8e62 ("s390/pai: Add support for PAI Extension 1 NNPA counters")

The document SA22-7832-13 "z/Architecture Principles of Operation",
published May, 2022, contains the description of the
Processor Activity Instrumentation Facility and the NNPA counter
set., See Pages 5-113 to 5-116.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z16/pai_ext.json  | 198 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |   1 +
 2 files changed, 199 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
new file mode 100644
index 000000000000..8bee481f05d5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
@@ -0,0 +1,198 @@
+[
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6144",
+		"EventName": "NNPA_ALL",
+		"BriefDescription": "NNPA ALL",
+		"PublicDescription": "Sum of all non zero NNPA counters"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6145",
+		"EventName": "NNPA_ADD",
+		"BriefDescription": "NNPA ADD",
+		"PublicDescription": "NNPA ADD function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6146",
+		"EventName": "NNPA_SUB",
+		"BriefDescription": "NNPA SUB",
+		"PublicDescription": "NNPA SUB function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6147",
+		"EventName": "NNPA_MUL",
+		"BriefDescription": "NNPA MUL",
+		"PublicDescription": "NNPA MUL function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6148",
+		"EventName": "NNPA_DIV",
+		"BriefDescription": "NNPA DIV",
+		"PublicDescription": "NNPA DIV function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6149",
+		"EventName": "NNPA_MIN",
+		"BriefDescription": "NNPA MIN",
+		"PublicDescription": "NNPA MIN function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6150",
+		"EventName": "NNPA_MAX",
+		"BriefDescription": "NNPA MAX",
+		"PublicDescription": "NNPA-MAX function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6151",
+		"EventName": "NNPA_LOG",
+		"BriefDescription": "NNPA LOG",
+		"PublicDescription": "NNPA-LOG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6152",
+		"EventName": "NNPA_EXP",
+		"BriefDescription": "NNPA EXP",
+		"PublicDescription": "NNPA-EXP function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6153",
+		"EventName": "NNPA_IBM_RESERVED_9",
+		"BriefDescription": "Reserved for IBM use",
+		"PublicDescription": "Reserved for IBM use"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6154",
+		"EventName": "NNPA_RELU",
+		"BriefDescription": "NNPA RELU",
+		"PublicDescription": "NNPA-RELU function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6155",
+		"EventName": "NNPA_TANH",
+		"BriefDescription": "NNPA TANH",
+		"PublicDescription": "NNPA-TANH function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6156",
+		"EventName": "NNPA_SIGMOID",
+		"BriefDescription": "NNPA SIGMOID",
+		"PublicDescription": "NNPA-SIGMOID function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6157",
+		"EventName": "NNPA_SOFTMAX",
+		"BriefDescription": "NNPA SOFTMAX",
+		"PublicDescription": "NNPA-SOFTMAX function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6158",
+		"EventName": "NNPA_BATCHNORM",
+		"BriefDescription": "NNPA BATCHNORM",
+		"PublicDescription": "NNPA-BATCHNORM function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6159",
+		"EventName": "NNPA_MAXPOOL2D",
+		"BriefDescription": "NNPA MAXPOOL2D",
+		"PublicDescription": "NNPA-MAXPOOL2D function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6160",
+		"EventName": "NNPA_AVGPOOL2D",
+		"BriefDescription": "NNPA AVGPOOL2D",
+		"PublicDescription": "NNPA-AVGPOOL2D function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6161",
+		"EventName": "NNPA_LSTMACT",
+		"BriefDescription": "NNPA LSTMACT",
+		"PublicDescription": "NNPA-LSTMACT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6162",
+		"EventName": "NNPA_GRUACT",
+		"BriefDescription": "NNPA GRUACT",
+		"PublicDescription": "NNPA-GRUACT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6163",
+		"EventName": "NNPA_CONVOLUTION",
+		"BriefDescription": "NNPA CONVOLUTION",
+		"PublicDescription": "NNPA-CONVOLUTION function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6164",
+		"EventName": "NNPA_MATMUL_OP",
+		"BriefDescription": "NNPA MATMUL OP",
+		"PublicDescription": "NNPA-MATMUL-OP function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6165",
+		"EventName": "NNPA_MATMUL_OP_BCAST23",
+		"BriefDescription": "NNPA NNPA-MATMUL_OP_BCAST23",
+		"PublicDescription": "NNPA-MATMUL-OP-BCAST23 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6166",
+		"EventName": "NNPA_SMALLBATCH",
+		"BriefDescription": "NNPA SMALLBATCH",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6167",
+		"EventName": "NNPA_LARGEDIM",
+		"BriefDescription": "NNPA LARGEDIM",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6168",
+		"EventName": "NNPA_SMALLTENSOR",
+		"BriefDescription": "NNPA SMALLTENSOR",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6169",
+		"EventName": "NNPA_1MFRAME",
+		"BriefDescription": "NNPA 1MFRAME",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6170",
+		"EventName": "NNPA_2GFRAME",
+		"BriefDescription": "NNPA 2GFRAME",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6171",
+		"EventName": "NNPA_ACCESSEXCEPT",
+		"BriefDescription": "NNPA ACCESSEXCEPT",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+ 	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 0daa3e007528..da630aab948b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -225,6 +225,7 @@ class JsonEvent:
           'CPU-M-CF': 'cpum_cf',
           'CPU-M-SF': 'cpum_sf',
           'PAI-CRYPTO' : 'pai_crypto',
+          'PAI-EXT' : 'pai_ext',
           'UPI LL': 'uncore_upi',
           'hisi_sicl,cpa': 'hisi_sicl,cpa',
           'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
-- 
2.37.3

