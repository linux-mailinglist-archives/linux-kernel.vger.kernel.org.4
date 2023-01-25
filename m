Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE067AFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjAYKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAYKqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:46:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E032D56;
        Wed, 25 Jan 2023 02:46:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P7U2Ma007077;
        Wed, 25 Jan 2023 10:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/rE7plyDah/nBJmzuMFXucz4lzFGzHs4vSiVS7Yw+7Q=;
 b=UXwi27jp13YLSmhUWkt1BGSdTz2wC3pssRAZCSpfwFjgvEF5IvELRoejYJR9Y1IKh9jg
 PcoOC2wr4t/bFAVSlsFN1c4RqH6c/9jTvqZkpRaT880+NiL9i0wEjFidNn2jezGhClln
 e6p2ka+68m9/HPNpGblulTsPHodXFWWPQZVIgl8PewXRBqctqDh9ROpADimj+vAi8AnP
 ty/WW9Q/q9iJX3QY2gHD1s+1dR7Fp8dXBMnHH7zvLwBnAWsFhor2K8deE+8DityLIeBs
 vpf8a2NsDtkL9SPGf3OTqn7UG77zi9JTkAAfaMn/RlF5WmDwaG9W6cqAfa4L5M6IMIyK Lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nag309xwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 10:45:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PAjg5k000913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 10:45:42 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 02:45:34 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 00/10] Add minimal boot support for IPQ5332
Date:   Wed, 25 Jan 2023 16:15:10 +0530
Message-ID: <20230125104520.89684-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0y2CuRzgWXyyYHKpRuNV58BgtErF3Mjg
X-Proofpoint-GUID: 0y2CuRzgWXyyYHKpRuNV58BgtErF3Mjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=579 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

The IPQ5332 is Qualcomm's 802.11ax SoC for Routers, Gateways and
Access Points.

This series adds minimal board boot support for ipq5332-mi01.2 board.

Also, this series depends on the below patch
https://lore.kernel.org/linux-arm-msm/20230120082631.22053-1-quic_kathirav@quicinc.com/

Kathiravan T (10):
  dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
  pinctrl: qcom: Introduce IPQ5332 TLMM driver
  clk: qcom: Add STROMER PLUS PLL type for IPQ5332
  dt-bindings: clock: Add Qualcomm IPQ5332 GCC
  clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC
  dt-bindings: qcom: add ipq5332 boards
  dt-bindings: firmware: document IPQ5332 SCM
  dt-bindings: mmc: sdhci-msm: add IPQ5332 compatible
  arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board support
  arm64: defconfig: Enable IPQ5332 SoC base configs

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 .../bindings/clock/qcom,ipq5332-gcc.yaml      |   55 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml    |    1 +
 .../pinctrl/qcom,ipq5332-pinctrl.yaml         |  134 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   |   71 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  273 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |   11 +
 drivers/clk/qcom/clk-alpha-pll.h              |    1 +
 drivers/clk/qcom/gcc-ipq5332.c                | 3954 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq5332.c        | 1008 +++++
 include/dt-bindings/clock/qcom,gcc-ipq5332.h  |  359 ++
 18 files changed, 5897 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5332.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5332.h

-- 
2.34.1

