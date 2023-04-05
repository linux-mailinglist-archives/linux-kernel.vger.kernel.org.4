Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB00F6D7D28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjDEM7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjDEM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:59:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2835BBC;
        Wed,  5 Apr 2023 05:59:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Ct6qJ009997;
        Wed, 5 Apr 2023 12:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=EpptDtQ1HuunohQuXlNGs29IRWwrA6ktepMVnXFRLRs=;
 b=GGMfX60M1snbjj4ZJWqtbDtvbmr00M4er0DjBWY5WDoCJerH+chjEA8/Ty9gCUEgj60e
 lKxmFP0NmRybUq2hQmeqJyPTH69KXQgsIo9fFDi6tR0K8ReLQ9fjNRC1NuvgvlIJK+AJ
 1SDih54J6baYIceD036NWBAuAOwq7IsFGwk7+J5KWpCX8O16EQpkhXjNQYsXPpkoX1bw
 QZJGI5Y1M9uiCPMPfun+wXQBzPOV6X0ju0nyTcIjrXSAYUxtvTbr5VqJxw/7LEJM/x5f
 aCeCqiFG/lQ/xxuSsv4c7IhLuNzCUn3Rdj3FFsAwQFk9GTJ3+IY8Wi5kU/eP5MRdh7Nj 4g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prn8b2xvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 12:58:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335CwwEN016502
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 12:58:58 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 05:58:52 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v6 5/8] usb: dwc3: qcom: Add multiport controller support for qcom wrapper
Date:   Wed, 5 Apr 2023 18:27:56 +0530
Message-ID: <20230405125759.4201-6-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405125759.4201-1-quic_kriskura@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qjPKVgOs1Lz__7Y59LI11CCT3ElpHsX1
X-Proofpoint-ORIG-GUID: qjPKVgOs1Lz__7Y59LI11CCT3ElpHsX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_07,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=965 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050115
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
for all the ports during suspend/resume.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v5: https://lore.kernel.org/all/20230310163420.7582-6-quic_kriskura@quicinc.com/

 drivers/usb/dwc3/dwc3-qcom.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 959fc925ca7c..7a9bce66295d 100644
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
+};
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
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
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
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		dwc3_qcom_setbits(qcom->qscratch_base,
+			pwr_evnt_irq_stat_reg_offset[i],
+			PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
 
 	qcom->is_suspended = false;
 
-- 
2.40.0

