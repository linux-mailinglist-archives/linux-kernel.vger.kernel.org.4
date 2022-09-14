Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920755B8544
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiINJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiINJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:40:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31E17E09;
        Wed, 14 Sep 2022 02:39:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28E9djTO113572;
        Wed, 14 Sep 2022 04:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663148385;
        bh=oVGNjubgA1LuX49FyuBwm5DlshfpTfeRSSrz1PSeRUU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L+6xwiaW222+H0ApV1nLDa+7lwNK1h8mVPL+/lwde7okpPmwdYqK0G0oTssGARPWA
         I1WWo0oQ7hxple8hGpLBxpnk9nbiaNQSMItRqwTm7yVmTUyxN+91tqQ/kzQh6GRItI
         wi9CVgFH62G0yPJJthoYNscXxOMLQqVEby/xhiSY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28E9djFh014883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 04:39:45 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 04:39:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 04:39:45 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dBHJ111966;
        Wed, 14 Sep 2022 04:39:40 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 6/6] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration
Date:   Wed, 14 Sep 2022 15:09:11 +0530
Message-ID: <20220914093911.187764-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093911.187764-1-s-vadapalli@ti.com>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add register sequences for PCIe + SGMII PHY multilink configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 141 ++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 6e86a6517f37..7c0daf3e8880 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -24,7 +24,7 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		4
+#define NUM_PHY_TYPE		5
 
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
@@ -46,7 +46,9 @@
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
+#define SIERRA_CMN_PLLLC1_FBDIV_INT_PREG		0xC3
 #define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
+#define SIERRA_CMN_PLLLC1_CLK0_PREG			0xCE
 #define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
 #define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
 
@@ -74,6 +76,7 @@
 #define SIERRA_PSC_RX_A1_PREG				0x031
 #define SIERRA_PSC_RX_A2_PREG				0x032
 #define SIERRA_PSC_RX_A3_PREG				0x033
+#define SIERRA_PLLCTRL_FBDIV_MODE01_PREG		0x039
 #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
 #define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
 #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
@@ -298,6 +301,7 @@ enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
 	TYPE_USB,
+	TYPE_SGMII,
 	TYPE_QSGMII
 };
 
@@ -936,6 +940,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	case PHY_TYPE_USB3:
 		inst->phy_type = TYPE_USB;
 		break;
+	case PHY_TYPE_SGMII:
+		inst->phy_type = TYPE_SGMII;
+		break;
 	case PHY_TYPE_QSGMII:
 		inst->phy_type = TYPE_QSGMII;
 		break;
@@ -1339,7 +1346,7 @@ static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
 			}
 		}
 
-		if (phy_t1 == TYPE_QSGMII)
+		if (phy_t1 == TYPE_SGMII || phy_t1 == TYPE_QSGMII)
 			reset_control_deassert(sp->phys[node].lnk_rst);
 	}
 
@@ -1537,6 +1544,71 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* SGMII PHY PMA lane configuration */
+static struct cdns_reg_pairs sgmii_phy_pma_ln_regs[] = {
+	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
+};
+
+static struct cdns_sierra_vals sgmii_phy_pma_ln_vals = {
+	.reg_pairs = sgmii_phy_pma_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_phy_pma_ln_regs),
+};
+
+/* SGMII refclk 100MHz, no ssc, opt3 and GE1 links using PLL LC1 */
+static const struct cdns_reg_pairs sgmii_100_no_ssc_plllc1_opt3_cmn_regs[] = {
+	{0x002D, SIERRA_CMN_PLLLC1_FBDIV_INT_PREG},
+	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
+	{0x1005, SIERRA_CMN_PLLLC1_CLK0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
+	{0x0800, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+static const struct cdns_reg_pairs sgmii_100_no_ssc_plllc1_opt3_ln_regs[] = {
+	{0x688E, SIERRA_DET_STANDEC_D_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
+	{0x0106, SIERRA_PLLCTRL_FBDIV_MODE01_PREG},
+	{0x0013, SIERRA_PLLCTRL_SUBRATE_PREG},
+	{0x0003, SIERRA_PLLCTRL_GEN_A_PREG},
+	{0x0106, SIERRA_PLLCTRL_GEN_D_PREG},
+	{0x5231, SIERRA_PLLCTRL_CPGAIN_MODE_PREG },
+	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
+	{0x9702, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x0051, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x3C0E, SIERRA_CREQ_CCLKDET_MODE01_PREG},
+	{0x3220, SIERRA_CREQ_FSMCLK_SEL_PREG},
+	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
+	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
+	{0x0186, SIERRA_DEQ_GLUT0},
+	{0x0186, SIERRA_DEQ_GLUT1},
+	{0x0186, SIERRA_DEQ_GLUT2},
+	{0x0186, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x0861, SIERRA_DEQ_ALUT0},
+	{0x07E0, SIERRA_DEQ_ALUT1},
+	{0x079E, SIERRA_DEQ_ALUT2},
+	{0x071D, SIERRA_DEQ_ALUT3},
+	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
+	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
+	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0033, SIERRA_DEQ_PICTRL_PREG},
+	{0x0000, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
+	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_cmn_vals = {
+	.reg_pairs = sgmii_100_no_ssc_plllc1_opt3_cmn_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_cmn_regs),
+};
+
+static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_ln_vals = {
+	.reg_pairs = sgmii_100_no_ssc_plllc1_opt3_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_ln_regs),
+};
+
 /* QSGMII PHY PMA lane configuration */
 static struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] = {
 	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
@@ -2363,6 +2435,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
@@ -2377,6 +2454,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
@@ -2388,6 +2470,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
@@ -2403,6 +2492,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
@@ -2414,6 +2508,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
@@ -2435,6 +2536,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
@@ -2443,6 +2549,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 		},
 	},
 	.phy_pma_ln_vals = {
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_phy_pma_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_phy_pma_ln_vals,
+				[INTERNAL_SSC] = &sgmii_phy_pma_ln_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_phy_pma_ln_vals,
@@ -2458,6 +2571,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
@@ -2469,6 +2587,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
@@ -2484,6 +2609,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &ti_ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ti_ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ti_ml_pcie_100_int_ssc_ln_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &ti_ml_pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &ti_ml_pcie_100_ext_ssc_ln_vals,
@@ -2495,6 +2625,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
-- 
2.25.1

