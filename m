Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6C702237
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbjEOD27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjEOD21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:28:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55781FC8;
        Sun, 14 May 2023 20:27:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F3FxbI028333;
        Mon, 15 May 2023 03:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Xr1QVDAj7y1cBEmQzYFR1qGU47oaFCDW8VhlXfyyiCs=;
 b=XIWVHG48hoA5C1pZmzJozPhl9MkJaL5PKbmdmMHmxCZjP18XbDXJDUOdbA88lG6yaxq+
 yeFIWhws9d6xQX0v0w12QRdNsm/vUBiNC9pEXxccgms+i2YzA+3nw7DnYH+uMQ9fSqlK
 lIwcyXKvQKulnpMz4RtVoE/uR6R4e2zf0iJJiUXPaa7xa9r2p6MbMF9eV1LNveuNzWUJ
 x8z1XT2oQbVSBLPZalAXhtk5kzpbLGDf33giCh4j9RgRynbgRoOXP/IjUZ3NYz3EDq41
 117KzRyFDTuIShJ3I5+IBgJgnZBLkK6VNe0ZuSVLMMeuBkt7Rpb3rVv5fBaqnoewR3cJ iQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj3amajbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 03:27:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F3RnM4030251
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 03:27:49 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 14 May 2023 20:27:49 -0700
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
Subject: [PATCH v3 0/8] phy: qcom-qmp-combo: Support orientation switching
Date:   Sun, 14 May 2023 20:27:35 -0700
Message-ID: <20230515032743.400170-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kxqtCwucodIL01aQZtI6G9bG9xQ75Ny1
X-Proofpoint-ORIG-GUID: kxqtCwucodIL01aQZtI6G9bG9xQ75Ny1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_01,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
2.25.1

