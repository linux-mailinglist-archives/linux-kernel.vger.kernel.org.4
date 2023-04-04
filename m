Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B856D5CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjDDKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjDDKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:17:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC28F;
        Tue,  4 Apr 2023 03:17:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334A9R5P004323;
        Tue, 4 Apr 2023 10:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=y+Enk9ytXsoOaS4RA9WDGye9PNpq6OKRR2me1LIQVw4=;
 b=Zz7TilLYPdHB695eDJbqOANMYDrq5LiUYmL/tUSHIcS2+W+T1mBMVHltDTEEhzLQVEPr
 1CATq1ZvCZhNVzbRVP02ZwMFhfTQqdaZa5Xxm70ZHKB07npSmlbzM9ZpuFKDPT64tL2v
 JPQo7U5Sl5W68zi3yyVhPZXNUz3KEKQvpOe0A6CorxGEpKqD0jucACAyCaBDLIDHX6Ac
 ZHKmg/RATANN2V6Z66O9UTh7ajkvD6E9XFVFRAcf9V5Fbz/azGvuhUgT6hVFugjgmWR8
 Lgv66xOboVM/q37agT+7gbEcLI+Z9NaivAX/MTaoPe+Mb367+pKCYpMzpyef9J4LGDrf tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqusu374m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 10:16:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334AGkmd020977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 10:16:46 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 03:16:36 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <rafal@milecki.pl>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH V11 0/4] Add minimal boot support for IPQ9574
Date:   Tue, 4 Apr 2023 15:46:18 +0530
Message-ID: <20230404101622.5394-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w5j8UAnDRZEjmhupV-CrHj_ekU1Y_FR3
X-Proofpoint-ORIG-GUID: w5j8UAnDRZEjmhupV-CrHj_ekU1Y_FR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_03,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=575 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040094
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ9574 is Qualcomm's 802.11ax SoC for Routers,
Gateways and Access Points

This series adds minimal board boot support for ipq9574-rdp433 variant

V10 can be found at:
https://lore.kernel.org/linux-arm-kernel/20230327132718.573-1-quic_devipriy@quicinc.com/

Changes in V11:
	- Detailed change log is added to the respective patches

Devi Priya (4):
  dt-bindings: clock: Add ipq9574 clock and reset definitions
  clk: qcom: Add Global Clock Controller driver for IPQ9574
  arm64: dts: qcom: Add support for ipq9574 SoC and RDP433 variant
  arm64: defconfig: Enable IPQ9574 SoC base configs

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |   60 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |   84 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  263 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-ipq9574.c                | 4225 +++++++++++++++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  213 +
 include/dt-bindings/reset/qcom,ipq9574-gcc.h  |  164 +
 10 files changed, 5021 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
 create mode 100644 drivers/clk/qcom/gcc-ipq9574.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq9574-gcc.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq9574-gcc.h


base-commit: 31bd35b66249699343d2416658f57e97314a433a
-- 
2.17.1

