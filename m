Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6E714FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE2Tdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2Tdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:33:46 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE56B7;
        Mon, 29 May 2023 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=LyKdt7bIuSLgYX3j/F+gzEFbzYlw1Pil8ehJHqfkgQE=; b=O
        V12uHWLprzyTdzNurAPHeByriz49zDuhyrfbUSbQxWIoGO5/4BnHzLRcsLvE21oVEvmz4QBIG1Zbw
        +vZAqhFtpIs4ObhoeHAABNkkwii2m7Nh+5qfmGzhHEbz6HjHXESmc14+gxTEvMki+hxcUnpf8Ymq6
        P5MDzsv9V9KeuUik=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42950 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q3icZ-0000Ll-Ok; Mon, 29 May 2023 15:33:36 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 May 2023 15:33:12 -0400
Message-Id: <20230529193311.1033939-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] arm64: dts: imx8mn-var-som: add 20ms delay to ethernet regulator enable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This commit is taken from Variscite linux kernel public git repository.
Original patch author: Nate Drude <nate.d@variscite.com>
See: https://github.com/varigit/linux-imx/blob/5.15-2.0.x-imx_var01/drivers/net/ethernet/freescale/fec_main.c#L3993-L4050

The ethernet phy reset was moved from the fec controller to the
mdio bus, see for example: 0e825b32c033e1998d0ebaf247f5dab3c340e3bf

When the fec driver managed the reset, the regulator had time to
settle during the fec phy reset before calling of_mdiobus_register,
which probes the mii bus for the phy id to match the correct driver.

Now that the mdio bus controls the reset, the fec driver no longer has
any delay between enabling the regulator and calling of_mdiobus_register.
If the regulator voltage has not settled, the phy id will not be read
correctly and the generic phy driver will be used.

The following call tree explains in more detail:

fec_probe
  fec_reset_phy                               <- no longer introduces delay after migration to mdio reset
  fec_enet_mii_init
    of_mdiobus_register
      of_mdiobus_register_phy
        fwnode_mdiobus_register_phy
          get_phy_device                      <- mii probe for phy id to match driver happens here
          ...
          fwnode_mdiobus_phy_device_register
            phy_device_register
              mdiobus_register_device
                mdio_device_reset             <- mdio reset assert / deassert delay happens here

Add a 20ms enable delay to the regulator to fix the issue.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index cbd9d124c80d..a502ef7394a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -27,6 +27,7 @@ reg_eth_phy: regulator-eth-phy {
 		regulator-name = "eth_phy_pwr";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-enable-ramp-delay = <20000>;
 		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};

base-commit: 8b817fded42d8fe3a0eb47b1149d907851a3c942
-- 
2.30.2

