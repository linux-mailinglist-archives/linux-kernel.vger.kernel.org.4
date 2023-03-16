Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8466BC49B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCPDYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCPDXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:23:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444ACAB880;
        Wed, 15 Mar 2023 20:21:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G242Ka026441;
        Thu, 16 Mar 2023 03:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=XNhxMsKw6ZAe+EYt13fPXlDqqycgBNXXfO0jTrz0x0w=;
 b=gW9G8XBTj3if7WlOW+L/yimmKoQhdti9K51EsKqThS3aNaI2G32PH1eXTfuGxIAS7AGZ
 4Zj8c68I4CXrbZgCS2g165Q3pgjCvr2xYiGr19/ElfzIixsw0CP12DBVQBAbqzC6vi3D
 Npk5o2q0dKFTywHQSuVEB9RL7CQzUao+F/g5wcJvfrjey25uaLWjw/NgIxSAKMGmkB6t
 lHdT3Xqt1rK3OSWY3TR+EmIfKDSNmnGf5rAvJ50q2Hf7N+/fubRLdY0FtLv58z7BEok9
 H9DVcSAbVfbDeSEOiN7NaSboM/NR1KQUhGuE8w03f8JeJHpm3Ue8xYGEPepfjOeid4te Pw== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjrhp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 03:20:22 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G3KKK4003071;
        Thu, 16 Mar 2023 03:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqmp091-1;
        Thu, 16 Mar 2023 03:20:20 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G3KK4P003062;
        Thu, 16 Mar 2023 03:20:20 GMT
Received: from hazha-gv.ap.qualcomm.com (hazha-gv.qualcomm.com [10.239.105.144])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 32G3KJUX003058;
        Thu, 16 Mar 2023 03:20:20 +0000
Received: by hazha-gv.ap.qualcomm.com (Postfix, from userid 4083943)
        id 0E8331200071; Thu, 16 Mar 2023 11:20:19 +0800 (CST)
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
Cc:     Hao Zhang <quic_hazha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH v1 3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
Date:   Thu, 16 Mar 2023 11:20:05 +0800
Message-Id: <20230316032005.6509-4-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316032005.6509-1-quic_hazha@quicinc.com>
References: <20230316032005.6509-1-quic_hazha@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gkiyfvKfL9NWFB60ffMpVHMHfwfOY26B
X-Proofpoint-ORIG-GUID: gkiyfvKfL9NWFB60ffMpVHMHfwfOY26B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_02,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=981 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160028
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

