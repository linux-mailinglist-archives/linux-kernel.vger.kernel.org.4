Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0F750BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjGLPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjGLPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A721BFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE4961803
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED24C433C7;
        Wed, 12 Jul 2023 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174451;
        bh=JUkJn0tOQ/1zn5ty5hw2G+mKkQGgGt0pj2+gPzoup48=;
        h=From:Subject:Date:To:Cc:From;
        b=A3NzsoDq1V6Qg40QoPbF6BZFHf3/IlL18NYcrVieLcuzyWy3cEem7L4oNFqm6QkwV
         1HFo9vfotZtY2j37nHwGEqBo/neh6XDuCXT/EIrFZBtdNlYEV8OfNcRLraddBGqPX4
         3B3TW7QjbrQCYnXPsEHreV4Nu+litUOxt1wEuW8dJLEIuxRJrIqIR6TJHARy8+L/t9
         Wc3ZrjdRo6qHeWaEId6t6rGieDLZam1ydC1acTcVDw1nmjq4ZDVh55pGCc+8KI60RG
         ZeXJ0X2h+Tkax/v6W1UtXTdNQNBwsq6Az+czA4+yr8aL+pEzI0RLxUNlstjLYjJpeb
         Z09Dliu3Ppk8w==
From:   Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next v3 00/11] net: phy: C45-over-C22 access
Date:   Wed, 12 Jul 2023 17:07:00 +0200
Message-Id: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTBrmQC/32OQQ6CMBBFr0Jm7ZhShagr72FctOUDjVrMtBIM4
 e4WDuDy5eXn/ZkixCPSpZhJMProh5DhsCvI9SZ0YN9kJq30QdVacQuTPgJ2x4qHEcJOa1ZGl6f
 SGttUNeWpNRFsxQTXr+OXiQmyireg9dPWu1FA4oAp0T2b3sc0yHc7MurN/2+OOcsNWmXs2TlAX
 x+QgOd+kI7uy7L8AG4kZj3cAAAA
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal here is to get the GYP215 and LAN8814 running on the Microchip
LAN9668 SoC. The LAN9668 suppports one external bus and unfortunately, the
LAN8814 has a bug which makes it impossible to use C45 on that bus.
Fortunately, it was the intention of the GPY215 driver to be used on a C22
bus. But I think this could have never really worked, because the
phy_get_c45_ids() will always do c45 accesses and thus gpy_probe() will
fail.

Introduce C45-over-C22 support and use it if the MDIO bus doesn't support
C45 in the OF case. We must not use C45-over-C22 if the device being
probed isn't a PHY because it involes register writes to standard PHY
registers, which might not be supported in generic PHY devices.
Therefore, we cannot use it in the generic PHY probing code. In the DT
case, we know we are probing a PHY device and thus we can fall back to
C45-over-C22.

The first patches convert the is_c45 property to a new "enum
phy_access_mode". The former property is then derived from the
access mode.

To support the probing for DT, export the prevent_c45_scan logic and
make it a property of the mii bus. Unfortunately, you'd need to stick to
the following flow in every scanning code:
 (1) add any c22 phys
 (2) scan for broken phys
 (3) add any c45 phys using either c45 or c45-over-c22 access

I couldn't find a way to make that generic and move the flow into the
phy core.

Then, a new access method c45-over-c22 is added for get_phy_device() and
phy_{read,write}_mmd(). It is the callers responsibilty to choose the
correct mode. Esp. the generic probing code isn't using c45-over-c22.

c45-over-c22 is then added for the MaxLinear PHYs if it is probed as a
C22 device, which is always the case if there is no compatible =
"ethernet-phy-ieee802.3-c45" in the device tree. The driver will
automatically "promote" the PHY to a C45 one if probed as C22.

The last two patches will then add c45-over-c22 fallback to the DT PHY
registration code. As described above, the probing is split into the
three phases.

FWIW, this now triggers a bug in mscc-miim. Haven't figured out what's
wrong yet, somehow the status register doesn't return busy/pending.
Currently, working around that with a sleep.

net: phy: add error checks in mmd_phy_indirect() and export it
net: phy: get rid of redundant is_c45 information
net: phy: introduce phy_is_c45()
net: phy: replace is_c45 with phy_accces_mode
net: phy: make the "prevent_c45_scan" a property of the MII bus
net: phy: print an info if a broken C45 bus is found
net: phy: add support for C45-over-C22 transfers
net: phy: introduce phy_promote_to_c45()
net: mdio: add C45-over-C22 fallback to fwnode_mdiobus_register_phy()
net: mdio: scan for broken C22 PHYs when probed via OF

Changes since v2:
 - addressed the review comments, see individual patches
 - more importantly, introduce a new helper phy_mdiobus_read_mmd() which
   takes an enum access_mode.
 - Link: https://lore.kernel.org/r/20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org

Changes since v1:
 - major rework to address the problem to not use c45-over-c22 on
   bus scanning, see the description above. Except from some preparation
   patches there is little left of the original series. The major
   difference is that there is now a new transport mode argument and the
   c45-over-c22 is not automatically used anymore.
 - Link: https://lore.kernel.org/netdev/20230120224011.796097-1-michael@walle.cc/

Changes since RFC v2:
 - Reased to latest net-next
 - new check_rc argument in mmd_phy_indirect() to retain old behavior
 - determine bus capabilities by bus->read and bus->read_c45
 - always set phydev->c45_over_c22 if PHY is promoted
 - Link: https://lore.kernel.org/netdev/20220325213518.2668832-1-michael@walle.cc/

Changes since RFC v1:
 - use __phy_mmd_indirect() in mdiobus_probe_mmd_read()
 - add new properties has_c45 c45_over_c22 (and remove is_c45)
 - drop MDIOBUS_NO_CAP handling, Andrew is preparing a series to
   add probe_capabilities to mark all C45 capable MDIO bus drivers
 - Link: https://lore.kernel.org/netdev/20220323183419.2278676-1-michael@walle.cc/

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Michael Walle (11):
      net: phy: get rid of redundant is_c45 information
      net: phy: introduce phy_has_c45_registers()
      net: phy: replace is_c45 with phy_accces_mode
      net: phy: make the "prevent_c45_scan" a property of the MII bus
      net: phy: print an info if a broken C45 bus is found
      net: phy: add error checks in mmd_phy_indirect()
      net: phy: introduce phy_mdiobus_read_mmd()
      net: phy: add support for C45-over-C22 transfers
      net: phy: introduce phy_promote_to_c45()
      net: mdio: add C45-over-C22 fallback to fwnode_mdiobus_register_phy()
      net: mdio: support C45-over-C22 when probed via OF

 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c |   8 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  |   4 +-
 drivers/net/mdio/fwnode_mdio.c                    |  19 ++-
 drivers/net/mdio/of_mdio.c                        |  63 +++++++---
 drivers/net/phy/bcm84881.c                        |   2 +-
 drivers/net/phy/marvell10g.c                      |   2 +-
 drivers/net/phy/mdio_bus.c                        |  34 ++---
 drivers/net/phy/mxl-gpy.c                         |   9 +-
 drivers/net/phy/nxp-tja11xx.c                     |   3 +-
 drivers/net/phy/phy-core.c                        | 144 ++++++++++++++++------
 drivers/net/phy/phy.c                             |   8 +-
 drivers/net/phy/phy_device.c                      | 107 +++++++++++-----
 drivers/net/phy/phylink.c                         |  12 +-
 drivers/net/phy/sfp.c                             |  12 +-
 include/linux/phy.h                               |  48 ++++++--
 15 files changed, 335 insertions(+), 140 deletions(-)
---
base-commit: ed2f1f76bed5a7ace3c4fa90bce3457d0fe2035d
change-id: 20230620-feature-c45-over-c22-0a2181babd56

