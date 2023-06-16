Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08987732B98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbjFPJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbjFPJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFFEA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AB4D6229E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF97EC433CA;
        Fri, 16 Jun 2023 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907817;
        bh=0LCiNW47vz9emKUNT6ghLeNK5ZkmMsQ8k9618ObBVAY=;
        h=From:To:Cc:Subject:Date:From;
        b=RFV0xw4rvVEg653MXihwltNfQZDxkpwhr2f/xjdVLCt8vLzv0j2Kx7BJQZBcCMew8
         jpi1fc4WiXoZMdDVhDV2ZA6zF2ybZxYKtrWyRnOYuG11gj8ojIUoul6c+BaIcDN5ed
         2CSLn8KDPvgytauycmr4EiD7bUB4gxFYyvc02Yij5ROssojdhQh0tReT+o0Cu8gV6Z
         7xOLWD64XznEkiOolp5NfjxqQ6PgaLIGR+/hIzc6TLd/k3rQ5G7+lCYBrfX/AFcKbj
         AhqtzTzv1a+pwziGilkVzyk+WQN9knrCIUdprSrdstxLQX4EoW8LZWf7GJV5gRfKih
         STgq8ZDc0xN5A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        Frank Sae <Frank.Sae@motor-comm.com>,
        Michael Walle <michael@walle.cc>,
        Daniel Golle <daniel@makrotopia.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] net: phy: mediatek: fix compile-test dependencies
Date:   Fri, 16 Jun 2023 11:29:54 +0200
Message-Id: <20230616093009.3511692-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new phy driver attempts to select a driver from another subsystem,
but that fails when the NVMEM subsystem is disabled:

WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE
  Depends on [n]: NVMEM [=n] && (ARCH_MEDIATEK [=n] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
  Selected by [y]:
  - MEDIATEK_GE_SOC_PHY [=y] && NETDEVICES [=y] && PHYLIB [=y] && (ARM64 && ARCH_MEDIATEK [=n] || COMPILE_TEST [=y])

I could not see an actual compile time dependency, so presumably this
is only needed for for working correctly but not technically a dependency
on that particular nvmem driver implementation, so it would likely
be safe to remove the select for compile testing.

To keep the spirit of the original 'select', just replace this with a
'depends on' that ensures that the driver will work but does not get in
the way of build testing.

Fixes: 98c485eaf509b ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a40269c175974..78e6981650d94 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -239,7 +239,7 @@ config MEDIATEK_GE_PHY
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
-	select NVMEM_MTK_EFUSE
+	depends on NVMEM_MTK_EFUSE
 	help
 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
 
-- 
2.39.2

