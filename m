Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DD60E86F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiJZTID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiJZTHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:07:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2A192A4;
        Wed, 26 Oct 2022 12:05:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIppis017921;
        Wed, 26 Oct 2022 19:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=OnbNAszLwwpNV9bgl3vGZhpAqeYHTnVxF7CmwEswKjs=;
 b=fbEF5vv5YCT85jjj5UXAcCfQiRwni0qxqAVN8OFBwMq2xcuEqDejQIss/H5zCantaqm4
 IpeyTLBXz7qp5UmKuJzpVTI2BtxbnP6T01DaUC+Tj/vGeKn7+eEe4f6pSAhdyFHLKEeP
 friLnqbbrOIqlJs9bNUdeS2dgQfiIBuHHL56MmZy+1TcIES/+570H1QPUzaf+Hc1brRM
 Xyy61mTH7WESOttN2sG1VGWLkh42ytKbcJqPyCZgTmU0VKGJMzz9El32ghfIHra186si
 8fKqtavShf0jVrbhasuRBHbDkGkM/MFBiYHRGngEexP7sq7NOnLJmZhZc6594+1zcs5g vw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfaj001fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:04:53 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJ4qHO013943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:04:52 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:04:52 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 0/5] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoCs
Date:   Wed, 26 Oct 2022 12:04:36 -0700
Message-ID: <20221026190441.4002212-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nqAXesLAyoSbdTqmIEzlarqXGy1ShAY5
X-Proofpoint-ORIG-GUID: nqAXesLAyoSbdTqmIEzlarqXGy1ShAY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=839
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

This patchset is based on the YAML conversion patch [1] submitted already.

[1] https://lore.kernel.org/r/20220103074348.6039-1-luca.weiss@fairphone.com

Changes from v2:
- Revised dt-bindings
- Removed qru compat strings
- Updated some clocks to use clk_branch ops instead of clk_branch2 and HALT_ENABLE

Melody Olvera (4):
  dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
  dt-bindings: clock: Add RPMHCC bindings for QDU1000 and QRU1000
  clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks
  dt-bindings: qcom,pdc: Introduce pdc bindings for QDU1000 and QRU1000

Taniya Das (1):
  clk: qcom: Add QDU1000 and QRU1000 GCC support

 .../bindings/clock/qcom,gcc-qdu1000.yaml      |   77 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   13 +
 drivers/clk/qcom/gcc-qdu1000.c                | 2645 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-qdu1000.h  |  170 ++
 8 files changed, 2916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
 create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h


base-commit: 60eac8672b5b6061ec07499c0f1b79f6d94311ce
-- 
2.25.1

