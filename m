Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1726B0776
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCHMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCHMxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:53:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7FB4820;
        Wed,  8 Mar 2023 04:53:40 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328BCH2J017371;
        Wed, 8 Mar 2023 12:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=BaOHCIvZggeecOWNBSlSSkIxgYUdRP4iC0BWfBmoQF0=;
 b=rTXwCOdguD3cwN7uQGHGMSKS+U0t3RDUzlfRCj2QtDTqM7EQEV+2q91+eLi6xr+JQnaw
 yby7qU8UxRfDkBAX1lrFA+bwPQHrwh4/OZJPA2ZjgFe9ig2emzfja2Y30kTK0fdh/6A3
 eru6DOY4ZEzlOwKka1spEqKTlTRJQC5Nk1WSVlPiAn5DgchZYuyQG6Kuwr6RZvMdmGt5
 +9gf7HDmRfUzrls+x2wAWItaz+nZupRuCCVzTblLWcz0VOsMT6TOlP8p/zAWxwSDMdGZ
 k98cD85812GGFXxhp87L7wnfEvi3AlyE32VQiJB/FZIwyZYfioc8cobIwxp3/B2ZWSz6 8A== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9a26d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 12:53:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3280dl7e003274;
        Wed, 8 Mar 2023 12:53:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3p6g0pgk2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 12:53:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328CrVcf35717584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 12:53:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C4220043;
        Wed,  8 Mar 2023 12:53:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DF4620040;
        Wed,  8 Mar 2023 12:53:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 12:53:31 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: Add PMU pai_ext event description for IBM z16
Date:   Wed,  8 Mar 2023 13:53:26 +0100
Message-Id: <20230308125326.2195613-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RpeAmozW15tdJB27fTMt0yE2cwFs2tVB
X-Proofpoint-GUID: RpeAmozW15tdJB27fTMt0yE2cwFs2tVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=853
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
set., See Pages 5-113 to 5-116 and chapter 26 for details.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z16/pai_ext.json  | 178 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |   1 +
 2 files changed, 179 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
new file mode 100644
index 000000000000..7ccbded95dc9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
@@ -0,0 +1,178 @@
+[
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6144",
+		"EventName": "NNPA_ALL",
+		"BriefDescription": "NNPA ALL Sum of all non zero counters",
+		"PublicDescription": "Sum of all non zero NNPA (Neural Networks Processing Assist) counters"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6145",
+		"EventName": "NNPA_ADD",
+		"BriefDescription": "NNPA ADD function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6146",
+		"EventName": "NNPA_SUB",
+		"BriefDescription": "NNPA SUB function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6147",
+		"EventName": "NNPA_MUL",
+		"BriefDescription": "NNPA MUL function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6148",
+		"EventName": "NNPA_DIV",
+		"BriefDescription": "NNPA DIV function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6149",
+		"EventName": "NNPA_MIN",
+		"BriefDescription": "NNPA MIN function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6150",
+		"EventName": "NNPA_MAX",
+		"BriefDescription": "NNPA MAX function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6151",
+		"EventName": "NNPA_LOG",
+		"BriefDescription": "NNPA LOG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6152",
+		"EventName": "NNPA_EXP",
+		"BriefDescription": "NNPA EXP function ending with CC=0"
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
+		"BriefDescription": "NNPA RELU function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6155",
+		"EventName": "NNPA_TANH",
+		"BriefDescription": "NNPA TANH function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6156",
+		"EventName": "NNPA_SIGMOID",
+		"BriefDescription": "NNPA SIGMOID function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6157",
+		"EventName": "NNPA_SOFTMAX",
+		"BriefDescription": "NNPA SOFTMAX function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6158",
+		"EventName": "NNPA_BATCHNORM",
+		"BriefDescription": "NNPA BATCHNORM function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6159",
+		"EventName": "NNPA_MAXPOOL2D",
+		"BriefDescription": "NNPA MAXPOOL2D function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6160",
+		"EventName": "NNPA_AVGPOOL2D",
+		"BriefDescription": "NNPA AVGPOOL2D function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6161",
+		"EventName": "NNPA_LSTMACT",
+		"BriefDescription": "NNPA LSTMACT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6162",
+		"EventName": "NNPA_GRUACT",
+		"BriefDescription": "NNPA GRUACT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6163",
+		"EventName": "NNPA_CONVOLUTION",
+		"BriefDescription": "NNPA CONVOLUTION function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6164",
+		"EventName": "NNPA_MATMUL_OP",
+		"BriefDescription": "NNPA MATMUL OP function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6165",
+		"EventName": "NNPA_MATMUL_OP_BCAST23",
+		"BriefDescription": "NNPA NNPA MATMUL OP BCAST23 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6166",
+		"EventName": "NNPA_SMALLBATCH",
+		"BriefDescription": "NNPA SMALLBATCH OP function ending with CC=0",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6167",
+		"EventName": "NNPA_LARGEDIM",
+		"BriefDescription": "NNPA LARGEDIM OP function ending with CC=0",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6168",
+		"EventName": "NNPA_SMALLTENSOR",
+		"BriefDescription": "NNPA SMALLTENSOR OP function ending with CC=0",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6169",
+		"EventName": "NNPA_1MFRAME",
+		"BriefDescription": "NNPA 1MFRAME OP function ending with CC=0",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6170",
+		"EventName": "NNPA_2GFRAME",
+		"BriefDescription": "NNPA 2GFRAME OP function ending with CC=0",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6171",
+		"EventName": "NNPA_ACCESSEXCEPT",
+		"BriefDescription": "NNPA ACCESSEXCEPT OP function ending with CC=0",
+		"PublicDescription": "NNPA function with conditions as described in Common Operation"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07ce609f..b20d06fcc358 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -246,6 +246,7 @@ class JsonEvent:
           'CPU-M-CF': 'cpum_cf',
           'CPU-M-SF': 'cpum_sf',
           'PAI-CRYPTO' : 'pai_crypto',
+          'PAI-EXT' : 'pai_ext',
           'UPI LL': 'uncore_upi',
           'hisi_sicl,cpa': 'hisi_sicl,cpa',
           'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
-- 
2.39.1

