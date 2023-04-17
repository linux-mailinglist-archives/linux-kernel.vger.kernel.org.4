Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB26E4FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDQSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDQSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:04:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C16A79
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754641; x=1713290641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+uQ6AuSXVO9NTO3vnNTGE3OcG8q0cmFmyPP7RNm0jA=;
  b=RjDtbVGyJWYkzmReb8smiv3M9xyrOQfm2IY4/EyZLubPokbApsjVNi9k
   Q6ZUzvwUQfHrqMpqhm99NWsmGFvWZeova2OZq4GxT0VWL3SJ0AITxWspo
   6iMy6zdC66Z+lnG0/XU8TZpMQz0UPzS0stTcpEHEC2MTsyG1QkpcZyUoO
   pVU972NQV8TIyY+Xj5d8OmXQdPAy/+Jf+JINPRFHCYyokQEgWRXvQl7oE
   eGLJoI7epWFkFa1cxuL3CmzXPm2idEBvylSGU10TKeJPHNWjyJYd4f2Nj
   Dp5dOo87VoycDRrXPSg/o4JVcKCkT+AtdAN4rOLsXR8NvvGaBlrr/J9/f
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="147469783"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:54 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:52 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] phy: sparx5-serdes: remove power up of all CMUs
Date:   Mon, 17 Apr 2023 20:03:34 +0200
Message-ID: <20230417180335.2787494-7-daniel.machon@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417180335.2787494-1-daniel.machon@microchip.com>
References: <20230417180335.2787494-1-daniel.machon@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMUs should not be powered up by default anymore, so remove responsible
code.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 25 -------------------------
 drivers/phy/microchip/sparx5_serdes.h |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index a6638d783a01..eb9352d1de7e 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -1062,24 +1062,6 @@ static int sparx5_cmu_cfg(struct sparx5_serdes_private *priv, u32 cmu_idx)
 	return sparx5_cmu_apply_cfg(priv, cmu_idx, cmu_tgt, cmu_cfg_tgt, spd10g);
 }
 
-static int sparx5_serdes_cmu_enable(struct sparx5_serdes_private *priv)
-{
-	int idx, err = 0;
-
-	if (!priv->cmu_enabled) {
-		for (idx = 0; idx < SPX5_CMU_MAX; idx++) {
-			err  = sparx5_cmu_cfg(priv, idx);
-			if (err) {
-				dev_err(priv->dev, "CMU %u, error: %d\n", idx, err);
-				goto leave;
-			}
-		}
-		priv->cmu_enabled = true;
-	}
-leave:
-	return err;
-}
-
 /* Map of 6G/10G serdes mode and index to CMU index. */
 static const int
 sparx5_serdes_cmu_map[SPX5_SD10G28_CMU_MAX][SPX5_SERDES_6G10G_CNT] = {
@@ -2236,10 +2218,6 @@ static int sparx5_serdes_config(struct sparx5_serdes_macro *macro)
 	int serdesmode;
 	int err;
 
-	err = sparx5_serdes_cmu_enable(macro->priv);
-	if (err)
-		return err;
-
 	serdesmode = sparx5_serdes_get_serdesmode(macro->portmode, macro->speed);
 	if (serdesmode < 0) {
 		dev_err(dev, "SerDes %u, interface not supported: %s\n",
@@ -2331,9 +2309,6 @@ static int sparx5_serdes_reset(struct phy *phy)
 	struct sparx5_serdes_macro *macro = phy_get_drvdata(phy);
 	int err;
 
-	err = sparx5_serdes_cmu_enable(macro->priv);
-	if (err)
-		return err;
 	if (macro->serdestype == SPX5_SDT_25G)
 		err = sparx5_sd25g28_config(macro, true);
 	else
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 0a3e496e6210..13f94a29225a 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -30,7 +30,6 @@ struct sparx5_serdes_private {
 	struct device *dev;
 	void __iomem *regs[NUM_TARGETS];
 	struct phy *phys[SPX5_SERDES_MAX];
-	bool cmu_enabled;
 	unsigned long coreclock;
 };
 
-- 
2.34.1

