Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8938D7111F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbjEYRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjEYRWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:22:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21AEB6;
        Thu, 25 May 2023 10:22:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFs7O4006281;
        Thu, 25 May 2023 17:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=DG555D3M9CO+ZW5Z7N0SmGjp8+ALFgSnLS2Drwkx5jM=;
 b=NLSSt57IdaspXmT5vUfetIMdEQFdKtnsNB//WQYUDMT/vSAkd6Ni4X+esUXlNxIGuh2+
 tAO3tQ9500WTJft6vG+y5kSYbAQDAJHYnPvCzGhoysoLny3q0NNEombdUgGSCrnTrsc1
 YHvG77rPz2Ih/0aHbveY1AXtzC6KnHpSGUxwCAPfrQVz7RUzTb48e4pfgVnwAPILN7z2
 wISiZx0VeT78bFMRaRQoIT3F/j0dsHb6S7r44NqwLbiAZL8omX3XeavXv5omPT+7aDNx
 QY5mVg6WXUN//hKQfkNnfH8LpBqXkXtSXn6vezuOCJY9YDcqoIHGOSTA27GTLzvwMsek QA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt5ufrwu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:22:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PHM4Ss019919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:22:04 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 25 May 2023 10:21:59 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 0/6] Add camera clock controller support for SM8550
Date:   Thu, 25 May 2023 22:51:36 +0530
Message-ID: <20230525172142.9039-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gcCI66alefp6x7H2xpWgy2AHllW29N-F
X-Proofpoint-GUID: gcCI66alefp6x7H2xpWgy2AHllW29N-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_10,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 mlxlogscore=736 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and devicetree node for camera clock controller
on SM8550. Update l value in pll configuration for lucid ole and evo
pll's across chipsets and remove explicit CAL_L configuration for EVO
pll's.

Depends on [1] for PLL_TEST_CTL_U2 programming
[1] https://patchwork.kernel.org/project/linux-clk/list/?series=750700

Jagadeesh Kona (6):
  dt-bindings: clock: qcom: Add SM8550 camera clock controller
  clk: qcom: Update l value configuration for lucid ole and evo plls
  clk: qcom: clk-alpha-pll: Remove explicit CAL_L configuration for EVO
    PLL
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
 drivers/clk/qcom/dispcc-sm8450.c              |   10 +-
 drivers/clk/qcom/dispcc-sm8550.c              |    6 +-
 drivers/clk/qcom/gpucc-sa8775p.c              |    6 +-
 include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
 11 files changed, 3832 insertions(+), 23 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h

-- 
2.40.1

