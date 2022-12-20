Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9261E65179A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiLTBM6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 20:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTBMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:12:53 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C5711C14;
        Mon, 19 Dec 2022 17:12:50 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8E78924E199;
        Tue, 20 Dec 2022 09:12:49 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 09:12:49 +0800
Received: from ubuntu.localdomain (183.27.97.120) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 09:12:48 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] Basic device tree support for StarFive JH7110 RISC-V SoC
Date:   Tue, 20 Dec 2022 09:12:40 +0800
Message-ID: <20221220011247.35560-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds basic device tree support for StarFive JH7110 SoC.
This patch series depends on series [1] and [2]. You can simply get or
review the patches at the link [3].

[1]: https://lore.kernel.org/all/20221220005054.34518-1-hal.feng@starfivetech.com/
[2]: https://lore.kernel.org/all/20221220005529.34744-1-hal.feng@starfivetech.com/
[3]: https://github.com/hal-feng/linux/commits/visionfive2-minimal

Changes since v2:
- Rebased on tag v6.1.
- Dropped patch 8 because it was merged.
Patch 1:
- Made the links into "Link:" tags. (by Conor)
- Corrected the board name to "VisionFive 2" instead of
  "VisionFive V2" and added compatibles for version A and
  version B of VisionFive 2. (by Emil)
Patch 4:
- Used "sifive,ccache0" compatible string to match. (by Conor)
Patch 5:
- Dropped "select SIFIVE_CCACHE" in config SOC_STARFIVE. (by Conor)
- Dropped "starfive,jh7110-ccache" compatible in
  drivers/soc/sifive/sifive_ccache.c.
Patch 6:
- Removed all "clock-frequency = <0>". (by Conor)
- Sorted the nodes after their addresses. (by Emil)
- Renamed "clk_rtc" to "rtc_osc".
- Added "sifive,ccache0" compatible in the cache-controller node.
- Renamed "JH7110_SYSCLK_APB_BUS_FUNC" to "JH7110_SYSCLK_APB_BUS" and
  renamed "apb_bus_func" to "apb_bus".
  Renamed "JH7110_SYSCLK_IOMUX" to "JH7110_SYSCLK_IOMUX_APB".
  Renamed "JH7110_SYSRST_IOMUX" to "JH7110_SYSRST_IOMUX_APB".
  Renamed "JH7110_AONRST_AON_IOMUX" to "JH7110_AONRST_IOMUX".
- Removed "reg-names" in gpio nodes.
Patch 7:
- Corrected the board name to "VisionFive 2" instead of "VisionFive V2".
- Renamed jh7110-starfive-visionfive-v2.dts to
  jh7110-starfive-visionfive-2.dtsi.
- Added dts for VisionFive 2 version A and version B boards.
- In the chosen node, deleted "linux,initrd-start" and "linux,initrd-end"
  and changed the value of "stdout-path" to "serial0:115200n8".
- Changed the bias of uart0 "rx-pins" to
  "bias-disable; /* external pull-up */".
- Renamed "clk_rtc" to "rtc_osc".
- Moved the gpio node behind the uart0 node.

  v2: https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/

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
  dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive 2 board
  dt-bindings: timer: Add StarFive JH7110 clint
  dt-bindings: interrupt-controller: Add StarFive JH7110 plic
  dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
  soc: sifive: ccache: Add StarFive JH7110 support
  riscv: dts: starfive: Add initial StarFive JH7110 device tree
  riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
    tree

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../bindings/riscv/sifive,ccache0.yaml        |   9 +-
 .../devicetree/bindings/riscv/starfive.yaml   |   6 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 .../jh7110-starfive-visionfive-2-va.dts       |  13 +
 .../jh7110-starfive-visionfive-2-vb.dts       |  13 +
 .../jh7110-starfive-visionfive-2.dtsi         | 111 +++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 411 ++++++++++++++++++
 drivers/soc/Makefile                          |   2 +-
 drivers/soc/sifive/Kconfig                    |   2 +-
 11 files changed, 567 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
prerequisite-patch-id: 4dc515731ce237184553c1606ffb3afaeb51c3d8
prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
prerequisite-patch-id: a798370d170dc2bcc79ed86f741c21c1e6d87c78
prerequisite-patch-id: bd9fd8b5cb2376dc7a5e08e1a1fbb969cf475926
prerequisite-patch-id: c57ebb83bc43ccd2a8366ff166eb499da1e1d2cf
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: 94860423c7acc9025249d4bb36652a585bd0a797
prerequisite-patch-id: b5084253283929d9a6d0e66c350400c7c85d034d
prerequisite-patch-id: 6e369dbe9dca2785e4ea7d0b80e525e227a90a6e
prerequisite-patch-id: e08806183c152714c563f3a21c6d7b2f539c4d6e
prerequisite-patch-id: 79db8036abdc48fd36da227652ec62627a6b548b
prerequisite-patch-id: 06971b8e6bddc0e87e63bfdb0ce8bfb653bd73aa
prerequisite-patch-id: 16309a0e23811a2c55d2e56886de3e8eccc51554
prerequisite-patch-id: bf4f7ab0b6cfa90b6e49e66c7d75ed2eaaebbe78
prerequisite-patch-id: 38468d532e87867990055d3320679f18c5f52278
prerequisite-patch-id: 4710f2ac22dca0bdd9ff5d744d2c37cab3c74515
-- 
2.38.1

