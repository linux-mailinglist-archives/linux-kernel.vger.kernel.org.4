Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74EE696987
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBNQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBNQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:32:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45685267;
        Tue, 14 Feb 2023 08:32:03 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EDYEBV018675;
        Tue, 14 Feb 2023 16:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=a8nZi9u0n1eIFJcXzdA48iqS00QsanwQRwBvLTEtuWg=;
 b=EniuooVaW40Bscngyik7w6im3HElYj9tuJhe/zH/F7Y1uvtIUCLy/66t8fY2ha2X0j7T
 73lB63riviDW80jQKQMeMhNRxK3gWwHTazTCLU0Z3WCDdSsUQDzmmBV5L3QkSEGtPZrE
 39YOl8RDIay4hYeJxpJuhJZ8hNbQagnuRaH2iNf6aqCyCqRsSfEeBFe0dQWij/3jUvdo
 LgBEUz/glkhllZC1rfpj1SW14fJvxkFSp9HhQITOgyVTRGl3wHARxuEitnWg90MBeBph
 vVy8+CSkSe6TMaSZqF9v1MtTCPtEJqFsI0g3b4X9VWTWd4+GalolYTXhBUCqSynVJaib ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygt33m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:31:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGVcII010403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:31:38 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:31:29 -0800
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
Subject: [PATCH V8 0/7] Add minimal boot support for IPQ9574
Date:   Tue, 14 Feb 2023 22:01:09 +0530
Message-ID: <20230214163116.9924-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mHQVGoCqSHY32sMG7HE0Hq2P19aLNOzm
X-Proofpoint-GUID: mHQVGoCqSHY32sMG7HE0Hq2P19aLNOzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=705 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140140
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ9574 is Qualcomm's 802.11ax SoC for Routers,
Gateways and Access Points

This series adds minimal board boot support for ipq9574-al02-c7 board

V7 can be found at:
https://lore.kernel.org/linux-arm-kernel/20230206103337.21000-1-quic_devipriy@quicinc.com/

Change logs are added to the respective patches

Devi Priya (7):
  dt-bindings: clock: Add ipq9574 clock and reset definitions
  clk: qcom: Add Global Clock Controller driver for IPQ9574
  dt-bindings: pinctrl: qcom: Add support for IPQ9574
  pinctrl: qcom: Add IPQ9574 pinctrl driver
  dt-bindings: arm: qcom: Add ipq9574 compatible
  arm64: dts: qcom: Add ipq9574 SoC and AL02 board support
  arm64: defconfig: Enable IPQ9574 SoC base configs

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 .../bindings/clock/qcom,ipq9574-gcc.yaml      |   61 +
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   |  130 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts  |   84 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  270 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-ipq9574.c                | 4248 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   11 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c        |  828 ++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  213 +
 include/dt-bindings/reset/qcom,ipq9574-gcc.h  |  164 +
 15 files changed, 6029 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq9574-gcc.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq9574-gcc.h


base-commit: 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb
-- 
2.17.1

