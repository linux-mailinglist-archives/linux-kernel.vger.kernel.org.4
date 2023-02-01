Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E568625A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBAJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBAJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:06:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06FE5D919;
        Wed,  1 Feb 2023 01:06:16 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3117VdHg011417;
        Wed, 1 Feb 2023 09:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AwaiLSDtQw5uLGESbQnWkJ31X4EUR2PwjzEPMhtai44=;
 b=ShxbigjZ/Bc1Dihzu03Armc04Jqr9rYSFvqrsfCN/MF3+p/gEZsgHjH5+r53nnvBWjyJ
 IbWDYdwn6WckwZrMF5jZR5/3QJNkp+ZHRO+d/0NpZCzdIEBYWWFkvtekWnXo5eEKrZn7
 x1tXaQ2p6dby24WKYUonQxziP3NMcKbe+/9Ow0ginMQbcFNM2+JxWCdmlv087/DGHbh7
 9rKSvCx1LUVfYdR5JXAIzxcRyAY5kh4J9cgODkDUgjfJx2/mP2dNyXSc0MdEUdpNiPFu
 m9l+vywpfdfW3HmnygPNgL4FIc/wrAnbJPFM7mhI9GI5A4GwnAl45aUCpVsYy3Ca7It/ kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3netc4btkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 09:05:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31195t3x023441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 09:05:55 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 01:05:46 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 0/5] Enable crashdump collection support for IPQ9574
Date:   Wed, 1 Feb 2023 14:35:24 +0530
Message-ID: <20230201090529.30446-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JYKSK0tXIDTmohLp25o6EZLqlz3ylFlN
X-Proofpoint-ORIG-GUID: JYKSK0tXIDTmohLp25o6EZLqlz3ylFlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_03,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=698 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashdump collection is enabled based on the DLOAD bit in the TCSR register.
This bit is set during bootup and cleared during shutdown. During crash,
dload bit is not cleared, due to which uboot starts crashdump collection.

This patch series adds the support for crashdump collection.

This series depends on the below patch set.
https://lore.kernel.org/linux-arm-msm/20230201060319.20434-1-quic_devipriy@quicinc.com/

Changes in V2:
	- rebased on linux-next/master
        - dropped co-developed by tag wherever applicable
	- V1 can be found at
	  https://lore.kernel.org/linux-arm-kernel/20230113160012.14893-1-quic_poovendh@quicinc.com/

Poovendhan Selvaraj (5):
  dt-bindings: scm: Add compatible for IPQ9574
  arm64: dts: Add support for Crashdump collection on IPQ9574
  firmware: scm: Modify only the DLOAD bit in TCSR register for download
    mode
  arm64: defconfig: Enable scm download mode config for IPQ9574 SoC.
  dt-bindings: tcsr: Add compatible for IPQ9574

 .../bindings/firmware/qcom,scm.yaml           |  1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 26 ++++++++++++++++++-
 arch/arm64/configs/defconfig                  |  1 +
 drivers/firmware/qcom_scm.c                   | 12 ++++++---
 5 files changed, 36 insertions(+), 5 deletions(-)


base-commit: 80bd9028fecadae4e8e3a278cd32d74badc2a6e0
-- 
2.17.1

