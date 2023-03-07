Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1776AD74B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCGGXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjCGGXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:23:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F320D2F;
        Mon,  6 Mar 2023 22:23:21 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3270S0Xm002087;
        Tue, 7 Mar 2023 06:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=v3eSfLi0MQiyxhJ9lHQLpvuKHcG5QUEYJSJ4qQfA1gM=;
 b=Hfs2GRc+kFu6JITbCvQ8tmHzP5YYZjWxsl9tuTksGGMo8ixVsZAjbEDmhXo8/GmmONI2
 gJRH/61cZlcVn+FRstedYulhxwBHWEJoYOBnkIsgCGUIbuCgnHE80eKrxP6PgA4V2une
 8vh4VyhJSit0aoKgAhUwujocOLOX2umYAwnS5HNQ4LmxYxJ2QxW5IJjxuJ+w1sMQ6wNE
 AOfBCNRw9/acdKQAn0FVCgRIuKvfR7xALadR7gDexUAExNaVaZyO9StbwZ+eWZVsntra
 aL7rYRglwS3mM+3ZpSVrizz2sgMke5Y7FOR5f5NsFfup6Mi5pjnQcX65URF/1iUEK+Cn kQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p4g3mwxh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:22:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276Mr76020667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:22:53 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 22:22:45 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V6 0/9] Add minimal boot support for IPQ5332
Date:   Tue, 7 Mar 2023 11:52:23 +0530
Message-ID: <20230307062232.4889-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zfLHgFxHVa_otHj8EkbLfcXCS6W3uFzY
X-Proofpoint-GUID: zfLHgFxHVa_otHj8EkbLfcXCS6W3uFzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 clxscore=1011 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=725 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303070056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ5332 is Qualcomm's 802.11be SoC for Routers, Gateways and
Access Points.

This series adds minimal board boot support for ipq5332-mi01.2 board.

Changes in V6:
	- Added couple of patches 1/9 and 5/9 in the series to make sure
	  all the dependent patches are together
	- V5 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230217075835.460-1-quic_kathirav@quicinc.com/

Changes in V5:
	- Dropped the clock-names from binding and DTS
	- Detailed change log is present in respective patches
	- V4 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230208155232.11500-1-quic_kathirav@quicinc.com/

Changes in V4:
	- Dropped the pinctrl driver and its binding, since it is
	  already part of linux-next/master
	- Detailed change log is present in respective patches
	- V3 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230206071217.29313-1-quic_kathirav@quicinc.com/

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

Kathiravan T (8):
  clk: qcom: Add STROMER PLUS PLL type for IPQ5332
  dt-bindings: clock: Add Qualcomm IPQ5332 GCC
  clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC
  clk: qcom: ipq5332: mark GPLL4 as ignore unused temporarily
  dt-bindings: qcom: add ipq5332 boards
  dt-bindings: firmware: qcom,scm: document IPQ5332 SCM
  arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board support
  arm64: defconfig: Enable IPQ5332 SoC base configs

Varadarajan Narayanan (1):
  clk: qcom: clk-alpha-pll: Add support for Stromer PLLs

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 .../bindings/clock/qcom,ipq5332-gcc.yaml      |   53 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   |   75 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  263 ++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |  139 +-
 drivers/clk/qcom/clk-alpha-pll.h              |   14 +-
 drivers/clk/qcom/gcc-ipq5332.c                | 3824 +++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h  |  356 ++
 13 files changed, 4742 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq5332-gcc.h


base-commit: dc837c1a5137a8cf2e9432c1891392b6a66f4d8d
-- 
2.17.1

