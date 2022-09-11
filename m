Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68EF5B4FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIKQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIKQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:10:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D6248ED;
        Sun, 11 Sep 2022 09:10:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b23so6372480pfp.9;
        Sun, 11 Sep 2022 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vtnejrobdg+Yx3W+F+QPYnhSFF4TlGo9EXWF/iIYvK4=;
        b=HVczGJpRiim/oprvQJHRinQXpKnNYlxFvw2ZaGCBCQt/UkB9OZdBWHAHOj2PBn0729
         aY61kjZoT5yHeF6ooQjm00nJZSgEuKO5Rf5DY+4dch7Fge9/Uid5h+B2+aG48sE6z+JK
         lsBuWAxiFn1TzhcM0jMq1xoLd9KB5O5XsOshir+bWwWpGl3241My0ArdY1HtomXI853w
         h76mTUW+TVOD8tlcW+ObqLwVLcN5CSbAO8+5kgHBya0YMg3GAPfSRivC21T8zLnf+P00
         U/Pz+JksNZCq1CdBr570zdnuFoPJvaimqjmVWgJPx/M1ob5z0M2IcPe9g/XK58mmuEpO
         dA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vtnejrobdg+Yx3W+F+QPYnhSFF4TlGo9EXWF/iIYvK4=;
        b=d2ssGhVm5Ud18LQFo+HJuJOVHh6tteP8ULwLmYhKlfOWFB1vVifKBqsiG+TitKFaE/
         /Stpbn3F1C9hBMeZksrKtAYa3+oVvv8+kwuLDT/e45M8RlpdUhu2Gde5s+FeEVhO0lJ2
         vhnLbunwi8xDf1YbEaCnLUNwGy5DVaFz56MnvTjF9LV1JKZaOeUK/LpMGArjcAasyTlH
         bhdDT2l1LA8N+S3fvu5TfpwuqdT5mae3ZIIHgNlf1i8gj8xRsOVCC2HQEDXovoFd+6mG
         gO7Tmw9HcS1DLc7gKxREgR+wmY43dbpXDpmqD2qRjLCfpEDE+u9Kie3xgIzJrmEMgGJQ
         MQPA==
X-Gm-Message-State: ACgBeo3MSbexHm1FP5zgXc8u47Q3ZJ8eTZSwl64rQyQLgKEmjxqyjeHG
        O4smlQnDdCzZE3hhEJjGhu3BM+tklpxdouN6
X-Google-Smtp-Source: AA6agR4fppLN3jll3RuQUQLAmcgKa1UGra2upnoBHUywsRdWew2D/DWl1ON6ka9/IvLrNleGLPgpoA==
X-Received: by 2002:aa7:8882:0:b0:53e:bc78:4f80 with SMTP id z2-20020aa78882000000b0053ebc784f80mr19398844pfe.69.1662912647412;
        Sun, 11 Sep 2022 09:10:47 -0700 (PDT)
Received: from kelvin-System-Product-Name.lan ([117.173.227.137])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b0053e78769470sm3486316pfr.88.2022.09.11.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:10:46 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2] MIPS: Loongson32: Fix PHY-mode being left unspecified
Date:   Mon, 12 Sep 2022 00:10:09 +0800
Message-Id: <20220911161009.34453-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

commit 0060c8783330 ("net: stmmac: implement support for passive mode
converters via dt") has changed the plat->interface field semantics from
containing the PHY-mode to specifying the MAC-PCS interface mode. Due to
that the loongson32 platform code will leave the phylink interface
uninitialized with the PHY-mode intended by the means of the actual
platform setup. The commit-author most likely has just missed the
arch-specific code to fix. Let's mend the Loongson32 platform code then by
assigning the PHY-mode to the phy_interface field of the STMMAC platform
data.

Fixes: 0060c8783330 ("net: stmmac: implement support for passive mode converters via dt")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Add my SoB tag
---
 arch/mips/loongson32/common/platform.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 794c96c2a4cd..311dc1580bbd 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -98,7 +98,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 	if (plat_dat->bus_id) {
 		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
 			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
-		switch (plat_dat->interface) {
+		switch (plat_dat->phy_interface) {
 		case PHY_INTERFACE_MODE_RGMII:
 			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
 			break;
@@ -107,12 +107,12 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 			break;
 		default:
 			pr_err("unsupported mii mode %d\n",
-			       plat_dat->interface);
+			       plat_dat->phy_interface);
 			return -ENOTSUPP;
 		}
 		val &= ~GMAC1_SHUT;
 	} else {
-		switch (plat_dat->interface) {
+		switch (plat_dat->phy_interface) {
 		case PHY_INTERFACE_MODE_RGMII:
 			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
 			break;
@@ -121,7 +121,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 			break;
 		default:
 			pr_err("unsupported mii mode %d\n",
-			       plat_dat->interface);
+			       plat_dat->phy_interface);
 			return -ENOTSUPP;
 		}
 		val &= ~GMAC0_SHUT;
@@ -131,7 +131,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
 	plat_dat = dev_get_platdata(&pdev->dev);
 
 	val &= ~PHY_INTF_SELI;
-	if (plat_dat->interface == PHY_INTERFACE_MODE_RMII)
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
 		val |= 0x4 << PHY_INTF_SELI_SHIFT;
 	__raw_writel(val, LS1X_MUX_CTRL1);
 
@@ -146,9 +146,9 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
 	.bus_id			= 0,
 	.phy_addr		= -1,
 #if defined(CONFIG_LOONGSON1_LS1B)
-	.interface		= PHY_INTERFACE_MODE_MII,
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
 #elif defined(CONFIG_LOONGSON1_LS1C)
-	.interface		= PHY_INTERFACE_MODE_RMII,
+	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 #endif
 	.mdio_bus_data		= &ls1x_mdio_bus_data,
 	.dma_cfg		= &ls1x_eth_dma_cfg,
@@ -186,7 +186,7 @@ struct platform_device ls1x_eth0_pdev = {
 static struct plat_stmmacenet_data ls1x_eth1_pdata = {
 	.bus_id			= 1,
 	.phy_addr		= -1,
-	.interface		= PHY_INTERFACE_MODE_MII,
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
 	.mdio_bus_data		= &ls1x_mdio_bus_data,
 	.dma_cfg		= &ls1x_eth_dma_cfg,
 	.has_gmac		= 1,

base-commit: 727488e305b223ca69205ca5a3b99ace21bbbf5f
-- 
2.34.1

