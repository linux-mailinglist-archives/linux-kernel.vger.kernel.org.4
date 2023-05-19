Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51570991E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjESONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjESONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:13:04 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7EC192;
        Fri, 19 May 2023 07:13:00 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B6E69E000C;
        Fri, 19 May 2023 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684505579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hNOWLwZhohqqCv++hyHHKNma3nLjTIdFany2731ha0U=;
        b=PQx2oP1A1g1UHKp0oSO4ocOP25FfBY43imsJdUNEXikVPyEyKgFMqUaTXPbK481EZfNaAK
        xanp4U3sYWNcgc36H5pEf5prYuMrh6cLKkKDSkSPzJvb2nl0U30MaxHWGPEJ+W9r8L7mrB
        VKdKLJOD4nW3PF7LiILdk8fddZnNilY3+Y4hLotCCfgMXi5WwHNXjffbzyhdIqQxVXMXWq
        1xJUrSfogvg6NlFStl9x2dL50IDQwu+xJFedVDvZngjDUKqV1QseR/x+MQqd1g4mHE5Im6
        ebRdszPtTgdylld2CKabKbqrH/LgA70jHFllQSaLX0jsVSv+sqBVLKo9dSe51w==
From:   alexis.lothore@bootlin.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        paul.arola@telus.com, scott.roberts@telus.com,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net-next v2 0/7] net: dsa: mv88e6xxx: add 88E6361 support
Date:   Fri, 19 May 2023 16:12:56 +0200
Message-Id: <20230519141303.245235-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

This series brings initial support for Marvell 88E6361 switch.

MV88E6361 is a 8 ports switch with 5 integrated Gigabit PHYs and 3
2.5Gigabit SerDes interfaces. It is in fact a new variant in the
88E639X/88E6193X/88E6191X family with a subset of existing features:
- port 0: MII, RMII, RGMII, 1000BaseX, 2500BaseX
- port 3 to 7: triple speed internal phys
- port 9 and 10: 1000BaseX, 25000BaseX

Since said family is already well supported in mv88e6xxx driver, adding
initial support for this new switch mostly consists in finding the ID
exposed in its identification register, adding a proper description
in switch description tables in mv88e6xxx driver, and enforcing 88E6361
specificities in mv88e6393x_XXX methods.

- first 4 commits introduce an internal phy offset field for switches which
  have internal phys but not starting from port 0
- 5th commit is a fix on existing switches based on first commits
- 6th commit is a slight modification to prepare 886361 support
- last commit introduces 88E6361 support in 88E6393X family

This initial support has been tested with two samples of a custom board
with the following hardware configuration:
- a main CPU connected to MV88E6361 using port 0 as CPU port
- port 9 wired to a SFP cage
- port 10 wired to a G.Hn transceiver

The following setup was used:
PC <-ethernet-> (copper SFP) - Board 1 - (G.hn) <-phone line(RJ11)-> (G.hn) Board 2

The unit 1 has been configured to bridge SFP port and G.hn port together,
which allowed to successfully ping Board 2 from PC.

Now that this series brings fixes for existing switches, I am not sure if
a split into two series is desirable. If so, please let me know. Also, my
current testing hardware does not use ports with internal PHYs, so further
feedback/testing on 6393X family would be highly appreciated

Changes since v1:
- rework mv88e6xxx_port_ppu_updates to use internal helper
- add internal phys offset field to manage switches which do not have
  internal PHYs right on first ports
- fix 88E639X/88E6193X/88E6191X internal phy layout
- enforce 88E6361 features in mv88e6393x_port_set_speed_duplex
- enforce 88E6361 features in mv88e6393x_port_max_speed_mode
- enforce 88E6361 features in mv88e6393x_phylink_get_caps
- add Reviewed-By and Acked-By on untouched patch

Alexis Lothoré (7):
  dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility
    list
  net: dsa: mv88e6xxx: pass directly chip structure to
    mv88e6xxx_phy_is_internal
  net: dsa: mv88e6xxx: use mv88e6xxx_phy_is_internal in
    mv88e6xxx_port_ppu_updates
  net: dsa: mv88e6xxx: add field to specify internal phys layout
  net: dsa: mv88e6xxx: fix 88E6393X family internal phys layout
  net: dsa: mv88e6xxx: pass mv88e6xxx_chip structure to
    port_max_speed_mode
  net: dsa: mv88e6xxx: enable support for 88E6361 switch

 .../devicetree/bindings/net/dsa/marvell.txt   |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c              | 69 ++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/chip.h              | 11 ++-
 drivers/net/dsa/mv88e6xxx/global2.c           |  6 +-
 drivers/net/dsa/mv88e6xxx/port.c              | 23 +++++--
 drivers/net/dsa/mv88e6xxx/port.h              | 13 ++--
 6 files changed, 94 insertions(+), 30 deletions(-)

-- 
2.40.1

