Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430369ACAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBQNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBQNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:42:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BD69283;
        Fri, 17 Feb 2023 05:42:09 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HDMREM011616;
        Fri, 17 Feb 2023 13:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=32hHrNwVdp3H+nkRDnFu0KDuuQaMByuR/fwbgNhhWQ8=;
 b=ZSwzL1cItz/uhqsrOW7WVXnHnf+C7hu1HX1DSWBAUsDHZNcHHO1taRCud0goAXsFcJjf
 HIkMax9iqmjez2NcQ32/ESYBp3SbrPgsUUUpjEvTtqcE/XnZ353u7BE6FJrXftlhAuIV
 UgdxEaRqxBGlBJO9CCvxI5baoIYGiTB1ElZC7zLbLV25fpkMlUo74IwKAYARrgNntDNZ
 mULDExah1M6obOoZpr45Mzv5UK+AJJDwxBvRu8Rmt+1wp2HfJ4IquugxCkek1Ob2f8N0
 XYA22NLdyryeDrmF7DxrUCMM0fDtMRdLAWff8Af3UVZ+8rWt4Lr1pUnIGEi63XIWOsfV Ig== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nse3d4d6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 13:41:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HDfUnQ002868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 13:41:30 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 05:41:22 -0800
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
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH V2 0/5] Add APSS clock controller support for IPQ9574
Date:   Fri, 17 Feb 2023 19:11:02 +0530
Message-ID: <20230217134107.13946-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2NN81d_UwnOVUrlmIpuw929F8Y_JPtN6
X-Proofpoint-ORIG-GUID: 2NN81d_UwnOVUrlmIpuw929F8Y_JPtN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=874
 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APSS PLL found in IPQ9574 platform is of type Huayra.
This series adds support for the APSS clock to bump the CPU frequency
above 800MHz.

This series depends on the below patch set
https://lore.kernel.org/linux-arm-msm/20230217083308.12017-1-quic_kathirav@quicinc.com/

DTS patch depends on the PCIe series
https://lore.kernel.org/linux-arm-msm/20230214164135.17039-1-quic_devipriy@quicinc.com/

[V2]:
	- Reordered the patches as suggested
	- Dropped [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
	  as it was unrelated
	- Detailed Change logs are added to the respective patches
[V1]:
https://lore.kernel.org/linux-arm-kernel/20230113143647.14961-1-quic_devipriy@quicinc.com/

Devi Priya (5):
  dt-bindings: clock: qcom,a53pll: add IPQ9574 compatible
  clk: qcom: apss-ipq-pll: Enable APSS clock driver in IPQ9574
  dt-bindings: mailbox: qcom: add compatible for IPQ9574 SoC
  arm64: dts: qcom: ipq9574: Add support for APSS clock controller
  arm64: defconfig: Enable ipq6018 apss clock and PLL controller

 .../bindings/clock/qcom,a53pll.yaml           |  1 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 18 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/qcom/apss-ipq-pll.c               | 19 +++++++++++++++++++
 5 files changed, 40 insertions(+)


base-commit: c068f40300a0eaa34f7105d137a5560b86951aa9
-- 
2.17.1

