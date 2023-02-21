Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB869DC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjBUId4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 03:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjBUIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:33:42 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB59746;
        Tue, 21 Feb 2023 00:33:36 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BBA1C24E350;
        Tue, 21 Feb 2023 16:33:29 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:29 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:28 +0800
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
Subject: [PATCH v2 00/11] Add new partial clock and reset drivers for StarFive JH7110
Date:   Tue, 21 Feb 2023 16:33:12 +0800
Message-ID: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
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
JH7110 PMU driver(Accpeted).
Patchdes 10 and 11 are dependent on the patchset [1] and [3] which is
about JH7110 device tree and PMU node.
This patchset should be applied after the patchset [1], [2], [3]:
[1] https://lore.kernel.org/all/20230221024645.127922-1-hal.feng@starfivetech.com/
[2] https://lore.kernel.org/all/20230119094447.21939-3-walker.chen@starfivetech.com/
[3] https://lore.kernel.org/all/20230116074259.22874-4-walker.chen@starfivetech.com/

Changes since v1:
- Modified the binding and dropped the indentation.
- Removed the useless header files in the drivers.
- Used an array lookup instead of a pile of conditions about parent
  clocks' name.
- Added clocks operation on driver remove.

v1: https://lore.kernel.org/all/20230120024445.244345-1-xingyu.wu@starfivetech.com/

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

 .../clock/starfive,jh7110-ispcrg.yaml         |  97 +++++++
 .../clock/starfive,jh7110-stgcrg.yaml         |  82 ++++++
 .../clock/starfive,jh7110-voutcrg.yaml        |  96 +++++++
 MAINTAINERS                                   |   1 +
 .../jh7110-starfive-visionfive-2.dtsi         |   8 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  71 +++++
 drivers/clk/starfive/Kconfig                  |  33 +++
 drivers/clk/starfive/Makefile                 |   3 +
 .../clk/starfive/clk-starfive-jh7110-isp.c    | 254 +++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-stg.c    | 176 ++++++++++++
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 261 ++++++++++++++++++
 .../reset/starfive/reset-starfive-jh7110.c    |  30 ++
 .../dt-bindings/clock/starfive,jh7110-crg.h   |  74 +++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   |  60 ++++
 14 files changed, 1246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
prerequisite-patch-id: 4dc515731ce237184553c1606ffb3afaeb51c3d8
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: a4255724d4698f1238663443024de56de38d717b
prerequisite-patch-id: a798370d170dc2bcc79ed86f741c21c1e6d87c78
prerequisite-patch-id: 203d2500cadc112bd20fefc56eabf1470d3d2d2d
prerequisite-patch-id: 315303931e4b6499de7127a88113763f86e97e16
prerequisite-patch-id: 40cb8212ddb024c20593f73d8b87d9894877e172
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: 94860423c7acc9025249d4bb36652a585bd0a797
prerequisite-patch-id: b5084253283929d9a6d0e66c350400c7c85d034d
prerequisite-patch-id: a428ed7a2aa45abab86923dc467e1e6b08427e85
prerequisite-patch-id: d4f80829fca7ce370a6fad766593cdcb502fa245
prerequisite-patch-id: e3490e19e089fe284334db300ee189b619a61628
prerequisite-patch-id: 34298e3882261bc2d72955b1570cc9612ab7d662
prerequisite-patch-id: 377c5c282a0776feee9acd10b565adbd5275a67e
prerequisite-patch-id: 3ccee718de0750adbf8d0b77d553a2778a344f64
prerequisite-patch-id: 4710f2ac22dca0bdd9ff5d744d2c37cab3c74515
prerequisite-patch-id: 65f2aed865d88e6fa468d2923527b523d4313857
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: a2b3a9cff8a683422eb0ccf3a0850091401812d4
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: ea9a6d0313dd3936c8de0239dc2072c3360a2f6b
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 29aab7148bf56a20acddcb8a11f290705fcc97f6
prerequisite-patch-id: eeecb5367bea99627210b661986ca5b49e2a9d63
prerequisite-patch-id: c02658f677990683d4c4957e06c19ed3a3a0cfab
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
-- 
2.25.1

