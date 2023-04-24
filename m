Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8466ECFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjDXNzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjDXNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:54:31 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294387D84;
        Mon, 24 Apr 2023 06:54:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 421A224E023;
        Mon, 24 Apr 2023 21:54:16 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 21:54:16 +0800
Received: from localhost.localdomain (113.72.145.137) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 21:54:14 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v5 00/10] Add STG/ISP/VOUT clock and reset drivers for StarFive JH7110
Date:   Mon, 24 Apr 2023 21:53:59 +0800
Message-ID: <20230424135409.6648-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serises are base on the basic JH7110 SYSCRG/AONCRG
drivers and add new partial clock drivers and reset supports
about System-Top-Group(STG), Image-Signal-Process(ISP)
and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
clocks and resets could be used by DMA, VIN and Display modules.

Patches 1 and 2 are about the System-Top-Group clock and reset
generator(STGCRG) part. The first patch adds docunmentation to
describe STG bindings, and the second patch adds clock driver to
support STG clocks and resets as auxiliary device for JH7110.

Patches 3 and 4 are about the Image-Signal-Process clock and reset
gennerator(ISPCRG) part. The first patch adds docunmentation to
describe ISP bindings, and the second patch adds clock driver to
support ISP clocks and resets as auxiliary device for JH7110.
And ISP clocks should power on and enable the SYSCRG clocks first
before registering.

Patches 5 and 6 are about the Video-Output clock and reset
generator(VOUTCRG) part. The first patch adds docunmentation to
describe VOUT bindings, and the second patch adds clock driver to
support VOUT clocks and resets as auxiliary device for JH7110.
And VOUT clocks also should power on and enable the SYSCRG clocks
first before registering.

Patch 7 adds the maintainer who take charge of the STGCRG/ISPCRG/VOUTCRG
for JH7110.
Patch 8 adds struct members to support STG/ISP/VOUT resets.
Patch 9 adds external clocks which ISP and VOUT clock driver need.
Patch 10 adds device node about STGCRG, ISPCRG and VOUTCRG to JH7110 dts.

Patches 2, 4, 6, 7 and 8 are dependent on the patchset [1] which
is about JH71x0 clock and reset driver, and the patches [2][3][4]
are complementary to the basic drivers.
Patchdes 9 and 10 are dependent on the patchset [1] and [5] which is
about JH7110 device tree and PMU node.

This patchset should be applied after their patchset:
[1] https://lore.kernel.org/all/20230401111934.130844-1-hal.feng@starfivetech.com/
[2] https://lore.kernel.org/all/20230413205528.4044216-1-sboyd@kernel.org/
[3] https://lore.kernel.org/all/20230417074115.30786-3-hal.feng@starfivetech.com/
[4] https://lore.kernel.org/all/20230418123756.62495-2-hal.feng@starfivetech.com/
[5] https://lore.kernel.org/all/20230116074259.22874-4-walker.chen@starfivetech.com/

Changes since v4:
- Rebased on the lastest patches about fixing the basic clock and reset drivers.
- Dropped the 'dev_set_drvdata()' in STG clock driver.
- Modified the data with 'dev_set_drvdata()' in ISP/VOUT clock driver
  and move the struct about the data to JH7110 header file, which both
  ISP and VOUT clock drivers will use.

v4: https://lore.kernel.org/all/20230411135558.44282-1-xingyu.wu@starfivetech.com/

Changes since v3: 
- Rebased on the lastest JH71X0 clock and reset driver of patchset[1]
  and modified the parameters of the register reset functions.
- The patch 1 combined three commits on STG/ISP/VOUT resets into one.
  And Changed the auxiliary_device_id name from
  "clk_starfive_jh71x0.reset-*" to "clk_starfive_jh7110_sys.rst-*".
- Added a maintainer in STARFIVE JH71X0 CLOCK DRIVERS.

v3: https://lore.kernel.org/all/20230314124404.117592-1-xingyu.wu@starfivetech.com/

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

v2: https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/

Changes since v1:
- Modified the binding and dropped the indentation.
- Removed the useless header files in the drivers.
- Used an array lookup instead of a pile of conditions about parent
  clocks' name.
- Added clocks operation on driver remove.

v1: https://lore.kernel.org/all/20230120024445.244345-1-xingyu.wu@starfivetech.com/

Emil Renner Berthing (1):
  clk: starfive: Add StarFive JH7110 System-Top-Group clock driver

Xingyu Wu (9):
  dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and
    reset generator
  dt-bindings: clock: Add StarFive JH7110 Image-Signal-Process clock and
    reset generator
  clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
  dt-bindings: clock: Add StarFive JH7110 Video-Output clock and reset
    generator
  clk: starfive: Add StarFive JH7110 Video-Output clock driver
  MAINTAINERS: Update maintainer of JH71x0 clock drivers
  reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support
  riscv: dts: starfive: jh7110: Add DVP and HDMI TX pixel external
    clocks
  riscv: dts: starfive: jh7110: Add STGCRG/ISPCRG/VOUTCRG nodes

 .../clock/starfive,jh7110-ispcrg.yaml         |  87 +++++++
 .../clock/starfive,jh7110-stgcrg.yaml         |  82 ++++++
 .../clock/starfive,jh7110-voutcrg.yaml        |  90 +++++++
 MAINTAINERS                                   |   1 +
 .../jh7110-starfive-visionfive-2.dtsi         |   8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++++
 drivers/clk/starfive/Kconfig                  |  33 +++
 drivers/clk/starfive/Makefile                 |   3 +
 .../clk/starfive/clk-starfive-jh7110-isp.c    | 232 +++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-stg.c    | 173 +++++++++++++
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 239 ++++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh7110.h    |   6 +
 .../reset/starfive/reset-starfive-jh7110.c    |  30 +++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  74 ++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   |  60 +++++
 15 files changed, 1185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c


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
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: 9007c8610fdcd387592475949864edde874c20a2
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 0a0ac5a8a90655b415f6b62e324f3db083cdaaee
prerequisite-patch-id: 1387a7e87b446329dfc21f3e575ceae7ebcf954c
prerequisite-patch-id: f6c6ca1490a996ef0183bb92e66ed4f8744ae28d
prerequisite-patch-id: 905cffb08818b964b9cdc52f2ab5ab12c93fb553
prerequisite-patch-id: fdb2280da77e8d8c22e37b8f44d8e34311217127
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
-- 
2.25.1

