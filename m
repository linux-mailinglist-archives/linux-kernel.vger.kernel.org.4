Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D973B540
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFWK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E22E9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8331C619E6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB23C433C8;
        Fri, 23 Jun 2023 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687516159;
        bh=yVjZn66r++ZhCk1KqONmns8zgE5ldWqRqKAWzYYRVBI=;
        h=From:Subject:Date:To:Cc:From;
        b=vBzyKAKXE9SYSdo01ADbe88OUg3WzqYt8thcz2ao8R32L/m7xTcL3eHxu7+qzRSZc
         3qoJsaiiAzYcQOLOdD0NvzjqWSI0H1Unsb7b/O1OSOIKDZC6+cr261VLNfClU96m+8
         3VUSHgAiYGTu+wSSDagnBeW59fPBXPzfYIUticoR/k+dDPQFzcML4aNvGcIgvmL5WX
         Xb4L4KEwxd2D7iaabQy2Qp4dFKDO4KzoC3MaB6r5F5uegn6Axh4jwzUJ03PZFDmtsp
         Sq94JT1m8nZQxQabiR+rl005XPIBKhjh7U02+7Jjdv39sikoLgbGRfOHWSKeFm+JQP
         pVjHCR3SZ1FHw==
From:   Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next v2 00/10] net: phy: C45-over-C22 access
Date:   Fri, 23 Jun 2023 12:29:09 +0200
Message-Id: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVzlWQC/x2NwQqDMBAFf0X23IW4rVL6K6WHTXzWHBrLJoog/
 ntjj8MwzE4ZFpHp0exkWGOOc6ogl4bCpOkNjkNlEidX14vjEVoWA4dbx/MK4yDCTqW9t1790PV
 UU68Z7E1TmM74o7nATvE1jHH7/56UUDhhK/Q6jh+3k9EliQAAAA==
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
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the very late follow-up on this series, I simply haven't had
time to look into it. Should be better now.]

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
Michael Walle (10):
      net: phy: add error checks in mmd_phy_indirect() and export it
      net: phy: get rid of redundant is_c45 information
      net: phy: introduce phy_is_c45()
      net: phy: replace is_c45 with phy_accces_mode
      net: phy: make the "prevent_c45_scan" a property of the MII bus
      net: phy: print an info if a broken C45 bus is found
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
 drivers/net/phy/mdio_bus.c                        |  33 ++---
 drivers/net/phy/mxl-gpy.c                         |   9 +-
 drivers/net/phy/nxp-tja11xx.c                     |   3 +-
 drivers/net/phy/phy-core.c                        | 105 +++++++++++-----
 drivers/net/phy/phy.c                             |   8 +-
 drivers/net/phy/phy_device.c                      | 139 +++++++++++++++++-----
 drivers/net/phy/phylink.c                         |  10 +-
 drivers/net/phy/sfp.c                             |  12 +-
 include/linux/phy.h                               |  48 ++++++--
 15 files changed, 331 insertions(+), 134 deletions(-)
---
base-commit: 5e218791dc7b2b57c90d5942ab6bae4bc2ab0ead
change-id: 20230620-feature-c45-over-c22-0a2181babd56

