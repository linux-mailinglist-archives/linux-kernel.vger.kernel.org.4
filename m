Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C34689B73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjBCOTH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Feb 2023 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBCOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:18:24 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE61CAD0;
        Fri,  3 Feb 2023 06:18:07 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EE43E24E020;
        Fri,  3 Feb 2023 22:18:03 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 22:18:04 +0800
Received: from ubuntu.localdomain (113.72.144.84) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 22:18:02 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] Basic pinctrl support for StarFive JH7110 RISC-V SoC
Date:   Fri, 3 Feb 2023 22:17:57 +0800
Message-ID: <20230203141801.59083-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.84]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds basic pinctrl support for StarFive JH7110 SoC.

Changes since v3:
- Rebased on Linus's "devel" branch of linux-pinctrl repo, which was based on
  on tag v6.2-rc1.
- Dropped patch 1.
Patch 2 & 3:
- Added a reference for '-pins$' patternProperties.
- Put "additionalProperties: false" before properties section. (by Rob)
- Improved the description.
- Changed the node name in examples from "gpio" to "pinctrl".
Patch 4:
- Added some missing headers. (by Andreas)

  v3: https://lore.kernel.org/all/20221220005529.34744-1-hal.feng@starfivetech.com/

Changes since v2:
- Rebased on tag v6.1.
Patch 1:
- Renamed pinctrl-starfive-jh7110.h to
  starfive,jh7110-pinctrl.h. (by Krzysztof)
- Separated the register values in the binding header and stored them in
  a new file arch/riscv/boot/dts/starfive/jh7110-pinfunc.h. (by Krzysztof)
- Split patch 1 into sys part and aon part. Merged them into patch 2
  and patch 3 respectively.
Patch 2 & 3:
- Dropped "reg-names" and the description of "interrupts". Dropped quotes
  behind "$ref" and kept consisitent quotes. (by Krzysztof)
- Moved gpio properties behind interrupt properties.
- Moved "required" behind "patternProperties". (by Krzysztof)
- Rewrote the examples of bindings. (by Krzysztof and Emil)
- Added Co-developed-by tag for Emil.
- Dropped unused "clocks" property in patch 3.
Patch 4 & 5:
- Renamed "pinctrl-starfive.*" to "pinctrl-starfive-jh7110.*" and replaced
  all "starfive_" prefix with "jh7110_" in these files. (by Emil)
- Dropped macro GPIO_NUM_PER_WORD. (by Emil)
- Dropped unused flag member in starfive_pinctrl_soc_info structure. (by Emil)
- Renamed "pinctrl-jh7110-sys.c" to "pinctrl-starfive-jh7110-sys.c".
  Renamed "pinctrl-jh7110-aon.c" to "pinctrl-starfive-jh7110-aon.c". (by Emil)
- Added individual Kconfig options for sys and aon pinctrl drivers. (by Emil)
- Made the sys and aon pinctrl drivers be modules. (by Emil)
- Added "JH7110_" prefix for macro SYS_GPO_PDA_0_74_CFG,
  SYS_GPO_PDA_89_94_CFG and AON_GPO_PDA_0_5_CFG. (by Emil)
- Dropped jh7110_sys_pinctrl_probe() and jh7110_aon_pinctrl_probe().
  Got the match data in the common jh7110_pinctrl_probe() and used it
  to probe. (by Emil)
- Dropped the of_match_ptr macro(). (by Emil)
- Set the MODULE_LICENSE as "GPL" according to commit bf7fbeeae6db.

  v2: https://lore.kernel.org/all/20221118011108.70715-1-hal.feng@starfivetech.com/

Changes since v1:
- Rebased on tag v6.1-rc5.
- Dropped patch 22 and 23 since they were merged in v6.1-rc1.
- Removed some unused macros and register values which do not belong to
  bindings. Simplified pinctrl definitions in patch 24. (by Krzysztof)
- Split the bindings into sys pinctrl bindings and aon pinctrl bindings,
  and split patch 25 into two patches.
- Made the bindings follow generic pinctrl bindings. (by Krzysztof)
- Fixed some wrong indentation in bindings, and checked it with
  `make dt_binding_check`.
- Split the patch 26 into two patches which added sys and aon pinctrl
  driver respectively.
- Restructured the pinctrl drivers so made them follow generic pinctrl
  bindings. Rewrote `dt_node_to_map` and extracted the public code to make
  it clearer.

  v1: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/

Jianlong Huang (4):
  dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl
  dt-bindings: pinctrl: Add StarFive JH7110 aon pinctrl
  pinctrl: starfive: Add StarFive JH7110 sys controller driver
  pinctrl: starfive: Add StarFive JH7110 aon controller driver

 .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 123 +++
 .../pinctrl/starfive,jh7110-sys-pinctrl.yaml  | 141 +++
 MAINTAINERS                                   |   8 +-
 drivers/pinctrl/starfive/Kconfig              |  33 +
 drivers/pinctrl/starfive/Makefile             |   4 +
 .../starfive/pinctrl-starfive-jh7110-aon.c    | 177 ++++
 .../starfive/pinctrl-starfive-jh7110-sys.c    | 449 ++++++++
 .../starfive/pinctrl-starfive-jh7110.c        | 982 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh7110.h        |  70 ++
 .../pinctrl/starfive,jh7110-pinctrl.h         | 137 +++
 10 files changed, 2121 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h

-- 
2.38.1

