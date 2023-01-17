Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6666E182
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjAQO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjAQO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:57:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6E359D;
        Tue, 17 Jan 2023 06:57:39 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEbTEp005229;
        Tue, 17 Jan 2023 14:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=5PcV4EjbwVxQbQROKWG6VF4HrVUTgnVHm7HS2j2rdJc=;
 b=Ld758OE+szB/gTZZagBXGHJ3IMPep1m3yS9mi8A+iC18lq26dceFL4asrupskag0NPgT
 yBYdM3jWMVTibmlCeRjMFMEq5ilAjgFpPfNbl++5dFfkmMmoRR2G6rdYKL9qoWju/BVQ
 tvBAGnj28Fc+6+Y/M7Ttfn8R2C0NjzFXcG+0RYGwevv3I8vwob3gp+jiJtMauAuBxnmF
 695s/yWwip09VCPzxhX3/eyfbGwhYR3Ftd8ojKwFgSw2v+aFEZ7sz2oO2Q8aIuC0hvk+
 +VdUXMhepXqCyFmcIDnHAz3loW9TpFcDGMGSuBCs3K3UvC42v/Xe0qCUd6vS1yuxkfnN Gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3npgdf93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HEvMLf018744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:22 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 06:57:22 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v17 8/9] Documentation: trace: Add documentation for TPDM and TPDA
Date:   Tue, 17 Jan 2023 06:57:07 -0800
Message-ID: <20230117145708.16739-9-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ljxv1xhztqbXpqPxLywcJ5VjNJoVZbXM
X-Proofpoint-ORIG-GUID: Ljxv1xhztqbXpqPxLywcJ5VjNJoVZbXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170121
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the TPDM and TPDA under trace/coresight.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../trace/coresight/coresight-tpda.rst        | 52 +++++++++++++++++++
 .../trace/coresight/coresight-tpdm.rst        | 43 +++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-tpda.rst
 create mode 100644 Documentation/trace/coresight/coresight-tpdm.rst

diff --git a/Documentation/trace/coresight/coresight-tpda.rst b/Documentation/trace/coresight/coresight-tpda.rst
new file mode 100644
index 000000000000..350dad4eda47
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-tpda.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+The trace performance monitoring and diagnostics aggregator(TPDA).
+==============================
+
+    :Author:   Jinlong Mao <quic_jinlmao@quicinc.com>
+    :Date:     January 2023
+
+Hardware Description
+--------------------
+
+TPDA - The trace performance monitoring and diagnostics aggregator or
+TPDA in short serves as an arbitration and packetization engine for the
+performance monitoring and diagnostics network specification.
+The primary use case of the TPDA is to provide packetization, funneling
+and timestamping of Monitor data.
+
+
+Sysfs files and directories
+---------------------------
+Root: ``/sys/bus/coresight/devices/tpda<N>``
+
+Config details
+---------------------------
+
+The tpdm and tpda nodes should be observed at the coresight path
+"/sys/bus/coresight/devices".
+e.g.
+/sys/bus/coresight/devices # ls -l | grep tpd
+tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
+tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
+
+We can use the commands are similar to the below to validate TPDMs.
+Enable coresight sink first. The port of tpda which is connected to
+the tpdm will be enabled after commands below.
+
+echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
+echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
+echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
+echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
+
+The test data will be collected in the coresight sink which is enabled.
+If rwp register of the sink is keeping updating when do
+integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
+generated from TPDM to sink.
+
+There must be a tpda between tpdm and the sink. When there are some
+other trace event hw components in the same HW block with tpdm, tpdm
+and these hw components will connect to the coresight funnel. When
+there is only tpdm trace hw in the HW block, tpdm will connect to
+tpda directly.
diff --git a/Documentation/trace/coresight/coresight-tpdm.rst b/Documentation/trace/coresight/coresight-tpdm.rst
new file mode 100644
index 000000000000..4ba40b0db550
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-tpdm.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Trace performance monitoring and diagnostics monitor(TPDM).
+==============================
+
+    :Author:   Jinlong Mao <quic_jinlmao@quicinc.com>
+    :Date:     January 2023
+
+Hardware Description
+--------------------
+TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
+short serves as data collection component for various dataset types.
+The primary use case of the TPDM is to collect data from different data
+sources and send it to a TPDA for packetization, timestamping and funneling.
+
+Sysfs files and directories
+---------------------------
+Root: ``/sys/bus/coresight/devices/tpdm<N>``
+
+----
+
+:File:            ``enable_source`` (RW)
+:Notes:
+    - > 0 : enable the datasets of TPDM.
+
+    - = 0 : disable the datasets of TPDM.
+
+:Syntax:
+    ``echo 1 > enable_source``
+
+----
+
+:File:            ``integration_test`` (wo)
+:Notes:
+    Integration test will generate test data for tpdm.
+
+:Syntax:
+    ``echo value > integration_test``
+
+    value -  1 or 2.
+
+----
-- 
2.39.0

