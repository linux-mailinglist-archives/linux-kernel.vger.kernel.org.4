Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4931F7350D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjFSJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFSJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:48:16 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354F11AB;
        Mon, 19 Jun 2023 02:48:09 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4454124DD82;
        Mon, 19 Jun 2023 17:48:02 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 17:48:02 +0800
Received: from ubuntu.localdomain (113.72.145.217) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 17:48:01 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Minda Chen <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v7 0/7] Add JH7110 USB PHY driver support
Date:   Mon, 19 Jun 2023 17:47:54 +0800
Message-ID: <20230619094759.21013-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.217]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds USB and PCIe PHY for the StarFive JH7110 SoC.
The patch has been tested on the VisionFive 2 board.

This patchset is base on v6.4-rc6

patch 1 is usb phy dt-binding document.
patch 2 is Pcie PHY dt-binding document.
patch 3 is USB 2.0 PHY driver.
patch 4 is PCIe PHY driver.
patch 5 is PCIe PHY dts

Previous version are merged with USB controller patch.
For USB controller patch is accepted. Now remove the USB controller patch.
And remove the dependency.

previous change can be seen list below.
(start from old patch set v3)
v3: https://patchwork.kernel.org/project/linux-phy/cover/20230315104411.73614-1-minda.chen@starfivetech.com/
v4: https://patchwork.kernel.org/project/linux-phy/cover/20230406015216.27034-1-minda.chen@starfivetech.com/
v5: https://patchwork.kernel.org/project/linux-phy/cover/20230420110052.3182-1-minda.chen@starfivetech.com/
v6: https://patchwork.kernel.org/project/linux-phy/cover/20230518112750.57924-1-minda.chen@starfivetech.com/

changes:
v7:
  (patch3 and patch 4) Add /driver/phy/starfive directory, Makefile and Kconfig. Remove the dependency.
  (patch 5) add PCIe PHY dts configuration. (USB 2.0 PHY clock reply on other patch, Dont add this first).
  
v6:
  1. (patch 3) remove the platform remove function.
  2. (patch 4)
     - add switch to pcie mode function.
     - remove the redundant init/exit function.

v5:
  1. (patch 1) set correct model name and commit title.
  2. (patch 2) change to '-item' in syscon property. change commit title.

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

v3:
  1. Add patch 1 - 4. Add USB PHY driver and dt-binding doc. 
     USB PHY codes are moved to patch 3 and patch 4.


Minda Chen (5):
  dt-bindings: phy: Add StarFive JH7110 USB PHY
  dt-bindings: phy: Add StarFive JH7110 PCIe PHY
  phy: starfive: Add JH7110 USB 2.0 PHY driver
  phy: starfive: Add JH7110 PCIE 2.0 PHY driver
  riscv: dts: starfive: Add PCIe PHY dts configuration for JH7110

 .../phy/starfive,jh7110-pcie-phy.yaml         |  58 +++++
 .../bindings/phy/starfive,jh7110-usb-phy.yaml |  50 +++++
 MAINTAINERS                                   |   8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  12 ++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  25 +++
 drivers/phy/starfive/Makefile                 |   3 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 204 ++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb.c         | 150 +++++++++++++
 10 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.17.1

