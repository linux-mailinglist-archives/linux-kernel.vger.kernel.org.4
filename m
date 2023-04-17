Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052926E4FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDQSEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjDQSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:03:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11056728D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754637; x=1713290637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzrZ7Z7YiYIaFp4WsXi8lfyg6YwsVetQDS6QQOYXX/4=;
  b=bluhDxYLMi64BA280NWmJv5FwbBRZB0YBwLx5WiGoLJnlrhwRk655Uix
   19g6wI0wTEq1q59Y+f/nBZIjVieE1KkKm33vX9DELFko8AAdIuzqpfPkj
   1k86lVA1HQBXEhRvnDollDNKJ7FLz43L4JGOaokhzI6MeLFAODhzKmqOE
   dZ6h0Y+pn9lpsjHY57E7My522wbAcRfyWrWZL7o8gEIKaP5GpyFY67/kz
   86eDaDSm+R47LtGpxhsJnGocei7yaWTY+2iyPSxYlpCiWZk++52FvLEE5
   GBVCRW9vPWCrxkrUXZCgi+bByajtbNm+irm9cBOuPnmKqSmpBqST2XpiT
   A==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="206900840"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:44 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:42 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] phy: sparx5-serdes: add registers required for SD/CMU power down
Date:   Mon, 17 Apr 2023 20:03:29 +0200
Message-ID: <20230417180335.2787494-2-daniel.machon@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417180335.2787494-1-daniel.machon@microchip.com>
References: <20230417180335.2787494-1-daniel.machon@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add registers required to configure serdeses and CMUs for initial power
down.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes_regs.h | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/phy/microchip/sparx5_serdes_regs.h b/drivers/phy/microchip/sparx5_serdes_regs.h
index b96386a4df5a..d0543fd3dc94 100644
--- a/drivers/phy/microchip/sparx5_serdes_regs.h
+++ b/drivers/phy/microchip/sparx5_serdes_regs.h
@@ -2149,6 +2149,92 @@ enum sparx5_serdes_target {
 #define SD_CMU_CMU_05_CFG_BIAS_TP_SEL_1_0_GET(x)\
 	FIELD_GET(SD_CMU_CMU_05_CFG_BIAS_TP_SEL_1_0, x)
 
+/*      SD10G_CMU_TARGET:CMU_GRP_1:CMU_06 */
+#define SD_CMU_CMU_06(t) \
+	__REG(TARGET_SD_CMU, t, 14, 20, 0, 1, 72, 4, 0, 1, 4)
+
+#define SD_CMU_CMU_06_CFG_DISLOS                 BIT(0)
+#define SD_CMU_CMU_06_CFG_DISLOS_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_DISLOS, x)
+#define SD_CMU_CMU_06_CFG_DISLOS_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_DISLOS, x)
+
+#define SD_CMU_CMU_06_CFG_DISLOL                 BIT(1)
+#define SD_CMU_CMU_06_CFG_DISLOL_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_DISLOL, x)
+#define SD_CMU_CMU_06_CFG_DISLOL_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_DISLOL, x)
+
+#define SD_CMU_CMU_06_CFG_DCLOL                  BIT(2)
+#define SD_CMU_CMU_06_CFG_DCLOL_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_DCLOL, x)
+#define SD_CMU_CMU_06_CFG_DCLOL_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_DCLOL, x)
+
+#define SD_CMU_CMU_06_CFG_FORCE_RX_FILT          BIT(3)
+#define SD_CMU_CMU_06_CFG_FORCE_RX_FILT_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_FORCE_RX_FILT, x)
+#define SD_CMU_CMU_06_CFG_FORCE_RX_FILT_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_FORCE_RX_FILT, x)
+
+#define SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD          BIT(4)
+#define SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD, x)
+#define SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD, x)
+
+#define SD_CMU_CMU_06_CFG_VCO_PD                 BIT(5)
+#define SD_CMU_CMU_06_CFG_VCO_PD_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_VCO_PD, x)
+#define SD_CMU_CMU_06_CFG_VCO_PD_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_VCO_PD, x)
+
+#define SD_CMU_CMU_06_CFG_VCO_CAL_RESETN         BIT(6)
+#define SD_CMU_CMU_06_CFG_VCO_CAL_RESETN_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_VCO_CAL_RESETN, x)
+#define SD_CMU_CMU_06_CFG_VCO_CAL_RESETN_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_VCO_CAL_RESETN, x)
+
+#define SD_CMU_CMU_06_CFG_VCO_CAL_BYP            BIT(7)
+#define SD_CMU_CMU_06_CFG_VCO_CAL_BYP_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_06_CFG_VCO_CAL_BYP, x)
+#define SD_CMU_CMU_06_CFG_VCO_CAL_BYP_GET(x)\
+	FIELD_GET(SD_CMU_CMU_06_CFG_VCO_CAL_BYP, x)
+
+/*      SD10G_CMU_TARGET:CMU_GRP_1:CMU_08 */
+#define SD_CMU_CMU_08(t) \
+	__REG(TARGET_SD_CMU, t, 14, 20, 0, 1, 72, 12, 0, 1, 4)
+
+#define SD_CMU_CMU_08_CFG_VFILT2PAD              BIT(0)
+#define SD_CMU_CMU_08_CFG_VFILT2PAD_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_08_CFG_VFILT2PAD, x)
+#define SD_CMU_CMU_08_CFG_VFILT2PAD_GET(x)\
+	FIELD_GET(SD_CMU_CMU_08_CFG_VFILT2PAD, x)
+
+#define SD_CMU_CMU_08_CFG_EN_DUMMY               BIT(1)
+#define SD_CMU_CMU_08_CFG_EN_DUMMY_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_08_CFG_EN_DUMMY, x)
+#define SD_CMU_CMU_08_CFG_EN_DUMMY_GET(x)\
+	FIELD_GET(SD_CMU_CMU_08_CFG_EN_DUMMY, x)
+
+#define SD_CMU_CMU_08_CFG_CK_TREE_PD             BIT(2)
+#define SD_CMU_CMU_08_CFG_CK_TREE_PD_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_08_CFG_CK_TREE_PD, x)
+#define SD_CMU_CMU_08_CFG_CK_TREE_PD_GET(x)\
+	FIELD_GET(SD_CMU_CMU_08_CFG_CK_TREE_PD, x)
+
+#define SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN        BIT(3)
+#define SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN, x)
+#define SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_GET(x)\
+	FIELD_GET(SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN, x)
+
+#define SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_EN     BIT(4)
+#define SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_EN_SET(x)\
+	FIELD_PREP(SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_EN, x)
+#define SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_EN_GET(x)\
+	FIELD_GET(SD_CMU_CMU_08_CFG_RST_TREE_PD_MAN_EN, x)
+
 /*      SD10G_CMU_TARGET:CMU_GRP_1:CMU_09 */
 #define SD_CMU_CMU_09(t)          __REG(TARGET_SD_CMU, t, 14, 20, 0, 1, 72, 16, 0, 1, 4)
 
@@ -2443,6 +2529,16 @@ enum sparx5_serdes_target {
 #define SD_LANE_SD_LANE_STAT_DBG_OBS_GET(x)\
 	FIELD_GET(SD_LANE_SD_LANE_STAT_DBG_OBS, x)
 
+/*      SD_LANE_TARGET:SD_PWR_CFG:QUIET_MODE_6G */
+#define SD_LANE_QUIET_MODE_6G(t) \
+	__REG(TARGET_SD_LANE, t, 25, 24, 0, 1, 8, 4, 0, 1, 4)
+
+#define SD_LANE_QUIET_MODE_6G_QUIET_MODE         GENMASK(24, 0)
+#define SD_LANE_QUIET_MODE_6G_QUIET_MODE_SET(x)\
+	FIELD_PREP(SD_LANE_QUIET_MODE_6G_QUIET_MODE, x)
+#define SD_LANE_QUIET_MODE_6G_QUIET_MODE_GET(x)\
+	FIELD_GET(SD_LANE_QUIET_MODE_6G_QUIET_MODE, x)
+
 /*      SD_LANE_TARGET:CFG_STAT_FX100:MISC */
 #define SD_LANE_MISC(t)           __REG(TARGET_SD_LANE, t, 25, 56, 0, 1, 56, 0, 0, 1, 4)
 
@@ -2692,4 +2788,14 @@ enum sparx5_serdes_target {
 #define SD_LANE_25G_SD_LANE_STAT_DBG_OBS_GET(x)\
 	FIELD_GET(SD_LANE_25G_SD_LANE_STAT_DBG_OBS, x)
 
+/*      SD25G_CFG_TARGET:SD_PWR_CFG:QUIET_MODE_6G */
+#define SD_LANE_25G_QUIET_MODE_6G(t) \
+	__REG(TARGET_SD_LANE_25G, t, 8, 28, 0, 1, 8, 4, 0, 1, 4)
+
+#define SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE     GENMASK(24, 0)
+#define SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE_SET(x)\
+	FIELD_PREP(SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE, x)
+#define SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE_GET(x)\
+	FIELD_GET(SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE, x)
+
 #endif /* _SPARX5_SERDES_REGS_H_ */
-- 
2.34.1

