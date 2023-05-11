Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619A6FF4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbjEKOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEKOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:44:10 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23EE35B3;
        Thu, 11 May 2023 07:39:53 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1px71J-0000mD-0V;
        Thu, 11 May 2023 14:11:49 +0000
Date:   Thu, 11 May 2023 16:09:54 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v4 0/2] net: phy: add driver for MediaTek SoC
 built-in GE PHYs
Message-ID: <cover.1683813687.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of MediaTek's Filogic SoCs come with built-in gigabit Ethernet
PHYs which require calibration data from the SoC's efuse.
Despite the similar design the driver doesn't share any code with the
existing mediatek-ge.c, so add support for these PHYs by introducing a
new driver for only MediaTek's ARM64 SoCs.

As the PHYs integrated in the MT7988 SoC require reading the polarity
of the LEDs from the SoCs's boottrap also add dt-binding for that.

All LEDs are for now setup with default values, a follow up patch which
allows custom LED setups will be sent after the PHY LED framework is
more in shape.

Changes since v3:
 * fix spelling and reverse xmas tree
 * add dt-binding for mediatek,boottrap

Changes since v2:
 * remove everything related to PHY LEDs for now, LED support will
   be cleaned up and submitted once PHY LED framework is more ready

Changes since v1:
 * split-off SoC-specific driver from mediatek-ge.c as requested
 * address comments made by Heiner Kallweit
 * add pinctrl handling for PHY LED
 * remove calibration details not needed in production hardware

Daniel Golle (2):
  dt-bindings: arm: mediatek: add mediatek,boottrap binding
  net: phy: add driver for MediaTek SoC built-in GE PHYs

 .../arm/mediatek/mediatek,boottrap.yaml       |   37 +
 MAINTAINERS                                   |    9 +
 drivers/net/phy/Kconfig                       |   12 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/mediatek-ge-soc.c             | 1264 +++++++++++++++++
 drivers/net/phy/mediatek-ge.c                 |    3 +-
 6 files changed, 1325 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,boottrap.yaml
 create mode 100644 drivers/net/phy/mediatek-ge-soc.c


base-commit: 285b2a46953cecea207c53f7c6a7a76c9bbab303
-- 
2.40.0

