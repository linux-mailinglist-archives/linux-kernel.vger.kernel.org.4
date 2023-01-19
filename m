Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9D6734AF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjASJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjASJpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:45:07 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C469B06;
        Thu, 19 Jan 2023 01:45:02 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4267B24DBCE;
        Thu, 19 Jan 2023 17:44:59 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 17:44:59 +0800
Received: from localhost.localdomain (113.72.144.40) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 17:44:57 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] JH7110 PMU Support
Date:   Thu, 19 Jan 2023 17:44:45 +0800
Message-ID: <20230119094447.21939-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.40]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds PMU (Power Management Unit) controller driver for the
StarFive JH7110 SoC. In order to meet low power requirements, PMU is
designed for including multiple PM domains that can be used for power
gating of selected IP blocks for power saving by reduced leakage
current. The first patch adds device tree binding for PM domain provider
and consumer. The second patch adds pmu driver and support JH7110 SoC.

The series has been tested on the VisionFive 2 boards which equip with
JH7110 SoC and works normally.

Changes since v3:
- Rebased on Linux 6.2-rc4.
- Dropped the statement that 'is_on' is set in error case in
  jh71xx_pmu_get_state().
- Replaced dev_info() with dev_dbg() at the bottom of
  jh71xx_pmu_probe().
- Added '.suppress_bind_attrs = true,' for jh71xx_pmu_driver structure.
- Dropped patch 3, which is about device tree node of pmu for jh7110.
  Because it depends on the submission of others, it will be upstream
separately later.

  v3: https://lore.kernel.org/all/20230116074259.22874-1-walker.chen@starfivetech.com/

Changes since v2:
- Rebased on Linux 6.1.
- Renamed the dt-bindings 'starfive,jh71xx-power.yaml' to
  'starfive,jh7110-pmu.yaml' which is matching compatible.
- Fixed wrong indentation and error when running 'make dt_binding_check'
  in dt-bindings.
- Changed the license of the dt-bindings header to be same with
  dt-bindings.
- Changed a little bit on dependency conditions in Kconfig of driver.
- Dropped some macros that are temporarily useless.
- Simplified the definition of macro 'JH71XX_PMU_INT_ALL_MASK'.
- Changed the sorting of structure members, such as 'struct
  jh71xx_domain_info', 'struct jh71xx_pmu', etc.
- Modified detailed comment about controlling power domain.
- Dropped useless comment when running 'platform_get_irq'.

  v2: https://lore.kernel.org/all/20221208084523.9733-1-walker.chen@starfivetech.com/

Changes since v1:
- Squashed 1st patch (dt-bindings header) into 2nd which is related to
  dt-bindings stuff.
- Renamed the dt-bindings header 'jh7110-power.h' to
  'starfive,jh7110-pmu.h' and used dual license for it.
- Renamed the dt-bindings 'starfive,jh71xx-power.yaml' to
  'starfive,jh71xx-pmu.yaml', dropped items from properties.
- Change of MAINTAINERS: added the entry of 'starfive soc drivers';
  changed status to 'Supported' for the entry of
  'STARFIVE JH71XX PMU CONTROLLER DRIVER' and sorted the lines alphabetically.
- Dropped the header file 'include/soc/starfive/pm_domains.h'.
- Dropped starfive_pmu_hw_event_turn_on() and starfive_pmu_hw_event_turn_off().
- Added 'default SOC_STARFIVE' and expanded help text in the Kconfig.
- Added a JH71XX_PMU_ prefix to those macro definitions in driver.
- Replaced the data type 'uint8_t / uint32_t' with 'u8 / u32'.
- Fixed some complains by using checkpatch.pl
- Added spinlock to jh71xx_pmu_int_enable().
- Dropped spinlock from jh71xx_pmu_interrupt().
- Used jh71xx_pmu_ as prefix to all functions.
- Replaced io accessors '__raw_readl / __raw_writel' with 'readl / writel'.
- Added jh71xx_pmu_get_state() to the beginning of jh71xx_pmu_set_state().
- Added more detailed comment about controlling power domain.
- Simplified the usage of loop when performing pm_genpd_init() to register
  power domain.
- Added more detailed description about the features of power domain
  hardware to commit message in 2nd patch.
- Replaced dev_info() with dev_dbg() in jh71xx_pmu_set_state().
- Decreased the timeout numbers of polling power status when switching
  power mode.

  v1: https://lore.kernel.org/all/20221118133216.17037-1-walker.chen@starfivetech.com/

Best regards,
Walker

Walker Chen (2):
  dt-bindings: power: Add starfive,jh7110-pmu
  soc: starfive: Add StarFive JH71XX pmu driver

 .../bindings/power/starfive,jh7110-pmu.yaml   |  45 ++
 MAINTAINERS                                   |  14 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/starfive/Kconfig                  |  12 +
 drivers/soc/starfive/Makefile                 |   3 +
 drivers/soc/starfive/jh71xx_pmu.c             | 383 ++++++++++++++++++
 .../dt-bindings/power/starfive,jh7110-pmu.h   |  17 +
 8 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
 create mode 100644 drivers/soc/starfive/Kconfig
 create mode 100644 drivers/soc/starfive/Makefile
 create mode 100644 drivers/soc/starfive/jh71xx_pmu.c
 create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.17.1

