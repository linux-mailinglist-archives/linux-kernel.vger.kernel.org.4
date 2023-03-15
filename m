Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764F6BAE00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjCOKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCOKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:44:18 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D854346F;
        Wed, 15 Mar 2023 03:44:15 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 99A5424E1BD;
        Wed, 15 Mar 2023 18:44:14 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 18:44:14 +0800
Received: from ubuntu.localdomain (113.72.145.194) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 18:44:13 +0800
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
        "Minda Chen" <minda.chen@starfivetech.com>
Subject: [PATCH v3 0/5] Add JH7110 USB and USB PHY driver support
Date:   Wed, 15 Mar 2023 18:44:06 +0800
Message-ID: <20230315104411.73614-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds USB driver and USB PHY for the StarFive JH7110 SoC.
USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
The patch has been tested on the VisionFive 2 board.

This patchset should be applied after the patchset [1], [2] and[3]:
[1] https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/
[2] https://lore.kernel.org/all/20230215113249.47727-4-william.qiu@starfivetech.com/
[3] https://lore.kernel.org/all/20230223015952.201841-1-changhuang.liang@starfivetech.com/

This patchset is base on v6.3-rc1

patch 1 is usb phy and pcie PHY layer dt-binding document.
patch 2 is USB 2.0 PHY and PCIe PHY driver.
patch 3 is usb wrapper layer dt-binding document.
patch 4 is the wrapper module driver of Cadence USB3. USB controller IP is Cadence USB3.
patch 5 is USB device tree configuration.

previous version
---
v1: https://patchwork.kernel.org/project/linux-usb/cover/20230306095212.25840-1-minda.chen@starfivetech.com/
v2: https://patchwork.kernel.org/project/linux-usb/cover/20230308082800.3008-1-minda.chen@starfivetech.com/

changes
v3:
  1. Add patch 1 and patch2. Add USB driver. USB PHY codes are moved to patch 2.
  2. (patch 3) USB wrapper module dts document is moved to usb directory.
     Remove the 'dr_mode' and 'starfive,usb2-only' setting.
     Some dts format changes. dts binding check pass.
  3. (patch 4) Remove the PHY codes. 
     Search 'dr_mode' and phy setting from Cadence subnode.
  4. (patch 5) Add USB PHY dts configurion. 
     'dr_mode' is moved to Cadence controller submode.

v2:
  1. (patch 3) dt-binding changes. The document example is the same as dts config.
  2. (patch 4) using dev_err_probe and syscon_regmap_lookup_by_phandle_args function. Some formats changes
  3. (patch 5) dts nodes sorted by the address after @


Minda Chen (5):
  dt-bindings: phy: Add StarFive JH7110 USB/PCIe document
  phy: starfive: add JH7110 PCIE 2.0 and USB 2.0 PHY driver.
  dt-binding: Add JH7110 USB wrapper layer doc.
  usb: cdns3: add StarFive JH7110 USB driver.
  dts: usb: add StarFive JH7110 USB dts configuration.

 .../phy/starfive,jh7110-usb-pcie-phy.yaml     |  62 ++++
 .../bindings/usb/starfive,jh7110-usb.yaml     | 119 +++++++
 MAINTAINERS                                   |  15 +
 .../jh7110-starfive-visionfive-2.dtsi         |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  54 ++++
 drivers/phy/starfive/Kconfig                  |  22 ++
 drivers/phy/starfive/Makefile                 |   2 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 136 ++++++++
 drivers/phy/starfive/phy-jh7110-usb.c         | 167 ++++++++++
 drivers/usb/cdns3/Kconfig                     |  11 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-starfive.c            | 305 ++++++++++++++++++
 12 files changed, 901 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: 8ca09d5fa3549d142c2080a72a4c70ce389163cd
prerequisite-patch-id: 46cc850aa0e9e03ccf5ed23d8458babfca3d71af
prerequisite-patch-id: a6975e61ee5803fbd74b1c21ab925fd81c3c0eab
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: 044263ef2fb9f1e5a586edbf85d5f67814a28430
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: 9f3dbc9073eee89134e68977e941e457593c2757
prerequisite-patch-id: 8600b156a235be2b3db53be3f834e7a370e2cfb9
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 4c12d958e3a3d629d86dddb1e4f099d8909393e0
prerequisite-patch-id: bb939c0c7c26b08addfccd890f9d3974b6eaec53
prerequisite-patch-id: 8f5c66dfb14403424044192f6fa05b347ad356a7
prerequisite-patch-id: fd93763b95469912bde9bdfa4cd827c8d5dba9c6
prerequisite-patch-id: 6987950c2eb4b3773b2df8f7934eff434244aeab
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 9f911969d0a550648493952c99096d26e05d4d83
prerequisite-patch-id: f9ce88e490c2473c3c94ad63fa26bc91829ce2cc
prerequisite-patch-id: 2c6b9fe2b00d9c1812d26fcffb4925335b359ede
prerequisite-patch-id: 51c1ca0fa8e1e8910c4d6aba147b8a75fd90a07f
prerequisite-patch-id: be0d260ac6eea34de411bf028828fea9f9fa0a9f
prerequisite-patch-id: aaff99c0bdd1604048d0713b44084ad4604816e1
prerequisite-patch-id: d7d5f5f35ecc3d66be8e3d8b0662788f875adc32
prerequisite-patch-id: b3362bb851a0efaa848104bc0c2a1a264ba7904b
prerequisite-patch-id: 6c25cbf9fe08218ee952d2202c5f6b645ea4b6e4
-- 
2.17.1

