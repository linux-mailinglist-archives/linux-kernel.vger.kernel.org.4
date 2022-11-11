Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947762519C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKKDZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:25:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FDA59867;
        Thu, 10 Nov 2022 19:25:35 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2td77016733;
        Fri, 11 Nov 2022 03:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+LcDJCGR0d0D4hLlz8YtCccmj6+WQ/Bu0GB1cKAUxsk=;
 b=Q0A0EIn/SY0wM7bp0hFPJT5qGeyhrh743ezMdqKI/BS7TAA/W1rb9TmlrQjjCXK0x2Ca
 mvqQpU+xgffie4c2cT+qOdmqtKyr2m1QIw77/yn5440/NG49bkc6A3B1KJXES2KwAglP
 kkU4teS4gKFEv7VQUG0W21iCxnVMHuF53hLwFpH08AqDoT66q6847NDfV9BhDBHrj1au
 AkUs8DWUaNrR9kaAAeok1YpoCBUCPj3xbMKT6f3D4kKFBjdJe+/PaVPhdeGx7y9Fvx5v
 2vDu+FjmHk3yOw5uaYCToCc3hgdcxU7KDnUujwDnbCMZlT4Xb8HyywuJvIE4EVw01RXQ cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksaqxren6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PLE7027147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:21 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:20 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Georgi Djakov" <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/10] interconnect: osm-l3: SC8280XP L3 and DDR scaling
Date:   Thu, 10 Nov 2022 19:25:05 -0800
Message-ID: <20221111032515.3460-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X7TEkaYeAXnh9_AjJA_U3Vw3V4jOnujN
X-Proofpoint-GUID: X7TEkaYeAXnh9_AjJA_U3Vw3V4jOnujN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280XP currently shows depressing results in memory benchmarks.
Fix this by introducing support for the platform in the OSM (and EPSS)
L3 driver and support for the platform in the bwmon binding.

Then add the necessary nodes and values throughout the sc8280xp and
sa8540p dtsi files to make the various devices on these platforms scale
both L3, memory bus and DDR.

Bjorn Andersson (10):
  interconnect: qcom: osm-l3: Use platform-independent node ids
  interconnect: qcom: osm-l3: Squash common descriptors
  interconnect: qcom: osm-l3: Add per-core EPSS L3 support
  interconnect: qcom: osm-l3: Simplify osm_l3_set()
  dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3
    compatibles
  arm64: dts: qcom: Align with generic osm-l3/epss-l3
  arm64: dts: qcom: sc8280xp: Add epss_l3 node
  arm64: dts: qcom: sc8280xp: Set up L3 scaling
  dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon
    instances
  arm64: dts: qcom: sc8280xp: Add bwmon instances

 .../interconnect/qcom,msm8998-bwmon.yaml      |   5 +
 .../bindings/interconnect/qcom,osm-l3.yaml    |  24 ++-
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  39 +++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 152 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +-
 drivers/interconnect/qcom/osm-l3.c            | 126 ++++-----------
 10 files changed, 252 insertions(+), 104 deletions(-)

-- 
2.17.1

