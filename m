Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57F6688120
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjBBPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjBBPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:07:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C284B40;
        Thu,  2 Feb 2023 07:07:08 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312D5gMA029018;
        Thu, 2 Feb 2023 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1zif5ytY87uKxJ+vKgYHMSv+bV5ssR+q75n3sSXTFBQ=;
 b=KaJ7DZS1AlWVwoOOCAEmkdh57QLYUSH4RtZnUWmjbZJjvKu2re1D6WDS9CPBh/D/wIB+
 37A8XNu9qviQPHV96i6vhVEs/pRiKCyT+DLRLNP0enhDZ05lqqUq+q0cZI052Fh26Vex
 SYm0GOXwY83EzN6Iw2/9rorj6virPGuTmVR5AxxWeGrJtnrd1+K6xL8yt6/U6IC1tcF1
 Aua1fR+ImULaP+4NqOxE9inDzfA5LPikrOmnQkbSUH4tfO0Ligy1+isH9zSKet/Q6mIW
 4qFjSOi8PR+fGPLq3TPWdVoLPC/Pv+gWvbgQU/QcF+/dBPK+XZi9KQoXH9zLz794iTFY aQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfqsyawcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 15:06:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312F6fH2004269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 15:06:41 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 07:06:32 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH V6 0/7] Add minimal boot support for IPQ9574
Date:   Thu, 2 Feb 2023 20:36:12 +0530
Message-ID: <20230202150619.22425-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tls0TEPc2Ua39fSlpCbAwKwDp49KCA4G
X-Proofpoint-ORIG-GUID: tls0TEPc2Ua39fSlpCbAwKwDp49KCA4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=735 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ9574 is Qualcomm's 802.11ax SoC for Routers,
Gateways and Access Points

This series adds minimal board boot support for ipq9574-al02-c7 board

V5 can be found at: https://lore.kernel.org/linux-arm-kernel/20230202083031.10457-1-quic_devipriy@quicinc.com/

Changes in V6:
	- [PATCH V6 7/7] : Updated the commit message and added the Reviewed-by tag 
	- No changes were made to the remaining patches

Devi Priya (7):
  dt-bindings: clock: Add ipq9574 clock and reset definitions
  clk: qcom: Add Global Clock Controller driver for IPQ9574
  dt-bindings: pinctrl: qcom: Add support for IPQ9574
  pinctrl: qcom: Add IPQ9574 pinctrl driver
  dt-bindings: arm: qcom: Add ipq9574 compatible
  arm64: dts: qcom: Add ipq9574 SoC and AL02 board support
  arm64: defconfig: Enable IPQ9574 SoC base configs

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 .../bindings/clock/qcom,ipq9574-gcc.yaml      |   72 +
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   |  137 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts  |   84 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  278 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-ipq9574.c                | 4302 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   11 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c        |  861 ++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  213 +
 include/dt-bindings/reset/qcom,ipq9574-gcc.h  |  164 +
 15 files changed, 6142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq9574-gcc.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq9574-gcc.h


base-commit: ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf
-- 
2.17.1

