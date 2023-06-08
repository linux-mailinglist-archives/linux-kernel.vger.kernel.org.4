Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2526727FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjFHMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbjFHMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:23:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494FA2709;
        Thu,  8 Jun 2023 05:23:11 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358BmcYK025325;
        Thu, 8 Jun 2023 12:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Z3dtTpcLrKlX9a6O3bdPA6tBkwCgqW/PWM0vugx9GK4=;
 b=DcWsioU3oJyO0SplO5KgeYmA0+T3bYRdS0Cn1HlOf5i93amP5poOMxQyAvpoox9SuUc2
 4R+kUug2PkUYYBYWWE0eRofGuzIsd1CUMMfOVYdDmPFWw+I4utzBKzftVwn0Ts7UINkk
 RHxjrrqYx11tdtIf8gAWeGMSZppDPpsFNKSl3cmZy15OTPzD2H/UhLc7ilcqcbpJJLl9
 zBNjvFkzn/7/nciTyPXSXOeDJ7My9eC7cFDZmAW2cTHVr3EEo7ojODGb+4rmxqUVymwq
 CqVygCeKBMXVDgzjjK7dYZsEyK5GsGBfo9/yBqiNoWm9h77sXbU19ieKPI3ZZQ6hymaG Nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r38rbrrrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 12:22:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358CMriT023508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 12:22:53 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 05:22:45 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <andy.shevchenko@gmail.com>,
        <quic_srichara@quicinc.com>
Subject: [v9 0/8] Add minimal boot support for IPQ5018
Date:   Thu, 8 Jun 2023 17:51:44 +0530
Message-ID: <20230608122152.3930377-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vCb5KSgza61xVw0Hm-Kd5Xh5uSMRTbu_
X-Proofpoint-ORIG-GUID: vCb5KSgza61xVw0Hm-Kd5Xh5uSMRTbu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=728 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ5018 is Qualcomm's 802.11ax SoC for Routers,
Gateways and Access Points.

This series adds minimal board boot support for ipq5018-rdp432-c2 board.

[v9]   Change only in patch 2/8
	   Sorted the headers and cleaned the unwanted ones
 	   Added trailing comma for .parent_hws member
	   Removed the hunk touching ipq5332 kconfig  (unintentionally)

[v8]   Changed only in patch 4/8
                Fixed Kconfig to add COMPILE_TEST and removed header of.h.
                Instead using mod_devicetable.h. Added Linus reviewed-by

[v7]   Fixed tz reserved region size in patch 7/8

[v6]   Fixed patch [4/8] pinctrl driver for rebase issue.

[v5]
       Added Reviewed-by tags from Krzysztof Kozlowski.
       Changed patch [6/8] with [1] since its already Acked
       Rebased patch [4/8] on top of [2] and fixed other comments
       Fixed commit log for patch [7/8]
       Fixed comments for patch [2/8]

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1678164097-13247-4-git-send-email-quic_mmanikan@quicinc.com/
[2] https://lore.kernel.org/r/1683718725-14869-1-git-send-email-quic_rohiagar@quicinc.com

[v4]
       Fixed all comments for clocks, schema, dts
       Added Reviewed-by tags.

[v3]
        Fixed all comments for clocks, schema fixes
        Picked up Reviewed-by from Bjorn for pinctrl driver

[v2]
        Fixed all comments and rebased for TOT.

Manikanta Mylavarapu (1):
  dt-bindings: scm: Add compatible for IPQ5018

Sricharan Ramabadhran (7):
  dt-bindings: arm64: Add IPQ5018 clock and reset
  clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018
  dt-bindings: pinctrl: qcom: Add support for ipq5018
  pinctrl: qcom: Add IPQ5018 pinctrl driver
  dt-bindings: qcom: Add ipq5018 bindings
  arm64: dts: Add ipq5018 SoC and rdp432-c2 board support
  arm64: defconfig: Enable IPQ5018 SoC base configs

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 .../bindings/clock/qcom,ipq5018-gcc.yaml      |   63 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml   |  127 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |   72 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         |  250 ++
 arch/arm64/configs/defconfig                  |    3 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-ipq5018.c                | 3724 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   11 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq5018.c        |  783 ++++
 include/dt-bindings/clock/qcom,gcc-ipq5018.h  |  183 +
 include/dt-bindings/reset/qcom,gcc-ipq5018.h  |  122 +
 16 files changed, 5357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq5018.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5018.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h

-- 
2.34.1

