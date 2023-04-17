Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0EC6E4FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDQSDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjDQSDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:03:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B355BE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754626; x=1713290626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWQh9zj/V577BO9z6BgacIjliHqRr9/mCbIBPB/bemc=;
  b=Q5gTHLuw6MuF/WZGkGOAZ+RocCVc0N9r5thkidfKV08dJnBrMp2Y468x
   WTtM9SwjBbL2933oyVpc6pKiTDNZwT3dDlJ+VK0sbc1X6kBPIjdJU81v1
   +jv4jitgzMLGtnDWgYmUzQ+Pf9LS86xwQTaPdUHXsKa/zW8cCafx6NIth
   jvgpJA+T1RC9BiDunKqZFFgBgm90F98cnBBe2VcCbaBtKbcDEwu85UGGr
   l2VzVggrU+Re5993eAEe6x3sDeaICRtcR+YLbRJC3c0S/V73inXm0f6Zr
   hM2n+fL3tOg6reKvhXIgslHORX7YpwdQRog0JlIoIOd0d54Ead3a+A7WK
   g==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="221268900"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:46 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:44 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] phy: sparx5-serdes: configure optimal quiet mode for serdes lanes
Date:   Mon, 17 Apr 2023 20:03:30 +0200
Message-ID: <20230417180335.2787494-3-daniel.machon@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417180335.2787494-1-daniel.machon@microchip.com>
References: <20230417180335.2787494-1-daniel.machon@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the serdes lanes of the sparx5 will transition between normal mode
and quiet mode, depending on activity. Make sure that the quiet mode is
configured optimally for all lanes initially. Although not much, this
will save a small amount of power.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 32 ++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index ab1b0986aa67..6ba058b2482f 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -26,6 +26,9 @@
 #define SPX5_SERDES_10G_START 13
 #define SPX5_SERDES_25G_START 25
 
+/* Optimal power settings from GUC */
+#define SPX5_SERDES_QUIET_MODE_VAL 0x01ef4e0c
+
 enum sparx5_10g28cmu_mode {
 	SPX5_SD10G28_CMU_MAIN = 0,
 	SPX5_SD10G28_CMU_AUX1 = 1,
@@ -1899,7 +1902,7 @@ static int sparx5_sd10g28_config(struct sparx5_serdes_macro *macro, bool reset)
 static int sparx5_serdes_power_save(struct sparx5_serdes_macro *macro, u32 pwdn)
 {
 	struct sparx5_serdes_private *priv = macro->priv;
-	void __iomem *sd_inst;
+	void __iomem *sd_inst, *sd_lane_inst;
 
 	if (macro->serdestype == SPX5_SDT_6G)
 		sd_inst = sdx5_inst_get(priv, TARGET_SD6G_LANE, macro->stpidx);
@@ -1909,12 +1912,36 @@ static int sparx5_serdes_power_save(struct sparx5_serdes_macro *macro, u32 pwdn)
 		sd_inst = sdx5_inst_get(priv, TARGET_SD25G_LANE, macro->stpidx);
 
 	if (macro->serdestype == SPX5_SDT_25G) {
+		sd_lane_inst = sdx5_inst_get(priv, TARGET_SD_LANE_25G,
+					     macro->stpidx);
+		/* Take serdes out of reset */
+		sdx5_inst_rmw(SD_LANE_25G_SD_LANE_CFG_EXT_CFG_RST_SET(0),
+			      SD_LANE_25G_SD_LANE_CFG_EXT_CFG_RST, sd_lane_inst,
+			      SD_LANE_25G_SD_LANE_CFG(0));
+
+		/* Configure optimal settings for quiet mode */
+		sdx5_inst_rmw(SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE_SET(SPX5_SERDES_QUIET_MODE_VAL),
+			      SD_LANE_25G_QUIET_MODE_6G_QUIET_MODE,
+			      sd_lane_inst, SD_LANE_25G_QUIET_MODE_6G(0));
+
 		sdx5_inst_rmw(SD25G_LANE_LANE_04_LN_CFG_PD_DRIVER_SET(pwdn),
 			      SD25G_LANE_LANE_04_LN_CFG_PD_DRIVER,
 			      sd_inst,
 			      SD25G_LANE_LANE_04(0));
 	} else {
 		/* 6G and 10G */
+		sd_lane_inst = sdx5_inst_get(priv, TARGET_SD_LANE, macro->sidx);
+
+		/* Take serdes out of reset */
+		sdx5_inst_rmw(SD_LANE_SD_LANE_CFG_EXT_CFG_RST_SET(0),
+			      SD_LANE_SD_LANE_CFG_EXT_CFG_RST, sd_lane_inst,
+			      SD_LANE_SD_LANE_CFG(0));
+
+		/* Configure optimal settings for quiet mode */
+		sdx5_inst_rmw(SD_LANE_QUIET_MODE_6G_QUIET_MODE_SET(SPX5_SERDES_QUIET_MODE_VAL),
+			      SD_LANE_QUIET_MODE_6G_QUIET_MODE, sd_lane_inst,
+			      SD_LANE_QUIET_MODE_6G(0));
+
 		sdx5_inst_rmw(SD10G_LANE_LANE_06_CFG_PD_DRIVER_SET(pwdn),
 			      SD10G_LANE_LANE_06_CFG_PD_DRIVER,
 			      sd_inst,
@@ -2308,6 +2335,9 @@ static int sparx5_phy_create(struct sparx5_serdes_private *priv,
 
 	phy_set_drvdata(*phy, macro);
 
+	/* Power off serdes by default */
+	sparx5_serdes_power_off(*phy);
+
 	return 0;
 }
 
-- 
2.34.1

