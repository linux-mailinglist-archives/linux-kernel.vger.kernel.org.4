Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7B66D3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjAQBzU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Jan 2023 20:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjAQBzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:55:06 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A9274B9;
        Mon, 16 Jan 2023 17:55:03 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id ED3CB24E00A;
        Tue, 17 Jan 2023 09:54:55 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 09:54:56 +0800
Received: from ubuntu.localdomain (202.190.108.220) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 09:54:49 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 0/3] hwrng: starfive: Add driver for TRNG module
Date:   Tue, 17 Jan 2023 09:54:42 +0800
Message-ID: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.190.108.220]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds kernel support for StarFive JH7110 hardware
random number generator. First 2 patches add binding docs and device
driver for this module. Patch 3 adds devicetree entry for VisionFive 2
SoC.

Patch 3 needs to be applied on top of:
https://patchwork.kernel.org/project/linux-riscv/patch/20221220011247.35560-7-hal.feng@starfivetech.com/

Patch 3 also depends on additional clock and reset patches for stg
domain that are yet to be submitted to mailing list.

Changes v4->v5:
- Updated status in MAINTAINERS. (Conor)
- Specified targeted device in Kconfig title and descriptions. (Conor)
- Removed unnecessary goto label in patch 2. (Conor)
- Enable runtime PM before registering hwrng in patch 2. (Conor)

Changes v3->v4:
- Moved init_completion before IRQ registration to be prepared for
  spurious interrupts. (Herbert)
- Added locks to guard concurrent write to the same register. (Herbert)

Changes v2->v3:
- Use constant usecs and convert to jiffies. (Herbert)
- Removed sleep in irq handler. (Herbert)
- Limited wait time to 40us if wait == 0 for trng read. (Herbert)

Changes v1->v2:
- Updated of_match_ptr and added pm_sleep_ptr. (Krzysztof)
- Dropped "status" in dts as module is always on. (Krzysztof)

Jia Jie Ho (3):
  dt-bindings: rng: Add StarFive TRNG module
  hwrng: starfive - Add TRNG driver for StarFive SoC
  riscv: dts: starfive: Add TRNG node for VisionFive 2

 .../bindings/rng/starfive,jh7110-trng.yaml    |  55 +++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  10 +
 drivers/char/hw_random/Kconfig                |  11 +
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/jh7110-trng.c          | 393 ++++++++++++++++++
 6 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
 create mode 100644 drivers/char/hw_random/jh7110-trng.c

-- 
2.25.1

