Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBCA650977
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiLSJnI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 04:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiLSJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:42:49 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BC95A5;
        Mon, 19 Dec 2022 01:42:43 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DBE7524DBD3;
        Mon, 19 Dec 2022 17:42:39 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 17:42:40 +0800
Received: from localhost.localdomain (183.27.97.120) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 17:42:38 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Add watchdog driver for StarFive JH7110 RISC-V SoC
Date:   Mon, 19 Dec 2022 17:42:30 +0800
Message-ID: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
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

This patch serises are to add watchdog driver for the StarFive JH7110
RISC-V SoC. The first patch adds docunmentation to describe device
tree bindings. The subsequent patch adds watchdog driver and support
JH7110 SoC. The last patch adds device node about watchdog to JH7110
dts.

The watchdog driver has been tested on the VisionFive 2 boards which
equip with JH7110 SoC and works normally.

The last patch should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/

Changes since v1:
- Renamed the dt-binding 'starfive,wdt.yaml' to 'starfive,jh7110-wdt.yaml'.
- Dropped the '_clk' and 'rst_' about the 'clock-names' and 'reset-names' in
  the dt-binding.
- Updated the example context in the dt-binding 'starfive,jh7110-wdt.yaml'
  to be independent of other patchset.
- Deleted unused macros like 'JH7110_WDOG_INT_EN'.
- Changed the type of 'freq' in the struct from u64 to u32.
- Used 'devm_clk_get_enabled()' instead of 'devm_clk_get()' and
  'clk_prepare_enable()'.
- Removed the operation to get the frequency from the device tree.
- Added watchdog_stop_on_unregister() and watchdog_stop_on_reboot().
- Removed any operations about interrupt.

v1: https://lore.kernel.org/all/20221202093943.149674-1-xingyu.wu@starfivetech.com/

Xingyu Wu (3):
  dt-bindings: watchdog: Add watchdog for StarFive JH7110
  drivers: watchdog: Add StarFive Watchdog driver
  riscv: dts: starfive: jh7110: Add watchdog node

 .../watchdog/starfive,jh7110-wdt.yaml         |  64 ++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  11 +
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   3 +
 drivers/watchdog/starfive-wdt.c               | 720 ++++++++++++++++++
 6 files changed, 816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,jh7110-wdt.yaml
 create mode 100644 drivers/watchdog/starfive-wdt.c


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
prerequisite-patch-id: 6b1b43a55b9773bec61ab6c1bbaa54dccbac0837
prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
prerequisite-patch-id: 29fe0b0c19b6f0cd31114ee9fe17fe9732047f33
prerequisite-patch-id: c59d9908de90e09ba2b9a81aadbf9fb9f00c8f04
prerequisite-patch-id: 94ac03d518993921bcfc9cc9f58d7da0c3528b51
prerequisite-patch-id: 694f7400375f5b85581fc1821e427334507826f2
prerequisite-patch-id: 699d49c4439dadb4b7cf900857f027d050cd6093
prerequisite-patch-id: 40d773f5a19912f731ee5fd4739ed2e3c2157b07
prerequisite-patch-id: 2bc3fd6df5dda116efe882045863d6c88aa81b3a
prerequisite-patch-id: 735e62255c75801bdc4c0b4107850bce821ff7f5
prerequisite-patch-id: b2a923b922e661fa6085185f33c1f1e733db9110
prerequisite-patch-id: b2bbc28354075432f059344eba5a127a653475cf
prerequisite-patch-id: 70eab7b7eee728afcd90e40f6743d1356f6d81ab
prerequisite-patch-id: 6276b2a23818c65ff2ad3d65b562615690cffee9
prerequisite-patch-id: d834ece14ffb525b8c3e661e78736692f33fca9b
prerequisite-patch-id: 4c17a3ce4dae9b788795d915bf775630f5c43c53
prerequisite-patch-id: dabb913fd478e97593e45c23fee4be9fd807f851
prerequisite-patch-id: 22fa141f7f0f80a5d619e9f3f4cf161ad06f108e
prerequisite-patch-id: f306819c257ea73aff8e06b17b5731053cdddfc8
prerequisite-patch-id: 536114f0732646095ef5302a165672b3290d4c75
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e09e995700a814a763aa304ad3881a7222acf556
prerequisite-patch-id: 05803238293fcc90c8e83018a1103c41133a816c
prerequisite-patch-id: d074c7ffa2917a9f754d5801e3f67bc980f9de4c
prerequisite-patch-id: ef23fdf3466b3c713b3826e8545c8dd2bc6cc9d7
prerequisite-patch-id: d5da3475c6a3588e11a1678feb565bdd459b548e
-- 
2.25.1

