Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295969C66E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBTITK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Feb 2023 03:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjBTITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:19:06 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE53FF24;
        Mon, 20 Feb 2023 00:19:02 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1832C24E2BC;
        Mon, 20 Feb 2023 16:19:01 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Feb
 2023 16:19:01 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Feb
 2023 16:18:59 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v3 0/2] Add watchdog driver for StarFive JH7110 RISC-V SoC
Date:   Mon, 20 Feb 2023 16:19:24 +0800
Message-ID: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
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

This patch serises are to add watchdog driver for the StarFive JH7110
RISC-V SoC. The first patch adds docunmentation to describe device
tree bindings. The subsequent patch adds watchdog driver and support
JH7110 SoC. And the addition of device tree node will be submitted
after the JH7110 dts merge. This patchset is based on 6.2.

The watchdog driver has been tested on the VisionFive 2 boards which
equip with JH7110 SoC and works normally.

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

v2: https://lore.kernel.org/all/20221219094233.179153-1-xingyu.wu@starfivetech.com/
v1: https://lore.kernel.org/all/20221202093943.149674-1-xingyu.wu@starfivetech.com/

Xingyu Wu (2):
  dt-bindings: watchdog: Add watchdog for StarFive JH7110
  drivers: watchdog: Add StarFive Watchdog driver

 .../watchdog/starfive,jh7110-wdt.yaml         |  74 ++
 MAINTAINERS                                   |   7 +
 drivers/watchdog/Kconfig                      |   9 +
 drivers/watchdog/Makefile                     |   2 +
 drivers/watchdog/starfive-wdt.c               | 651 ++++++++++++++++++
 5 files changed, 743 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,jh7110-wdt.yaml
 create mode 100644 drivers/watchdog/starfive-wdt.c


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.25.1

