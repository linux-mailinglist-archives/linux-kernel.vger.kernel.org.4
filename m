Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD266B9682
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjCNNkk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCNNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:40:21 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46343A9C;
        Tue, 14 Mar 2023 06:37:21 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 51E5924E1D3;
        Tue, 14 Mar 2023 20:44:06 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 20:44:06 +0800
Received: from localhost.localdomain (113.72.145.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 20:44:05 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 00/11] Add new partial clock and reset drivers for StarFive JH7110
Date:   Tue, 14 Mar 2023 20:43:53 +0800
Message-ID: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serises are to add new partial clock drivers and reset
supports about System-Top-Group(STG), Image-Signal-Process(ISP)
and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC.

Patches 1 to 3 are about the System-Top-Group clock and reset
generator(STGCRG) part.
The first patch adds docunmentation to describe STG bindings, and 
the second patch adds support about STG resets. The last patch adds
clock driver to support STG clocks for JH7110.

Patches 4 to 6 are about the Image-Signal-Process clock and reset
gennerator(ISPCRG) part.
The first patch adds docunmentation to describe ISP bindings, and 
the second patch adds support about ISP resets. The last patch adds
clock driver to support ISP clocks for JH7110.

Patches 7 to 9 are about the Video-Output clock and reset
generator(VOUTCRG) part.
The first patch adds docunmentation to describe VOUT bindings, and 
the second patch adds support about VOUT resets. The last patch adds
clock driver to support VOUT clocks for JH7110.

Patch 10 adds external clocks which ISP and VOUT clock driver need.
Patch 11 adds device node about STGCRG, ISPCRG and VOUTCRG to JH7110 dts.

Patches 2, 3, 5, 6, 8 and 9 are dependent on the patchset [1] which
is about JH71x0 clock and reset driver.
Patchdes 10 and 11 are dependent on the patchset [1] and [2] which is
about JH7110 device tree and PMU node.
This patchset should be applied after the patchset [1], [2]:
[1] https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfivetech.com/
[2] https://lore.kernel.org/all/20230116074259.22874-4-walker.chen@starfivetech.com/

Changes since v2:
Patch 1:
- Dropped the modification of maintainers.
- Modified clock and reset names in the dt-bindings header files.
Patch 3:
- Added 'Emil Renner Berthing' as the author.
- Used 'default m' in Kconfig file.
- Changed the flags of 'CLK_IGNORE_UNUSED' to 0 or 'CLK_IS_CRITICAL'.
Patch 4:
- Dropped the 'reset-names' property.
- Shortened the clock and reset names in the dt-bindings header files.
Pacth 6:
- Used 'default m' in Kconfig file.
- Changed the flags of 'CLK_IGNORE_UNUSED' to 0.
- Set reset_control struct to a local variable because it just is used
  one time in probe.
Pacth 7:
- Dropped the 'reset-names' property.
Patch 9:
- Used 'default m' in Kconfig file.
- Set reset_control struct to a local variable because it just is used
  one time in probe.
Patch 10:
- Changed the order of externel clock in alphanumerical order.
Patch 11:
- Dropped the 'reset-names' property in ispcrg and voutcrg node.

v2:https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/

Changes since v1:
- Modified the binding and dropped the indentation.
- Removed the useless header files in the drivers.
- Used an array lookup instead of a pile of conditions about parent
  clocks' name.
- Added clocks operation on driver remove.

v1: https://lore.kernel.org/all/20230120024445.244345-1-xingyu.wu@starfivetech.com/

Emil Renner Berthing (1):
  clk: starfive: Add StarFive JH7110 System-Top-Group clock driver

Xingyu Wu (10):
  dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and
    reset generator
  reset: starfive: jh7110: Add StarFive System-Top-Group reset support
  dt-bindings: clock: Add StarFive JH7110 Image-Signal-Process clock and
    reset generator
  reset: starfive: jh7110: Add StarFive Image-Signal-Process reset
    support
  clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
  dt-bindings: clock: Add StarFive JH7110 Video-Output clock and reset
    generator
  reset: starfive: jh7110: Add StarFive Video-Output reset support
  clk: starfive: Add StarFive JH7110 Video-Output clock driver
  riscv: dts: starfive: jh7110: Add DVP and HDMI TX pixel external
    clocks
  riscv: dts: starfive: jh7110: Add STGCRG/ISPCRG/VOUTCRG nodes

 .../clock/starfive,jh7110-ispcrg.yaml         |  87 +++++++
 .../clock/starfive,jh7110-stgcrg.yaml         |  82 ++++++
 .../clock/starfive,jh7110-voutcrg.yaml        |  90 +++++++
 .../jh7110-starfive-visionfive-2.dtsi         |   8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++++
 drivers/clk/starfive/Kconfig                  |  33 +++
 drivers/clk/starfive/Makefile                 |   3 +
 .../clk/starfive/clk-starfive-jh7110-isp.c    | 233 +++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-stg.c    | 176 +++++++++++++
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 240 ++++++++++++++++++
 .../reset/starfive/reset-starfive-jh7110.c    |  30 +++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  74 ++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   |  60 +++++
 13 files changed, 1183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c


base-commit: 8ca09d5fa3549d142c2080a72a4c70ce389163cd
prerequisite-patch-id: ebaead89601acf604e83224f4df8d57a7f4331b8
prerequisite-patch-id: 609d5d7c55b0b8e2967966673dab8f62a6fceab9
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: a4255724d4698f1238663443024de56de38d717b
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: dfb8d5a1fb262127d7a8e1ef3e97f455aaa19509
prerequisite-patch-id: 11b0f5746bbfbf8aa5c5746dcd7b0dce62e7f922
prerequisite-patch-id: 315303931e4b6499de7127a88113763f86e97e16
prerequisite-patch-id: 40cb8212ddb024c20593f73d8b87d9894877e172
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: 189a0f41ba4eecd4f3f35c503baac8aed8ccd7de
prerequisite-patch-id: 1117ecaa40a353c667b71802ab34ecf9568d8bb2
prerequisite-patch-id: 25923a0c77e92631ed3cd8a163d789daad35f0f8
prerequisite-patch-id: 6a6f6215f09932e68fdfd294df2e813ec9d2481f
prerequisite-patch-id: 2cc95b47cad25fd9b875d27f4e8e3d84eb70274b
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 0a0ac5a8a90655b415f6b62e324f3db083cdaaee
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
-- 
2.25.1

