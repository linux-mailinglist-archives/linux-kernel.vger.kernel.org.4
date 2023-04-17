Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C06E4FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjDQSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDQSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:04:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA376A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754640; x=1713290640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWBx4BKoFDrQnCpgyAMwdPuAQ4nlRpG6oep6/zjdvDg=;
  b=SPMiTOv8lG6jPe0YVtkkhAuZBOSOjP+Ge2hwlgXaR5njPCBKVxk0S7WB
   Agdr8CXBBV47m+nneW0SGZ5LCIxkb1ZEZFZzAeCwGmyP8yatfwbKtOijp
   WJpXBwKxy6tb/z91HJk2MQBMIb9+msCUmB61CKwF8pA6EAr80PRqhHLH/
   Q9BNhmzPvvFCRk48okqSDdV0eYfwjxbZ0VCQLyr2rdh91yb4S4oE1LPyy
   HqT8vz8NRC/0FU0hEHXFrPxNQVUPd4LXpE2iqS6BgB7ZR7gJM7Pe6Q7YX
   dPAqjl25+nFsFtvCZLZUVeop6iwLlQ0hMU/52G8d13ZPK/JZnXgiPzQ05
   A==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="147469779"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:52 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:50 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] phy: sparx5-serdes: power on CMUs individually
Date:   Mon, 17 Apr 2023 20:03:33 +0200
Message-ID: <20230417180335.2787494-6-daniel.machon@microchip.com>
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

Power on the CMU instance, that provides the clock for the serdes, given the
specified serdes mode and index. The CMU instance is looked up, using a
preset map of serdes mode and index to CMU index.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 43 ++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 0e9db7b36b60..a6638d783a01 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -25,6 +25,7 @@
 
 #define SPX5_SERDES_10G_START 13
 #define SPX5_SERDES_25G_START 25
+#define SPX5_SERDES_6G10G_CNT SPX5_SERDES_25G_START
 
 /* Optimal power settings from GUC */
 #define SPX5_SERDES_QUIET_MODE_VAL 0x01ef4e0c
@@ -34,6 +35,7 @@ enum sparx5_10g28cmu_mode {
 	SPX5_SD10G28_CMU_AUX1 = 1,
 	SPX5_SD10G28_CMU_AUX2 = 3,
 	SPX5_SD10G28_CMU_NONE = 4,
+	SPX5_SD10G28_CMU_MAX,
 };
 
 enum sparx5_sd25g28_mode_preset_type {
@@ -1078,6 +1080,39 @@ static int sparx5_serdes_cmu_enable(struct sparx5_serdes_private *priv)
 	return err;
 }
 
+/* Map of 6G/10G serdes mode and index to CMU index. */
+static const int
+sparx5_serdes_cmu_map[SPX5_SD10G28_CMU_MAX][SPX5_SERDES_6G10G_CNT] = {
+	[SPX5_SD10G28_CMU_MAIN] = {  2,  2,  2,  2,  2,
+				     2,  2,  2,  5,  5,
+				     5,  5,  5,  5,  5,
+				     5,  8, 11, 11, 11,
+				    11, 11, 11, 11, 11 },
+	[SPX5_SD10G28_CMU_AUX1] = {  0,  0,  3,  3,  3,
+				     3,  3,  3,  3,  3,
+				     6,  6,  6,  6,  6,
+				     6,  6,  9,  9, 12,
+				    12, 12, 12, 12, 12 },
+	[SPX5_SD10G28_CMU_AUX2] = {  1,  1,  1,  1,  4,
+				     4,  4,  4,  4,  4,
+				     4,  4,  7,  7,  7,
+				     7,  7, 10, 10, 10,
+				    10, 13, 13, 13, 13 },
+	[SPX5_SD10G28_CMU_NONE] = {  1,  1,  1,  1,  4,
+				     4,  4,  4,  4,  4,
+				     4,  4,  7,  7,  7,
+				     7,  7, 10, 10, 10,
+				    10, 13, 13, 13, 13 },
+};
+
+/* Get the index of the CMU which provides the clock for the specified serdes
+ * mode and index.
+ */
+static int sparx5_serdes_cmu_get(enum sparx5_10g28cmu_mode mode, int sd_index)
+{
+	return sparx5_serdes_cmu_map[mode][sd_index];
+}
+
 static void sparx5_serdes_cmu_power_off(struct sparx5_serdes_private *priv)
 {
 	void __iomem *cmu_inst, *cmu_cfg_inst;
@@ -1626,7 +1661,13 @@ static int sparx5_sd10g28_apply_params(struct sparx5_serdes_macro *macro,
 	u32 lane_index = macro->sidx;
 	u32 sd_index = macro->stpidx;
 	void __iomem *sd_inst;
-	u32 value;
+	u32 value, cmu_idx;
+	int err;
+
+	cmu_idx = sparx5_serdes_cmu_get(params->cmu_sel, lane_index);
+	err = sparx5_cmu_cfg(priv, cmu_idx);
+	if (err)
+		return err;
 
 	if (params->is_6g)
 		sd_inst = sdx5_inst_get(priv, TARGET_SD6G_LANE, sd_index);
-- 
2.34.1

