Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF06E20C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDNKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:30:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148C310FC;
        Fri, 14 Apr 2023 03:30:02 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EAB2YL018086;
        Fri, 14 Apr 2023 10:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MdfQFKES6jw8fw8QjG5eTZNIKiSSWxy6UfpOJBaGlUg=;
 b=WenTUlq+oQ7Cw+W1cTNZx8EdCE6jFISY3mJd7csTI2BEzs3NTM6dIipMTle7ohOdf1b6
 yaROLqqGsKTerXIWorirmrwE9AaRs6xMBtwZKnvgwu1EmBT/lKzeacWUR58J8xOC4M9E
 W6KQVRMe9d5kme8FlBSWi7kM5y3QXMF1R5kP6UB3/WPIYF/O43YSIivGlxpkXVE7qnn/
 xWAcJ8ljM1Uni2zNUduL2EMLkIBymGNwsDXlsbJm048qM8uF425VNs7miE278cbwcW2B
 w/rAZqhl5SlrO0RmxZxKiKDX9PQFkXVIm2/0L0oVfDKyBUffkO7mlfFPwo9Ci8D+1zLa Kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1kx0g17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:29:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EATmWT020186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:29:48 GMT
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 14 Apr 2023 03:29:42 -0700
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
        <linux-arm-kernel@lists.infradead.org>, <quic_srichara@quicinc.com>
Subject: [PATCH V3 0/9] Add minimal boot support for IPQ5018
Date:   Fri, 14 Apr 2023 15:59:18 +0530
Message-ID: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wSqlkZolsMg1JhXZB8NktOw5XPcrfxL0
X-Proofpoint-GUID: wSqlkZolsMg1JhXZB8NktOw5XPcrfxL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_04,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=797 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140094
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

This series adds minimal board boot support for ipq5018-mp03.1-c2 board.

[v3]
	Fixed all comments for clocks, schema fixes
        Picked up Reviewed-by from Bjorn for pinctrl driver

[v2]
	Fixed all comments and rebased for TOT.

Sricharan Ramabadhran (9):
  dt-bindings: arm64: Add IPQ5018 clock and reset
  clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018
  dt-bindings: pinctrl: qcom: Add support for ipq5018
  pinctrl: qcom: Add IPQ5018 pinctrl driver
  dt-bindings: qcom: Add ipq5018 bindings
  dt-bindings: firmware: document IPQ5018 SCM
  dt-bindings: mmc: sdhci-msm: Document the IPQ5018 compatible
  arm64: dts: Add ipq5018 SoC and rdp432-c2 board support
  arm64: defconfig: Enable IPQ5018 SoC base configs

 Documentation/devicetree/bindings/arm/qcom.yaml    |    7 +
 .../bindings/clock/qcom,ipq5018-gcc.yaml           |   63 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |    1 +
 .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml        |  129 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts     |   72 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  248 ++
 arch/arm64/configs/defconfig                       |    3 +
 drivers/clk/qcom/Kconfig                           |    7 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5018.c                     | 3731 ++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                       |   10 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq5018.c             |  791 +++++
 include/dt-bindings/clock/qcom,gcc-ipq5018.h       |  183 +
 include/dt-bindings/reset/qcom,gcc-ipq5018.h       |  122 +
 17 files changed, 5371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq5018.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5018.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h

-- 
2.7.4

