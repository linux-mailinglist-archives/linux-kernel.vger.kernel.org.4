Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876FD6DEF55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDLIti convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Apr 2023 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDLItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:49:33 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA727ED7;
        Wed, 12 Apr 2023 01:49:13 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1925B8043;
        Wed, 12 Apr 2023 16:45:42 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 16:45:42 +0800
Received: from ubuntu.localdomain (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 16:45:40 +0800
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
Subject: [PATCH v4 0/3] Add JH7110 MIPI DPHY RX support
Date:   Wed, 12 Apr 2023 01:45:37 -0700
Message-ID: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
It is used to transfer CSI camera data. The series has been tested on
the VisionFive 2 board.

This patchset should be applied after the patchset [1] [2]:
[1] https://lore.kernel.org/all/20230411135558.44282-1-xingyu.wu@starfivetech.com/
[2] https://lore.kernel.org/all/20230411064743.273388-1-changhuang.liang@starfivetech.com/

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

 .../bindings/phy/starfive,jh7110-dphy-rx.yaml |  85 ++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  14 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  13 +
 drivers/phy/starfive/Makefile                 |   2 +
 drivers/phy/starfive/phy-starfive-dphy-rx.c   | 286 ++++++++++++++++++
 8 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-starfive-dphy-rx.c


base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
prerequisite-patch-id: 388b8adbb0fe2daf4d07a21eafd4f1bd50ce2403
prerequisite-patch-id: 1117ecaa40a353c667b71802ab34ecf9568d8bb2
prerequisite-patch-id: b00c6b21fbd0353d88b7c9b09093ba30b765f45b
prerequisite-patch-id: 08ec9027e8a5c6fdf201726833168c7464a9b94d
prerequisite-patch-id: fb5120248e48fe1faf053ae0b490c92507ec2b44
prerequisite-patch-id: 4b93d8d590b0a2abe7b4be5287232c494c35be4a
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: c09c4c68af017b8e5c97b515cb50b70c18a2e705
prerequisite-patch-id: 0df8ccb0e848c2df4c2da95026494bebecede92d
prerequisite-patch-id: 315303931e4b6499de7127a88113763f86e97e16
prerequisite-patch-id: 40cb8212ddb024c20593f73d8b87d9894877e172
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: d57cc467fb036241b9276320ff076c4a30d376d6
prerequisite-patch-id: 6e563d68bc5dbf951d4ced17897f9cc4d56169fe
prerequisite-patch-id: 61ec2caa21fd0fc60e57977f7d16d3f72b135745
prerequisite-patch-id: 1387a7e87b446329dfc21f3e575ceae7ebcf954c
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: 9007c8610fdcd387592475949864edde874c20a2
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 0a0ac5a8a90655b415f6b62e324f3db083cdaaee
prerequisite-patch-id: 7ff6864ac74df5392c8646fe756cadd584fcc813
prerequisite-patch-id: 284b5d1b95c6d68bca08db1e82ed14930c98b777
prerequisite-patch-id: bf945205ddc9ce82ceaa9b65f1ce74d418cd679b
prerequisite-patch-id: 4590f1ab508e1de53f38e041f72acf6697b86e43
prerequisite-patch-id: 983e5bdb79140f251188f75616f5af4e9277d9dc
prerequisite-patch-id: 51d8468d34d92024684fa41bb4f824f5b22f64a4
prerequisite-patch-id: 66876bb31692425683e48cd374d26b3d57543ffb
prerequisite-patch-id: 74b4cab6d5b289d8794cf3b15e48fbe8dec3b525
prerequisite-patch-id: b7339b240664c4eabc143e9dab73105af807f5c7
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: 80042661ff6156ce577a72e9eb8c0b218b624829
prerequisite-patch-id: 8c735dffc6d5388a35a76b16e914a2f9722ad979
prerequisite-patch-id: 3d8fa6282e8227273b4e564b1aaab1e5e9f8ab08
prerequisite-patch-id: 36e69700dfc0375b950b0e23086ed3b722cb84a4
prerequisite-patch-id: 30285160ae8276d7e7a2607c86e6f33dab631600
prerequisite-patch-id: 81f7c65712c4901a7a178ddcd98ffc55f3b473ff
prerequisite-patch-id: 9c03a24fb91aa831850697fb562d969a4b9d97ad
prerequisite-patch-id: 39e1be2a3d1593577ab997f55f59367cba665aa7
prerequisite-patch-id: d5abfba63fc07ff97b5023911513c260bb7a53e1
prerequisite-patch-id: 39a4219fec3bbe3b3b255359d34ed1a06a7cd8b8
--
2.25.1
