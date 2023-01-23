Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3C677D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjAWNva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAWNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:51:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF1422F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:51:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e3so10851407wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/aPgVYxytvHxJllto1N4mW/e7BZnp3Uj+u6VxCc02s=;
        b=pnUkWpGE8BU1Q/ZnWNSy8A1mAVzk+vB6belwCcQ6B3j2xskVbgg7rpB5MpSX2SvCod
         hjJZoCIBz6pNKwMd/S23aQh0SZm7CmwLVYWvz4VvtrflwdI1VXMsl+ipBvlXgIkfxvdw
         FqtyjR6NeU8usGBc7JIuBatSjTiyxuZ4xt85B7jdU+Bp16JDPY1WTnoMoj1qOxP0LcXd
         AD8f6IYPWsO4/HPjUdV+u4djT89UWS+8+B6w8aIot0x8uJfN8unsaLVpqT0Ry+Cml5Lb
         Wm/uO+BAOF7QLUrrRBRPT1lrV4zgIBErh6WT/dvdtHActXqkSXNFOIwa0U/2KOjfoMfH
         bH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/aPgVYxytvHxJllto1N4mW/e7BZnp3Uj+u6VxCc02s=;
        b=celxskz5g5Wr5AtydIYbtDrCS2VQUur5HGa8sXKyMUKV0aSsiWWR9eM3CPKcXTtlRb
         SdVUUjlcay4ZZttLTVn9cCN3oPHkZ3hCF2A3hJKEukwknWB+6dbczWllpbQi6EgzqXB/
         YJL5NZf/7reMMwS483ai/cdXjOaqklH89De+gHANKut+JeG4APbZ5JJy2HimbK8X826N
         816x1ufmHtcK0c+zE3VXHwoUiexWutiNnPUgAuFVeno6dVCvUSBHw+poHHr/0YIjHpc6
         0qAYbmUmqdX6zV+tfX0K+WUpbipvsC/6XrPvEY9bqv0i8ee+q7Py99hJVBcbFR/p/xQC
         kSoA==
X-Gm-Message-State: AFqh2krEmZamktJhe9mvqLwT2/4ihOrtb6tlM+fTg2CWZJKJLP1lJngP
        fSzzqHnVgteF+trjlMNpMmG9hg==
X-Google-Smtp-Source: AMrXdXu8LYL65Syg8VeA91+RRN/vtoihzlCknkCIPZF3kK+2V4F+Fo/u29x7IHbFhomd/NYSoXD74w==
X-Received: by 2002:adf:fc4c:0:b0:2bd:dbbb:e7e2 with SMTP id e12-20020adffc4c000000b002bddbbbe7e2mr20364277wrs.60.1674481885872;
        Mon, 23 Jan 2023 05:51:25 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z12-20020adfd0cc000000b002bdff778d87sm19412230wrh.34.2023.01.23.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:51:25 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Qi Duan <qi.duan@amlogic.com>
Subject: [PATCH net] net: mdio-mux-meson-g12a: force internal PHY off on mux switch
Date:   Mon, 23 Jan 2023 14:50:37 +0100
Message-Id: <20230123135037.195157-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force the internal PHY off then on when switching to the internal path.
This fixes problems where the PHY ID is not properly set.

Fixes: 7090425104db ("net: phy: add amlogic g12a mdio mux support")
Suggested-by: Qi Duan <qi.duan@amlogic.com>
Co-developed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

The initial discussion about this change can be found here:
https://lore.kernel.org/all/1j4jslwen5.fsf@starbuckisacylon.baylibre.com/

 drivers/net/mdio/mdio-mux-meson-g12a.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-g12a.c b/drivers/net/mdio/mdio-mux-meson-g12a.c
index 4a2e94faf57e..da61f00a6666 100644
--- a/drivers/net/mdio/mdio-mux-meson-g12a.c
+++ b/drivers/net/mdio/mdio-mux-meson-g12a.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
@@ -151,6 +152,7 @@ static const struct clk_ops g12a_ephy_pll_ops = {
 static int g12a_enable_internal_mdio(struct g12a_mdio_mux *priv)
 {
 	int ret;
+	u32 value;
 
 	/* Enable the phy clock */
 	if (!priv->pll_is_enabled) {
@@ -163,18 +165,25 @@ static int g12a_enable_internal_mdio(struct g12a_mdio_mux *priv)
 
 	/* Initialize ephy control */
 	writel(EPHY_G12A_ID, priv->regs + ETH_PHY_CNTL0);
-	writel(FIELD_PREP(PHY_CNTL1_ST_MODE, 3) |
-	       FIELD_PREP(PHY_CNTL1_ST_PHYADD, EPHY_DFLT_ADD) |
-	       FIELD_PREP(PHY_CNTL1_MII_MODE, EPHY_MODE_RMII) |
-	       PHY_CNTL1_CLK_EN |
-	       PHY_CNTL1_CLKFREQ |
-	       PHY_CNTL1_PHY_ENB,
-	       priv->regs + ETH_PHY_CNTL1);
+
+	/* Make sure we get a 0 -> 1 transition on the enable bit */
+	value = FIELD_PREP(PHY_CNTL1_ST_MODE, 3) |
+		FIELD_PREP(PHY_CNTL1_ST_PHYADD, EPHY_DFLT_ADD) |
+		FIELD_PREP(PHY_CNTL1_MII_MODE, EPHY_MODE_RMII) |
+		PHY_CNTL1_CLK_EN |
+		PHY_CNTL1_CLKFREQ;
+	writel(value, priv->regs + ETH_PHY_CNTL1);
 	writel(PHY_CNTL2_USE_INTERNAL |
 	       PHY_CNTL2_SMI_SRC_MAC |
 	       PHY_CNTL2_RX_CLK_EPHY,
 	       priv->regs + ETH_PHY_CNTL2);
 
+	value |= PHY_CNTL1_PHY_ENB;
+	writel(value, priv->regs + ETH_PHY_CNTL1);
+
+	/* The phy needs a bit of time to power up */
+	mdelay(10);
+
 	return 0;
 }
 
-- 
2.39.0

