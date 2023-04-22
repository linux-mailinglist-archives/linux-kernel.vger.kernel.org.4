Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE436EB7DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDVHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDVHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:38:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B219BD;
        Sat, 22 Apr 2023 00:38:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33M7ZNDl027766;
        Sat, 22 Apr 2023 07:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Vsorn17+lHdspdySrV76ro0C+0yMpI5rorINwv56l2o=;
 b=Cqh2I/ZGB0lsWGyDlTwBA94i0LpeBlbgIYlfdbUNBYfDRfKoDEZCXmeAWc5RJiUmLJve
 tIyLyWxCGisYt3MIjXogFOl0adbj5LUwhylqKgqZHqcLjjCXayJ8IVufiQEi5yomaspV
 lKn8nCtSgZOJwwPgCZvvg6KE5bIGky8v7bVd5wO9loHHjtBmN9pBFQPMCr5k3YYdosEp
 KJdoFHI3MYZjmhJqSxeKD+G3Usp05VxxvlUkw09DT6ymEDnSU0DGb+oRvlOKKRhWHsYX
 nSlpKKKLUYfeSmWH7TUkM5FHQc7iSvu+Plde3QZC6iRMAVppGrl9p367sEUrr4SRb2Yf 9Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48h385km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:38:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33M7bxHq002516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:59 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 22 Apr 2023 00:37:54 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
Subject: [PATCH v3 3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
Date:   Sat, 22 Apr 2023 15:37:14 +0800
Message-ID: <20230422073714.38844-4-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422073714.38844-1-quic_hazha@quicinc.com>
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3cnXiXHaXM4tSxblUdSU-IzjgEwVrY7R
X-Proofpoint-GUID: 3cnXiXHaXM4tSxblUdSU-IzjgEwVrY7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=952 mlxscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304220064
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

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../trace/coresight/coresight-dummy.rst       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst

diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
new file mode 100644
index 000000000000..d0f73253f694
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-dummy.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Coresight Dummy Trace Module
+=============================
+
+    :Author:   Hao Zhang <quic_hazha@quicinc.com>
+    :Date:     April 2023
+
+Introduction
+---------------------------
+
+Coresight Dummy Trace Module is for the specific devices that kernel
+don't have permission to access or configure, e.g., CoreSight TPDMs
+on Qualcomm platforms. So there need driver to register dummy devices
+as Coresight devices. It may also be used to define components that
+may not have any programming interfaces (e.g, static links), so that
+paths can be established in the driver. Provide Coresight API for
+dummy device operations, such as enabling and disabling dummy devices.
+Build the Coresight path for dummy sink or dummy source for debugging.
+
+Config details
+---------------------------
+
+There are two types of nodes, dummy sink and dummy source. The nodes
+should be observed at the below coresight path::
+
+    ``/sys/bus/coresight/devices``.
+
+e.g.::
+
+    / $ ls -l /sys/bus/coresight/devices | grep dummy
+    dummy0 -> ../../../devices/platform/soc@0/soc@0:dummy_source/dummy0
+    dummy1 -> ../../../devices/platform/soc@0/soc@0:dummy_sink/dummy1
-- 
2.17.1

