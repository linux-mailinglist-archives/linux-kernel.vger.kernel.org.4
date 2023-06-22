Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7735673A299
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjFVOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjFVOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:01:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE541FC6;
        Thu, 22 Jun 2023 07:01:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MDxuTc026091;
        Thu, 22 Jun 2023 14:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NCqK9AWW1jrILuN42ZzM3jJivYAr8GWtU2zu3BJnavc=;
 b=eP2m5otM16OHpYe/8m3Pxf7Ke1/dadQbi2cdpIUkmF47KL/KcGo2MmcHXK51gTVb9WXq
 g5Vc2PX9Zu8XWIrKXsN9gPTQKC5ofQHsHAwhUrRMuriF5nTg9ce1dwGPZv5/BAYbu5H0
 hEdPjozCavqKE/0hYLhGhHbLkM950C50U+k+NXs2wEMECTuoQu5ideWsEbHvepJA4mL9
 bFlT2y81nWY1CfIouNzObWULn7AFJ0Ax+juwGVJPLzUIZOxEsEOCH+7VoGzsv03yJLL1
 sI5HFCZPngWSonl7TxnNH4BegQ88jWKcnDwOxfdF6ONjVk/lPONA+jyjMGyAP7VMba1P zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc2rcjqjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:01:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35ME13Cd026274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:01:04 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 07:00:29 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v3 1/3] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
Date:   Thu, 22 Jun 2023 19:29:53 +0530
Message-ID: <20230622135955.941-2-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230622135955.941-1-quic_ptalari@quicinc.com>
References: <20230622135955.941-1-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jz9v-McmzDg1VBnqjL8KIByd8t3D_KBl
X-Proofpoint-GUID: Jz9v-McmzDg1VBnqjL8KIByd8t3D_KBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306220118
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device mode supported registers and masks.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v2 -> v3:
- modified commit message to use device mode instead of slave mode

v1 -> v2:
- modified commit message
---
 include/linux/soc/qcom/geni-se.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 821a19135bb6..29e06905bc1f 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -35,6 +35,7 @@ enum geni_se_protocol_type {
 	GENI_SE_UART,
 	GENI_SE_I2C,
 	GENI_SE_I3C,
+	GENI_SE_SPI_SLAVE,
 };
 
 struct geni_wrapper;
@@ -73,12 +74,14 @@ struct geni_se {
 
 /* Common SE registers */
 #define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_OUTPUT_CTRL		0x24
 #define SE_GENI_STATUS			0x40
 #define GENI_SER_M_CLK_CFG		0x48
 #define GENI_SER_S_CLK_CFG		0x4c
 #define GENI_IF_DISABLE_RO		0x64
 #define GENI_FW_REVISION_RO		0x68
 #define SE_GENI_CLK_SEL			0x7c
+#define SE_GENI_CFG_SEQ_START		0x84
 #define SE_GENI_DMA_MODE_EN		0x258
 #define SE_GENI_M_CMD0			0x600
 #define SE_GENI_M_CMD_CTRL_REG		0x604
@@ -111,6 +114,9 @@ struct geni_se {
 /* GENI_FORCE_DEFAULT_REG fields */
 #define FORCE_DEFAULT	BIT(0)
 
+/* GENI_OUTPUT_CTRL fields */
+#define GENI_IO_MUX_0_EN		BIT(0)
+
 /* GENI_STATUS fields */
 #define M_GENI_CMD_ACTIVE		BIT(0)
 #define S_GENI_CMD_ACTIVE		BIT(12)
@@ -130,6 +136,9 @@ struct geni_se {
 /* GENI_CLK_SEL fields */
 #define CLK_SEL_MSK			GENMASK(2, 0)
 
+/* SE_GENI_CFG_SEQ_START fields */
+#define START_TRIGGER			BIT(0)
+
 /* SE_GENI_DMA_MODE_EN */
 #define GENI_DMA_MODE_EN		BIT(0)
 
-- 
2.17.1

