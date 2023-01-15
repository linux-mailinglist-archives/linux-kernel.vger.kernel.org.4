Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD766B0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjAOLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjAOLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:42:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198210ABC;
        Sun, 15 Jan 2023 03:42:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FBbXht003741;
        Sun, 15 Jan 2023 11:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=H20S8ELH9qYJC4Qh8PH4n3kMF4E+MgQmDR16kIjBito=;
 b=HaYEZiouVU9McBLJQwBM6beCyLYe/cZPBU98wYLFko0Ylv1EocNP5/3LxhmF2puhPObr
 WMg90TSoK9Du3Iu7yEnabs0QD6au3lhyMCzwMuDT4a4p/SfzAvFQ4xXdqmoOUeNSey/9
 xiJ4zEZxYRuMvBrlUaTMxJelTkxUg7bBe8tkj/wFmLgqDJ+3dyceuYZGgCWII/UWPgAS
 Tj08+xzouCIhM0P7TL1TqA58+AAp/AMUGjnqEO2yEgKzcHTlnDUiNXoG4aFVHEljgt/s
 2fQGU6GO/GsTJ56TCJzLkVK4jz9MT8JXkVoPNmgSGUvE6Grusv7vpKbk+OjFDhTPcZnk ag== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3kdg1u61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30FBgPdc026104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:25 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 03:42:19 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC v4 4/5] usb: dwc3: qcom: Add multiport controller support for qcom wrapper
Date:   Sun, 15 Jan 2023 17:11:45 +0530
Message-ID: <20230115114146.12628-5-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115114146.12628-1-quic_kriskura@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AwCzy8Jn4HSIoUT0RSgBXf_oyeyoAWFO
X-Proofpoint-GUID: AwCzy8Jn4HSIoUT0RSgBXf_oyeyoAWFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=885
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150089
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM SoC SA8295P supports 2 HS+SS ports and 2 HS only ports. Add
support for configuring PWR_EVENT_IRQ's for all the ports during
suspend/resume.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b0a0351d2d8b..feef0e737bc9 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -37,7 +37,10 @@
 #define PIPE3_PHYSTATUS_SW			BIT(3)
 #define PIPE_UTMI_CLK_DIS			BIT(8)
 
-#define PWR_EVNT_IRQ_STAT_REG			0x58
+#define PWR_EVNT_IRQ1_STAT_REG			0x58
+#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
+#define PWR_EVNT_IRQ3_STAT_REG			0x228
+#define PWR_EVNT_IRQ4_STAT_REG			0x238
 #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
 #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
 
@@ -93,6 +96,13 @@ struct dwc3_qcom {
 	struct icc_path		*icc_path_apps;
 };
 
+static u32 pwr_evnt_irq_stat_reg_offset[4] = {
+			PWR_EVNT_IRQ1_STAT_REG,
+			PWR_EVNT_IRQ2_STAT_REG,
+			PWR_EVNT_IRQ3_STAT_REG,
+			PWR_EVNT_IRQ4_STAT_REG,
+		};
+
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
 {
 	u32 reg;
@@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 {
 	u32 val;
 	int i, ret;
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 
 	if (qcom->is_suspended)
 		return 0;
 
-	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
-	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
-		dev_err(qcom->dev, "HS-PHY not in L2\n");
+	for (i = 0; i < dwc->num_ports; i++) {
+		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
+		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
+			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
+	}
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--)
 		clk_disable_unprepare(qcom->clks[i]);
@@ -446,6 +459,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 {
 	int ret;
 	int i;
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 
 	if (!qcom->is_suspended)
 		return 0;
@@ -467,8 +481,10 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
 
 	/* Clear existing events from PHY related to L2 in/out */
-	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
-			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	for (i = 0; i < dwc->num_ports; i++)
+		dwc3_qcom_setbits(qcom->qscratch_base,
+			pwr_evnt_irq_stat_reg_offset[i],
+			PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
 
 	qcom->is_suspended = false;
 
-- 
2.39.0

