Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6170C439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjEVRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjEVRYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:24:32 -0400
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C602FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8748; q=dns/txt; s=iport;
  t=1684776270; x=1685985870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xKoskdBhkZr2JURFYPQ2/JJgJ2iUPRt/j8suS3z9pTI=;
  b=X1n2UXgefNyGy61LwFx7BsSbaP2EeDJT6kjmWXUvYMK+mFKii2ut4CdB
   hDJYkXL4/1lKKeXY4Z4i6D0xOgLeDNkY81P9Blw3GSZYobho2DEcfQH6O
   g1blYH9dSlff6SbxuN/ul7gSiKCBgNv0prkw4+BhTaBcYh5NCgaZ4K9jB
   w=;
X-IronPort-AV: E=Sophos;i="6.00,184,1681171200"; 
   d="scan'208";a="60536514"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 May 2023 17:24:28 +0000
Received: from sjc-ads-7449.cisco.com (sjc-ads-7449.cisco.com [10.30.220.234])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 34MHOSVu008961
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 17:24:28 GMT
Received: by sjc-ads-7449.cisco.com (Postfix, from userid 1777032)
        id F2629CCD0B1; Mon, 22 May 2023 10:24:27 -0700 (PDT)
From:   Marcin Wierzbicki <mawierzb@cisco.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Marcin Wierzbicki <mawierzb@cisco.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: [PATCH v3] phy: cadence: Sierra: Add single link SGMII register configuration
Date:   Mon, 22 May 2023 17:24:13 +0000
Message-Id: <20230522172415.1668975-1-mawierzb@cisco.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.220.234, sjc-ads-7449.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single link SGMII register configuration for no SSC for
cdns,sierra-phy-t0 compatibility string.
The configuration is based on Sierra Programmer's Guide and
validated in Cisco CrayAR SoC.

Co-developed-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Signed-off-by: Marcin Wierzbicki <mawierzb@cisco.com>
---
v3
- all reported comments were addressed
- v2: https://lore.kernel.org/lkml/20230508160142.2489365-1-mawierzb@cisco.com/T/#u

v2
- rebased version on top of commit 0cfa43ab46b5 ("phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration")
- v1: https://lore.kernel.org/lkml/20230419093008.195094-1-mawierzb@cisco.com/T/

Regards,
Marcin
---
---
 drivers/phy/cadence/phy-cadence-sierra.c | 102 +++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 13fcd3a65fe9..28dd5f606bd3 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -30,23 +30,34 @@
 #define SIERRA_COMMON_CDB_OFFSET			0x0
 #define SIERRA_MACRO_ID_REG				0x0
 #define SIERRA_CMN_PLLLC_GEN_PREG			0x42
+#define SIERRA_CMN_PLLLC_FBDIV_INT_MODE0_PREG		0x43
+#define SIERRA_CMN_PLLLC_DCOCAL_CTRL_PREG		0x45
+#define SIERRA_CMN_PLLLC_INIT_PREG			0x46
+#define SIERRA_CMN_PLLLC_ITERTMR_PREG			0x47
 #define SIERRA_CMN_PLLLC_MODE_PREG			0x48
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
 #define SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG		0x4B
+#define SIERRA_CMN_PLLLC_LOCKSEARCH_PREG		0x4C
 #define SIERRA_CMN_PLLLC_CLK1_PREG			0x4D
+#define SIERRA_CMN_PLLLC_CLK0_PREG			0x4E
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
 #define SIERRA_CMN_PLLLC_DSMCORR_PREG			0x51
 #define SIERRA_CMN_PLLLC_SS_PREG			0x52
 #define SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG		0x53
 #define SIERRA_CMN_PLLLC_SSTWOPT_PREG			0x54
+#define SIERRA_CMN_PLLCSM_PLLEN_TMR_PREG		0x5D
+#define SIERRA_CMN_PLLCSM_PLLPRE_TMR_PREG		0x5E
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
 #define SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG		0x63
+#define SIERRA_SDOSCCAL_CLK_CNT_PREG			0x6E
 #define SIERRA_CMN_REFRCV_PREG				0x98
+#define SIERRA_CMN_RESCAL_CTRLA_PREG			0xA0
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
 #define SIERRA_CMN_PLLLC1_FBDIV_INT_PREG		0xC3
+#define SIERRA_CMN_PLLLC1_DCOCAL_CTRL_PREG		0xC5
 #define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
 #define SIERRA_CMN_PLLLC1_CLK0_PREG			0xCE
 #define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
@@ -86,6 +97,7 @@
 #define SIERRA_DFE_BIASTRIM_PREG			0x04C
 #define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
 #define SIERRA_DRVCTRL_BOOST_PREG			0x06F
+#define SIERRA_LANE_TX_RECEIVER_DETECT_PREG		0x071
 #define SIERRA_TX_RCVDET_OVRD_PREG			0x072
 #define SIERRA_CLKPATHCTRL_TMR_PREG			0x081
 #define SIERRA_RX_CREQ_FLTR_A_MODE3_PREG		0x085
@@ -101,6 +113,8 @@
 #define SIERRA_CREQ_SPARE_PREG				0x096
 #define SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG		0x097
 #define SIERRA_CTLELUT_CTRL_PREG			0x098
+#define SIERRA_DEQ_BLK_TAU_CTRL1_PREG			0x0AC
+#define SIERRA_DEQ_BLK_TAU_CTRL4_PREG			0x0AF
 #define SIERRA_DFE_ECMP_RATESEL_PREG			0x0C0
 #define SIERRA_DFE_SMP_RATESEL_PREG			0x0C1
 #define SIERRA_DEQ_PHALIGN_CTRL				0x0C4
@@ -129,6 +143,9 @@
 #define SIERRA_DEQ_GLUT14				0x0F6
 #define SIERRA_DEQ_GLUT15				0x0F7
 #define SIERRA_DEQ_GLUT16				0x0F8
+#define SIERRA_POSTPRECUR_EN_CEPH_CTRL_PREG		0x0F9
+#define SIERRA_TAU_EN_CEPH2TO0_PREG			0x0FB
+#define SIERRA_TAU_EN_CEPH5TO3_PREG			0x0FC
 #define SIERRA_DEQ_ALUT0				0x108
 #define SIERRA_DEQ_ALUT1				0x109
 #define SIERRA_DEQ_ALUT2				0x10A
@@ -143,6 +160,7 @@
 #define SIERRA_DEQ_ALUT11				0x113
 #define SIERRA_DEQ_ALUT12				0x114
 #define SIERRA_DEQ_ALUT13				0x115
+#define SIERRA_OEPH_EN_CTRL_PREG			0x124
 #define SIERRA_DEQ_DFETAP_CTRL_PREG			0x128
 #define SIERRA_DEQ_DFETAP0				0x129
 #define SIERRA_DEQ_DFETAP1				0x12B
@@ -157,6 +175,7 @@
 #define SIERRA_DEQ_TAU_CTRL2_PREG			0x151
 #define SIERRA_DEQ_TAU_CTRL3_PREG			0x152
 #define SIERRA_DEQ_OPENEYE_CTRL_PREG			0x158
+#define SIERRA_DEQ_CONCUR_EPIOFFSET_MODE_PREG		0x159
 #define SIERRA_DEQ_PICTRL_PREG				0x161
 #define SIERRA_CPICAL_TMRVAL_MODE1_PREG			0x170
 #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
@@ -165,6 +184,7 @@
 #define SIERRA_CPI_RESBIAS_BIN_PREG			0x17E
 #define SIERRA_CPI_TRIM_PREG				0x17F
 #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
+#define SIERRA_CPICAL_RES_STARTCODE_MODE01_PREG		0x184
 #define SIERRA_EPI_CTRL_PREG				0x187
 #define SIERRA_LFPSDET_SUPPORT_PREG			0x188
 #define SIERRA_LFPSFILT_NS_PREG				0x18A
@@ -176,6 +196,7 @@
 #define SIERRA_RXBUFFER_CTLECTRL_PREG			0x19E
 #define SIERRA_RXBUFFER_RCDFECTRL_PREG			0x19F
 #define SIERRA_RXBUFFER_DFECTRL_PREG			0x1A0
+#define SIERRA_LN_SPARE_REG_PREG			0x1B0
 #define SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG		0x14F
 #define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150

@@ -2401,6 +2422,77 @@ static struct cdns_sierra_vals usb_100_ext_ssc_ln_vals = {
 	.num_regs = ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
 };

+/* SGMII PHY common configuration */
+static const struct cdns_reg_pairs sgmii_pma_cmn_vals[] = {
+	{0x0180, SIERRA_SDOSCCAL_CLK_CNT_PREG},
+	{0x6000, SIERRA_CMN_REFRCV_PREG},
+	{0x0031, SIERRA_CMN_RESCAL_CTRLA_PREG},
+	{0x001C, SIERRA_CMN_PLLLC_FBDIV_INT_MODE0_PREG},
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_LOCKSEARCH_PREG},
+	{0x8103, SIERRA_CMN_PLLLC_CLK0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x0027, SIERRA_CMN_PLLCSM_PLLEN_TMR_PREG},
+	{0x0062, SIERRA_CMN_PLLCSM_PLLPRE_TMR_PREG},
+	{0x0800, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_INIT_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_ITERTMR_PREG},
+	{0x0020, SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG},
+	{0x0013, SIERRA_CMN_PLLLC_DCOCAL_CTRL_PREG},
+	{0x0013, SIERRA_CMN_PLLLC1_DCOCAL_CTRL_PREG},
+};
+
+static struct cdns_sierra_vals sgmii_cmn_vals = {
+	.reg_pairs = sgmii_pma_cmn_vals,
+	.num_regs = ARRAY_SIZE(sgmii_pma_cmn_vals),
+};
+
+/* SGMII PHY lane configuration */
+static const struct cdns_reg_pairs sgmii_ln_regs[] = {
+	{0x691E, SIERRA_DET_STANDEC_D_PREG},
+	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
+	{0x0104, SIERRA_PLLCTRL_FBDIV_MODE01_PREG},
+	{0x0013, SIERRA_PLLCTRL_SUBRATE_PREG},
+	{0x0106, SIERRA_PLLCTRL_GEN_D_PREG},
+	{0x5234, SIERRA_PLLCTRL_CPGAIN_MODE_PREG},
+	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
+	{0x00AB, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x3C0E, SIERRA_CREQ_CCLKDET_MODE01_PREG},
+	{0x3220, SIERRA_CREQ_FSMCLK_SEL_PREG},
+	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
+	{0x6320, SIERRA_DEQ_CONCUR_EPIOFFSET_MODE_PREG},
+	{0x0000, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x15A2, SIERRA_LN_SPARE_REG_PREG},
+	{0x7900, SIERRA_DEQ_BLK_TAU_CTRL1_PREG},
+	{0x2202, SIERRA_DEQ_BLK_TAU_CTRL4_PREG},
+	{0x2206, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0005, SIERRA_LANE_TX_RECEIVER_DETECT_PREG},
+	{0x8001, SIERRA_CREQ_SPARE_PREG},
+	{0x0000, SIERRA_DEQ_CONCUR_CTRL1_PREG},
+	{0xD004, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x0101, SIERRA_DEQ_GLUT9},
+	{0x0101, SIERRA_DEQ_GLUT10},
+	{0x0101, SIERRA_DEQ_GLUT11},
+	{0x0101, SIERRA_DEQ_GLUT12},
+	{0x0000, SIERRA_DEQ_GLUT13},
+	{0x0000, SIERRA_DEQ_GLUT16},
+	{0x0000, SIERRA_POSTPRECUR_EN_CEPH_CTRL_PREG},
+	{0x0000, SIERRA_TAU_EN_CEPH2TO0_PREG},
+	{0x0003, SIERRA_TAU_EN_CEPH5TO3_PREG},
+	{0x0101, SIERRA_DEQ_ALUT8},
+	{0x0101, SIERRA_DEQ_ALUT9},
+	{0x0100, SIERRA_DEQ_ALUT10},
+	{0x0000, SIERRA_OEPH_EN_CTRL_PREG},
+	{0x5425, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x7458, SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG},
+	{0x321F, SIERRA_CPICAL_RES_STARTCODE_MODE01_PREG},
+};
+
+static struct cdns_sierra_vals sgmii_pma_ln_vals = {
+	.reg_pairs = sgmii_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_ln_regs),
+};
+
 static const struct cdns_sierra_data cdns_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x2,
@@ -2461,6 +2553,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_cmn_vals,
+			},
+		},
 	},
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
@@ -2499,6 +2596,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_pma_ln_vals,
+			},
+		},
 	},
 };

--
2.28.0

