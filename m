Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A345F18DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiJADHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiJADHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479C1B5EE4;
        Fri, 30 Sep 2022 20:06:05 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 291355Tc011861;
        Sat, 1 Oct 2022 03:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=F25VzeOT9tRmbYFnUi0yLLJk5VgqSX7Qttr5zZIUc00=;
 b=mt8nWIYyY02wNiqmlwZxyO+OyYjFW4BhzsAFgpKvcwKat8/Y7RkASaxMhVheYOoVJWMU
 o6OlchA6juq7u/4Suq7SMKFg+VVllAt5vuS92GoZhNV2wlxbPgHqP8jY+xJeSK8/ywhL
 lWZbKHky0PI9IJOGG4wgDb3XqKnPViXCx9f3yTYqyPWnVv1h/XP/+22nRNzOP5WuqExc
 tIzeRPjbmD9fKs0fjoDUdB6YhSXKhmmJTPQmk3s62LLMdvqoqzRZyPKVrko2WCxQ3Qvz
 gWlkW+YACV4Evpt6phDb3pl/IU/A5waR2+Mmxq+xiXSFBpBAiUylQe5E8UIG3Joxajxp iA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwx18k13h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:06:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 291362BK004276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:06:02 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:01 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 0/2] Add pinctrl support for QDU1000/QRU1000 SoCs
Date:   Fri, 30 Sep 2022 20:05:44 -0700
Message-ID: <20221001030546.28220-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TGlsk3YZjRcx5hrxunz6V-D9igYaYFYe
X-Proofpoint-GUID: TGlsk3YZjRcx5hrxunz6V-D9igYaYFYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=782 bulkscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds pinctrl support for the Qualcomm QDU1000 and QRU1000
SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Melody Olvera (2):
  dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl bindings
  pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver

 .../pinctrl/qcom,qdru1000-pinctrl.yaml        |  124 ++
 drivers/pinctrl/qcom/Kconfig                  |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-qdru1000.c       |   59 +
 drivers/pinctrl/qcom/pinctrl-qdru1000.h       | 1896 +++++++++++++++++
 5 files changed, 2090 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.h


base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
-- 
2.37.3

