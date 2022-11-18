Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903362EADF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiKRB2q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiKRB2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:28:33 -0500
X-Greylist: delayed 664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 17:28:28 PST
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27467209E;
        Thu, 17 Nov 2022 17:28:23 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8E6EB24E20C;
        Fri, 18 Nov 2022 09:17:18 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:17:17 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:17:16 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/8] Basic device tree support for StarFive JH7110 RISC-V SoC
Date:   Fri, 18 Nov 2022 09:17:06 +0800
Message-ID: <20221118011714.70877-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original patch series "Basic StarFive JH7110 RISC-V SoC support" [1]
is split into 3 patch series. They respectively add basic clock&reset,
pinctrl and device tree support for StarFive JH7110 SoC. These patch
series are independent, but the Visionfive2 board can boot up successfully
only if all these patches series applied. This one adds basic device
tree support. This patch series is pulled out from the patch 1~6 and
patch 27~30 of v1 [1]. You can simply get or review the patches at the
link [2].

[1]: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/
[2]: https://github.com/hal-feng/linux/commits/visionfive2-minimal

Changes since v1:
- Rebased on tag v6.1-rc5.
- Added blank line in patch 1. (by Krzysztof)
- Rebased patch 4 and 6 on the newest code. (by Conor)
- Dropped patch 5. (by Conor)
- Removed the quirk of JH7100 in patch 6, considering this patch series
  should only add support for JH7110.
- For patch 27, added Co-developed-by tag for Jianlong and me. Renamed
  cpu labels to "S76_0", "U74_*" instead of "cpu*" following the style
  of jh7100.dtsi. Moved all "clock-frequency" properties to the board dts.
  Rewrote clock-controller nodes and deleted reset-controller nodes for
  using auxiliary bus. Rewrote gpio nodes following generic pinctrl
  bindings. Removed the redundant second reset entry of uart nodes.
- For patch 28, added Co-developed-by tag for Jianlong and me. Added a
  chosen node. Removed reserved-memory node. Added fixed frequency clock
  nodes for overriding the "clock-frequency" properties. Rewrote the gpio
  nodes following generic pinctrl bindings.
- Dropped patch 30. (by Conor)
- Reworded the commit messages.

  v1: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/

Emil Renner Berthing (7):
  dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive2 board
  dt-bindings: timer: Add StarFive JH7110 clint
  dt-bindings: interrupt-controller: Add StarFive JH7110 plic
  dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
  soc: sifive: ccache: Add StarFive JH7110 support
  riscv: dts: starfive: Add initial StarFive JH7110 device tree
  riscv: dts: starfive: Add StarFive JH7110 VisionFive2 board device
    tree

Hal Feng (1):
  RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../bindings/riscv/sifive,ccache0.yaml        |   7 +-
 .../devicetree/bindings/riscv/starfive.yaml   |   4 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/Kconfig.socs                       |   1 +
 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 .../jh7110-starfive-visionfive-v2.dts         | 116 +++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 437 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/soc/Makefile                          |   2 +-
 drivers/soc/sifive/Kconfig                    |   2 +-
 drivers/soc/sifive/sifive_ccache.c            |   1 +
 12 files changed, 571 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
prerequisite-patch-id: 6b1b43a55b9773bec61ab6c1bbaa54dccbac0837
prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
prerequisite-patch-id: 29fe0b0c19b6f0cd31114ee9fe17fe9732047f33
prerequisite-patch-id: c59d9908de90e09ba2b9a81aadbf9fb9f00c8f04
prerequisite-patch-id: 94ac03d518993921bcfc9cc9f58d7da0c3528b51
prerequisite-patch-id: 694f7400375f5b85581fc1821e427334507826f2
prerequisite-patch-id: 699d49c4439dadb4b7cf900857f027d050cd6093
prerequisite-patch-id: 40d773f5a19912f731ee5fd4739ed2e3c2157b07
prerequisite-patch-id: 2bc3fd6df5dda116efe882045863d6c88aa81b3a
prerequisite-patch-id: 735e62255c75801bdc4c0b4107850bce821ff7f5
prerequisite-patch-id: b2a923b922e661fa6085185f33c1f1e733db9110
prerequisite-patch-id: b2bbc28354075432f059344eba5a127a653475cf
prerequisite-patch-id: 70eab7b7eee728afcd90e40f6743d1356f6d81ab
prerequisite-patch-id: 6276b2a23818c65ff2ad3d65b562615690cffee9
prerequisite-patch-id: d834ece14ffb525b8c3e661e78736692f33fca9b
prerequisite-patch-id: 4c17a3ce4dae9b788795d915bf775630f5c43c53
prerequisite-patch-id: dabb913fd478e97593e45c23fee4be9fd807f851
prerequisite-patch-id: 22fa141f7f0f80a5d619e9f3f4cf161ad06f108e
prerequisite-patch-id: f306819c257ea73aff8e06b17b5731053cdddfc8
-- 
2.38.1

