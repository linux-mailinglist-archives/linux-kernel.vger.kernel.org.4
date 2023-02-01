Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D097685E48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBAETH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBAETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:19:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A13F2B2;
        Tue, 31 Jan 2023 20:19:03 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114Bx1A029916;
        Wed, 1 Feb 2023 04:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=CrymkedV5laHK2FzFN517hNBKAJU5Sy8gU2V0LVlGnU=;
 b=XPRMB0yxqgd+oL4ddVVtPsmtTeiHGuwbLnnJaGdUlYkJ+sTGLSkAHUOzBjQm2O7nU4JM
 9N+6+zIcYrLHOXT0UpahkTg4yFHJYYOUfCacHNXYMOQ/Zm/YpUySLyP+s/rTOssZGJDd
 4y39UEb4Ik4zAw9iUacZuJ4mIm2J4tHnjHIZV7Cp8ylrLRaeD42KEDPErl0MSoCwjZyL
 8OpmcwiVytaxf4m8yTpjleKpfDEpQ15hvJRdWdB1jRHh6qrjfB8dyZEOlAzYH+v4fdwB
 pLZGsyrAJf4Dj9Mf8koexKiTzrQ61Fc18qkzWJVjraI8hEP3OU139wlBACi2icEyNsY2 Dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3netc4b8xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 04:19:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3114IxXD004524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 04:18:59 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 20:18:58 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/4] soc: qcom: Introduce PMIC GLINK
Date:   Tue, 31 Jan 2023 20:18:49 -0800
Message-ID: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TnHORyjvtcA-t7w1s6WBJk7HUY4zydao
X-Proofpoint-ORIG-GUID: TnHORyjvtcA-t7w1s6WBJk7HUY4zydao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=841 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the base PMIC GLINK driver, a power_supply driver and a
driver for the USB Type-C altmode protocol. This has been tested and
shown to provide battery information, USB Type-C switch and mux requests
and DisplayPort notifications on SC8180X, SC8280XP and SM8350.

Bjorn Andersson (4):
  dt-bindings: soc: qcom: Introduce PMIC GLINK binding
  soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
  soc: qcom: pmic_glink: Introduce altmode support
  power: supply: Introduce Qualcomm PMIC GLINK power supply

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |   95 ++
 drivers/power/supply/Kconfig                  |    9 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
 drivers/soc/qcom/Kconfig                      |   15 +
 drivers/soc/qcom/Makefile                     |    2 +
 drivers/soc/qcom/pmic_glink.c                 |  336 ++++
 drivers/soc/qcom/pmic_glink_altmode.c         |  478 ++++++
 include/linux/soc/qcom/pmic_glink.h           |   32 +
 9 files changed, 2389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
 create mode 100644 drivers/power/supply/qcom_battmgr.c
 create mode 100644 drivers/soc/qcom/pmic_glink.c
 create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
 create mode 100644 include/linux/soc/qcom/pmic_glink.h

-- 
2.25.1

