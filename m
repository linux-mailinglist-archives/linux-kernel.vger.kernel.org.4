Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950A868BA57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjBFKgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBFKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:35:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94A4206;
        Mon,  6 Feb 2023 02:35:03 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3167Kx3p004366;
        Mon, 6 Feb 2023 10:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=W0toyepOcpEnmNwiHaYGgmMb3irPFSZ1YuuJCtAvY/o=;
 b=WjB0WQUfbIn7mIuiODA7utDTxsU/qdL0KVNDNZydNJpbozUtHIhxXGI+SvqPTFTd6fp8
 mdFYGZgov3d5f6LrSWgqUFfbU48t717T/2yQvuEV7Con9YaAk2TaBB4OR/c/mFCv2Vog
 9CF7csCrnf4KYPT8BlZ5prhFe6xv/zSmeFv8KUhf15foL2Z3Cdg0v5V+rthu7m3WH/TK
 X8yUG6pygVMmTmpHfOaXBU+waC3Aq1c/2ozAg6cFm7sLQQtF+3D9kCiM9zOBMHhVXzTx
 3zMajhPSSGahBjnb8s2O3LEGKg5j3BqxD3Vnnd61s8knlTl7Te5/JzfzmGcN+5dltvvy hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhghv392d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 10:34:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316AXxfA013152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 10:33:59 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 02:33:51 -0800
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
Subject: [PATCH V7 0/7] Add minimal boot support for IPQ9574
Date:   Mon, 6 Feb 2023 16:03:30 +0530
Message-ID: <20230206103337.21000-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VmV8GtSC6vRD9hlEK0WK7hFNJp_6-Ztf
X-Proofpoint-ORIG-GUID: VmV8GtSC6vRD9hlEK0WK7hFNJp_6-Ztf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_04,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=716 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060091
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

V6 can be found at: https://lore.kernel.org/linux-arm-kernel/20230202150619.22425-1-quic_devipriy@quicinc.com/

Change log is added to the respective patches

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
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   |  130 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts  |   84 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  278 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-ipq9574.c                | 4295 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   11 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c        |  828 ++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  213 +
 include/dt-bindings/reset/qcom,ipq9574-gcc.h  |  164 +
 15 files changed, 6095 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq9574-gcc.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq9574-gcc.h


base-commit: 129af770823407ee115a56c69a04b440fd2fbe61
-- 
2.17.1

