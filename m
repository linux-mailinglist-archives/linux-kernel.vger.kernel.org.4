Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07C73DCED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFZLJf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjFZLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:09:20 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9686DB1;
        Mon, 26 Jun 2023 04:09:18 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 81E1024E199;
        Mon, 26 Jun 2023 19:09:11 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:11 +0800
Received: from ubuntu.localdomain (113.72.146.167) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:10 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/5] Add PWM-DAC audio support for StarFive JH7110 RISC-V SoC
Date:   Mon, 26 Jun 2023 19:09:04 +0800
Message-ID: <20230626110909.38718-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.167]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
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

This patchset adds PWM-DAC audio support for the StarFive JH7110 SoC.
The PWM-DAC module does not require a hardware codec, so add a dummy codec
driver for it.

The fourth patch depends on the patch [1].
The fifth patch depends on the patchset [2], patch [3].

[1] https://lore.kernel.org/all/20230526145402.450-3-walker.chen@starfivetech.com/
[2] https://lore.kernel.org/all/20230518101234.143748-1-xingyu.wu@starfivetech.com/
[3] https://lore.kernel.org/all/20230322094820.24738-5-walker.chen@starfivetech.com/

Hal Feng (5):
  ASoC: dt-bindings: Add StarFive JH7110 dummy PWM-DAC transmitter
  ASoC: codecs: Add StarFive JH7110 dummy PWM-DAC transmitter driver
  ASoC: dt-bindings: Add StarFive JH7110 PWM-DAC controller
  ASoC: starfive: Add JH7110 PWM-DAC driver
  riscv: dts: starfive: Add JH7110 PWM-DAC support

 .../sound/starfive,jh7110-pwmdac-dit.yaml     |  38 +
 .../sound/starfive,jh7110-pwmdac.yaml         |  76 ++
 MAINTAINERS                                   |   8 +
 .../jh7110-starfive-visionfive-2.dtsi         |  50 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  13 +
 sound/soc/codecs/Kconfig                      |   4 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/jh7110_pwmdac_transmitter.c  |  74 ++
 sound/soc/starfive/Kconfig                    |   9 +
 sound/soc/starfive/Makefile                   |   1 +
 sound/soc/starfive/jh7110_pwmdac.c            | 787 ++++++++++++++++++
 11 files changed, 1062 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
 create mode 100644 sound/soc/codecs/jh7110_pwmdac_transmitter.c
 create mode 100644 sound/soc/starfive/jh7110_pwmdac.c


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
prerequisite-patch-id: 8c735dffc6d5388a35a76b16e914a2f9722ad979
prerequisite-patch-id: ffa1f5831e75722c9f41603f009f762c9fd525e2
prerequisite-patch-id: 36e69700dfc0375b950b0e23086ed3b722cb84a4
prerequisite-patch-id: 0b49b996d7a404ea548e1734c12933ec749e92b9
prerequisite-patch-id: 81f7c65712c4901a7a178ddcd98ffc55f3b473ff
prerequisite-patch-id: f342fbf594014b072378528bea94c01fb2186e1a
prerequisite-patch-id: 39e1be2a3d1593577ab997f55f59367cba665aa7
prerequisite-patch-id: 0159f09bb0a1ff711a00ae17ef5b12662c9c7d3d
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: d5abfba63fc07ff97b5023911513c260bb7a53e1
prerequisite-patch-id: b37ac15032973e1fcd918f157c82a0606775c9e9
prerequisite-patch-id: 6abf359fa445f4104432ddee27044dfbfb128417
prerequisite-patch-id: 2f7aca99e714a4c590a91baa015080ac0902814d
prerequisite-patch-id: 32cabbc4e7a97ec14d5c28a477fa483784f86709
prerequisite-patch-id: d449b1957dd77c2537c38585daa75974c94c529a
-- 
2.38.1

