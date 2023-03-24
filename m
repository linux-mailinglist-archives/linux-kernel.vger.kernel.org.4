Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4B6C77C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCXGRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCXGRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:17:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6028E76;
        Thu, 23 Mar 2023 23:17:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O5FbJ2030390;
        Fri, 24 Mar 2023 06:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XNhxMsKw6ZAe+EYt13fPXlDqqycgBNXXfO0jTrz0x0w=;
 b=LymwUMow5Jwgr4HR/5eHH+OVNwHFWYtxutNjh4/KbsM4Ny7gVjeScmWgEO57LS47Ec7w
 5YApU1Y/pfNfXkB6xuPKu+qwmXQ1rpJHLMbSZiouiuLibsP0RlONIu389m+fVQC8fi44
 2mkzSDMLs6X6om6+iMDSgRQl3qdH8f/Rl5rcO6GhCUgQdhinvRFFke/ls1m5SVtxCKQL
 t2Cbph8CoPiCySPCrklnOOIgbGb0Pc67HZ1XA89UhXW6TRjlZ3SqypwA5M78P5aDhHd3
 40gCCKHSj8ExWuGFmmn2rvLs8QspOa4KzjJsHqoK/PHMpRAMYZLI+++zj6Gg1+rQ296/ ig== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgydugvyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:16:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32O6Gn6B005035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:16:49 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 23:16:43 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Hao Zhang <quic_hazha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
Date:   Fri, 24 Mar 2023 14:16:08 +0800
Message-ID: <20230324061608.33609-4-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230324061608.33609-1-quic_hazha@quicinc.com>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LNGL-8bt0fqzFf7EHFVs3GItCkxhHfeV
X-Proofpoint-GUID: LNGL-8bt0fqzFf7EHFVs3GItCkxhHfeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_02,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240049
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Coresight Dummy Trace under trace/coresight.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../trace/coresight/coresight-dummy.rst       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst

diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
new file mode 100644
index 000000000000..819cabab8623
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-dummy.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Coresight Dummy Trace Module
+=============================
+
+    :Author:   Hao Zhang <quic_hazha@quicinc.com>
+    :Date:     March 2023
+
+Introduction
+---------------------------
+
+Coresight Dummy Trace Module is for the specific devices that HLOS don't
+have permission to access or configure. Such as Coresight sink EUD, some
+TPDMs etc. So there need driver to register dummy devices as Coresight
+devices. Provide Coresight API for dummy device operations, such as
+enabling and disabling dummy devices. Build the Coresight path for dummy
+sink or dummy source for debugging.
+
+Sysfs files and directories
+---------------------------
+
+Root: ``/sys/bus/coresight/devices/dummy<N>``
+
+----
+
+:File:            ``enable_source`` (RW)
+:Notes:
+    - > 0 : enable the datasets of dummy source.
+
+    - = 0 : disable the datasets of dummy source.
+
+:Syntax:
+    ``echo 1 > enable_source``
+
+----
+
+:File:            ``enable_sink`` (RW)
+:Notes:
+    - > 0 : enable the datasets of dummy sink.
+
+    - = 0 : disable the datasets of dummy sink.
+
+:Syntax:
+    ``echo 1 > enable_sink``
+
+----
+
+Config details
+---------------------------
+
+There are two types of nodes, dummy sink and dummy source. The nodes
+should be observed at the coresight path
+"/sys/bus/coresight/devices".
+e.g.
+/sys/bus/coresight/devices # ls -l | grep dummy
+dummy0 -> ../../../devices/platform/soc@0/soc@0:dummy_source/dummy0
+dummy1 -> ../../../devices/platform/soc@0/soc@0:dummy_sink/dummy1
-- 
2.17.1

