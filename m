Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95446D2FF0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDALT5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Apr 2023 07:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDALTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:19:48 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D761CBAE;
        Sat,  1 Apr 2023 04:19:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D839324E0F6;
        Sat,  1 Apr 2023 19:19:37 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:37 +0800
Received: from ubuntu.localdomain (113.72.144.76) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:36 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 00/22] Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC
Date:   Sat, 1 Apr 2023 19:19:12 +0800
Message-ID: <20230401111934.130844-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds basic clock, reset & DT support for StarFive
JH7110 SoC.

@Stephen and @Conor, I have made this series start with the shared
dt-bindings, so it will be easier to merge.

@Conor, patch 1, 2, 16~21 were already in your branch. Patch 22 is the
same with the patch [1] I submitted before, which you had accepted but
not merge it into your branch.

You can simply review or test the patches at the link [2]. Hope this
series will be merged soon.

[1]: https://lore.kernel.org/all/20230324064651.84670-1-hal.feng@starfivetech.com/
[2]: https://github.com/hal-feng/linux/commits/visionfive2-minimal

Changes since v6:
- Rebased on v6.3-rc4.
- Made the dt-bindings patches (patch 11, 12) be the first two patches.
  Merged all maintainers changes into the first dt-bindings patch.
Patch 13:
- Moved the reset related functions from clk-starfive-jh71x0.c to
  clk-starfive-jh7110-sys.c.
- Moved the declaration of jh7110_reset_controller_register() to a new
  header clk-starfive-jh7110.h.
- Dropped the include <linux/clk.h> and added <linux/auxiliary_bus.h>.
- Included "clk-starfive-jh7110.h" instead of "clk-starfive-jh71x0.h".
- Set the qspi clock flags as 0.
- Set the flag of clock gmac?_gtxc as 0 and added CLK_SET_RATE_NO_REPARENT
  flag for the clock gmac1_tx.
- Removed the PLL clock return in jh7110_sysclk_get().
- Used "else" instead of "else if (pidx >= JH7110_SYSCLK_PLL0_OUT && \
  pidx <= JH7110_SYSCLK_PLL2_OUT)".
- Renamed the reset aux device name from "reset-sys" to "rst-sys"
  avoiding exceeding the maximum length of auxiliary_device_id name.
Patch 14:
- Dropped the include <linux/clk.h>
- Included "clk-starfive-jh7110.h" instead of "clk-starfive-jh71x0.h".
- Added CLK_SET_RATE_NO_REPARENT flag for the clock gmac0_tx.
- Renamed the reset aux device name from "reset-aon" to "rst-aon".
Patch 15:
- Changed the auxiliary_device_id name from
  "clk_starfive_jh71x0.reset-*" to "clk_starfive_jh7110_sys.rst-*".

  v6: https://lore.kernel.org/all/20230320103750.60295-1-hal.feng@starfivetech.com/

Changes since v5:
- Rebased on v6.3-rc3.
Patch 1:
- Set obj-y for starfive/ in drivers/clk/Makefile.
Patch 2:
- Sorted the StarFive entries alphabetically in MAINTAINERS.
Patch 3:
- Fixed the build error which caused by renaming the header without
  changing the users of the header.
Patch 4:
- Fixed the errors reported by checkpatch.pl.
Patch 6:
- Set obj-y for starfive/ in drivers/reset/Makefile.
Patch 13:
- Set the timer clock flags as 0.

  v5: https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfivetech.com/

Changes since v4:
- Rebased on v6.3-rc1.
- Added two patches to replace SOC_STARFIVE with ARCH_STARFIVE.
- Added Tested-by tag for Tommaso.
Patch 9:
- Set GMAC1 related clocks as optional inputs.
- Dropped PLL clock definitions.
Patch 10:
- Set GMAC0 related clocks and RTC oscillator as optional inputs.
- Sorted the clocks.
Patch 11:
- Replaced SOC_STARFIVE with ARCH_STARFIVE.
- Added macros for PLL clocks and adjusted the code properly to
  make it easier to add the PLL clock driver later.
- Updated the clock flags.
Patch 12:
- Built as a module by default.
- Sorted the clocks.
- Updated the clock flags.
Patch 13:
- Replaced "default CLK_STARFIVE_JH7110_SYS" with "default ARCH_STARFIVE".
- Renamed "reset_info" struct to "jh7110_reset_info" and moved its
  definition into the driver.
- Put jh7110_sys_info and jh7110_sys_info before the probe().
Patch 17:
- Dropped "_zicsr" in ISA.
- Sorted the external clocks alphabetically.
- Put the ccache node before the plic node according to their addresses.
- Sorted the clock inputs of the aoncrg node.
Patch 19:
- Replaced SOC_STARFIVE with ARCH_STARFIVE.
- Sorted the nodes alphabetically.

  v4: https://lore.kernel.org/all/20230221024645.127922-1-hal.feng@starfivetech.com/

Changes since v3:
- Suggested by Conor, Merged clock & reset series and DT series together
  so that they could go via the same tree as the dt-binding headers are
  required by both driver & devicetree.
- Rebased on tag v6.2.

[Clock & reset]
Patch 2:
- Split patch 2 into two. One for renaming file and one for renaming
  variables. (by Conor)
Patch 4:
- Split patch 4 into two. One for code movement and one for
  extraction. (by Conor)
Patch 5 & 9 & 10 & 11:
- Fixed the issues reported by kernel test robot.
Patch 9:
- Set (&priv->base) as driver data instead of (priv->base).
- Set the frequency of clock PLL0 as 1000MHz for Synchronizing with the
  lastest u-boot setting from StarFive. (by Emil)
- Used devm_kzalloc() instead of kzalloc() when registering aux device.
Patch 10:
- Set (&priv->base) as driver data instead of (priv->base).
Patch 11:
- Used (*base) to get the register base address instead of (base).

[Device tree]
- Dropped patch 1, 4, 5 because they were accepted.
- Added a new patch to add SiFive S7 compatible. (by Conor)
- Added a new patch to add JH7110 pin function definitions.
Patch 6:
- Changed the label "S76_0" to "S7_0" and used compatible "sifive,s7"
  for core 0.
- Updated ISA of each cores. (by Conor)
- Made the node names generic. (by Krzysztof)
- Added clock-output-names for all external clocks.
- Added i2c0~6 nodes.
- Changed the node name "gpio" to "pinctrl". Changed the label "gpio"
  and "gpioa" to "sysgpio" and "aongpio". (by Conor)
Patch 7:
- Separated the long lines into more lines in Makefile. (by Conor)
- Renamed jh7110-starfive-visionfive-2-va.dts and
  jh7110-starfive-visionfive-2-vb.dts to
  jh7110-starfive-visionfive-2-v1.2a.dts and
  jh7110-starfive-visionfive-2-v1.3b.dts.
  Changed the model and compatible to match v1.2A and v1.3B which
  are printed on the silkscreen of VisionFive 2 board. (by Emil)
- Configured pins for i2c0/2/5/6 and enabled them.

  clock & reset v3: https://lore.kernel.org/all/20221220005054.34518-1-hal.feng@starfivetech.com/
  DT v3: https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/

Changes since v2:
[Clock & reset]
- Rebased on tag v6.1.
- Added "JH71X0" to the StarFive driver headers in MAINTAINERS.
- Removed Co-developed-by tag of Hal in patch 1 and patch 4.
- Changed the commit author from Hal to Emil in patch 2 and patch 5.
  Removed Co-developed-by tag of Emil in patch 2 and patch 5. (by Emil)
- Improved the coding style of patch 11, 12 and 13.
- Dropped patch 14. (by Emil)
Patch 4:
- Passed the "owner" member of reset_controller_dev structure
  directly in reset_starfive_jh7100_register(). (by Emil)
- Added MAINTAINERS changes.
Patch 7:
- Split patch 7 into sys part and aon part. Merged them into patch 9 and
  patch 10 respectively. (by Krzysztof)
- Renamed include/dt-bindings/clock/starfive-jh7110.h to
  include/dt-bindings/clock/starfive,jh7110-crg.h. (by Krzysztof)
- Synchronized the definitions with the latest changes from Emil.
Patch 8:
- Split patch 8 into sys part and aon part. Merged them into patch 9 and
  patch 10 respectively. (by Krzysztof)
- Renamed include/dt-bindings/reset/starfive-jh7110.h to
  include/dt-bindings/reset/starfive,jh7110-crg.h. (by Krzysztof)
- Fixed the date of Copyright. (by Emil)
- Dropped weird indentations. (by Krzysztof)
- Synchronized the definitions with the latest changes from Emil.
Patch 9:
- Improved the description of clocks. (by Emil and Krzysztof)
- Added MAINTAINERS changes.
Patch 10:
- Improved the description of clocks. (by Emil and Krzysztof)
- Changed the clock-name "clk_rtc" to "rtc_osc" and  "apb_bus_func" to
  "apb_bus".
Patch 11:
- Removed the flags of trace/debug clocks and set the flags of core clocks
  as CLK_IS_CRITICAL. (by Emil)
- Deleted the extra 1-1 clocks and synchronized the clock tree with the
  latest changes from Emil. (by Emil)
- Selected RESET_STARFIVE_JH7110 in Kconfig option CLK_STARFIVE_JH7110_SYS.
Patch 12:
- Changed the macro JH7110_AONCLK_RTC to JH7110_AONCLK_RTC_OSC and
  JH7110_AONCLK_APB_BUS_FUNC to JH7110_AONCLK_APB_BUS.
- Synchronized the clock tree with the latest changes from Emil.
- Set the MODULE_LICENSE as "GPL" according to commit bf7fbeeae6db.
Patch 13:
- Removed the "asserted" member in reset_info structure and always pass
  NULL when calling reset_starfive_jh71x0_register(). (by Emil)

[Device tree]
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

  clock & reset v2: https://lore.kernel.org/all/20221118010627.70576-1-hal.feng@starfivetech.com/
  DT v2: https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/

Changes since v1:
[Clock & reset]
- Rebased on tag v6.1-rc5.
- Rewrote the clock and reset drivers using auxiliary bus framework, so
  patch 8, 9, 15 were dropped and all patches changed a lot. (by Stephen)
- Split Patch 14 into two patches. One is for factoring out the common
  JH71X0 code, the another one is for renaming. (by Stephen)
- Created a subdirectory for StarFive reset drivers.
- Factored out common JH71X0 reset code.
- Renamed the common clock and reset code from "*starfive*" or
  "*STARFIVE*" to "*jh71x0*" or "*JH71X0*".
- Combined JH7110 system and always-on clock DT binding headers in one
  file named "include/dt-bindings/clock/starfive-jh7110.h".
- Renamed clock definitions "JH7110_SYSCLK_PCLK2_MUX_FUNC_PCLK" and
  "JH7110_SYSCLK_U2_PCLK_MUX_PCLK" to "JH7110_SYSCLK_PCLK2_MUX_FUNC" and
  "JH7110_SYSCLK_PCLK2_MUX".
- Rewrote the DT bindings of clock and reset for using auxiliary bus.
- Registered an auxiliary device for reset controller in clock drivers.
- Changed clock names "CODAJ*" and "WAVE*" to "codaj*" and "wave*".
  Changed clock names "u2_pclk_mux_func_pclk" and "u2_pclk_mux_pclk" to
  "pclk2_mux_func" and "pclk2_mux".
- Changed the flags of clock apb0 and noc_bus_isp_axi to CLK_IS_CRITICAL
  as suggested by StarFive SDK group.
- Registered clock gmac0_gtxc as a gate clock instead of a div clock
  as suggested by StarFive SDK group.
- Changed the frequency of clock pll2_out to 1188MHz as suggested by
  StarFive SDK group.
- Fixed the bug that the clock JH7110_AONCLK_GMAC0_GTXCLK was not handled
  in JH7110 always-on clock driver.
- Registered the reset driver as an auxiliary driver.
- Reworded the commit messages.

[Device tree]
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

Emil Renner Berthing (16):
  dt-bindings: clock: Add StarFive JH7110 system clock and reset
    generator
  dt-bindings: clock: Add StarFive JH7110 always-on clock and reset
    generator
  clk: starfive: Factor out common JH7100 and JH7110 code
  clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
  clk: starfive: Rename "jh7100" to "jh71x0" for the common code
  reset: Create subdirectory for StarFive drivers
  reset: starfive: Factor out common JH71X0 reset code
  reset: starfive: Extract the common JH71X0 reset code
  reset: starfive: Rename "jh7100" to "jh71x0" for the common code
  reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
  clk: starfive: Add StarFive JH7110 system clock driver
  clk: starfive: Add StarFive JH7110 always-on clock driver
  dt-bindings: timer: Add StarFive JH7110 clint
  dt-bindings: interrupt-controller: Add StarFive JH7110 plic
  riscv: dts: starfive: Add initial StarFive JH7110 device tree
  riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
    tree

Hal Feng (5):
  clk: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
  reset: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
  reset: starfive: Add StarFive JH7110 reset driver
  dt-bindings: riscv: Add SiFive S7 compatible
  riscv: dts: starfive: jh7110: Correct the properties of S7 core

Jianlong Huang (1):
  riscv: dts: starfive: Add StarFive JH7110 pin function definitions

 .../clock/starfive,jh7110-aoncrg.yaml         | 107 +++
 .../clock/starfive,jh7110-syscrg.yaml         | 104 +++
 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 MAINTAINERS                                   |  16 +-
 arch/riscv/boot/dts/starfive/Makefile         |   6 +-
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 308 ++++++++
 .../jh7110-starfive-visionfive-2-v1.2a.dts    |  13 +
 .../jh7110-starfive-visionfive-2-v1.3b.dts    |  13 +
 .../jh7110-starfive-visionfive-2.dtsi         | 215 ++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 500 ++++++++++++
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/starfive/Kconfig                  |  33 +-
 drivers/clk/starfive/Makefile                 |   6 +-
 .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 +-
 drivers/clk/starfive/clk-starfive-jh7100.c    | 716 +++++-------------
 drivers/clk/starfive/clk-starfive-jh7100.h    | 112 ---
 .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 490 ++++++++++++
 drivers/clk/starfive/clk-starfive-jh7110.h    |  11 +
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 333 ++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 123 +++
 drivers/reset/Kconfig                         |   8 +-
 drivers/reset/Makefile                        |   2 +-
 drivers/reset/reset-starfive-jh7100.c         | 173 -----
 drivers/reset/starfive/Kconfig                |  20 +
 drivers/reset/starfive/Makefile               |   5 +
 .../reset/starfive/reset-starfive-jh7100.c    |  74 ++
 .../reset/starfive/reset-starfive-jh7110.c    |  70 ++
 .../reset/starfive/reset-starfive-jh71x0.c    | 131 ++++
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 +
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 221 ++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 154 ++++
 34 files changed, 3351 insertions(+), 862 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 delete mode 100644 drivers/reset/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/Kconfig
 create mode 100644 drivers/reset/starfive/Makefile
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
-- 
2.38.1

