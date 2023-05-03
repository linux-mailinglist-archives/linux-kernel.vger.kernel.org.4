Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF606F56B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjECLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjECLAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:00:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F44C1F;
        Wed,  3 May 2023 04:00:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3439o2ix028765;
        Wed, 3 May 2023 11:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ayruRtZgD2T5QYRMWizogDlcWzfvLOcYDeNhAZN6hm4=;
 b=XbSpw1Cb0Go0dDd0AyignpYkNWtxx4na2oVeVHEAtLk5CIKa9y+J5wOrP8k0D4MHPYg/
 qTBaVQSQ5sPZHvSvNqpbsbmFGsANSNc6gwqrRtPo1JjZpZ7R6DTz6gDWeRm80IIom4kk
 ukMebMGBNx4gKHjdnRX1nTZj5U7ZyMiar7oT40HpvklM+K2uxRo7ci55pNPKtlTjvWB3
 qWuDI1+/Oq9eyMBY9M37VM0K51rxq3RZMIA3/BFWdL1N8w+NVD4CcMmOkga78CpZI2EH
 ALAby+Lwghr5o100DHIM2Dl7ymthDkMYTC3YE0XM5wThbe+fRzSIkHwmpamJcZEv2GR+ jQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbk7sgdrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 11:00:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343B08va024664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 11:00:08 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 04:00:02 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
Subject: [PATCH V3 0/3] Add video clock controller driver for SM8450
Date:   Wed, 3 May 2023 16:29:34 +0530
Message-ID: <20230503105937.24911-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: blAklyOJsbT-KJcjckYng8HeAzr419A1
X-Proofpoint-GUID: blAklyOJsbT-KJcjckYng8HeAzr419A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 mlxlogscore=721 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030092
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Add bindings, driver and DT node for video clock controller on SM8450.

Taniya Das (3):
  dt-bindings: clock: qcom: Add SM8450 video clock controller
  clk: qcom: videocc-sm8450: Add video clock controller driver for
    SM8450
  arm64: dts: qcom: sm8450: Add video clock controller

 .../bindings/clock/qcom,sm8450-videocc.yaml   |  77 +++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  12 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/videocc-sm8450.c             | 459 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sm8450-videocc.h   |  38 ++
 6 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
 create mode 100644 drivers/clk/qcom/videocc-sm8450.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8450-videocc.h

-- 
2.25.1

