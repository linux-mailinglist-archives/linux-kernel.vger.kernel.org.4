Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EB5B6280
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiILVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiILVH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:07:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011F4AD4F;
        Mon, 12 Sep 2022 14:07:23 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CKAWuo022713;
        Mon, 12 Sep 2022 21:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=JPui+m1sTy4UWR4WfKlasGuzzQ6pT5frq4NflYKcmnk=;
 b=WQmjgTIWUgwl0c5k08N/A+wc9yp2Gy7Cjr8YMLoWNkSwvMoItcQdQXH9QtzTjnf3fBAb
 5yCVsb8ZNdeCAzmfGKKstZcxltepV4GWLXB/YUYEXgrCknzFDFePQg0aMXq+LODqz2lj
 vhcDY6IqYSrvaRuUBEASA/ydqeRfYaZVKZ0HLsxc3y3QeltfCDqRKEedyq5wXiEp1kOj
 w591Ib3Rr6VEtoV6oLPwRTxPLkzCwD026mXBzNOwSGJrVE+XwY6+Dk0hwuS1bcvg8Gcv
 JCd/0dGCTTiPiOYPM4aisV2OxBGMKeqwnZKuhkFtKN9hVCMlyR/NDurP1fL3L7GoMKYb Ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkgpd81f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:07:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CL7GuL001914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:07:16 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 14:07:16 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 2/4] pinctrl: qcom: spmi-gpio: Fix the GPIO strength mapping
Date:   Mon, 12 Sep 2022 14:06:25 -0700
Message-ID: <20220912210624.4527-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220912210624.4527-1-quic_amelende@quicinc.com>
References: <20220912210624.4527-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L9F2Iy11lN5EDnVz9brFBdSvRoHo_QW2
X-Proofpoint-ORIG-GUID: L9F2Iy11lN5EDnVz9brFBdSvRoHo_QW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPMI based PMICs have the HIGH and LOW GPIO output strength mappings
interchanged, fix them.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 27 ++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index cf6b6047de8d..3973ea77aada 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -101,6 +101,9 @@
 #define PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS	1
 #define PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS	2
 
+#define PMIC_GPIO_OUT_STRENGTH_LOW		1
+#define PMIC_GPIO_OUT_STRENGTH_HIGH		3
+
 /* PMIC_GPIO_REG_EN_CTL */
 #define PMIC_GPIO_REG_MASTER_EN_SHIFT		7
 
@@ -440,7 +443,17 @@ static int pmic_gpio_config_get(struct pinctrl_dev *pctldev,
 		arg = pad->pullup;
 		break;
 	case PMIC_GPIO_CONF_STRENGTH:
-		arg = pad->strength;
+		switch (pad->strength) {
+		case PMIC_GPIO_OUT_STRENGTH_HIGH:
+			arg = PMIC_GPIO_STRENGTH_HIGH;
+			break;
+		case PMIC_GPIO_OUT_STRENGTH_LOW:
+			arg = PMIC_GPIO_STRENGTH_LOW;
+			break;
+		default:
+			arg = pad->strength;
+			break;
+		}
 		break;
 	case PMIC_GPIO_CONF_ATEST:
 		arg = pad->atest;
@@ -527,7 +540,17 @@ static int pmic_gpio_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PMIC_GPIO_CONF_STRENGTH:
 			if (arg > PMIC_GPIO_STRENGTH_LOW)
 				return -EINVAL;
-			pad->strength = arg;
+			switch (arg) {
+			case PMIC_GPIO_STRENGTH_HIGH:
+				pad->strength = PMIC_GPIO_OUT_STRENGTH_HIGH;
+				break;
+			case PMIC_GPIO_STRENGTH_LOW:
+				pad->strength = PMIC_GPIO_OUT_STRENGTH_LOW;
+				break;
+			default:
+				pad->strength = arg;
+				break;
+			}
 			break;
 		case PMIC_GPIO_CONF_ATEST:
 			if (!pad->lv_mv_type || arg > 4)
-- 
2.35.1

