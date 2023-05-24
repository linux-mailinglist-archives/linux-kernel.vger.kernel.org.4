Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD470F93B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjEXOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjEXOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:53:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9DE4A;
        Wed, 24 May 2023 07:52:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OEoQqZ018693;
        Wed, 24 May 2023 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=s2tzbHZ6tRclonQlCeSSqG2fAfKn4T3Y0xn3fTKkLsM=;
 b=NT0QXyeEmJT4pHrrFMJeErjAz0tED12dYEYGTe0BY7SBUh2lGeZxSnjsAXecLpxpXZLC
 iS+YS8ZDRDEvutaAqHMnoGOL5/ZWx1jhkQzG9cnsSaskOsGxYRCX1UfmX680b82+Qo74
 8OYHbgMq5XjhSLKeKz5yjMsINRfbRKnS4kAIjouxCmG23nBZx9AoTUATr1nX6ZLWRb/i
 yyt3tXQKGAm1KLRfRvzQT8vI5KdqoZKkrG6Id49+5c+RId+gfhHXJTu913MXxEQ/Omye
 Rmy7r+h6u+zms3jumq6qoy2q2uFYe33Ldh+rimFpQTK8TeRutOIXl/p2iIMGFMC4PXUJ sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs4dfa0ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:52:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OEqPf3010379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:52:25 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 24 May 2023 07:52:20 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
Subject: [PATCH V2 0/4] Add Video Clock Controller driver for SM8550
Date:   Wed, 24 May 2023 20:21:59 +0530
Message-ID: <20230524145203.13153-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lw8Ic0BAGVl-lD1nbPtQOa7KSvuruSo6
X-Proofpoint-ORIG-GUID: lw8Ic0BAGVl-lD1nbPtQOa7KSvuruSo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_10,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=783
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and DT node for video clock controller on SM8550.
Also, add support to configure PLL_TEST_CTL_U2 register for ole pll.

Depends on [1] for SM8450 videocc YAML file
[1] https://patchwork.kernel.org/project/linux-clk/list/?series=750683

Jagadeesh Kona (4):
  clk: qcom: clk-alpha-pll: Add support to configure PLL_TEST_CTL_U2
  dt-bindings: clock: qcom: Add SM8550 video clock controller
  clk: qcom: videocc-sm8550: Add video clock controller driver for
    SM8550
  arm64: dts: qcom: sm8550: Add video clock controller

 .../bindings/clock/qcom,sm8450-videocc.yaml   |   4 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  13 +
 drivers/clk/qcom/Kconfig                      |  10 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clk-alpha-pll.c              |   2 +
 drivers/clk/qcom/clk-alpha-pll.h              |   1 +
 drivers/clk/qcom/videocc-sm8550.c             | 470 ++++++++++++++++++
 7 files changed, 500 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/videocc-sm8550.c

-- 
2.40.1

