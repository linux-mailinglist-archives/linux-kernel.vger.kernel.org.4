Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF46D8F24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjDFGOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjDFGOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:14:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7952D10CB;
        Wed,  5 Apr 2023 23:14:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3363Qkr6017532;
        Thu, 6 Apr 2023 06:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NFWetsE9KvJsPPSwB4D2j1OpKDvowd/F44sbNQiiFfs=;
 b=SFL/VLwcJMWgEejErj5CV8hYoeRawHtFwJWKHx4Wh49oE/JUIYiBRid2KNkHpx+rI9V3
 9DEfhN6nC+hMll+ABB/X+q7P43VuULO3q+UciLaZGud4sQNoHvOYMHjWyKZf/7pAB3TN
 zVuTp7ICP3q5oR4XJjQ0y2FzhjnO/KmbNY5AWDdIFtR2NB0jAa4g99sLHn0ASdzJwCVG
 XXP5+GkVZ2I1qqe1Do98Md0UV8wj2Bix+yvdO2yvZayMA5PBa1D+zECX9CTiE+NO2CbO
 6fcJyc+AZDPruZpemQXBru8NDmRtR2T0B8h/Gn4a7HFsH5fTKIu9g2tUTBo0s2qkH8Aj bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psnmj0cnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 06:13:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3366Dc2E024892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 06:13:38 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 23:13:29 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 0/5] Add APSS clock controller support for IPQ9574
Date:   Thu, 6 Apr 2023 11:43:09 +0530
Message-ID: <20230406061314.10916-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VS7hQXVqsUlrahz64DKaFpnBz8wtbcl9
X-Proofpoint-ORIG-GUID: VS7hQXVqsUlrahz64DKaFpnBz8wtbcl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=838 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060053
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APSS PLL found in IPQ9574 platform is of type Huayra.
This series adds support for the APSS clock to bump the CPU frequency
above 800MHz.

DTS patch is based on the below series
https://lore.kernel.org/linux-arm-msm/20230404164828.8031-1-quic_devipriy@quicinc.com/

[V3]:
	- Detailed change logs are added to the respective patches
[V2]:
https://lore.kernel.org/linux-arm-msm/20230217134107.13946-1-quic_devipriy@quicinc.com/
	- Reordered the patches as suggested
	- Dropped [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
	  as it was unrelated
	- Detailed Change logs are added to the respective patches
[V1]:
https://lore.kernel.org/linux-arm-msm/20230113143647.14961-1-quic_devipriy@quicinc.com/

Devi Priya (5):
  dt-bindings: clock: qcom,a53pll: add IPQ9574 compatible
  clk: qcom: apss-ipq-pll: Add support for IPQ9574
  dt-bindings: mailbox: qcom: add compatible for IPQ9574 SoC
  arm64: dts: qcom: ipq9574: Add support for APSS clock controller
  arm64: defconfig: Enable ipq6018 apss clock and PLL controller

 .../bindings/clock/qcom,a53pll.yaml           |  1 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 18 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/qcom/apss-ipq-pll.c               | 19 +++++++++++++++++++
 5 files changed, 40 insertions(+)


base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
-- 
2.17.1

