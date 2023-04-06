Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2576D8D02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjDFBwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjDFBw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:52:28 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5C7AA6;
        Wed,  5 Apr 2023 18:52:25 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C424424E208;
        Thu,  6 Apr 2023 09:52:19 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 09:52:19 +0800
Received: from ubuntu.localdomain (183.27.97.179) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 09:52:18 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Minda Chen" <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v4 0/7] Add JH7110 USB and USB PHY driver support
Date:   Thu, 6 Apr 2023 09:52:09 +0800
Message-ID: <20230406015216.27034-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds USB driver and USB PHY for the StarFive JH7110 SoC.
USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
The patch has been tested on the VisionFive 2 board.

This patchset should be applied after the patchset [1], [2] and[3]:
[1] https://patchwork.kernel.org/project/linux-riscv/cover/20230314124404.117592-1-xingyu.wu@starfivetech.com/
[2] https://lore.kernel.org/all/20230315055813.94740-1-william.qiu@starfivetech.com/
[3] https://patchwork.kernel.org/project/linux-phy/cover/20230315100421.133428-1-changhuang.liang@starfivetech.com/

This patchset is base on v6.3-rc4

patch 1 is usb phy dt-binding document.
patch 2 is Pcie PHY dt-binding document.
patch 3 is USB 2.0 PHY driver.
patch 4 is PCIe PHY driver.
patch 5 is usb dt-binding document.
patch 6 is the wrapper module driver of Cadence USB3. USB controller IP is Cadence USB3.
patch 7 is USB device tree configuration.

previous version
---
v1: https://patchwork.kernel.org/project/linux-usb/cover/20230306095212.25840-1-minda.chen@starfivetech.com/
v2: https://patchwork.kernel.org/project/linux-usb/cover/20230308082800.3008-1-minda.chen@starfivetech.com/
v3: https://patchwork.kernel.org/project/linux-usb/cover/20230315104411.73614-1-minda.chen@starfivetech.com/

changes
v4:
  1. (patch 1) split PCIe PHY dt-binding doc to patch 2.
  2. (patch 2) PCIe PHY add stg and sys con configuration to dt-binding doc.
  3. (patch 3)
     - split PCIe PHY driver to patch 4.
     - replace dr_mode to phy mode in jh7110_usb2_phy.
  4. (patch 4) 
     - Makefile and Kconfig sorted by alphabet sequence.
     - Add PCIe PHY stg and syscon PHY connection configuration
       for USB 3.0.
  5. (patch 5)
     - commit message changed.
     - merge wrapper dts node and cdns3 node in example.
     - Add interrupts, reg, phy and dr_mode in property.
     - Add reset-name in property example.
  6. (patch 6)
     - For dts node is merged, Using platform_device_alloc and
       platform_device_add to generate cadence sub device.
     - IOMEM and IRQ resource are passed to Cadence sub device.
     - Add PHY ops process for PHY dts setting can not be passed to
       Cadence USB driver.
     - remove the stg and sys USB 3.0 PHY configuration.
     - Change the suspend clock reset and clock enable sequence.
     - Get all reset and clock resources before enable them in 
       cdns_clk_rst_init.
     - commit message changed.
  7. (patch 7)
     - merge wrapper dts node and cdns3 node in usb dts.
     - move the stg and sys USB 3.0 PHY confiuration to
       PCIe PHY dts node.
     - commit message changed.
     - Add reset-names dts.

v3:
  1. Add patch 1 - 4. Add USB PHY driver and dt-binding doc. 
     USB PHY codes are moved to patch 3 and patch 4.
  2. (patch 5)
     - USB wrapper module dts document is moved to usb directory.
     - Remove the 'dr_mode' and 'starfive,usb2-only' setting.
     - Some dts format changes. dts binding check pass.
  3. (patch 6)
     - Remove the PHY codes. 
     - Search 'dr_mode' and phy setting from Cadence subnode.
  4. (patch 7)
     - Add USB PHY dts configurion. 
     - 'dr_mode' is moved to Cadence controller submode.

v2:
  1. (patch 5) dt-binding changes. The document example is the same as dts config.
  2. (patch 6) using dev_err_probe and syscon_regmap_lookup_by_phandle_args function. Some formats changes
  3. (patch 7) dts nodes sorted by the address after @


Minda Chen (7):
  dt-bindings: phy: Add StarFive JH7110 USB document
  dt-bindings: phy: Add StarFive JH7110 PCIe document
  phy: starfive: add JH7110 USB 2.0 PHY driver.
  phy: starfive: add JH7110 PCIE 2.0 PHY driver.
  dt-bindings: usb: Add StarFive JH7110 USB Bindings YAML schemas
  usb: cdns3: add StarFive JH7110 USB driver.
  riscv: dts: starfive: add USB dts configuration for JH7110

 .../phy/starfive,jh7110-pcie-phy.yaml         |  58 +++
 .../bindings/phy/starfive,jh7110-usb-phy.yaml |  50 +++
 .../bindings/usb/starfive,jh7110-usb.yaml     | 136 +++++++
 MAINTAINERS                                   |  16 +
 .../jh7110-starfive-visionfive-2.dtsi         |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  44 ++
 drivers/phy/starfive/Kconfig                  |  22 +
 drivers/phy/starfive/Makefile                 |   2 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 197 +++++++++
 drivers/phy/starfive/phy-jh7110-usb.c         | 161 ++++++++
 drivers/usb/cdns3/Kconfig                     |  11 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-starfive.c            | 378 ++++++++++++++++++
 drivers/usb/cdns3/core.h                      |   3 +
 14 files changed, 1086 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35
prerequisite-patch-id: 24a6e3442ed1f5454ffb4a514cfd768436a87090
prerequisite-patch-id: 55390537360f25c8b9cbfdc30b73ade004f436f7
prerequisite-patch-id: bb939c0c7c26b08addfccd890f9d3974b6eaec53
prerequisite-patch-id: 8a6f135bcabdad4a4bfb21f0c6a0ffd2bb57efe7
prerequisite-patch-id: c2366f993a9d85e28c06d8d09f064dd5e8b29a61
prerequisite-patch-id: 50d53a21f91f4087fc80b6f1f72864adfb0002b9
prerequisite-patch-id: 0df3703af91c30f1ca2c47f5609012f2d7200028
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: 551fae54377090044c3612fca9740a9b359abdd2
prerequisite-patch-id: c7fdf904f398d478f0ed6d57eb878982bc73329d
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 4637a8fa2334a45fa6b64351f4e9e28d3e2d60d3
prerequisite-patch-id: 32647ec60a3b614e1c59ec8e54cb511ae832c22f
prerequisite-patch-id: aa06658ecf89c92d0dfdd6a4ba6d9e6e67532971
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 9f911969d0a550648493952c99096d26e05d4d83
prerequisite-patch-id: 41eddeabff082d08a76d8da523f90da4b5218d28
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: 398744c61913c76a35754de867c4f820ca7a8d99
prerequisite-patch-id: 1a2c49c1cf81607f062f35898457037d86598cf9
prerequisite-patch-id: f59269382164b5d642a5e10443ca447f5caa595c
prerequisite-patch-id: 1babe83d6bf999bad17584dc595480f9070a5369
prerequisite-patch-id: d95ea69f88a048ef702dceed0f2edee31e6fdfd2
prerequisite-patch-id: 77be3d122d66df813f13088141ce27b21107a341
prerequisite-patch-id: 9fbb7ad1dd258bb8ff5946c4a0e59de4bfd82a04
prerequisite-patch-id: a02411a8fe009acc0888e4a7d60233c9ee5a1e71
prerequisite-patch-id: 6f6984916dffd0cc66aa733c9b6bd3a55495a50c
prerequisite-patch-id: 584c256c9acb52ee2773d0c81c3f4977fc18155a
prerequisite-patch-id: b37ac15032973e1fcd918f157c82a0606775c9e9
prerequisite-patch-id: 999c243dca89d56d452aa52ea3e181358b5c1d80
prerequisite-patch-id: ca653566085079839fb3dc1e722effafbc8109a4
prerequisite-patch-id: 2fe72c216673efe690db54cbf500ba7f15e6247a
prerequisite-patch-id: 776afb78743657e4a6bfebd2cd8a44c5c9017ee2
prerequisite-patch-id: c9b92e6d1531d0a9fb122d9d038cc3d9df380e0f
-- 
2.17.1

