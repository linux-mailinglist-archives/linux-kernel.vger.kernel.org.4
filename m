Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84071243B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbjEZKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbjEZKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:09:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585B5E7;
        Fri, 26 May 2023 03:09:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q9c4L3002992;
        Fri, 26 May 2023 10:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=927t+Jc3BbVATY+uT8tywu3mTWnUFfdwEVcCWZY9YDk=;
 b=WA2UKZgAnSUcjgtf88laz+SxYLmgl4Ziu4QMmrgPsctbnlpR34PhW9kY/qeSBrfCfIJt
 79YZRfcFSnGa5uhtFwQxqOKdg7PTMPtly4+G3RyUDyxkBB9xauMNppEZ9ttv7B3W8F8b
 OjAKRtkoC87lqlvu5oIkEQHxZApJQsCAa7Ld+qIniZ7CXfqZU69PdstlkKO6AAYeETai
 XZjlkNjK8XdGJg8zeGLj81vuF1gugNZRaR6EBKatmPFJMlepE+cEsi3AaxEGbQZzG+86
 +rywbzuNtegLtH9K+uSKAmFk7sd534NSJFKdi9VOXxhLKInXYQbauPrtyIr5sqRBAnyU DA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt27n35br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:09:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QA9ITk001304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:09:18 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 03:09:12 -0700
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
Subject: [PATCH v5 3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
Date:   Fri, 26 May 2023 18:07:53 +0800
Message-ID: <20230526100753.34581-4-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526100753.34581-1-quic_hazha@quicinc.com>
References: <20230526100753.34581-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BIKqSiad5Hb8lLy5TtcQ7omTW-4K6x1i
X-Proofpoint-GUID: BIKqSiad5Hb8lLy5TtcQ7omTW-4K6x1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=959 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Coresight Dummy Trace under trace/coresight.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../trace/coresight/coresight-dummy.rst       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst

diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
new file mode 100644
index 000000000000..f0a92669288b
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
+    :Date:     May 2023
+
+Introduction
+------------
+
+The Coresight dummy trace module is for the specific devices that kernel don't
+have permission to access or configure, e.g., CoreSight TPDMs on Qualcomm
+platforms. For these devices, a dummy driver is needed to register them as
+Coresight devices. The module may also be used to define components that may
+not have any programming interfaces (e.g, static links), so that paths can be
+created in the driver. It provides Coresight API for operations on dummy
+devices, such as enabling and disabling them. It also provides the Coresight
+dummy sink/source paths for debugging.
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

