Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEC680C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjA3Lrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3Lrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:47:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31222BF11;
        Mon, 30 Jan 2023 03:47:47 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBOVcL003571;
        Mon, 30 Jan 2023 11:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9+W/B7UVaPo2M/DDHgP37hzNidjWqDG4bP/F/hh+ewI=;
 b=nhqMMI34RmmaZ0lixya6zMPh6VtAWNQ0f6c4zHoVBKT9veOfP8T9dhHD0uKbrVDNtmf1
 R3lIceIWVS4jc0PKu9O1KtZbywVgxg/d2daUwRwxw1pK283HXibIFFZsxNcXa5UA+HLu
 0rkckWjcDbJkxvqZKpJMVcQhIdHXbEf1ThFAWzAR7glaMLqfbDPutUUzJJQ0cmvNe8zs
 QRlegQwTasAg5/KWsSejqCzm54rkBHHsJlEMfYi6AcxD3ijNtPruTsH1QZEQxIuWycex
 BZHCjziqPz46GdW7/TqWKYWDxRY5kIRCz9cQrQGTRT4qLu/B7eYz9HSLKii+mv/Y5OBu gQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncu1tus2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:47:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UBlMcC017595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:47:23 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 03:47:16 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/9] Add minimal boot support for IPQ5332
Date:   Mon, 30 Jan 2023 17:16:53 +0530
Message-ID: <20230130114702.20606-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R4kq7ukwQUB-mxL1njgAxNdOkSV-k_D_
X-Proofpoint-ORIG-GUID: R4kq7ukwQUB-mxL1njgAxNdOkSV-k_D_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=584 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300113
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
 .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml   |  136 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   |   71 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  272 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |   11 +
 drivers/clk/qcom/clk-alpha-pll.h              |    1 +
 drivers/clk/qcom/gcc-ipq5332.c                | 3954 +++++++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq5332.c        | 1008 +++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h  |  359 ++
 17 files changed, 5904 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5332.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq5332-gcc.h

-- 
2.17.1

