Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876D71A03C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjFAOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjFAOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:35:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5591B0;
        Thu,  1 Jun 2023 07:35:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3516HMfs019107;
        Thu, 1 Jun 2023 14:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=lrnyQIpygLJZ9fbl2OnmnjygGlDH4h/Jr+0LW9apveI=;
 b=iqOMRqrR5wOwUljF6Wyu1vi3KdK9cYyitzqt5kap/ic0ax/xcTiiaGganURGC3wEffE9
 FyPNEYN5BmQwAObm21XFV96iyC2b3jfDxyBNtBW8ZuSu4SUmems1B1ZyRkzzeY5vE/Tt
 nQAg1jfNXVi0Dk056g1SqZx8VCKvpnLXeKXwXRpwoKLeMF57RaFQxXbGoQOicCmfeeRO
 1Eo5A9dxtg7/jzc/G+cvaw0sXrc7QWpF0yyYinoLNMFzo/2uPr1Ncb9Au6yEaJGtwEUk
 1WO/k6h+ftoIrtrZw29m18IBRXDBW15tsWDTeXnUSSYIX5tWNkobQeUugI3jnV5whmoP xg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxnwv18t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:35:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EZ8lO015492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:35:08 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 07:35:03 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V3 0/5] Add camera clock controller support for SM8550
Date:   Thu, 1 Jun 2023 20:04:25 +0530
Message-ID: <20230601143430.5595-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GBpUK-SmFXrcBGjkfqXn2J3vSrq1iZ40
X-Proofpoint-ORIG-GUID: GBpUK-SmFXrcBGjkfqXn2J3vSrq1iZ40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=2
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=871 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and devicetree node for camera clock controller on
SM8550. Update l configuration value to include L, CAL_L, RINGOSC_CAL_L
fields on lucid evo and ole pll's across chipsets. Remove setting CAL_L
field explicitly in lucid evo pll configure.

Jagadeesh Kona (5):
  dt-bindings: clock: qcom: Add SM8550 camera clock controller
  clk: qcom: Remove support to set CAL_L field in lucid evo pll
    configure
  clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
  clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
  arm64: dts: qcom: sm8550: Add camera clock controller

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8450.c               |   24 +-
 drivers/clk/qcom/camcc-sm8550.c               | 3585 +++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c              |    6 +-
 drivers/clk/qcom/dispcc-sm8450.c              |    6 +-
 drivers/clk/qcom/dispcc-sm8550.c              |    6 +-
 drivers/clk/qcom/gpucc-sa8775p.c              |    6 +-
 drivers/clk/qcom/gpucc-sm8450.c               |    6 +-
 include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
 12 files changed, 3834 insertions(+), 23 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h

-- 
2.40.1

