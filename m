Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660D26EDAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjDYDkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjDYDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:40:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E34ECA;
        Mon, 24 Apr 2023 20:40:24 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P2vRbb011628;
        Tue, 25 Apr 2023 03:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=cNOclMCELNCK+CMcCiTtKRwn+cFcMI0/gkzNAob37fA=;
 b=iJTjbqPmCmIKcdRtZVrmnVZnyPks0Ij1aSm7r92nBaRyGwKall4QKtWZUn/BtSeFk4LH
 EWuOCTt+jIPEMzwQgwfHKkinhonEEDmrDxbDcXI0brT29Z69sEx6FALplR3yydrzsxJG
 eUewEoVlGcdngDBpEVQ9saIsIxhogrhld77eCBGso/lLMkdPL63dO7KpoS1Xg5wlS/Gc
 2QH1VifoUA352B1pTbVXzT/tW5HbXm9mOKGfEw0xYxDgIFROSUVuSASaN/TBtal1tC/x
 DD4uPmfql1WO9UjSPYwx2JGWozdLOHxANNGIVZpKFb0yBljjr81DzGtw8AjH8RdO96w9 nA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q628x8g4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P3eGLP008563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 20:40:16 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] phy: qcom-qmp-combo: Introduce orientation variable
Date:   Mon, 24 Apr 2023 20:40:06 -0700
Message-ID: <20230425034010.3789376-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1qUof-jEfrUBfTujVuhJCCli9bGpI3RS
X-Proofpoint-ORIG-GUID: 1qUof-jEfrUBfTujVuhJCCli9bGpI3RS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multiple places throughout the driver code has been written in
prepration for handling of orientation switching.

Introduce a typec_orientation in qmp_combo and fill out the various
"placeholders" with the associated logic. By initializing the
orientation to "normal" this change has no functional impact, but
reduces the size of the upcoming introduction of dynamic orientation
switching.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 +++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7280f7141961..6748f31da7a3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/usb/typec.h>
 
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 
@@ -63,6 +64,10 @@
 /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
 #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
+/* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
+#define SW_PORTSELECT_VAL			BIT(0)
+#define SW_PORTSELECT_MUX			BIT(1)
+
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
 struct qmp_phy_init_tbl {
@@ -1323,6 +1328,8 @@ struct qmp_combo {
 	struct clk_fixed_rate pipe_clk_fixed;
 	struct clk_hw dp_link_hw;
 	struct clk_hw dp_pixel_hw;
+
+	enum typec_orientation orientation;
 };
 
 static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
@@ -1955,29 +1962,23 @@ static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
 static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
 {
 	u32 val;
-	bool reverse = false;
+	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 
 	val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
 	      DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN;
 
-	/*
-	 * TODO: Assume orientation is CC1 for now and two lanes, need to
-	 * use type-c connector to understand orientation and lanes.
-	 *
-	 * Otherwise val changes to be like below if this code understood
-	 * the orientation of the type-c cable.
-	 *
-	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC2)
-	 *	val |= DP_PHY_PD_CTL_LANE_0_1_PWRDN;
-	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC1)
-	 *	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
-	 * if (orientation == ORIENTATION_CC2)
-	 *	writel(0x4c, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_MODE);
-	 */
-	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
+	if (dp_opts->lanes == 4 || reverse)
+		val |= DP_PHY_PD_CTL_LANE_0_1_PWRDN;
+	if (dp_opts->lanes == 4 || !reverse)
+		val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
+
 	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
-	writel(0x5c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
+	if (reverse)
+		writel(0x4c, qmp->pcs + QSERDES_DP_PHY_MODE);
+	else
+		writel(0x5c, qmp->pcs + QSERDES_DP_PHY_MODE);
 
 	return reverse;
 }
@@ -2235,7 +2236,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
-	bool reverse = false;
+	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
 	u32 status;
 	int ret;
 
@@ -2299,7 +2300,7 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
-	bool reverse = false;
+	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
 	u32 status;
 	int ret;
 
@@ -2358,7 +2359,7 @@ static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
-	bool reverse = false;
+	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;
 	u32 status;
 	int ret;
 
@@ -2462,6 +2463,7 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *com = qmp->com;
 	int ret;
+	u32 val;
 
 	if (qmp->init_count++)
 		return 0;
@@ -2495,10 +2497,12 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
 			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 
-	/* Default type-c orientation, i.e CC1 */
-	qphy_setbits(com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
-
-	qphy_setbits(com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE | DP_MODE);
+	/* Use software based port select and switch on typec orientation */
+	val = SW_PORTSELECT_MUX;
+	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
+		val |= SW_PORTSELECT_VAL;
+	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
+	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
 
 	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
 	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
@@ -3361,6 +3365,8 @@ static int qmp_combo_probe(struct platform_device *pdev)
 
 	qmp->dev = dev;
 
+	qmp->orientation = TYPEC_ORIENTATION_NORMAL;
+
 	qmp->cfg = of_device_get_match_data(dev);
 	if (!qmp->cfg)
 		return -EINVAL;
-- 
2.39.2

