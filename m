Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9C6AFD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCHDlC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 22:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCHDkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:40:49 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD769943B2;
        Tue,  7 Mar 2023 19:40:44 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C372724E1C9;
        Wed,  8 Mar 2023 11:40:37 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 11:40:37 +0800
Received: from localhost.localdomain (183.27.97.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 11:40:36 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Add watchdog driver for StarFive JH7100/JH7110 RISC-V SoCs
Date:   Wed, 8 Mar 2023 11:40:33 +0800
Message-ID: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
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

This patch serises are to add watchdog driver for the StarFive
JH7100 and JH7110 RISC-V SoCs. The first patch adds docunmentation to
describe device tree bindings. The subsequent patch adds watchdog driver
and support JH7100/JH7110 SoCs. And the last patch adds watchdog node in
the JH7100 dts. And the addition of JH7110 device tree node will be
submitted after the JH7110 dts merge. This patchset is based on 6.3-rc1.

The watchdog driver has been tested on the VisionFive 1 and VisionFive 2
boards which equip with JH7100 and JH7110 SoCs respectively and both
works normally.

Changes since v3: 
- Modified the dt-binding, driver and dts to support JH7100 watchdog.
- Modified the register comments.
- Changed the return value and order when getting clock rate.
- Used dev_err_probe() when getting clocks and resets.
- Improved the codes of setting default timeout.
- Moved the watchdog_register_device() after setting WDOG_HW_RUNNING.
- Changed 'SOC_STARFIVE' to 'ARCH_STARFIVE' in Kconfig file.
- Dropped the struct of platform_device_id.
- Used new functions to enable or disable clock.

Changes since v2:
- Added watchdog.yaml and unevaluatedProperties in the dt-binding.
- Removed some unnecessary include files.
- Changed the 'module_param' name and dropped 'soft_noboot'.
- Rrmoved 'CONFIG_OF'.
- Added a check if clock rate is 0.
- Modified the max_timeout calculation formula.
- Removed restart function.
- Removed duplicate checks on the upper and lower bounds of 'count'.
- Removed 'started' variable.
- Added pm_runtime_get_sync() and pm_runtime_put_sync().
- Removed 'firmware_version = 0' variable.
- Drop the device tree node commit.

Changes since v1:
- Renamed the dt-binding 'starfive,wdt.yaml' to 'starfive,jh7110-wdt.yaml'.
- Dropped the '_clk' and 'rst_' about the 'clock-names' and 'reset-names'
  in the dt-binding.
- Updated the example context in the dt-binding 'starfive,jh7110-wdt.yaml'
  to be independent of other patchset.
- Deleted unused macros like 'JH7110_WDOG_INT_EN'.
- Changed the type of 'freq' in the struct from u64 to u32.
- Used 'devm_clk_get_enabled()' instead of 'devm_clk_get()' and
  'clk_prepare_enable()'.
- Removed the operation to get the frequency from the device tree.
- Added watchdog_stop_on_unregister() and watchdog_stop_on_reboot().
- Removed any operations about interrupt.

v3:
--- https://lore.kernel.org/all/20230220081926.267695-1-xingyu.wu@starfivetech.com/
v2:
--- https://lore.kernel.org/all/20221219094233.179153-1-xingyu.wu@starfivetech.com/
v1:
--- https://lore.kernel.org/all/20221202093943.149674-1-xingyu.wu@starfivetech.com/

Xingyu Wu (3):
  dt-bindings: watchdog: Add watchdog for StarFive JH7100 and JH7110
  drivers: watchdog: Add StarFive Watchdog driver
  riscv: dts: starfive: jh7100: Add watchdog node

 .../watchdog/starfive,jh7100-wdt.yaml         |  71 ++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  10 +
 drivers/watchdog/Kconfig                      |   9 +
 drivers/watchdog/Makefile                     |   2 +
 drivers/watchdog/starfive-wdt.c               | 675 ++++++++++++++++++
 6 files changed, 774 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
 create mode 100644 drivers/watchdog/starfive-wdt.c


base-commit: 8ca09d5fa3549d142c2080a72a4c70ce389163cd
prerequisite-patch-id: 558a5b43260d13a6f5229b139ccd45f737a4f686
-- 
2.25.1

