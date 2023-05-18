Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780FA707DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjERKNI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 May 2023 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjERKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:12:44 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6D1BDA;
        Thu, 18 May 2023 03:12:42 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ABCAA24E212;
        Thu, 18 May 2023 18:12:35 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 18:12:35 +0800
Received: from localhost.localdomain (113.72.146.100) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 18:12:34 +0800
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
Subject: [PATCH v6 00/11] Add STG/ISP/VOUT clock and reset drivers for StarFive JH7110
Date:   Thu, 18 May 2023 18:12:23 +0800
Message-ID: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
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
Patch 9 adds pmu node for JH7110.
Patch 10 adds external clocks which ISP and VOUT clock driver need.
Patch 11 adds device node about STGCRG, ISPCRG and VOUTCRG to JH7110 dts.

Changes since v5:
- Rebased on the Linux 6.4-rc2.
- Modified the reset name about VOUTCRG to fix the error with
  CONFIG_FORTIFY_SOURCE=y
- Added the patch about pmu node.

v5: https://lore.kernel.org/all/20230424135409.6648-1-xingyu.wu@starfivetech.com/

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

Walker Chen (1):
  riscv: dts: starfive: jh7110: add pmu controller node

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
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  74 ++++++
 drivers/clk/starfive/Kconfig                  |  33 +++
 drivers/clk/starfive/Makefile                 |   3 +
 .../clk/starfive/clk-starfive-jh7110-isp.c    | 232 +++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-stg.c    | 173 +++++++++++++
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 239 ++++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh7110.h    |   6 +
 .../reset/starfive/reset-starfive-jh7110.c    |  30 +++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  74 ++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   |  60 +++++
 15 files changed, 1192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c

-- 
2.25.1

