Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694406FD3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjEJBxc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:53:22 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD231721;
        Tue,  9 May 2023 18:53:20 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 066CF24E199;
        Wed, 10 May 2023 09:53:14 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 10 May
 2023 09:53:13 +0800
Received: from ubuntu.localdomain (183.27.98.219) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 10 May
 2023 09:53:12 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 0/5] Add JH7110 AON PMU support
Date:   Tue, 9 May 2023 18:53:06 -0700
Message-ID: <20230510015311.27505-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
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

This patchset adds aon power domain driver for the StarFive JH7110 SoC.
It is used to turn on/off dphy rx/tx power switch. It also can use syscon
operation. The series has been tested on the VisionFive 2 board.

This patchset should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20230401111934.130844-1-hal.feng@starfivetech.com/

changes since v2:
- Updated commit message.
- Changed "starfive,jh7110-aon-pmu" to "starfive,jh7110-aon-syscon".
- Dropped patch 3: Modify ioremap to regmap.
- Changed "pmu_parse_dt" to "pmu_parse_irq".
- Dropped "pmu_parse_dt" function in aon pmu.
- Changed copyright to "2022-2023" in "starfive,jh7110-pmu.h".
- Replaced regread/regwrite operation with io_read/io_write operation.

v2: https://lore.kernel.org/all/20230419035646.43702-1-changhuang.liang@starfivetech.com/

changes since v1:
- Updated commit message.
- Changed "starfive,jh7110-pmu-dphy" to "starfive,jh7110-aon-pmu".
- Put if condition under allOf in .yaml file.
- Updated spelling error.
- Dropped patch 4: Add pmu type operation.
- Changed "jh71xx_pmu_general_set_state" to "jh7110_pmu_set_state" and moved it in call back.
- Changed "jh7110_pmu_general_parse_dt" to "jh7110_pmu_parse_dt" and moved it in call back.
- Used pmu_status save the pmu status offset.
- Changed "JH71XX_PMU_DPHY_SWITCH" to "JH71XX_AON_PMU_SWITCH"
- Changed copyright to "2022-2023"

v1: https://lore.kernel.org/all/20230411064743.273388-1-changhuang.liang@starfivetech.com/


Changhuang Liang (5):
  dt-bindings: power: Add JH7110 AON PMU support
  soc: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
  soc: starfive: Extract JH7110 pmu private operations
  soc: starfive: Add JH7110 AON PMU support
  riscv: dts: starfive: jh7110: Add AON PMU node

 .../bindings/power/starfive,jh7110-pmu.yaml   |  28 +++-
 MAINTAINERS                                   |   1 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   6 +
 drivers/soc/starfive/Kconfig                  |   4 +-
 drivers/soc/starfive/jh71xx_pmu.c             | 138 ++++++++++++++----
 .../dt-bindings/power/starfive,jh7110-pmu.h   |   5 +-
 6 files changed, 148 insertions(+), 34 deletions(-)


base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
--
2.25.1
