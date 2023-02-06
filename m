Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61768B619
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBFHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBFHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:13:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670DC12875;
        Sun,  5 Feb 2023 23:13:07 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3165vlDF003536;
        Mon, 6 Feb 2023 07:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=DmFiP85FP/vxcQ0rmFb24P05jX+s/4Cj7aPv9HsHrH0=;
 b=bbz58a6WMyExPkRLrXvGY+byeVObWLL4+xXm9dEhxQre9CyYbHd+AL8kveR9pNBypvyY
 rZt4LuQ0lpfaZfYDSqOVHZjioCgM1UfBOiyyMnNqXFyM8kag4nvM1VOIzFWlqbIwN+RT
 /CpoK4kU2uu82XtDYq6fOuPMk/l+owv2+xmYzO+p9WXgQR2peUVlH3AssgycokfWS7jh
 +oFaVTb5g/CEHCDztzRwGL83JGdjzMzGWkUwTqI37jb2n7k+X9Rg78BhZt0nXZhcHI/f
 AluWMAAOpkhdksch135YAFQGTrN/jpfeDUnCJXKcavDvS3KzLC3M/3IItVoJv1pufm1y Sg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhghv2uhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 07:12:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3167CiMZ006914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 07:12:44 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 5 Feb 2023 23:12:36 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3 0/9] Add minimal boot support for IPQ5332
Date:   Mon, 6 Feb 2023 12:42:08 +0530
Message-ID: <20230206071217.29313-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xExxf9W8ishTxxW-UyPeNRgMXrY_liy7
X-Proofpoint-ORIG-GUID: xExxf9W8ishTxxW-UyPeNRgMXrY_liy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=526 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ5332 is Qualcomm's 802.11ax SoC for Routers, Gateways and
Access Points.

This series adds minimal board boot support for ipq5332-mi01.2 board.

Also, this series depends on the below patch
https://lore.kernel.org/linux-arm-msm/20230120082631.22053-1-quic_kathirav@quicinc.com/

Changes in V3:
	- Detailed change log is present in respective patches
	- V2 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230130114702.20606-1-quic_kathirav@quicinc.com/

Changes in V2:
	- Rebased on linux-next/master
	- Dropped the 'dt-bindings: mmc: sdhci-msm: add IPQ5332 compatible',
	  since it is already part of linux-next/master
	- Added a new patch 'clk: qcom: ipq5332: mark GPLL4 as critical temporarily'
	- Detailed change log is present in respective patches
	- V1 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230125104520.89684-1-quic_kathirav@quicinc.com/


Kathiravan T (9):
  dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
  pinctrl: qcom: Introduce IPQ5332 TLMM driver
  clk: qcom: Add STROMER PLUS PLL type for IPQ5332
  dt-bindings: clock: Add Qualcomm IPQ5332 GCC
  clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC
  dt-bindings: qcom: add ipq5332 boards
  dt-bindings: firmware: qcom,scm: document IPQ5332 SCM
  arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board support
  arm64: defconfig: Enable IPQ5332 SoC base configs

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 .../bindings/clock/qcom,ipq5332-gcc.yaml      |   61 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml   |  134 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   |   75 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  268 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |   11 +
 drivers/clk/qcom/clk-alpha-pll.h              |    1 +
 drivers/clk/qcom/gcc-ipq5332.c                | 3850 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq5332.c        |  861 ++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h  |  356 ++
 17 files changed, 5648 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5332.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq5332-gcc.h

-- 
2.17.1

