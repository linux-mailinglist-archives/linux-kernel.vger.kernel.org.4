Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34A71FC53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjFBInM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFBInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:43:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331D1A6;
        Fri,  2 Jun 2023 01:43:03 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527pmQI007127;
        Fri, 2 Jun 2023 08:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=df8HITZ3Pr3w5FS83ye95x3aY6DvbRLf3rmUvx5ciCs=;
 b=ccFAfP3/Y5lSdtvZPMzeTmka4TV/bnrqK8ubgOm8NbDL3cY2ieAYrZAOL9D/yvILpccN
 cCjAAwRpdgBxiuPmKANjnR3MmTkTowXg01uvC71J/dyF/ofQD+M9Z0Roy82ty7Wfq447
 5as5B97iFuKoozb4uZg/OHL+fxIZMekYaMOSZU4IUSu7ORxfIgpkBb80BxrIXQglXE19
 KJhWpCyNM24dHbM/MuE8fXpSE9HLoPZ6h1t7vSyoQHdV4ZpRQaXrFyu9Q/VtmsiHS/uH
 H465fgDhTnCKZ6mBMOuCBmPgoSY4OUvx5V7T+eAMOoRWK7W36dfNcsy4NVUkRZDLb0+T ng== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy8390hd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:42:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528glse020237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:42:47 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 01:42:41 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Hao Zhang <quic_hazha@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v6 3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
Date:   Fri, 2 Jun 2023 16:41:49 +0800
Message-ID: <20230602084149.40031-4-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230602084149.40031-1-quic_hazha@quicinc.com>
References: <20230602084149.40031-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uPts5TZSDrRxuJTCz1rkGWAS-5snZ2Wi
X-Proofpoint-ORIG-GUID: uPts5TZSDrRxuJTCz1rkGWAS-5snZ2Wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=971
 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Coresight Dummy Trace under trace/coresight.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../trace/coresight/coresight-dummy.rst       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst

diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
new file mode 100644
index 000000000000..eff7c553ee6c
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-dummy.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Coresight Dummy Trace Module
+=============================
+
+    :Author:   Hao Zhang <quic_hazha@quicinc.com>
+    :Date:     June 2023
+
+Introduction
+------------
+
+The Coresight dummy trace module is for the specific devices that kernel don't
+have permission to access or configure, e.g., CoreSight TPDMs on Qualcomm
+platforms. For these devices, a dummy driver is needed to register them as
+Coresight devices. The module may also be used to define components that may
+not have any programming interfaces, so that paths can be created in the driver.
+It provides Coresight API for operations on dummy devices, such as enabling and
+disabling them. It also provides the Coresight dummy sink/source paths for
+debugging.
+
+Config details
+--------------
+
+There are two types of nodes, dummy sink and dummy source. These nodes
+are available at ``/sys/bus/coresight/devices``.
+
+Example output::
+
+    $ ls -l /sys/bus/coresight/devices | grep dummy
+    dummy_sink0 -> ../../../devices/platform/soc@0/soc@0:sink/dummy_sink0
+    dummy_source0 -> ../../../devices/platform/soc@0/soc@0:source/dummy_source0
-- 
2.17.1

