Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59726FD427
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjEJDU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjEJDTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:19:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9C40F6;
        Tue,  9 May 2023 20:19:43 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A0LURK012311;
        Wed, 10 May 2023 03:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4Gvnm6KDHSPLSIkX9eKbidvrh/yuJS1nU0dJAJo1N4g=;
 b=HKdUXIIi0NT797TZe8sNyT11ALTk1fcW+/NPQ2bEPgBXSG++w7VMIUVNV7JbUlXxVMVK
 7GVYmmG/L/BY7munKzvon+qRtflMkJOMtqlJg1cge74305JPwxDQ/63bWVE4pA/jhLbC
 ThDhQDnSNJxRq3LXaPvHb+KxSEaii4XuUV/mpbXsm6oaF+GwaaYDuBvtveMtkkl7fEIT
 wK1/IheQ+ZM0+dNqCRQPb0Gk6qmI0LDookPRfv1yzcYTfXSVvAnSdyEWGj0egMDsrgMi
 BNePMTK0FdMRkWc7dQmg7miZeP7Xh05GYtHTgWzjWxYfFgRPaNJqVugczEHAZwYJvcHK /Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfyx08adx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 03:19:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A3JZYo022810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 03:19:35 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 20:19:35 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/8] phy: qcom-qmp-combo: Support orientation switching
Date:   Tue, 9 May 2023 20:19:22 -0700
Message-ID: <20230510031930.1996020-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XzSguFU4m7ee0vvZ4hfZKFFWJPBPAiTi
X-Proofpoint-GUID: XzSguFU4m7ee0vvZ4hfZKFFWJPBPAiTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for USB and DisplayPort orientation switching to the
QMP combo PHY, as well as updating the sc8280xp devices to include the
QMP in the SuperSpeed graph.

Bjorn Andersson (8):
  dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and
    orientation-switch
  phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
  phy: qcom-qmp-combo: Extend phy_mutex to all phy_ops
  phy: qcom-qmp-combo: Introduce orientation variable
  phy: qcom-qmp-combo: Introduce orientation switching
  phy: qcom-qmp-combo: Introduce drm_bridge
  arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
  arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  51 ++++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  28 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  28 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  34 +++
 drivers/phy/qualcomm/Kconfig                  |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 255 ++++++++++++++----
 6 files changed, 340 insertions(+), 59 deletions(-)

-- 
2.39.2

