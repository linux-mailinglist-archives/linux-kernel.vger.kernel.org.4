Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9695EB251
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIZUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiIZUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:38:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B4A8973;
        Mon, 26 Sep 2022 13:38:16 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QK23B1023690;
        Mon, 26 Sep 2022 20:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LLzqGdwuKfnPHvUnLbDQcD3l/4Ld3OkFQ2xefY/ApRM=;
 b=lJG1OwAK/faNdoADDOdo613t0Xn2CY4xVM6r/hsrnytCPB/wGKC4NSTIudPRBs5j5CCl
 R1GzCwIndxkrZBbyLBz/s2fLPjz4ftgzGzLdihd3Q2rI+RhZ4GLUbVF+1CeLvHHLZP+n
 I0zJUaugYk33aq3xb/4jN/LfwK4kLGnAaFJltvI9qGjMQT95ClnypAABGYa42s9FAXSZ
 XBgKxcAKh9cgAIe/Unf9aJCyDuKIfQXbBiBqvwDRR6q1QKJ1GYSTJxew1M2NszyeqBRd
 vCM2y7CGzTojefo92fVhF4K6b3vXU2OhcS3nFwhB74kaoA1Ijs8Zg77sNf2YQOs6w0yc oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juh0hr9yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 20:38:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QKc6mR011761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 20:38:06 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 13:38:06 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] clock: qcom: SC8280XP display clock controller
Date:   Mon, 26 Sep 2022 13:37:58 -0700
Message-ID: <20220926203800.16771-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h0H1vDnndserFSivDbre6-2gnsKRp3GU
X-Proofpoint-ORIG-GUID: h0H1vDnndserFSivDbre6-2gnsKRp3GU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=968 phishscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds binding and implementation of the SC8280XP display clock controller.

Bjorn Andersson (2):
  dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
  clk: qcom: Add SC8280XP display clock controller

 .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |   97 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/dispcc-sc8280xp.c            | 3218 +++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  |  100 +
 5 files changed, 3425 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h

-- 
2.17.1

