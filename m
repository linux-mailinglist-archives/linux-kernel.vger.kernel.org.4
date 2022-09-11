Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E455B4C82
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIKHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIKHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 03:24:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ABE28705;
        Sun, 11 Sep 2022 00:24:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b23so5694951pfp.9;
        Sun, 11 Sep 2022 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2i+JzSc+5pljUj/heQMd8hyMP8Ji7Xs9ZUu2HyhldaQ=;
        b=qCSHZoPS3a2dRFFrK42xLC7t27D/Nvq4de/wuMUj0+QonR7RlJ0R+mXrdFcc071BH2
         ldjDwmubt29ZCKytFXnMPhXgjvWZBsrDnLomJml7v+R+QZmv5MixE5FD7H/MkUrfwDjS
         PODd9Dl1uTaysGKaRX5EsbAVbfjpC3yA4azfqhEhLy9x9zaPprSwp84pkUYT/FWXM2pK
         bkqdlF40iu4VGjM4hNp8mI/Ltou2hFdH0/A8gfuwwucJ3CJDaEcw1MvaA6RmTbXnSmGg
         kx+qMgnIINyYJURzUu51gRI6hndCOD5IVgjINu/qsftTTAeyMqKn6sdSMquD6P8xbDet
         Y1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2i+JzSc+5pljUj/heQMd8hyMP8Ji7Xs9ZUu2HyhldaQ=;
        b=10cyWhK7oTknB1LJmO/OJZJ+tZtFwpxuOTdj5WSwWE/xp34t/GpGnRI9BgRwJF+Dv/
         7mP02gVJVBn8J/Pg3sAESwHSxmHik5mrefNz18RyLbRTZ9e/RWqPmNJEl3y1S6f2S3pd
         4pvr3VulFRTkUxZBhIG3KVwEqnJexQ4zeIW5jGk1kK6G7DdS5lqKb+20FdpjDWDW1mYQ
         ogXyO1Xv3/IIQ6MYkxe/yv9x9gEMo/va8EC8eiTaPRpk/hFTlus4jRNSHscqdmrhU8um
         mL9OU4g3O84ORipw7+sA4JkETNJBr5XScnxh59e5IrXyu9AkuXkkrHwdhS1nSMVNloEK
         zlHQ==
X-Gm-Message-State: ACgBeo0qTLlpNywWV62mgfJv7yug5L+MXY0I5Oym6OahD2R//sRUzTom
        7vO96shE6CC6rwAYTDSk3b4SX/HZdLoJpkw+
X-Google-Smtp-Source: AA6agR66WV5VtLDLdwNGmvtp7drjUWpkQG++Z2PwMahj2CxB2vyDxF3icHo3y/2CdugqmaNpNtlsWQ==
X-Received: by 2002:a05:6a00:1909:b0:536:65dd:44ca with SMTP id y9-20020a056a00190900b0053665dd44camr22564434pfi.1.1662881065024;
        Sun, 11 Sep 2022 00:24:25 -0700 (PDT)
Received: from kelvin-System-Product-Name.lan ([117.173.227.137])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090a734c00b002004760a66csm3020498pjs.13.2022.09.11.00.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 00:24:24 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson32: Fix PHY-mode being left unspecified
Date:   Sun, 11 Sep 2022 15:22:51 +0800
Message-Id: <20220911072251.25024-1-keguang.zhang@gmail.com>
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
Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
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

