Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487EC6BE15A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCQGi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQGix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:38:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01C72024;
        Thu, 16 Mar 2023 23:38:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6K3bE003612;
        Fri, 17 Mar 2023 06:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=2LEm1rlOKk4SFDtjTM+UU6Fh8rO/dnWJ0pWJPyDocQ8=;
 b=eS2c16Q7h/vYHhdcELw/WbvbhOwB/2O5IS3O1stWUYFAuSIJpey55l2T2+nOKOjp//87
 F+yDgZXohwgOvzj0aDRndnRHcDQcsmuWiW15c98G35aszrwNJ5gGbMYlZfrC/ZgwIrxd
 yjBhlvDhy2n9A0LCCmTIQ84JTMDDv9Ys6TdHaaubtPXZdpWvDd4lkAjHtbFXazQoGvIN
 m/DwzFBIfYuK5qslieYWhVyEcx0lgx1O9SY6QVUP9wZLLXcR340e0hKnGj8ieEdmKqtL
 CELJ04Mc/WN/Jahx/RZ1zzGNlxYF90lziS4gXOKDue76u9y4eijmKbukoBeu8Dcgq+cJ lg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbst93w78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:38:41 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32H6cata000626;
        Fri, 17 Mar 2023 06:38:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqmd71n-1;
        Fri, 17 Mar 2023 06:38:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H6caiV000627;
        Fri, 17 Mar 2023 06:38:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32H6cadB000621;
        Fri, 17 Mar 2023 06:38:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E794E4F09; Fri, 17 Mar 2023 12:08:35 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 2/2] phy: qcom-qmp: Add support for SDX65 QMP PCIe PHY
Date:   Fri, 17 Mar 2023 12:08:34 +0530
Message-Id: <1679035114-19879-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679035114-19879-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1679035114-19879-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BkduFD01U0-cMhAxdvzUIqYcjC-Um6EL
X-Proofpoint-GUID: BkduFD01U0-cMhAxdvzUIqYcjC-Um6EL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170044
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe PHY version used in SDX65 is v5.20 which has different register
offsets compared to the v5.0x and v4.0x PHYs. So separate register defines are
used for init sequence and PHY status.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 165 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |  24 +++
 4 files changed, 193 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 5182aea..e6c19fae 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1224,6 +1224,139 @@ static const struct qmp_phy_init_tbl sdx55_qmp_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
 };
 
+static const struct qmp_phy_init_tbl sdx65_qmp_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BG_TIMER, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYS_CLK_CTRL, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x27),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MISC1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE_CONTD, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_DC_LEVEL_CTRL, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl sdx65_qmp_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_2, 0xf6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_3, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_VMODE_CTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_PI_QEC_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_RX, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RCV_DETECT_LVL_2, 0x12),
+};
+
+static const struct qmp_phy_init_tbl sdx65_qmp_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_PRE_THRESH1, 0x3e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_PRE_THRESH2, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_MAIN_THRESH1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_MAIN_THRESH2, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_CNTRL1, 0x44),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x74),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1, 0xcc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3, 0xcc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B4, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6, 0x29),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_PHPRE_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_PI_CONTROLS, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_IDAC_SAOFFSET, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_3, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_DAC_ENABLE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_DAC_ENABLE2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_MAN_VAL, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_GM_CAL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B0, 0xc5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B1, 0xac),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B2, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B3, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B4, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B5, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B6, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B0, 0xc5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B1, 0xee),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B3, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B4, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B5, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B6, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_EN_TIMER, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+};
+
+static const struct qmp_phy_init_tbl sdx65_qmp_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_G3S2_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG4, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG5, 0x22),
+};
+
+static const struct qmp_phy_init_tbl sdx65_qmp_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_EQ_CONFIG1, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_RX_MARGINING_CONFIG3, 0x28),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_LANE1_INSIG_SW_CTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
+};
+
 static const struct qmp_phy_init_tbl sm8450_qmp_gen3_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
@@ -2387,6 +2520,35 @@ static const struct qmp_phy_cfg sm8350_qmp_gen3x2_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 };
 
+static const struct qmp_phy_cfg sdx65_qmp_pciephy_cfg = {
+	.lanes                  = 2,
+
+	.offsets		= &qmp_pcie_offsets_v6_20,
+
+	.tbls = {
+			.serdes         = sdx65_qmp_pcie_serdes_tbl,
+			.serdes_num     = ARRAY_SIZE(sdx65_qmp_pcie_serdes_tbl),
+			.tx             = sdx65_qmp_pcie_tx_tbl,
+			.tx_num         = ARRAY_SIZE(sdx65_qmp_pcie_tx_tbl),
+			.rx             = sdx65_qmp_pcie_rx_tbl,
+			.rx_num         = ARRAY_SIZE(sdx65_qmp_pcie_rx_tbl),
+			.pcs            = sdx65_qmp_pcie_pcs_tbl,
+			.pcs_num        = ARRAY_SIZE(sdx65_qmp_pcie_pcs_tbl),
+			.pcs_misc       = sdx65_qmp_pcie_pcs_misc_tbl,
+			.pcs_misc_num   = ARRAY_SIZE(sdx65_qmp_pcie_pcs_misc_tbl),
+		},
+	.clk_list               = sdm845_pciephy_clk_l,
+	.num_clks               = ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list             = sdm845_pciephy_reset_l,
+	.num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list              = qmp_phy_vreg_l,
+	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs                   = pciephy_v5_regs_layout,
+
+	.pwrdn_ctrl             = SW_PWRDN,
+	.phy_status             = PHYSTATUS_4_20,
+};
+
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -3181,6 +3343,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 		.compatible = "qcom,sdx55-qmp-pcie-phy",
 		.data = &sdx55_qmp_pciephy_cfg,
 	}, {
+		.compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy",
+		.data = &sdx65_qmp_pciephy_cfg,
+	}, {
 		.compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy",
 		.data = &sm8250_qmp_gen3x1_pciephy_cfg,
 	}, {
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
index 3d9713d..a3a0567 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
@@ -12,8 +12,11 @@
 #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS		0x090
 #define QPHY_V5_20_PCS_PCIE_EQ_CONFIG1			0x0a0
 #define QPHY_V5_20_PCS_PCIE_PRESET_P10_POST		0x0e0
+#define QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG2		0x0fc
 #define QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5		0x108
 #define QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN			0x15c
 #define QPHY_V5_20_PCS_PCIE_RX_MARGINING_CONFIG3	0x184
+#define QPHY_V5_20_PCS_LANE1_INSIG_SW_CTRL2		0xa24
+#define QPHY_V5_20_PCS_LANE1_INSIG_MX_CTRL2		0xa28
 
 #endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
index 9a5a20d..f0754b6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
@@ -8,6 +8,7 @@
 
 #define QPHY_V5_20_PCS_G3S2_PRE_GAIN			0x170
 #define QPHY_V5_20_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V5_20_PCS_EQ_CONFIG2			0x1d8
 #define QPHY_V5_20_PCS_EQ_CONFIG4			0x1e0
 #define QPHY_V5_20_PCS_EQ_CONFIG5			0x1e4
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
index 86c0110..c7b12c1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
@@ -11,6 +11,10 @@
 #define QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_RX	0x34
 #define QSERDES_V5_20_TX_LANE_MODE_1			0x78
 #define QSERDES_V5_20_TX_LANE_MODE_2			0x7c
+#define QSERDES_V5_20_TX_LANE_MODE_3			0x80
+#define QSERDES_V5_20_TX_RCV_DETECT_LVL_2		0x90
+#define QSERDES_V5_20_TX_VMODE_CTRL1			0xb0
+#define QSERDES_V5_20_TX_PI_QEC_CTRL			0xcc
 
 /* Only for QMP V5_20 PHY - RX registers */
 #define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2		0x008
@@ -19,16 +23,33 @@
 #define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1	0x02c
 #define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3	0x030
 #define QSERDES_V5_20_RX_RX_IDAC_SAOFFSET		0x07c
+#define QSERDES_V5_20_RX_DFE_1				0x088
+#define QSERDES_V5_20_RX_DFE_2				0x08c
 #define QSERDES_V5_20_RX_DFE_3				0x090
 #define QSERDES_V5_20_RX_DFE_DAC_ENABLE1		0x0b4
+#define QSERDES_V5_20_RX_TX_ADAPT_PRE_THRESH1		0x0bc
+#define QSERDES_V5_20_RX_TX_ADAPT_PRE_THRESH2		0x0c0
 #define QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1		0x0c4
 #define QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2		0x0c8
+#define QSERDES_V5_20_RX_TX_ADAPT_MAIN_THRESH1		0x0cc
+#define QSERDES_V5_20_RX_TX_ADAPT_MAIN_THRESH2		0x0d0
+#define QSERDES_V5_20_RX_VGA_CAL_CNTRL1			0x0d4
+#define QSERDES_V5_20_RX_VGA_CAL_CNTRL2			0x0d8
 #define QSERDES_V5_20_RX_VGA_CAL_MAN_VAL		0x0dc
 #define QSERDES_V5_20_RX_GM_CAL				0x0ec
+#define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL2		0x100
+#define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL3		0x104
 #define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4		0x108
+#define QSERDES_V5_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x118
+#define QSERDES_V5_20_RX_RX_OFFSET_ADAPTOR_CNTRL2	0x11c
+#define QSERDES_V5_20_RX_SIGDET_ENABLES			0x120
+#define QSERDES_V5_20_RX_SIGDET_CNTRL			0x124
+#define QSERDES_V5_20_RX_SIGDET_DEGLITCH_CNTRL		0x12c
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B0		0x160
 #define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1		0x164
 #define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2		0x168
 #define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3		0x16c
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B4		0x170
 #define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5		0x174
 #define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6		0x178
 #define QSERDES_V5_20_RX_RX_MODE_RATE2_B0		0x17c
@@ -46,7 +67,10 @@
 #define QSERDES_V5_20_RX_RX_MODE_RATE3_B5		0x1ac
 #define QSERDES_V5_20_RX_RX_MODE_RATE3_B6		0x1b0
 #define QSERDES_V5_20_RX_PHPRE_CTRL			0x1b4
+#define QSERDES_V5_20_RX_DFE_DAC_ENABLE2		0x1b8
+#define QSERDES_V5_20_RX_DFE_EN_TIMER			0x1bc
 #define QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET	0x1c0
+#define QSERDES_V5_20_RX_DCC_CTRL1			0x1c4
 #define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210	0x1f4
 #define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3	0x1f8
 #define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210	0x1fc
-- 
2.7.4

