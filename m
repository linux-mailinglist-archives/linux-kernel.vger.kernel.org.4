Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514CF674972
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjATCoz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 21:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATCox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:44:53 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4587A19A4;
        Thu, 19 Jan 2023 18:44:48 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 937AC24E00A;
        Fri, 20 Jan 2023 10:44:46 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Jan
 2023 10:44:46 +0800
Received: from localhost.localdomain (113.72.144.40) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Jan
 2023 10:44:45 +0800
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
Subject: [PATCH v1 00/11] Add new partial clock and reset drivers for StarFive JH7110
Date:   Fri, 20 Jan 2023 10:44:34 +0800
Message-ID: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.40]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Patches 6 and 9 also are dependent on the patchset [2] which is about
JH7110 pmu driver.
Patchdes 10 and 11 are dependent on the patchset [3] which is about
JH7110 device tree.
This patchset should be applied after the patchset [1], [2], [3]:
[1] https://lore.kernel.org/all/20221220005054.34518-1-hal.feng@starfivetech.com/
[2] https://lore.kernel.org/all/20230119094447.21939-1-walker.chen@starfivetech.com/
[3] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/

Xingyu Wu (11):
  dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and
    reset generator
  reset: starfive: jh7110: Add StarFive System-Top-Group reset support
  clk: starfive: Add StarFive JH7110 System-Top-Group clock driver
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

 .../clock/starfive,jh7110-ispcrg.yaml         |  97 ++++++++
 .../clock/starfive,jh7110-stgcrg.yaml         |  82 +++++++
 .../clock/starfive,jh7110-voutcrg.yaml        |  96 ++++++++
 MAINTAINERS                                   |   2 +
 .../jh7110-starfive-visionfive-2.dtsi         |   8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  69 ++++++
 drivers/clk/starfive/Kconfig                  |  33 +++
 drivers/clk/starfive/Makefile                 |   3 +
 .../clk/starfive/clk-starfive-jh7110-isp.c    | 218 +++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-stg.c    | 180 ++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 227 ++++++++++++++++++
 .../reset/starfive/reset-starfive-jh7110.c    |  30 +++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  74 ++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   |  60 +++++
 14 files changed, 1179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c


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
prerequisite-patch-id: 6bb9a780c62af3bcc2368dfd20303c7b1bc91e23
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: a2b3a9cff8a683422eb0ccf3a0850091401812d4
prerequisite-patch-id: e0ba7af0f8d3d41844da9fbcba14b548cbc18f55
prerequisite-patch-id: bc0176325c11a632c6abaa83e54e891cc92d1c74
prerequisite-patch-id: bd3076c3fde77b417bc5b402b97563f2928d623d
prerequisite-patch-id: 795c5ea9868c12fd62c14220140f0706f3db66ce
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
-- 
2.25.1

