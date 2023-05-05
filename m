Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617846F7FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjEEJZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjEEJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:25:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38A19415;
        Fri,  5 May 2023 02:25:34 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3457sTZk031532;
        Fri, 5 May 2023 09:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lf38yr2HPtkIr93NPvSpTb0G/h2pVjgRVUdckSYuuQ8=;
 b=ksV0YRNEm/IJt5oD87fCmCGelJT8N9K6tU8BIZxKUKYVz7NQvDh8xiA9T8stqwc/B9m+
 kkTp0/cd0VJ8Qbl0qJxqb5CfU5P6A7NIciFcZOTqn2nAneuwjX7FNSQ5b7QKCr5xuxKy
 n+XleoInRzl0g+YEOWW5N6xU7DkqYM5+9xOk2NfWdMQCfgiR23khVdRC3xbQY463/icl
 UX40oZnu5Vd1PJ0RJpqEYvSZ5fS16z3EoeeX1mTp46icoW4sNxJtu48cdDC6bE8QIg7G
 1H8RqMDpTELNSXw9srRP4I0c2WTCpULPrdyfivOuNrJHhZEzTI99fsIdgH/5mFRu3kjG WQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcb24arjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 09:25:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3459PLC8026884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 09:25:21 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 02:25:15 -0700
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
Subject: [PATCH v4 3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
Date:   Fri, 5 May 2023 17:24:22 +0800
Message-ID: <20230505092422.32217-4-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505092422.32217-1-quic_hazha@quicinc.com>
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SM7Gnzn-OtCaw7hcWz9pSx3d6kWhIc23
X-Proofpoint-ORIG-GUID: SM7Gnzn-OtCaw7hcWz9pSx3d6kWhIc23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=967 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..7cb59f080c88
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
+    :Date:     May 2023
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
+    dummy_sink0 -> ../../../devices/platform/soc@0/soc@0:sink/dummy_sink0
+    dummy_source0 -> ../../../devices/platform/soc@0/soc@0:source/dummy_source0
-- 
2.17.1

