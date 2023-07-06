Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD57494E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjGFFLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGFFLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:11:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FCE10E;
        Wed,  5 Jul 2023 22:11:50 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3664Vm4S009122;
        Thu, 6 Jul 2023 05:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NCqK9AWW1jrILuN42ZzM3jJivYAr8GWtU2zu3BJnavc=;
 b=gdzktnRRj4iNp0lNKbwC0HTbNJ5izqRU6eBiFST5hHc5E7SvVi2d+CviUWjTzMyY6Ukd
 T/rBi2lBfKR8yPtAzBwDqWO+1F6hc85WG9TmkzTFvwLxB0D/u8SiCqWjL+fp4W74eNcl
 m/Xu7GKL+Y0+doWeTyLPJNiW+d7/C159Q8aapYlqrN3X1LuO2tJQZbVHA+ZRCjQAQSkk
 nvXUH4Ls8w1PqEWFhrS86hikit4fZdhJZbLqx4w/00l15cjfqE+0GC5Ggi7+GfPC1AB8
 Fo59yi52wu2+SgsIM2EfeLODRAHoDcTfuWijGBw8TIm+w/7lArbxmuxodV9GP7ZR7SND VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmxy92w2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 05:11:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3665Bkpj018090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 05:11:46 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 22:11:42 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v4 1/2] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
Date:   Thu, 6 Jul 2023 10:40:23 +0530
Message-ID: <20230706051024.15422-2-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230706051024.15422-1-quic_ptalari@quicinc.com>
References: <20230706051024.15422-1-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CrvqK7pg5FitMpG3DQBxk9v909jcFfVS
X-Proofpoint-ORIG-GUID: CrvqK7pg5FitMpG3DQBxk9v909jcFfVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307060045
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

