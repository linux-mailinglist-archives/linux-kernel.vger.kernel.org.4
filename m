Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9336EABCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjDUNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjDUNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:40:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22E9025;
        Fri, 21 Apr 2023 06:40:08 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LDOD52011770;
        Fri, 21 Apr 2023 13:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=SrlQ1fyqBwMZibIEE/0X0Lc9HUti+9A1aysZf3UlwIw=;
 b=RjYS+FOT3bbeoKUw2mzlinIDqnGWstPkTJQKMVTHgKbmgutUCb3OE3Bt3G4UnK9DPXTa
 3d140FYU3gJ0+XRfAAOI7ayl40kgQWaDIG/cq1pQ4V90wFatrjfhMsyECRnSLGTMCN96
 uIs2nS7Di8CGJBlLCjLfEWlVrXVfF+xgqYZI4zonzwoqDQ7UQbVa0S38a6XKP48sx2UO
 fAxIL1sMQY37GAkqeJ6DMJD4m+DS13ERjEy+GHQraCzWNcIGaISDU2SjwirsFS7+IJoO
 oZ1dc0VWhuyigIDzv3FVmIwRYnpCudeUxDZ3AQpr4JfjYcNxVYX+P8nb59Vx5Vnavq3Y 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3cpysrc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 13:39:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LDdwjZ014488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 13:39:58 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 06:39:53 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for USB
Date:   Fri, 21 Apr 2023 19:09:15 +0530
Message-ID: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M3Q8bBj0U0ys_L5OBIVQR4AQVnnEYVzi
X-Proofpoint-ORIG-GUID: M3Q8bBj0U0ys_L5OBIVQR4AQVnnEYVzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_05,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=577 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update relavent DT bindings for USB, add new config to the phy driver,
add USB and PHY nodes to the .dtsi and enable them in the board .dts
for the sa8775p-ride platform.

Shazad Hussain (6):
  dt-bindings: usb: qcom,dwc3: Add bindings for SA8775P
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SA8775P
  dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add SA8775P USB PHY
    binding
  phy: qcom-qmp: Add SA8775P USB3 UNI phy
  arm64: dts: qcom: sa8775p: add USB nodes
  arm64: dts: qcom: sa8775p-ride: enable USB nodes

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |   1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  92 +++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 239 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  45 ++++
 6 files changed, 381 insertions(+), 2 deletions(-)

-- 
2.17.1

