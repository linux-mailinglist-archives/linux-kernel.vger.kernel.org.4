Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC74C6684E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALVCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjALVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:00:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332FB91;
        Thu, 12 Jan 2023 12:45:05 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CKeXXf010657;
        Thu, 12 Jan 2023 20:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=vBXwAb72vX2Wqd9imLAbByiYWkxH8zt/8X98sXB0xUY=;
 b=UPPFmjGuAvBKhP5RPkt4QdYgnZPYWu+PBa4MQCvHbOsMIvyNUBHq5PE6EzyBqkji0c6b
 fFW23hElqJLExNJGEnLvWg55vvBCjPAsy/Rvyvp/UMCzYZzmQsPPUbMoUJA0lbCmKrJI
 hs0Y6oUTNddLN5DIeK3T40FqKsLRbzCnxW2NfBXVMQ/XFcY087gvuvr4x6TWif7zuq8w
 w5Q456mCZ2FCyc0D+927j9w2NjHexMTf1QDdwfvNJsCQnscfZUs9/8xdVsArB/hBcdS+
 vC2qGp+gNuqx0Kxy+o1gL5bgJ9qBYYMADwyMi2dRXin1D5SjMM0uV9Bv7vzCpdXpFee+ AQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2evhsnw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 20:45:01 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CKj04x031349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 20:45:00 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 12:45:00 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v6 0/2] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoCs
Date:   Thu, 12 Jan 2023 12:44:44 -0800
Message-ID: <20230112204446.30236-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -wCfVRrsQSm6l3MvxfrZyS4c1EsCvWFg
X-Proofpoint-ORIG-GUID: -wCfVRrsQSm6l3MvxfrZyS4c1EsCvWFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1011 mlxlogscore=942 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the GCC, RPMh, and PDC clock support required for the
QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Changes from v5:
- Fixed properties in bindings
- Updated dt index macros

Changes from v4:
- removed syscon from bindings and update style
- removed optional clocks and redundant properties
- updated compatible to new standard

Changes from v3:
- added example sources for PCIE and USB clocks
- added index enum in GCC clock driver
- fixed some style issues
- removed pdc patches from set

Changes from v2:
- Revised dt-bindings
- Removed qru compat strings
- Updated some clocks to use clk_branch ops instead of clk_branch2 and HALT_ENABLE

Melody Olvera (1):
  dt-bindings: clock: Add QDU1000 and QRU1000 GCC clocks

Taniya Das (1):
  clk: qcom: Add QDU1000 and QRU1000 GCC support

 .../bindings/clock/qcom,qdu1000-gcc.yaml      |   51 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-qdu1000.c                | 2653 +++++++++++++++++
 include/dt-bindings/clock/qcom,qdu1000-gcc.h  |  175 ++
 5 files changed, 2888 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
 create mode 100644 include/dt-bindings/clock/qcom,qdu1000-gcc.h


base-commit: 0a093b2893c711d82622a9ab27da4f1172821336
-- 
2.38.1

