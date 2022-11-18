Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9786162EB15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiKRBhJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbiKRBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:36:43 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03B6379;
        Thu, 17 Nov 2022 17:36:12 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7FF0024E020;
        Fri, 18 Nov 2022 09:06:29 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:29 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:28 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/14] Basic clock and reset support for StarFive JH7110 RISC-V SoC
Date:   Fri, 18 Nov 2022 09:06:13 +0800
Message-ID: <20221118010627.70576-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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
only if all these patches series applied. This one adds basic clock&reset
support. This patch series is pulled out from the patch 7~21 of v1 [1].
You can simply get or review the patches at the link [2].

[1]: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/
[2]: https://github.com/hal-feng/linux/commits/visionfive2-minimal

Changes since v1:
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

  v1: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/

Emil Renner Berthing (10):
  clk: starfive: Factor out common JH7100 and JH7110 code
  reset: Create subdirectory for StarFive drivers
  reset: starfive: Factor out common JH71X0 reset code
  reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
  dt-bindings: clock: Add StarFive JH7110 system and always-on clock
    definitions
  dt-bindings: reset: Add StarFive JH7110 system and always-on reset
    definitions
  dt-bindings: clock: Add StarFive JH7110 system clock and reset
    generator
  dt-bindings: clock: Add StarFive JH7110 always-on clock and reset
    generator
  clk: starfive: Add StarFive JH7110 system clock driver
  clk: starfive: Add StarFive JH7110 always-on clock driver

Hal Feng (4):
  clk: starfive: Rename "jh7100" to "jh71x0" for the common code
  reset: starfive: Rename "jh7100" to "jh71x0" for the common code
  reset: starfive: Add StarFive JH7110 reset driver
  clk: starfive: jh71x0: Don't register aux devices if JH7110 reset is
    disabled

 .../clock/starfive,jh7110-aoncrg.yaml         |  76 ++
 .../clock/starfive,jh7110-syscrg.yaml         |  80 ++
 MAINTAINERS                                   |  16 +-
 drivers/clk/starfive/Kconfig                  |  25 +
 drivers/clk/starfive/Makefile                 |   6 +-
 .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 +-
 drivers/clk/starfive/clk-starfive-jh7100.c    | 713 +++++-------------
 drivers/clk/starfive/clk-starfive-jh7100.h    | 112 ---
 .../clk/starfive/clk-starfive-jh7110-aon.c    | 165 ++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 650 ++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 396 ++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 122 +++
 drivers/reset/Kconfig                         |   8 +-
 drivers/reset/Makefile                        |   2 +-
 drivers/reset/reset-starfive-jh7100.c         | 173 -----
 drivers/reset/starfive/Kconfig                |  20 +
 drivers/reset/starfive/Makefile               |   5 +
 .../reset/starfive/reset-starfive-jh7100.c    |  74 ++
 .../reset/starfive/reset-starfive-jh7110.c    |  67 ++
 .../reset/starfive/reset-starfive-jh71x0.c    | 130 ++++
 .../reset/starfive/reset-starfive-jh71x0.h    |  21 +
 include/dt-bindings/clock/starfive-jh7110.h   | 234 ++++++
 include/dt-bindings/reset/starfive-jh7110.h   | 154 ++++
 23 files changed, 2466 insertions(+), 857 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 delete mode 100644 drivers/reset/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/Kconfig
 create mode 100644 drivers/reset/starfive/Makefile
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 include/dt-bindings/clock/starfive-jh7110.h
 create mode 100644 include/dt-bindings/reset/starfive-jh7110.h


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
-- 
2.38.1

