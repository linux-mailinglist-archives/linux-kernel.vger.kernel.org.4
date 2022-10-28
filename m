Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666616108E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiJ1DmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiJ1DmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:42:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A722D0CEB;
        Thu, 27 Oct 2022 20:42:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S1fSb6024445;
        Fri, 28 Oct 2022 03:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=g5+N1PHowRMUT5TXOjJDnHoPkr/6MxFxj3HIebfEAeg=;
 b=ogCuhoC8ME8upWhGZIOsaDF0KQ5OiAIj79gJxCFST5/ZTm0khr4u7j3buwzHit5WWoDA
 FbZOEVcBeJ0B/G0Uqv7H78wTHqLIQlWC6TNFVrq2/FZIKS/2CUlbA3Xqelabqnruapj7
 uSH2Wk8/Fr7LjJ4jA4+mCKZxQpyaOqDGvBR8k6y4RGU2fSjaOSRA5xQLfHJXOqg3o3EP
 5cM5vSzfPtjHrvA7gD7nQ3cy5B+QZfsX9Hrjmu3Cv3yCoCLStY3NRmsOUYuPRX9qgBzk
 IRoQ2HMOHbx8WPVdojHKyE7gXSU9qLQcUiDKjKDlcqCgNmRb34onIR5YqDiPFkx82sYM Wg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfyf7h3fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29S3g1rA003679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:01 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 20:42:00 -0700
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
Subject: [PATCH 00/10] interconnect: osm-l3: SC8280XP L3 and DDR scaling
Date:   Thu, 27 Oct 2022 20:41:45 -0700
Message-ID: <20221028034155.5580-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3MdJ1CNUHZnUqBOvIqTODDRU_rZLAtIK
X-Proofpoint-GUID: 3MdJ1CNUHZnUqBOvIqTODDRU_rZLAtIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280022
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
 .../bindings/interconnect/qcom,osm-l3.yaml    |  22 ++-
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  39 +++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 152 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +-
 drivers/interconnect/qcom/osm-l3.c            | 126 ++++-----------
 10 files changed, 251 insertions(+), 103 deletions(-)

-- 
2.37.3

