Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE63714936
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjE2MPV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 May 2023 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjE2MPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:15:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F919B1;
        Mon, 29 May 2023 05:15:11 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A0FAC7F8A;
        Mon, 29 May 2023 20:15:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 20:15:06 +0800
Received: from ubuntu.localdomain (113.72.147.198) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 20:15:05 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 0/3] Add JH7110 MIPI DPHY RX support
Date:   Mon, 29 May 2023 05:15:00 -0700
Message-ID: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.198]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
It is used to transfer CSI camera data. The series has been tested on
the VisionFive 2 board.

This patchset should be applied after the patchset [1] [2]:
[1] https://lore.kernel.org/all/20230518101234.143748-1-xingyu.wu@starfivetech.com/
[2] https://lore.kernel.org/all/20230519060202.15296-1-changhuang.liang@starfivetech.com/

changes since v4:
- Rebased on tag v6.4-rc2.

patch 1:
- Dropped "lane_maps" property.

patch 2:
- Added lane maps in compatible.

patch 3:
- Dropped "lane_maps" property.
- Changed "pwrc_dphy" to "aon_syscon".

v4: https://lore.kernel.org/all/20230412084540.295411-1-changhuang.liang@starfivetech.com/

changes since v3:
- Rebased on tag v6.3-rc4.

patch 1 & patch 3:
- Changed "starfive,aon-syscon" to "power-domains".
- Added "lane_maps" property.

patch 2:
- Changed "STF_DPHY_APBCFGSAIF__SYSCFG(x)" to "STF_DPHY_APBCFGSAIF_SYSCFG(x)".
- Merged phy_init into phy_power_on.
- Merged phy_exit into phy_power_off.
- Replaced syscon with power domain framework.
- Parsed "lane_maps" property form device tree.
- Dropped compatible private data.

v3: https://lore.kernel.org/all/20230315100421.133428-1-changhuang.liang@starfivetech.com/

changes since v2:
- Rebased on tag v6.3-rc1.

patch 1:
- Changed the 'Starfive' to 'StarFive'.
- Changed the "items" to "- items".
- Add description to clocks.

patch 2:
- Changed the 'Starfive' to 'StarFive'.
- Updated the driver order in MAINTAINERS.

patch 3:
- Changed the 'Starfive' to 'StarFive'.
- Update clocks&resets macros follow patchset [1].

v2: https://lore.kernel.org/all/20230223015952.201841-1-changhuang.liang@starfivetech.com/

changes since v1:
- Rebased on tag v6.2.
- Dropped patch 1, it will be added by the patch [2].

patch 1:
- Changed the node name 'dphy' to 'phy'.
- Changed the "starfive,aon-syscon" description.
- Changed the MIPI DPHY RX IP description.
- Add description to resets.
- Update devicetree binding examples.

patch 2:
- Changed the commit message.

patch 3:
- Changed the commit message.
- Changed the node name 'dphy' to 'phy'.
- Sorted the node by address.

v1: https://lore.kernel.org/all/20230210061713.6449-1-changhuang.liang@starfivetech.com/

Changhuang Liang (3):
  dt-bindings: phy: Add starfive,jh7110-dphy-rx
  phy: starfive: Add mipi dphy rx support
  riscv: dts: starfive: Add dphy rx node

 .../bindings/phy/starfive,jh7110-dphy-rx.yaml |  71 +++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  13 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  13 +
 drivers/phy/starfive/Makefile                 |   2 +
 drivers/phy/starfive/phy-starfive-dphy-rx.c   | 300 ++++++++++++++++++
 8 files changed, 408 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-starfive-dphy-rx.c


base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
--
2.25.1
